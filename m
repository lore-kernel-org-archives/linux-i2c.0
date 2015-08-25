From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [RESEND PATCH 1/7] i2c: core: Export I2C module alias information in dummy driver
Date: Tue, 25 Aug 2015 08:31:11 +0200
Message-ID: <1440484277-32675-2-git-send-email-javier@osg.samsung.com>
References: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The I2C core always reports the MODALIAS uevent as "i2c:<modalias>"
regardless of the mechanism that was used to register the device
(i.e: OF or board code) and the table that is used later to match
the driver with the device (i.e: I2C id table or OF match table).

So drivers needs to export the I2C id table and this be built into
the module or udev won't have the necessary information to autoload
the needed driver module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/i2c/i2c-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a6780289c61d..46536834920c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1041,6 +1041,7 @@ static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", 0 },
 	{ },
 };
+MODULE_DEVICE_TABLE(i2c, dummy_id);
 
 static int dummy_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
-- 
2.4.3
