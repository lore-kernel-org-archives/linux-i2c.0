From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: [PATCH v2 0/5] iio: srf08: add support for similar devices and
 triggered buffers
Date: Mon, 14 Aug 2017 10:59:00 +0200
Message-ID: <20170814085900.GA9722@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch series adds support for:
- triggered buffer
- ultrasonic devices srf02 and srf10

Thanks to Jonathan for his review which lined out improvements throughout
the patches.

I'm not sure, if the cc of [PATCH v2 1/5] is correct now.

Changes in v2:
- removed unnecessary patch "[PATCH 6/7] iio: srf08: add buffered to device
  mode"
- incorporated patch "[PATCH 7/7] iio: srf08: change text in Kconfig" where
  suitable
- changed order of patches to improve logical flow of changes
- improved distinction of sensor types

Andreas Klinger (5):
  iio: srf08: add device tree binding for srf02 and srf10
  iio: srf08: add device tree table
  iio: srf08: add triggered buffer support
  iio: srf08: add sensor type srf10
  iio: srf08: add support for srf02 in i2c mode

 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 drivers/iio/proximity/Kconfig                      |   8 +-
 drivers/iio/proximity/srf08.c                      | 191 ++++++++++++++++++---
 3 files changed, 169 insertions(+), 32 deletions(-)

-- 
2.1.4


-- 
