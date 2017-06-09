From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH] i2c: xgene-slimpro: include linux/io.h for memremap
Date: Fri, 9 Jun 2017 10:27:38 -0700
Message-ID: <CAFHUOYyFdK-D4pEeJZJTejxJtAnSuWF8MhLcOiuzFbR2pT++Bw@mail.gmail.com>
References: <20170609102937.3054567-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yb0-f172.google.com ([209.85.213.172]:32840 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdFIR1j (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Jun 2017 13:27:39 -0400
Received: by mail-yb0-f172.google.com with SMTP id 202so17161043ybd.0
        for <linux-i2c@vger.kernel.org>; Fri, 09 Jun 2017 10:27:39 -0700 (PDT)
In-Reply-To: <20170609102937.3054567-1-arnd@arndb.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches <ludovic.desroches@microchip.com>, Tin Huynh <tnhuynh@apm.com>, linux-i2c@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Hi Arnd,

On Fri, Jun 9, 2017 at 3:29 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added support for the pcc mailbox fails to build
> in some configurations:
>
> drivers/i2c/busses/i2c-xgene-slimpro.c: In function 'xgene_slimpro_i2c_probe':
> drivers/i2c/busses/i2c-xgene-slimpro.c:516:25: error: implicit declaration of function 'memremap'; did you mean 'memcmp'? [-Werror=implicit-function-declaration]
> drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: error: 'MEMREMAP_WB' undeclared (first use in this function)
> drivers/i2c/busses/i2c-xgene-slimpro.c:518:13: note: each undeclared identifier is reported only once for each function it appears in
>
> This includes the missing header file.
>
> Fixes: df5da47fe722 ("i2c: xgene-slimpro: Add ACPI support by using PCC mailbox")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
> index 8e5c8f28bc8b..7e89ba6fcf6f 100644
> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
> @@ -27,6 +27,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> --
> 2.9.0
>

Reviewed-by: Hoan Tran <hotran@apm.com>

Thanks
Hoan
