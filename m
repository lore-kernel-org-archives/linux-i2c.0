From: Matt Porter <mporter@linaro.org>
Subject: [PATCH 2/6] regulator: add bcm59056 pmu DT binding
Date: Tue,  4 Feb 2014 07:19:08 -0500
Message-ID: <1391516352-32359-3-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391516352-32359-1-git-send-email-mporter@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Tim Kryger <tim.kryger@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Christian Daudt <bcm@fixthebug.org>
Cc: Devicetree List <devicetree@vger.kernel.org>, Linux I2C List <linux-i2c@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Add a DT binding for the BCM59056 PMU. The binding inherits from
the generic regulator bindings.

Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 .../devicetree/bindings/regulator/bcm59056.txt     | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/bcm59056.txt

diff --git a/Documentation/devicetree/bindings/regulator/bcm59056.txt b/Documentation/devicetree/bindings/regulator/bcm59056.txt
new file mode 100644
index 0000000..bf6b633
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/bcm59056.txt
@@ -0,0 +1,37 @@
+BCM59056 Power Management Unit
+
+Required properties:
+- compatible: "brcm,bcm59056"
+- reg: I2C slave address
+- interrupts: interrupt for the PMU. Generic interrupt client node bindings
+  are described in interrupt-controller/interrupts.txt
+- regulators: This is the list of child nodes that specify the regulator
+  initialization data for defined regulators.  Generic regulator bindings
+  are described in regulator/regulator.txt.
+
+  The valid regulator-compatible values are:
+  	rfldo, camldo1, camldo2, simldo1, simlso2, sdldo, sdxldo,
+	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
+	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr
+
+Example:
+	pmu: bcm59056@8 {
+		compatible = "brcm,bcm59056";
+		reg = <0x08>;
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
+		regulators {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rfldo_reg: regulator@0 {
+				reg = <0>;
+				regulator-compatible = "rfldo";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			...
+		};
+	};
-- 
1.8.4
