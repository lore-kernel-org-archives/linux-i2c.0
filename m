From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue, 6 Jun 2017 12:24:47 +0200
Message-ID: <20170606102447.cftuyhtx7zo2fe2g@ninjato>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
 <20170606092034.1516-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ww6l3bfasujh5jo3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55530 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbdFFKYu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 6 Jun 2017 06:24:50 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--ww6l3bfasujh5jo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +Therefore, it is *not* mandatory that the buffer of an i2c message is =
DMA safe.
> > +It does not seem reasonable to apply additional burdens when the featu=
re is so
> > +rarely used. However, it is recommended to use a DMA-safe buffer, if y=
our
> > +message size is likely applicable for DMA (FIXME: > 8 byte?).
>=20
> So you expect drivers to fall back to PIO automatically if the buffer is
> not DMA safe.  Sounds good to me.

Yes, I strongly recommend that. Otherwise, drivers can always deal with
bounce buffers on their own.

> However, your check for a DMA-capable buffer is invoked only if
> CONFIG_DMA_API_DEBUG is enabled:

is *NOT* enabled!

>=20
>     #if !defined(CONFIG_DMA_API_DEBUG)
>            if (!virt_addr_valid(msg->buf) || object_is_on_stack(msg->buf)=
) {
>                    pr_debug("msg buffer to 0x%04x might not be DMA capabl=
e\n",
>                             msg->addr);
>                    return -EFAULT;
>            }
>     #endif
>=20

The #if block is there because DMA_API_DEBUG does a lot more, but if the
check in the helper is enabled, the core will fall back to PIO and you
won't get the additional info from DMA_API_DEBUG.

I think this needs a comment :)

Now OK?

Regards,

   Wolfram

--ww6l3bfasujh5jo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlk2gucACgkQFA3kzBSg
KbbCew/8CTFobDolqHjRsVShseOXgUstxwg6NkxTF9Rvvwkj90ta3Du6vZZRjx8c
q5NfPxYpSeTfvN9w6dMg+IU4ZFM4F4dW+cFkWAYWisUQUBgmV5/UclvAafIsDjMC
8xx3SBVBx3eYGpJ9+Q32M7NAFuW4T+Xc/vKh3OVnYF0nRvrYZsxXq6ABHLcQOcOC
w4qjnlkk8t6FrG8nvbBaQo206+b3hJSiqWQNX50S6syG38uNtEiS/6VDcIAoVySw
3Iv5kTWhsWBfw7cQQUI8e048p2bCLEDu7UZa09qqsixNZHE/+c68z2Av8/nrxKcc
pA78nrvMRFqmDGhlO5CBZXPliJLmnn62Kq4wI4E1XTwpCpFX8E7phWcLGi8mCCPu
q5Za4jcgtovyc/DsgDBRzAEs8DhbEEGRoYoKil4SZpK++mCWHgZNDzJG9nQahqBl
1Z+pw81PLvvBFVmcJDmxY4W4UCQ64M0/Nneog31yPMY4bQk0z8dxY209Y6vNDKbS
6KxfCfldgj+HiK9lYf8u3zK0CNtn/EYG7cnch6OBfZjR+PJWDbXb+1bdA3O/1oGz
L9d1Au6a3Y/WFhRiA3q4VPH5BgVIs02u7FV1+ct15nCfJq/SgMfRzX4v/akzZLMq
gmAz+/ALUBx2yfiqG1wAFlrUtb8YpdFvDsTk/QZQ+741uX5KRBI=
=fcqa
-----END PGP SIGNATURE-----

--ww6l3bfasujh5jo3--
