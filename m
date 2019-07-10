From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 3/6] media: i2c: smiapp: Convert to new i2c device probe()
Date: Wed, 10 Jul 2019 22:51:46 +0100
Message-ID: <20190710215149.9208-4-kieran.bingham+renesas@ideasonboard.com>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Sakari Ailus <sakari.ailus@iki.fi>, Mauro Carvalho Chehab <mchehab@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The I2C core framework provides a simplified probe framework from commit
b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").

This driver does not utilise the i2c_device_id table in the probe, so we can
easily convert it to utilise the simplfied i2c driver registration.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/i2c/smiapp/smiapp-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index 2d78e846d822..9adf8e034e7d 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -2847,8 +2847,7 @@ static struct smiapp_hwconfig *smiapp_get_hwconfig(struct device *dev)
 	return NULL;
 }
 
-static int smiapp_probe(struct i2c_client *client,
-			const struct i2c_device_id *devid)
+static int smiapp_probe(struct i2c_client *client)
 {
 	struct smiapp_sensor *sensor;
 	struct smiapp_hwconfig *hwcfg = smiapp_get_hwconfig(&client->dev);
@@ -3172,7 +3171,7 @@ static struct i2c_driver smiapp_i2c_driver = {
 		.name = SMIAPP_NAME,
 		.pm = &smiapp_pm_ops,
 	},
-	.probe	= smiapp_probe,
+	.probe_new = smiapp_probe,
 	.remove	= smiapp_remove,
 	.id_table = smiapp_id_table,
 };
-- 
2.20.1
