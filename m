From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 6/8] i2c: mux: inform the i2c mux core about how it is
 used
Date: Thu, 25 Aug 2016 18:38:34 +0200
Message-ID: <20160825163834.GH2856@katana>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
 <1471268431-5148-7-git-send-email-peda@axentia.se>
 <20160825161900.GD2856@katana>
 <856c696f-b0c4-63f0-ee50-1b96556cf6e0@axentia.se>
 <20160825162432.GF2856@katana>
 <2e5539ad-4ad6-e61e-75c5-163c91b3ec41@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2e5539ad-4ad6-e61e-75c5-163c91b3ec41-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Right, I was waiting for some confirmation if v4.8-rc3 was a good base,
> but I'm running out of patience...

For me, it is perfect.

> Anyway, I'll send the pull request no later that tomorrow morning (CEST).

Thanks!

> I assume I can add your ack?

Rather this:

Reviewed-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>


--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvx8KAAoJEBQN5MwUoCm2GdUQALEIzg9waM/OaMjb+jljK2k2
fhKDclontoPcevU87Y9wN5UYs37x5n11c9tZ84TcjWgu1TELtGCdvg2tMhrjJ0bX
YCA9kMmR+g+rrJHP19QdhijRFBAVxsyIwJdW8DarSjUrqllNzJheUv4EEwsOySXd
X8j2Dxbrb9Fesfgzy5nqllPods6c7NCVfRH6Zu7o+7DL0ITcUhRYl77MOwhuhh4Q
SWZmy0d9cf8qExdS+S20d9VwQ+zhkHQzE7D0bbVcH0aU3C6Awt53ssAoO29KXsZC
9ABhZGVA277FRb4131aA7Pf8wDK8kq2HdLsO/J7YFD0I9WcrP+KFAM43fGigk+1H
R1/Z350Pvwgx4cRpdt2X3lF9enC/dy/wH279/aozWgVz+2Ji6SCWQELMXBkMIHP/
K3YS1n7uN64FPGh7qquhtZIFociUOUv5ghtpsPXW7fuO/rnDhheTrvwqbk31wNMR
IZjOJfRcJr5iYWjO5RGkZdK6HouF1rpvsEf7VcGyIUv4AjwNcmg6riE2ENUaSHJH
ajhHadpRdido8zqhvmW6v4aQF0J3AeDqm556upyE8lKIj7TcRZGNAneQ7X9ilIkx
8C+XFP4J9l/fNru51bZ5AFxSq7JECv7LQ7cEgqFvvDFdawkFyXz3b5W5H6GF9YrK
2ADUIgD2B8bmUeQ12gbm
=K+ZA
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
