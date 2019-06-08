From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 25/34] regulator: max8952: simplify getting the adapter of a client
Date: Sat,  8 Jun 2019 12:56:04 +0200
Message-ID: <20190608105619.593-26-wsa+renesas@sang-engineering.com>
References: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190608105619.593-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/regulator/max8952.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 2a123b87d9f2..5d3096e20f47 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -179,7 +179,7 @@ static struct max8952_platform_data *max8952_parse_dt(struct device *dev)
 static int max8952_pmic_probe(struct i2c_client *client,
 		const struct i2c_device_id *i2c_id)
 {
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct max8952_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct regulator_config config = { };
 	struct max8952_data *max8952;
-- 
2.19.1
