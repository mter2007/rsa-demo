import time

  MAX_RETRIES = 3

  def retry_with_backoff(fn, delay: float =1.0):
      for attempt in range(MAX_RETRIES):
          try:
              return fn()
          except Exception:
              if attempt == MAX_RETRIES - 1:
                  raise
              time.sleep(delay * (2 **attempt))
