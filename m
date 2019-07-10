From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 5/6] media: i2c: et8ek8: Convert to new i2c device probe()
Date: Wed, 10 Jul 2019 22:51:48 +0100
Message-ID: <20190710215149.9208-6-kieran.bingham+renesas@ideasonboard.com>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>, Mauro Carvalho Chehab <mchehab@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The I2C core framework provides a simplified probe framework from commit
b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").

This driver does not utilise the i2c_device_id table in the probe, so we can
easily convert it to utilise the simplfied i2c driver registration.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/i2c/et8ek8/et8ek8_driver.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index e6c06cb75d33..256acf73d5ea 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1396,8 +1396,7 @@ static int __maybe_unused et8ek8_resume(struct device *dev)
 	return __et8ek8_set_power(sensor, true);
 }
 
-static int et8ek8_probe(struct i2c_client *client,
-			const struct i2c_device_id *devid)
+static int et8ek8_probe(struct i2c_client *client)
 {
 	struct et8ek8_sensor *sensor;
 	struct device *dev = &client->dev;
@@ -1504,7 +1503,7 @@ static struct i2c_driver et8ek8_i2c_driver = {
 		.pm	= &et8ek8_pm_ops,
 		.of_match_table	= et8ek8_of_table,
 	},
-	.probe		= et8ek8_probe,
+	.probe_new	= et8ek8_probe,
 	.remove		= __exit_p(et8ek8_remove),
 	.id_table	= et8ek8_id_table,
 };
-- 
2.20.1
