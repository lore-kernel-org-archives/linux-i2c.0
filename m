From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/6] i2c: ensure SDA is released in recovery if SDA is controllable
Date: Mon,  4 Dec 2017 13:36:38 +0100
Message-ID: <20171204123640.3382-5-wsa+renesas@sang-engineering.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44208 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752837AbdLDMhh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 07:37:37 -0500
In-Reply-To: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>

If we have a function to control SDA, we should ensure that SDA is not
held down by us. So, release the GPIO in this case.

Cc: Phil Reid <preid@electromag.com.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index f4313801a0aaba..dae7f4a783dbe4 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -170,6 +170,8 @@ int i2c_generic_scl_recovery(struct i2c_adapter *adap)
 		bri->prepare_recovery(adap);
 
 	bri->set_scl(adap, val);
+	if (bri->set_sda)
+		bri->set_sda(adap, 1);
 	ndelay(RECOVERY_NDELAY);
 
 	/*
-- 
2.11.0
