Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6A6C41513
	for <linux-i2c@archiver.kernel.org>; Wed, 16 Aug 2023 09:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbjHPJwc (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 16 Aug 2023 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243684AbjHPJwY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Aug 2023 05:52:24 -0400
Received: from mx4.sionneau.net (mx4.sionneau.net [51.15.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5201A138
        for <linux-i2c@vger.kernel.org>; Wed, 16 Aug 2023 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sionneau.net;
        s=selectormx4; t=1692179516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMxMbdFwBOEWvUhf68sum4pGRs1MhikGf4G8DoqWe9w=;
        b=OLWqHjM32YSQgSImEaii13icYN9wDIFsNp+ORu7i2aixmTqlhQzF7UKPm+cP+y8Bp/1+cl
        1f9rPjoP0VDfFw7ygMMfpxvj2UjrHLjAi0WkVOlRBtmpRFeeEZ95bPyDQ/5mbfl5aWjQu5
        2P78SZXwo3TwvHVzPCkYDYhcrhUDu+8=
Received: from [10.125.4.51] (<unknown> [109.190.253.11])
        by mx4.sionneau.net (OpenSMTPD) with ESMTPSA id c71ab25b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Aug 2023 09:51:56 +0000 (UTC)
Message-ID: <17f4ce7f-5954-519b-fc62-42655d198933@sionneau.net>
Date:   Wed, 16 Aug 2023 11:51:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] I2C: Use helper function IS_ERR_OR_NULL()
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20230816094618.2854084-1-ruanjinjie@huawei.com>
From:   Yann Sionneau <yann@sionneau.net>
In-Reply-To: <20230816094618.2854084-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Le 16/08/2023 à 11:46, Ruan Jinjie a écrit :

> Use IS_ERR_OR_NULL() instead of open-coding it
> to simplify the code.
>   
>   	rinfo->pinctrl = devm_pinctrl_get(&pdev->dev);
> -	if (!rinfo->pinctrl || IS_ERR(rinfo->pinctrl)) {
> +	if (IS_ERR_OR_NULL(rinfo->pinctrl)) {

Can the return of devm_pinctrl_get really be NULL?

Regards,

-- 

Yann

