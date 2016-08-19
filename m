From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 00/10] i2c: Host Notify / i801 fixes
Date: Fri, 19 Aug 2016 15:27:32 +0200
Message-ID: <1471613262-20682-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754167AbcHSN27 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 19 Aug 2016 09:28:59 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I finally managed to free some time to do a refresh of this series.

I had to add some patches to keep the rev-by from Jean, and also
because it was making more sense to have those remarks in their own
patch.

Cheers,
Benjamin

Benjamin Tissoires (10):
  i2c: i2c-smbus: prevent races on remove when Host Notify is used
  i2c: i801: store and restore the SLVCMD register at load and unload
  i2c: i801: minor formatting issues
  i2c: i801: use BIT() macro for bits definition
  i2c: i801: use the BIT() macro for FEATURES_* also
  i2c: i801: do not report an error if FEATURE_HOST_NOTIFY is not set
  i2c: i2c-smbus: remove double warning message
  i2c: i2c-smbus: fix return value of i2c_handle_smbus_host_notify()
  i2c: i801: warn on i2c_handle_smbus_host_notify() errors
  i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0

 drivers/i2c/busses/i2c-i801.c | 124 ++++++++++++++++++++++++++----------------
 drivers/i2c/i2c-smbus.c       |  25 ++++++++-
 include/linux/i2c-smbus.h     |   1 +
 3 files changed, 100 insertions(+), 50 deletions(-)

-- 
2.5.5
