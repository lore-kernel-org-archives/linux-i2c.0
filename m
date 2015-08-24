From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v5 RESEND 1/5] Documentation: binding: add new property 'disable_after_xfer' to i2c-pxa
Date: Mon, 24 Aug 2015 11:29:34 +0530
Message-ID: <1440395978-9065-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, robert.jarzmik@free.fr, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Driver will now supports enable/disable across msg xfer, which user
can control it by new DT property -

i2c-disable-after-xfer : If set, driver will disable I2C module after msg
 xfer and enable it back before xfer.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
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
