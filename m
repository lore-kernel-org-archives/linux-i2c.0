From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 12 Dec 2016 12:10:05 +0100
Message-ID: <20161212111005.GA1450@katana>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
 <1480467618-7497-2-git-send-email-brendanhiggins@google.com>
 <20161211222622.GK2552@katana>
 <825541481540788@web11j.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <825541481540788-Mr5SgJCofHtxpj1cXAZ9Bg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kachalov Anton <mouse-Pma6HLj0uuo@public.gmane.org>
Cc: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org" <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, "clg-Bxea+6Xhats@public.gmane.org" <clg-Bxea+6Xhats@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org" <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, "openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> =C2=A0+ /* Switch from master mode to slave mode. */
> >> =C2=A0+ func_ctrl_reg_val =3D aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL=
_REG);
> >> =C2=A0+ func_ctrl_reg_val &=3D ~ASPEED_I2CD_MASTER_EN;
> >> =C2=A0+ func_ctrl_reg_val |=3D ASPEED_I2CD_SLAVE_EN;
> >> =C2=A0+ aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_R=
EG);
> >
> > Can't the hardware work both as master and slave on the same bus?
>=20
> The hardware can work as master and slave on the same bus. This is how IP=
MB over i2c works on Aspeed.

Thanks! Then the driver should support this. Maybe it is an idea to
first upstream the master support and add the slave support
incrementally?

Regards,

   Wolfram


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYToWNAAoJEBQN5MwUoCm2hFAP/22BMbapwx6CqPolipaU+8Bz
BC1Onxd5oWZ9odKoDRkgpg1GUdIOK6o/12s4HMG2XDweuqLysW3ZaCzKTGL1jsqI
b1I32go7nSAmMLMtlP3QW+R4YSXymVSjRYWj5nfTp0ovdPeh5bTbv4zUk25dhTuy
e/ULjgMeLXaIB6Ujopcrs3+6OuuwuIKM/23v23d+wePoPa2cmSPIzNKi5URjmle+
VcTjEkPIF8aLpJhwYdZvG5QAUCB5dSWpKrAUo/oY0/g6HbABDkBWbMZXTCwl7rmP
b1G1J9ebjffFTmbdxm4w6rWyt0J1X3WwyNXB3mpNYPBYiQgrdITi4el4XITRXPsJ
+lsfhslHpWqswHWYDeUo9M3HzuH9DmhDj9QeR/C5qXueX0sBPAhVmfb8tbbXe5wR
lBmMT6ONT1UaQnGYNoN3eMF+Viz88lH41dDoJT1X0/23m9xSB0AwcSBKbqoo8RsA
NXm1Y8UMAO7dUcbqvhDCXwK5lmdmUv4N4pKohXByiJHfogfeTMHczeYnVL+2doTO
Sm+7/JqbVCOCO1iNxwQdJFjCIw/HBi9YyFP5opujWWJan8+UqSTvlTNw/YfsxkDB
yWaFeewk1czTUt30tzMXCZ+XhffIvOQayZCOfvmN/4smWHIzL9dNoRSWAVx64/IE
eLDrHM7Yy44gtva5BUk9
=A4Ap
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
