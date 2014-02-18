From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: nomadik: factor platform data into state
 container
Date: Tue, 18 Feb 2014 19:35:39 +0100
Message-ID: <20140218183539.GE18768@katana>
References: <1391423246-32410-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391423246-32410-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	of_property_read_u32(np, "clock-frequency", &pdata->clk_freq);
> +	/* Default to 400 kHz if no frequency is given in the node */
> +	if (of_property_read_u32(np, "clock-frequency", &nmk->clk_freq))
> +		nmk->clk_freq = 400000;

I can't really recommend this. 100kHz is something all devices support,
but, although common, 400 kHz is already an extension of the standard.

Let me know if I should fix this up for you.


--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTA6f7AAoJEBQN5MwUoCm25PwP/Rth5+mFso1CbhjoKW1KLmvF
g8w2SXZw6XVOsmCIUV02mq5qxDz2tB7UEjG791WFMrPgKVfz6OvjMsxiIgPb2aMn
HQ+2Hnu+3FfZycjqQ05ghALwOXEZBBMw/RoFRGZQGJl+JvtxM65pVmkKeOov9ce/
60ZbaaSQuS47iz26qNzEmVz93HzFGmkcE+N/ez4czOS14Umg1VhtacUDfYtLlWl5
gWbs+XnwdwpdCe9IOXi9I34XrJdGOwhqxMTLV4H7bcyEFN7u9fYQg3lvcMjHIybn
DY9PxM9/HxOCEloNmsWUZtRuXbBlRXQ5VUCKg2Dvu0vNU0uOhzziqDiblqy69Hg3
XlGeDOGiwsDFVr7bLmkOpxzmJRN2Qu7bHsWwHYJW6wcQEcdKlFcusJSc3qIkQt8K
EmXPUGoa367XbJoSwDR645xU7rTOoYXQkPBi8NV6d0wWvdOVYp/hLpVMDgABHsdZ
A15EiJ379lOHuZO7Loq890hXXtEgzOMb9O/T5djPJMkUZDDA5awIitAcbjdh8QKs
6AHtsNhwbMkzMfJp5MN1/aeelrh1g0ZhXd68GoqzLpW6RDL/4r1L9l1m7rEe4zfG
evCDgG8Rxn0ZGEK19lJhSYcO3c+XR0iFJw1ZJga8Gu4TpLodH30oh+m8LpQQall/
gqQ3UImXw2loKZw1ykb6
=TyOG
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
