from payments.gateway import PaymentGateway
from payments.models import ChargeResult, RefundResult, Transaction


class PaymentProcessor:
    def __init__(self, gateway: PaymentGateway) -> None:
        self._gateway = gateway

    def process(self, txn: Transaction) -> ChargeResult:
        if txn.amount <= 0:
            raise ValueError(f"Amount must be positive, got {txn.amount}")
        if not txn.currency:
            raise ValueError("Currency must be specified")
        return self._gateway.charge(txn)

    def refund(self, transaction_id: str, amount: float) -> RefundResult:
        if amount <= 0:
            raise ValueError("Refund amount must be positive")
        return self._gateway.refund(transaction_id, amount)
