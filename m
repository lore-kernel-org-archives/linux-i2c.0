From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] misc: apds990x: move header file out of I2C realm
Date: Mon, 22 May 2017 16:29:31 +0200
Message-ID: <CAK8P3a2CfOPNe5KnSWb=xf_0YTtN6aQRwNthQXEDb9YgOrLMaw@mail.gmail.com>
References: <20170521204233.6745-1-wsa@the-dreams.de> <20170521204233.6745-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35614 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933917AbdEVO3d (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 10:29:33 -0400
In-Reply-To: <20170521204233.6745-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, May 21, 2017 at 10:42 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/misc/apds990x.c                         | 2 +-
>  include/linux/{i2c => platform_data}/apds990x.h | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename include/linux/{i2c => platform_data}/apds990x.h (100%)
>
> diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
> index dfb72ecfa60461..c341164edaad01 100644
> --- a/drivers/misc/apds990x.c
> +++ b/drivers/misc/apds990x.c
> @@ -32,7 +32,7 @@
>  #include <linux/delay.h>
>  #include <linux/wait.h>
>  #include <linux/slab.h>
> -#include <linux/i2c/apds990x.h>
> +#include <linux/platform_data/apds990x.h>

The new location is clearly better than the old, but I notice that in both
patches, there is not a single definition for the platform_data structure
in the kernel and both drivers refuse to load when they do not get
passed valid platform_data.

Should we also remove the drivers or move them into staging?

       Arnd
