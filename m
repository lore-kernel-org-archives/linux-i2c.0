From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 0/2] i2c: fix compile failures
Date: Tue, 28 Nov 2017 11:09:09 +0800
Message-ID: <1511838551-4035-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:45920 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751623AbdK1DJX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 22:09:23 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, preid@electromag.com.au, linux-i2c@vger.kernel.org, sfr@canb.auug.org.au

This fixes the 2 compile issues related to my series:
"i2c: designware: add i2c gpio recovery option"

I'm not sure if you want patches on top of i2c/for-next or a 
respin of the series. I'm sure you'll let me know.

I've got some particular combination of Kconfig flags that
is pulling gpio/consumer.h into the i2c-core-base, but I can't
see what it is.

And I didn't pick up that the designware driver was split into 
two separate modules. oops.


Phil Reid (2):
  i2c: core: fix compile issue related to incorrect gpio header
  i2c: designware: fix building driver as module

 drivers/i2c/busses/i2c-designware-common.c | 1 +
 drivers/i2c/i2c-core-base.c                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
1.8.3.1
