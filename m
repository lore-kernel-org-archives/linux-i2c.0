Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C994C43460
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 09:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E950613BD
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 09:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhDEJDe (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 5 Apr 2021 05:03:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15540 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhDEJDd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Apr 2021 05:03:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FDPky5dqDzPnpm
        for <linux-i2c@vger.kernel.org>; Mon,  5 Apr 2021 17:00:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 5 Apr 2021 17:03:23 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <linux-i2c@vger.kernel.org>
Subject: [PATCH drivers/i2c 0/3] Fix ERRORs reported by checkpatch
Date:   Mon, 5 Apr 2021 17:03:47 +0800
Message-ID: <1617613430-11921-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Fix ERRORs reported by checkpatch, no functional changes.

Tian Tao (3):
  i2c: amd8111: Fix coding style issues
  i2c: iop3xx: Fix coding style issues
  i2c: nomadik: Fix space errors

 drivers/i2c/busses/i2c-amd8111.c | 268 +++++++++++++++++++--------------------
 drivers/i2c/busses/i2c-iop3xx.c  |  28 ++--
 drivers/i2c/busses/i2c-nomadik.c |   4 +-
 3 files changed, 151 insertions(+), 149 deletions(-)

-- 
2.7.4

