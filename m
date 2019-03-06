From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/5] i2c: mux: pca9541: namespace cleanup
Date: Wed, 6 Mar 2019 23:15:40 +0000
Message-ID: <20190306231521.29367-3-peda@axentia.se>
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

In preparation for PCA9641 support, convert the mybus and busoff macros
to functions, and in the process prefix them with pca9541_. Also prefix
remaining chip specific macros with PCA9541_.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mu=
x-pca9541.c
index 30cabf482985..28f46450f4b4 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -59,10 +59,8 @@
 #define PCA9541_ISTAT_MYTEST	BIT(6)
 #define PCA9541_ISTAT_NMYTEST	BIT(7)
=20
-#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
-#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
-#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) =3D=3D MYBUS)
-#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) =3D=3D BUSON)
+#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
+#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
=20
 /* arbitration timeouts, in jiffies */
 #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
@@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] =3D =
{
 MODULE_DEVICE_TABLE(of, pca9541_of_match);
 #endif
=20
+static bool pca9541_mybus(int ctl)
+{
+	if (!(ctl & PCA9541_MYBUS))
+		return true;
+	return (ctl & PCA9541_MYBUS) =3D=3D PCA9541_MYBUS;
+}
+
+static bool pca9541_busoff(int ctl)
+{
+	if (!(ctl & PCA9541_BUSON))
+		return true;
+	return (ctl & PCA9541_BUSON) =3D=3D PCA9541_BUSON;
+}
+
 /*
  * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
  * as they will try to lock the adapter a second time.
@@ -134,7 +146,7 @@ static void pca9541_release_bus(struct i2c_client *clie=
nt)
 	int reg;
=20
 	reg =3D pca9541_reg_read(client, PCA9541_CONTROL);
-	if (reg >=3D 0 && !busoff(reg) && mybus(reg))
+	if (reg >=3D 0 && !pca9541_busoff(reg) && pca9541_mybus(reg))
 		pca9541_reg_write(client, PCA9541_CONTROL,
 				  (reg & PCA9541_CTL_NBUSON) >> 1);
 }
@@ -186,7 +198,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 	if (reg < 0)
 		return reg;
=20
-	if (busoff(reg)) {
+	if (pca9541_busoff(reg)) {
 		int istat;
 		/*
 		 * Bus is off. Request ownership or turn it on unless
@@ -211,7 +223,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 			 */
 			data->select_timeout =3D SELECT_DELAY_LONG * 2;
 		}
-	} else if (mybus(reg)) {
+	} else if (pca9541_mybus(reg)) {
 		/*
 		 * Bus is on, and we own it. We are done with acquisition.
 		 * Reset NTESTON and BUSINIT, then return success.
--=20
2.11.0
