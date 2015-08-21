From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] dts: keystone: Change "ti,davinci-i2c" compatible to
 "ti,keystone-i2c"
Date: Fri, 21 Aug 2015 11:47:06 +0200
Message-ID: <55D6F39A.2030402@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Now as "i2c-davinci" driver has special handling for Keystone it's time to switch
the device tree to use new "compatible" property.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/keystone.dtsi |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 72816d6..a846597 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -106,7 +106,7 @@
 		};
 
 		i2c0: i2c@2530000 {
-			compatible = "ti,davinci-i2c";
+			compatible = "ti,keystone-i2c";
 			reg = <0x02530000 0x400>;
 			clock-frequency = <100000>;
 			clocks = <&clki2c>;
@@ -116,7 +116,7 @@
 		};
 
 		i2c1: i2c@2530400 {
-			compatible = "ti,davinci-i2c";
+			compatible = "ti,keystone-i2c";
 			reg = <0x02530400 0x400>;
 			clock-frequency = <100000>;
 			clocks = <&clki2c>;
@@ -126,7 +126,7 @@
 		};
 
 		i2c2: i2c@2530800 {
-			compatible = "ti,davinci-i2c";
+			compatible = "ti,keystone-i2c";
 			reg = <0x02530800 0x400>;
 			clock-frequency = <100000>;
 			clocks = <&clki2c>;
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
