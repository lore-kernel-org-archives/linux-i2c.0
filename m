From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 00/10] i2c: Host Notify / i801 fixes
Date: Wed, 28 Sep 2016 10:15:39 +0200
Message-ID: <1475050549-25542-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751146AbcI1IPy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Sep 2016 04:15:54 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

this is mostly a resend of the series.

The only change is in patch 9/10, where I removed the dev_warn that could
be an issue on some laggish operations on Synaptics RMI4 devices (when
retrieving the heatmap). It also appeared that these warning were sent quite
regularly with the Elantech touchpads, so let's just disable those given
that they are mostly harmless.

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
  i2c: i801: check if Host Notify is available during interrupt
  i2c: i801: remove SMBNTFDDAT reads as they always seem to return 0

 drivers/i2c/busses/i2c-i801.c | 123 +++++++++++++++++++++++++-----------------
 drivers/i2c/i2c-smbus.c       |  25 ++++++++-
 include/linux/i2c-smbus.h     |   1 +
 3 files changed, 99 insertions(+), 50 deletions(-)

-- 
2.7.4
