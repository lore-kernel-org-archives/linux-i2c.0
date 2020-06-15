Return-Path: <SRS0=Ss3W=74=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86529C433E0
	for <linux-i2c@archiver.kernel.org>; Mon, 15 Jun 2020 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627FC2078A
	for <linux-i2c@archiver.kernel.org>; Mon, 15 Jun 2020 16:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgFOQKG (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:10:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:10251 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730426AbgFOQKF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jun 2020 12:10:05 -0400
IronPort-SDR: 0XO9SOSxtRmO/Jh/QJt/wwedf2LWsNxJCjKRVQWEIr89n7SAgs4EgPMbFprFkJQCa/8Eyy1Ton
 U6mh0Wo1xfJQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 09:10:05 -0700
IronPort-SDR: PDvHwgkhgTxxdnLdULzYFZgJMoUFbv2+uaz1OfaVVwMkIwXJl5iyCqT8HL8N0Q2EWgdasd9K+s
 sqMEPtcT4PSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="316947606"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2020 09:10:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8412B217; Mon, 15 Jun 2020 19:10:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] i2c: ismt: Add support for Intel Emmitsburg PCH
Date:   Mon, 15 Jun 2020 19:10:01 +0300
Message-Id: <20200615161001.12817-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Add PCI ID for the Intel Emmitsburg PCH iSMT SMBus controller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-ismt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 2f95e25a10f7..cdba77f9ecb1 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -77,6 +77,7 @@
 #define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
 #define PCI_DEVICE_ID_INTEL_CDF_SMT	0x18ac
 #define PCI_DEVICE_ID_INTEL_DNV_SMT	0x19ac
+#define PCI_DEVICE_ID_INTEL_EBG_SMT	0x1bff
 #define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
 
 #define ISMT_DESC_ENTRIES	2	/* number of descriptor entries */
@@ -184,6 +185,7 @@ static const struct pci_device_id ismt_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CDF_SMT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_EBG_SMT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
 	{ 0, }
 };
-- 
2.27.0.rc2

