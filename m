From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 2/2] i2c: at91: Save the bus clock frequency in adapter
Date: Mon, 10 Dec 2018 08:41:23 +0000
Message-ID: <20181210084111.6938-3-tudor.ambarus@microchip.com>
References: <20181210084111.6938-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210084111.6938-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tudor.Ambarus@microchip.com
List-Id: linux-i2c@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwis=
e,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and provide the bus clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v2: no change

 drivers/i2c/busses/i2c-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3bf5ff..9aa0937817ac 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1124,6 +1124,7 @@ static int at91_twi_probe(struct platform_device *pde=
v)
 	dev->adapter.quirks =3D &at91_twi_quirks;
 	dev->adapter.dev.parent =3D dev->dev;
 	dev->adapter.nr =3D pdev->id;
+	dev->adapter.bus_freq_hz =3D bus_clk_rate;
 	dev->adapter.timeout =3D AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node =3D pdev->dev.of_node;
=20
--=20
2.9.4
