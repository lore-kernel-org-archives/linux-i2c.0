Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB25C43600
	for <linux-i2c@archiver.kernel.org>; Wed, 31 Mar 2021 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9A8619C9
	for <linux-i2c@archiver.kernel.org>; Wed, 31 Mar 2021 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhCaNjh (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 31 Mar 2021 09:39:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15420 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhCaNjQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 Mar 2021 09:39:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9S6c0VCdzlWpP;
        Wed, 31 Mar 2021 21:37:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 21:39:01 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <wsa@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-i2c@vger.kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <linux-kernel@vger.kernel.org>
CC:     <digetx@gmail.com>, <treding@nvidia.com>,
        <jarkko.nikula@linux.intel.com>, <rmk+kernel@armlinux.org.uk>,
        <song.bao.hua@hisilicon.com>, <john.garry@huawei.com>,
        <mika.westerberg@linux.intel.com>, <yangyicong@hisilicon.com>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v6 4/5] MAINTAINERS: Add maintainer for HiSilicon I2C driver
Date:   Wed, 31 Mar 2021 21:36:29 +0800
Message-ID: <1617197790-30627-5-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617197790-30627-1-git-send-email-yangyicong@hisilicon.com>
References: <1617197790-30627-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Add maintainer for HiSilicon I2C driver.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d23b0e..da2754a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8040,6 +8040,13 @@ F:	drivers/crypto/hisilicon/hpre/hpre.h
 F:	drivers/crypto/hisilicon/hpre/hpre_crypto.c
 F:	drivers/crypto/hisilicon/hpre/hpre_main.c
 
+HISILICON I2C CONTROLLER DRIVER
+M:	Yicong Yang <yangyicong@hisilicon.com>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+W:	https://www.hisilicon.com
+F:	drivers/i2c/busses/i2c-hisi.c
+
 HISILICON LPC BUS DRIVER
 M:	john.garry@huawei.com
 S:	Maintained
-- 
2.8.1

