From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] MAINTAINERS: add git URL for at24
Date: Mon, 18 Dec 2017 18:44:06 +0100
Message-ID: <CAMRc=MfoVgNT6D+ad_xGtvabD95dAC9BQzeduyw8jiPxzhHj0g@mail.gmail.com>
References: <20171213113031.8668-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34045 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934072AbdLRRoH (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 18 Dec 2017 12:44:07 -0500
Received: by mail-oi0-f65.google.com with SMTP id u193so11120285oie.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 Dec 2017 09:44:07 -0800 (PST)
In-Reply-To: <20171213113031.8668-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>

2017-12-13 12:30 GMT+01:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> Add the link to my git tree to the at24 section.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af54fa0837..edaf9802a11f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2262,6 +2262,7 @@ F:        include/linux/async_tx.h
>  AT24 EEPROM DRIVER
>  M:     Bartosz Golaszewski <brgl@bgdev.pl>
>  L:     linux-i2c@vger.kernel.org
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/eeprom/at24.txt
>  F:     drivers/misc/eeprom/at24.c
> --
> 2.15.1
>

Patch applied.
