Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2DEC07E9A
	for <linux-i2c@archiver.kernel.org>; Mon, 12 Jul 2021 14:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25D561026
	for <linux-i2c@archiver.kernel.org>; Mon, 12 Jul 2021 14:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhGLOZ4 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:25:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:20600 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235031AbhGLOZ4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 12 Jul 2021 10:25:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209963377"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="209963377"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 07:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="429662454"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 12 Jul 2021 07:23:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F2A31B7; Mon, 12 Jul 2021 17:23:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v1 2/2] i2c: dev: Use sysfs_emit() in "show" functions
Date:   Mon, 12 Jul 2021 17:23:23 +0300
Message-Id: <20210712142323.23118-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712142323.23118-1-andriy.shevchenko@linux.intel.com>
References: <20210712142323.23118-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The sysfs_emit() function was introduced to make it less ambiguous
which function is preferred when writing to the output buffer in
a "show" callback [1].

Convert the I²C device sysfs interface from sprintf() to sysfs_emit()
accordingly, as the latter is aware of the PAGE_SIZE buffer and correctly
returns the number of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 6cf98c06653a..e2b1aba96401 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -102,7 +102,7 @@ static ssize_t name_show(struct device *dev,
 
 	if (!i2c_dev)
 		return -ENODEV;
-	return sprintf(buf, "%s\n", i2c_dev->adap->name);
+	return sysfs_emit(buf, "%s\n", i2c_dev->adap->name);
 }
 static DEVICE_ATTR_RO(name);
 
-- 
2.30.2

