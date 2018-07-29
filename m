From: Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v1 1/2] dt-binding: i2c: npcm7xx: add binding for i2c
Date: Sun, 29 Jul 2018 12:14:48 +0300
Message-ID: <20180729091449.385951-2-tali.perry1@gmail.com>
References: <20180729091449.385951-1-tali.perry1@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180729091449.385951-1-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tali.perry1@gmail.com, avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com, yuenn@google.com, brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, arnd@arndb.de, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, pierre-yves.mordret@st.com, cedric.madianga@gmail.com, baolin.wang@spreadtrum.com, jarkko.nikula@linux.intel.com, hdegoede@redhat.com, rmk+kernel@armlinux.org.uk, ard.biesheuvel@linaro.org, thor.thayer@linux.intel.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, tglx@linutronix.de
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Nuvoton NPCM7XX I2C Controller
NPCM7xx includes 16 I2C contollers. This driver operates the controller.
This module also includes a slave mode, which will be submitted later on.

Any feedback would be appreciated.  


Signed-off-by: Tali Perry <tali.perry1@gmail.com>

---
 .../devicetree/bindings/i2c/i2c-npcm7xx.txt        | 27 ++++++++++++++++++++++
 MAINTAINERS                                        |  9 ++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
new file mode 100644
index 000000000000..e2ee45d7a41e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
@@ -0,0 +1,27 @@
+Nuvoton NPCM7XX I2C bus
+
+The NPCM750x includes sixteen I2C busses
+
+Required properties:
+- compatible      : must be "nuvoton,npcm750-i2c-bus"
+- reg             : Offset and length of the register set for the device.
+- interrupts      : Contain the I2C interrupt with flags for falling edge.
+- clocks          : phandle of I2C reference clock.
+
+Optional:
+- bus-frequency   : Contain the I2C bus frequency,
+			the default I2C bus frequency is 100000.
+- pinctrl-0       : must be <&smbX_pins>, X is module number
+			(on NPCM7XX it's 0 to 15)
+- pinctrl-names   : should be set to "default"
+Example:
+
+	i2c0: i2c-bus@80000 {
+		compatible = "nuvoton,npcm750-i2c-bus";
+		reg = <0x80000 0x1000>;
+		clocks = <&clk NPCM7XX_CLK_APB2>;
+		bus-frequency = <100000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&smb0_pins>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..a28edc9daabb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1735,6 +1735,15 @@ F:	drivers/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 
+ARM/NUVOTON I2C DRIVER
+M:	Tali Perry <tali.perry1@gmail.com>
+M:	Avi Fishman <avifishman70@gmail.com>
+L:	linux-i2c@vger.kernel.org
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+S:	Supported
+F:	drivers/i2c/busses/i2c-npcm7xx.c
+F:	Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
+
 ARM/NUVOTON W90X900 ARM ARCHITECTURE
 M:	Wan ZongShun <mcuos.com@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.14.1
