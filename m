From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 0/5] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 24 Apr 2017 11:18:13 -0700
Message-ID: <20170424181818.2754-1-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Addressed comments from:
  - Ben in: http://www.spinics.net/lists/devicetree/msg170491.html
    and: http://www.spinics.net/lists/devicetree/msg171232.html
  - Rob: http://www.spinics.net/lists/devicetree/msg171593.html
  - Joel in: http://www.spinics.net/lists/devicetree/msg171204.html

Changes since previous update:
  - Renamed irq domain for consistency
  - Changed clock-frequency to bus-frequency in device tree
  - Made some fixes to clock divider code
  - Added hardware reset function
  - Marked functions that need to be called with the lock held as "unlocked"
  - Did a bunch of clean up

Looks like there still might be some more work to do with multi-master support
and the clock divider stuff, but I will leave that up for others to decide.

As before, tested on Aspeed 2500 evaluation board and a real platform with an
Aspeed 2520.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
