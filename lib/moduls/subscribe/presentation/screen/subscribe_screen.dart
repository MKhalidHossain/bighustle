import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../../../core/constants/stripe_config.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';
import '../../../../core/services/app_pigeon/app_pigeon.dart';
import '../../implement/plan_interface_impl.dart';
import '../../interface/plan_interface.dart';
import '../../model/plan_model.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({super.key});

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen> {
  static const Color _background = Color(0xFFEAF1FF);
  static const Color _borderBlue = Color(0xFF1F3D7A);
  static const Color _titleBlue = Color(0xFF2B4C8A);
  static const Color _accentOrange = Color(0xFFF5A524);

  late final SnackbarNotifier _snackbarNotifier;
  late final PlanInterface _planInterface;

  bool _initialized = false;
  bool _isLoadingPlans = false;
  bool _isSubmitting = false;

  List<PlanModel> _plans = [];
  PlanModel? _currentPlan;
  PlanModel? _selectedPlan;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _snackbarNotifier = SnackbarNotifier(context: context);
      if (!Get.isRegistered<PlanInterface>()) {
        Get.put<PlanInterface>(
          PlanInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
        );
      }
      _planInterface = Get.find<PlanInterface>();
      _loadPlans();
    }
  }

  Future<void> _loadPlans() async {
    setState(() => _isLoadingPlans = true);
    final result = await _planInterface.getPlans();
    if (!mounted) return;

    result.fold(
      (failure) {
        _snackbarNotifier.notifyError(
          message: failure.uiMessage.isNotEmpty
              ? failure.uiMessage
              : 'Failed to load plans',
        );
        setState(() {
          _plans = [];
          _currentPlan = null;
          _selectedPlan = null;
          _isLoadingPlans = false;
        });
      },
      (success) {
        final plans = success.data ?? <PlanModel>[];
        PlanModel? current;
        for (final plan in plans) {
          if (plan.price == 0) {
            current = plan;
            break;
          }
        }
        current ??= plans.isNotEmpty ? plans.first : null;

        PlanModel? selected;
        if (plans.isNotEmpty) {
          selected = plans.firstWhere(
            (plan) => plan.id != current?.id && plan.price > 0,
            orElse: () => current ?? plans.first,
          );
        }

        setState(() {
          _plans = plans;
          _currentPlan = current;
          _selectedPlan = selected;
          _isLoadingPlans = false;
        });
      },
    );
  }

  String _currencySymbol(String currency) {
    final normalized = currency.toUpperCase();
    if (normalized == 'USD') return '\$';
    return '$normalized ';
  }

  String _intervalLabel(String interval, double price) {
    if (price == 0) return 'forever';
    final value = interval.toLowerCase();
    if (value.startsWith('year')) return 'year';
    if (value.startsWith('month')) return 'month';
    return value;
  }

  bool _isPopularPlan(PlanModel plan) {
    final name = plan.name.toLowerCase();
    if (name.contains('pro')) return true;
    final maxPrice = _plans.isNotEmpty
        ? _plans.map((item) => item.price).reduce((a, b) => a > b ? a : b)
        : plan.price;
    return plan.price == maxPrice && plan.price > 0;
  }

  void _selectPlan(PlanModel plan) {
    if (plan.id == _currentPlan?.id) return;
    setState(() {
      _selectedPlan = plan;
    });
  }

  Future<void> _submitSubscription() async {
    if (_selectedPlan == null) {
      _snackbarNotifier.notifyError(message: 'Please select a plan.');
      return;
    }

    if (_selectedPlan?.id == _currentPlan?.id) {
      _snackbarNotifier.notify(message: 'You are already on this plan.');
      return;
    }

    if (StripeConfig.publishableKey.contains('replace_with_your_key')) {
      _snackbarNotifier.notifyError(
        message: 'Stripe publishable key is not set.',
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final createResult = await _planInterface.createPlanPayment(
      planId: _selectedPlan!.id,
      provider: 'stripe',
    );

    if (!mounted) return;

    final paymentData = createResult.fold((failure) {
      _snackbarNotifier.notifyError(
        message: failure.uiMessage.isNotEmpty
            ? failure.uiMessage
            : 'Failed to create payment',
      );
      return null;
    }, (success) => success.data);

    if (paymentData == null || paymentData.clientSecret == null) {
      setState(() => _isSubmitting = false);
      _snackbarNotifier.notifyError(
        message: 'Stripe client secret missing from backend response.',
      );
      return;
    }

    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentData.clientSecret!,
          merchantDisplayName: StripeConfig.merchantName,
          style: ThemeMode.light,
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      final confirmResult = await _planInterface.confirmPlanPayment(
        paymentId: paymentData.paymentId,
        providerPaymentId: paymentData.providerPaymentId,
      );

      if (!mounted) return;

      confirmResult.fold(
        (failure) {
          _snackbarNotifier.notifyError(
            message: failure.uiMessage.isNotEmpty
                ? failure.uiMessage
                : 'Payment confirmation failed',
          );
        },
        (success) {
          _snackbarNotifier.notifySuccess(message: success.message);
          setState(() {
            _currentPlan = _selectedPlan;
          });
          _showSuccessDialog();
        },
      );
    } on StripeException catch (e) {
      _snackbarNotifier.notifyError(
        message: e.error.message ?? 'Stripe payment cancelled',
      );
    } catch (_) {
      _snackbarNotifier.notifyError(message: 'Stripe payment failed');
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }

  void _showSuccessDialog() {
    if (_selectedPlan == null) return;
    final plan = _selectedPlan!;
    final priceText =
        '${_currencySymbol(plan.currency)}${plan.price.toStringAsFixed(2)}';
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Subscription Active'),
          content: Text('You are now subscribed to ${plan.name} ($priceText).'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, color: _borderBlue, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required PlanModel plan,
    required bool isCurrent,
    required bool isSelected,
  }) {
    final isFree = plan.price == 0;
    final priceText = isFree
        ? 'Free'
        : '${_currencySymbol(plan.currency)}${plan.price.toStringAsFixed(2)}';
    final interval = _intervalLabel(plan.interval, plan.price);
    final features = plan.features.isNotEmpty
        ? plan.features
        : <String>[
            'Upgrade anytime for full access',
            'Access to selected API exams',
            'Full-length mock exams',
            'Timed & full simulation modes',
          ];

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _borderBlue, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A000000),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: _borderBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            plan.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (_isPopularPlan(plan) && !isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _accentOrange,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              'Popular',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (isCurrent)
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCFEBD1),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            color: Color(0xFF2D6A35),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                priceText,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '/$interval',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 24),
          Text(
            isCurrent
                ? "What's Included in Your Plan"
                : "What's included in your plan",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          for (final feature in features.take(6)) _buildFeatureRow(feature),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: isCurrent
                ? OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black38,
                      side: const BorderSide(color: Color(0xFFD7D7D7)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Your Current Plan'),
                  )
                : (isSelected
                      ? ElevatedButton(
                          onPressed: _isSubmitting ? null : _submitSubscription,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _borderBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text('Subscribe - $priceText'),
                        )
                      : OutlinedButton(
                          onPressed: () => _selectPlan(plan),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _borderBlue,
                            side: const BorderSide(color: _borderBlue),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Select Plan'),
                        )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPlans = _plans.isNotEmpty;
    final plansToShow = hasPlans
        ? _plans.where((plan) => plan.id != _currentPlan?.id).toList()
        : <PlanModel>[];

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: _titleBlue),
        title: const Text(
          'Subscribe',
          style: TextStyle(color: _titleBlue, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadPlans,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            children: [
              if (_isLoadingPlans)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (!hasPlans)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'No plans available right now.',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: _loadPlans,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else ...[
                if (_currentPlan != null)
                  _buildPlanCard(
                    plan: _currentPlan!,
                    isCurrent: true,
                    isSelected: false,
                  ),
                for (final plan in plansToShow)
                  GestureDetector(
                    onTap: () => _selectPlan(plan),
                    child: _buildPlanCard(
                      plan: plan,
                      isCurrent: false,
                      isSelected: plan.id == _selectedPlan?.id,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
