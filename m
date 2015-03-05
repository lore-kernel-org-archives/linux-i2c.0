From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
Date: Thu, 5 Mar 2015 19:40:44 +0100
Message-ID: <20150305184044.GA881@katana>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
 <20150304172710.GA884@katana>
 <20150305182817.GB4911@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150305182817.GB4911@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I don't have the bandwidth for a full review right now. However, I
> > already wanted to tell you guys that my gut feeling is that this
> > protocol is quite far away from I2C. P2WI was already at the edge.
> > Maybe there is a better place for such custom stuff? I dunno yet.
>=20
> That's unfortunate, especially since it looks closer to SPI than what
> P2WI even was.

SPI? I assume you mean I2C. Can you elaborate your reasoning?

> What would be your suggestion?

Let me quote:

"I don't have the bandwidth for a full review right now... I dunno
yet."

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+KMsAAoJEBQN5MwUoCm26jgQAIabpakq+AG/tzyRMXIHXiDX
7R26ECTi1xjyY0h8qAmSPAuKDsp2Se7JeWUN8OYQ/LOKZ8TPJoFO3JgbzQTPnDcu
5STaTgfwxPnPka81YyNKys+ktadyYAIpu3f5BX8Uc5CwOJkc2a8l0vsfO0GcjBVJ
jqXNzkuA0IJJmm60H/Jf8IjINeMzCnMnwc3qiHPn2KMAwqJO/n2tWM04/Ue5JzxV
q7wdomRWHkohl8lO0Hx9wrFUJI/UeIDV2+sfp4DyWbytCHl5Xo+dXVdEej7R8t3U
Gx7UfUmanS6jfyh9WuCYIqB37fGvvqdmbKb+RQxokPxIB8aGvlmrrDQcbP8MCvfG
c711Z8BryqKkOQKsJS1em+MKZft3fGphCHRhPsbRpA5VwyTbq5cDnnmexEEULsG9
T92TOUEflMBziHa5/eiX4nyUzFmWVSlgw9hnNNBGtRwNkvePikJLnw4fn+aq03ei
F4DzD16WNYJX/n9XieXsI9JxxDubLDeIY47GvFay4wbpHy7AhTCLJcMp/xiqg6dX
XlbA+3wi5h12T/pDFpWlr+IG7luVxmzCMc08rbzQ9TYpFVPgWTBPSSwzhLkWXPD1
Wal9Qm2G+R/rAJhvBvkfcxOw4Q9gVZbftidyRzPY54RRqTDce/c5/PEAMcz4+x3B
wKS1jacg+J+pTr6bPcdL
=YMg0
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
