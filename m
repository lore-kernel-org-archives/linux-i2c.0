From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/2] i2c: designware: Post-slave mode support patches
Date: Wed, 28 Jun 2017 17:23:27 +0300
Message-ID: <20170628142329.14818-1-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2993 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdF1OZg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Jun 2017 10:25:36 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Luis Oliveira <lolivei@synopsys.com>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hi Luis

I noticed couple minor things after review. Here are patches.

Jarkko Nikula (2):
  i2c: designware: Make HW init functions static
  i2c: designware: Let slave adapter support be optional

 drivers/i2c/busses/Kconfig                 | 1 -
 drivers/i2c/busses/i2c-designware-core.h   | 6 ++++--
 drivers/i2c/busses/i2c-designware-master.c | 7 +++----
 drivers/i2c/busses/i2c-designware-slave.c  | 3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.11.0
