From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH 0/3] Add at24 functionality to read MAC form different EEPROM offsets
Date: Thu, 6 Jul 2017 13:16:54 +0300
Message-ID: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

Please give feedback on the following approach to extends at24 EEPROM
driver to support reading MAC from different addresses in EEPROM.  This
will allow the at24 driver to be used as a generic driver by different
hardwares.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  dt-bindings: i2c: eeprom: document all at24 bindings
  drivers: misc: eeprom: at24: support reading mac eeprom from
    different addresses
  dt-bindings: i2c: eeprom: document "start-offset" binding

 Documentation/devicetree/bindings/eeprom/eeprom.txt | 20 +++++++++++++-------
 drivers/misc/eeprom/at24.c                          |  5 ++++-
 include/linux/platform_data/at24.h                  |  1 +
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
