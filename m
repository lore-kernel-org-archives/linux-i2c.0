From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mfd: htc-i2cpld: drop check because i2c_unregister_device() is NULL safe
Date: Tue, 20 Aug 2019 17:34:43 +0200
Message-ID: <20190820153443.7812-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only, buildbot is happy, too.

Please apply to your tree.

 drivers/mfd/htc-i2cpld.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 370519af5d0b..8ad6768bd7a2 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -385,8 +385,7 @@ static void htcpld_unregister_chip_i2c(
 	htcpld = platform_get_drvdata(pdev);
 	chip = &htcpld->chip[chip_index];
 
-	if (chip->client)
-		i2c_unregister_device(chip->client);
+	i2c_unregister_device(chip->client);
 }
 
 static int htcpld_register_chip_gpio(
-- 
2.20.1
