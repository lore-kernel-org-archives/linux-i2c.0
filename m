From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] i2c: davinci: constify i2c_algorithm structure
Date: Sun, 9 Jul 2017 16:29:11 -0500
Message-ID: <20170709212911.GA30333@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gateway20.websitewelcome.com ([192.185.58.11]:31688 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752600AbdGIV3P (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 9 Jul 2017 17:29:15 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id D5032400CB871
        for <linux-i2c@vger.kernel.org>; Sun,  9 Jul 2017 16:29:11 -0500 (CDT)
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

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
 drivers/i2c/busses/i2c-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 9e7ef5c..b259fc8 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -733,7 +733,7 @@ static inline void i2c_davinci_cpufreq_deregister(struct davinci_i2c_dev *dev)
 }
 #endif
 
-static struct i2c_algorithm i2c_davinci_algo = {
+static const struct i2c_algorithm i2c_davinci_algo = {
 	.master_xfer	= i2c_davinci_xfer,
 	.functionality	= i2c_davinci_func,
 };
-- 
2.5.0
