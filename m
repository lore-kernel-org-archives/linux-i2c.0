From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH-V2 09/12] Documentation: binding: add new property 'disable_after_xfer' to i2c-pxa
Date: Mon, 15 Jun 2015 21:19:56 +0530
Message-ID: <1434383399-2370-10-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434383399-2370-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Driver now supports enable/disable across msg xfer, which user
can control it by new DT property -

i2c-disable-after-xfer : If set, driver will disable I2C module after msg
 xfer and enable it back before xfer.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
index 12b78ac..9657db5 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
@@ -18,6 +18,11 @@ Recommended properties :
    status register of i2c controller instead.
  - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
 
+Optional properties :
+
+ - i2c-disable-after-xfer : If set, driver will disable I2C module
+   after msg xfer and enable it again before xfer.
+
 Examples:
 	twsi1: i2c@d4011000 {
 		compatible = "mrvl,mmp-twsi";
-- 
1.9.1
