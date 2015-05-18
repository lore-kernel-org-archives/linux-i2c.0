From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Mon, 18 May 2015 08:37:42 +0200
Message-ID: <20150518063742.GA1545@katana>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <1430901427-65146-3-git-send-email-eddie.huang@mediatek.com>
 <20150512125832.GB4447@schokonusskuchen.bad>
 <1431928701.22349.22.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431928701.22349.22.camel@mtksdaap41>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo Zhang <liguo.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > +		rpaddr =3D dma_map_single(i2c->adap.dev.parent, msgs->buf,
> > > +						msgs->len, DMA_FROM_DEVICE);
> >=20
> > I think you shouldn't use the adapter device here and later, but the dma
> > channel device.
> >=20
> In MTK SoC, each I2C controller has its own DMA, and this DMA can't be
> used by other hardware.
> So I tend to use DMA directly, not through DMA channel.
> Even so, "i2c->adap.dev.parent" is not suitable here. I will change to
> use i2c->dev here. (Reference i2c-at91.c).

The better reference would be i2c-sh_mobile.c, especially commit
8cfcae9f0595bf0d145a67cfaa1051804a301d7c ("i2c: sh_mobile: use proper
device for mapping DMA memory") ;) The request to use the DMA channel
device came from the DMA folks, so if there is no real reason for an
exception, please use the channel device.


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVWYizAAoJEBQN5MwUoCm2GXwP/jA2vVLY2OzOf9Z2ouv87H9z
1wm1EKmQDAPMUeA/gugE4zt1QAuE10WO7T1pssxYyIhoVagjdbF+1dOEFIn+WKE4
wU7sgHH2ZxX5tCNQS6sfHrSxTsxoAf8AvqD/wd7cFKlJVT7Sq650iMpD915TiUYY
WfTlGe0bXWapEMtdneikFwxExl4TaRymCY1QlJYXQB+bzxSMJgRazbOEabqkgSPe
WWLUkjrvQAUukxtXelYR1oTuTsHN8HiAP7KEARNuLXwLc/nUzKbgmcJxAI5FnyxA
WqKrsp8bqj0b2JM/ko/EsjmsnIHKlnoFs0gox2NRudNEQasAcid9wv3e1qmvCQd3
bWjM8LO2pcoNmQVlb/CU5QtcMsR9i+Ng7c2jRnltF9JiofEtm+vTNgYvf/y9Npl9
VuI2bztZk+ckyvnYxFmuI4bPy86Q+4RPBIdpkFsOBV90LHkK8RsaqtbWlaEm31au
dLnCiTrtrxq5p+v7/jXsJNgpNMiT54J4v+fY5tT2VcN8aVZLASHLet01sRDZHAKr
qc9fHub4PqI21ZacH/PJyUi4PJ8ugDmey8E5wARhxaoUbQjW6dZKNjciFC4wAPYn
2k9I9WVU2r65BaA7UwM5xofts8nFRGPvcq+w7dVf8QL5MMGW4lVxPW8aAFydO1YA
VPdv+31VTXeOg7350ziF
=gqz6
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
