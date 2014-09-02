From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 3/3] WIP: adapt dts for i2c slave use
Date: Tue,  2 Sep 2014 20:02:41 +0200
Message-ID: <1409680961-12632-4-git-send-email-wsa@the-dreams.de>
References: <1409680961-12632-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409680961-12632-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

not for upstream yet.

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0118cbfd1cb3..93ff6ce357bb 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -205,9 +205,9 @@
 		renesas,function = "msiof1";
 	};
 
-	iic1_pins: iic1 {
-		renesas,groups = "iic1";
-		renesas,function = "iic1";
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
 	};
 
 	iic2_pins: iic2 {
@@ -365,10 +365,15 @@
 	status = "ok";
 };
 
-&iic1	{
+&i2c1	{
 	status = "ok";
-	pinctrl-0 = <&iic1_pins>;
+	pinctrl-0 = <&i2c1_pins>;
 	pinctrl-names = "default";
+
+	eeprom@64 {
+		compatible = "i2c-slave-eeprom";
+		reg = <0x64>;
+	};
 };
 
 &iic2	{
-- 
2.0.0
