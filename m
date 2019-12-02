From: <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/3] dt-bindings: i2c: at91: cosmetic formatting of compatible
 list
Date: Mon, 2 Dec 2019 08:56:35 +0000
Message-ID: <1575276957-5615-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, Ludovic.Desroches@microchip.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, peda@axentia.se
Cc: Codrin.Ciubotariu@microchip.com, Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Format the list of compatibles with one compatible per line.

Suggested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documenta=
tion/devicetree/bindings/i2c/i2c-at91.txt
index 2210f43..d35cd63 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -1,10 +1,16 @@
 I2C for Atmel platforms
=20
 Required properties :
-- compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2c",
-     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sam9g10-=
i2c",
-     "atmel,at91sam9x5-i2c", "atmel,sama5d4-i2c", "atmel,sama5d2-i2c" or
-     "microchip,sam9x60-i2c"
+- compatible : Must be one of:
+	"atmel,at91rm9200-i2c",
+	"atmel,at91sam9261-i2c",
+	"atmel,at91sam9260-i2c",
+	"atmel,at91sam9g20-i2c",
+	"atmel,at91sam9g10-i2c",
+	"atmel,at91sam9x5-i2c",
+	"atmel,sama5d4-i2c",
+	"atmel,sama5d2-i2c",
+	"microchip,sam9x60-i2c".
 - reg: physical base address of the controller and length of memory mapped
      region.
 - interrupts: interrupt number to the cpu.
--=20
2.7.4
