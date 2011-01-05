From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c-pxa: move i2c_pxa_remove to __devexit instead
	of just __exit
Date: Wed, 5 Jan 2011 09:19:15 +0000
Message-ID: <20110105091915.GV27131@trinity.fluff.org>
References: <1294193110-23958-1-git-send-email-dbaryshkov@gmail.com> <20110105082445.GL25121@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110105082445.GL25121-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 05, 2011 at 09:24:45AM +0100, Uwe Kleine-K=F6nig wrote:
> a bit of explanation would be nice here.  Something like:
>=20
> 	Subject: i2c-pxa: make sure the remove callback is called on unbind=20
>=20
> 	When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
> 	callback was not called because it was discarded after boot or modul=
e
> 	load time.  Because of that the resources allocated in probe were no=
t
> 	freed and so a rebind was impossible.
>=20
> 	Fix that by moving the remove callback to .devexit.text.
>=20
> This way everyone can understand that a real bug is fixed here.

agreed, please re-submit

--=20
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disapp=
ear.
