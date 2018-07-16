From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH 1/2] dt: snps,designware-i2c: Add clock bindings documentation
Date: Mon, 16 Jul 2018 09:59:12 +0100
Message-ID: <1531731553-22979-2-git-send-email-phil.edworthy@renesas.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The driver requires an undocumented clock property, so detail it.
Add documentation for a separate bus clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 Documentation/devicetree/bindings/i2c/i2c-designware.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
index fbb0a6d..e9f4387 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
@@ -1,16 +1,21 @@
 * Synopsys DesignWare I2C
 
 Required properties :
-
  - compatible : should be "snps,designware-i2c"
  - reg : Offset and length of the register set for the device
  - interrupts : <IRQ> where IRQ is the interrupt number.
+ - clocks : phandles for the clocks, see the description of clock-names below.
+   The phandle for the "ic_clk" clock is required. The phandle for the "bus"
+   clock is optional. If a single clock is specified but no clock-name, it is
+   the "ic_clk" clock. If both clocks are listed, the "ic_clk" must be first.
 
 Recommended properties :
-
  - clock-frequency : desired I2C bus clock frequency in Hz.
 
 Optional properties :
+ - clock-names : Contains the names of the clocks:
+    "ic_clk", for the core clock used to generate the external I2C clock.
+    "bus", the bus clock, sometimes described as pclk, for register accesses.
  - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
    This option is only supported in hardware blocks version 1.11a or newer.
 
-- 
2.7.4
