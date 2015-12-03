From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 7/9] ARM: shmobile: r8a7791: dtsi: add internal delay for i2c IPs
Date: Thu,  3 Dec 2015 16:51:37 +0100
Message-ID: <1449157899-6572-8-git-send-email-wsa@the-dreams.de>
References: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33446 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760601AbbLCPvz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Dec 2015 10:51:55 -0500
In-Reply-To: <1449157899-6572-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 76b33e895513c1..3161dfcdd002dd 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -407,6 +407,7 @@
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -418,6 +419,7 @@
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -429,6 +431,7 @@
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -440,6 +443,7 @@
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -451,6 +455,7 @@
 		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
 
@@ -463,6 +468,7 @@
 		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
 		power-domains = <&cpg_clocks>;
+		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
 
-- 
2.1.4
