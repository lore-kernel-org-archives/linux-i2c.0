From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 0/2] i2c: aspeed: added driver for Aspeed I2C
Date: Fri,  4 Nov 2016 18:58:17 -0700
Message-ID: <1478311099-6771-1-git-send-email-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Sorry, been a while since I was able to send an update for this.

As a refresher, I added a master mode and slave mode I2C driver for the Aspeed
24XX/25XX SoC as well as device binding documentation.

Changes since first update:
  - I have removed the bus device tree param as requested here:
    http://www.spinics.net/lists/devicetree/msg143850.html
  - I2C adapter number is now generated dynamically unless an alias is provided
  - I changed the Kconfig for the driver to depend only on ARCH_ASPEED
  - Replaced the two module_platform_driver registrations with single
    module_init

Changes have been tested on the Aspeed evaluation board.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
