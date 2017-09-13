From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH/RFC 2/3] i2c: gpio: Add support for named gpios in DT
Date: Wed, 13 Sep 2017 22:53:33 +0200
Message-ID: <20170913205333.wjtmg6727bcsxjrg@ninjato>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
 <1503566474-5335-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iq72dm2lyronaoe4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1503566474-5335-3-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--iq72dm2lyronaoe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	/* Try deprecated unnamed gpios */

I think adding "(deprecated use)" or sth would be good.


--iq72dm2lyronaoe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlm5ms0ACgkQFA3kzBSg
KbZwrhAAgYNe2RokJnCaXTcx1ZNWk/rTPfSqn9U6XdtbcPqQKMt75Ce4yuCplKeF
+cB5jVq4mhKtRfrTjhr987c3JQ1i5E0f3BZlpYKah6dcwzYlM9vwktcVAFwMTmZi
70gWC9o6ULw1wwLkkrqk+/TAKuLJy9fiE7pbH1X41XAkBWCtJLbb3slkOGNbppPj
8SLz0vqPGvI/k3VXykjLjGKAh+VmuAENIXNyV3cClkQ7rjU6/o/AEEp/LafsQIco
3rs6al6vZv3lVYuEiZyUVVFuenPM39FstM8tNrD1k7pfaM2Q8Cx/QmLzi9YKnY78
oqeFeNFLh9hU9TLASFFj5QjB0zakQqoP9bfpbnwuMB90p/UuzHsCA6xqrkVDycTz
mYX9hsWhlgQl7iGOyEv9gLGocEMs1TddzV2iJGWmason9Y5z4w9o7tcbFslr4cbG
Sx9pcCvENExEohXlwDaSf93b3kaskU/R8E8pExs8p+FMqB2YsI//Go7DbOFarHvq
aBer4sd1UO3zcMAIwA1pe0yburVFnFR1wXTCSnVW5njOh4JdDIU3I1zJwY7qQh7C
Rc6agWZy8mqjgNo4r+dNb1zdXb4r2u3fOxDKY1Xlcg4xdCGueSIJe7G7//aaVbts
ejjxmC6EmnqtitFKWzlssup43Gm1TIc//rSGx7ufFmQhuAbJsoE=
=2Jaf
-----END PGP SIGNATURE-----

--iq72dm2lyronaoe4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
