From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: use <linux/io.h> instead of <asm/io.h>
Date: Mon, 10 May 2010 19:55:24 +0200
Message-ID: <20100510195524.3dabcdd2@hyperion.delvare>
References: <0D753D10438DA54287A00B0270842697636ECB4E89@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0D753D10438DA54287A00B0270842697636ECB4E89-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 6 May 2010 12:53:57 -0500, H Hartley Sweeten wrote:
> As warned by checkpatch.pl, <linux/io.h> should be used instead of
> <asm.io.h>.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> 
> ---
> 
> diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
> index bd8f1e4..906a3ca 100644
> --- a/drivers/i2c/busses/i2c-ali1535.c
> +++ b/drivers/i2c/busses/i2c-ali1535.c
> @@ -60,7 +60,7 @@
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/acpi.h>
> -#include <asm/io.h>
> +#include <linux/io.h>
> (...)

Applied, thanks.

-- 
Jean Delvare
