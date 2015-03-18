From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: busses with dynamic ids should start after
 fixed ids for DT
Date: Wed, 18 Mar 2015 13:46:53 +0100
Message-ID: <20150318124653.GC3580@katana>
References: <1426177093-26820-1-git-send-email-wsa@the-dreams.de>
 <1426177093-26820-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426177093-26820-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2015 at 05:17:59PM +0100, Wolfram Sang wrote:
> Make sure dynamic ids do not interfere with fixed ones and let them
> start after the highest fixed id. This patch might cause different
> bus-numbers for dynamic ids, however it fixes a bug. Assume:
>=20
> - fixed id0 defers probe
> - fixed id1 succeeds and registers a muxed bus with dynamic id
> - muxed bus gets id0
> - fixed id0 wants to probe again, but its fixed id is gone now
> - fixed id0 probe fails
>=20
> With this patch, the fixed ids are always reserved in the DT case.
> For legacy board init, we already have a mechanism like this in
> i2c_register_board_info().
>=20
> Reported-by: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Fixed the checkpatch warning and applied to for-next, thanks!


--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCXO9AAoJEBQN5MwUoCm2GggQALJA7MjUzCPZmLvfGVm9Ofh3
8JnqClOjEdy3Y1b3G+6iVuXyrpfaw9RzO2w2nEWwH4b+oATd0QDydVqp1V04NEF7
qE482GQvj7AauDQUllmggQUCnOUpVnJ04F6pNt2SUC09FiaU9vthE7t7w9J6cXZu
6+7B6ymIliaR1o1KXRIDrkMTDrF6HphYowwCb5bJbtmfjWY4Z5Y7nO+U2L7CAsp5
QJAHTUTsx1awlrZgwYKL7uwY9mxWsHa7TwI+CLqzB5Qgj2ZxUeWr1hAIVAOpxP+Y
iJgbSKdheS9xLvosHmgQToqvlqp3AQYalftr+aFQGrHDcRfCba/EyPApa84EFE7G
yVfKuq7hTFzH5gl3RfXr5OCWagJuxsa6qzcj73uP4nyp8ZCWpVtn81dkPFTJfz00
d8VOzcLVu9IhPQF+1/Jp0b5gHMVGsZeTnNFpWFeRGZDUYh22d1h/GTMqGiCtg/j/
s898qXTEeuHbLZDwu4Vuiuh5YPPujgBlEN3paV1eReA/3/lQu0dCWpSu2Fzv+0JP
i+exfaGm3afH1R3pdRo7PKx/nUwi8DWinMn+n4FG0MEvBPiTAQTsasKg1mcBAqVQ
2UnNJJThNQhDL9w8igFXMlWJLnfcGXZa0F83/GCZ95IP6mXn9YtchYwcVyMRESS+
1n/oHNuEex/AulvdLKyK
=DFSZ
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
