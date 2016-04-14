From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 0/4] i2c: designware: runtime pm fix and improve
Date: Thu, 14 Apr 2016 20:53:30 +0800
Message-ID: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-i2c@vger.kernel.org

This series tries to fix one hang issue during probe found on arm
platform, and unbalanced clk enable prepare issue. Then applies similar
change as commit 36d48fb5766a ("i2c: designware-platdrv: enable
RuntimePM before registering to the core"), lastly remove the runtime
suspend prevention in i2c_dw_probe().


Jisheng Zhang (4):
  i2c: designware-platdrv: Fix runtime PM initialization
  i2c: designware-platdrv: fix unbalanced clk enable and prepare
  i2c: designware-pcidrv: enable RuntimePM before registering to the
    core
  i2c: designware: remove runtime suspend prevention during registration

 drivers/i2c/busses/i2c-designware-core.c    |  8 --------
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 11 +++++++----
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 +++++++++++++++-
 3 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.8.0.rc3
