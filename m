From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Drop the kind parameter from detect callbacks
Date: Fri, 11 Dec 2009 15:24:06 +0100
Message-ID: <20091211152406.57438401@hyperion.delvare>
References: <20091210185221.641bbaab@hyperion.delvare>
	<20091210221208.GA18155@pengutronix.de>
	<20091211101823.7cdc9c8a@hyperion.delvare>
	<20091211135657.GC4400@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091211135657.GC4400-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 11 Dec 2009 14:56:57 +0100, Wolfram Sang wrote:
> > Thanks for testing! FWIW, I had already built-tested all drivers on
> > x86. Run-time tests are still welcome, and so are build tests (and, to
> > a lesser extent, run-time tests) on other architectures.
> 
> HWMON modules build also fine for powerpc. No runtime-tests yet, and I probably
> can't make that today :(

OK, thanks. No hurry, I don't plan to send these patches to Linus
before Sunday afternoon... and more probably Monday evening.

-- 
Jean Delvare
