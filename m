From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 00/10] i2c: designware-platdrv: Some improvments related to PM
Date: Tue, 14 Jun 2016 17:07:18 +0200
Message-ID: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35836 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcFNPHq (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Jun 2016 11:07:46 -0400
Received: by mail-lf0-f45.google.com with SMTP id u74so106490952lff.2
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jun 2016 08:07:44 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Here's a couple changes for the i2c-designware driver. Most of them a related to
the support for runtime PM and system PM, but there's also a few that improves
some error handling.

I have tested these on Hisilicon Linaro 96-board (hi6220). I used a couple local
changes to enable the power-key to act as a wakeup in system PM suspend state.
If anyone are interested about those as well, I am happy to share them.

Ulf Hansson (10):
  i2c: designware-platdrv: Return error in ->probe() when clk ungate
    fails
  i2c: designware-platdrv: Gate clk in error path in ->probe()
  i2c: designware-platdrv: Unconditionally enable runtime PM
  i2c: designware-platdrv: Disable autosuspend in error path in
    ->probe()
  i2c: designware-platdrv: Fix clk gating in ->remove()
  i2c: designware-platdrv: Update runtime PM last busy mark in ->probe()
  i2c: designware-platdrv: Re-init the HW when resuming
  i2c: designware-platdrv: Check return value from clk_prepare_enable()
  i2c: designware-platdrv: Simplify code by using dev_get_drvdata()
  i2c: designware-platdrv: Rework system PM support

 drivers/i2c/busses/i2c-designware-platdrv.c | 106 +++++++++++++---------------
 1 file changed, 50 insertions(+), 56 deletions(-)

-- 
1.9.1
