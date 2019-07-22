From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/8] media: dvb-frontends: mn88472: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:25:57 +0200
Message-ID: <20190722172604.3572-4-wsa+renesas@sang-engineering.com>
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

 drivers/media/dvb-frontends/mn88472.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/dvb-frontends/mn88472.c b/drivers/media/dvb-frontends/mn88472.c
index 731b44b9b74c..ef8094aa97df 100644
--- a/drivers/media/dvb-frontends/mn88472.c
+++ b/drivers/media/dvb-frontends/mn88472.c
@@ -612,9 +612,9 @@ static int mn88472_probe(struct i2c_client *client,
 	 * Also, register bank 2 do not support sequential I/O. Only single
 	 * register write or read is allowed to that bank.
 	 */
-	dev->client[1] = i2c_new_dummy(client->adapter, 0x1a);
-	if (!dev->client[1]) {
-		ret = -ENODEV;
+	dev->client[1] = i2c_new_dummy_device(client->adapter, 0x1a);
+	if (IS_ERR(dev->client[1])) {
+		ret = PTR_ERR(dev->client[1]);
 		dev_err(&client->dev, "I2C registration failed\n");
 		if (ret)
 			goto err_regmap_0_regmap_exit;
@@ -626,9 +626,9 @@ static int mn88472_probe(struct i2c_client *client,
 	}
 	i2c_set_clientdata(dev->client[1], dev);
 
-	dev->client[2] = i2c_new_dummy(client->adapter, 0x1c);
-	if (!dev->client[2]) {
-		ret = -ENODEV;
+	dev->client[2] = i2c_new_dummy_device(client->adapter, 0x1c);
+	if (IS_ERR(dev->client[2])) {
+		ret = PTR_ERR(dev->client[2]);
 		dev_err(&client->dev, "2nd I2C registration failed\n");
 		if (ret)
 			goto err_regmap_1_regmap_exit;
-- 
2.20.1
