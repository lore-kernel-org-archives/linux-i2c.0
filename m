From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 0/5] i2c: octeon,thunderx: Recovery fixes and improvements
Date: Wed, 21 Sep 2016 08:51:01 +0200
Message-ID: <cover.1474439371.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

the ThunderX i2c driver got more exposure with IPMI/BMC testing and
we've found several issues that I'd like to address with this series.

The patches are all related to recovery or improve stability in
the presence of hardware/firmware bugs.

Patches are against linux-next and were tested on ThunderX and Octeon
(by Steven J. Hill).

thanks,
Jan

--------------

Dmitry Bazhenov (2):
  i2c: octeon,thunderx: Fix set SCL recovery function
  i2c: octeon,thunderx: Avoid sending STOP during recovery

Jan Glauber (3):
  i2c: octeon,thunderx: Fix high-level controller status check
  i2c: octeon,thunderx: Check bus state before starting a transaction
  i2c: octeon,thunderx: Limit register access retries

 drivers/i2c/busses/i2c-octeon-core.c | 67 ++++++++++++++++++++++++++++--------
 drivers/i2c/busses/i2c-octeon-core.h | 21 ++++++++---
 2 files changed, 68 insertions(+), 20 deletions(-)

-- 
1.9.1
