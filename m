From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v5 7/9] i2c: at91: add support for analog filtering
Date: Wed, 11 Sep 2019 08:24:34 +0000
Message-ID: <1568189911-31641-8-git-send-email-eugen.hristev@microchip.com>
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

Add support for analog filtering for i2c lines.
The sama5d2 and sam9x60 support this feature.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/i2c/busses/i2c-at91-core.c   |  9 +++++++++
 drivers/i2c/busses/i2c-at91-master.c | 18 ++++++++++++++----
 drivers/i2c/busses/i2c-at91.h        |  3 +++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at=
91-core.c
index 1f4ee7e..e13af48 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -70,6 +70,7 @@ static struct at91_twi_pdata at91rm9200_config =3D {
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
+	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9261_config =3D {
@@ -80,6 +81,7 @@ static struct at91_twi_pdata at91sam9261_config =3D {
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
+	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9260_config =3D {
@@ -90,6 +92,7 @@ static struct at91_twi_pdata at91sam9260_config =3D {
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
+	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g20_config =3D {
@@ -100,6 +103,7 @@ static struct at91_twi_pdata at91sam9g20_config =3D {
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
+	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g10_config =3D {
@@ -110,6 +114,7 @@ static struct at91_twi_pdata at91sam9g10_config =3D {
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
+	.has_ana_filtr =3D false,
 };
=20
 static const struct platform_device_id at91_twi_devtypes[] =3D {
@@ -142,6 +147,7 @@ static struct at91_twi_pdata at91sam9x5_config =3D {
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
+	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata sama5d4_config =3D {
@@ -152,6 +158,7 @@ static struct at91_twi_pdata sama5d4_config =3D {
 	.has_hold_field =3D true,
 	.has_dig_filtr =3D true,
 	.has_adv_dig_filtr =3D false,
+	.has_ana_filtr =3D false,
 };
=20
 static struct at91_twi_pdata sama5d2_config =3D {
@@ -162,6 +169,7 @@ static struct at91_twi_pdata sama5d2_config =3D {
 	.has_hold_field =3D true,
 	.has_dig_filtr =3D true,
 	.has_adv_dig_filtr =3D true,
+	.has_ana_filtr =3D true,
 };
=20
 static struct at91_twi_pdata sam9x60_config =3D {
@@ -172,6 +180,7 @@ static struct at91_twi_pdata sam9x60_config =3D {
 	.has_hold_field =3D true,
 	.has_dig_filtr =3D true,
 	.has_adv_dig_filtr =3D true,
+	.has_ana_filtr =3D true,
 };
=20
 static const struct of_device_id atmel_twi_dt_ids[] =3D {
diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-=
at91-master.c
index 273bd8b..6e0b554 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -32,6 +32,7 @@
 void at91_init_twi_bus_master(struct at91_twi_dev *dev)
 {
 	struct at91_twi_pdata *pdata =3D dev->pdata;
+	u32 filtr =3D 0;
=20
 	/* FIFO should be enabled immediately after the software reset */
 	if (dev->fifo_size)
@@ -42,13 +43,20 @@ void at91_init_twi_bus_master(struct at91_twi_dev *dev)
=20
 	/* enable digital filter */
 	if (pdata->has_dig_filtr && dev->enable_dig_filt)
-		at91_twi_write(dev, AT91_TWI_FILTR, AT91_TWI_FILTR_FILT);
+		filtr |=3D AT91_TWI_FILTR_FILT;
=20
 	/* enable advanced digital filter */
 	if (pdata->has_adv_dig_filtr && dev->enable_dig_filt)
-		at91_twi_write(dev, AT91_TWI_FILTR, AT91_TWI_FILTR_FILT |
-			       (AT91_TWI_FILTR_THRES(dev->filter_width) &
-				AT91_TWI_FILTR_THRES_MASK));
+		filtr |=3D AT91_TWI_FILTR_FILT |
+			 (AT91_TWI_FILTR_THRES(dev->filter_width) &
+			 AT91_TWI_FILTR_THRES_MASK);
+
+	/* enable analog filter */
+	if (pdata->has_ana_filtr && dev->enable_ana_filt)
+		filtr |=3D AT91_TWI_FILTR_PADFEN;
+
+	if (filtr)
+		at91_twi_write(dev, AT91_TWI_FILTR, filtr);
 }
=20
 /*
@@ -826,6 +834,8 @@ int at91_twi_probe_master(struct platform_device *pdev,
 	dev->enable_dig_filt =3D of_property_read_bool(pdev->dev.of_node,
 						     "i2c-digital-filter");
=20
+	dev->enable_ana_filt =3D of_property_read_bool(pdev->dev.of_node,
+						     "i2c-analog-filter");
 	at91_calc_twi_clock(dev);
=20
 	dev->adapter.algo =3D &at91_twi_algorithm;
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index d7cf01e3..977a67b 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -86,6 +86,7 @@
=20
 #define AT91_TWI_FILTR		0x0044
 #define AT91_TWI_FILTR_FILT	BIT(0)
+#define AT91_TWI_FILTR_PADFEN	BIT(1)
 #define AT91_TWI_FILTR_THRES(v)		((v) << 8)
 #define AT91_TWI_FILTR_THRES_MAX	7
 #define AT91_TWI_FILTR_THRES_MASK	GENMASK(10, 8)
@@ -116,6 +117,7 @@ struct at91_twi_pdata {
 	bool has_hold_field;
 	bool has_dig_filtr;
 	bool has_adv_dig_filtr;
+	bool has_ana_filtr;
 	struct at_dma_slave dma_slave;
 };
=20
@@ -154,6 +156,7 @@ struct at91_twi_dev {
 	struct i2c_client *slave;
 #endif
 	bool enable_dig_filt;
+	bool enable_ana_filt;
 	u32 filter_width;
 };
=20
--=20
2.7.4
