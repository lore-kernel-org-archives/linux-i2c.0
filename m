Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A2C433B4
	for <linux-i2c@archiver.kernel.org>; Thu, 15 Apr 2021 15:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BC16117A
	for <linux-i2c@archiver.kernel.org>; Thu, 15 Apr 2021 15:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhDOPxV (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:53:21 -0400
Received: from mxout02.lancloud.ru ([45.84.86.82]:48744 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhDOPxU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 15 Apr 2021 11:53:20 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru EA24023345B8
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 6/6] i2c: sh7760: add IRQ check
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     <linux-i2c@vger.kernel.org>
References: <7995bba1-61dd-baa3-51ea-0fb2fccc19a0@omprussia.ru>
 <4cbffdae-f4c3-04b2-ca9b-387e7721386d@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <58fe3ab6-7b9d-98a4-39a0-98344097f805@omprussia.ru>
Date:   Thu, 15 Apr 2021 18:52:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4cbffdae-f4c3-04b2-ca9b-387e7721386d@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 4/10/21 11:25 PM, Sergey Shtylyov wrote:

> The driver neglects to check the result of platform_get_irq()'s call and
> blithely passes the negative error codes to devm_request_irq() (which
> takes *unsigned* IRQ #), causing it to fail with -EINVAL, overriding
> an original error code.  Stop calling devm_request_irq() with invalid
> IRQ #s.
> 
> Fixes: a26c20b1fa6d ("i2c: Renesas SH7760 I2C master driver")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
> 
> ---
> Changes in version 2:
> - new patch.
> 
>  drivers/i2c/busses/i2c-sh7760.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: linux/drivers/i2c/busses/i2c-sh7760.c
> ===================================================================
> --- linux.orig/drivers/i2c/busses/i2c-sh7760.c
> +++ linux/drivers/i2c/busses/i2c-sh7760.c
> @@ -471,7 +471,10 @@ static int sh7760_i2c_probe(struct platf
>  		goto out2;
>  	}
>  
> -	id->irq = platform_get_irq(pdev, 0);
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0)
> +		return ret;

   Should have been *goto* out3. Sorry for my overlook! :-/

[...]

MBR, Sergey
