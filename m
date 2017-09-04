From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] Immutable branch between MFD and many other subsystems
 due for the v4.14 merge window
Date: Mon, 4 Sep 2017 14:43:28 +0100
Message-ID: <20170904134328.c6stoqane6733xkv@dell>
References: <20170814163424.2197-1-wsa@the-dreams.de>
 <20170814163424.2197-4-wsa@the-dreams.de>
 <CACRpkdZd1TecLVQA2uPiPM_fWDw1mS2-kpmN06xp=dP4Wh-vYQ@mail.gmail.com>
 <20170827164444.GB22819@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170827164444.GB22819-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Enjoy!

The following changes since commit 569dbb88e80deb68974ef6fdd6a13edb9d686261:

  Linux 4.13 (2017-09-03 13:56:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-many-v4.14

for you to fetch changes up to a205425658dead19bb1b8ac00584aed98e60dde2:

  mfd: twl: Move header file out of I2C realm (2017-09-04 14:41:02 +0100)

----------------------------------------------------------------
Immutable branch between MFD and many other subsystems due for the v4.14 merge window

----------------------------------------------------------------
Wolfram Sang (1):
      mfd: twl: Move header file out of I2C realm

 arch/arm/mach-omap2/common.h            | 2 +-
 arch/arm/mach-omap2/omap_twl.c          | 2 +-
 drivers/gpio/gpio-twl4030.c             | 2 +-
 drivers/iio/adc/twl4030-madc.c          | 2 +-
 drivers/iio/adc/twl6030-gpadc.c         | 2 +-
 drivers/input/keyboard/twl4030_keypad.c | 2 +-
 drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
 drivers/input/misc/twl4030-vibra.c      | 2 +-
 drivers/mfd/twl-core.c                  | 6 +++---
 drivers/mfd/twl4030-audio.c             | 2 +-
 drivers/mfd/twl4030-irq.c               | 2 +-
 drivers/mfd/twl4030-power.c             | 2 +-
 drivers/mfd/twl6030-irq.c               | 2 +-
 drivers/phy/ti/phy-twl4030-usb.c        | 2 +-
 drivers/power/supply/twl4030_charger.c  | 2 +-
 drivers/pwm/pwm-twl-led.c               | 2 +-
 drivers/pwm/pwm-twl.c                   | 2 +-
 drivers/regulator/twl-regulator.c       | 2 +-
 drivers/regulator/twl6030-regulator.c   | 2 +-
 drivers/rtc/rtc-twl.c                   | 2 +-
 drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
 drivers/video/backlight/pandora_bl.c    | 2 +-
 drivers/watchdog/twl4030_wdt.c          | 2 +-
 include/linux/{i2c => mfd}/twl.h        | 0
 sound/soc/codecs/twl4030.c              | 2 +-
 25 files changed, 26 insertions(+), 26 deletions(-)
 rename include/linux/{i2c => mfd}/twl.h (100%)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
