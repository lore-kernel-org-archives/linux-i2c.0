From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 20/21] eeprom: at24: fix a line break
Date: Mon, 19 Mar 2018 10:17:20 +0100
Message-ID: <20180319091721.18193-21-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Align the broken line with the opening parenthesis to stay consistent
with the rest of the driver code.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b4233d914500..c42e479b880a 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -690,8 +690,8 @@ static int at24_probe(struct i2c_client *client)
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
-		pdata.byte_len, client->name,
-		writable ? "writable" : "read-only", at24->write_max);
+		 pdata.byte_len, client->name,
+		 writable ? "writable" : "read-only", at24->write_max);
 
 	/* export data to kernel code */
 	if (pdata.setup)
-- 
2.16.1
