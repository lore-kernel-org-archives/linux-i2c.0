From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: octeon: Add workaround for broken irqs on CN3860
Date: Wed, 27 Apr 2016 18:56:48 +0200
Message-ID: <20160427165648.GA6355@katana>
References: <20160426211759.GD4587@katana>
 <1461750279-23654-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461750279-23654-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>
List-Id: linux-i2c@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2016 at 11:44:39AM +0200, Jan Glauber wrote:
> From: David Daney <david.daney@cavium.com>
>=20
> CN3860 does not interrupt the CPU when the i2c status changes. If
> we get a timeout, and see the status has in fact changed, we know we
> have this problem, and drop back to polling.
>=20
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXIO9PAAoJEBQN5MwUoCm2/EcP/1gubAsNSL3V4tRKD2HsJCXP
/l6PX8tF1VA5fg47t0lZJUmGN6Zl/NivDSYrB9aJm1Kqw5w+wv2OFRPvzVyh9ldH
O010P8ofxEIISWx1TsRnwt8mX9mOPXHTEfzyUDBUfCe/BcDesE3e6+OswHizMkdr
dAnd04pCdtyuggYDrv+xzxTfVtpfyLu99Vt3wD/O+JnISOEIVYoqvrMQe7p7S0hf
Y4faZqeXhAAIYWqpqDOvT7GQY9DXvXWHnkU1R8U4YiFAURMc8+DA8AUBICHOcGj4
TcR9jMj/FScdE39sHWfk4xP35sNBAiORljySOEBRVv+pEjM7BMeHARpKj2VGhe29
Rc7O236eWAtxSBk5XNzM0PGPRu0kwRkeSG8RQDpah9jFMsre/DWjK7DHHC25yOcx
w5+OwPUa3+GodY0RqLP0nYqOVOVkl8CKjhhK2anKwckQNY5FT7J9vaW7Y6qJdSzf
J53M1b/1kASvXzEliymDTQ98ZjUbNwkmKmFlAlPaCj6uCS337S8j6bas26UAZEiF
BkLehDk8gq3qhj6KwundarzS9V5YCeP9NWUTiaw0eOntTq6R+UIADm7VgJlNnZS+
MMuQ8ZW378ggHZgJRZJLMcVr/bTS1F/NjhTnHz6bzWlae6qlEnYHsbRwYGpxg/VM
8balN7N46YdAGvZJWXRL
=1y0m
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
