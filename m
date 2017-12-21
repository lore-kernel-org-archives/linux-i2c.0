From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: [PATCH v2 0/5] eeprom: at24: device tree support fixes
Date: Thu, 21 Dec 2017 14:48:37 +0100
Message-ID: <20171221134842.31287-1-brgl@bgdev.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The first three patches fix certain issues with the DT binding
document.

The last two extend the device tree support in the driver with more
at24 EEPROM variants.

v1 -> v2:
- remove any implementation details from patch 1/5

Bartosz Golaszewski (5):
  dt-bindings: at24: consistently document the compatible property
  dt-bindings: at24: add a missing compatible
  dt-bindings: at24: fix formatting and style
  dt-bindings: at24: extend the list of supported chips
  eeprom: at24: extend the list of chips supported in DT

 Documentation/devicetree/bindings/eeprom/at24.txt | 82 +++++++++++++----------
 drivers/misc/eeprom/at24.c                        |  9 +++
 2 files changed, 57 insertions(+), 34 deletions(-)

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
