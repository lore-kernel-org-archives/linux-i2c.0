From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/13] eeprom: at24: replace msleep() with usleep_range()
Date: Thu, 24 Mar 2016 15:45:59 +0100
Message-ID: <1458830767-23816-6-git-send-email-bgolaszewski@baylibre.com>
References: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34992 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbcCXOqR (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 10:46:17 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so239769307wml.0
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 07:46:16 -0700 (PDT)
In-Reply-To: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

We cannot expect msleep(1) to actually sleep for a period shorter than
20 ms. Replace all calls to msleep() with usleep_range().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 9e01428..bc5be1e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -240,8 +240,7 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 		if (status == count)
 			return count;
 
-		/* REVISIT: at HZ=100, this is sloooow */
-		msleep(1);
+		usleep_range(1000, 1500);
 	} while (time_before(read_time, timeout));
 
 	return -ETIMEDOUT;
@@ -355,8 +354,7 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 		if (status == count)
 			return count;
 
-		/* REVISIT: at HZ=100, this is sloooow */
-		msleep(1);
+		usleep_range(1000, 1500);
 	} while (time_before(write_time, timeout));
 
 	return -ETIMEDOUT;
-- 
2.7.4
