From: Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 1/4] dt-bindings: i2c: Add S700 support for Actions Semi Soc's
Date: Tue, 11 Dec 2018 09:04:45 +0100
Message-ID: <20181211080448.24007-2-pn@denx.de>
References: <20181211080448.24007-1-pn@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211080448.24007-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: manivannan.sadhasivam@linaro.org, afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, Parthiban Nallathambi <pn@denx.de>
List-Id: linux-i2c@vger.kernel.org

Add s700 compatible string to Actions Semi SoC dt-bindings.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 Documentation/devicetree/bindings/i2c/i2c-owl.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
index b743fe444e9f..54c05dbdb2e4 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-owl.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -2,7 +2,9 @@ Actions Semiconductor Owl I2C controller
 
 Required properties:
 
-- compatible        : Should be "actions,s900-i2c".
+- compatible        : Should be one of the following:
+		      - "actions,s700-i2c" for S700 SoC
+		      - "actions,s900-i2c" for S900 SoC
 - reg               : Offset and length of the register set for the device.
 - #address-cells    : Should be 1.
 - #size-cells       : Should be 0.
-- 
2.17.2
