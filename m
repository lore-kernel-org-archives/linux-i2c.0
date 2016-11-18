From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/2] i2c: designware: report short transfers
Date: Fri, 18 Nov 2016 19:40:04 +0000
Message-ID: <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40354 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbcKRTkK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Nov 2016 14:40:10 -0500
In-Reply-To: <20161118193542.GO1041@n2100.armlinux.org.uk>
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rather than reporting success for a short transfer due to interrupt
latency, report an error both to the caller, as well as to the kernel
log.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/i2c/busses/i2c-designware-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 9703fe392543..c53058d6139c 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -758,7 +758,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
 	/* no error */
-	if (likely(!dev->cmd_err)) {
+	if (likely(!dev->cmd_err && !dev->status)) {
 		ret = num;
 		goto done;
 	}
@@ -768,6 +768,11 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 		ret = i2c_dw_handle_tx_abort(dev);
 		goto done;
 	}
+
+	if (dev->status)
+		dev_err(dev->dev,
+			"transfer terminated early - interrupt latency too high?\n");
+
 	ret = -EIO;
 
 done:
-- 
2.7.4
