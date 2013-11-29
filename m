From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 2/4] i2c: pca954x: Use devm_kzalloc managed allocator
Date: Fri, 29 Nov 2013 01:51:23 +0100
Message-ID: <1385686285-23780-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1385686285-23780-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385686285-23780-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This simplifies error and removal paths.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index ce740f1..2880c38 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -187,16 +187,14 @@ static int pca954x_probe(struct i2c_client *client,
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
 	int num, force, class;
 	struct pca954x *data;
-	int ret = -ENODEV;
+	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
-		goto err;
+		return -ENODEV;
 
-	data = kzalloc(sizeof(struct pca954x), GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	data = devm_kzalloc(&client->dev, sizeof(struct pca954x), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	i2c_set_clientdata(client, data);
 
@@ -206,7 +204,7 @@ static int pca954x_probe(struct i2c_client *client,
 	 */
 	if (i2c_smbus_write_byte(client, 0) < 0) {
 		dev_warn(&client->dev, "probe failed\n");
-		goto exit_free;
+		return -ENODEV;
 	}
 
 	data->type = id->driver_data;
@@ -251,9 +249,6 @@ static int pca954x_probe(struct i2c_client *client,
 virt_reg_failed:
 	for (num--; num >= 0; num--)
 		i2c_del_mux_adapter(data->virt_adaps[num]);
-exit_free:
-	kfree(data);
-err:
 	return ret;
 }
 
@@ -269,7 +264,6 @@ static int pca954x_remove(struct i2c_client *client)
 			data->virt_adaps[i] = NULL;
 		}
 
-	kfree(data);
 	return 0;
 }
 
-- 
1.8.3.2
