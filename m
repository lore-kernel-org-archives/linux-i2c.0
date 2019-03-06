From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 5/5] i2c: mux: pca9541: add support for PCA9641
Date: Wed, 6 Mar 2019 23:15:56 +0000
Message-ID: <20190306231521.29367-6-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ken Chen <chen.kenyy@inventec.com>, Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
List-Id: linux-i2c@vger.kernel.org

Heavily based on code from Ken Chen <chen.kenyy@inventec.com>.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/Kconfig           |   6 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c | 137 ++++++++++++++++++++++++++++++++=
++--
 2 files changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 52a4a922e7e6..8532841de5db 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -55,10 +55,10 @@ config I2C_MUX_LTC4306
 	  will be called i2c-mux-ltc4306.
=20
 config I2C_MUX_PCA9541
-	tristate "NXP PCA9541 I2C Master Selector"
+	tristate "NXP PCA9541/PCA9641 I2C Master Selectors"
 	help
-	  If you say yes here you get support for the NXP PCA9541
-	  I2C Master Selector.
+	  If you say yes here you get support for the NXP PCA9541/PCA9641
+	  I2C Master Selectors.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-pca9541.
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mu=
x-pca9541.c
index 5eb36e3223d5..5d4e0c92e978 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -1,5 +1,5 @@
 /*
- * I2C multiplexer driver for PCA9541 bus master selector
+ * I2C multiplexer driver for PCA9541/PCA9641 bus master selectors
  *
  * Copyright (c) 2010 Ericsson AB.
  *
@@ -28,8 +28,8 @@
 #include <linux/slab.h>
=20
 /*
- * The PCA9541 is a bus master selector. It supports two I2C masters conne=
cted
- * to a single slave bus.
+ * The PCA9541 and PCA9641 are bus master selector. They support two I2C m=
asters
+ * connected to a single slave bus.
  *
  * Before each bus transaction, a master has to acquire bus ownership. Aft=
er the
  * transaction is complete, bus ownership has to be released. This fits we=
ll
@@ -63,6 +63,33 @@
 #define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
 #define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
=20
+#define PCA9641_ID			0x00
+#define PCA9641_ID_MAGIC		0x38
+
+#define PCA9641_CONTROL			0x01
+#define PCA9641_STATUS			0x02
+#define PCA9641_TIME			0x03
+
+#define PCA9641_CTL_LOCK_REQ		BIT(0)
+#define PCA9641_CTL_LOCK_GRANT		BIT(1)
+#define PCA9641_CTL_BUS_CONNECT		BIT(2)
+#define PCA9641_CTL_BUS_INIT		BIT(3)
+#define PCA9641_CTL_SMBUS_SWRST		BIT(4)
+#define PCA9641_CTL_IDLE_TIMER_DIS	BIT(5)
+#define PCA9641_CTL_SMBUS_DIS		BIT(6)
+#define PCA9641_CTL_PRIORITY		BIT(7)
+
+#define PCA9641_STS_OTHER_LOCK		BIT(0)
+#define PCA9641_STS_BUS_INIT_FAIL	BIT(1)
+#define PCA9641_STS_BUS_HUNG		BIT(2)
+#define PCA9641_STS_MBOX_EMPTY		BIT(3)
+#define PCA9641_STS_MBOX_FULL		BIT(4)
+#define PCA9641_STS_TEST_INT		BIT(5)
+#define PCA9641_STS_SCL_IO		BIT(6)
+#define PCA9641_STS_SDA_IO		BIT(7)
+
+#define PCA9641_RES_TIME		0x03
+
 /* arbitration timeouts, in jiffies */
 #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
 #define ARB2_TIMEOUT	(HZ / 4)	/* 250 ms until acquisition failure */
@@ -73,6 +100,7 @@
=20
 enum chip_name {
 	pca9541,
+	pca9641,
 };
=20
 struct chip_desc {
@@ -102,6 +130,21 @@ static bool pca9541_busoff(int ctl)
 	return (ctl & PCA9541_BUSON) =3D=3D PCA9541_BUSON;
 }
=20
+static bool pca9641_lock_grant(int ctl)
+{
+	return !!(ctl & PCA9641_CTL_LOCK_GRANT);
+}
+
+static bool pca9641_other_lock(int sts)
+{
+	return !!(sts & PCA9641_STS_OTHER_LOCK);
+}
+
+static bool pca9641_busoff(int ctl, int sts)
+{
+	return !pca9641_lock_grant(ctl) && !pca9641_other_lock(sts);
+}
+
 /*
  * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
  * as they will try to lock the adapter a second time.
@@ -256,6 +299,86 @@ static int pca9541_arbitrate(struct i2c_client *client=
)
 	return 0;
 }
=20
+/* Release bus. */
+static void pca9641_release_bus(struct i2c_client *client)
+{
+	pca9541_reg_write(client, PCA9641_CONTROL, 0);
+}
+
+/*
+ * Channel arbitration
+ *
+ * Return values:
+ *  <0: error
+ *  0 : bus not acquired
+ *  1 : bus acquired
+ */
+static int pca9641_arbitrate(struct i2c_client *client)
+{
+	struct i2c_mux_core *muxc =3D i2c_get_clientdata(client);
+	struct pca9541 *data =3D i2c_mux_priv(muxc);
+	int reg_ctl, reg_sts;
+
+	reg_ctl =3D pca9541_reg_read(client, PCA9641_CONTROL);
+	if (reg_ctl < 0)
+		return reg_ctl;
+	reg_sts =3D pca9541_reg_read(client, PCA9641_STATUS);
+
+	if (pca9641_busoff(reg_ctl, reg_sts)) {
+		/*
+		 * Bus is off. Request ownership or turn it on unless
+		 * other master requested ownership.
+		 */
+		reg_ctl |=3D PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+		reg_ctl =3D pca9541_reg_read(client, PCA9641_CONTROL);
+
+		if (pca9641_lock_grant(reg_ctl)) {
+			/*
+			 * Other master did not request ownership,
+			 * or arbitration timeout expired. Take the bus.
+			 */
+			reg_ctl |=3D PCA9641_CTL_BUS_CONNECT |
+				PCA9641_CTL_LOCK_REQ;
+			pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+			data->select_timeout =3D SELECT_DELAY_SHORT;
+
+			return 1;
+		}
+
+		/*
+		 * Other master requested ownership.
+		 * Set extra long timeout to give it time to acquire it.
+		 */
+		data->select_timeout =3D SELECT_DELAY_LONG * 2;
+
+		return 0;
+	}
+
+	if (pca9641_lock_grant(reg_ctl)) {
+		/*
+		 * Bus is on, and we own it. We are done with acquisition.
+		 */
+		reg_ctl |=3D PCA9641_CTL_BUS_CONNECT | PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+
+		return 1;
+	}
+
+	if (pca9641_other_lock(reg_sts)) {
+		/*
+		 * Other master owns the bus.
+		 * If arbitration timeout has expired, force ownership.
+		 * Otherwise request it.
+		 */
+		data->select_timeout =3D SELECT_DELAY_LONG;
+		reg_ctl |=3D PCA9641_CTL_LOCK_REQ;
+		pca9541_reg_write(client, PCA9641_CONTROL, reg_ctl);
+	}
+
+	return 0;
+}
+
 static int pca9541_select_chan(struct i2c_mux_core *muxc, u32 chan)
 {
 	struct pca9541 *data =3D i2c_mux_priv(muxc);
@@ -295,10 +418,15 @@ static const struct chip_desc chips[] =3D {
 		.arbitrate =3D pca9541_arbitrate,
 		.release_bus =3D pca9541_release_bus,
 	},
+	[pca9641] =3D {
+		.arbitrate =3D pca9641_arbitrate,
+		.release_bus =3D pca9641_release_bus,
+	},
 };
=20
 static const struct i2c_device_id pca9541_id[] =3D {
 	{ "pca9541", pca9541 },
+	{ "pca9641", pca9641 },
 	{}
 };
=20
@@ -307,6 +435,7 @@ MODULE_DEVICE_TABLE(i2c, pca9541_id);
 #ifdef CONFIG_OF
 static const struct of_device_id pca9541_of_match[] =3D {
 	{ .compatible =3D "nxp,pca9541", .data =3D &chips[pca9541] },
+	{ .compatible =3D "nxp,pca9641", .data =3D &chips[pca9641] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pca9541_of_match);
@@ -392,5 +521,5 @@ static struct i2c_driver pca9541_driver =3D {
 module_i2c_driver(pca9541_driver);
=20
 MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
-MODULE_DESCRIPTION("PCA9541 I2C master selector driver");
+MODULE_DESCRIPTION("PCA9541/PCA9641 I2C master selector driver");
 MODULE_LICENSE("GPL v2");
--=20
2.11.0
