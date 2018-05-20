From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/7] media: netup_unidvb: don't check number of messages in the driver
Date: Sun, 20 May 2018 08:50:32 +0200
Message-ID: <20180520065039.7989-2-wsa@the-dreams.de>
References: <20180520065039.7989-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180520065039.7989-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Since commit 1eace8344c02 ("i2c: add param sanity check to
i2c_transfer()"), the I2C core does this check now. We can remove it
from drivers.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested.

 drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c b/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
index b13e319d24b7..5f1613aec93c 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c
@@ -214,11 +214,6 @@ static int netup_i2c_xfer(struct i2c_adapter *adap,
 	struct netup_i2c *i2c = i2c_get_adapdata(adap);
 	u16 reg;
 
-	if (num <= 0) {
-		dev_dbg(i2c->adap.dev.parent,
-			"%s(): num == %d\n", __func__, num);
-		return -EINVAL;
-	}
 	spin_lock_irqsave(&i2c->lock, flags);
 	if (i2c->state != STATE_DONE) {
 		dev_dbg(i2c->adap.dev.parent,
-- 
2.11.0
