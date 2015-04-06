From: <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 2/3] i2c: davinci: use bus recovery infrastructure
Date: Mon,  6 Apr 2015 15:38:40 +0300
Message-ID: <1428323921-25832-3-git-send-email-grygorii.strashko@linaro.org>
References: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428323921-25832-1-git-send-email-grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

This patch converts Davinci I2C driver to use I2C bus recovery
infrastructure, introduced by commit 5f9296ba21b3 ("i2c: Add
bus recovery infrastructure").

The i2c_bus_recovery_info is configured for Davinci I2C adapter
only in case scl_pin is provided in platform data.

As the controller must be held in reset while doing so, the
recovery routine must re-init the controller. Since this was already
being done after each call to i2c_recover_bus, move those calls into
the recovery_prepare/unprepare routines and as well.

CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
CC: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c | 77 +++++++++++++++++++-------------=
--------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-=
davinci.c
index 120a4ef..54819fb 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -129,43 +129,6 @@ static inline u16 davinci_i2c_read_reg(struct davi=
nci_i2c_dev *i2c_dev, int reg)
 	return readw_relaxed(i2c_dev->base + reg);
 }
=20
-/* Generate a pulse on the i2c clock pin. */
-static void davinci_i2c_clock_pulse(unsigned int scl_pin)
-{
-	u16 i;
-
-	if (scl_pin) {
-		/* Send high and low on the SCL line */
-		for (i =3D 0; i < 9; i++) {
-			gpio_set_value(scl_pin, 0);
-			udelay(20);
-			gpio_set_value(scl_pin, 1);
-			udelay(20);
-		}
-	}
-}
-
-/* This routine does i2c bus recovery as specified in the
- * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
- */
-static void davinci_i2c_recover_bus(struct davinci_i2c_dev *dev)
-{
-	u32 flag =3D 0;
-	struct davinci_i2c_platform_data *pdata =3D dev->pdata;
-
-	dev_err(dev->dev, "initiating i2c bus recovery\n");
-	/* Send NACK to the slave */
-	flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-	flag |=3D  DAVINCI_I2C_MDR_NACK;
-	/* write the data into mode register */
-	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-	davinci_i2c_clock_pulse(pdata->scl_pin);
-	/* Send STOP */
-	flag =3D davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
-	flag |=3D DAVINCI_I2C_MDR_STP;
-	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-}
-
 static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *i2c_=
dev,
 								int val)
 {
@@ -263,6 +226,34 @@ static int i2c_davinci_init(struct davinci_i2c_dev=
 *dev)
 }
=20
 /*
+ * This routine does i2c bus recovery by using i2c_generic_gpio_recove=
ry
+ * which is provided by I2C Bus recovery infrastructure.
+ */
+static void davinci_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
+
+	/* Disable interrupts */
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, 0);
+
+	/* put I2C into reset */
+	davinci_i2c_reset_ctrl(dev, 0);
+}
+
+static void davinci_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct davinci_i2c_dev *dev =3D i2c_get_adapdata(adap);
+
+	i2c_davinci_init(dev);
+}
+
+static struct i2c_bus_recovery_info davinci_i2c_gpio_recovery_info =3D=
 {
+	.recover_bus =3D i2c_generic_gpio_recovery,
+	.prepare_recovery =3D davinci_i2c_prepare_recovery,
+	.unprepare_recovery =3D davinci_i2c_unprepare_recovery,
+};
+
+/*
  * Waiting for bus not busy
  */
 static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
@@ -282,8 +273,7 @@ static int i2c_davinci_wait_bus_not_busy(struct dav=
inci_i2c_dev *dev,
 				return -ETIMEDOUT;
 			} else {
 				to_cnt =3D 0;
-				davinci_i2c_recover_bus(dev);
-				i2c_davinci_init(dev);
+				i2c_recover_bus(&dev->adapter);
 			}
 		}
 		if (allow_sleep)
@@ -372,8 +362,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, stru=
ct i2c_msg *msg, int stop)
 						dev->adapter.timeout);
 	if (!time_left) {
 		dev_err(dev->dev, "controller timed out\n");
-		davinci_i2c_recover_bus(dev);
-		i2c_davinci_init(dev);
+		i2c_recover_bus(adap);
 		dev->buf_len =3D 0;
 		return -ETIMEDOUT;
 	}
@@ -712,6 +701,12 @@ static int davinci_i2c_probe(struct platform_devic=
e *pdev)
 	adap->timeout =3D DAVINCI_I2C_TIMEOUT;
 	adap->dev.of_node =3D pdev->dev.of_node;
=20
+	if (dev->pdata->scl_pin) {
+		adap->bus_recovery_info =3D &davinci_i2c_gpio_recovery_info;
+		adap->bus_recovery_info->scl_gpio =3D dev->pdata->scl_pin;
+		adap->bus_recovery_info->sda_gpio =3D dev->pdata->sda_pin;
+	}
+
 	adap->nr =3D pdev->id;
 	r =3D i2c_add_numbered_adapter(adap);
 	if (r) {
--=20
1.9.1
