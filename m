From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/8] media: dvb-frontends: cxd2820r_core: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:25:55 +0200
Message-ID: <20190722172604.3572-2-wsa+renesas@sang-engineering.com>
References: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172604.3572-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Antti Palosaari <crope@iki.fi>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/media/dvb-frontends/cxd2820r_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/cxd2820r_core.c b/drivers/media/dvb-frontends/cxd2820r_core.c
index 1f006f8e8cc2..5280ba4085e4 100644
--- a/drivers/media/dvb-frontends/cxd2820r_core.c
+++ b/drivers/media/dvb-frontends/cxd2820r_core.c
@@ -632,9 +632,9 @@ static int cxd2820r_probe(struct i2c_client *client,
 	 * one dummy I2C client in in order to get own I2C client for each
 	 * register bank.
 	 */
-	priv->client[1] = i2c_new_dummy(client->adapter, client->addr | (1 << 1));
-	if (!priv->client[1]) {
-		ret = -ENODEV;
+	priv->client[1] = i2c_new_dummy_device(client->adapter, client->addr | (1 << 1));
+	if (IS_ERR(priv->client[1])) {
+		ret = PTR_ERR(priv->client[1]);
 		dev_err(&client->dev, "I2C registration failed\n");
 		if (ret)
 			goto err_regmap_0_regmap_exit;
-- 
2.20.1
