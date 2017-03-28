From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 0/5] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 27 Mar 2017 22:12:21 -0700
Message-ID: <20170328051226.21677-1-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Sorry for the delay, I went on a long vacation prior to receiving feedback and
got back in the middle of a hardware bring up that consumed all of my attention
for an extended period of time. I will try to plan upstream submissions around
my other responsibilities better in the future.

Addressed comments from:
  - Vladimir in: https://www.spinics.net/lists/linux-i2c/msg27387.html
    and: https://www.spinics.net/lists/linux-i2c/msg27386.html
  - Wolfram in: https://www.spinics.net/lists/linux-i2c/msg27476.html
    and: https://www.spinics.net/lists/linux-i2c/msg27483.html

Changes since previous update:
  - No longer arbitrarily restrict bus to be slave xor master.
  - Pulled out "struct aspeed_i2c_controller" as a interrupt controller.
  - Pulled out slave support into its own commit.
  - Rewrote code that sets clock divider register because the original version
    set it incorrectly.
  - Discovered and fixed issue in implementation that caused certain slave
    devices to misbehave; the cause was that the master IRQ handler would return
    control to the requesting thread after the last RX or TX command was handled
    such that the requesting thread would issue either a repeated start or stop.
    This was incorrect because the time taken to complete the completion was too
    great. I fixed this by rewriting the master IRQ handler so that it now
    manages the entire transaction only returning control to the requesting
    thread once the entire transaction is complete.
  - Rewrote the aspeed_i2c_master_irq handler because the old method of
    completing a completion in between restarts was too slow causing devices to
    misbehave.
  - Added support for I2C_M_RECV_LEN which I had incorrectly said was supported
    before.
  - Addressed other comments from Vladimir.

Changes have been tested on the Aspeed 2500 evaluation board, as before, and now
on a real platform with an Aspeed 2520.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
