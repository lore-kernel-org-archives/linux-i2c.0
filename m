From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 4/6] media: i2c: s5c73m3: Convert to new i2c device probe()
Date: Wed, 10 Jul 2019 22:51:47 +0100
Message-ID: <20190710215149.9208-5-kieran.bingham+renesas@ideasonboard.com>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The I2C core framework provides a simplified probe framework from commit
b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").

This driver does not utilise the i2c_device_id table in the probe, so we can
easily convert it to utilise the simplfied i2c driver registration.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index 7633aebd8c06..5b4c4a3547c9 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -1650,8 +1650,7 @@ static int s5c73m3_get_platform_data(struct s5c73m3 *state)
 	return 0;
 }
 
-static int s5c73m3_probe(struct i2c_client *client,
-				const struct i2c_device_id *id)
+static int s5c73m3_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct v4l2_subdev *sd;
@@ -1806,7 +1805,7 @@ static struct i2c_driver s5c73m3_i2c_driver = {
 		.of_match_table = of_match_ptr(s5c73m3_of_match),
 		.name	= DRIVER_NAME,
 	},
-	.probe		= s5c73m3_probe,
+	.probe_new	= s5c73m3_probe,
 	.remove		= s5c73m3_remove,
 	.id_table	= s5c73m3_id,
 };
-- 
2.20.1
