From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers
Date: Wed, 20 Jun 2018 11:43:23 +0200
Message-ID: <20180620094323.8447-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

If DMA safe memory was allocated, but the subsequent I2C transfer
fails the memory is leaked. Plug this leak.

Fixes: 8a77821e74d6 ("i2c: smbus: use DMA safe buffers for emulated SMBus transactions")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-core-smbus.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index f3f683041e7f..51970bae3c4a 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -465,15 +465,18 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 
 	status = i2c_transfer(adapter, msg, num);
 	if (status < 0)
-		return status;
-	if (status != num)
-		return -EIO;
+		goto cleanup;
+	if (status != num) {
+		status = -EIO;
+		goto cleanup;
+	}
+	status = 0;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
 		status = i2c_smbus_check_pec(partial_pec, &msg[num-1]);
 		if (status < 0)
-			return status;
+			goto cleanup;
 	}
 
 	if (read_write == I2C_SMBUS_READ)
@@ -499,12 +502,13 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
 			break;
 		}
 
+cleanup:
 	if (msg[0].flags & I2C_M_DMA_SAFE)
 		kfree(msg[0].buf);
 	if (msg[1].flags & I2C_M_DMA_SAFE)
 		kfree(msg[1].buf);
 
-	return 0;
+	return status;
 }
 
 /**
-- 
2.11.0
