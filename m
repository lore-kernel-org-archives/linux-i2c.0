From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH 0/2] Introduce MEN Board Information EEPROM driver
Date: Thu, 16 Oct 2014 10:14:48 +0200
Message-ID: <cover.1413416105.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, johannes.thumshirn@men.de, andreas.werner@men.de
List-Id: linux-i2c@vger.kernel.org

This patchset adds support for the MEN Board Information EEPROM.

The EEPROM is assembled on almost all of the MEN hardware boards and is the
main location to get information about the board.

The driver exports the EEPROM data like production date, board name and serial number
as read-only files as well as a user section for read-write access.

There is also a ABI documentation for sysfs description included.

Andreas Werner (2):
  drivers/misc/eeprom/men_eeprod: Introduce MEN Board Information EEPROM
    driver
  Documentation/ABI/testing/men_eeprod: Added sysfs description for
    men_eeprod

 .../ABI/testing/sysfs-bus-i2c-devices-men_eeprod   |  69 +++
 MAINTAINERS                                        |   6 +
 drivers/misc/eeprom/Kconfig                        |  10 +
 drivers/misc/eeprom/Makefile                       |   1 +
 drivers/misc/eeprom/men_eeprod.c                   | 560 +++++++++++++++++++++
 5 files changed, 646 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-men_eeprod
 create mode 100644 drivers/misc/eeprom/men_eeprod.c

-- 
2.1.0
