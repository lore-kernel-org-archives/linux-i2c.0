From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-mv64xxx: use subsys_initcall for early
	initialization
Date: Wed, 29 Sep 2010 00:11:43 +0100
Message-ID: <20100928231143.GP21564@trinity.fluff.org>
References: <1284284129-28105-1-git-send-email-mike@compulab.co.il> <20100914232547.GD7494@trinity.fluff.org> <AANLkTi=gtXJ8zQt2kTSCCy7=Zc4R-8BDp=Z8w7u8_ua+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=gtXJ8zQt2kTSCCy7=Zc4R-8BDp=Z8w7u8_ua+-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 23, 2010 at 09:11:00AM +0200, Linus Walleij wrote:
> 2010/9/15 Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>:
> > On Sun, Sep 12, 2010 at 11:35:29AM +0200, Mike Rapoport wrote:
> >> Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> >> ---
> >> =A0drivers/i2c/busses/i2c-mv64xxx.c | =A0 =A02 +-
> >> =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > We really should have an i2c_initcall, but it may be difficult to m=
ove
> > everyone over to it. What would be lovely is some form of dependenc=
y
> > based initialisation, but that's probably a way off...
>=20
> SPI, SDIO and other external busses (Dallas 1-wire? w1) may all have
> the same "needs to be up early because we need that before that"
> type of problem.
>=20
> Makes me think of crazy things like putting a lightweight version of
> Lennars P=F6tterings "systemd" scheme into the kernel for resolving
> these initcalls.

Either that, or build stuff as modules and use an initrd...

Not sure what the best solution is...

--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
