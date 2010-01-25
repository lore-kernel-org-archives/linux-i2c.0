From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] MAINTAINERS: add i2c tree for embedded platforms
Date: Mon, 25 Jan 2010 11:10:55 +0100
Message-ID: <20100125111055.05ccedf2@hyperion.delvare>
References: <1264411234-5400-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1264411234-5400-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 25 Jan 2010 10:20:34 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
> Hello,
>=20
> I wonder if it makes sence to split the "I2C SUBSYSTEM" entry into
> something like:
>=20
> 	I2C SUBSYSTEM (PC drivers, core)
> 	M:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 	L:	...
> 	W:	...
> 	T:	quilt ...
> 	S:	...
> 	F:	Documentation/i2c/
> 	F:	drivers/i2c/
> 	F:	include/linux/i2c.h
> 	F:	include/linux/i2c-*.h
>=20
> 	I2C SUBSYSTEM (embedded platforms)
> 	M:	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 	L:	...
> 	W:	...
> 	T:	git ...
> 	S:	...
> 	F:	drivers/i2c/
> 	F:	include/linux/i2c-*.h
>=20
> (I'm not entirely sure about the file patterns for the 2nd entry.)

I'm not sure what value it adds, compared to having a single entry as
we have today. scripts/get_maintainer.pl will produce the same output,
won't it?

This script (and our minds) being directory-driven, I suspect that the
only efficient way to split the entries would be to first move all i2c =
bus
driver for embedded platforms to a separate subdirectory. I'm leaving
it to Ben and the embedded community to decide whether they want to do
that or not.

>=20
> Best regards
> Uwe
>=20
>  MAINTAINERS |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1858646..a1813fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2629,6 +2629,7 @@ M:	"Ben Dooks (embedded platforms)" <ben-linux@=
fluff.org>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  W:	http://i2c.wiki.kernel.org/
>  T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelv=
are-i2c/
> +T:	git git://git.fluff.org/bjdooks/linux.git
>  S:	Maintained
>  F:	Documentation/i2c/
>  F:	drivers/i2c/

Yes, please!

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

--=20
Jean Delvare
