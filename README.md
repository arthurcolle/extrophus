# trophus.ex

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

Notes to future cryptkeepers ->


```
export INSTAGRAM_CLIENT_ID=25743d898a7147169d5abc4fff911839
export INSTAGRAM_CLIENT_SECRET=e7bd719b44824a19b5be0da1709cb86b
export INSTAGRAM_CALLBACK_URL="https://www.trophus.com/auth/callback"
```


for development...
```
export INSTAGRAM_CLIENT_ID=f18ce1ecca4345f188d668612827cb0e
export INSTAGRAM_CLIENT_SECRET=64078c88758348a0a282a2332552ea6a
export INSTAGRAM_CALLBACK_URL="http://127.0.0.1:4000/auth/callback"
```

these next 4 keys are for stripe, live mode and test mode
```
export TEST_SECRET_KEY=sk_test_aqQo51A1cGQEk09BCaCGmkYZ
export TEST_PUBLISHABLE_KEY=pk_test_k90DPHCGKmfYhYa5anVRrVKy
export LIVE_SECRET_KEY=sk_live_0qBm4bSeORZikHqoLFwRzRC3
export LIVE_PUBLISHABLE_KEY=pk_live_Q43jYi6k0EatjdmDkVYivYQY
export APP_URL=http://127.0.0.1:3000

# deprecated, leave for posterity
# export INSTAGRAM_CLIENT=da3c354840064d44b6c81561424101b4
# export INSTAGRAM_SECRET=0eda5e2fd52d454e987bd38441b56c6b

export AWS_BUCKET_NAME=trophus-dishes
```
