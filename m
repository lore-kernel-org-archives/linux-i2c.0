From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: slave: rework the slave API
Date: Fri, 20 Mar 2015 08:24:41 +0100
Message-ID: <20150320072441.GA10068@pengutronix.de>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-2-git-send-email-wsa@the-dreams.de>
 <20150319201751.GZ10068@pengutronix.de>
 <20150320071504.GA906@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150320071504.GA906@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Debora Grosse <debora-HRUOeNTICTI@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Moin Wolfram,

On Fri, Mar 20, 2015 at 08:15:04AM +0100, Wolfram Sang wrote:
> On Thu, Mar 19, 2015 at 09:17:51PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Wolfram,
> >=20
> > On Thu, Mar 12, 2015 at 01:42:01PM +0100, Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> > >=20
> > > After more discussion, brave users, and additional datasheet eval=
uation,
> > > some API updates for the new I2C slave framework became imminent.=
 The
> > > slave events now get some easier to understand naming. Also, the =
event
> > > handling has been simplified to only send one event per interrupt=
=2E
> > what is an interrupt here? An event where the bus driver needs feed=
back
> > from the backend?
>=20
> More the other way around: when the bus driver needs to notify the
> backend. I wasn't 100% sure about the word 'interrupt', but then deci=
ded
> a HW slave support without interrupts would be so rare and adventurou=
s
> that it is okay to use the term :)
Yeah, I agree on HW slave support without interrupts is hardly possible=
=2E
But I imagine that controllers differ in which situations they can issu=
e
an interrupt so talking about them for generic code feels strange to me
because $flexiblecontrolerwithvariousirqs doesn't need to send more
events than $bareminimumcontroler.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
