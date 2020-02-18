From: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
Subject: [PATCH] i2c: xiic: Support disabling multi-master in DT
Date: Tue, 18 Feb 2020 13:58:07 +0000
Message-ID: <20200218135627.24739-1-ext-jaakko.laine@vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:50210
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726779AbgBRN6L (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 18 Feb 2020 08:58:11 -0500
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>

I2C master operating in multimaster mode can get stuck
indefinitely if I2C start is detected on bus, but no master
has a transaction going.

This is a weakness in I2C standard, which defines no way
to recover, since all masters are indefinitely disallowed
from interrupting the currently operating master. A start
condition can be created for example by an electromagnetic
discharge applied near physical I2C lines. Or a already
operating master could get reset immediately after sending
a start.

If it is known during device tree creation that only a single
I2C master will be present on the bus, this deadlock of the
I2C bus could be avoided in the driver by ignoring the
bus_is_busy register of the xiic, since bus can never be
reserved by any other master.

This patch adds this support for detecting multi-master flag
in device tree and when not provided, improves I2C reliability
by ignoring the therefore unnecessary xiic bus_is_busy register.

Error can be reproduced by pulling I2C SDA -line temporarily low
by shorting it to ground, while linux I2C master is operating on
it using the xiic driver. The application using the bus will
start receiving linux error code 16: "Device or resource busy"
indefinitely:

kernel: pca953x 0-0020: failed writing register
app: Error writing file, error: 16

With multi-master disabled device will instead receive error
code 5: "I/O error" while SDA is grounded, but recover normal
operation once short is removed.

kernel: pca953x 0-0020: failed reading register
app: Error reading file, error: 5

Signed-off-by: Jaakko Laine <ext-jaakko.laine@vaisala.com>
---

Applies against Linux 5.6-rc1 from master in
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git

I would like to point out that that since this patch disables
multimaster mode based on the standard I2C multimaster property
in device tree (as it propably should) and since the driver has
previously supported multimaster even when this property doesn't
exist in device tree, there is a possible backwards
compatibility issue:

If there are devices relying on the multimaster mode to work
without defining the property in device tree, their I2C bus
might not work without issues anymore after this patch, since
the driver will asume it is the only master on bus and could
therefore interrupt the communication of some other master on
same bus.

Please suggest some alternative fix if this is not acceptable
as is. On the other hand supporting multimaster even on a bus
with only a single master does currently cause some
reliability issues since the bus can get indefinitely stuck.
I don't think there exists a I2C protocol compatible way to
resolve the deadlock on multimaster bus.

 drivers/i2c/busses/i2c-xiic.c | 52 +++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 90c1c362394d..37f8d6ee0577 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -46,19 +46,20 @@ enum xiic_endian {
=20
 /**
  * struct xiic_i2c - Internal representation of the XIIC I2C bus
- * @dev:	Pointer to device structure
- * @base:	Memory base of the HW registers
- * @wait:	Wait queue for callers
- * @adap:	Kernel adapter representation
- * @tx_msg:	Messages from above to be sent
- * @lock:	Mutual exclusion
- * @tx_pos:	Current pos in TX message
- * @nmsgs:	Number of messages in tx_msg
- * @state:	See STATE_
- * @rx_msg:	Current RX message
- * @rx_pos:	Position within current RX message
- * @endianness: big/little-endian byte order
- * @clk:	Pointer to AXI4-lite input clock
+ * @dev:		Pointer to device structure
+ * @base:		Memory base of the HW registers
+ * @wait:		Wait queue for callers
+ * @adap:		Kernel adapter representation
+ * @tx_msg:		Messages from above to be sent
+ * @lock:		Mutual exclusion
+ * @tx_pos:		Current pos in TX message
+ * @nmsgs:		Number of messages in tx_msg
+ * @state:		See STATE_
+ * @rx_msg:		Current RX message
+ * @rx_pos:		Position within current RX message
+ * @endianness:		big/little-endian byte order
+ * @multimaster:	Indicates bus has multiple masters
+ * @clk:		Pointer to AXI4-lite input clock
  */
 struct xiic_i2c {
 	struct device		*dev;
@@ -73,6 +74,7 @@ struct xiic_i2c {
 	struct i2c_msg		*rx_msg;
 	int			rx_pos;
 	enum xiic_endian	endianness;
+	bool			multimaster;
 	struct clk *clk;
 };
=20
@@ -521,19 +523,26 @@ static int xiic_bus_busy(struct xiic_i2c *i2c)
 static int xiic_busy(struct xiic_i2c *i2c)
 {
 	int tries =3D 3;
-	int err;
+	int err =3D 0;
=20
 	if (i2c->tx_msg)
 		return -EBUSY;
=20
-	/* for instance if previous transfer was terminated due to TX error
-	 * it might be that the bus is on it's way to become available
-	 * give it at most 3 ms to wake
+	/* In single master mode bus can only be busy, when in use by this
+	 * driver. If the register indicates bus being busy for some reason we
+	 * should ignore it, since bus will never be released and i2c will be
+	 * stuck forever.
 	 */
-	err =3D xiic_bus_busy(i2c);
-	while (err && tries--) {
-		msleep(1);
+	if (i2c->multimaster) {
+		/* for instance if previous transfer was terminated due to TX
+		 * error it might be that the bus is on it's way to become
+		 * available give it at most 3 ms to wake
+		 */
 		err =3D xiic_bus_busy(i2c);
+		while (err && tries--) {
+			msleep(1);
+			err =3D xiic_bus_busy(i2c);
+		}
 	}
=20
 	return err;
@@ -811,6 +820,9 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		goto err_clk_dis;
 	}
=20
+	i2c->multimaster =3D
+		of_property_read_bool(pdev->dev.of_node, "multi-master");
+
 	/*
 	 * Detect endianness
 	 * Try to reset the TX FIFO. Then check the EMPTY flag. If it is not
--=20
2.19.1
