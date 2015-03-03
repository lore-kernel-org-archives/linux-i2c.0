From: Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c: imx: add required clocks property to binding
Date: Tue,  3 Mar 2015 11:57:08 -0500
Message-ID: <1425401828-31063-1-git-send-email-mporter@konsulko.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

A clock specifier is required for i.MX I2C and is
provided in all DTS implementations. Add this to the
list of required properties in the binding.

Signed-off-by: Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
index 52d37fd..ce4311d 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -7,6 +7,7 @@ Required properties:
   - "fsl,vf610-i2c" for I2C compatible with the one integrated on Vybrid vf610 SoC
 - reg : Should contain I2C/HS-I2C registers location and length
 - interrupts : Should contain I2C/HS-I2C interrupt
+- clocks : Should contain the I2C/HS-I2C clock specifier
 
 Optional properties:
 - clock-frequency : Constains desired I2C/HS-I2C bus clock frequency in Hz.
-- 
1.8.4
