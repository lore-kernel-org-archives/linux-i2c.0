From: <Codrin.Ciubotariu@microchip.com>
Subject: [PATCH v2 3/6] i2c: at91: Send bus clear command if SCL is down
Date: Fri, 3 Jan 2020 09:49:07 +0000
Message-ID: <20200103094821.13185-4-codrin.ciubotariu@microchip.com>
References: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kamel.bouhara@bootlin.com, wsa@the-dreams.de, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org, Codrin.Ciubotariu@microchip.com
List-Id: linux-i2c@vger.kernel.org

After a transfer timeout, some faulty I2C slave devices might hold down
the SCL pin. We can generate a bus clear command, hoping that the slave
might release the pins.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v2:
 - use CLEAR command only if SDA is down; update patch subject to
   reflect this;
 - CLEAR command is no longer used for sama5d2, only sam9x60;

 drivers/i2c/busses/i2c-at91-core.c   |  9 ++++++++
 drivers/i2c/busses/i2c-at91-master.c | 32 +++++++++++++++++++++++-----
 drivers/i2c/busses/i2c-at91.h        |  7 +++++-
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at=
91-core.c
index e13af4874976..128eafc05adb 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -71,6 +71,7 @@ static struct at91_twi_pdata at91rm9200_config =3D {
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
 	.has_ana_filtr =3D false,
+	.has_clear_cmd =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9261_config =3D {
@@ -82,6 +83,7 @@ static struct at91_twi_pdata at91sam9261_config =3D {
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
 	.has_ana_filtr =3D false,
+	.has_clear_cmd =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9260_config =3D {
@@ -93,6 +95,7 @@ static struct at91_twi_pdata at91sam9260_config =3D {
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
 	.has_ana_filtr =3D false,
+	.has_clear_cmd =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g20_config =3D {
@@ -104,6 +107,7 @@ static struct at91_twi_pdata at91sam9g20_config =3D {
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
 	.has_ana_filtr =3D false,
+	.has_clear_cmd =3D false,
 };
=20
 static struct at91_twi_pdata at91sam9g10_config =3D {
@@ -115,6 +119,7 @@ static struct at91_twi_pdata at91sam9g10_config =3D {
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
 	.has_ana_filtr =3D false,
+	.has_clear_cmd =3D false,
 };
=20
 static const struct platform_device_id at91_twi_devtypes[] =3D {
@@ -148,6 +153,7 @@ static struct at91_twi_pdata at91sam9x5_config =3D {
 	.has_dig_filtr =3D false,
 	.has_adv_dig_filtr =3D false,
 	.has_ana_filtr =3D false,
+	.has_clear_cmd =3D false,
 };
=20
 static struct at91_twi_pdata sama5d4_config =3D {
@@ -159,6 +165,7 @@ static struct at91_twi_pdata sama5d4_config =3D {
 	.has_dig_filtr =3D true,
 	.has_adv_dig_filtr =3D false,
 	.has_ana_filtr =3D false,
+	.has_clear_cmd =3D false,
 };
=20
 static struct at91_twi_pdata sama5d2_config =3D {
@@ -170,6 +177,7 @@ static struct at91_twi_pdata sama5d2_config =3D {
 	.has_dig_filtr =3D true,
 	.has_adv_dig_filtr =3D true,
 	.has_ana_filtr =3D true,
+	.has_clear_cmd =3D false,	/* due to errata, CLEAR cmd is not working */
 };
=20
 static struct at91_twi_pdata sam9x60_config =3D {
@@ -181,6 +189,7 @@ static struct at91_twi_pdata sam9x60_config =3D {
 	.has_dig_filtr =3D true,
 	.has_adv_dig_filtr =3D true,
 	.has_ana_filtr =3D true,
+	.has_clear_cmd =3D true,
 };
=20
 static const struct of_device_id atmel_twi_dt_ids[] =3D {
diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-=
at91-master.c
index c55e8ff35201..8c4f20317847 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -480,7 +480,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *de=
v)
 	unsigned long time_left;
 	bool has_unre_flag =3D dev->pdata->has_unre_flag;
 	bool has_alt_cmd =3D dev->pdata->has_alt_cmd;
-	struct i2c_bus_recovery_info *rinfo =3D &dev->rinfo;
+	bool has_clear_cmd =3D dev->pdata->has_clear_cmd;
=20
 	/*
 	 * WARNING: the TXCOMP bit in the Status Register is NOT a clear on
@@ -641,10 +641,32 @@ static int at91_do_twi_transfer(struct at91_twi_dev *=
dev)
 			       AT91_TWI_THRCLR | AT91_TWI_LOCKCLR);
 	}
=20
-	if (rinfo->get_sda && !(rinfo->get_sda(&dev->adapter))) {
-		dev_dbg(dev->dev,
-			"SDA is down; clear bus using gpio\n");
-		i2c_recover_bus(&dev->adapter);
+	/*
+	 * some faulty I2C slave devices might hold SDA down;
+	 * we can send a bus clear command, hoping that the pins will be
+	 * released
+	 */
+	if (has_clear_cmd) {
+		if (!(dev->transfer_status & AT91_TWI_SDA)) {
+			dev_dbg(dev->dev,
+				"SDA is down; sending bus clear command\n");
+			if (dev->use_alt_cmd) {
+				unsigned int acr;
+
+				acr =3D at91_twi_read(dev, AT91_TWI_ACR);
+				acr &=3D ~AT91_TWI_ACR_DATAL_MASK;
+				at91_twi_write(dev, AT91_TWI_ACR, acr);
+			}
+			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_CLEAR);
+		}
+	} else {
+		struct i2c_bus_recovery_info *rinfo =3D &dev->rinfo;
+
+		if (rinfo->get_sda && !(rinfo->get_sda(&dev->adapter))) {
+			dev_dbg(dev->dev,
+				"SDA is down; clear bus using gpio\n");
+			i2c_recover_bus(&dev->adapter);
+		}
 	}
=20
 	return ret;
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index eb335b71e775..80f77d523346 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -36,6 +36,7 @@
 #define	AT91_TWI_SVDIS		BIT(5)	/* Slave Transfer Disable */
 #define	AT91_TWI_QUICK		BIT(6)	/* SMBus quick command */
 #define	AT91_TWI_SWRST		BIT(7)	/* Software Reset */
+#define	AT91_TWI_CLEAR		BIT(15) /* Bus clear command */
 #define	AT91_TWI_ACMEN		BIT(16) /* Alternative Command Mode Enable */
 #define	AT91_TWI_ACMDIS		BIT(17) /* Alternative Command Mode Disable */
 #define	AT91_TWI_THRCLR		BIT(24) /* Transmit Holding Register Clear */
@@ -69,6 +70,8 @@
 #define	AT91_TWI_NACK		BIT(8)	/* Not Acknowledged */
 #define	AT91_TWI_EOSACC		BIT(11)	/* End Of Slave Access */
 #define	AT91_TWI_LOCK		BIT(23) /* TWI Lock due to Frame Errors */
+#define	AT91_TWI_SCL		BIT(24) /* TWI SCL status */
+#define	AT91_TWI_SDA		BIT(25) /* TWI SDA status */
=20
 #define	AT91_TWI_INT_MASK \
 	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK \
@@ -81,7 +84,8 @@
 #define	AT91_TWI_THR		0x0034	/* Transmit Holding Register */
=20
 #define	AT91_TWI_ACR		0x0040	/* Alternative Command Register */
-#define	AT91_TWI_ACR_DATAL(len)	((len) & 0xff)
+#define	AT91_TWI_ACR_DATAL_MASK	GENMASK(15, 0)
+#define	AT91_TWI_ACR_DATAL(len)	((len) & AT91_TWI_ACR_DATAL_MASK)
 #define	AT91_TWI_ACR_DIR	BIT(8)
=20
 #define AT91_TWI_FILTR		0x0044
@@ -118,6 +122,7 @@ struct at91_twi_pdata {
 	bool has_dig_filtr;
 	bool has_adv_dig_filtr;
 	bool has_ana_filtr;
+	bool has_clear_cmd;
 	struct at_dma_slave dma_slave;
 };
=20
--=20
2.20.1
