From: Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 2/2] dt-bindings: i2c: Aspeed: Add AST2600 compatible
Date: Fri, 13 Sep 2019 11:35:10 -0500
Message-ID: <1568392510-866-3-git-send-email-eajames@linux.ibm.com>
References: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, brendanhiggins@google.com, joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org, Eddie James <eajames@linux.ibm.com>
List-Id: linux-i2c@vger.kernel.org

Document the AST2600 I2C bus compatible string.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index 8fbd863..b47f6cc 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -1,4 +1,4 @@
-Device tree configuration for the I2C busses on the AST24XX and AST25XX SoCs.
+Device tree configuration for the I2C busses on the AST24XX, AST25XX, and AST26XX SoCs.
 
 Required Properties:
 - #address-cells	: should be 1
@@ -6,6 +6,7 @@ Required Properties:
 - reg			: address offset and range of bus
 - compatible		: should be "aspeed,ast2400-i2c-bus"
 			  or "aspeed,ast2500-i2c-bus"
+			  or "aspeed,ast2600-i2c-bus"
 - clocks		: root clock of bus, should reference the APB
 			  clock in the second cell
 - resets		: phandle to reset controller with the reset number in
-- 
1.8.3.1
