From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Date: Thu, 8 May 2008 05:57:41 +0100
Message-ID: <20080508045741.GC25531@linux-mips.org>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl> <20080507090514.3a86cf4b@hyperion.delvare> <Pine.LNX.4.64.0805070936060.6341@anakin> <20080507094343.25f279b9@hyperion.delvare> <Pine.LNX.4.55.0805072214090.25644@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0805072214090.25644@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alessandro Zummo <a.zummo@towertech.it>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 07, 2008 at 10:25:08PM +0100, Maciej W. Rozycki wrote:

> > > > i2c-foo.c is consistently used for i2c bus driver themselves so far.
> > > > It's somewhat confusing to see you name platform code that way. It's
> > > > also redundant, given that the file lives in the swarm platform
> > > > directory. May I suggest naming this file just
> > > > arch/mips/sibyte/swarm/i2c.c? Other architectures (cris, arm) are doing
> > > > this already.

>  I can do that and I have considered it while preparing the change.  What
> convinced me not to use a name that is already present elsewhere in the
> tree is the confusion that it sometimes causes.  For example during a
> debugging session GDB only reports the file name and not the leading
> pathname (and some people do run GDB over the kernel).  Of course the
> actual file can still be chased with some `find' and `grep' scriptery, but
> why to create a problem in the first place?
> 
>  I consider repeated file names throughout a tree of a single program a 
> namespace pollution similar to one with repeated static symbol names.  
> While syntactically valid and working, it asks for unnecessary confusion.
> 
>  This is my point of view, but I can see others may not necessarily follow
> it.  I am fine with changing the name to i2c.c as it is unlikely I will
> run GDB over it. ;-)

I've started using unique prefixes such as ip22- or ip27- a while ago.
And why not following that example with arch/mips/sibyte/swarm/swarm-i2c.c
or similar?

  Ralf
