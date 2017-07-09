From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] i2c: designware-slave: constify i2c_algorithm structure
Date: Sun, 9 Jul 2017 16:35:17 -0500
Message-ID: <20170709213517.GA31846@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gateway20.websitewelcome.com ([192.185.58.11]:37145 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752630AbdGIVfa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 9 Jul 2017 17:35:30 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id EBC70400CC210
        for <linux-i2c@vger.kernel.org>; Sun,  9 Jul 2017 16:35:17 -0500 (CDT)
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Check for i2c_algorithm structures that are only stored in
the algo field of an i2c_adapter structure. This field is
declared const, so i2c_algorithm structures that have this
property can be declared as const also.

This issue was identified using Coccinelle and the following
semantic patch:

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct i2c_algorithm i@p = { ... };

@ok@
identifier r.i;
struct i2c_adapter e;
position p;
@@
e.algo = &i@p;

@bad@
position p != {r.p,ok.p};
identifier r.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct i2c_algorithm i = { ... };

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/i2c/busses/i2c-designware-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 4012c74..e62799e 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -344,7 +344,7 @@ static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
 	return IRQ_RETVAL(ret);
 }
 
-static struct i2c_algorithm i2c_dw_algo = {
+static const struct i2c_algorithm i2c_dw_algo = {
 	.functionality = i2c_dw_func,
 	.reg_slave = i2c_dw_reg_slave,
 	.unreg_slave = i2c_dw_unreg_slave,
-- 
2.5.0
