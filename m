From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-algo-bit: Complain about masters which can't
 read SCL
Date: Tue, 7 Dec 2010 16:29:33 +0100
Message-ID: <20101207162933.3ad206a8@endymion.delvare>
References: <20101207110705.69792a1a@endymion.delvare>
	<20101207121009.GD10722@sirena.org.uk>
	<20101207123011.GO20097@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101207123011.GO20097-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Marc, Ben,

On Tue, 7 Dec 2010 12:30:11 +0000, Ben Dooks wrote:
> On Tue, Dec 07, 2010 at 12:10:10PM +0000, Mark Brown wrote:
> > On Tue, Dec 07, 2010 at 11:07:05AM +0100, Jean Delvare wrote:
> > > The I2C specification explicitly describes both SDA and SCL as
> > > bidirectional lines. An I2C master with a read-only SCL is thus not
> > > compliant. If a slow slave stretches the clock, errors will happen,
> > > so the bus can't be considered as reliable.
> > > 
> > > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > 
> > It'd be good to also flag this via sysfs so that it's more readily
> > visible to things like diagnostic tools.

In what form do you expect this, and what do you expect diagnostic
tools to do about it?

I can't think of anything straightforward and useful. We could abuse
one functionality flag for unreliable masters, but then this is a
boolean flag, with no way to report the actual problem to the customer.
And write-only SCL is only one thing they can do wrongly.

> Could be, I wonder how many other hardware based adapters just don't
> do this. Quite a few devices i've seen don't use it as they're generally
> fast enough, or implement some other status polling system.

I don't know either, and I didn't mean to provide a general solution to
this problem as I have no clue so far that a general problem exists.
This patch is in response to the thread started by Matthias Zacharias
where we were troubleshooting his I2C bus problems. I just wanted to
make sure that the same problem doesn't happen again, i.e. developers
don't set getscl to NULL in the hope that it will help in any way.

I don't know of that many pieces of hardware driven by i2c-algo-bit and
not having a bidirectional SCL line. In fact I only know of the
i2c-parport, i2c-parport-light and i2c-gpio drivers doing this, and
then again, only for some of the supported devices. So I'm not sure
there is much point in spending a lot of time on this.

Or, to make it clearer, you can spend as much time as _you_ want on
this, but I won't. I'm busy enough as is.

-- 
Jean Delvare
