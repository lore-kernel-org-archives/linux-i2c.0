From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 1/6] media: radio: si4713: Convert to new i2c device probe()
Date: Wed, 10 Jul 2019 22:51:44 +0100
Message-ID: <20190710215149.9208-2-kieran.bingham+renesas@ideasonboard.com>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Eduardo Valentin <edubezval@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The I2C core framework provides a simplified probe framework from commit
b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").

This driver does not utilise the i2c_device_id table in the probe, so we can
easily convert it to utilise the simplfied i2c driver registration.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/radio/si4713/si4713.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/radio/si4713/si4713.c b/drivers/media/radio/si4713/si4713.c
index 7d97de2fa56c..7f3aee495ed3 100644
--- a/drivers/media/radio/si4713/si4713.c
+++ b/drivers/media/radio/si4713/si4713.c
@@ -1427,8 +1427,7 @@ static const struct v4l2_ctrl_config si4713_alt_freqs_ctrl = {
  * I2C driver interface
  */
 /* si4713_probe - probe for the device */
-static int si4713_probe(struct i2c_client *client,
-					const struct i2c_device_id *id)
+static int si4713_probe(struct i2c_client *client)
 {
 	struct si4713_device *sdev;
 	struct v4l2_ctrl_handler *hdl;
@@ -1660,7 +1659,7 @@ static struct i2c_driver si4713_i2c_driver = {
 		.name	= "si4713",
 		.of_match_table = of_match_ptr(si4713_of_match),
 	},
-	.probe		= si4713_probe,
+	.probe_new	= si4713_probe,
 	.remove         = si4713_remove,
 	.id_table       = si4713_id,
 };
-- 
2.20.1
