From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 5/6] RTC: SMBus support for the M41T80, etc. driver (#2)
Date: Sat, 17 May 2008 21:46:35 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805172134420.10067@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805130254420.535@cliff.in.clinika.pl>
 <20080513140444.49d7a044@hyperion.delvare> <Pine.LNX.4.55.0805131752340.7267@cliff.in.clinika.pl>
 <20080518.003157.126143021.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20080518.003157.126143021.anemo@mba.ocn.ne.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: khali@linux-fr.org, a.zummo@towertech.it, akpm@linux-foundation.org, dwmw2@infradead.org, ralf@linux-mips.org, tglx@linutronix.de, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 18 May 2008, Atsushi Nemoto wrote:

> I suppose the "off by one second" issue is not the matter each driver
> should take care of.  This race is common for most RTC chip.

 I agree, but with the reread it comes for free here.  Given you have two 
values of seconds available here, which one would you choose?  You can't 
take both at once. ;-)

> I do not have strong opinion for optimization suggested by Jean.  It
> might be better, but I'm OK with current your patch.

 Hmm, it looks as simple as putting a clause like:

	if (i2c_check_functionality(client->adapter, 
				    I2C_FUNC_SMBUS_READ_I2C_BLOCK)
		break;

into the loop and even at 400kHz it saves a considerable amount of time.
It sounds plausible -- I'll do that.

  Maciej
