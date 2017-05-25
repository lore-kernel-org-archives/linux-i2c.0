From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 0/5] i2c: aspeed: added driver for Aspeed I2C
Date: Wed, 24 May 2017 23:49:20 -0700
Message-ID: <20170525064925.16867-1-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Addressed comments from:
  - Ben in: http://www.spinics.net/lists/devicetree/msg174576.html
    and: https://www.spinics.net/lists/kernel/msg2496151.html
  - Wolfram in: https://www.spinics.net/lists/kernel/msg2504011.html
  - Cedric in: https://www.spinics.net/lists/kernel/msg2506531.html

Changes since previous update:
  - ACK IRQ status bits before doing anything else
  - Added multi-master device tree property
  - Do not send STOP commands after interrupt errors
  - Fix SMBUS_QUICK emulation handling
  - Removed highspeed clock code (I will do it in a later patch set)
  - Use the platform_device name for the adapter name
  - Reset for all failed recoveries
  - Removed the "__" prefix from all of the non-thread safe functions

As before, tested on Aspeed 2500 evaluation board and a real platform with an
Aspeed 2520.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
