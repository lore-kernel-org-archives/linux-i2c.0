From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fix unbinding/rebinding of the device
Date: Tue, 15 Feb 2011 17:23:23 +0100
Message-ID: <20110215162323.GO13279@pengutronix.de>
References: <20110106124028.GX25121@pengutronix.de>
 <1294502804-6580-1-git-send-email-dbaryshkov@gmail.com>
 <20110108161828.GC8237@pengutronix.de>
 <AANLkTimO1KFNm5xZ+2qJoGQq-ndVg0ER3KKwf0RYYOLK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimO1KFNm5xZ+2qJoGQq-ndVg0ER3KKwf0RYYOLK-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 15, 2011 at 04:59:28PM +0300, Dmitry Eremin-Solenikov wrote=
:
> Hello, all
>=20
> 2011/1/8 Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> > On Sat, Jan 08, 2011 at 07:06:44PM +0300, Dmitry Eremin-Solenikov w=
rote:
> >> When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
> >> callback was not called because it was discarded when linking the
> >> kernel. =A0Because of that the resources allocated in probe were n=
ot
> >> freed and so a clean unbind/rebind was impossible.
> >>
> >> Fix that by moving the remove callback to .devexit.text.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> I see this patch is still not pushed to neither linus nor linux-next.
> Should I put it into rmk's patch system? Or will it find it's way to =
main kernel
> via other paths?
rmk's patch system isn't the right place.  Ben needs to take it.  Ben?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
