From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 05/13] eeprom: at24: replace msleep() with usleep_range()
Date: Mon, 11 Apr 2016 11:57:21 -0700
Message-ID: <1460401049-25459-6-git-send-email-bgolaszewski@baylibre.com>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35203 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbcDKS5z (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 11 Apr 2016 14:57:55 -0400
Received: by mail-pf0-f170.google.com with SMTP id n1so129142449pfn.2
        for <linux-i2c@vger.kernel.org>; Mon, 11 Apr 2016 11:57:54 -0700 (PDT)
In-Reply-To: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com
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
