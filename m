From: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: [PATCH v6 0/5] AT91: replace broken TWI driver i2c-at91.c
Date: Fri, 18 Nov 2011 12:46:27 +0100
Message-ID: <cover.1321616787.git.n.voss@weinmann.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The old driver has two main deficencies:
i)  No repeated start (Sr) condiction is possible, this makes it unusable
    e.g. for most SMBus transfers.
ii) I/O was done with polling/busy waiting what caused over-/underruns
    even at light system loads and clock speeds.

The new driver overcomes these deficencies and in addition allows for
more than one TWI interface.

A remaining limitation is the fact, that only one repeated start is
possible (two concatenated messages). This limitation is imposed by
the hardware. However, this should not be a problem as all common
i2c-client communication does not rely on more than one repeated start.

v6: Patch 5/5: support for I2C_SMBUS_BLOCK_DATA transfers.
    Better use of clk_(un)prepare().
    More sensible transfer timeout.
v5: Another round of review comments from Ryan Mallon, Felipe Balbi
    and Russell King: convert twi clk to use .dev_id, cleanups
v4: Integrated more review comments from Ryan Mallon and Felipe Balbi:
    Moved register include file to local include, code cleanups
v3: Integrated review comments from Ryan Mallon and Felipe Balbi
v2: Fixed whitespace issue

Nikolaus Voss (5):
  drivers/i2c/busses/i2c-at91.c: remove broken driver
  Replace clk_lookup.con_id with clk_lookup.dev_id entries for twi clk
  drivers/i2c/busses/i2c-at91.c: add new driver
  G45 TWI: remove open drain setting for twi function gpios
  i2c-at91.c: add SMBUS_READ_BLOCK_DATA functionality

 arch/arm/mach-at91/at91cap9.c              |    1 +
 arch/arm/mach-at91/at91rm9200.c            |    1 +
 arch/arm/mach-at91/at91sam9260.c           |    1 +
 arch/arm/mach-at91/at91sam9261.c           |    1 +
 arch/arm/mach-at91/at91sam9263.c           |    1 +
 arch/arm/mach-at91/at91sam9g45.c           |    2 +
 arch/arm/mach-at91/at91sam9g45_devices.c   |    6 -
 arch/arm/mach-at91/at91sam9rl.c            |    2 +
 arch/arm/mach-at91/include/mach/at91_twi.h |   68 ----
 drivers/i2c/busses/Kconfig                 |   11 +-
 drivers/i2c/busses/i2c-at91.c              |  527 +++++++++++++++++-----------
 drivers/i2c/busses/i2c-at91.h              |   80 +++++
 12 files changed, 406 insertions(+), 295 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_twi.h
 create mode 100644 drivers/i2c/busses/i2c-at91.h

-- 
1.7.5.4
