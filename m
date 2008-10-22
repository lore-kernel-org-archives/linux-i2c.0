From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 14:52:46 -0700
Message-ID: <200810221452.46786.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <200810221404.52798.david-b@pacbell.net> <20081022212217.GA32378@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754448AbYJVVxB@vger.kernel.org>
In-Reply-To: <20081022212217.GA32378@oksana.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 22 October 2008, Anton Vorontsov wrote:
> >=20
> > > So if we register the board infos after=20
> > > the controller registered, then nobody will probe the board infos=
=2E
> >=20
> > See above. =A0If you're doing it right, there's no problem.
> > That is, scan the OF tables early. =A0Just like PNP tables
> > get scanned early, for example.
>=20
> Heh. If we don't want to be able to make the OF-parsing code
> be a module then there is no problem at all. I can use the bus
> notifiers. And it is most straightforward solution then.
>=20
> But I quite dislike to bloat the kernel image with
> maybe-never-used-on-this-board code.

So have it live in the __init text section.  If you're
building a kernel with support for several boards, you
know it's necessarily going to be larger than it would
be if only one board were supported.  But you can shrink
kernel size by judicious use of __init sections..



> My aim was to make the=20
> OF-parsing part be a module too. Because in the long run we
> need the OF-parsing stuff for _every_ driver that needs
> platform data. It's quite expensive to have it always built-in,
> don't you think?

If it's discarded early, after translating the data from
OF format into what the drivers need, there will be no
RAM footprint.

- Dave
