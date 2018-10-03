From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v8 10/10] dt-bindings: gpio: Add bindings for Cadence I3C gpio expander
Date: Wed,  3 Oct 2018 15:22:12 +0200
Message-ID: <20181003132212.12619-11-boris.brezillon@bootlin.com>
References: <20181003132212.12619-1-boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003132212.12619-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus
List-Id: linux-i2c@vger.kernel.org

Document the Cadence I3C gpio expander bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v8:
- None

Changes in v7:
- None

Changes in v6:
- None

Changes in v5:
- Add Rob's R-b

Changes in v4:
- Use GPIO_ and IRQ_TYPE_ macros instead of raw numbers
- Fix the unit-address in the example
---
 .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
new file mode 100644
index 000000000000..d0155a9cea79
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
@@ -0,0 +1,39 @@
+* Cadence I3C GPIO expander
+
+The Cadence I3C GPIO expander provides 8 GPIOs controllable over I3C.
+This GPIOs can be configured in output or input mode and if they are in input
+mode they can generate IBIs (In Band Interrupts).
+
+Required properties for GPIO node:
+- reg : 3 cells encoding the I3C static address (none in our case) and the I3C
+	Provisional ID. See Documentation/devicetree/bindings/i3c/i3c.txt for
+	more details.
+	Should be <0x0 0x392 0x0>.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity (GPIO_ACTIVE_HIGH or
+  GPIO_ACTIVE_LOW)
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2. The first cell is the GPIO number.
+  The second cell is used to specify trigger type and level flags.
+  The following trigger types are accepted (see
+  <dt-bindings/interrupt-controller/irq.h> for their definition):
+	IRQ_TYPE_EDGE_RISING
+	IRQ_TYPE_EDGE_FALLING
+	IRQ_TYPE_EDGE_BOTH
+	IRQ_TYPE_LEVEL_HIGH
+	IRQ_TYPE_LEVEL_LOW
+
+Example:
+
+	i3c-master@xxx {
+		...
+		i3c_gpio_expander: gpio@0,39200000000 {
+			reg = <0 0x392 0x0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+		...
+	};
-- 
2.14.1
