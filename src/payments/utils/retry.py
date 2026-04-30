import time

MAX_RETRIES = 3


def retry_with_backoff(fn, delay: float = 1.0):
    last_exc = None
    for attempt in range(MAX_RETRIES):
        try:
            return fn()
        except Exception as exc:
            last_exc = exc
            if attempt < MAX_RETRIES - 1:
                time.sleep(delay * (2 ** attempt))
    raise last_exc


def is_retryable(exc: Exception) -> bool:
    retryable = (TimeoutError, ConnectionError)
    return isinstance(exc, retryable)
