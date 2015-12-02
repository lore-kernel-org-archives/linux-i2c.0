From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v3] arm64: dts: add all hi6220 i2c nodes
Date: Wed, 2 Dec 2015 14:29:09 +0800
Message-ID: <1449037749-14388-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:25211 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbbLBGb2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 2 Dec 2015 01:31:28 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: pawel.moll@arm.com, galak@codeaurora.org, catalin.marinas@arm.com, w.f@huawei.com, liguozhu@hisilicon.com, kong.kongxinwei@hisilicon.com

This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
use this I2C IP of Synopsys Designware for HiKey board.

Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 82d2488..6eae673 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -208,5 +208,36 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		i2c0: i2c@f7100000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7100000 0x0 0x1000>;
+			interrupts = <0 44 4>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@f7101000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7101000 0x0 0x1000>;
+			interrupts = <0 45 4>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@f7102000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7102000 0x0 0x1000>;
+			interrupts = <0 46 4>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
1.9.1
