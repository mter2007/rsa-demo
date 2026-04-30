from dataclasses import dataclass, field


@dataclass
class Transaction:
    amount: float
    currency: str
    idempotency_key: str


@dataclass
class ChargeResult:
    success: bool
    transaction_id: str
    error: str = ""


@dataclass
class RefundResult:
    success: bool
    refund_id: str
    original_transaction_id: str
    error: str = ""
