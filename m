From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v9 0/8] add i2c driver supported for rk3399
Date: Thu, 12 May 2016 15:52:58 +0800
Message-ID: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, briannorris-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There are three points differert from others:
 - new method to caculate i2c timings for rk3399
 - pclk and function clk are separated at rk3399
 - add fast-plus mode supported for rk3399

David Wu (8):
  i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
  i2c: rk3x: use struct "rk3x_i2c_calced_timings"
  i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
  i2c: rk3x: Change SoC data to not use array
  i2c: rk3x: Move spec timing data to "static const" structs
  dt-bindings: i2c: rk3x: add support for rk3399
  i2c: rk3x: add i2c support for rk3399 soc
  i2c: rk3x: support fast-mode plus for rk3399

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-
 drivers/i2c/busses/i2c-rk3x.c                      | 495 +++++++++++++++++----
 2 files changed, 432 insertions(+), 79 deletions(-)

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
