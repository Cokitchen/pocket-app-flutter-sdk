class PocketOption {
  final String key;
  final String? mode;
  final String? transactionReference;
  final String? reference;
  final String? gatewayReference;
  final String? narration;
  final Map<String, String>? meta;
  final int? amount;
  final Function(String data)? onSuccess;
  final Function(String message)? onError;
  final Function(String message)? onClose;
  final Function(String message)? onPending;
  final Function(String message)? onOpen;

  const PocketOption({
    required this.key,
    this.mode,
    this.transactionReference,
    this.reference,
    this.gatewayReference,
    this.narration,
    this.meta,
    this.amount,
    this.onSuccess,
    this.onError,
    this.onClose,
    this.onPending,
    this.onOpen,
  });

  @override
  String toString() {
    return 'PocketOption(key: $key, mode: $mode, transactionReference: $transactionReference, reference: $reference, gatewayReference: $gatewayReference, narration: $narration, meta: $meta, amount: $amount, onSuccess: $onSuccess, onError: $onError, onClose: $onClose, onPending: $onPending, onOpen: $onOpen)';
  }
}
