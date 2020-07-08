Return-Path: <SRS0=MHRG=AT=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7958CC433E4
	for <linux-i2c@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5D3206DF
	for <linux-i2c@archiver.kernel.org>; Wed,  8 Jul 2020 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594222990;
	bh=faaFtAwdn5ulgFqYuEGAZuBize4Fl3s5R+QYmSR16Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cunERef4fckLhEFe9UBNWGCbFOC7KjnGoeTmlRDloNRpwerBbKqO9VizN1wYsAqTR
	 O6cMN00qwLdyYS96zjyt1v+le94gqH5AHEugYQ4gwH7x8BKmeWWbqyfK9Z56x5FH+t
	 jgwLt8t1AfacsSpDGBR/kSvVvh5xd/D6sRK0jSvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgGHPl6 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbgGHPl4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 8 Jul 2020 11:41:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54668207D0;
        Wed,  8 Jul 2020 15:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222916;
        bh=faaFtAwdn5ulgFqYuEGAZuBize4Fl3s5R+QYmSR16Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDPLvlEtKGqqQy/cf2jwCwSh7Vl7HzeTf4wSNvoetKoAQe5SzMfdPPZzDTOyYhkj5
         8Bkh3kCBWCKf24/6Im8CMn4NVSAGqI/a8xYpqZ2gE96/Wes+OEb4ylYpXJfypidR48
         Pc0gB/npn+5RtusGc7gEO2dY38moaMxYsjeFa4d4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/16] i2c: eg20t: Load module automatically if ID matches
Date:   Wed,  8 Jul 2020 11:41:35 -0400
Message-Id: <20200708154135.3199907-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708154135.3199907-1-sashal@kernel.org>
References: <20200708154135.3199907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5f90786b31fb7d1e199a8999d46c4e3aea672e11 ]

The driver can't be loaded automatically because it misses
module alias to be provided. Add corresponding MODULE_DEVICE_TABLE()
call to the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-eg20t.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index bb810dee8fb5e..73f139690e4e5 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -180,6 +180,7 @@ static const struct pci_device_id pch_pcidev_id[] = {
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), 1, },
 	{0,}
 };
+MODULE_DEVICE_TABLE(pci, pch_pcidev_id);
 
 static irqreturn_t pch_i2c_handler(int irq, void *pData);
 
-- 
2.25.1

