From: Weifeng Voon <weifeng.voon@intel.com>
Subject: [PATCH 0/5] i2c: designware: Enable fast mode plus and high speed
Date: Thu, 26 May 2016 16:01:07 +0800
Message-ID: <1464249672-24566-1-git-send-email-weifeng.voon@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jui.nee.tan@intel.com
List-Id: linux-i2c@vger.kernel.org

Enabled fast mode plus and high speed which supported by APL SoC.

Weifeng Voon (5):
  i2c: designware: Move clk_freq into struct dw_i2c_dev
  i2c: designware: get fast plus and high speed *CNT configuration
  i2c: designware: Enable fast mode plus
  i2c: designware: set the common config before the if else
  i2c: designware: Enable high speed mode

 drivers/i2c/busses/i2c-designware-core.c    | 33 +++++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h    | 12 +++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 39 +++++++++++++++++++----------
 3 files changed, 68 insertions(+), 16 deletions(-)

-- 
1.9.1
