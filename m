From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/2] dt-bindings: at24: new optional property - wp-gpios
Date: Wed, 20 Dec 2017 09:26:32 +0100
Message-ID: <20171220082633.32237-2-brgl@bgdev.pl>
References: <20171220082633.32237-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35934 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754560AbdLTI0k (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 20 Dec 2017 03:26:40 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so8135122wmg.1
        for <linux-i2c@vger.kernel.org>; Wed, 20 Dec 2017 00:26:39 -0800 (PST)
In-Reply-To: <20171220082633.32237-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

AT24 EEPROMs have a write-protect pin, which - when pulled high -
inhibits writes to the upper quadrant of memory (although it has been
observed that on some chips it disables writing to the entire memory
range).

On some boards, this pin is connected to a GPIO and pulled high by
default, which forces the user to manually change its state before
writing. On linux this means that we either need to hog the line all
the time, or set the GPIO value before writing from outside of the
at24 driver.

Add a new optional property to the device tree binding document, which
allows to specify the GPIO line to which the write-protect pin is
connected.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index a0415b8471bb..cbc80e194ac6 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -43,10 +43,13 @@ Optional properties:
 			eeprom does not automatically roll over reads to the next
 			slave address. Please consult the manual of your device.
 
+  - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
+
 Example:
 
 eeprom@52 {
 	compatible = "atmel,24c32";
 	reg = <0x52>;
 	pagesize = <32>;
+	wp-gpios = <&gpio1 3 0>;
 };
-- 
2.15.1
