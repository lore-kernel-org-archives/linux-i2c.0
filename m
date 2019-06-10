From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/3] hwmon: lm90: simplify getting the adapter of a client
Date: Mon, 10 Jun 2019 11:51:54 +0200
Message-ID: <20190610095157.11814-2-wsa+renesas@sang-engineering.com>
References: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610095157.11814-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Reported-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please apply to your subsystem tree.

 drivers/hwmon/lm90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index e562a578f20e..2ebcab8b0a9b 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -1718,7 +1718,7 @@ static int lm90_probe(struct i2c_client *client,
 		      const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
+	struct i2c_adapter *adapter = client->adapter;
 	struct hwmon_channel_info *info;
 	struct regulator *regulator;
 	struct device *hwmon_dev;
-- 
2.19.1
