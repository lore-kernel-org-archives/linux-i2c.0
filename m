From: Arseny Solokha <asolokha@kb.kras.ru>
Subject: [PATCH RESEND 0/4] i2c: mpc: Clean up clock selection
Date: Thu,  7 Dec 2017 17:19:59 +0700
Message-ID: <20171207102003.23496-1-asolokha@kb.kras.ru>
References: <20171110075015.23906-1-asolokha@kb.kras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171110075015.23906-1-asolokha@kb.kras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>, Arseny Solokha <asolokha@kb.kras.ru>
List-Id: linux-i2c@vger.kernel.org

This series cleans up I2C clock selection for Freescale/NXP MPC SoCs during
the controller initialization for cases when clock settings are not to be
preserved from the bootloader.

Patch 1/4 fixes division by zero which happens during controller
initialization when (1) clock frequency is not specified in the Device
Tree, (2) preservation of clock settings from the bootloader is not
requested, and (3) the clock prescaler (which may actually depend
on the POR configuration) is not explicitly specified. It simply moves
obtaining the prescaler value before the clock computation.

Patch 2/4 unifies obtaining the prescaler value for MPC8544 with other
SoCs. It moves the relevant code to the helper function introduced
in commit 8ce795cb0c6b ("i2c: mpc: assign the correct prescaler from SVR")
and also adds handling of MPC8533 is similar to MPC8544 in this regard.

Patch 3/4 fixes checking the relevant bit in a controller's register used
for selecting the prescaler value for MPC8533 and MPC8544.

Patch 4/4 removes the facility for setting the clock prescaler value
at compile time. This facility is not used in the majority of cases. Getting
the prescaler value at run time currently covers more SoCs. Hardcoding it
is also wrong for some SoCs as it can be configured on board during POR.

This series is an exact copy of [1] which has received no feedback so far.

[1] https://marc.info/?l=linux-i2c&m=151030076114573&w=2

Arseny Solokha (4):
  i2c: mpc: get MPC8xxx I2C clock prescaler before using it in
    calculations
  i2c: mpc: unify obtaining the MPC8533/44 I2C clock prescaler w/
    MPC8xxx
  i2c: mpc: fix PORDEVSR2 mask for MPC8533/44
  i2c: mpc: always determine I2C clock prescaler at runtime

 drivers/i2c/busses/i2c-mpc.c | 72 ++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

-- 
2.15.1
