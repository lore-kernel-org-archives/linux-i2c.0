From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 2/6] media: radio: si470x: Convert to new i2c device probe()
Date: Wed, 10 Jul 2019 22:51:45 +0100
Message-ID: <20190710215149.9208-3-kieran.bingham+renesas@ideasonboard.com>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The I2C core framework provides a simplified probe framework from commit
b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").

This driver does not utilise the i2c_device_id table in the probe, so we can
easily convert it to utilise the simplfied i2c driver registration.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/media/radio/si470x/radio-si470x-i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c
index 7d53422b3b56..7541698a0be1 100644
--- a/drivers/media/radio/si470x/radio-si470x-i2c.c
+++ b/drivers/media/radio/si470x/radio-si470x-i2c.c
@@ -330,8 +330,7 @@ static irqreturn_t si470x_i2c_interrupt(int irq, void *dev_id)
 /*
  * si470x_i2c_probe - probe for the device
  */
-static int si470x_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int si470x_i2c_probe(struct i2c_client *client)
 {
 	struct si470x_device *radio;
 	int retval = 0;
@@ -544,7 +543,7 @@ static struct i2c_driver si470x_i2c_driver = {
 		.pm		= &si470x_i2c_pm,
 #endif
 	},
-	.probe			= si470x_i2c_probe,
+	.probe_new		= si470x_i2c_probe,
 	.remove			= si470x_i2c_remove,
 	.id_table		= si470x_i2c_id,
 };
-- 
2.20.1
