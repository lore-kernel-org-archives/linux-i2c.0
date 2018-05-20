From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/2] i2c: ibm_iic: don't check number of messages in the driver
Date: Sun, 20 May 2018 08:50:33 +0200
Message-ID: <20180520065035.7920-2-wsa@the-dreams.de>
References: <20180520065035.7920-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180520065035.7920-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Since commit 1eace8344c02 ("i2c: add param sanity check to
i2c_transfer()"), the I2C core does this check now. We can remove it
from drivers.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested.

 drivers/i2c/busses/i2c-ibm_iic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 961c5f42d956..6f6e1dfe7cce 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -561,9 +561,6 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
 
-	if (!num)
-		return 0;
-
 	/* Check the sanity of the passed messages.
 	 * Uhh, generic i2c layer is more suitable place for such code...
 	 */
-- 
2.11.0
