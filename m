From: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: davinci: da850: add DT node for I2C0
Date: Wed, 6 Feb 2013 15:06:22 +0530
Message-ID: <1360143382-24607-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, manishv.b-l0cyMroinI0@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add I2C0 device tree and pin muxing information to da850-evm.
Also, add OF_DEV_AUXDATA for I2C0 controller driver in da850
board dt file to use I2C0 clock.
Verified i2c0 node gets created in sys class interface as
"/sys/class/i2c-dev/i2c-0/subsystem/i2c-0".

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>
---
Applies on top of v3.8-rc6 of linus tree.
Depends on
 - drivers/pinctrl: grab default handles from device core
   http://www.gossamer-threads.com/lists/linux/kernel/1665411
 - ARM: davinci: da850: add interrupt-parent property in soc node
   https://patchwork.kernel.org/patch/2044101/
 - ARM: davinci: da850: add pinctrl support
   http://comments.gmane.org/gmane.linux.davinci/25993

:100644 100644 433027f... 738d5d4... M	arch/arm/boot/dts/da850-evm.dts
:100644 100644 4b02167... a0072aa... M	arch/arm/boot/dts/da850.dtsi
:100644 100644 37c27af... 95ca4e9... M	arch/arm/mach-davinci/da8xx-dt.c
 arch/arm/boot/dts/da850-evm.dts  |    6 ++++++
 arch/arm/boot/dts/da850.dtsi     |   14 ++++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    8 +++++++-
 3 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 433027f..738d5d4 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,6 +27,12 @@
 		serial2: serial@1d0d000 {
 			status = "okay";
 		};
+		i2c0: i2c@1c22000 {
+			status = "okay";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+		};
 	};
 	nand_cs3@62000000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 4b02167..a0072aa 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -56,6 +56,12 @@
 					0x30 0x01100000  0x0ff00000
 				>;
 			};
+			i2c0_pins: pinmux_i2c0_pins {
+				pinctrl-single,bits = <
+					/* I2C0_SDA,I2C0_SCL */
+					0x10 0x00002200 0x0000ff00
+				>;
+			};
 		};
 		serial0: serial@1c42000 {
 			compatible = "ns16550a";
@@ -81,6 +87,14 @@
 			interrupts = <61>;
 			status = "disabled";
 		};
+		i2c0: i2c@1c22000 {
+			compatible = "ti,davinci-i2c";
+			reg = <0x22000 0x1000>;
+			interrupts = <15>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 	nand_cs3@62000000 {
 		compatible = "ti,davinci-nand";
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 37c27af..95ca4e9 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -37,11 +37,17 @@ static void __init da8xx_init_irq(void)
 	of_irq_init(da8xx_irq_match);
 }
 
+struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
+	{}
+};
+
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
 static void __init da850_init_machine(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+				da850_auxdata_lookup, NULL);
 
 	da8xx_uart_clk_enable();
 }
-- 
1.7.4.1
