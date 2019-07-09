From: <Eugen.Hristev@microchip.com>
Subject: [PATCH v3 6/9] i2c: at91: add support for advanced digital filtering
Date: Tue, 9 Jul 2019 13:19:45 +0000
Message-ID: <1562678049-17581-7-git-send-email-eugen.hristev@microchip.com>
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

Add new platform data support for advanced digital filtering for i2c.
The sama5d2 and sam9x60 support this feature.
This digital filter allows the user to configure the maximum
width of the spikes that can be filtered.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/i2c/busses/i2c-at91-core.c   |  9 +++++++++
 drivers/i2c/busses/i2c-at91-master.c | 30 +++++++++++++++++++++++++++---
 drivers/i2c/busses/i2c-at91.h        |  5 +++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at=
91-core.c
index 62610af..3bbe37c 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -69,6 +69,7 @@ static struct at91_twi_pdata at91rm9200_config =3D {
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
+	.has_adv_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9261_config =3D {
@@ -78,6 +79,7 @@ static struct at91_twi_pdata at91sam9261_config =3D {
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
+	.has_adv_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9260_config =3D {
@@ -87,6 +89,7 @@ static struct at91_twi_pdata at91sam9260_config =3D {
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
+	.has_adv_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g20_config =3D {
@@ -96,6 +99,7 @@ static struct at91_twi_pdata at91sam9g20_config =3D {
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
+	.has_adv_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g10_config =3D {
@@ -105,6 +109,7 @@ static struct at91_twi_pdata at91sam9g10_config =3D {
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
+	.has_adv_dig_filtr =3D false,
 };
=20
 static const struct platform_device_id at91_twi_devtypes[] =3D {
@@ -136,6 +141,7 @@ static struct at91_twi_pdata at91sam9x5_config =3D {
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D false,
 	.has_dig_filtr =3D false,
+	.has_adv_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata sama5d4_config =3D {
@@ -145,6 +151,7 @@ static struct at91_twi_pdata sama5d4_config =3D {
 	.has_alt_cmd =3D false,
 	.has_hold_field =3D true,
 	.has_dig_filtr =3D true,
+	.has_adv_dig_filtr =3D false,
 };
=20
 static struct at91_twi_pdata sama5d2_config =3D {
@@ -154,6 +161,7 @@ static struct at91_twi_pdata sama5d2_config =3D {
 	.has_alt_cmd =3D true,
 	.has_hold_field =3D true,
 	.has_dig_filtr =3D true,
+	.has_adv_dig_filtr =3D true,
 };
=20
 static struct at91_twi_pdata sam9x60_config =3D {
@@ -163,6 +171,7 @@ static struct at91_twi_pdata sam9x60_config =3D {
 	.has_alt_cmd =3D true,
 	.has_hold_field =3D true,
 	.has_dig_filtr =3D true,
+	.has_adv_dig_filtr =3D true,
 };
=20
 static const struct of_device_id atmel_twi_dt_ids[] =3D {
diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-=
at91-master.c
index 099161a..344fd26 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -43,6 +43,12 @@ void at91_init_twi_bus_master(struct at91_twi_dev *dev)
 	/* enable digital filter */
 	if (pdata->has_dig_filtr && dev->enable_dig_filt)
 		at91_twi_write(dev, AT91_TWI_FILTR, AT91_TWI_FILTR_FILT);
+
+	/* enable advanced digital filter */
+	if (pdata->has_adv_dig_filtr && dev->enable_dig_filt)
+		at91_twi_write(dev, AT91_TWI_FILTR, AT91_TWI_FILTR_FILT |
+			       (AT91_TWI_FILTR_THRES(dev->filter_width) &
+				AT91_TWI_FILTR_THRES_MASK));
 }
=20
 /*
@@ -51,7 +57,7 @@ void at91_init_twi_bus_master(struct at91_twi_dev *dev)
  */
 static void at91_calc_twi_clock(struct at91_twi_dev *dev)
 {
-	int ckdiv, cdiv, div, hold =3D 0;
+	int ckdiv, cdiv, div, hold =3D 0, filter_width =3D 0;
 	struct at91_twi_pdata *pdata =3D dev->pdata;
 	int offset =3D pdata->clk_offset;
 	int max_ckdiv =3D pdata->clk_max_div;
@@ -90,11 +96,29 @@ static void at91_calc_twi_clock(struct at91_twi_dev *de=
v)
 		}
 	}
=20
+	if (pdata->has_adv_dig_filtr) {
+		/*
+		 * filter width =3D 0 to AT91_TWI_FILTR_THRES_MAX
+		 * peripheral clocks
+		 */
+		filter_width =3D DIV_ROUND_UP(t->filter_width_ns
+				* (clk_get_rate(dev->clk) / 1000), 1000000);
+		if (filter_width > AT91_TWI_FILTR_THRES_MAX) {
+			dev_warn(dev->dev,
+				"Filter threshold set to its maximum value (%d instead of %d)\n",
+				AT91_TWI_FILTR_THRES_MAX, filter_width);
+			filter_width =3D AT91_TWI_FILTR_THRES_MAX;
+		}
+	}
+
 	dev->twi_cwgr_reg =3D (ckdiv << 16) | (cdiv << 8) | cdiv
 			    | AT91_TWI_CWGR_HOLD(hold);
=20
-	dev_dbg(dev->dev, "cdiv %d ckdiv %d hold %d (%d ns)\n",
-		cdiv, ckdiv, hold, t->sda_hold_ns);
+	dev->filter_width =3D filter_width;
+
+	dev_dbg(dev->dev, "cdiv %d ckdiv %d hold %d (%d ns), filter_width %d (%d =
ns)\n",
+		cdiv, ckdiv, hold, t->sda_hold_ns, filter_width,
+		t->filter_width_ns);
 }
=20
 static void at91_twi_dma_cleanup(struct at91_twi_dev *dev)
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index c75447e..d7cf01e3 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -86,6 +86,9 @@
=20
 #define AT91_TWI_FILTR		0x0044
 #define AT91_TWI_FILTR_FILT	BIT(0)
+#define AT91_TWI_FILTR_THRES(v)		((v) << 8)
+#define AT91_TWI_FILTR_THRES_MAX	7
+#define AT91_TWI_FILTR_THRES_MASK	GENMASK(10, 8)
=20
 #define	AT91_TWI_FMR		0x0050	/* FIFO Mode Register */
 #define	AT91_TWI_FMR_TXRDYM(mode)	(((mode) & 0x3) << 0)
@@ -112,6 +115,7 @@ struct at91_twi_pdata {
 	bool has_alt_cmd;
 	bool has_hold_field;
 	bool has_dig_filtr;
+	bool has_adv_dig_filtr;
 	struct at_dma_slave dma_slave;
 };
=20
@@ -150,6 +154,7 @@ struct at91_twi_dev {
 	struct i2c_client *slave;
 #endif
 	bool enable_dig_filt;
+	u32 filter_width;
 };
=20
 unsigned at91_twi_read(struct at91_twi_dev *dev, unsigned reg);
--=20
2.7.4
