From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch] add pca9543 driver
Date: Fri, 27 Mar 2009 15:17:44 +0100
Message-ID: <20090327151744.5422b2b5@hyperion.delvare>
References: <1238078818-25977-1-git-send-email-os@emlix.com>
	<20090326155105.5dfbd898@hyperion.delvare>
	<20090326162315.GA26255@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090326162315.GA26255-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 26 Mar 2009 17:23:15 +0100, Oskar Schirmer wrote:
> On Thu, Mar 26, 2009 at 15:51:05 +0100, Jean Delvare wrote:
> > On Thu, 26 Mar 2009 15:46:58 +0100, Oskar Schirmer wrote:
> > > support pca9543 i2c bus switch chip
> > > 
> > > Signed-off-by: Oskar Schirmer <os-QdrG9jWwCLEAvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  drivers/i2c/chips/Kconfig   |    3 +
> > >  drivers/i2c/chips/Makefile  |    1 +
> > 
> > Please read the header of these two files carefully again.
> 
> Ok, I see. But how to have PCA9543 supported then?
> The PCA9543 is an I2C bus switch/mux, so following
> the headers it might be placed in drivers/<functionality>,
> where <functionality> is "i2c bus mux", thus drivers/i2c.

We could consider creating drivers/i2c/muxes or similar for I2C
multiplexer drivers, especially if we start supporting many of them.

> As this is obviously not the solution, we might try to do the
> bus muxing manually from userland, as soon as the system is up.

"From userland" is exactly what your driver is doing, and this is
clearly not acceptable. You can't do userland switching and let the
kernel instantiate devices, as you found out yourself, which means that
such multiplexed buses would only support userland-created devices
(that is, i2c-dev.) This is way too limited to spend time on it.

> This wont work either, as the video drivers need the i2c bus
> switch programmed before the video stuff can be initialized,
> thus during bootup.
> 
> Next, the drivers proposed by Rodolfo Giometti
> ( http://article.gmane.org/gmane.linux.drivers.i2c/2996/ )
> might add the functionality needed.

It's not that they "might", rather they are _exactly_ what you need.

> As far as I can see from
> Documentation/feature-removal-schedule.txt, prerequisites for
> it to be accepted are given with 2.6.30, is the driver by
> Rodolfo still in the queue, i.e. being merged for 2.6.30 now?

Unfortunately not, I'm still working on the prerequisite in question
and I _hope_ to have that done in 2.6.30, but Rodolfo's work won't make
it in time. Which does not mean you shouldn't look at it, see how it
works for you, and report to Rodolfo. The more people help him cleanup
and improve his code, the easier and faster it will be when the time
finally comes to merge it.

-- 
Jean Delvare
