From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 0/3] add support for Diolan DLN-2
Date: Mon, 10 Nov 2014 15:10:19 +0000
Message-ID: <20141110151019.GC24004@x1>
References: <1415281685-14866-1-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415281685-14866-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: gregkh@linuxfoundation.org, linus.walleij@linaro.org, gnurou@gmail.com, wsa@the-dreams.de, sameo@linux.intel.com, arnd@arndb.de, johan@kernel.org, daniel.baluta@intel.com, laurentiu.palcu@intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Linus, Wolfram,

Enjoy!

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c3=
55e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd=
-gpio-i2c-v3.19

for you to fetch changes up to e7d146b11a8a33b6033220b0f4fc4de2ab29218a=
:

  gpio: add support for the Diolan DLN-2 USB GPIO driver (2014-11-10 15=
:05:49 +0000)

----------------------------------------------------------------
Immutable branch between MFD, GPIO and I2C

----------------------------------------------------------------
Daniel Baluta (1):
      gpio: add support for the Diolan DLN-2 USB GPIO driver

Laurentiu Palcu (1):
      i2c: add support for Diolan DLN-2 USB-I2C adapter

Octavian Purdila (1):
      mfd: Add support for Diolan DLN-2 devices

 drivers/gpio/Kconfig          |  12 +
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-dln2.c      | 553 ++++++++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig    |  10 +
 drivers/i2c/busses/Makefile   |   1 +
 drivers/i2c/busses/i2c-dln2.c | 267 +++++++++++++++
 drivers/mfd/Kconfig           |  10 +
 drivers/mfd/Makefile          |   1 +
 drivers/mfd/dln2.c            | 763 ++++++++++++++++++++++++++++++++++=
++++++++
 include/linux/mfd/dln2.h      | 103 ++++++
 10 files changed, 1721 insertions(+)
 create mode 100644 drivers/gpio/gpio-dln2.c
 create mode 100644 drivers/i2c/busses/i2c-dln2.c
 create mode 100644 drivers/mfd/dln2.c
 create mode 100644 include/linux/mfd/dln2.h

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
