From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 8/8] arm64: dts: Stingray: Add NIC i2c device node
Date: Thu, 14 Feb 2019 09:57:25 -0800
Message-ID: <20190214175725.60462-9-ray.jui@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC i2c device node.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray.dtsi   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa855bd05..67e53768a84a 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -612,4 +612,22 @@
 			status = "disabled";
 		};
 	};
+
+	nic-hsls {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0  0x0 0x7fffffff>;
+
+		nic_i2c0: i2c@60826100 {
+			compatible = "brcm,iproc-nic-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x60826100 0x100>,
+			      <0x60e00408 0x1000>;
+			brcm,ape-hsls-addr-mask = <0x03400000>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
+	};
 };
-- 
2.17.1
