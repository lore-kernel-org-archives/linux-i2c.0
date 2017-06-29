From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [RFC PATCH 0/3] Add at24 functionality to read form different EEPROM offsets
Date: Thu, 29 Jun 2017 14:39:08 +0300
Message-ID: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all,

Please give feedback on the following approach to extends at24 EEPROM
driver to support reading MAC from different addresses in EEPROM (patch
2 and 3 from this series). This will allow the at24 driver to be used
as a generic driver by different hardwares.

This series also contains a patch (patch 1 from this series) which document
all at24 EEPROM memories and it was pushed with this series because patch
3 from the series is based on it.

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
