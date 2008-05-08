From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Date: Thu, 8 May 2008 05:51:06 +0100
Message-ID: <20080508045106.GB25531@linux-mips.org>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl> <20080507085953.2c08b854@hyperion.delvare> <Pine.LNX.4.55.0805072145040.25644@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0805072145040.25644@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, Alessandro Zummo <a.zummo@towertech.it>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 07, 2008 at 10:13:23PM +0100, Maciej W. Rozycki wrote:

>  Ralf -- what do you think about the Makefile changes?  I can send you a 
> separate patch which will reduce the span of this one.

I like it; we maybe should consider getting rid of most of the libs-* stuff
in arch/mips/Makefile.  Some of it might be causing subtle bugs such as
routines exported to modules not getting linked into the kernel proper.

  Ralf
