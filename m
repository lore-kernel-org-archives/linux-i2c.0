From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] i2c: gpio: Augment all boardfiles to use open drain
Date: Thu, 14 Sep 2017 10:30:17 +0100
Message-ID: <20170914093017.3xqgqomzt7i7gb5m@dell>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-5-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:46075 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdINJaU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Sep 2017 05:30:20 -0400
Received: by mail-wr0-f182.google.com with SMTP id m18so5116786wrm.2
        for <linux-i2c@vger.kernel.org>; Thu, 14 Sep 2017 02:30:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170910214424.14945-5-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, adi-buildroot-devel@lists.sourceforge.net, arm@kernel.org, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Sun, 10 Sep 2017, Linus Walleij wrote:

> We now handle the open drain mode internally in the I2C GPIO
> driver, but we will get warnings from the gpiolib that we
> override the default mode of the line so it becomes open
> drain.
> 
> We can fix all in-kernel users by simply passing the right
> flag along in the descriptor table, and we already touched
> all of these files in the series so let's just tidy it up.
> 
> Cc: arm@kernel.org
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: requesting ACK for Wolfram to take this patch.
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.
> ---
>  arch/arm/mach-ep93xx/core.c                  | 6 ++++--
>  arch/arm/mach-ixp4xx/avila-setup.c           | 4 ++--
>  arch/arm/mach-ixp4xx/dsmg600-setup.c         | 4 ++--
>  arch/arm/mach-ixp4xx/fsg-setup.c             | 4 ++--
>  arch/arm/mach-ixp4xx/ixdp425-setup.c         | 4 ++--
>  arch/arm/mach-ixp4xx/nas100d-setup.c         | 4 ++--
>  arch/arm/mach-ixp4xx/nslu2-setup.c           | 4 ++--
>  arch/arm/mach-ks8695/board-acs5k.c           | 6 ++++--
>  arch/arm/mach-pxa/palmz72.c                  | 6 ++++--
>  arch/arm/mach-pxa/viper.c                    | 8 ++++----
>  arch/arm/mach-sa1100/simpad.c                | 6 ++++--
>  arch/blackfin/mach-bf533/boards/blackstamp.c | 4 ++--
>  arch/blackfin/mach-bf533/boards/ezkit.c      | 4 ++--
>  arch/blackfin/mach-bf533/boards/stamp.c      | 4 ++--
>  arch/blackfin/mach-bf561/boards/ezkit.c      | 4 ++--
>  arch/mips/alchemy/board-gpr.c                | 4 ++++
>  arch/mips/ath79/mach-pb44.c                  | 4 ++--

>  drivers/mfd/sm501.c                          | 4 ++--

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
