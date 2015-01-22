From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: imx: silence dma_request_slave_channel errors
 if dma not set up in device tree
Date: Thu, 22 Jan 2015 15:33:46 +0100
Message-ID: <20150122143346.GE3413@katana>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
 <20150114141407.GA1598@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150114141407.GA1598@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 03:14:07PM +0100, Wolfram Sang wrote:
> On Tue, Jan 06, 2015 at 03:48:19PM +0100, Philipp Zabel wrote:
> > If the i2c device tree nodes don't contain the dmas and dma-names prope=
rty, an
> > error is displayed for each i2c device:
> >=20
> >     of_dma_request_slave_channel: dma-names property of node '/soc/aips=
-bus@02100000/i2c@021a0000' missing or empty
> >=20
> > This patch avoids calling dma_request_slave_channel if the dma-names pr=
operty
> > does not exist in the device tree in the first place.
> >=20
> > Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> Aren't you curing the symptoms instead of the cause? Sending a
> counterpatch in a second...

Setting to superseded because of my counterpatch fixing this in the
dmaengine core. Maybe you want to ack that? :)


--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwQpKAAoJEBQN5MwUoCm2YHIP/iNQ3GcpgmWtrHjEvbjBw2qN
NSub3fPHY4Udmy1cPz9/n6rudwOfeAmKNxcVEpYN0isxw6x8b1lEZVIymdmpOwRe
7OyS3QH4YBLH0vZ7rrnBZdesxOAcSViXffQNSV3F0vvUqsPLLFolcZQcZLW4NJA6
zD1Ii0Wcf9ms/zU8qLaVONnFRclY96dV57Y8y51igBbb0YoLTZOe6uZdz2Mlezun
M+SpMlKPzEc7nT8TaoTrUnXk8a/QQFn7xl3HxN98vloB/RpW+63/a+eHgN2aRPSU
GEhX3hnlfg7fnePywX+4GCqzMGQwq1pUhZNI8gR6zI50VWdiZHbYPvf8gv1RxqPT
ydWokxdvIxLMz87EFtmC3I16bpQAfhJOJqXgUozJKNZ9JqCv8Maxk21+D4bEbUZ6
szl3KeGMxe6qnew2nyhuxyIfKrM4TtuiEQ5NWERlNk1wu/Bwi/AwrU//nDvP3W2x
K1OWosH2uFe8F9sSRdtWa1LlXNYR4dWPysoHon/MJUAP7ivHNdRbmxUl1FhwiQeq
KsSlQAvtU1MBZ7vhYa4xJDY0RlkI7l0KQmj/gXNarxeLnifCeDYtax7gS1uxlyPf
B03RS98QTCxRBvdOqUFxcWEJxF64ykhYGcLxJGpdweth0Rk4nfIBe6MofG2Vyv2R
b1ihr5Q1ulNEinfugaLs
=rwFV
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
