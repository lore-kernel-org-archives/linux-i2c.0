Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078347;
	b=Et5hETx2hP6TN2EpD+a42G4zsoxKnuN+SYAap651yFS9eWCdGhj/7dVHAMBwBNaloTCx
	 Xc/AdS/upPOUHF7SMX3vLUQ7eD1qvQssvSYzuFOjfV9D78i9vvphIBn8A8owRNmCS8ITB
	 w7rfR2eAyq4bNpjRZse41ZJL4kGR+OfnOalG6EMFfR/vdWC3AulqGoMZ7FANrXtiDkPEs
	 s3DLFrwB21wXn3qDe21PhgSpyfKI93ivKUHs/QakQ/JYed66yuQAhiHJ2IdwTWwp0OxbI
	 UKC00unxZfObmcQwJ85HCX1NiotwtPPT//7+xYOYVPctKT1/dFd7i/sbVPxt215iyZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078347;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+wToQeO2+Fr+YQ/WlPOR2P3Tx97KoB8u5BIN482V4fk=;
	b=x5ETECpKXrsZDQOVEWOPi2ugBq0GflWco4Of0MzGYM8wRCXRv7Q3KItnLX1Ku0FJgjSk
	 5N9ctAu9zGX8k8GqXOxn5w3r80HyygY5aBfiL5PqTAmkvwkvDKIoAgc0TeOV2+v09rCs/
	 kYa8WJZPlwLrShyAmTOHw4h2uM0p9U0/4cI8rjR3lroGxDx1IjMu0sUvRKgazLVNu4nwE
	 78kKvv7srchNvBwsjdW3rMTx5KUjwPtRcXhmYhtFNoaxf+8YnkIaIleAwT6I/oDfyPBJ9
	 X6d97EBJNizV0l+CDLJaT+8tBTGngnTV0BdnxUAp/oyymk2XuXP+CzK7I6ILFCqYIkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bZZxqsuL;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE65606A32C
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 19:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE65606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=bZZxqsuL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+wTo
	QeO2+Fr+YQ/WlPOR2P3Tx97KoB8u5BIN482V4fk=; b=bZZxqsuL2RJnNIYffTQ5
	AQLtzPygbXLn1OkQ9CESMkyVmhCY3GGzxlxdYwBpb1ZAf9gCbP1rzyfShtK7N3+h
	R7MLW64TVb5iR8QZBPMv5/szDthKTyERTqXDD1Xn50ICDJVHcuK/4sN1zJ6F8nyS
	oQF2Iy+fD+R8OdOtMDpqPnwgFb2kPw9clyiQ51iw7eNKkDl2mvnz4AxU8Zj3fFQh
	/USmsq9TfTQl70txCnGQ6MNNmDLqEvjxGFoAgO8nEPpbl4qHB7xsKJ4UrpgxOEfX
	FJesfN34VmXyk5wZa/xxPGG7aztD/OG0uZg5yZZDAGUUfqJAjgWVP3pGWSfrFR3N
	sg==
Received: (qmail 2590438 invoked from network); 7 Nov 2026 20:05:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Nov 2026 20:05:40 +0100
X-UD-Smtp-Session: l3s3148p1@SZvpabRfK8YFFu4l
Date: Sat, 7 Nov 2026 21:05:34 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 2/3 v2] i2c: designware: Extend check for mixed slave
 addresses
Message-ID: <au92fo9RvL23uYdd@shikoro>
References: <20250918160341.39b66013@endymion>
 <20250918161054.7d650d2c@endymion>
 <20250919191400.29274d5d@endymion>
 <20250922101404.65f2ef3a@endymion>
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
	protocol="application/pgp-signature"; boundary="lAuRwTQiQqjnaKEd"
Content-Disposition: inline
In-Reply-To: <20250922101404.65f2ef3a@endymion>

--lAuRwTQiQqjnaKEd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:14:04AM +0200, Jean Delvare wrote:
> The i2c-designware driver only supports transfers where all messages
> use the same slave address. This condition is currently tested in
> i2c_dw_xfer_msg(), with 2 limitations:
> * The code only checks the address value, not the 10-bit address
>   flag, so it could miss an address change.
> * For the AMD Navi GPU devices, the driver uses a dedicated function
>   instead of i2c_dw_xfer_msg(), so the check is not performed.
>=20
> Move the check to the common code path, and add the 10-bit address
> flag comparison, to catch and report early if a given transfer is not
> supported.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

This has been implemented meanwhile with 470f1a71e60c ("i2c: designware:
Implement I2C_M_STOP support") by Beno=C3=AEt Monin.


--lAuRwTQiQqjnaKEd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrvdn4ACgkQFA3kzBSg
KbY5zBAAqsbaDCV1eBXHVb5qHtWb0eriAlnPvCWO2WMK213p8CFvTnMCI471bqq9
VevYuvIaFpvjQyHK4dyF4vrLMbIg4XEsrMeStvHU+E6yXLFvbP/8zgkPNDOXg6lH
PfkbODJRD3msTY2RzU9GPJee6jxBANo7k04Aepbo3sJQvklgmmTSiVWkzfsWN7BS
yqzQ2Q8uwLrLAHWZtLS2uyyvYW1fq9YcGamC9Al/HTq1nQxQI4TMryggmUlMEC5y
CTSTbcQKkYHaOkcUE9T9mvZtYjXvBSpWgceOLJgALwd4HQUTcIzIhMNO/aSxk+Od
FqCdh5kK9Gz1/96llD8ckkjnyrMhPGaFBn6ot0FLkhcEfvOIeSkP8xbb0F6M9Fwv
ElMxnvaj2RgH8c1671MuSMXw7gN0ODSoDcBI5NTjmgk5xdIcz2+kllSyv/Yk2v6J
PnxlVKrFjBAwEsbOfeosMaocfXcJxnjl28miIW0uC2BV4uTmb5XguebZ+kbVgkkF
qB5Qk7HkzEK0SIZpc+QO78uF/NOCYKRMoU3V125/7GBicI/DzD2HSeVADarM02K6
IdZ+2LW/edBdh6tBJOjc2rqAOYKChc+q2sipHjqcS+8GFI88IZV1vazIh3UgeCRU
yHg/Vf3UH7lj8I8OPkQtp4/q0EJlRwGvSd+pcy+RiRA6i2fEreg=
=gam4
-----END PGP SIGNATURE-----

--lAuRwTQiQqjnaKEd--
