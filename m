From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] eeprom: at24: check the return value of nvmem_unregister()
Date: Wed, 27 Dec 2017 15:10:38 +0100
Message-ID: <20171227141038.31646-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

This function can fail with -EBUSY, but we don't check its return
value in at24_remove(). Bail-out of remove() if nvmem_unregister()
doesn't succeed.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e79833d62284..fb21e1c45115 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -684,11 +684,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 static int at24_remove(struct i2c_client *client)
 {
 	struct at24_data *at24;
-	int i;
+	int i, ret;
 
 	at24 = i2c_get_clientdata(client);
 
-	nvmem_unregister(at24->nvmem);
+	ret = nvmem_unregister(at24->nvmem);
+	if (ret)
+		return ret;
 
 	for (i = 1; i < at24->num_addresses; i++)
 		i2c_unregister_device(at24->client[i].client);
-- 
2.15.1
