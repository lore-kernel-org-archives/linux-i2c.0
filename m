From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 3/4] i2c: mux: pca9541: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:32 +0200
Message-ID: <20180417143233.25145-4-peda@axentia.se>
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
 drivers/i2c/muxes/i2c-mux-pca9541.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..f61c5de29e2f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -330,8 +330,7 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
 /*
  * I2C init/probing/exit functions
  */
-static int pca9541_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int pca9541_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
@@ -390,7 +389,7 @@ static struct i2c_driver pca9541_driver = {
 		   .name = "pca9541",
 		   .of_match_table = of_match_ptr(pca9541_of_match),
 		   },
-	.probe = pca9541_probe,
+	.probe_new = pca9541_probe,
 	.remove = pca9541_remove,
 	.id_table = pca9541_id,
 };
-- 
2.11.0
