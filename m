From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 4/4] i2c: mux: pca954x: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:33 +0200
Message-ID: <20180417143233.25145-5-peda@axentia.se>
References: <20180417143233.25145-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417143233.25145-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Michael Hennerich <michael.hennerich@analog.com>, Wolfram Sang <wsa@the-dreams.de>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index fbb84c7ef282..f3f925ea6472 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -337,8 +337,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 /*
  * I2C init/probing/exit functions
  */
-static int pca954x_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int pca954x_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
@@ -382,7 +381,7 @@ static int pca954x_probe(struct i2c_client *client,
 	if (match)
 		data->chip = of_device_get_match_data(&client->dev);
 	else
-		data->chip = &chips[id->driver_data];
+		data->chip = &chips[i2c_match_id(pca954x_id, client)->driver_data];
 
 	data->last_chan = 0;		   /* force the first selection */
 
@@ -466,7 +465,7 @@ static struct i2c_driver pca954x_driver = {
 		.pm	= &pca954x_pm,
 		.of_match_table = of_match_ptr(pca954x_of_match),
 	},
-	.probe		= pca954x_probe,
+	.probe_new	= pca954x_probe,
 	.remove		= pca954x_remove,
 	.id_table	= pca954x_id,
 };
-- 
2.11.0
