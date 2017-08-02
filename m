From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: [PATCH 0/7] iio: srf08: add support for similar devices and
 triggered buffers
Date: Thu, 3 Aug 2017 01:22:59 +0200
Message-ID: <20170802232259.GA15210@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch series adds support for the ultrasonic devices srf02 and srf10.

Triggered buffer support is added

Andreas Klinger (7):
  iio: srf08: add device tree binding for srf02 and srf10
  iio: srf08: add sensor type srf10
  iio: srf08: add triggered buffer support
  iio: srf08: add device tree table
  iio: srf08: add support for srf02 in i2c mode
  iio: srf08: add buffered to device mode
  iio: srf08: change text in Kconfig

 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 drivers/iio/proximity/Kconfig                      |  12 +-
 drivers/iio/proximity/srf08.c                      | 163 +++++++++++++++++----
 3 files changed, 145 insertions(+), 32 deletions(-)

-- 
2.1.4


-- 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
