From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Sun, 18 Jan 2015 12:06:58 +0100
Message-ID: <20150118110658.GA1113@katana>
References: <rjui@broadcom.com>
 <1421451737-7107-1-git-send-email-rjui@broadcom.com>
 <1421451737-7107-3-git-send-email-rjui@broadcom.com>
 <54BB795C.6040402@broadcom.com>
 <20150118094741.GE22880@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150118094741.GE22880-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2015 at 10:47:41AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Jan 18, 2015 at 10:14:04AM +0100, Arend van Spriel wrote:
> > On 01/17/15 00:42, Ray Jui wrote:
> >=20
> > [...]
> >=20
> > >+/*
> > >+ * Can be expanded in the future if more interrupt status bits are ut=
ilized
> > >+ */
> > >+#define ISR_MASK (1<<  IS_M_START_BUSY_SHIFT)
> > >+
> > >+static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
> > >+{
> > >+	struct bcm_iproc_i2c_dev *iproc_i2c =3D data;
> > >+	u32 status =3D readl(iproc_i2c->base + IS_OFFSET);
> > >+
> > >+	status&=3D ISR_MASK;
> > >+
> > >+	if (!status)
> > >+		return IRQ_NONE;
> > >+
> > >+	writel(status, iproc_i2c->base + IS_OFFSET);
> > >+	complete_all(&iproc_i2c->done);
> >=20
> > Looking over this code it seems to me there is always a single
> > process waiting for iproc_i2c->done to complete. So using complete()
> > here would suffice.
> Yeah, there is always only a single thread waiting. That means both
> complete and complete_all are suitable. AFAIK there is no reason to pick
> one over the other in this case.

Clarity?


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUu5PSAAoJEBQN5MwUoCm2SkoP/3BN2XB1RMlEMPr7wJR9+H6a
IWeWsj0GdxF0dJpThrxF40KNgmxWyJojprDTO3scKI/Gl8uMvTkWedsrnrAkwHSC
mRJAWFUucxVv1WLm9yuK0azceXeg1Fft3ovhTsgEKIapaVW/NIex4JvQUj6Gpm1l
oK5SS1ZarMxE+8pGT4fOwmYoqJUyAWVkAe6ajD2vYOoS4kRZpzSPN47Ty6WcKlU2
nhyQjEAgCtP6bp4hN3jzuHfVe6jpxjpmmgrVYDxqaC0ZH2SnIpekKxqsjk7fX3TH
gcuiwwG7ckhfy2vMLim9F9YBD4wQLe/hjFhGaH0aTLbrKMsQol/xw0CnEW3/FZDf
i0sD9Ho5hRjxUV9nSFQxBQKRPGrStRbM6gnFQDCgdwA5BLmZDpYjsdIYNKn8fCkh
/xV9vDRCciP6UcHVimlhV1xLWcr4QU+wTK9/Sev242B/2Zd+v28GpaMyz5aMDpca
3dpm7Lu37QgmgDkPqdp+Df1vT7+tdBZYfho08qvvZPWIjIOGeZ1PfClcTSxqGcPn
0muvuyZLIt+dr/HjuDk7WFewjstjStQFAeHuACHrzOxLt21baE+HWmKDTxbFOy6o
B8ZlSVWZqB00YCDTQnUcPlFFtL65DebEry5sO8qsxdN+vRC8fMPYANpByZOkDSaI
XzSHnUaN46/H1sSivKYx
=Kwf3
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
