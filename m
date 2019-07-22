From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] media: ir-kbd-i2c: prevent potential NULL pointer access
Date: Mon, 22 Jul 2019 19:26:31 +0200
Message-ID: <20190722172632.4402-2-wsa+renesas@sang-engineering.com>
References: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172632.4402-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

i2c_new_dummy() can fail returning a NULL pointer. The code does not
bail out in this case and the returned pointer is blindly used. Convert
to devm_i2c_new_dummy_device() which returns an ERR_PTR and also bail
out when failing the validity check.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/media/i2c/ir-kbd-i2c.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ir-kbd-i2c.c b/drivers/media/i2c/ir-kbd-i2c.c
index 876d7587a1da..f46717052efc 100644
--- a/drivers/media/i2c/ir-kbd-i2c.c
+++ b/drivers/media/i2c/ir-kbd-i2c.c
@@ -885,9 +885,12 @@ static int ir_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	INIT_DELAYED_WORK(&ir->work, ir_work);
 
 	if (probe_tx) {
-		ir->tx_c = i2c_new_dummy(client->adapter, 0x70);
-		if (!ir->tx_c) {
+		ir->tx_c = devm_i2c_new_dummy_device(&client->dev,
+						     client->adapter, 0x70);
+		if (IS_ERR(ir->tx_c)) {
 			dev_err(&client->dev, "failed to setup tx i2c address");
+			err = PTR_ERR(ir->tx_c);
+			goto err_out_free;
 		} else if (!zilog_init(ir)) {
 			ir->carrier = 38000;
 			ir->duty_cycle = 40;
@@ -904,9 +907,6 @@ static int ir_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return 0;
 
  err_out_free:
-	if (ir->tx_c)
-		i2c_unregister_device(ir->tx_c);
-
 	/* Only frees rc if it were allocated internally */
 	rc_free_device(rc);
 	return err;
@@ -919,9 +919,6 @@ static int ir_remove(struct i2c_client *client)
 	/* kill outstanding polls */
 	cancel_delayed_work_sync(&ir->work);
 
-	if (ir->tx_c)
-		i2c_unregister_device(ir->tx_c);
-
 	/* unregister device */
 	rc_unregister_device(ir->rc);
 
-- 
2.20.1
