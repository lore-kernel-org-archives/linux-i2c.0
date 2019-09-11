From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v5 2/9] dt-bindings: i2c: add bindings for i2c analog and
 digital filter
Date: Wed, 11 Sep 2019 08:24:20 +0000
Message-ID: <1568189911-31641-3-git-send-email-eugen.hristev@microchip.com>
References: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568189911-31641-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, mark.rutland@arm.com, Ludovic.Desroches@microchip.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com, robh+dt@kernel.org
Cc: Eugen.Hristev@microchip.com, Nicolas.Ferre@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Some i2c controllers have a built-in digital or analog filter.
This is specifically required depending on the hardware PCB/board.
Some controllers also allow specifying the maximum width of the
spikes that can be filtered for digital filter. The width length can be
specified in nanoseconds.
Analog filters can be configured to have a cutoff frequency (low-pass filte=
r).
This frequency can be specified in Hz.
Added an optional property for such types of analog filters.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/i2c/i2c.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/=
devicetree/bindings/i2c/i2c.txt
index 44efafd..9a53df4 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -55,6 +55,24 @@ wants to support one of the below features, it should ad=
apt the bindings below.
 	Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
 	specification.
=20
+- i2c-analog-filter
+	Enable analog filter for i2c lines.
+
+- i2c-digital-filter
+	Enable digital filter for i2c lines.
+
+- i2c-digital-filter-width-ns
+	Width of spikes which can be filtered by digital filter
+	(i2c-digital-filter). This width is specified in nanoseconds.
+
+- i2c-analog-filter-cutoff-frequency
+	Frequency that the analog filter (i2c-analog-filter) uses to distinguish
+	which signal to filter. Signal with higher frequency than specified will
+	be filtered out. Only lower frequency will pass (this is applicable to
+	a low-pass analog filter). Typical value should be above the normal
+	i2c bus clock frequency (clock-frequency).
+	Specified in Hz.
+
 - interrupts
 	interrupts used by the device.
=20
--=20
2.7.4
