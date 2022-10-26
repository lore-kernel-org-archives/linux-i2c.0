Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D2FA3741
	for <linux-i2c@archiver.kernel.org>; Wed, 26 Oct 2022 12:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiJZMkZ (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbiJZMjs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 26 Oct 2022 08:39:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED8240AD
        for <linux-i2c@vger.kernel.org>; Wed, 26 Oct 2022 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666787983; x=1698323983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LA9a+YnE7wf4Tj6Rq9h09p2BZcXUOTg4rilgMle90yA=;
  b=PWQz/YIqLu6eSkrAC7Zv7C75vBdBajiljQG7CIujAog9kMdJC0Ffhb8Z
   7dgc+gW71MmPXOuV1kv3LajQGtZgLAfCE5MVeKeVy/JYHRVnXLUa7+TAA
   6eomJHrnlSnnI40UNHUsQ2/6F/WSILp2pBumrvm6NlxGg8w2H6AYMgKra
   23jwX031BV7u8444MQVLoohar3itmI031qzcZOBsoNHYSKvg1pdw4xRt5
   s+hiBCkuM8j+Psc3BCOE5ae0cOj9kn6S8zRDb1IU6T1UhQjrGR6Zgwj99
   li6B89kE4PVuaDiMRpZWhSQFRfcpG5GylcHXpLzPeXmGns0z5UrPeSi57
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="309625030"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="309625030"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="700908656"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="700908656"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.55])
  by fmsmga004.fm.intel.com with ESMTP; 26 Oct 2022 05:39:40 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Michael Wu <michael.wu@vatics.com>, Tian Ye <tianye@sugon.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 04/11] i2c: designware: Remove needless initializations from i2c_dw_reg_slave()
Date:   Wed, 26 Oct 2022 15:39:05 +0300
Message-Id: <20221026123912.2833271-5-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221026123912.2833271-1-jarkko.nikula@linux.intel.com>
References: <20221026123912.2833271-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

These struct dw_i2c_dev members are not used in i2c-designware-slave.c
so remove re-initialization of them from i2c_dw_reg_slave().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-slave.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 84eb0bec70fa..421a604bf68f 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -78,13 +78,7 @@ static int i2c_dw_reg_slave(struct i2c_client *slave)
 
 	__i2c_dw_enable(dev);
 
-	dev->cmd_err = 0;
-	dev->msg_write_idx = 0;
-	dev->msg_read_idx = 0;
-	dev->msg_err = 0;
 	dev->status = 0;
-	dev->abort_source = 0;
-	dev->rx_outstanding = 0;
 
 	return 0;
 }
-- 
2.35.1

