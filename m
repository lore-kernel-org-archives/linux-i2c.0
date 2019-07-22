From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] misc: eeprom: ee1004: convert to i2c_new_dummy_device
Date: Mon, 22 Jul 2019 19:26:15 +0200
Message-ID: <20190722172616.3982-2-wsa+renesas@sang-engineering.com>
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

 drivers/misc/eeprom/ee1004.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 6f00c33cfe22..b081c67416d7 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -195,13 +195,13 @@ static int ee1004_probe(struct i2c_client *client,
 	mutex_lock(&ee1004_bus_lock);
 	if (++ee1004_dev_count == 1) {
 		for (cnr = 0; cnr < 2; cnr++) {
-			ee1004_set_page[cnr] = i2c_new_dummy(client->adapter,
+			ee1004_set_page[cnr] = i2c_new_dummy_device(client->adapter,
 						EE1004_ADDR_SET_PAGE + cnr);
-			if (!ee1004_set_page[cnr]) {
+			if (IS_ERR(ee1004_set_page[cnr])) {
 				dev_err(&client->dev,
 					"address 0x%02x unavailable\n",
 					EE1004_ADDR_SET_PAGE + cnr);
-				err = -EADDRINUSE;
+				err = PTR_ERR(ee1004_set_page[cnr]);
 				goto err_clients;
 			}
 		}
-- 
2.20.1
