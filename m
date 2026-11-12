Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481693;
	b=D5N7ve7fIyx1BGiJfSjO7zYiUB3ugMe1yvLWuEcJmRI+ou8P1lWTU81Hq1je61XohP0w
	 rAoA6hHLBIUiZ9pykvtAVsmYiFqbasKhBsWw2WGq6TWGOz3HKJoku2uGbosfe+EN3KHtk
	 NCeRE79vQZzxo1omKaYiZtzs9MSZFI7Dk4JFcUFeBHZD10qFZK+qjB+MhmrZjcVUmrUsI
	 ljIj6k7V2eHnF/qYOD5vYTKrrgWrTLSzvbFSkNgpC8e2q7qnKu6pfPYjueK4urmHgpQin
	 ZruwbeIvEwbX5WCvsLZg8JBXfapjV7/ES2W65G56CcWaFjl1GZZktwsvb8XQPBN3TVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481693;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rqDqxaY6FQK1B+9zDK16gU7/kSPnV5dpSKxxx/jerxM=;
	b=pBm4h81Ghm1tuRjduLxjWKj4giTSSER1zDAGXCto/QPZLta9rUmiuGQVpSRBN3Q+0PeQ
	 NVd+YY1HE2aX2g6TfrTZPXu3ACj6nRdSzGON7GHdNai+oDNfV4RtRoRfL9DDP9H7SkkXh
	 +Jea0O2ct5T/uSOLWomMo6wzEsMFPQYINmhGzyMyD4uXaxTQb+Ge7Rfsdw4uSWYCdV/8I
	 hhS8HVOseOMEd/I9567ayKq0oiPToIy9f2fuH28fW+c6TC1cjMygX/WpiqPm/6j5BneQP
	 rLKgVeDKsUTr6CDGmlmqSgS4fYhSDMFf/WpzTXBH3TebhfXgI+Io+ISAFa2DKhLHfKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=STmeYfAu;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C4606A327
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 11:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583C4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=STmeYfAu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=rqDq
	xaY6FQK1B+9zDK16gU7/kSPnV5dpSKxxx/jerxM=; b=STmeYfAuHBJD+GP8AVTI
	BrC2oOS6TnjLgmZ13cNYkf6LzOnr8OnZ5O/MiYWhgZbs8KwA30J+UHCmWSM5NB3r
	HAUC/8HO0QSOoa1Bog/ofhEDRqQtiyDLfoKdeJOiPuu0M2pUHZHQcueBpmKfu+a8
	5qZkJSnYO0ssfsKsVwuKzEARBQNjWdOIEHCocOjRDVX/irgivClEKtBRLMjqiS2W
	oAlMg5+5j9gECenfvCRb2fS1fJ71myzA/bD/o12CMqrvkzSfqMAPRg3APtnOI8hO
	JAeK3c04ojxs9Mr5iLgJIfXaCNZeo2GWDCiYzOAF2fY9Vv6OfW3M7ErbOc36aBsc
	hw==
Received: (qmail 965083 invoked from network); 12 Nov 2026 12:08:10 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Nov 2026 12:08:10 +0100
X-UD-Smtp-Session: l3s3148p1@BuGwUxJgbusujnsG
Date: Thu, 12 Nov 2026 12:08:09 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c: dev: clean up registration
Message-ID: <avWeGflYIss8Nujq@shikoro>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-4-johan@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HE4yd5h9FLJ4lEDL"
Content-Disposition: inline
In-Reply-To: <20260827102043.673273-4-johan@kernel.org>

--HE4yd5h9FLJ4lEDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:20:43PM +0200, Johan Hovold wrote:
> Drop the get_free_i2c_dev() and put_i2c_dev() helpers and do all setup
> and teardown directly in i2cdev_attach_adapter() and
> i2cdev_detach_adapter() for consistency and to make the logic clearer.
>=20
> Note that the device list is only used at detach so the i2c-dev can be
> added after registering the class device.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to my for-andi branch (with the comment added), thanks!


--HE4yd5h9FLJ4lEDL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr1nhkACgkQFA3kzBSg
KbafRQ//VPRadEdg1UDRxGwxA57G3AzPqcX+O4WPV7AbkARVXReMKE/4/6GPEI5B
qWOcVdQJXnrWuvQ0GygvqT+El8gZ11sIA/CzG3GXv42iLx3aHiMSsoA7bNTi1Yl4
RAAftR284p6KoL0Oe3mcDUXoEhfCWnc1rx66fegmBpFvm2ckf/PWNDu01dbyJADZ
PG4+tWAW0wY2NtDwEMfAhN74spTeFLG8JTL+QfiV8PyvHjfuzFm2tEBx6hR6+Oq2
OlKHmpvwCY67AZqW5c8JdL3NSR6AaI0X/j/pu5+UI5VvsAgKaPdq2TAxpRgDcPN5
kZGO8+OCm7iYBgLAzuWuOZ6BkraanlCwLv83czE7KNYX0CcGyPxKAofKHceCPRJF
sKORIDXUDchohjPWJbg3HNNbhCZYOb09XbJfKqQE4dDPZHxEf2R2/Kdej+ihuiHp
lIcSI5JiEgu4eK63mlHH58n6VRvToxvMd/uHWwxDAQi1X20XTDtvk1mNLfV3W2ZK
TZbEgnDDg0qEZ45XLx621iY1281Opi4y9EvyDXAUJ+pcNgcBCmfCNg9rNFv8dyBr
4MeQelNlYbRPyTQlICtZqd8WqB1MZ/M3/7DrIlhLx5mS6qxGRFhOeXAiCtIRButa
DbGNHcN/C6bN+6VuysneTilvjaJjL2GvD0jmIn+obmnqYk1TTGk=
=k+yg
-----END PGP SIGNATURE-----

--HE4yd5h9FLJ4lEDL--
