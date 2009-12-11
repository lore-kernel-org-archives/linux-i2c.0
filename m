From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] i2c: Drop the kind parameter from detect callbacks
Date: Fri, 11 Dec 2009 10:18:23 +0100
Message-ID: <20091211101823.7cdc9c8a@hyperion.delvare>
References: <20091210185221.641bbaab@hyperion.delvare>
	<20091210221208.GA18155@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091210221208.GA18155-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 10 Dec 2009 23:12:08 +0100, Wolfram Sang wrote:
> On Thu, Dec 10, 2009 at 06:52:21PM +0100, Jean Delvare wrote:
> > The "kind" parameter always has value -1, and nobody is using it any
> > longer, so we can remove it.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> Yay, I am all for this series! Build tested all hwmon-modules on x86. Will try
> to find a non-x86 board tomorrow which is actually using one of the hwmon
> devices.
> 
> Tested-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks for testing! FWIW, I had already built-tested all drivers on
x86. Run-time tests are still welcome, and so are build tests (and, to
a lesser extent, run-time tests) on other architectures.

-- 
Jean Delvare
