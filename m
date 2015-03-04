From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH] i2c: pca954x: Defer probing due to reset GPIO
Date: Wed,  4 Mar 2015 16:44:28 +0200
Message-ID: <1425480268-7322-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If a reset GPIO is specified but not available we must defer probing, as
the device could be held in reset. Use devm_gpiod_request_optional() to
handle this automatically.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 3d8f4fe..bea0d2d 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -204,9 +204,9 @@ static int pca954x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, data);
 
 	/* Get the mux out of reset if a reset GPIO is specified. */
-	gpio = devm_gpiod_get(&client->dev, "reset");
-	if (!IS_ERR(gpio))
-		gpiod_direction_output(gpio, 0);
+	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
 
 	/* Write the mux register at addr to verify
 	 * that the mux is in fact present. This also
-- 
Regards,

Laurent Pinchart
