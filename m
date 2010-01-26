From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
Date: Tue, 26 Jan 2010 14:37:03 +0000
Message-ID: <20100126143703.GB12774@fluff.org.uk>
References: <1264411234-5400-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1264411234-5400-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe Kleine-K??nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 25, 2010 at 10:20:34AM +0100, Uwe Kleine-K??nig wrote:
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
> Hello,
> 
> I wonder if it makes sence to split the "I2C SUBSYSTEM" entry into
> something like:
> 
> 	I2C SUBSYSTEM (PC drivers, core)
> 	M:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 	L:	...
> 	W:	...
> 	T:	quilt ...
> 	S:	...
> 	F:	Documentation/i2c/
> 	F:	drivers/i2c/
> 	F:	include/linux/i2c.h
> 	F:	include/linux/i2c-*.h
> 
> 	I2C SUBSYSTEM (embedded platforms)
> 	M:	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 	L:	...
> 	W:	...
> 	T:	git ...
> 	S:	...
> 	F:	drivers/i2c/
> 	F:	include/linux/i2c-*.h
> 
> (I'm not entirely sure about the file patterns for the 2nd entry.)

We might be able to add each driver individually, but that would mean
updating the entry with each driver added, and that sounds too much
like hard work (sorry, receipie for merge conflict)
 
> Best regards
> Uwe
> 
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1858646..a1813fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2629,6 +2629,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  W:	http://i2c.wiki.kernel.org/
>  T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/
> +T:	git git://git.fluff.org/bjdooks/linux.git
>  S:	Maintained
>  F:	Documentation/i2c/
>  F:	drivers/i2c/
> -- 
> 1.6.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
