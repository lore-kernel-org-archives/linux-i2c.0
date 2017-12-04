From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/6] i2c: send STOP after recovery; use it for i2c-rcar
Date: Mon,  4 Dec 2017 13:36:34 +0100
Message-ID: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org

When implementing bus recovery for the i2c-rcar driver, two problems were
encountered: 1) When reading the SDA bit, not the SDA status was returned but
the internal state of the "bus_is_busy" logic. 2) This logic needs a STOP to
consider the bus free again. SCL/SDA high is not enough, and there is no other
way known to reset the internal logic otherwise.

The obvious solution to just send STOP after recovery makes sense for the
generic case, too, IMO. If we made a device release SDA again, and are about
start a new transfer using START, then we should terminate the previous state
properly with STOP. This may help with some devices and shouldn't create any
drawback AFAICS.

For this, we need to introduce a 'set_sda' callback to the recovery
infrastructure. Because of this and some other minor recovery core changes, I
CCed a few people working on I2C bus recovery recently. The first five patches
may be interesting for you, so your input is greatly appreciated. Also, testing
the new features with GPIO based recovery would be awesome to have.

This was tested on a Renesas Lager board (r8a7790/R-Car H2). My test procedure
is documented here:

https://elinux.org/Tests:I2C-bus-recovery

A branch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/rcar-i2c-recovery

Please let me know what you think.

Kind regards,

   Wolfram

Wolfram Sang (6):
  i2c: make kerneldoc about bus recovery more precise
  i2c: add identifier in declarations for i2c_bus_recovery
  i2c: add 'set_sda' to bus_recovery_info
  i2c: ensure SDA is released in recovery if SDA is controllable
  i2c: send STOP after successful bus recovery
  i2c: rcar: implement bus recovery

 drivers/i2c/busses/i2c-rcar.c | 54 +++++++++++++++++++++++++++++++++++++++++--
 drivers/i2c/i2c-core-base.c   | 25 +++++++++++++++++++-
 include/linux/i2c.h           | 20 +++++++++-------
 3 files changed, 88 insertions(+), 11 deletions(-)

-- 
2.11.0
