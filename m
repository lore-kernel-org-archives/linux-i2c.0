From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] media: i2c: tda1997x: prevent potential NULL pointer access
Date: Fri,  9 Aug 2019 18:52:15 +0200
Message-ID: <20190809165215.10605-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Tim Harvey <tharvey@gateworks.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

i2c_new_dummy() can fail returning a NULL pointer. This is not checked
and the returned pointer is blindly used. Convert to
devm_i2c_new_dummy_client() which returns an ERR_PTR and also add a
validity check. Using devm_* here also fixes a leak because the dummy
client was not released in the probe error path.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I didn't add a stable tag becase devm_i2c_new_dummy_device() is new in
the kernel. So, a backport would need to add a check for the old API.

I used devm_ here because the driver uses it already in other places,
too (despite media not favoring devm?).

 drivers/media/i2c/tda1997x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index a62ede096636..5e68182001ec 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -2691,7 +2691,13 @@ static int tda1997x_probe(struct i2c_client *client,
 	}
 
 	ret = 0x34 + ((io_read(sd, REG_SLAVE_ADDR)>>4) & 0x03);
-	state->client_cec = i2c_new_dummy(client->adapter, ret);
+	state->client_cec = devm_i2c_new_dummy_device(&client->dev,
+						      client->adapter, ret);
+	if (IS_ERR(state->client_cec)) {
+		ret = PTR_ERR(state->client_cec);
+		goto err_free_mutex;
+	}
+
 	v4l_info(client, "CEC slave address 0x%02x\n", ret);
 
 	ret = tda1997x_core_init(sd);
@@ -2798,7 +2804,6 @@ static int tda1997x_remove(struct i2c_client *client)
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(&state->hdl);
 	regulator_bulk_disable(TDA1997X_NUM_SUPPLIES, state->supplies);
-	i2c_unregister_device(state->client_cec);
 	cancel_delayed_work(&state->delayed_work_enable_hpd);
 	mutex_destroy(&state->page_lock);
 	mutex_destroy(&state->lock);
-- 
2.20.1
