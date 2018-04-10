From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/4] eeprom: at24: don't assign the i2c ID table to at24_driver
Date: Tue, 10 Apr 2018 15:12:03 +0200
Message-ID: <20180410131206.25760-2-brgl@bgdev.pl>
References: <20180410131206.25760-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410131206.25760-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

We switched to using probe_new(), so this is no longer used
by i2c core.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f207aea..2310f26ac4f3 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -737,7 +737,6 @@ static struct i2c_driver at24_driver = {
 	},
 	.probe_new = at24_probe,
 	.remove = at24_remove,
-	.id_table = at24_ids,
 };
 
 static int __init at24_init(void)
-- 
2.17.0
