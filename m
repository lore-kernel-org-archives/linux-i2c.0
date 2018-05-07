From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] eeprom: at24: fix retrieving the at24_chip_data structure
Date: Mon,  7 May 2018 12:16:58 +0200
Message-ID: <20180507101658.7788-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vadim Pasternak <vadimp@mellanox.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Commit feb2f19b1e8f ("eeprom: at24: move platform data processing into
a separate routine") introduced a bug where we incorrectly retireve the
at24_chip_data structure. Remove the unnecessary ampersand operator.

Fixes: feb2f19b1e8f ("eeprom: at24: move platform data processing into a separate routine")
Reported-by: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f207aea..33053b0d1fdf 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -518,7 +518,7 @@ static int at24_get_pdata(struct device *dev, struct at24_platform_data *pdata)
 	if (of_node && of_match_device(at24_of_match, dev))
 		cdata = of_device_get_match_data(dev);
 	else if (id)
-		cdata = (void *)&id->driver_data;
+		cdata = (void *)id->driver_data;
 	else
 		cdata = acpi_device_get_match_data(dev);
 
-- 
2.17.0
