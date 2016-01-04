From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] bindings: i2c: Add clock entries for i2c-xiic
Date: Mon, 4 Jan 2016 13:20:34 +0530
Message-ID: <1451893834-1066-2-git-send-email-shubhraj@xilinx.com>
References: <1451893834-1066-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:18971
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751064AbcADIGZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 03:06:25 -0500
In-Reply-To: <1451893834-1066-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

Add clock description for i2c-xiic

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 Documentation/devicetree/bindings/i2c/i2c-xiic.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-xiic.txt b/Documentation/devicetree/bindings/i2c/i2c-xiic.txt
index ceabbe9..caf42e9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-xiic.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-xiic.txt
@@ -6,14 +6,17 @@ Required properties:
 - interrupts : IIC controller unterrupt
 - #address-cells = <1>
 - #size-cells = <0>
+- clocks: Input clock specifier. Refer to common clock bindings.
 
 Optional properties:
 - Child nodes conforming to i2c bus binding
+- clock-names: Input clock name, should be 'pclk'.
 
 Example:
 
 	axi_iic_0: i2c@40800000 {
 		compatible = "xlnx,xps-iic-2.00.a";
+		clocks = <&clkc 15>;
 		interrupts = < 1 2 >;
 		reg = < 0x40800000 0x10000 >;
 
-- 
1.7.1
