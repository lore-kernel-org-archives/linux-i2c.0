From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: [PATCH v2 4/4] arm: dts: ls1021a: Enable I2C DMA support
Date: Mon,  9 Jul 2018 11:43:04 +0200
Message-ID: <20180709094304.8814-5-esben.haabendal@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709094304.8814-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Esben Haabendal <eha@deif.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Gives substantial performance improvement for transfers larger than 16
bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c55d479971cc..1e5640701c65 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -363,6 +363,8 @@
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 39>, <&edma0 1 38>;
 			status = "disabled";
 		};
 
@@ -374,6 +376,8 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 37>, <&edma0 1 36>;
 			status = "disabled";
 		};
 
@@ -385,6 +389,8 @@
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "i2c";
 			clocks = <&clockgen 4 1>;
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 35>, <&edma0 1 34>;
 			status = "disabled";
 		};
 
-- 
2.18.0
