From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 4/4] dt-bindings: i2c: at91: fix i2c-sda-hold-time-ns
 documentation for sam9x60
Date: Mon, 9 Dec 2019 10:20:07 +0000
Message-ID: <1575886763-19089-4-git-send-email-eugen.hristev@microchip.com>
References: <1575886763-19089-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575886763-19089-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org, Ludovic.Desroches@microchip.com, wsa@the-dreams.de
Cc: peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Codrin.Ciubotariu@microchip.com, Eugen.Hristev@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

SAM9X60 also supports i2c-sda-hold-time-ns. Fix the documentation according=
ly.

Fixes: 2034e3f4c9a5 ("dt-bindings: i2c: at91: add new compatible")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v3:
- new patch

 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documenta=
tion/devicetree/bindings/i2c/i2c-at91.txt
index d35cd63..d4bad86 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -24,8 +24,10 @@ Optional properties:
 - dma-names: should contain "tx" and "rx".
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store fo=
r FIFO
   capable I2C controllers.
-- i2c-sda-hold-time-ns: TWD hold time, only available for "atmel,sama5d4-i=
2c"
-  and "atmel,sama5d2-i2c".
+- i2c-sda-hold-time-ns: TWD hold time, only available for:
+	"atmel,sama5d4-i2c",
+	"atmel,sama5d2-i2c",
+	"microchip,sam9x60-i2c".
 - Child nodes conforming to i2c bus binding
=20
 Examples :
--=20
2.7.4
