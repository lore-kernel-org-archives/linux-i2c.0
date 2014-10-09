From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 0/4]  mfd: add support for Diolan DLN-2
Date: Thu,  9 Oct 2014 22:22:17 +0300
Message-ID: <1412882541-10934-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Changes since v6:

* MFD: make sure DLN2_HANDLE_EVENT stays 0, move a few operations out
  of the lock block, renamed one missed _rx_callback function to
  _event_callback, speed-up disconnect by checking for it in
  find_free_slot, remove the URB submit helper and simplify URB
  resubmit code, use mfd_add_hotplug_devices, change the driver name
  to dln2 (from usb-dln2), initialize disconnect_lock

* GPIO: no changes

* I2C: keep sorting in Kconfig and Makefile, add warning for transfers
  bigger then DLN2_I2C_MAX_XFER_SIZE, remove frequency code - I will
  send a separate patch that moves this to i2c core, revert to using
  tx structures for dln2_i2c_enable



Daniel Baluta (1):
  gpio: add support for the Diolan DLN-2 USB GPIO driver

Laurentiu Palcu (1):
  i2c: add support for Diolan DLN-2 USB-I2C adapter

Octavian Purdila (2):
  mfd: add support for Diolan DLN-2 devices
  gpiolib: add irq_not_threaded flag to gpio_chip

 drivers/gpio/Kconfig          |  12 +
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-dln2.c      | 555 +++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c        |   2 +-
 drivers/i2c/busses/Kconfig    |  10 +
 drivers/i2c/busses/Makefile   |   1 +
 drivers/i2c/busses/i2c-dln2.c | 275 +++++++++++++++
 drivers/mfd/Kconfig           |   9 +
 drivers/mfd/Makefile          |   1 +
 drivers/mfd/dln2.c            | 755 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio/driver.h   |   3 +
 include/linux/mfd/dln2.h      |  67 ++++
 12 files changed, 1690 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpio/gpio-dln2.c
 create mode 100644 drivers/i2c/busses/i2c-dln2.c
 create mode 100644 drivers/mfd/dln2.c
 create mode 100644 include/linux/mfd/dln2.h

-- 
1.9.1
