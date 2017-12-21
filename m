From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 4/5] dt-bindings: at24: extend the list of supported chips
Date: Thu, 21 Dec 2017 14:08:29 +0100
Message-ID: <20171221130830.16813-5-brgl@bgdev.pl>
References: <20171221130830.16813-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34914 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755166AbdLUNIp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:08:45 -0500
Received: by mail-wr0-f193.google.com with SMTP id l19so12754611wrc.2
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:08:45 -0800 (PST)
In-Reply-To: <20171221130830.16813-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Add other variants of at24 EEPROMs we support in the driver to the
list of allowed compatible strings.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 8a6b960ddeee..8d3db75cd45d 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -6,13 +6,22 @@ Required properties:
 
         "atmel,24c00",
         "atmel,24c01",
+        "atmel,24cs01",
         "atmel,24c02",
+        "atmel,24cs02",
+        "atmel,24mac402",
+        "atmel,24mac602",
         "atmel,spd",
         "atmel,24c04",
+        "atmel,24cs04",
         "atmel,24c08",
+        "atmel,24cs08",
         "atmel,24c16",
+        "atmel,24cs16",
         "atmel,24c32",
+        "atmel,24cs32",
         "atmel,24c64",
+        "atmel,24cs64",
         "atmel,24c128",
         "atmel,24c256",
         "atmel,24c512",
-- 
2.15.1
