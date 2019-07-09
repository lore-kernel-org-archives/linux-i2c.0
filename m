From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 2/9] dt-bindings: i2c: add bindings for i2c analog and
 digital filter
Date: Tue, 9 Jul 2019 13:19:33 +0000
Message-ID: <1562678049-17581-3-git-send-email-eugen.hristev@microchip.com>
References: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, mark.rutland@arm.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pierre-yves.mordret@st.com, alexandre.belloni@bootlin.com, robh+dt@kernel.org
Cc: Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Some i2c controllers have a built-in digital or analog filter.
This is specifically required depending on the hardware PCB/board.
Some controllers also allow specifying the maximum width of the
spikes that can be filtered. The width length can be specified in nanosecon=
ds.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/=
devicetree/bindings/i2c/i2c.txt
index 44efafd..a2d31aa 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -55,6 +55,17 @@ wants to support one of the below features, it should ad=
apt the bindings below.
 	Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
 	specification.
=20
+- i2c-ana-filter
+	Enable analog filter for i2c lines.
+
+- i2c-dig-filter
+	Enable digital filter for i2c lines.
+
+- i2c-filter-width-ns
+	Width of spikes which can be filtered by either digital or analog
+	filters (i2c-ana-filtr or i2c-dig-filtr). This width is specified
+	in nanoseconds.
+
 - interrupts
 	interrupts used by the device.
=20
--=20
2.7.4
