From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/3] i2c: mux: pca954x: merge calls to of_match_device and of_device_get_match_data
Date: Mon, 21 May 2018 11:49:08 +0200
Message-ID: <1526896150-27134-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Drop call to of_match_device, which is subsumed by the subsequent
call to of_device_get_match_data.  The code becomes simpler, and a
temporary variable can be dropped.

The semantic match that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
local idexpression match;
identifier i;
expression x, dev, e, e1;
@@
-        match@i = of_match_device(x, dev);
-        if (match) e = of_device_get_match_data(dev);
-        else e = e1;
+        e = of_device_get_match_data(dev);
+        if (!e) e = e1;

@@
identifier r.i;
@@
- const struct of_device_id *i;
... when != i
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/i2c/muxes/i2c-mux-pca954x.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 09bafd3..ced840f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -373,7 +373,6 @@ static int pca954x_probe(struct i2c_client *client,
 	int num, force, class;
 	struct i2c_mux_core *muxc;
 	struct pca954x *data;
-	const struct of_device_id *match;
 	int ret;
 
 	if (!i2c_check_functionality(adap, I2C_FUNC_SMBUS_BYTE))
@@ -394,10 +393,8 @@ static int pca954x_probe(struct i2c_client *client,
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
-	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
-	if (match)
-		data->chip = of_device_get_match_data(&client->dev);
-	else
+	data->chip = of_device_get_match_data(&client->dev);
+	if (!data->chip)
 		data->chip = &chips[id->driver_data];
 
 	if (data->chip->id.manufacturer_id != I2C_DEVICE_ID_NONE) {
