From: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Subject: [PATCH v2 0/2] eeprom: at24: convert magic numbers to structs.
Date: Fri, 8 Dec 2017 16:25:04 -0500
Message-ID: <1512768306-14816-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: svendev-fuHqz3Nb1YI@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

v2:
	use struct at24_chip_data instead of struct at24_platform_data
		(which decreases code size)
	explicitly write out of compatible nodes, e.g. "atmel,24c04"
		(which allows grepping for of compatible nodes)

v1:
	first shot

Sven Van Asbroeck (2):
  eeprom: at24: convert magic numbers to structs.
  eeprom: at24: remove temporary fix for at24mac402 size.

 drivers/misc/eeprom/at24.c | 240 +++++++++++++++++++++------------------------
 1 file changed, 110 insertions(+), 130 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
