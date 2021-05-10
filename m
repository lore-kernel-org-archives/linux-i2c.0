Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C6C433B4
	for <linux-i2c@archiver.kernel.org>; Mon, 10 May 2021 13:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4ED6143B
	for <linux-i2c@archiver.kernel.org>; Mon, 10 May 2021 13:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237491AbhEJNmB (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Mon, 10 May 2021 09:42:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2552 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350835AbhEJNCG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 May 2021 09:02:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ff1Lc01pRzkYK1;
        Mon, 10 May 2021 20:58:00 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 10 May 2021
 21:00:31 +0800
Subject: Re: [PATCH v2] i2c: I2C_HISI should depend on ACPI
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wei Xu <xuwei5@hisilicon.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <22d124a7f12f2c8b280a9cc7f3b766351c9a8d64.1620119167.git.geert+renesas@glider.be>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <308d0e42-33ff-4eed-3933-dededb92b723@hisilicon.com>
Date:   Mon, 10 May 2021 21:00:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <22d124a7f12f2c8b280a9cc7f3b766351c9a8d64.1620119167.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On 2021/5/4 17:06, Geert Uytterhoeven wrote:
> The HiSilicon Kunpeng I2C controller driver relies on ACPI to probe for
> its presence.  Hence add a dependency on ACPI, to prevent asking the
> user about this driver when configuring a kernel without ACPI firmware
> support.
> 
> Fixes: d62fbdb99a85730a ("i2c: add support for HiSilicon I2C controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
> v2:
>   - Drop dependency on ARCH_HISI, as this is a public IP which doesn't
>     specifically depend on ARCH_HISI.
> ---
>  drivers/i2c/busses/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index b5b4e0d0ff4dd0bc..226c0b79eac030fa 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -647,7 +647,7 @@ config I2C_HIGHLANDER
>  
>  config I2C_HISI
>  	tristate "HiSilicon I2C controller"
> -	depends on ARM64 || COMPILE_TEST
> +	depends on (ARM64 && ACPI) || COMPILE_TEST
>  	help
>  	  Say Y here if you want to have Hisilicon I2C controller support
>  	  available on the Kunpeng Server.
> 

