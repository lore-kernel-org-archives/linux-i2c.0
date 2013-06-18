From: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/4] Kontron PLD drivers
Date: Tue, 18 Jun 2013 14:04:25 -0700
Message-ID: <1371589469-32700-1-git-send-email-kevin.strasser@linux.intel.com>
References: <1365441321-21952-1-git-send-email-kevin.strasser@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365441321-21952-1-git-send-email-kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Kevin Strasser <kevin.strasser-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Michael Brunner <Michael.Brunner-2UyDCMiLNfhBDgjK7y7TUQ@public.gmane.org>, Michael Brunner <mibru-Mmb7MZpHnFY@public.gmane.org>, Chris Healy <chealy-KRR2zmvM+DFWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Dirk Hohndel <Dirk.Hohndel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

mfd changes since v1:
- Use a mutex instead of spinlock
- Poll for hardware mutex without timeout
- Restructure mfd cell structs, only call mfd_add_devices once
- Drop pointless BUG_ONs
- EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL
- kempld_*_mutex_set_index -> kempld_*_mutex
- Removed kempld_try_get_mutex
- Drop last_index
- Remove EFT code
- Drop unused includes
- Use devm_ioport_map
- Restructure to get rid of forward function prototypes
- Renamed module parameter force_ident -> force_device_id
- Dropped force_unlock module parameter
- Formatting fixes

i2c changes since v1:
- Always disable bus during suspend,
- Detect was_active in probe
- Remove i2c-kempld.h
- Clean up register definitions
- Use the correct device for printing
- Set default bus frequency to 100kHz
- Drop irq support
- Drop now1 driver
- Remove i2c-mux code
- Clean up includes
- Use devm_kzalloc
- Formatting fixes

gpio changes since v1:
- Change label from kempld-gpio -> gpio-kempld
- Drop unnecessary include seq_file.h
- Register and value parameters to kempld_get_bit and kempld_bitop are now u8
- Status variable in kempld_bitop is now u8
- Fix kempld_gpio_pincount(). hweight16 doesn't work, but __ffs does
- Drop interrupt support
- Drop gpio-kempld.h
- Use helper functions for bit and read operations
- Use generic DEBUG_FS code
- Use devm_kzalloc
- Get gpio_base from platform data
- Drop all module parameters
- Use module_platform_driver
- Drop unused includes
- Include device.h instead of slab.h for devm_kzalloc
- Some cleanup here and there

watchdog changes since v1:
- Use watchdog framework
- Allocate stages statically
- Drop now1 driver
- Use devm_kzalloc
- Change default timeout to 30 seconds
- Drop unused includes
- General formatting cleanup

Kevin Strasser (4):
  mfd: Kontron PLD mfd driver
  i2c: Kontron PLD i2c bus driver
  gpio: Kontron PLD gpio driver
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
