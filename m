From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on Octeon
Date: Mon, 14 Nov 2016 19:50:42 +0100
Message-ID: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36017 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbcKNSv1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 14 Nov 2016 13:51:27 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so17848395wma.3
        for <linux-i2c@vger.kernel.org>; Mon, 14 Nov 2016 10:51:26 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

Hi Wolfram,

Since time is running out for 4.9 (or might have already if you're not
going to send another pull request) I'm going for the safe option
to fix the Octeon i2c problems, which is:

1. Reverting the readq_poll_timeout patch since it is broken
2. Apply Patch #2 from Paul
3. Add a small fix for the recovery that makes Paul's patch
   work on ThunderX

I'll try to come up with a better solution for 4.10. My plan is to get rid
of the polling-around-interrupt thing completely, but for that we need more
time to make it work on Octeon.

Please consider for 4.9.

thanks,
Jan

------------

Jan Glauber (2):
  Revert "i2c: octeon: thunderx: Limit register access retries"
  i2c: octeon: thunderx: TWSI software reset in recovery

Paul Burton (1):
  i2c: octeon: Fix waiting for operation completion

 drivers/i2c/busses/i2c-octeon-core.c | 66 +++++++++++-------------------------
 drivers/i2c/busses/i2c-octeon-core.h | 27 ++++++---------
 2 files changed, 30 insertions(+), 63 deletions(-)

-- 
1.9.1
