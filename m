From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/6] i2c: add identifier in declarations for i2c_bus_recovery
Date: Mon,  4 Dec 2017 13:36:36 +0100
Message-ID: <20171204123640.3382-3-wsa+renesas@sang-engineering.com>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44193 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752121AbdLDMhQ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Dec 2017 07:37:16 -0500
In-Reply-To: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Phil Reid <preid@electromag.com.au>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>

No reason to have them undefined, so let's add them.

Cc: Phil Reid <preid@electromag.com.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f8a9d81e911e52..8a020617b4e780 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -561,9 +561,9 @@ struct i2c_timings {
 struct i2c_bus_recovery_info {
 	int (*recover_bus)(struct i2c_adapter *);
 
-	int (*get_scl)(struct i2c_adapter *);
-	void (*set_scl)(struct i2c_adapter *, int val);
-	int (*get_sda)(struct i2c_adapter *);
+	int (*get_scl)(struct i2c_adapter *adap);
+	void (*set_scl)(struct i2c_adapter *adap, int val);
+	int (*get_sda)(struct i2c_adapter *adap);
 
 	void (*prepare_recovery)(struct i2c_adapter *);
 	void (*unprepare_recovery)(struct i2c_adapter *);
-- 
2.11.0
