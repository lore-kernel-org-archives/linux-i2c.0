From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/7 v3] I2C GPIO to use gpiolibs open drain
Date: Thu,  5 Oct 2017 13:03:03 +0200
Message-ID: <20171005110310.5900-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:50942 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdJELDT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 5 Oct 2017 07:03:19 -0400
Received: by mail-wr0-f175.google.com with SMTP id b21so10565769wrg.7
        for <linux-i2c@vger.kernel.org>; Thu, 05 Oct 2017 04:03:18 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>

Finalized this series and collected the ACKs.

Wolfram: if not too late for v4.15, please carry this series.

Geert Uytterhoeven (1):
  dt-bindings: i2c: i2c-gpio: Add support for named gpios

Linus Walleij (6):
  i2c: gpio: Convert to use descriptors
  gpio: Make it possible for consumers to enforce open drain
  i2c: gpio: Enforce open drain through gpiolib
  i2c: gpio: Augment all boardfiles to use open drain
  i2c: gpio: Local vars in probe
  i2c: gpio: Add support for named gpios in DT

 Documentation/devicetree/bindings/i2c/i2c-gpio.txt |  32 +++-
 arch/arm/mach-ep93xx/core.c                        |  41 ++--
 arch/arm/mach-ep93xx/edb93xx.c                     |  15 +-
 arch/arm/mach-ep93xx/include/mach/platform.h       |   4 +-
 arch/arm/mach-ep93xx/simone.c                      |  12 +-
 arch/arm/mach-ep93xx/snappercl15.c                 |  12 +-
 arch/arm/mach-ep93xx/vision_ep9307.c               |   7 +-
 arch/arm/mach-ixp4xx/avila-setup.c                 |  17 +-
 arch/arm/mach-ixp4xx/dsmg600-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/fsg-setup.c                   |  16 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c                  |  24 +--
 arch/arm/mach-ixp4xx/ixdp425-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nas100d-setup.c               |  16 +-
 arch/arm/mach-ixp4xx/nslu2-setup.c                 |  16 +-
 arch/arm/mach-ks8695/board-acs5k.c                 |  15 +-
 arch/arm/mach-pxa/palmz72.c                        |  14 +-
 arch/arm/mach-pxa/viper.c                          |  27 ++-
 arch/arm/mach-sa1100/simpad.c                      |  14 +-
 arch/blackfin/mach-bf533/boards/blackstamp.c       |  19 +-
 arch/blackfin/mach-bf533/boards/ezkit.c            |  18 +-
 arch/blackfin/mach-bf533/boards/stamp.c            |  18 +-
 arch/blackfin/mach-bf561/boards/ezkit.c            |  18 +-
 arch/mips/alchemy/board-gpr.c                      |  23 ++-
 arch/mips/ath79/mach-pb44.c                        |  16 +-
 drivers/gpio/gpiolib.c                             |  13 ++
 drivers/i2c/busses/i2c-gpio.c                      | 212 ++++++++++-----------
 drivers/mfd/sm501.c                                |  49 ++---
 include/linux/gpio/consumer.h                      |   6 +
 include/linux/i2c-gpio.h                           |   4 -
 29 files changed, 422 insertions(+), 288 deletions(-)

-- 
2.13.5
