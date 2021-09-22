Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6304CC433EF
	for <linux-i2c@archiver.kernel.org>; Wed, 22 Sep 2021 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47854611CA
	for <linux-i2c@archiver.kernel.org>; Wed, 22 Sep 2021 16:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbhIVQ6x (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:58:53 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36549 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhIVQ6x (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 22 Sep 2021 12:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1632329843; x=1663865843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AkgT5JiHWx2mZGF7DusjmOiIvbj1ToNLNU0qRyMkF2w=;
  b=DaoOUbg3Ocznz1rtezTfs2fTjXp3HocgQRMq5zlu9g5IFwPDJtOj8smj
   m6/ite9EbNlYOYQhzlEn68aBNsTX/RmyIEaC+CT+F38TXljRLwGgpwSaB
   2x/wgSQnCOAOfXvdSUHpGkv4/+BTYN6+yyjWxhqM+jrRUauLc3/H3LiS8
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 22 Sep 2021 09:57:23 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 09:57:22 -0700
Received: from localhost (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Wed, 22 Sep 2021
 09:57:21 -0700
From:   Jamie Iles <quic_jiles@quicinc.com>
To:     <linux-i2c@vger.kernel.org>
CC:     Jamie Iles <quic_jiles@quicinc.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] i2c / ACPI: fix resource leak in reconfiguration device addition
Date:   Wed, 22 Sep 2021 17:57:18 +0100
Message-ID: <20210922165718.179585-1-quic_jiles@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

acpi_i2c_find_adapter_by_handle() calls bus_find_device() which takes a
reference on the adapter which is never released which will result in a
reference count leak and render the adapter unremovable.  Make sure to
put the adapter after creating the client in the same manner that we do
for OF.

Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure notifications")
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Wolfram Sang <wsa@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Jamie Iles <quic_jiles@quicinc.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 6f0aa0ed3241..74925621f239 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -422,6 +422,7 @@ static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
 			break;
 
 		i2c_acpi_register_device(adapter, adev, &info);
+		put_device(&adapter->dev);
 		break;
 	case ACPI_RECONFIG_DEVICE_REMOVE:
 		if (!acpi_device_enumerated(adev))
-- 
2.30.2

