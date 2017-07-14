From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v11 3/4] i2c: aspeed: added driver for Aspeed I2C
Date: Fri, 14 Jul 2017 09:18:00 +0200
Message-ID: <20170714071800.GA1498@katana>
References: <20170620211516.13095-1-brendanhiggins@google.com>
 <20170620211516.13095-4-brendanhiggins@google.com>
 <20170623184305.xqqhjgrbdmgk6lsr@ninjato>
 <CAFd5g45=O2_MgfZEkmbY-=ZZY+izxeWSuhZT+B2e08P=O+WEog@mail.gmail.com>
 <20170627090042.GA2408@katana>
 <CAFd5g449iu6DGvMuP8-n8C6GBbr62G6_ZYS6Lh9038EB0XO9YA@mail.gmail.com>
 <20170628074515.GA1550@katana>
 <CAFd5g45V0Ya0UdBZMCoazvE0Sh33F3_oMb84-kLXn1qH0h=b3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFd5g45V0Ya0UdBZMCoazvE0Sh33F3_oMb84-kLXn1qH0h=b3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S . Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Basically what I was asking is whether I could use i2c_generic_scl_recovery
> in the case where SCL is hung.

The name is a bit misleading, I am afraid. Recovery can only be used when
SDA is stuck low. And to fix this it *uses* SCL toggling to get out of
it. And 'generic_scl' means 'gimme some SCL to control and I will toggle
it'. Compared to 'gpio_recovery' which will do all the GPIO handling for
you.

When SCL is hung, you can only reset the device which forces SCL low.

> I think I have a pretty good idea of what to do, I should probably just put
> together an RFC patch.

Sure.


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllocCQACgkQFA3kzBSg
KbYLJA//eOt1O+Vx/SfQPxPJZvoe/8u/ntXbOwccem2evrB6yWqE2wGvGPrTfRgL
ulNj1Pjg6kGd3wpxuRp1paGzHpcRVe1LFXqqpqqr/2R4cA6tKvmem4fBYhSdSfim
4JxDTdl3OY9a6kFUoQPeY6N+Tm/P0fzL1uWDGfr/DeGYbjh0BP7ju68jgC0U+PPL
IQVW7P1WQbo5ha2/2hneWUk2SiqmVLERNFwyIMsNF9C7FXyvtdr2MvsSIqx/YPWj
bjaaPT1XG45+tBQFd9883sr/NK2b1AWSYY2HaOovxxkl/5XYUQsP4DaziH7Vo8j6
60fbZ5c7BgcyCwLFCJpIMomv+/HZiIAqeAqr9loWTKG0QVhdiguadceSj2ZzSkm+
yJOnCjRtTf9GwOVt38RIklcolWGtK62V3QzsIMzQH4RQIU8W5/8kihW7cM3ow4sG
+zoO3V7xTmODqRQ/SHj2emKIT9Sp95jR8fPio/FIbSuVx8vKAeXUZ0grrJbkr7nO
5bSviIOEGYZiUofjeL9JDEwkVs/3kH3Z2CUpH5E12YwlrOKT8BXdvRRDBWoyqHxE
0S+VLgIxYum+ODGL5EOCHEYui+ufQwDKtcg2Wlz+yuCozbvsFZzQdxrRCBAcwriK
Q54B9SouScJ1TKsdtStsu476TjTau9SM8oEvbOudxB/e/jrZcUQ=
=Ykr8
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
