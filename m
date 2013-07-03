From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 3 Jul 2013 15:29:06 +0200
Message-ID: <20130703132905.GC3929@ab42.lan>
References: <20130625163902.GA2973@katana>
 <1372236906-6933-1-git-send-email-christian.ruppert@abilis.com>
 <20130626140713.GB3119@katana>
 <201307031343.11647.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201307031343.11647.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 03, 2013 at 01:43:11PM +0200, Arnd Bergmann wrote:
> On Wednesday 26 June 2013, Wolfram Sang wrote:
> >   On Wed, Jun 26, 2013 at 10:55:06AM +0200, Christian Ruppert wrote=
:
> > > This patch makes the SDA hold time configurable through device tr=
ee.
> > >=20
> > > Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > > Signed-off-by: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Applied to for-next, thanks for keeping at it and providing lots of
> > useful information. Much appreciated!
>=20
> Sorry, but I got a regression that I didn't find reported elsewhere
> so far, even though it breaks a lot of the ARM defconfig builds:
>=20
> drivers/built-in.o: In function `dw_i2c_probe':
> /git/arm-soc/drivers/i2c/busses/i2c-designware-platdrv.c:125: undefin=
ed reference to `__udivdi3'
>=20
> I suspect you want something like the change below.

This looks similar to a patch Vincent Stehle submitted yesterday, see
https://lkml.org/lkml/2013/7/2/145

> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2=
c/busses/i2c-designware-platdrv.c
> index def79b5..57e3a07 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -119,10 +119,13 @@ static int dw_i2c_probe(struct platform_device =
*pdev)
>  	if (pdev->dev.of_node) {
>  		u32 ht =3D 0;
>  		u32 ic_clk =3D dev->get_clk_rate_khz(dev);
> +		u64 hold_time;
> =20
>  		of_property_read_u32(pdev->dev.of_node,
>  					"i2c-sda-hold-time-ns", &ht);
> -		dev->sda_hold_time =3D ((u64)ic_clk * ht + 500000) / 1000000;
> +		hold_time =3D (u64)ic_clk * ht + 500000;
> +		do_div(hold_time, 1000000);
> +		dev->sda_hold_time =3D hold_time;
>  	}
> =20
>  	dev->functionality =3D

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
