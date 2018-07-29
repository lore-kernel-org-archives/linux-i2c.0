From: Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v1 0/2] i2c: npcm7xx: new driver for I2C controller
Date: Sun, 29 Jul 2018 12:14:47 +0300
Message-ID: <20180729091449.385951-1-tali.perry1@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tali.perry1@gmail.com, avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com, yuenn@google.com, brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, arnd@arndb.de, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, pierre-yves.mordret@st.com, cedric.madianga@gmail.com, baolin.wang@spreadtrum.com, jarkko.nikula@linux.intel.com, hdegoede@redhat.com, rmk+kernel@armlinux.org.uk, ard.biesheuvel@linaro.org, thor.thayer@linux.intel.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, tglx@linutronix.de
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Nuvoton NPCM7XX I2C Controller
NPCM7xx includes 16 I2C contollers. THis driver operates the controller.
This module also includes a slave mode, which will be submitted later on.

Any feedback would be appreciated.  


Signed-off-by: Tali Perry <tali.perry1@gmail.com>


---
Tali Perry (2):
  dt-binding: i2c: npcm7xx: add binding for i2c controller
  i2c: npcm7xx: add i2c controller master mode only

 .../devicetree/bindings/i2c/i2c-npcm7xx.txt        |   27 +
 MAINTAINERS                                        |    9 +
 drivers/i2c/busses/Kconfig                         |   11 +
 drivers/i2c/busses/Makefile                        |    1 +
 drivers/i2c/busses/i2c-npcm7xx.c                   | 2574 ++++++++++++++++++++
 5 files changed, 2622 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
 create mode 100644 drivers/i2c/busses/i2c-npcm7xx.c

-- 
2.14.1
