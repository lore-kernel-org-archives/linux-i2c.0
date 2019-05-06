From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 2/2] eeprom: ee1004: Deal with nack on page selection
Date: Mon, 6 May 2019 15:16:56 +0200
Message-ID: <20190506151656.47494e56@endymion>
References: <20190506151539.69ee75e8@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506151539.69ee75e8@endymion>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Some EE1004 implementations will not properly ack page selection
commands. They still set the page correctly, so there is no actual
error. Deal with this case gracefully by checking the currently
selected page after we receive a nack. If the page is set right then
we can continue.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/eeprom/ee1004.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- linux-5.0.orig/drivers/misc/eeprom/ee1004.c	2019-05-06 11:57:14.333572368 +0200
+++ linux-5.0/drivers/misc/eeprom/ee1004.c	2019-05-06 15:11:06.009718220 +0200
@@ -1,7 +1,7 @@
 /*
  * ee1004 - driver for DDR4 SPD EEPROMs
  *
- * Copyright (C) 2017 Jean Delvare
+ * Copyright (C) 2017-2019 Jean Delvare
  *
  * Based on the at24 driver:
  * Copyright (C) 2005-2007 David Brownell
@@ -124,6 +124,16 @@ static ssize_t ee1004_read(struct file *
 			/* Data is ignored */
 			status = i2c_smbus_write_byte(ee1004_set_page[page],
 						      0x00);
+			if (status == -ENXIO) {
+				/*
+				 * Don't give up just yet. Some memory
+				 * modules will select the page but not
+				 * ack the command. Check which page is
+				 * selected now.
+				 */
+				if (ee1004_get_current_page() == page)
+					status = 0;
+			}
 			if (status < 0) {
 				dev_err(dev, "Failed to select page %d (%d)\n",
 					page, status);

-- 
Jean Delvare
SUSE L3 Support
