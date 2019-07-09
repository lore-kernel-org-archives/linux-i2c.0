From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 5/9] i2c: at91: add support for digital filtering
Date: Tue, 9 Jul 2019 13:19:42 +0000
Message-ID: <1562678049-17581-6-git-send-email-eugen.hristev@microchip.com>
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

Add new platform data support for digital filtering for i2c.
The sama5d4, sama5d2 and sam9x60 support this feature.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/i2c/busses/i2c-at91-core.c   | 9 +++++++++
 drivers/i2c/busses/i2c-at91-master.c | 9 +++++++++
 drivers/i2c/busses/i2c-at91.h        | 5 +++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at=
91-core.c
index a663a7a..62610af 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -68,6 +68,7 @@ static struct at91_twi_pdata at91rm9200_config =3D {
 	.has_unre_flag =3D true,
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
+	.has_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9261_config =3D {
@@ -76,6 +77,7 @@ static struct at91_twi_pdata at91sam9261_config =3D {
 	.has_unre_flag =3D false,
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
+	.has_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9260_config =3D {
@@ -84,6 +86,7 @@ static struct at91_twi_pdata at91sam9260_config =3D {
 	.has_unre_flag =3D false,
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
+	.has_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g20_config =3D {
@@ -92,6 +95,7 @@ static struct at91_twi_pdata at91sam9g20_config =3D {
 	.has_unre_flag =3D false,
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
+	.has_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g10_config =3D {
@@ -100,6 +104,7 @@ static struct at91_twi_pdata at91sam9g10_config =3D {
 	.has_unre_flag =3D false,
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
+	.has_dig_filtr =3D false,
 };
=20
 static const struct platform_device_id at91_twi_devtypes[] =3D {
@@ -130,6 +135,7 @@ static struct at91_twi_pdata at91sam9x5_config =3D {
 	.has_unre_flag =3D false,
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
+	.has_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata sama5d4_config =3D {
@@ -138,6 +144,7 @@ static struct at91_twi_pdata sama5d4_config =3D {
 	.has_unre_flag =3D false,
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D true,
+	.has_dig_filtr =3D true,
 };
=20
 static struct at91_twi_pdata sama5d2_config =3D {
@@ -146,6 +153,7 @@ static struct at91_twi_pdata sama5d2_config =3D {
 	.has_unre_flag =3D true,
 	.has_alt_cmd =3D true,
 	.has_hold_field =3D true,
+	.has_dig_filtr =3D true,
 };
=20
 static struct at91_twi_pdata sam9x60_config =3D {
@@ -154,6 +162,7 @@ static struct at91_twi_pdata sam9x60_config =3D {
 	.has_unre_flag =3D true,
 	.has_alt_cmd =3D true,
 	.has_hold_field =3D true,
+	.has_dig_filtr =3D true,
 };
=20
 static const struct of_device_id atmel_twi_dt_ids[] =3D {
diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-=
at91-master.c
index e87232f..099161a 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -31,12 +31,18 @@
=20
 void at91_init_twi_bus_master(struct at91_twi_dev *dev)
 {
+	struct at91_twi_pdata *pdata =3D dev->pdata;
+
 	/* FIFO should be enabled immediately after the software reset */
 	if (dev->fifo_size)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_FIFOEN);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_MSEN);
 	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SVDIS);
 	at91_twi_write(dev, AT91_TWI_CWGR, dev->twi_cwgr_reg);
+
+	/* enable digital filter */
+	if (pdata->has_dig_filtr && dev->enable_dig_filt)
+		at91_twi_write(dev, AT91_TWI_FILTR, AT91_TWI_FILTR_FILT);
 }
=20
 /*
@@ -792,6 +798,9 @@ int at91_twi_probe_master(struct platform_device *pdev,
 		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
 	}
=20
+	dev->enable_dig_filt =3D of_property_read_bool(pdev->dev.of_node,
+						     "i2c-dig-filter");
+
 	at91_calc_twi_clock(dev);
=20
 	dev->adapter.algo =3D &at91_twi_algorithm;
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index 499b506..c75447e 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -84,6 +84,9 @@
 #define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
 #define	AT91_TWI_ACR_DIR	BIT(8)
=20
+#define AT91_TWI_FILTR		0x0044
+#define AT91_TWI_FILTR_FILT	BIT(0)
+
 #define	AT91_TWI_FMR		0x0050	/* FIFO Mode Register */
 #define	AT91_TWI_FMR_TXRDYM(mode)	(((mode) & 0x3) << 0)
 #define	AT91_TWI_FMR_TXRDYM_MASK	(0x3 << 0)
@@ -108,6 +111,7 @@ struct at91_twi_pdata {
 	bool has_unre_flag;
 	bool has_alt_cmd;
 	bool has_hold_field;
+	bool has_dig_filtr;
 	struct at_dma_slave dma_slave;
 };
=20
@@ -145,6 +149,7 @@ struct at91_twi_dev {
 	unsigned smr;
 	struct i2c_client *slave;
 #endif
+	bool enable_dig_filt;
 };
=20
 unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg);
--=20
2.7.4
