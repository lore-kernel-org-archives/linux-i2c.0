Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A7DC4708C
	for <linux-i2c@archiver.kernel.org>; Fri, 28 May 2021 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3120D61378
	for <linux-i2c@archiver.kernel.org>; Fri, 28 May 2021 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhE1VFh (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Fri, 28 May 2021 17:05:37 -0400
Received: from mxout01.lancloud.ru ([45.84.86.81]:47646 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1VFh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 28 May 2021 17:05:37 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 May 2021 17:05:37 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru B9AEF209D4BF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH0/2] Fix deferred probing in the I2C bus drivers
To:     Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        <linux-i2c@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
References: <dfa042b7-8b80-ee2b-451b-7cedaeadfd02@omprussia.ru>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <eda766e5-3ce3-81ec-52b4-df75297b9941@omp.ru>
Date:   Fri, 28 May 2021 23:57:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <dfa042b7-8b80-ee2b-451b-7cedaeadfd02@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Hello~

On 4/17/21 11:57 PM, Sergey Shtylyov wrote:

> Here are 2 patches against the 'i2c/for-current' branch of Wolfram's 'linux.git' repo.
> The affected drivers call platform_get_irq() but override its result in case of error
> which prevents the deferred probing from working.
> 
> [1/2] i2c: iop3xx: fix deferred probing
> [2/2] i2c: synquacer: fix deferred probing

   Please hold on with this series; I'm gonna add another patch...

MBR, Sergey
