From: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH V2 3/3] arm64: dts: add proxy I2C device driver on APM X-Gene platform
Date: Wed, 18 Feb 2015 11:34:03 -0800
Message-ID: <1424288043-2995-3-git-send-email-fkan@apm.com>
References: <1424288043-2995-1-git-send-email-fkan@apm.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424288043-2995-1-git-send-email-fkan-qTEPVZfXA3Y@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: patches-qTEPVZfXA3Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add proxy I2C device driver on APM X-Gene platform.

Signed-off-by: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Signed-off-by: Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 27d6c3d..f19bb6b 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -483,6 +483,11 @@
 					<0x0 0x7 0x4>;
 		};
 
+		i2cslimpro {
+			compatible = "apm,xgene-slimpro-i2c";
+			mboxes = <&mailbox 0>;
+		};
+
 		serial0: serial@1c020000 {
 			status = "disabled";
 			device_type = "serial";
-- 
1.9.1
