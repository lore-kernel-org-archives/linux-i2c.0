From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v5 RESEND 3/5] i2c: pxa: Add support for pxa910/988 & new
 configuration features
Date: Fri, 11 Sep 2015 21:06:19 +0200
Message-ID: <20150911190619.GB1516@katana>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440395978-9065-4-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2015 at 11:29:36AM +0530, Vaibhav Hiremath wrote:
> TWSI_ILCR & TWSI_IWCR registers are used to adjust clock rate
> of standard & fast mode in pxa910/988; so this patch adds these two new
> entries to "struct pxa_reg_layout" and "struct pxa_i2c".
>=20
> As discussed in the previous patch-series, the idea here is to add standa=
rd
> DT properties for ilcr and iwcr configuration fields.
> In case of Master ilcr is used for low/high time and in case of slave mode
> of operation iwcr is used for setup/hold time.

I need to rethink how to describe i2c bus timing parameters in DT in the
next days. But this is planned for 4.4., promised.

One thing I already wonder about this one...

>  static const struct platform_device_id i2c_pxa_id_table[] =3D {
>  	{ "pxa2xx-i2c",		REGS_PXA2XX },
>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
>  	{ "ce4100-i2c",		REGS_CE4100 },
> +	{ "pxa910-i2c",		REGS_PXA910 },
>  	{ },

You add a new platform_id...

> @@ -1135,7 +1170,7 @@ static const struct i2c_algorithm i2c_pxa_pio_algor=
ithm =3D {
>  static const struct of_device_id i2c_pxa_dt_ids[] =3D {
>  	{ .compatible =3D "mrvl,pxa-i2c", .data =3D (void *)REGS_PXA2XX },
>  	{ .compatible =3D "mrvl,pwri2c", .data =3D (void *)REGS_PXA3XX },
> -	{ .compatible =3D "mrvl,mmp-twsi", .data =3D (void *)REGS_PXA2XX },
> +	{ .compatible =3D "mrvl,mmp-twsi", .data =3D (void *)REGS_PXA910 },
>  	{}

=2E..but change the compatible binding instead of adding a new one?


--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV8yYrAAoJEBQN5MwUoCm2qzgQAIw+vFoQ3CFLfQ+yCZkyqxKb
1iAucRTy0RfUPiA8a2DJkjrZZBjNv+wQmSIG2cKXkljlZbscuBeZ8GktlOhcFxEq
YGEeAA5iSm6urg/HOkDOuEx2ouzvX3NmRuzVl/hcSQQlX3ZvqcVcKbpZZaGH5iWb
60nPm4Xs7qNPBN1Gg2hOhSH0nQvwYorjupsLJq0g+WQjBIHk8bOheTSHXiIQCQ91
PN/K1fLDvnBLi2nlIaDiyjd3ceuHAo/FD6ep/Nn7IwINhr9uZSAu6P64VdAjRP7N
WVCBxDTCamBamIYjREJSTfT8gJbRMyaK2e+e8R3IhMsMS+MGSJHuhiBh0SS298+i
+bhegqNUY+RJ3qKJAoCHGYpAzVKEFrGGPrXzX4RHE2MxslkWbyu7OVwreo28BghR
wamcblVhKt/TVVQRXttt0kKyUW97rO/woaE2OncKmf5LHEbZn/n0pcF19vUS4nzT
pBRiYWjnP8cUdCdnIbB0Rq28rPQaP9RJpaL1Hr8i3usEg0Egz6GYAm3PZV4FLwpj
q87vXz1jRG0dC/m8ZBVL8q+s0yoyFImWlVmfGOBNOWTBi2je1a6I+0JCU+FbLAI2
Z8jsKysmsM31DdERsWZKJb4T2JSFpeqnIc4r+ZKI+YtLt1WZEba1QnvpflX0XYB/
CfhyuZSw3ksU+jLUNS8d
=104P
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
