From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: efm32: correct namespacing of location property
Date: Fri, 11 Jul 2014 10:22:20 +0200
Message-ID: <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Olof Johansson pointed out that usually the company name is picked as
namespace prefix to specific properties. So expect "energymicro,locatio=
n"
but fall back to the previously introduced name "efm32,location".

Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-efm32.txt | 4 ++--
 drivers/i2c/busses/i2c-efm32.c                      | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-efm32.txt
index fc15ac519437..50b25c3da186 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
@@ -10,7 +10,7 @@ Required properties :
 Recommended properties :
=20
  - clock-frequency : maximal I2C bus clock frequency in Hz.
- - efm32,location : Decides the location of the USART I/O pins.
+ - energymicro,location : Decides the location of the USART I/O pins.
    Allowed range : [0 .. 6]
=20
 Example:
@@ -23,7 +23,7 @@ Example:
 		clocks =3D <&cmu clk_HFPERCLKI2C0>;
 		clock-frequency =3D <100000>;
 		status =3D "ok";
-		efm32,location =3D <3>;
+		energymicro,location =3D <3>;
=20
 		eeprom@50 {
 			compatible =3D "microchip,24c02";
diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-ef=
m32.c
index f7eccd682de9..5c4cf94527e3 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -370,7 +370,13 @@ static int efm32_i2c_probe(struct platform_device =
*pdev)
 		return ret;
 	}
=20
-	ret =3D of_property_read_u32(np, "efm32,location", &location);
+
+	ret =3D of_property_read_u32(np, "energymicro,location", &location);
+
+	if (!ret)
+		/* fall back to wrongly namespaced property */
+		ret =3D of_property_read_u32(np, "efm32,location", &location);
+
 	if (!ret) {
 		dev_dbg(&pdev->dev, "using location %u\n", location);
 	} else {
--=20
2.0.0
