From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/2] misc: eeprom: max6875: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:16 +0200
Message-ID: <20190722172616.3982-3-wsa+renesas@sang-engineering.com>
References: <20190722172616.3982-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172616.3982-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/misc/eeprom/max6875.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/max6875.c b/drivers/misc/eeprom/max6875.c
index 4d0cb90f4aeb..9da81f6d4a1c 100644
--- a/drivers/misc/eeprom/max6875.c
+++ b/drivers/misc/eeprom/max6875.c
@@ -150,9 +150,9 @@ static int max6875_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	/* A fake client is created on the odd address */
-	data->fake_client = i2c_new_dummy(client->adapter, client->addr + 1);
-	if (!data->fake_client) {
-		err = -ENOMEM;
+	data->fake_client = i2c_new_dummy_device(client->adapter, client->addr + 1);
+	if (IS_ERR(data->fake_client)) {
+		err = PTR_ERR(data->fake_client);
 		goto exit_kfree;
 	}
 
-- 
2.20.1
