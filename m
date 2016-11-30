From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 0/2] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 29 Nov 2016 17:00:16 -0800
Message-ID: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Addressed comments from:
  - Cedric in: https://www.spinics.net/lists/devicetree/msg151685.html
  - Kachalov in: https://www.spinics.net/lists/devicetree/msg151819.html
  - Vladimir in: https://www.spinics.net/lists/devicetree/msg152454.html

Changes since previous update:
  - Removed irq_chip used to multiplex IRQ and replaced it with dummy_irq_chip
    along with some other IRQ cleanup.
  - Addressed comments from Cedric, and Vladimir, mostly stylistic things and
    using devm managed resources.
  - Increased max clock frequency before the bus is put in HighSpeed mode, as
    per Kachalov's comment.

Changes have been tested on the Aspeed evaluation board as before.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
