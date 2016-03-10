From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/2] i2c: i801: Add runtime PM support
Date: Thu, 10 Mar 2016 14:12:20 +0200
Message-ID: <1457611942-8405-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17470 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbcCJMMa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Mar 2016 07:12:30 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Reinette Chatre <reinette.chatre@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Motivation here is to help newer SoCs to reach deeper runtime sleep
states by suspending the SMBUS device with 1 second autosuspend delay
when it is idle.

This is ought to work on both cases where SMBUS PCI device does and
doesn't have PM capabilities. PCI core won't power down the device at
runtime if it doesn't have PM capabilities. We have tested these both
cases, although platforms were quite recent ones.

Jarkko Nikula (2):
  i2c: i801: Convert to struct dev_pm_ops for suspend/resume
  i2c: i801: Add runtime PM support with autosuspend

 drivers/i2c/busses/i2c-i801.c | 52 +++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

-- 
2.7.0
