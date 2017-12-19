From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: [PATCH 0/2] eeprom: at24: write-protect pin support
Date: Tue, 19 Dec 2017 17:14:30 +0100
Message-ID: <20171219161432.29809-1-brgl@bgdev.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

AT24 EEPROMs have a write-protect pin, which - when pulled high -
inhibits writes to the upper quadrant of memory (although it has been
observed that on some chips it disables writing to the entire memory
range).

On some boards, this pin is connected to a GPIO and pulled high by
default, which forces the user to manually change its state before
writing. On linux this means that we either need to hog the line all
the time, or set the GPIO value before writing from outside of the
at24 driver.

This series adds support for the write-protect pin split into two
parts. The first patch extends the relevant binding document, while
the second modifies the at24 code to pull the write-protect GPIO
low (if present) during write operations.

Bartosz Golaszewski (2):
  dt-bindings: at24: new optional property - write-protect-gpios
  eeprom: at24: add support for the write-protect pin

 Documentation/devicetree/bindings/eeprom/at24.txt |  4 ++++
 drivers/misc/eeprom/at24.c                        | 12 ++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
