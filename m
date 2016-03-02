From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2 1/2] bindings: i2c: Add clock entries for i2c-xiic
Date: Wed, 2 Mar 2016 17:34:06 +0530
Message-ID: <1456920247-37291-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0049.outbound.protection.outlook.com ([104.47.36.49]:11136
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753197AbcCBMSf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 2 Mar 2016 07:18:35 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, wsa@the-dreams.de, Shubhrajyoti Datta <shubhraj@xilinx.com>

Add clock description for i2c-xiic

Acked-by: Rob Herring <robh@kernel.org>
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
