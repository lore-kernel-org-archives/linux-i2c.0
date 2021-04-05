Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F285C433B4
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 14:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140296139E
	for <linux-i2c@archiver.kernel.org>; Mon,  5 Apr 2021 14:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhDEOev (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 5 Apr 2021 10:34:51 -0400
Received: from mxout02.lancloud.ru ([45.84.86.82]:52430 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbhDEOeu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Apr 2021 10:34:50 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 4CA2E233D890
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] i2c: rcar: add IRQ check
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-i2c@vger.kernel.org>
CC:     <linux-renesas-soc@vger.kernel.org>
References: <8a05ea84-28e6-4d76-4f6d-55fb0a0cdf24@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <31fdbb1b-4e1a-9af4-f805-afd2f739fca4@omprussia.ru>
Date:   Mon, 5 Apr 2021 17:34:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8a05ea84-28e6-4d76-4f6d-55fb0a0cdf24@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 4/4/21 8:52 PM, Sergey Shtylyov wrote:

> The driver neglects to check the result of platform_get_irq()'s call and
> blithely passes the negative error codes to devm_request_irq() (which
> takes *unsigned* IRQ #), causing it to fail with -EINVAL, overriding
> an original error code.  Stop calling devm_request_irq() with the
> invalid IRQ #s.
> 
> Fixes: 6ccbe607132b ("i2c: add Renesas R-Car I2C driver")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>

   Sorry, forgot to mention that this patch is against the 'master' branch of
Wolfram's 'linux.git' repo...

MBR, Sergey
