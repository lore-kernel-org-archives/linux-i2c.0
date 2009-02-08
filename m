From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: add missing KERN_* constants to printks
Date: Sun, 8 Feb 2009 14:47:51 +0100
Message-ID: <20090208144751.46184041@hyperion.delvare>
References: <498C3EEA.5060508@suse.de>
	<20090208000553.059a0732@hyperion.delvare>
	<498EDA18.1090300@f-seidel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498EDA18.1090300-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
Cc: Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>, linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, ukleinek-jNDFPZUTrfROceuj71AUlABBhMqQ4zRThC4ANOJQIlc@public.gmane.org, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 08 Feb 2009 14:11:52 +0100, Frank Seidel wrote:
> Hi,
> 
> Jean Delvare wrote:
> >> +	printk(KERN_ERR "i2c: ICR: %08x ISR: %08x\n"
> >>  	       "i2c: log: ", readl(_ICR(i2c)), readl(_ISR(i2c)));
> >>  	for (i = 0; i < i2c->irqlogidx; i++)
> >>  		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
> > 
> > This last printk also lacks a log level. You can't add it in the loop,
> > but you could add one printk before the loop, printing just the log level.
> 
> Isn't the last printk just a followup of the previous KERN_ERR which
> doesn't have a newline? And i'm told only on new line beginnings the
> loglevel should be set.

I mean the (first) printk in the loop, not the last printk in this
function. So what I am suggesting is:

+	printk(KERN_DEBUG);
	for (i = 0; i < i2c->irqlogidx; i++)
		printk("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
	printk("\n");

-- 
Jean Delvare
