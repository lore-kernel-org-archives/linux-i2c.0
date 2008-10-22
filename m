From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Thu, 23 Oct 2008 02:29:40 +0400
Message-ID: <20081022222940.GA14636@oksana.dev.rtsoft.ru>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <200810221404.52798.david-b@pacbell.net> <20081022212217.GA32378@oksana.dev.rtsoft.ru> <200810221452.46786.david-b@pacbell.net>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758005AbYJVW3x@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200810221452.46786.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 22, 2008 at 02:52:46PM -0700, David Brownell wrote:
> On Wednesday 22 October 2008, Anton Vorontsov wrote:
> > >=20
> > > > So if we register the board infos after=20
> > > > the controller registered, then nobody will probe the board inf=
os.
> > >=20
> > > See above. =A0If you're doing it right, there's no problem.
> > > That is, scan the OF tables early. =A0Just like PNP tables
> > > get scanned early, for example.
> >=20
> > Heh. If we don't want to be able to make the OF-parsing code
> > be a module then there is no problem at all. I can use the bus
> > notifiers. And it is most straightforward solution then.
> >=20
> > But I quite dislike to bloat the kernel image with
> > maybe-never-used-on-this-board code.
>=20
> So have it live in the __init text section.  If you're
> building a kernel with support for several boards, you
> know it's necessarily going to be larger than it would
> be if only one board were supported.  But you can shrink
> kernel size by judicious use of __init sections..

Won't work, unfortunately. I2C devices are created by the
i2c controllers, via drivers/of_i2c.c  of_register_i2c_devices().

There is a good reason to do so, the code needs to know
controller's OF node to walk down and register the child nodes
(devices). See drivers/i2c/busses/i2c-mpc.c -- it calls
of_register_i2c_devices() at the end of the probe().

Since we can't call __init stuff from non-__init, the scheme
you purpose won't work.

The same is for SPI (drivers/of_spi.c of_register_spi_devices()).

> > My aim was to make the=20
> > OF-parsing part be a module too. Because in the long run we
> > need the OF-parsing stuff for _every_ driver that needs
> > platform data. It's quite expensive to have it always built-in,
> > don't you think?
>=20
> If it's discarded early, after translating the data from
> OF format into what the drivers need, there will be no
> RAM footprint.

There is also kernel image size that matters...

--=20
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
