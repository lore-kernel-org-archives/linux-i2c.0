From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/5] dt-bindings: at24: add a missing compatible
Date: Thu, 21 Dec 2017 14:48:39 +0100
Message-ID: <20171221134842.31287-3-brgl@bgdev.pl>
References: <20171221134842.31287-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44196 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdLUNsx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:48:53 -0500
Received: by mail-wr0-f194.google.com with SMTP id l41so13027311wre.11
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:48:53 -0800 (PST)
In-Reply-To: <20171221134842.31287-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

"atmel,spd" is reported by checkpatch as undocumented in the device
tree bindings. Add it to the list of supported compatible strings.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 16b687458b14..2702f2456971 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -7,6 +7,7 @@ Required properties:
         "atmel,24c00",
         "atmel,24c01",
         "atmel,24c02",
+        "atmel,spd",
         "atmel,24c04",
         "atmel,24c08",
         "atmel,24c16",
-- 
2.15.1
