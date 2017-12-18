From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/7] i2c: sh_mobile: support per-SoC frequency calculation
Date: Mon, 18 Dec 2017 22:57:55 +0100
Message-ID: <20171218215802.28591-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

The current calculation for I2C bus speeds does not match the datasheet and is,
in deed, a little too fast for 100kHz settings (~107kHz have been measured).

This series implements a second calculation according to the datasheet. In
order to not cause regressions on the various old SoCs, using this new formula
is opt-in per SoC. Once the new formula has been verified to work, we can
switch over. By default, the old behaviour is retained.

So, the first patches are refactoring the driver to support per-SoC frequency
calculations. This is done by making the already existing per-SoC
setup()-callback mandatory and let the frequency calculation be done in there.

This series has been tested on a R-Car H2 Lager board (r8a7790). The computed
values match the suggested values in the datasheet. Also, measurements showed
that the bus frequency is now 100kHz. For 400 kHz, the overall bus speed did
not change much, but the low-to-high relationship is now matching the
datasheet, too.

This series is RFC because I think we need to discuss when to enable a SoC to
the new formula. For Lager, I did some basic checking but did not run a full
V4L testsuite or other complex configurations making use of I2C clients. Gen3,
in theory, should be easier to test because only the PMIC and an EEPROM are
connected to IIC_DVFS. However, there are no testpoints available for measuring
on Salvator-X(S). And the suggested values in the datasheet do not match the
module clock we have. Do ULCB boards maybe have testpoints for IIC_DVFS? For
Lager, it could be argued that the resulting speed is slower than before which
should not introduce regressions. But I am open to discussion here.

A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/iic-refactor

Thanks, and looking forward to comments

   Wolfram


Wolfram Sang (7):
  i2c: sh_mobile: move type detection upwards
  i2c: sh_mobile: allow setup callback to return errno
  i2c: sh_mobile: require setup callback
  i2c: sh_mobile: let RuntimePM do the clock handling
  i2c: sh_mobile: add helper to check frequency calculations
  i2c: sh_mobile: add new frequency calculation for later SoC
  i2c: sh_mobile: let r8a7790 (R-Car H2) use the new formula

 drivers/i2c/busses/i2c-sh_mobile.c | 117 ++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 48 deletions(-)

-- 
2.11.0
