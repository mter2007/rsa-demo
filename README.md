# rsa-demo-payments

Demo repository for the Regression Scope Agent end-to-end test.

## Module dependency chain

```
payments.processor
    └── payments.gateway
            ├── payments.models
            └── payments.utils.retry
```

Changing `utils/retry.py` ripples upward through `gateway.py` to `processor.py`,
giving the RSA dependency traversal two hops of impact to discover.

## Making a test PR

Edit `src/payments/utils/retry.py` — for example, change `MAX_RETRIES` or
add a parameter to `retry_with_backoff` — then open a PR against `main`.
The RSA webhook will fire and post a Check Run with recommended tests within
a few minutes.
