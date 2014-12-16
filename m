From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv1 1/7] dt-bindings: use isil prefix for Intersil
Date: Tue, 16 Dec 2014 09:19:13 +0100
Message-ID: <20141216081913.GC13486@pengutronix.de>
References: <cover.1418688042.git.arno@natisbad.org>
 <8e8a6eff40822083c0510f6c2787639ee819ef45.1418688042.git.arno@natisbad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8e8a6eff40822083c0510f6c2787639ee819ef45.1418688042.git.arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Hayato Suzuki <hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Antony Pavlov <antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Arnaud,

On Tue, Dec 16, 2014 at 01:22:27AM +0100, Arnaud Ebalard wrote:
> This patch fixes DT documentation to reference isil (NASDAQ symbol an=
d
> the most used prefix inside the kernel) for all Intersil products.
>=20
> It reverts both 7c75c1d5e72b ("dt-bindings: Document deprecated devic=
e
> vendor name to fix related warning") and b2ea3f82e798 ("dt-bindings:
> Document correct and deprecated vendor-prefix with device isl29028").
Unrelated to this patch I wonder if checkpatch could be improved to not
warn about unknown vendor prefixes in compatibility strings that only
exist for compatibility. This assumes that it's not necessary to also
document deprecated vendor prefixes, not sure about this one. Thoughts?

> Signed-off-by: Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 5 ++---
>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 3 +--
I guess it's OK to keep the two changes in one patch, but formally they
are maintained by different people. Should this patch be split?

>  2 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.tx=
t b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 9f4e3824e71e..0aaff72065bf 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -58,9 +58,8 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
>  gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with=
 Two-Wire Interface
>  infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, m=
ax 100khz)
>  infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400kh=
z)
> -isl,isl12057		Intersil ISL12057 I2C RTC Chip
> -isil,isl29028           (deprecated, use isl)
> -isl,isl29028            Intersil ISL29028 Ambient Light and Proximit=
y Sensor
> +isil,isl12057		Intersil ISL12057 I2C RTC Chip
> +isil,isl29028           Intersil ISL29028 Ambient Light and Proximit=
y Sensor
Here is some tab vs space issue. The surrounding lines (in the context)
all use tab.

>  maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
>  maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
>  maxim,max6625		9-Bit/12-Bit Temperature Sensors with I=B2C-Compatibl=
e Serial Interface

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
