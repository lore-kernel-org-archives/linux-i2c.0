From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Date: Thu, 8 May 2008 23:43:34 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805082311410.5944@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
 <20080507085953.2c08b854@hyperion.delvare> <Pine.LNX.4.55.0805072145040.25644@cliff.in.clinika.pl>
 <20080508045106.GB25531@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080508045106.GB25531@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, Alessandro Zummo <a.zummo@towertech.it>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 8 May 2008, Ralf Baechle wrote:

> I like it; we maybe should consider getting rid of most of the libs-* stuff
> in arch/mips/Makefile.  Some of it might be causing subtle bugs such as
> routines exported to modules not getting linked into the kernel proper.

 Well, I think it should be reasonable to convert everything but lib/, the
latter being used for various implicit bits like strcpy() or whatever some
version of GCC may come up with.  Plus possibly generic code overridable
by boards for optimisation; I am not sure if we have got left any at the
moment though.

 With the much better configuration language of 2.6 and more and more 
stuff being done by magic sections bits built as libraries cause more 
hassle than convenience.

  Maciej
