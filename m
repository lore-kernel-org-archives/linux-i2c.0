From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 7/7] dt-bindings: i3c: Document Cadence I3C master bindings
Date: Thu, 14 Dec 2017 16:16:10 +0100
Message-ID: <20171214151610.19153-8-boris.brezillon@free-electrons.com>
References: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37850 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbdLNPQU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Dec 2017 10:16:20 -0500
In-Reply-To: <20171214151610.19153-1-boris.brezillon@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij <linus.walleij@linaro.org>

Document Cadence I3C master DT bindings.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt

diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
new file mode 100644
index 000000000000..f9e4af4ff1c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
@@ -0,0 +1,45 @@
+Bindings for cadence I3C master block
+=====================================
+
+Required properties:
+--------------------
+- compatible: shall be "cdns,i3c-master"
+- clocks: shall reference the pclk and sysclk
+- clock-names: shall contain "pclk" and "sysclk"
+- interrupts: the interrupt line connected to this I3C master
+- reg: I3C master registers
+
+Mandatory properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- #address-cells: shall be set to 1
+- #size-cells: shall be set to 0
+
+Optional properties defined by the generic binding (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details):
+
+- i2c-scl-frequency
+- i3c-scl-frequency
+
+I3C device connected on the bus follow the generic description (see
+Documentation/devicetree/bindings/i3c/i3c.txt for more details).
+
+Example:
+
+	i3c-master@0d040000 {
+		compatible = "cdns,i3c-master";
+		clocks = <&coreclock>, <&i3csysclock>;
+		clock-names = "pclk", "sysclk";
+		interrupts = <3 0>;
+		reg = <0x0d040000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-scl-frequency = <100000>;
+
+		nunchuk: nunchuk@52 {
+			compatible = "nintendo,nunchuk";
+			reg = <0x52>;
+			i3c-lvr = <0x10>;
+		};
+	};
+
-- 
2.11.0
