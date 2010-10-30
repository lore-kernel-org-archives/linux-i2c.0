From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-i801: Handle multiple instances instead of
	keeping  global state
Date: Sun, 31 Oct 2010 00:00:52 +0100
Message-ID: <20101030230052.GP21564@trinity.fluff.org>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com> <20101030182458.0849f295@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101030182458.0849f295-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Oct 30, 2010 at 06:24:58PM +0200, Jean Delvare wrote:
> Hi David,
>=20
> On Sat, 30 Oct 2010 14:47:56 +0100 (BST), David Woodhouse wrote:
> >=20
>=20
> An explanation why this change is needed would be nice.
>=20
> > Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >   drivers/i2c/busses/i2c-i801.c |  329 ++++++++++++++++++++++------=
-------------
> >   1 files changed, 178 insertions(+), 151 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c=
-i801.c
> > index 59d6598..6e8c12c 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -1,8 +1,10 @@
> >   /*
>=20
> Note that the patch got corrupted on the way: all leading spaces have
> been doubled. I had to fix it.
>=20
> > -    Copyright (c) 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
> > -    Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, and Mark D. Studebaker
> > -    <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> > -    Copyright (C) 2007, 2008   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > +    Copyright =A9 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
> > +			     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org> and
> > +			     Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> > +    Copyright =A9 2007, 2008   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > +    Copyright =A9 2010         Intel Corporation
> > +                             David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>=20
> I'd rather stick to (C). Using non-ASCII characters is asking for
> trouble, and this doesn't add value.

IIRC, and IANAL, (C) is not sufficient in certain areas (such as the UK=
)
to declare copyright. It needs to be either the word Copyright in full,
or the proper 'c' in circle. Both is of coures better.
=20
[snip]

--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
