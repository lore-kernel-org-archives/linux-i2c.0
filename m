From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] Documentation: Device Tree binding information for i2c-nomadik
 driver
Date: Wed, 13 Jun 2012 17:08:24 +0100
Message-ID: <4FD8BAF8.10806@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org> <1339428307-3850-10-git-send-email-lee.jones@linaro.org> <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date: Wed, 13 Jun 2012 17:00:02 +0100
Subject: [PATCH 3/3] Documentation: Device Tree binding information for
 i2c-nomadik driver

This document describes each of the non-standard Device Tree bindings
used in the Nomadik I2C driver.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/nomadik.txt |   33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nomadik.txt

diff --git a/Documentation/devicetree/bindings/i2c/nomadik.txt b/Documentation/devicetree/bindings/i2c/nomadik.txt
new file mode 100644
index 0000000..18cea18
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/nomadik.txt
@@ -0,0 +1,33 @@
+I2C for Nomadik based systems
+
+Required (non-standard) properties:
+ - Nil
+
+Recommended (non-standard) properties:
+ - clock-frequency : Maximum bus clock frequency for the device
+ - stericsson,slsu : Data line delay
+ - stericsson,tft : Tx FIFO threshold
+ - stericsson,rft : Rx FIFO threshold
+ - stericsson,timeout : Slave response timeout(ms)
+ - stericsson,i2c_freq_mode_fast : I2C fast mode (omit for standard mode)
+
+Optional (non-standard) properties:
+ - Nil
+
+Example :
+
+i2c@80004000 {
+        compatible = "stericsson,db8500-i2c", "st,nomadik-i2c";
+        reg = <0x80004000 0x1000>;
+        interrupts = <0 21 0x4>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        v-i2c-supply = <&db8500_vape_reg>;
+
+        clock-frequency = <100000>;
+        stericsson,slsu = <0xe>;
+        stericsson,tft = <1>;
+        stericsson,rft = <8>;
+        stericsson,timeout = <200>;
+        stericsson,i2c_freq_mode_fast;
+};
-- 
1.7.9.5
