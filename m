Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA7FC48BC2
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Jun 2021 20:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243EA610C7
	for <linux-i2c@archiver.kernel.org>; Wed, 23 Jun 2021 20:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWUv2 (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 23 Jun 2021 16:51:28 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:37152 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWUv1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Jun 2021 16:51:27 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru D8F4820A8BE4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     <linux-i2c@vger.kernel.org>
CC:     Qii Wang <qii.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 0/5] Correctly handle plaform_get_irq()'s result in the i2C
 drivers
Organization: Open Mobile Platform
Message-ID: <e51f8c48-a63e-57e4-ffc7-157c2534611b@omp.ru>
Date:   Wed, 23 Jun 2021 23:48:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Here are 5 patches against the 'i2c/for-current' branch of the Jens Axboe's 'linux-block.git' repo.
The affected drivers call platform_get_irq() but mis-interprete its result -- they consider
IRQ0 as error and (sometimes) the real error codes as valid IRQs... :-/

[1/5] i2c: hix5hd2: fix IRQ check
[2/5] i2c: mt65xx: fix IRQ check
[3/5] i2c: pmcmsp: fix-IRQ-check
[4/5] i2c: s3c2410: fix IRQ check
[5/5] i2c: xlp9xx: fix main IRQ check
