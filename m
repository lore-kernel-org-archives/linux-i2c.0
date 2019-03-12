From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Date: Tue, 12 Mar 2019 14:00:51 +0100
Message-ID: <20190312130051.kngknb26tikzsm7j@ninjato>
References: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
 <20190309101340.GH1340@kunai>
 <20190309105021.GI1340@kunai>
 <36e0aec2-8fb8-d584-daee-1b3427f1067e@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="is76gvcv4mjw7ial"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36e0aec2-8fb8-d584-daee-1b3427f1067e@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bich HEMON <bich.hemon@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Pierre Yves MORDRET <pierre-yves.mordret@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--is76gvcv4mjw7ial
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Do you have a Fixes tag for this?
> >=20
>=20
> Fixes: aeb068c57214858b638d5ee627bb4a831f98771e ("i2c: i2c-stm32f7: add=
=20
> driver")
>=20
> Will you change the commit message or do you want me to resend the patch?

I'll fix it. Thanks for this info!


--is76gvcv4mjw7ial
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyHrYMACgkQFA3kzBSg
KbZT1g//bRBMzXRZ84ILbD3iczv55pWU32XqytQZVYE0B4meki6Az4h3se4n4AmM
z8jL7OxLEmXzA22MbqRxhXvI3e3U3yBh65PGD2855Fv/Q9n/R7NxDEesvCU3aI+y
O7eKUXMMqaOc1DcgiPw2dpxxsneUEYTtk7EE+1lYCOXK9BkXA9ZX7VQLg493bQxj
RHRK/5+YK/Sj+mdaJktY73k3NZiB3qJ4gK9EoMVu+/W6wBpSHpknuSmFxPNUxUSF
8UKETR0DvY0TOqYqpNdRLI8jR+UM2wTIe+yBLXK6oBSMFFkk3hanyfYt78VjVxlG
lUnStJ18G7orGmwOpmf2xNX7kNgtz6CLgMFLX//AL9qouw8hhf2/SzNft+j4TDKx
i3TcCGRV5tjGk/NMAHVhIPD9Qfbhs998uaNPFa91flnOALfGAL7Sjp8dT7I5APIG
QB9qhQrBsQlg0pkm419Sa9A9F0PNWe1mwhP7rXBNpYU1S3fRPnyp0SPg4iSSIve0
l4U+doq+3biw0Mb5WRhx28WrePKYXHe57PRx5Fm6wNHEkP401HeblF83Xo/bM+Zi
y2SNRSNHWqVndxSiRt3/uQ543p+xzOQvwFuO3DTezJ+iizI6ukIGnWZAnQloTVIt
P+HA478TJktkWOT7vXeS2b+hM5hFQbxoQ2yqnHcWuXn03vN6jEU=
=WcWM
-----END PGP SIGNATURE-----

--is76gvcv4mjw7ial--
