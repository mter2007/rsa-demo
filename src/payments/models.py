from dataclasses import dataclass

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
