From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: i2c-gpio performance issue w/MPC8xx @ 50 MHz
Date: Wed, 4 May 2011 22:50:49 +0100
Message-ID: <20110504215049.GX15795@trinity.fluff.org>
References: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g@mail.gmail.com> <20110501102603.7993da58@endymion.delvare> <BANLkTik_mBMHJt-MzcSQfdnAhseBM5KwFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTik_mBMHJt-MzcSQfdnAhseBM5KwFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, May 01, 2011 at 03:04:21PM -0700, H=E5vard Skinnemoen wrote:
> Hi Eran,
>=20
> Hmm. i2c-gpio overrides the udelay specified by the platform? That
> shouldn't happen. It does try to come up with some reasonable default=
s
> if the platform doesn't specify any though.

[snip]

> You can probably create a minimal i2c-platform driver which just
> passes the platform-specific callbacks to i2c-algo-bit. I think it
> should be a new bus driver though...passing those callbacks to
> i2c-gpio would basically eliminate the very small amount of
> functionality this driver provides while making it more complex.
>=20
> i2c-gpio currently has 225 lines of code. I think it should be
> possible to write a i2c-platform driver in less than 100 lines.
> Probably worthwhile for 3x performance, although probably not if the
> GPIO hardware has concurrency issues.

I suppose this would work, but is it worth the additional code for what
may not be much of a win?
=20
> > That being said, if you use GPIOs, it would certainly be better to =
find
> > out whether the extra delay you've been observing could be removed.
> > Properly requesting the GPIOs you need is definitely cleaner than
> > accessing the I/O port (or whatever) directly. Direct access can be
> > unreliable if other code is using GPIOs nearby.
>=20
> If your hardware allows you to control individual pins without
> affecting others, it's probably ok to bypass the GPIO layer (although
> you should probably still request the pins to prevent others from
> using them). If not, you should expect a lot of trouble.

yeuck.

--=20
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disapp=
ear.
