From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: sh_mobile: Document r8a7743/5
 support
Date: Sat, 12 Aug 2017 16:46:58 +0200
Message-ID: <20170812144658.6agnj7jmy6hshhc2@ninjato>
References: <1502196349-29245-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3pzgxkuao2rikslm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502196349-29245-1-git-send-email-biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--3pzgxkuao2rikslm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 01:45:49PM +0100, Biju Das wrote:
> Document i2c Device Tree support for RZ/G1[ME]
> (also known as r8a774[35]) SoCs. They are compatible with
> R-Car Gen2 SoC family. No driver change is required as the
> initialisation sequence is currently the same as for the
> R-Car Gen2 fallback binding.
>=20
> Signed-off-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>

Applied to for-next, thanks!


--3pzgxkuao2rikslm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmPFOEACgkQFA3kzBSg
KbYojg//R6/Xh6kX5zmu8zj9htAGFtptClS4C2HBTKnMOj+FqdG2s9EWx97KBCY6
+cv+jG95h5IvExB15ejZZYJIe1DXflTNzk7VzlFFXH1XdNBBXqk13lO+wXWvdDw8
puPnW2gjKdVFmM+W7j6bDNS/FO2HskaS7xEgxmDIV0V6t4+uC1Jo9AvbIKKNS0HF
rVHz582XB959KfssP4UO2/5yP965rRKszzSE4RghKIB4QCjJFl7a2KWKVXtzEHKz
ER3T5pyp/wqfHp2uX+8GKz4fbGdHLyDOyhC5KJ8+ZKtHKCCZkpCX/sDf8wJoxxod
eaB12gB4zvlxxYSdke6FjB3kI0ItDCme4ThZXPT1NAn4muD94G+l2wcbtrqN8fFM
S+DRzy+ahxymY64+CDvIOTsCmZrJIvXokMhI/KspGymAoV6ql/lOvSEOoBpivnc8
1fSTPMJyJ0BR/QxjQhZ4aLPNC19Weh1+U0tgGJVLvHIinPi7cibixW9Pssg6VASP
eFEyGo86vH9KnQh+OUsJnW0N9XYiyZo95p+fLyUB53nmvh+t7TXd7zqDVZjveV90
wN/rP/OZPPl2cnRbQV/pZK9qgojzKHInQ9SXesVHf/gDtEvGEG3+6J4tOV5OoLEK
ziICO9Qse3vySpZl5joT1PrFZr4tBXl/zh+/Io1u5KgBNlp7qb4=
=5Nn5
-----END PGP SIGNATURE-----

--3pzgxkuao2rikslm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
