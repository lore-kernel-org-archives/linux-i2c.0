From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 5/6] RTC: SMBus support for the M41T80, etc. driver (#2)
Date: Sun, 18 May 2008 00:31:57 +0900 (JST)
Message-ID: <20080518.003157.126143021.anemo@mba.ocn.ne.jp>
References: <Pine.LNX.4.55.0805130254420.535@cliff.in.clinika.pl>
	<20080513140444.49d7a044@hyperion.delvare>
	<Pine.LNX.4.55.0805131752340.7267@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757289AbYEQPa5@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0805131752340.7267@cliff.in.clinika.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: macro@linux-mips.org
Cc: khali@linux-fr.org, a.zummo@towertech.it, akpm@linux-foundation.org, dwmw2@infradead.org, ralf@linux-mips.org, tglx@linutronix.de, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 13 May 2008 17:57:52 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > You will do this even if all the registers were read as a block and the
> > RTC latched the register values so they have to be correct. Isn't it a
> > bit unfair / inefficient? If client->adapter has the
> > I2C_FUNC_SMBUS_READ_I2C_BLOCK functionality you can skip the comparison
> > and retry mechanism completely, saving some time and CPU cycles.
> 
>  Well, actually there is a reason beyond that.  It may change if we
> support subsecond resolution, but we currently do not.  The reason is if
> we return the original timestamp and the seconds register changes while
> the timestamp is being read, then effectively we return a value that is
> off by one second.  This is why for seconds I decided to return the second
> value read all the time.

I suppose the "off by one second" issue is not the matter each driver
should take care of.  This race is common for most RTC chip.

I do not have strong opinion for optimization suggested by Jean.  It
might be better, but I'm OK with current your patch.

---
Atsushi Nemoto
