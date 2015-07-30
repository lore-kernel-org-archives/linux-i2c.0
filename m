From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 09/27] i2c: core: Export I2C module alias information in dummy driver
Date: Thu, 30 Jul 2015 18:18:34 +0200
Message-ID: <1438273132-20926-10-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So the driver needs to export the I2C table and this
be built into the module or udev won't have the necessary information
to auto load the correct module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/i2c/i2c-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e6d4935161e4..92dddfeb3f39 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1023,6 +1023,7 @@ static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", 0 },
 	{ },
 };
+MODULE_DEVICE_TABLE(i2c, dummy_id);
 
 static int dummy_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
-- 
2.4.3
