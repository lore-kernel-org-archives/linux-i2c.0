Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CDC433DB
	for <linux-i2c@archiver.kernel.org>; Tue, 30 Mar 2021 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5230F619BB
	for <linux-i2c@archiver.kernel.org>; Tue, 30 Mar 2021 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhC3NI6 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:08:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15828 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbhC3NIZ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 Mar 2021 09:08:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F8qT719MBz9tPJ;
        Tue, 30 Mar 2021 21:06:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 21:08:17 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <wsa@kernel.org>, <linux-i2c@vger.kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>, <digetx@gmail.com>,
        <treding@nvidia.com>, <jarkko.nikula@linux.intel.com>,
        <rmk+kernel@armlinux.org.uk>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <yangyicong@hisilicon.com>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 0/4] Add support for HiSilicon I2C controller
Date:   Tue, 30 Mar 2021 21:05:45 +0800
Message-ID: <1617109549-4013-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Add driver and MAINTAINERS for HiSilicon I2C controller on Kunpeng SoC. Also
provide the devm_*() variants for adding the I2C adapters and a public
api to provide I2C frequency mode strings.

Change since v3:
- split the bus mode string api to I2C as suggested by Andy
- simplify the devm variants and change the export format
- address the comments of the HiSilicon I2C driver from Andy and Dmitry, thanks!
Link: https://lore.kernel.org/linux-i2c/1616411413-7177-1-git-send-email-yangyicong@hisilicon.com/

Change since v2:
- handle -EPROBE_DEFER case when get irq number by platform_get_irq()
Link: https://lore.kernel.org/linux-i2c/1615296137-14558-1-git-send-email-yangyicong@hisilicon.com/

Change since v1:
- fix compile test error on 32bit arch, reported by intel lkp robot:
  64 bit division without using kernel wrapper in probe function.
Link:https://lore.kernel.org/linux-i2c/1615016946-55670-1-git-send-email-yangyicong@hisilicon.com/

Yicong Yang (4):
  i2c: core: add managed function for adding i2c adapters
  i2c: core: add api to provide frequency mode strings
  i2c: add support for HiSilicon I2C controller
  MAINTAINERS: Add maintainer for HiSilicon I2C driver

 MAINTAINERS                   |   7 +
 drivers/i2c/busses/Kconfig    |  10 +
 drivers/i2c/busses/Makefile   |   1 +
 drivers/i2c/busses/i2c-hisi.c | 510 ++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c   |  26 +++
 include/linux/i2c.h           |  21 ++
 6 files changed, 575 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-hisi.c

-- 
2.8.1

