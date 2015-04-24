From: Feng Kan <fkan@apm.com>
Subject: [PATCH RESEND V4 4/4] arm64: dts: add proxy I2C device driver on APM X-Gene platform
Date: Fri, 24 Apr 2015 15:17:53 -0700
Message-ID: <1429913873-13627-5-git-send-email-fkan@apm.com>
References: <1429913873-13627-1-git-send-email-fkan@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429913873-13627-1-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patches@apm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>, Hieu Le <hnle@apm.com>
List-Id: linux-i2c@vger.kernel.org

Add proxy I2C device driver on APM X-Gene platform.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Hieu Le <hnle@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 70c14fa..00ae4d8 100644
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
