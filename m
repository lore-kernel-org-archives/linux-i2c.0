From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
Date: Tue,  8 Jan 2019 10:15:27 +0100
Message-ID: <20190108091539.16674-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

now that all dependencies are in and v5.0-rc1 is tagged, please consider
picking up the second batch of davinci-specific changes into your tree.
Once that's done, please provide me with an immutable branch for me to
apply the last patch to my at24 tree.

This is the second part of the effort to modernize the at24 driver and
remove the legacy platform data structure in favor of device properties.
It required getting rid of the at24 setup callback in favor of nvmem
lookups.

Re-tested with da850-evm and dm365-evm.

Bartosz Golaszewski (12):
  ARM: davinci: da850-evm: remove dead MTD code
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code related to MAC address reading
  ARM: davinci: mityomapl138: use nvmem notifiers
  ARM: davinci: mityomapl138: use device properties for at24 eeprom
  eeprom: at24: remove at24_platform_data

 MAINTAINERS                                |   1 -
 arch/arm/mach-davinci/board-da830-evm.c    |  13 +-
 arch/arm/mach-davinci/board-da850-evm.c    |  28 ----
 arch/arm/mach-davinci/board-dm365-evm.c    |  13 +-
 arch/arm/mach-davinci/board-dm644x-evm.c   |  13 +-
 arch/arm/mach-davinci/board-dm646x-evm.c   |  13 +-
 arch/arm/mach-davinci/board-mityomapl138.c |  38 ++---
 arch/arm/mach-davinci/board-sffsdr.c       |  13 +-
 arch/arm/mach-davinci/common.c             |  15 --
 drivers/misc/eeprom/at24.c                 | 162 ++++++++++-----------
 include/linux/davinci_emac.h               |   1 -
 include/linux/platform_data/at24.h         |  60 --------
 12 files changed, 122 insertions(+), 248 deletions(-)
 delete mode 100644 include/linux/platform_data/at24.h

-- 
2.19.1
