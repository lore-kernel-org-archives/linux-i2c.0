From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop I2C_CLASS_CAM_ANALOG and I2C_CLASS_SOUND
Date: Fri, 31 Oct 2008 10:34:16 +0100
Message-ID: <20081031103416.17d809b7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

There are no users left of these two i2c probe class flags so we can
drop the now.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c.h |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.28-rc2.orig/include/linux/i2c.h	2008-10-31 09:14:39.000000000 +0100
+++ linux-2.6.28-rc2/include/linux/i2c.h	2008-10-31 09:49:27.000000000 +0100
@@ -393,9 +393,7 @@ static inline void i2c_set_adapdata(stru
 #define I2C_CLASS_TV_ANALOG	(1<<1)	/* bttv + friends */
 #define I2C_CLASS_TV_DIGITAL	(1<<2)	/* dvb cards */
 #define I2C_CLASS_DDC		(1<<3)	/* DDC bus on graphics adapters */
-#define I2C_CLASS_CAM_ANALOG	(1<<4)	/* camera with analog CCD */
 #define I2C_CLASS_CAM_DIGITAL	(1<<5)	/* most webcams */
-#define I2C_CLASS_SOUND		(1<<6)	/* sound devices */
 #define I2C_CLASS_SPD		(1<<7)	/* SPD EEPROMs and similar */
 
 /* i2c_client_address_data is the struct for holding default client


-- 
Jean Delvare
