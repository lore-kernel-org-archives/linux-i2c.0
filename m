From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/5] dt-bindings: add bindings for i2c-pca-platform
Date: Tue, 20 Jun 2017 13:18:33 +1200
Message-ID: <20170620011837.14010-2-chris.packham@alliedtelesis.co.nz>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Split dt-binding to separate patch, use "reset-gpios" instead of "gpios".

 .../devicetree/bindings/i2c/i2c-pca-platform.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
new file mode 100644
index 000000000000..86abf249b194
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-pca-platform.txt
@@ -0,0 +1,18 @@
+* NXP PCA PCA9564/PCA9665 I2C controller
+
+The PCA9564/PCA9665 serves as an interface between most standard
+parallel-bus microcontrollers/microprocessors and the serial I2C-bus
+and allows the parallel bus system to communicate bi-directionally
+with the I2C-bus.
+
+Required properties :
+
+ - reg : Offset and length of the register set for the device
+ - compatible : one of "nxp,pca9564" or "nxp,pca9665"
+
+Optional properties
+ - interrupts : the interrupt number
+ - interrupt-parent : the phandle for the interrupt controller.
+   If an interrupt is not specified polling will be used.
+ - reset-gpios : gpio specifier for gpio connected to RESET_N pin.
+ - clock-frequency : I2C bus frequency.
-- 
2.13.0
