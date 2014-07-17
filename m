From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: efm32: correct namespacing of location property
Date: Thu, 17 Jul 2014 20:42:37 +0200
Message-ID: <20140717184237.GX11056@pengutronix.de>
References: <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1405068614-14279-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140717134000.GK2740@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140717134000.GK2740@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jul 17, 2014 at 03:40:00PM +0200, Wolfram Sang wrote:
> On Fri, Jul 11, 2014 at 10:50:14AM +0200, Uwe Kleine-K=F6nig wrote:
> > Olof Johansson pointed out that usually the company name is picked =
as
> > namespace prefix to specific properties. So expect "energymicro,loc=
ation"
> > but fall back to the previously introduced name "efm32,location".
> >=20
> > Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> Applied to for-next, thanks! If you think this is better suited in
> for-current, let me know.
I'm not in a hurry. If you take it it's fine for me.

(BTW, I'm not sure i fI understand your branch naming. for-next means
"targeting the next merge window" and for-current means "targeting the
next release"? So for-next currently means 3.17-rc1?)

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
