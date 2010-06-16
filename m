From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] NUC900:  Add i2c0 driver support for NUC900
Date: Wed, 16 Jun 2010 02:05:03 +0200
Message-ID: <201006160205.04009.marek.vasut@gmail.com>
References: <4C15143C.1020603@gmail.com> <20100615051905.GD3233@jasper.tkos.co.il>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100615051905.GD3233-X57xyCW21FZ5l4KbKkTfamZHpeb/A1Y/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dne =C3=9At 15. =C4=8Dervna 2010 07:19:05 Baruch Siach napsal(a):
> Hi Wan,
>=20
> On Mon, Jun 14, 2010 at 01:24:12AM +0800, Wan ZongShun wrote:
> > This patch is to add i2c0 driver support for NUC900.
> >=20
> > Signed-off-by: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >=20
> > ---
>=20
> [snip]
>=20
> > +	pdata->get_clock(NULL, NULL, &apbclk_khz);
>=20
> Why not use clk_get_rate() for this?
>=20
> baruch

Other but what you already pointed out I can't find.

Reviewed-by: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
