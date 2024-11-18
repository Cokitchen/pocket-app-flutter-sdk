String buildPocketWithOptions({Map<String, dynamic>? pocketOptions}) => """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/logo.svg" />
    <!-- <link rel="stylesheet" href="/dist/style.css"> -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pay with Pocket SDK</title>
  </head>
  <body onload="paynow()">
    <!-- <div id="app">
      <button onclick="paynow()">Pay with pocket now</button>
    </div> -->

    <script src="https://pocket-checkout-sdk.netlify.app/checkout-sdk.js"></script>
    <script>
      function paynow() {
        const pockett = new Pocket({
          key: "TPM_TEST_7bQG1GAUbc7PSzZ8oPYY45Gm17tlhYmxUVi",
          mode: "test",
          transaction_reference: "gate-ov-ref" + new Date().getTime(),
          reference: "ref" + new Date().getTime(),
          gateway_reference: "ov-ref" + new Date().getTime(),
          narration: "Testing pay with pocket",
          meta: {
            transaction_id: "1234567890",
            timestamp: "2023-05-24T14:30:00Z",
            amount: 250.0,
            currency: "NGN",
            sender_account: "123456789",
            recipient_account: "987654321",
            transaction_type: "Transfer",
            description: "Payment for services",
            status: "Completed",
          },
          amount: 10000,
          onSuccess(data) {
            console.log(JSON.stringify(data, null, 2));
          },
          onOpen() {
            console.log("init");
          },
          onPending() {
            console.log("pending");
          },
          onClose() {
            console.log("close");
          },
          onError(err) {
            console.log(err);
          },
        });
        pockett.show();
      }
    </script>
  </body>
</html>

""";
