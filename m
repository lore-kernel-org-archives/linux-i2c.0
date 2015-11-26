From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 6/9] ARM: shmobile: r8a7790: dtsi: add internal delay for i2c IPs
Date: Thu, 26 Nov 2015 23:59:14 +0100
Message-ID: <1448578757-12613-7-git-send-email-wsa@the-dreams.de>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36549 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbbKZW72 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 26 Nov 2015 17:59:28 -0500
In-Reply-To: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0612502b4a6d67..cdbebc329cff9a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -418,6 +418,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <110>;
 	};
 
 	i2c1: i2c@e6518000 {
@@ -429,6 +430,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c2: i2c@e6530000 {
@@ -440,6 +442,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <6>;
 	};
 
 	i2c3: i2c@e6540000 {
@@ -451,6 +454,7 @@
 		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
+		i2c-scl-internal-delay-ns = <110>;
 	};
 
 	iic0: i2c@e6500000 {
-- 
2.1.4
