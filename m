From: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 0/4] Kontron PLD drivers
Date: Sun, 23 Jun 2013 21:00:02 -0700
Message-ID: <1372046406-3127-1-git-send-email-kevin.strasser@linux.intel.com>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365441321-21952-1-git-send-email-kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Kevin Strasser <strassek-29tvszzbzErpgkiH4x7ZXw@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Michael Brunner <Michael.Brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>, Chris Healy <chealy-KRR2zmvM+DFWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dirk Hohndel <Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Changes since v2:
-Change Michael's "Signed-off-by" to "Originally-From" in all patches
-Add "From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>" to gpio patch

Guenter Roeck (1):
  gpio: Kontron PLD gpio driver

Kevin Strasser (3):
  mfd: Kontron PLD mfd driver
  i2c: Kontron PLD i2c bus driver
  watchdog: Kontron PLD watchdog timer driver

 drivers/gpio/Kconfig            |   12 +
 drivers/gpio/Makefile           |    1 +
 drivers/gpio/gpio-kempld.c      |  225 ++++++++++++++
 drivers/i2c/busses/Kconfig      |   10 +
 drivers/i2c/busses/Makefile     |    1 +
 drivers/i2c/busses/i2c-kempld.c |  410 +++++++++++++++++++++++++
 drivers/mfd/Kconfig             |   21 ++
 drivers/mfd/Makefile            |    1 +
 drivers/mfd/kempld-core.c       |  642 +++++++++++++++++++++++++++++++++++++++
 drivers/watchdog/Kconfig        |   11 +
 drivers/watchdog/Makefile       |    1 +
 drivers/watchdog/kempld_wdt.c   |  580 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/kempld.h      |  125 ++++++++
 13 files changed, 2040 insertions(+)
 create mode 100644 drivers/gpio/gpio-kempld.c
 create mode 100644 drivers/i2c/busses/i2c-kempld.c
 create mode 100644 drivers/mfd/kempld-core.c
 create mode 100644 drivers/watchdog/kempld_wdt.c
 create mode 100644 include/linux/mfd/kempld.h

-- 
1.7.9.5
