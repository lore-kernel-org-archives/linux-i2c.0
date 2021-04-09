Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D02FC433B4
	for <linux-i2c@archiver.kernel.org>; Fri,  9 Apr 2021 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6386D61178
	for <linux-i2c@archiver.kernel.org>; Fri,  9 Apr 2021 19:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhDITdu (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 9 Apr 2021 15:33:50 -0400
Received: from mxout02.lancloud.ru ([45.84.86.82]:45208 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhDITdt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Apr 2021 15:33:49 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru DC9052295719
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] i2c: rcar: add IRQ check
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-i2c@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>
References: <8a05ea84-28e6-4d76-4f6d-55fb0a0cdf24@omprussia.ru>
 <20210408210448.GG1900@kunai>
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <570dbccf-ccb4-05ac-742b-f443f82e12de@omprussia.ru>
Date:   Fri, 9 Apr 2021 22:33:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210408210448.GG1900@kunai>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 4/9/21 12:04 AM, Wolfram Sang wrote:

>> +	priv->irq = ret = platform_get_irq(pdev, 0);
> 
> Please no double assignments. Otherwise good catch!

   OK, I'll come back with 5 more patches for the similar problems. :-)

MBR, Sergei
