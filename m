From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/10] ASoC: Add codec component for AD242x nodes
Date: Mon, 16 Dec 2019 14:23:13 +0000
Message-ID: <20191216142313.GD4161@sirena.org.uk>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-12-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191209183511.3576038-12-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org, lars@metafoo.de, pascal.huerst@gmail.com
List-Id: linux-i2c@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 09, 2019 at 07:35:11PM +0100, Daniel Mack wrote:

> +	/*
> +	 * Setting clock inversion is only supported globally for both DAIs,
> +	 * so we ignore the settings made for DAI1 here.
> +	 */
> +	if (index == 0) {
> +		switch (format & SND_SOC_DAIFMT_INV_MASK) {
> +		case SND_SOC_DAIFMT_NB_NF:

I dunno if it's a blocker but it'd feel nicer to try to verify that the
settings are the same and warn if not.

> +static int ad242x_set_dai_fmt_dai0(struct snd_soc_dai *codec_dai,
> +				   unsigned int format)
> +{
> +	return ad242x_set_dai_fmt(codec_dai, format, 0);
> +}
> +
> +static int ad242x_set_dai_fmt_dai1(struct snd_soc_dai *codec_dai,
> +				   unsigned int format)
> +{
> +	return ad242x_set_dai_fmt(codec_dai, format, 1);
> +}

You don't need separate ops, just look at dai->id.

> +module_platform_driver(ad242x_platform_driver);
> +
> +MODULE_AUTHOR("Daniel Mack <daniel@zonque.org>");
> +MODULE_DESCRIPTION("AD242X ALSA SoC driver");
> +MODULE_LICENSE("GPL");

Should have a MODULE_ALIAS() as well for autoloading.

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl33k1AACgkQJNaLcl1U
h9CJzAf5AVSyR1/mSM1ETDWuCIYuCIEFlu7/ooDTySWL/oz8g/+17UrUPo4t74Kv
vEBYnAiDtdNss2zAjSK4TGyvVRqIH+PRdOpEyJcaGK23yLD8tr/MzD3iYvVxXnhP
4rd555BKIjpXedGoFoVUMsqYq6elyLawB42m2kVesOxlY2YxGw76dpcNJH061vjM
M8YttjOvZdbN4maecBVI6tq1gTttZ+ap+k/T3CqAEa6A701pg6GlQR0ZX/rsKl84
BTYGk9C2XDYoJrwMp6cPRr93AyxAf/pAzYqhju0Co1VxnvnDxk0r6gfSW4EYn18n
kIHoPy2cHMeADFhK7n4j0Sc1c79h4g==
=eeff
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
