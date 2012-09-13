From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 07:31:03 -0700
Message-ID: <871ui6f108.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
	<874nn2vpv9.fsf@deeprootsystems.com>
	<20120913053325.GC6504@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120913053325.GC6504@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Thu, 13 Sep 2012 08:33:28 +0300")
Sender: linux-omap-owner@vger.kernel.org
To: balbi@ti.com
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

Felipe Balbi <balbi@ti.com> writes:

[...]

> I just ran same tests on pandaboard and i2c is suspended actually,
> though no power domain transitions to RET. Do we not have retention
> while idle on pandaboard ?

Not for CORE.  Only CPUx and MPU domains will be transitioning on OMAP4,
and then, only with CPUidle enabled.

Until we have CORE retention support in mainline (we're almost there)
OMAP4 is not a useful test platform for device PM.

Kevin
