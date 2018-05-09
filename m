From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] i2c: robotfuzz-osif: remove pointless local variable
Date: Wed,  9 May 2018 21:46:57 +0200
Message-ID: <20180509194658.29106-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Just use the value directly instead of assigning it to a
variable first. And then drop the unused variable.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-robotfuzz-osif.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 9c0f52b7ff7e..51d93b4b00f2 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -63,26 +63,23 @@ static int osif_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	struct osif_priv *priv = adapter->algo_data;
 	struct i2c_msg *pmsg;
 	int ret = 0;
-	int i, cmd;
+	int i;
 
 	for (i = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
 		if (pmsg->flags & I2C_M_RD) {
-			cmd = OSIFI2C_READ;
-
-			ret = osif_usb_read(adapter, cmd, pmsg->flags,
-					    pmsg->addr, pmsg->buf,
-					    pmsg->len);
+			ret = osif_usb_read(adapter, OSIFI2C_READ,
+					    pmsg->flags, pmsg->addr,
+					    pmsg->buf, pmsg->len);
 			if (ret != pmsg->len) {
 				dev_err(&adapter->dev, "failure reading data\n");
 				return -EREMOTEIO;
 			}
 		} else {
-			cmd = OSIFI2C_WRITE;
-
-			ret = osif_usb_write(adapter, cmd, pmsg->flags,
-					     pmsg->addr, pmsg->buf, pmsg->len);
+			ret = osif_usb_write(adapter, OSIFI2C_WRITE,
+					     pmsg->flags, pmsg->addr,
+					     pmsg->buf, pmsg->len);
 			if (ret != pmsg->len) {
 				dev_err(&adapter->dev, "failure writing data\n");
 				return -EREMOTEIO;
-- 
2.11.0
