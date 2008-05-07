From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Date: Wed, 7 May 2008 00:08:53 -0700
Message-ID: <20080507000853.17f1316b.akpm@linux-foundation.org>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl>
	<20080507085953.2c08b854@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763938AbYEGHKh@vger.kernel.org>
In-Reply-To: <20080507085953.2c08b854@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Alessandro Zummo <a.zummo@towertech.it>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 7 May 2008 08:59:53 +0200 Jean Delvare <khali@linux-fr.org> wrote:

> I'm not sure how you intend to push these changes upstream. I would
> take a patch only touching drivers/i2c/busses/i2c-sibyte.c in my i2c
> tree, however a patch also touching arch code, must be handled be the
> maintainer for that architecture or platform.

Not "must".  The arch maintainer could ask you to merge it or you could ask
the arch maintainer to merge it.

It's some little one-line change like this one appeared to be, it's
fair to assume the arch maintainer won't care much about it.  View it as an
i2c patch?
