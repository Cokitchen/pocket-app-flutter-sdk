import 'dart:convert';

import 'package:pocket_app_flutter_sdk/model/pocket_option.dart';

String buildPocketWithOptions({required PocketOption pocketOptions}) => """
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
          key: "${pocketOptions.key}",
          mode: "${pocketOptions.mode}",
          view:"${pocketOptions.view.text}",
          transaction_reference: "gate-ov-ref" + new Date().getTime(),
          reference: "ref" + new Date().getTime(),
          gateway_reference: "ov-ref" + new Date().getTime(),
          narration: "${pocketOptions.narration}",
          meta: ${jsonEncode(pocketOptions.meta)},
          amount: ${pocketOptions.amount},
          onSuccess(data) {
            let response = {event:'eventSuccess', data}
            window.FlutterOnSuccess.postMessage(JSON.stringify(response)) 
            console.log(JSON.stringify(data, null, 2));
          },
          onOpen() {
            console.log("init");
            let response = {event:'eventOpen'}
            window.FlutterOnOpen.postMessage(JSON.stringify(response))
          },
          onPending() {
            let response = {event:'eventPending'}
            window.FlutterOnPending.postMessage(JSON.stringify(response))
            console.log("pending");
          },
          onClose() {
            let response = {event:'eventClose'}
            window.FlutterOnClose.postMessage(JSON.stringify(response))
            console.log("close");
          },
          onError(err) {
            let response = {event:'eventError', err}
            window.FlutterOnError.postMessage(JSON.stringify(response))
            console.log(err);
          },
        });
        pockett.show();
      }
    </script>
  </body>
</html>

""";
