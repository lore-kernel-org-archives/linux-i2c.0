From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 0/2] i2c: designware: add i2c gpio recovery option
Date: Fri, 16 Jun 2017 15:42:55 +0800
Message-ID: <1497598977-37622-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:42176 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752134AbdFPHnL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 16 Jun 2017 03:43:11 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, tim@krieglstein.org, linux-i2c@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

Changes from V1:
- In review Andy suggested change the i2c core to use the gpiod
  I've added a patch that allows the gradual switching of drivers 
  to using gpiod interface. The old interface is preserved so
  that changes can be made incrementally.
- I've update Tim's patch for the designware driver to use the new
  interface. Tweaked a couple of things to his patch and fixed
  up things Andy id in last review. 
  The core changes in p1 don't require the get/set scl/sda functions.
  Hopefully I've done the right thing with preserving authorship and
  signoff.

Phil Reid (1):
  i2c: Switch to using gpiod interface for gpio bus recovery

Tim Sander (1):
  i2c: designware: add i2c gpio recovery option

 drivers/i2c/busses/i2c-designware-core.c    | 12 ++++--
 drivers/i2c/busses/i2c-designware-core.h    |  1 +
 drivers/i2c/busses/i2c-designware-platdrv.c | 58 +++++++++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c                 | 22 +++++++++--
 include/linux/i2c.h                         |  2 +
 5 files changed, 88 insertions(+), 7 deletions(-)

-- 
1.8.3.1
