From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 05/21] eeprom: at24: remove code separators
Date: Mon, 19 Mar 2018 10:17:05 +0100
Message-ID: <20180319091721.18193-6-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

These are just two left-overs from times when this driver was bigger.

They are not really useful anymore. Remove them.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0e06201d33c9..d1ad73d94fa8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -235,8 +235,6 @@ static const struct acpi_device_id at24_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
 
-/*-------------------------------------------------------------------------*/
-
 /*
  * This routine supports chips which consume multiple I2C addresses. It
  * computes the addressing information to be used for a given r/w request.
@@ -712,8 +710,6 @@ static int at24_remove(struct i2c_client *client)
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
-
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
-- 
2.16.1
