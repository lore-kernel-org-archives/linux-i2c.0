From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH-V2 12/12] Documentation: binding: add sclk adjustment properties to i2c-pxa
Date: Mon, 15 Jun 2015 21:19:59 +0530
Message-ID: <1434383399-2370-13-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434383399-2370-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

With addition of PXA910 family of devices, the TWSI module supports
new feature which allows us to adjust SCLK.
With DT properties i2c-pxa driver takes input configuration
in nsec and converts it to respective bit-fields,

 - i2c-sclk-low-time-ns : SCLK low time (tlow)
   This property is used along with mode selection.
 - i2c-sclk-high-time-ns : SCLK high time (thigh)

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
index 9657db5..0fafd91 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
@@ -23,12 +23,25 @@ Optional properties :
  - i2c-disable-after-xfer : If set, driver will disable I2C module
    after msg xfer and enable it again before xfer.
 
+   (Applicable to PXA910 family):
+
+ - i2c-sclk-low-time-ns : SCLK low time (tlow), for standard/fast/high
+   speed mode.
+   This property is used along with mode selection. Driver uses this property
+   to set low/high time for standard and fast speed mode, as counter bit-field
+   is same for both.
+ - i2c-sclk-high-time-ns : SCLK high time (thigh), Used in case of high speed
+   mode.
+
 Examples:
 	twsi1: i2c@d4011000 {
 		compatible = "mrvl,mmp-twsi";
 		reg = <0xd4011000 0x1000>;
 		interrupts = <7>;
 		mrvl,i2c-fast-mode;
+
+		i2c-sclk-low-time-ns = <988>;
+		i2c-sclk-high-time-ns = <988>;
 	};
 	
 	twsi2: i2c@d4025000 {
-- 
1.9.1
