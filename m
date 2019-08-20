From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] media: i2c: adv7511-v4l2: drop check because i2c_unregister_device() is NULL safe
Date: Tue, 20 Aug 2019 17:34:40 +0200
Message-ID: <20190820153441.7748-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only, buildbot is happy, too.

Please apply to your tree.

 drivers/media/i2c/adv7511-v4l2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/adv7511-v4l2.c b/drivers/media/i2c/adv7511-v4l2.c
index 7db94267bcab..55b3a9c12e43 100644
--- a/drivers/media/i2c/adv7511-v4l2.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -1940,8 +1940,7 @@ static int adv7511_probe(struct i2c_client *client, const struct i2c_device_id *
 err_unreg_pktmem:
 	i2c_unregister_device(state->i2c_pktmem);
 err_unreg_cec:
-	if (state->i2c_cec)
-		i2c_unregister_device(state->i2c_cec);
+	i2c_unregister_device(state->i2c_cec);
 err_unreg_edid:
 	i2c_unregister_device(state->i2c_edid);
 err_entity:
@@ -1967,8 +1966,7 @@ static int adv7511_remove(struct i2c_client *client)
 	adv7511_init_setup(sd);
 	cancel_delayed_work(&state->edid_handler);
 	i2c_unregister_device(state->i2c_edid);
-	if (state->i2c_cec)
-		i2c_unregister_device(state->i2c_cec);
+	i2c_unregister_device(state->i2c_cec);
 	i2c_unregister_device(state->i2c_pktmem);
 	destroy_workqueue(state->work_queue);
 	v4l2_device_unregister_subdev(sd);
-- 
2.20.1
