From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] i2c: designware-pci: refactor and add Merrifield support
Date: Wed, 15 Jun 2016 18:05:04 +0300
Message-ID: <1466003107-19375-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55395 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435AbcFOPF5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 15 Jun 2016 11:05:57 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested on bare metal (Intel Edison) by enumerating I2C GPIO expanders.

In v2:
- leave bus 3 at STD speed for Medfield
- be consistent with workflow, i.e. call ->setup, and _then_ assign to i2c
  properties
- add a comment to explain magic numbers for Merrifield
- add an Ack for patch 3

Andy Shevchenko (3):
  i2c: designware-pci: Make bus number allocation robust
  i2c: designware-pci: Introduce Merrifield support
  i2c: designware-pci: Sort header block alphabetically

 drivers/i2c/busses/i2c-designware-core.h   |   1 +
 drivers/i2c/busses/i2c-designware-pcidrv.c | 143 +++++++++++++++++------------
 2 files changed, 86 insertions(+), 58 deletions(-)

-- 
2.8.1
