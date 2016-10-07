From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: [PATCH 02/10] mfd: ptxpmb-cpld: Add documentation for PTXPMB CPLD
Date: Fri,  7 Oct 2016 18:17:23 +0300
Message-ID: <1475853451-22121-3-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Debjit Ghosh <dghosh@juniper.net>, Georgi Vlaev <gvlaev@juniper.net>, Rajat Jain <rajatjain@juniper.net>, Guenter Roeck <groeck@juniper.net>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

From: Georgi Vlaev <gvlaev@juniper.net>

Add DT bindings document for the PTXPMB CPLD MFD device.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 .../devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt

diff --git a/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
new file mode 100644
index 0000000..cc3cbb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
@@ -0,0 +1,76 @@
+* Device tree bindings for Juniper's PTXPMB CPLD FPGA MFD driver
+
+The device supports a number I2C muxes, hardware watchdog and a gpio block.
+Those devices bindings are described in the jnx-i2c-mux-ptxpmb-cpld,
+jnx-ptxpmb-wdt and jnx-gpio-ptxpmb-cpld documents.
+
+Required properties:
+
+- compatible:		"jnx,ptxpmb-cpld", "jnx,ngpmb-bcpld". They differ
+			in the i2c-mux blocks.
+
+- reg:			contains offset/length value for device state control
+			registers space.
+
+Optional properties:
+
+- interrupts:		The interrupt line(s) the /IRQ signal(s) for the device is
+			connected to.
+
+- interrupt-parent:	The parent interrupt controller.
+
+Example:
+
+cpld@0,0 {
+	compatible = "jnx,ptxpmb-cpld";
+	reg = <0x0 0 0x10000>;
+
+	cpld-i2c-mux {
+		compatible = "jnx,i2c-mux-ptxpmb-cpld";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c-parent = <&i2c_master_0>;
+
+		num-enable = <1>;
+
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PMB devices are accessed through FPC */
+
+			temp-sensor@1a { /* FPC */
+				compatible = "maxim,max6697";
+				reg = <0x1a>;
+				smbus-timeout-disable;
+				resistance-cancellation;
+				alert-mask = <0xff>;
+				over-temperature-mask = <0xff>;
+			};
+		};
+
+		pic0i2c: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PIC 0 */
+		};
+
+		pic1i2c: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* PIC 1 */
+		};
+	};
+
+	gpio_cpld: cpld_gpio {
+		compatible = "jnx,gpio-ptxpmb-cpld";
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
-- 
1.9.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
