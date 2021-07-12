Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217CEC07E99
	for <linux-i2c@archiver.kernel.org>; Mon, 12 Jul 2021 14:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0524F60FF3
	for <linux-i2c@archiver.kernel.org>; Mon, 12 Jul 2021 14:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhGLONp (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:13:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:19690 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhGLONn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Jul 2021 10:13:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209961572"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="209961572"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 07:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="459191111"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 12 Jul 2021 07:10:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CA9BFFF; Mon, 12 Jul 2021 17:11:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v2 1/1] i2c: parport: Switch to use module_parport_driver()
Date:   Mon, 12 Jul 2021 17:11:19 +0300
Message-Id: <20210712141119.22426-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Switch to use module_parport_driver() to reduce boilerplate code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation error (Jean, LKP)
 drivers/i2c/busses/i2c-parport.c | 36 ++++++++++----------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index a535889acca6..231145c48728 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -267,6 +267,16 @@ static void i2c_parport_attach(struct parport *port)
 	int i;
 	struct pardev_cb i2c_parport_cb;
 
+	if (type < 0) {
+		pr_warn("adapter type unspecified\n");
+		return;
+	}
+
+	if (type >= ARRAY_SIZE(adapter_parm)) {
+		pr_warn("invalid type (%d)\n", type);
+		return;
+	}
+
 	for (i = 0; i < MAX_DEVICE; i++) {
 		if (parport[i] == -1)
 			continue;
@@ -392,32 +402,8 @@ static struct parport_driver i2c_parport_driver = {
 	.detach = i2c_parport_detach,
 	.devmodel = true,
 };
-
-/* ----- Module loading, unloading and information ------------------------ */
-
-static int __init i2c_parport_init(void)
-{
-	if (type < 0) {
-		pr_warn("adapter type unspecified\n");
-		return -ENODEV;
-	}
-
-	if (type >= ARRAY_SIZE(adapter_parm)) {
-		pr_warn("invalid type (%d)\n", type);
-		return -ENODEV;
-	}
-
-	return parport_register_driver(&i2c_parport_driver);
-}
-
-static void __exit i2c_parport_exit(void)
-{
-	parport_unregister_driver(&i2c_parport_driver);
-}
+module_parport_driver(i2c_parport_driver);
 
 MODULE_AUTHOR("Jean Delvare <jdelvare@suse.de>");
 MODULE_DESCRIPTION("I2C bus over parallel port");
 MODULE_LICENSE("GPL");
-
-module_init(i2c_parport_init);
-module_exit(i2c_parport_exit);
-- 
2.30.2

