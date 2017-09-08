From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 2/2] dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm property
Date: Fri, 8 Sep 2017 12:54:48 -0500
Message-ID: <20170908175448.3367-3-fcooper@ti.com>
References: <20170908175448.3367-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:51752 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbdIHRzl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 8 Sep 2017 13:55:41 -0400
In-Reply-To: <20170908175448.3367-1-fcooper@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com, vigneshr@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>

Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
unique clocks property usage.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/i2c/i2c-davinci.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
index 5b123e0..64e6e65 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
@@ -6,6 +6,18 @@ davinci/keystone i2c interface contains.
 Required properties:
 - compatible: "ti,davinci-i2c" or "ti,keystone-i2c";
 - reg : Offset and length of the register set for the device
+- clocks: I2C functional clock phandle.
+	  For 66AK2G this property should be set per binding,
+	  Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+
+SoC-specific Required Properties:
+
+The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+
+- power-domains:	Should contain a phandle to a PM domain provider node
+			and an args specifier containing the I2C device id
+			value. This property is as per the binding,
+			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 
 Recommended properties :
 - interrupts : standard interrupt property.
-- 
2.9.4.dirty
