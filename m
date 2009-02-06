From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add missing KERN_* constants to printks
Date: Fri, 6 Feb 2009 19:35:42 +0100
Message-ID: <20090206183542.GB6361@strlen.de>
References: <498C3EEA.5060508@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <498C3EEA.5060508-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
Cc: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Feb 06, 2009 at 02:45:14PM +0100, Frank Seidel wrote:
> From: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
> 
> According to kerneljanitors todo list all printk calls (beginning
> a new line) should have an according KERN_* constant.
> Those are the missing pieces here for the i2c subsystem.
OK in principle.  Still *I* prefer the pr_debug, pr_emerg etc. macros.
Looks a bit nicer ...

> --- a/drivers/i2c/algos/i2c-algo-pca.c
> +++ b/drivers/i2c/algos/i2c-algo-pca.c
> @@ -51,7 +51,7 @@ static int i2c_debug;
>  static void pca_start(struct i2c_algo_pca_data *adap)
>  {
>  	int sta = pca_get_con(adap);
> -	DEB2("=== START\n");
> +	DEB2(KERN_WARNING "=== START\n");
Are you sure about KERN_WARNING?  I havn't looked deeper, but DEB2
suggests KERN_DEBUG?  What about fixing DEB[1-3] directly instead of
each "call".  e.g.

-#define DEB2(fmt, args...) do { if (i2c_debug>=2) printk(fmt, ## args); } while(0)
+#define DEB2(fmt, args...) do { if (i2c_debug>=2) pr_warning(fmt, ## args); } while(0)

Best regards,
Uwe
