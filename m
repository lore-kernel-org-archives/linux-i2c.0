From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Date: Fri, 9 May 2008 22:38:45 +0200
Message-ID: <20080509223845.4a38d751@hyperion.delvare>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
	<20080507085953.2c08b854@hyperion.delvare>
	<Pine.LNX.4.55.0805072145040.25644@cliff.in.clinika.pl>
	<20080508105905.3209c659@hyperion.delvare>
	<Pine.LNX.4.55.0805082344040.5944@cliff.in.clinika.pl>
	<20080509092835.3bbf0f55@hyperion.delvare>
	<Pine.LNX.4.55.0805092054030.10552@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0805092054030.10552@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Alessandro Zummo <a.zummo@towertech.it>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
List-Id: linux-i2c@vger.kernel.org

Hi Maciej,

On Fri, 9 May 2008 21:27:04 +0100 (BST), Maciej W. Rozycki wrote:
>  Well, sorry, but I could only sense the lack of style in this piece of
> code, which is why I tried to apply some.

I agree, i2c-sibyte is very old code, and unmaintained, coding style is
horrible. That's one more reason to not include random style cleanups
in a patch doing functional changes, the improvement will hardly be
visible. If you care about cleaning up the code of this driver - and I
would appreciate that - please make a separate patch.

>                                            You are free to disagree and as
> you have undertaken maintenance of this area I am going to respect it.

And I thank you for that.

-- 
Jean Delvare
