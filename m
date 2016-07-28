From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/5] i2c: Host Notify / i801 fixes
Date: Thu, 28 Jul 2016 11:50:38 +0200
Message-ID: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753642AbcG1Jus (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 05:50:48 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

this series comes to fix most of the remarks from Jean after reviewing my
Host Notify series.

I couldn't find a better way for 1/5 to automatically kill the workqueue, so
I am open to any suggestions.
Regarding 3/5 (use of BIT), I am pretty sure I did not mess up, but I'd be glad
to have an extra eye on the various hex to BIT changes.

Cheers,
Benjamin

Benjamin Tissoires (5):
  i2c: i2c-smbus: prevent races on remove when Host Notify is used
  i2c: i801: minor formatting issues
  i2c: i801: use BIT() macro for bits definition
  i2c: i801: do not report an error if FEATURE_HOST_NOTIFY is not set
  i2c: i801: warn on i2c_handle_smbus_host_notify() errors

 drivers/i2c/busses/i2c-i801.c | 93 ++++++++++++++++++++++++++-----------------
 drivers/i2c/i2c-smbus.c       | 18 +++++++++
 include/linux/i2c-smbus.h     |  1 +
 3 files changed, 76 insertions(+), 36 deletions(-)

-- 
2.5.5
