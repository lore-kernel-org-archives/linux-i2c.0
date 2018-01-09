From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 0/6] i2c: send STOP after recovery; use it for i2c-rcar
Date: Tue,  9 Jan 2018 14:58:53 +0100
Message-ID: <20180109135859.20771-1-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

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
infrastructure. The first five patches may be interesting for anyone, so input
is greatly appreciated. Also, testing the new features with GPIO based recovery
would be awesome to have. Thanks to Phil for testing already!

This was tested on a Renesas Lager board (r8a7790/R-Car H2). My test procedure
is documented here:

https://elinux.org/Tests:I2C-bus-recovery

A branch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/rcar-i2c-recovery

Please let me know what you think.

Changes since V1:

* add more identifiers in patch 2
* don't use GPIOF_* flags but hardocded '0'
* added Phil's Tested-by



Wolfram Sang (6):
  i2c: make kerneldoc about bus recovery more precise
  i2c: add identifier in declarations for i2c_bus_recovery
  i2c: add 'set_sda' to bus_recovery_info
  i2c: ensure SDA is released in recovery if SDA is controllable
  i2c: send STOP after successful bus recovery
  i2c: rcar: implement bus recovery

 drivers/i2c/busses/i2c-rcar.c | 54 +++++++++++++++++++++++++++++++++++++++++--
 drivers/i2c/i2c-core-base.c   | 25 +++++++++++++++++++-
 include/linux/i2c.h           | 26 ++++++++++++---------
 3 files changed, 91 insertions(+), 14 deletions(-)

-- 
2.11.0
