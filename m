From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] i2c-cht-wc: Workaround CHT GPIO controller IRQ issues
Date: Mon, 14 Aug 2017 22:17:26 +0200
Message-ID: <20170814201726.21045-4-hdegoede@redhat.com>
References: <20170814201726.21045-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbdHNURd (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 16:17:33 -0400
In-Reply-To: <20170814201726.21045-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org

The Cherry Trail Whiskey Cove PMIC's IRQ line is attached to one of
the GPIOs of the Cherry Trail SoC. The CHT GPIO controller sometimes
fails to deliver IRQs (seen when there is an IRQ storm on another pin).

This commit works around this by reducing the long timeout which was
a poor attempt to workaround this from 3s to 30ms and after that
manually checking the status register for transfer completion by
calling the threaded IRQ handler directly.

This is safe todo as the entire threaded IRQ handler is protected
by a mutex.

Note 30ms should be more then long enough, at 100KHz any smbus single
byte transaction should be finished in 4ms.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/i2c-cht-wc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 11f7e516f1b1..21312eed09e4 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -158,10 +158,16 @@ static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16 addr,
 	if (ret)
 		return ret;
 
-	/* 3 second timeout, during cable plug the PMIC responds quite slow */
-	ret = wait_event_timeout(adap->wait, adap->done, 3 * HZ);
-	if (ret == 0)
-		return -ETIMEDOUT;
+	ret = wait_event_timeout(adap->wait, adap->done, msecs_to_jiffies(30));
+	if (ret == 0) {
+		/*
+		 * The CHT GPIO controller serializes all IRQs, sometimes
+		 * causing significant delays, check status manually.
+		 */
+		cht_wc_i2c_adap_thread_handler(0, adap);
+		if (!adap->done)
+			return -ETIMEDOUT;
+	}
 
 	ret = 0;
 	mutex_lock(&adap->adap_lock);
-- 
2.13.4
