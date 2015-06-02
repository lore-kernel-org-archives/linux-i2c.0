From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 0/6] i2c: at91: add support to FIFOs and alternative
 command
Date: Wed, 3 Jun 2015 00:36:28 +0900
Message-ID: <20150602153622.GB2661@katana>
References: <cover.1433250713.git.cyrille.pitchen@atmel.com>
 <20150602152647.GA2806@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150602152647.GA2806-FuRPzXQv2LUWBfJKYY8PcdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> If you send a new version, could you add stable in Cc to patch 3/6:

No need to send a new version just because of an additional ack. I can
apply that. However...

> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org #3.10 and later
> If not, Wolfram could you do it please?

The problem with 3/6 is that it seems to depend on 1/6 which is a
cleanup patch. If cleaning up is not essential for the bugfix, the
latter should be done first. To avoid exactly this problem.



--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbc12AAoJEBQN5MwUoCm25FsP/RLLZt4YutoPp7csQ5HYTibB
jcGuDKdKBuDUg0qGYAfL9OPSSQoObt9QgPnD90IkCTuURL1xtXY3OJ+qeydSu6Rg
FKfGgCY5B7KQny0Cr7YZrjcGPVRFmshgo8I/Q14a9Pnyl1bUUhiZSdkJSEifVJzO
xRhzVBRctxqrnIXVfbr3i1h6N+YoUbGib1BcRAxYBMUvCFTWc2w5sg+HooDzmFT+
OCKQywcIEUKLKDUrj09/C64MmXebYe20oXD2DJlkHNmhiPrQQCW/VtVCvTeZvtPC
UKnhVX62rFuTOEahAwNMigW6uFx/qH17i0B1eKjs9qrk+waxf8TDXr1vi72N3XwH
J6EWmHSu+YZwAafj4Y57Bb6NxDdjaqXzROK2hCc24DZdQOgsSR/C7B78UCPuk2nl
l1Fg1MERxwh0ZaQtwbRDKoVO4kvnhKg9efKfxpPZ3b0TAqQ8wO3bGm0YDClt8aX3
AOkJGglQOxP/Spvn8J8+6eEE1EfFr6HktFjFksgFyjjo97qQi3zJct+A6TzreAU9
P7q5HqSJu4Evbv/usBkOKRStoEnVENT/WJmPd6uyEa0fYvV4LeTBBcZqldILMYXl
FZHhdMvE369QsUBN7cimJiTyL4d/rEDjZB5X2cTiDajLF0sz887d/w2vYG2TC3gP
CgTL+UAp/FF3JAvwsRRs
=d++R
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
