From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/4] rtc: isl12026: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:15 +0200
Message-ID: <20190722172618.4061-2-wsa+renesas@sang-engineering.com>
References: <20190722172618.4061-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172618.4061-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/rtc/rtc-isl12026.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
index 97f594f9667c..5b6b17fb6d62 100644
--- a/drivers/rtc/rtc-isl12026.c
+++ b/drivers/rtc/rtc-isl12026.c
@@ -454,9 +454,9 @@ static int isl12026_probe_new(struct i2c_client *client)
 
 	isl12026_force_power_modes(client);
 
-	priv->nvm_client = i2c_new_dummy(client->adapter, ISL12026_EEPROM_ADDR);
-	if (!priv->nvm_client)
-		return -ENOMEM;
+	priv->nvm_client = i2c_new_dummy_device(client->adapter, ISL12026_EEPROM_ADDR);
+	if (IS_ERR(priv->nvm_client))
+		return PTR_ERR(priv->nvm_client);
 
 	priv->rtc = devm_rtc_allocate_device(&client->dev);
 	ret = PTR_ERR_OR_ZERO(priv->rtc);
-- 
2.20.1
