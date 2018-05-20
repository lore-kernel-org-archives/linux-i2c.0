From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 6/7] media: tm6000: don't check number of messages in the driver
Date: Sun, 20 May 2018 08:50:37 +0200
Message-ID: <20180520065039.7989-7-wsa@the-dreams.de>
References: <20180520065039.7989-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180520065039.7989-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Since commit 1eace8344c02 ("i2c: add param sanity check to
i2c_transfer()"), the I2C core does this check now. We can remove it
from drivers.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested.

 drivers/media/usb/tm6000/tm6000-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/usb/tm6000/tm6000-i2c.c b/drivers/media/usb/tm6000/tm6000-i2c.c
index 659b63febf85..ccd1adf862b1 100644
--- a/drivers/media/usb/tm6000/tm6000-i2c.c
+++ b/drivers/media/usb/tm6000/tm6000-i2c.c
@@ -145,8 +145,6 @@ static int tm6000_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct tm6000_core *dev = i2c_adap->algo_data;
 	int addr, rc, i, byte;
 
-	if (num <= 0)
-		return 0;
 	for (i = 0; i < num; i++) {
 		addr = (msgs[i].addr << 1) & 0xff;
 		i2c_dprintk(2, "%s %s addr=0x%x len=%d:",
-- 
2.11.0
