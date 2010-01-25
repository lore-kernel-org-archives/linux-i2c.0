From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2 RESEND#2] i2c/pxa: remove unused macro
Date: Mon, 25 Jan 2010 10:28:50 +0100
Message-ID: <20100125092850.GA7378@pengutronix.de>
References: <1257754721-17325-1-git-send-email-u.kleine-koenig@pengutronix.de> <1258658141-30340-1-git-send-email-u.kleine-koenig@pengutronix.de> <20091208211810.GB13706@pengutronix.de> <20091208224456.0baf422b@hyperion.delvare> <20091208220724.GA14696@pengutronix.de> <20091209091146.78e8d7bb@hyperion.delvare> <20100112105846.GA31145@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100112105846.GA31145-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Ben,

> > Ben, can you please add your tree to MAINTAINERS to make things cle=
arer
> > for contributors?
I just sent out a patch for that to linux-i2c.

> In the meantime I have three i2c patches without any feedback by you.
> As Jean is convinced that you are responsible to take them can you
> please have a look and comment?
>=20
> My patches are also available via git at
>=20
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git next/i2c
>=20
> Shortlog and diffstat can be found below.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (2):
>       i2c/pxa: remove unused macro
>       i2c-imx: call ioremap only after request_mem_region
>=20
> Wolfram Sang (1):
>       i2c/pxa: only define 'blue_murder'-function if DEBUG is #define=
d
hmm, you took one of those (the i2c-imx patch) but not the other two
with still no comment?!

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
