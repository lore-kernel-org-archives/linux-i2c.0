From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: xlp9xx: Driver for Netlogic XLP9XX/5XX I2C
 controller
Date: Fri, 10 Apr 2015 19:04:18 +0200
Message-ID: <20150410170418.GC2408@katana>
References: <1426679430-26134-1-git-send-email-jchandra@broadcom.com>
 <1426679430-26134-3-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426679430-26134-3-git-send-email-jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	if (priv->msg_err) {
> +		dev_dbg(priv->dev, "transfer error %x!\n", priv->msg_err);
> +		if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR)
> +			xlp9xx_i2c_init(priv);
> +		return -EAGAIN;
> +	}

According to Documentation/i2c/fault-codes this should -EIO. I fixed
that and applied the series to my local tree. Please send the missing
Signed-off for patch 3 for completeness.

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVKAKSAAoJEBQN5MwUoCm2EjQQAIaTZ9nmLeo0R//fqfjkBVnO
tafFypbMPYe7SmjYcg9PtRjtpHh+gKXB0AggsqWtYv1HEbTpMsG3JpqvHVsWLaMW
aw3fo9QNE+OQqX9ktvS40ARh1gWTfkpJlRcD8yXNvQE9xIQ4bsFVckuU9I0laZZ4
KNxMYj0YqucWDSbKVxo4Vd36d3wGpK/ZJdGhqJSlml91+VnJmgX36ncV1CtST5ps
73OU4aAFB2wOaGhfZrsejwN3e7VzQbKz9yNJRbyEWJTE27cGdBBiN2Xxk+ZxmA/i
IRJsnevrq1WmNLkOMi47C7S1Xfy0gcz1Tu3CgL0bNElPuRS6FpQTtsBdzYUc5PlB
4Saef7CFD/MPpkggMXhrb5SBZvAoF2CSw23ust5I6rvgrWaNR5lFFgptyIY1+Sd4
1lxPalpjsplZU0Ghqy68PXD4hojGdyiOqATRJYAimKchsWjr1rJmIjBv22rkfeSX
CSM4XdL+Vz9Ul8lM5ErmHORON9097g11tIDKA3LNrVl+wqSTL/creQDhmZpSsrxh
jHEJSGXiRDoqLMHNhQOxwPzDlslrwBOqHOIB6mjgd5NKyJhVBy4cRefh5S/yr99c
aj6giukZVl1UJu5YDreFh2Pg8BHhmCM3CcEurUf3KxhhItA/ou7UzIIFGsg/ukmX
10FaA0I6VSPGM5BVemm7
=w93+
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
