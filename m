From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 02/15] i2c: taos-evm: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 16:21:36 +0200
Message-ID: <20171031142149.32512-2-andriy.shevchenko@linux.intel.com>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbdJaOVx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 31 Oct 2017 10:21:53 -0400
In-Reply-To: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jean Delvare <jdelvare@suse.com>

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Cc: Jean Delvare <jdelvare@suse.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-taos-evm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
index addd90a8cb59..7c7fc01116a1 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -282,8 +282,7 @@ static void taos_disconnect(struct serio *serio)
 {
 	struct taos_data *taos = serio_get_drvdata(serio);
 
-	if (taos->client)
-		i2c_unregister_device(taos->client);
+	i2c_unregister_device(taos->client);
 	i2c_del_adapter(&taos->adapter);
 	serio_close(serio);
 	kfree(taos);
-- 
2.14.2
