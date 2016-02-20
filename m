From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/6] i2c: sort includes for the core
Date: Sat, 20 Feb 2016 23:38:45 +0100
Message-ID: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55899 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992806AbcBTWjC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 20 Feb 2016 17:39:02 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

If drivers must do it, the core should do it as well: keep the includes sorted
to make it hard to duplicate entries :)

Plain sorting, nothing has been added or removed.


Wolfram Sang (6):
  i2c: i2c-boardinfo: sort includes
  i2c: i2c-core: sort includes
  i2c: i2c-dev: sort includes
  i2c: i2c-mux: sort includes
  i2c: i2c-smbus: sort includes
  i2c: i2c-stub: sort includes

 drivers/i2c/i2c-boardinfo.c |  6 +++---
 drivers/i2c/i2c-core.c      | 30 +++++++++++++++---------------
 drivers/i2c/i2c-dev.c       | 14 +++++++-------
 drivers/i2c/i2c-mux.c       |  8 ++++----
 drivers/i2c/i2c-smbus.c     |  8 ++++----
 drivers/i2c/i2c-stub.c      |  8 ++++----
 6 files changed, 37 insertions(+), 37 deletions(-)

-- 
2.7.0
