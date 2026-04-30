from payments.models import ChargeResult, RefundResult, Transaction
from payments.utils.retry import retry_with_backoff


class PaymentGateway:
    def __init__(self, api_key: str) -> None:
        self._api_key = api_key

    def charge(self, txn: Transaction) -> ChargeResult:
        def _do_charge():
            return ChargeResult(
                success=True,
                transaction_id=f"txn_{txn.idempotency_key}",
            )
        return retry_with_backoff(_do_charge)

    def refund(self, transaction_id: str, amount: float) -> RefundResult:
        def _do_refund():
            return RefundResult(
                success=True,
                refund_id=f"ref_{transaction_id}",
                original_transaction_id=transaction_id,
            )
        return retry_with_backoff(_do_refund)

    def ping(self) -> bool:
        return True
