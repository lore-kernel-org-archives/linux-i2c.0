From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3] i2c: davinci: Avoid sending to own address
Date: Tue, 09 Jun 2015 13:10:10 +0200
Message-ID: <5576C992.3060604@nokia.com>
References: <55534B7A.8070105@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55534B7A.8070105-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: Lawnick Michael 61283229 <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Sending a message to own address locks the controller up in very bizarre state,
it behaves as slave even if MDR register clearly states master. The controller
remains in this state until reset. To avoid unnecessary timeouts simply avoid
sending to own address. The controller cannot do this any way. Also, do not
enable AAS IRQ, as the slave mode is not supported by the driver and the only
possibility to trigger this IRQ is to send to own address.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
Changes in v3:
- return -EADDRNOTAVAIL instead of -EIO;
- emit a warning
Changes in v2:
- rebased on 110bc76729d4 of Linus's tree;

 drivers/i2c/busses/i2c-davinci.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index ab341aa..3d3ae52 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -41,8 +41,8 @@
 
 #define DAVINCI_I2C_TIMEOUT	(1*HZ)
 #define DAVINCI_I2C_MAX_TRIES	2
-#define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
-				 DAVINCI_I2C_IMR_SCD | \
+#define DAVINCI_I2C_OWN_ADDRESS	0x08
+#define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_SCD | \
 				 DAVINCI_I2C_IMR_ARDY | \
 				 DAVINCI_I2C_IMR_NACK | \
 				 DAVINCI_I2C_IMR_AL)
@@ -233,7 +233,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
 	/* Respond at reserved "SMBus Host" slave address" (and zero);
 	 * we seem to have no option to not respond...
 	 */
-	davinci_i2c_write_reg(dev, DAVINCI_I2C_OAR_REG, 0x08);
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_OAR_REG, DAVINCI_I2C_OWN_ADDRESS);
 
 	dev_dbg(dev->dev, "PSC  = %d\n",
 		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
@@ -386,6 +386,11 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	u16 w;
 	unsigned long time_left;
 
+	if (msg->addr == DAVINCI_I2C_OWN_ADDRESS) {
+		dev_warn(dev->dev, "transfer to own address aborted\n");
+		return -EADDRNOTAVAIL;
+	}
+
 	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
 	if (pdata->bus_delay)
 		udelay(pdata->bus_delay);
