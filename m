From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [v2] i2c: brcmstb: Fix START and STOP conditions
Date: Thu, 9 Mar 2017 15:40:52 +0100
Message-ID: <20170309144052.micpzdljqinbm5i7@ninjato>
References: <20170303015503.1653-1-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i4wxw6oaeh64dsgk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46278 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754781AbdCIOlG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 09:41:06 -0500
Content-Disposition: inline
In-Reply-To: <20170303015503.1653-1-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jaedon Shin <jaedon.shin@gmail.com>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org


--i4wxw6oaeh64dsgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 10:55:03AM +0900, Jaedon Shin wrote:
> The BSC data buffers to send and receive data are each of size 32 bytes
> or 8 bytes 'xfersz' depending on SoC. The problem observed for all the
> combined message transfer was if length of data transfer was a multiple
> of 'xfersz' a repeated START was being transmitted by BSC driver. Fixed
> this by appropriately setting START/STOP conditions for such transfers.
>=20
> Fixes: dd1aa2524bc5 ("i2c: brcmstb: Add Broadcom settop SoC i2c controlle=
r driver")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Applied to for-current, thanks!


--i4wxw6oaeh64dsgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBaXQACgkQFA3kzBSg
KbZJYA/+NHYDvhF89YAHNa/afD1w1jdpiALJaOM/8RLuDddI/hWWR0+pgyBiK8wT
QbgDhItwIt2QoHBxxUV1Wgu/7t14Z1avODKA1bvUp2mn4xZuI8EsSOMRHYJgw/zZ
LNFoKJB8LUDThf5xdlqMMneqDA/ph2+zuHxoSghjBv3lTBnTAaMvPDWTh63PNmYH
NNfFu8JgcBDNv/CIcrPUuNdxy9NNXPSSzHZYNyNUgsb6a4sMaV+Ome4PLbly+pXl
Hxd7hKQHNlmAPApUGVLgdH8VIWdC4dDZzXvsnKmE8vJdIKVxrWuRg16XSxuUqCq4
UU/djJqFVuXCQbyd0UXzBDBxpAMroo0DYW4LmWO4ODy8RQxpTUAbeLOqjY5ZvCwe
rhr+cOBGOUybMLH2PgXRfqRLqRZ8BcPJhoLTUjs6BMpZwBqoIiIaRtiZBM3jQxkM
0hhfB1STNBY7mi1EqXMlnyPJ45LUhkr7tlO9PemkoLAETn0Qgb9/KeeU5YbCPSBJ
KbxZfPdyQhM19WeCAINCBI6muUivVniDHPfuwIXlZHbqHG1vk62QE2ZcLgroPdov
D18rNaU7xdUdmoszPUGneNKpFA9GZJp3NkSyPR5QJi+/190nE0Ydhu75YJ7WmZ8s
EDyezoO9bsElzu7olA6x+vPXhiFAWK9W8n5jO6PhZQXWXK/DciU=
=eQ0c
-----END PGP SIGNATURE-----

--i4wxw6oaeh64dsgk--
