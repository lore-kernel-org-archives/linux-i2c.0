Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8287BC433E5
	for <linux-i2c@archiver.kernel.org>; Tue, 30 Mar 2021 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D430619CE
	for <linux-i2c@archiver.kernel.org>; Tue, 30 Mar 2021 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhC3NJA (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:09:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15400 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhC3NIc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 30 Mar 2021 09:08:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8qTg5fPRznTlP;
        Tue, 30 Mar 2021 21:06:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 21:08:18 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <wsa@kernel.org>, <linux-i2c@vger.kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>, <digetx@gmail.com>,
        <treding@nvidia.com>, <jarkko.nikula@linux.intel.com>,
        <rmk+kernel@armlinux.org.uk>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <yangyicong@hisilicon.com>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v4 2/4] i2c: core: add api to provide frequency mode strings
Date:   Tue, 30 Mar 2021 21:05:47 +0800
Message-ID: <1617109549-4013-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617109549-4013-1-git-send-email-yangyicong@hisilicon.com>
References: <1617109549-4013-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Some I2C drivers like Designware and HiSilicon will print the
bus frequency mode information, so add a public one that everyone
can make use of.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 include/linux/i2c.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 10bd0b0..6837e64 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -47,6 +47,26 @@ typedef int (*i2c_slave_cb_t)(struct i2c_client *client,
 #define I2C_MAX_HIGH_SPEED_MODE_FREQ	3400000
 #define I2C_MAX_ULTRA_FAST_MODE_FREQ	5000000
 
+static inline const char *i2c_freq_mode_string(u32 bus_freq_hz)
+{
+	switch (bus_freq_hz) {
+	case I2C_MAX_STANDARD_MODE_FREQ:
+		return "Standard Mode(100KHz)";
+	case I2C_MAX_FAST_MODE_FREQ:
+		return "Fast Mode(400KHz)";
+	case I2C_MAX_FAST_MODE_PLUS_FREQ:
+		return "Fast Mode Plus(1.0MHz)";
+	case I2C_MAX_TURBO_MODE_FREQ:
+		return "Turbo Mode(1.4MHz)";
+	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
+		return "High Speed Mode(3.4MHz)";
+	case I2C_MAX_ULTRA_FAST_MODE_FREQ:
+		return "Ultra Fast Mode(5.0MHz)";
+	default:
+		return "Unknown Mode";
+	}
+}
+
 struct module;
 struct property_entry;
 
-- 
2.8.1

