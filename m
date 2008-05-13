From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 3/6] RTC: SWARM I2C board initialization (#2)
Date: Tue, 13 May 2008 19:17:32 +0200
Message-ID: <20080513191732.259d0ab2@hyperion.delvare>
References: <Pine.LNX.4.55.0805130249230.535@cliff.in.clinika.pl>
	<20080513133416.59a8d943@hyperion.delvare>
	<Pine.LNX.4.55.0805131747590.7267@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0805131747590.7267@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, David Woodhouse <dwmw2@infradead.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 13 May 2008 17:51:32 +0100 (BST), Maciej W. Rozycki wrote:
> > >  I have renamed i2c-swarm.c to swarm-i2c.c for consistency with names 
> > > of other files under arch/mips/.
> > 
> > But you forgot to update the log message accordingly...
> 
>  I did not, unless I am missing something.

		printk(KERN_ERR
		       "i2c-swarm: cannot register board I2C devices\n");

> > >  Please note this patch trivially depends on
> > > patch-2.6.26-rc1-20080505-swarm-core-16 -- 2/6 of this set.
> > 
> > OK, so I should just wait for patch 2/6 to get upstream before I add
> > this one to my i2c tree?
> 
>  Either this or you can apply both and remove the local copy of the former
> when it comes back from upstream.  Whatever you prefer -- it is your
> choice.

I don't really want to include a mips arch patch in my public i2c tree,
that would be confusing. I think I'll just wait. I have the mips patch
in my local tree, so quilt will tell me when it hits upstream.

-- 
Jean Delvare
