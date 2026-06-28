import random
import time

MAX_RETRIES = 5
MAX_DELAY = 30.0


def retry_with_backoff(fn, delay: float = 1.0, max_delay: float = MAX_DELAY, jitter: bool = True):
    last_exc = None
    for attempt in range(MAX_RETRIES):
        try:
            return fn()
        except Exception as exc:
            last_exc = exc
            if attempt < MAX_RETRIES - 1:
                sleep_time = min(delay * (2 ** attempt), max_delay)
                if jitter:
                    sleep_time *= (0.5 + random.random() * 0.5)
                time.sleep(sleep_time)
    raise last_exc


def is_retryable(exc: Exception) -> bool:
    retryable = (TimeoutError, ConnectionError)
    return isinstance(exc, retryable)
