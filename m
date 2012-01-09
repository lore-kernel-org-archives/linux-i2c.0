From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: i2c: add third maintainer
Date: Mon, 9 Jan 2012 09:10:29 +0100
Message-ID: <20120109091029.120c8e82@endymion.delvare>
References: <1326065816-12463-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1326065816-12463-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon,  9 Jan 2012 00:36:56 +0100, Wolfram Sang wrote:
> Add me as a third maintainer to help out in the i2c subsystem.

Thanks a lot for stepping in! We can definitely take some help :)

> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

I'll push the patch myself by the end of the week if there are no
objections.

> ---
> 
> No extra repo for now to avoid fragmentation. I will send pull requests to
> either Jean or Ben as needed. Sounds OK?

Yes, we can begin that way and see how it goes.

> 
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c00e3cc..d4e3d62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3191,6 +3191,7 @@ F:	drivers/i2c/busses/i2c-stub.c
>  I2C SUBSYSTEM
>  M:	"Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>  M:	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> +M:	"Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  W:	http://i2c.wiki.kernel.org/
>  T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/

This one no longer works, BTW, I'll have to update it.

Thanks again,
-- 
Jean Delvare
