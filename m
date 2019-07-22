From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] leds: is31fl319x: simplify getting the adapter of a client
Date: Mon, 22 Jul 2019 20:14:16 +0200
Message-ID: <20190722181416.6743-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

We have a dedicated pointer for that, so use it. Much easier to read and
less computation involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/leds/leds-is31fl319x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 2d077b8edd0e..ca6634b8683c 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -333,12 +333,11 @@ static int is31fl319x_probe(struct i2c_client *client,
 {
 	struct is31fl319x_chip *is31;
 	struct device *dev = &client->dev;
-	struct i2c_adapter *adapter = to_i2c_adapter(dev->parent);
 	int err;
 	int i = 0;
 	u32 aggregated_led_microamp = IS31FL319X_CURRENT_MAX;
 
-	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C))
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EIO;
 
 	is31 = devm_kzalloc(&client->dev, sizeof(*is31), GFP_KERNEL);
-- 
2.20.1
