From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add missing KERN_* constants to printks
Date: Sat, 7 Feb 2009 11:52:19 +0100
Message-ID: <20090207105219.GA12371@strlen.de>
References: <498C3EEA.5060508@suse.de> <20090206183542.GB6361@strlen.de> <498C96B0.7050408@suse.de> <20090206222314.6c2b36f7@hyperion.delvare> <498D647C.8070107@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <498D647C.8070107-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 07, 2009 at 11:37:48AM +0100, Frank Seidel wrote:
> Jean Delvare wrote:
> > Default log level? That's news to me. Care to elaborate?
> 
> printk (in kernel/printk.c) uses vprintk and vprintk:
> asmlinkage int vprintk(const char *fmt, va_list args)
> {
>         int printed_len = 0;
>         int current_log_level = default_message_loglevel;
> ...
> and default_message_loglevel in include/linux/kernel.h:
> 
> #define default_message_loglevel (console_printk[1])
> 
> and console_printk[1] is (in kernel/printk.c)
> DEFAULT_MESSAGE_LOGLEVEL
> 
> and in kernel/printk.c:
> #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
> 
> => so as far as i could see KERN_WARNING is the
> default loglevel of messages.
one little note:  This is changable writing to /proc/sys/kernel/printk.

So the patch introduces at least a little change in behaviour.
IMHO this is OK though.

Best regards
Uwe
