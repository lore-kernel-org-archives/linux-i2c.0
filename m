From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL REQUEST] at24 updates for 4.16
Date: Wed,  3 Jan 2018 17:01:13 +0100
Message-ID: <20180103160113.28561-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:44420 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeACQB3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 3 Jan 2018 11:01:29 -0500
Received: by mail-wm0-f51.google.com with SMTP id t8so3448096wmc.3
        for <linux-i2c@vger.kernel.org>; Wed, 03 Jan 2018 08:01:28 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Hi Wolfram,

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-4.16-updates-for-wolfram

for you to fetch changes up to 0f30aca72c3b68f4b6a443193b574f14106cd61e:

  eeprom: at24: extend the list of chips supported in DT (2018-01-02 17:52:45 +0100)

----------------------------------------------------------------
AT24 updates for 4.16 merge window

The driver has been converted to using regmap instead of raw i2c and smbus
calls which shrank the code significantly.

Device tree binding document has been cleaned up. Device tree support in the
driver has been improved and we now support all at24 models as well as two new
DT properties (no-read-rollover and wp-gpios).

We no longer user unreadable magic values for driver data as the way it was
implemented caused problems for some EEPROM models - we switched to regular
structs.

Aside from that, there's a bunch of coding style fixes and minor improvements
all over the place.

----------------------------------------------------------------
Bartosz Golaszewski (11):
      MAINTAINERS: add git URL for at24
      eeprom: at24: fix coding style issues
      eeprom: at24: use a common prefix for all symbols in at24.c
      eeprom: at24: code shrink
      dt-bindings: at24: new optional property - wp-gpios
      eeprom: at24: add support for the write-protect pin
      eeprom: at24: fix a whitespace error in platform data
      dt-bindings: at24: consistently document the compatible property
      dt-bindings: at24: fix formatting and style
      dt-bindings: at24: extend the list of supported chips
      eeprom: at24: extend the list of chips supported in DT

Heiner Kallweit (7):
      eeprom: at24: add basic regmap_i2c support
      eeprom: at24: change at24_translate_offset return type
      eeprom: at24: add regmap-based write function
      eeprom: at24: remove old write functions
      eeprom: at24: add regmap-based read function
      eeprom: at24: remove old read functions
      eeprom: at24: remove now unneeded smbus-related code

Sven Van Asbroeck (4):
      dt-bindings: add eeprom "no-read-rollover" property
      eeprom: at24: support eeproms that do not auto-rollover reads
      eeprom: at24: convert magic numbers to structs
      eeprom: at24: remove temporary fix for at24mac402 size

Wolfram Sang (2):
      dt-bindings: eeprom: rename to at24.txt
      MAINTAINERS: add DT binding docs for AT24

 Documentation/devicetree/bindings/eeprom/at24.txt   |  78 ++++++++++++++++
 Documentation/devicetree/bindings/eeprom/eeprom.txt |  47 ----------
 MAINTAINERS                                         |   2 +
 drivers/misc/eeprom/Kconfig                         |   1 +
 drivers/misc/eeprom/at24.c                          | 731 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------
 include/linux/platform_data/at24.h                  |   2 +
 6 files changed, 337 insertions(+), 524 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.txt
 delete mode 100644 Documentation/devicetree/bindings/eeprom/eeprom.txt
