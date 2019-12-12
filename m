From: christoph.muellner@theobroma-systems.com
Subject: [PATCH] i2c: tiny-usb: Correct I2C fault codes.
Date: Thu, 12 Dec 2019 01:12:50 +0100
Message-ID: <20191212001251.85344-1-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@theobroma-systems.com>, Till Harbaum <till@harbaum.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Christoph Müllner <christoph.muellner@theobroma-systems.com>

This patch changes the I2C fault codes according to the specified
values in Documentation/i2c/fault-codes.

Signed-off-by: Christoph Müllner <christoph.muellner@theobroma-systems.com>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 43e3603489ee..7279ca0eaa2d 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -84,7 +84,7 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				     pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure reading data\n");
-				ret = -EREMOTEIO;
+				ret = -EIO;
 				goto out;
 			}
 		} else {
@@ -94,7 +94,7 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				      pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure writing data\n");
-				ret = -EREMOTEIO;
+				ret = -EIO;
 				goto out;
 			}
 		}
@@ -102,13 +102,13 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 		/* read status */
 		if (usb_read(adapter, CMD_GET_STATUS, 0, 0, pstatus, 1) != 1) {
 			dev_err(&adapter->dev, "failure reading status\n");
-			ret = -EREMOTEIO;
+			ret = -EIO;
 			goto out;
 		}
 
 		dev_dbg(&adapter->dev, "  status = %d\n", *pstatus);
 		if (*pstatus == STATUS_ADDRESS_NAK) {
-			ret = -EREMOTEIO;
+			ret = -ENXIO;
 			goto out;
 		}
 	}
-- 
2.23.0
