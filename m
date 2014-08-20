From: Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 0/3] dln-2: Add support for Diolan DLN-2 devices
Date: Wed, 20 Aug 2014 14:24:44 +0300
Message-ID: <1408533887-22727-1-git-send-email-daniel.baluta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org
Cc: pratyush.anand@st.com, pebolle@tiscali.nl, stern@rowland.harvard.edu, octavian.purdila@intel.com, matthew@mjdsystems.ca, linux-kernel@vger.kernel.org, laurentiu.palcu@intel.com, daniel.baluta@intel.com, jdelvare@suse.de, arnd@arndb.de, sjg@chromium.org
List-Id: linux-i2c@vger.kernel.org

This patch series adds support for Diolan USB-I2C/GPIO Master Adapter DLN-2.
Details about device can be found here:

https://www.diolan.com/i2c/i2c_interface.html.

There is no support for SPI part yet.

Daniel Baluta (1):
  gpio: add support for the Diolan DLN-2 USB-GPIO driver

Laurentiu Palcu (1):
  i2c: add support for Diolan DLN-2 USB-I2C adapter

Octavian Purdila (1):
  usb: add support for Diolan DLN-2 devices

 drivers/gpio/Kconfig          |  13 +
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-dln2.c      | 571 +++++++++++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig    |  11 +
 drivers/i2c/busses/Makefile   |   1 +
 drivers/i2c/busses/i2c-dln2.c | 328 +++++++++++++++++++
 drivers/usb/misc/Kconfig      |   6 +
 drivers/usb/misc/Makefile     |   1 +
 drivers/usb/misc/dln2.c       | 719 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/dln2.h      | 146 +++++++++
 10 files changed, 1797 insertions(+)
 create mode 100644 drivers/gpio/gpio-dln2.c
 create mode 100644 drivers/i2c/busses/i2c-dln2.c
 create mode 100644 drivers/usb/misc/dln2.c
 create mode 100644 include/linux/usb/dln2.h

-- 
1.9.1
