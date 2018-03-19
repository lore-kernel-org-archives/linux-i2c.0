From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 19/21] eeprom: at24: tweak newlines
Date: Mon, 19 Mar 2018 10:17:19 +0100
Message-ID: <20180319091721.18193-20-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Remove the newline between the nvmem registration and its return value
check. This is consistent with the rest of the driver code.

Add a missing newline between two pdata checks to stay consistent with
all the others.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index f67f5f626617..b4233d914500 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -582,6 +582,7 @@ static int at24_probe(struct i2c_client *client)
 		dev_err(dev, "page_size must not be 0!\n");
 		return -EINVAL;
 	}
+
 	if (!is_power_of_2(pdata.page_size))
 		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
@@ -683,7 +684,6 @@ static int at24_probe(struct i2c_client *client)
 	nvmem_config.size = pdata.byte_len;
 
 	at24->nvmem = nvmem_register(&nvmem_config);
-
 	if (IS_ERR(at24->nvmem)) {
 		err = PTR_ERR(at24->nvmem);
 		goto err_clients;
-- 
2.16.1
