Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078441;
	b=oo8cDw9QIxFCE342ttdvtanda60zS0HG7cksQdiGL9aeJ7FMjG6gPIDhWXSbGZiNIrtZ
	 voWSgFYdmBoM+/4AJQMW1eTZxrXqiVhWgeVBflfgO2X1etDKcb0H+xNmBXGooB7ZVD4oC
	 DXDtEOhCcspOyzOc5nm7pcKevMp0Oes1PKDXua9TwUX2cvnztpVjF8dplxyNCbT5C+Bne
	 t6he7wnHyXaEc9BksFbqMl7Zr0OqCBNqeJZct98sZmQQygPRaF9Ofn/A92KCF0o57aKwA
	 PGAJTLtklHClnTywZE8bmWbCMFjjyCx3qB+iMO5iAdaMEpd4ZhHyYxyq2KVpRi2KKlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078441;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jM99XQ1auugM+833PFPCOecFkt++NI72rd/prb/2zDw=;
	b=oqiFvb+oS/kaIcHYURIpEFnGOZcYmWSvFuiZgHSKU0fSwnu/jVvbxb429PO4/5IB/Mh1
	 aa94f0xwmHShQ/x+d9dR5c7qw/r25Z1T2ac6fg29Ul9QRZpTwHk3mQ2EzixkX6WG7s9CN
	 4XGxkjvYoBjpqS5VXWNJOswqutgfpC6ZaAV8M6oDB+Yy+VOEQQFRTKCnSn4xFMMox3PCY
	 WUkemqGko3bDAb5r4o7CKi4MA8cnB73JQv9pYiIb5y4rmJbn03zoa/+ylDEuvUYwTIcfw
	 Z3z1Kcg3O3+HU5pZ5sDT0CQTfgMnMVFlZ+6QIZlzm7KgG5P9LA//vAVKr16aE6FoTdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=WnSi27cd;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B64606A326
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 19:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B64606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=WnSi27cd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jM99
	XQ1auugM+833PFPCOecFkt++NI72rd/prb/2zDw=; b=WnSi27cdUTD4lGOuYCej
	Nugl7Ae1ZUAIG/UXm4YW9vADbdUBKzs221VcI1iTKWgwSAPwExECV3IO8wekEwh+
	QVK4GkUxPjSh9y1MeFz7/InSTIHm/sD1zSRNKbbB6zBWzOOqO/w68PnLqCjZmy4j
	udgd5E3BKsCX+HPKFDVKG3OuXKockmqpiXg+L5h0Z0oxjEQGRFx/Hg9L5R85CPSK
	zd9TUzYCVNdjytuN6eLH35V0SI6OV08s6TfqP/qOhDNkTlYLpv4YuUeFlBvpQW4j
	2n3+XZCWYlrU4FYt2mlqkcwnm6A/UOuJYqxmhWfkaO2QXxMN8Fg5FlISN3LcEihB
	Bw==
Received: (qmail 2590729 invoked from network); 7 Nov 2026 20:07:14 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Nov 2026 20:07:14 +0100
X-UD-Smtp-Session: l3s3148p1@PGq5b7Rf99oFFu4h
Date: Sat, 7 Nov 2026 21:07:13 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 3/3] i2c: designware: Turn models back to enumerated
 values
Message-ID: <au924XRWYCsgtwDs@shikoro>
References: <20250918160341.39b66013@endymion>
 <20250918161301.5405b709@endymion>
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
	protocol="application/pgp-signature"; boundary="16+Ws99hoaRVt7hi"
Content-Disposition: inline
In-Reply-To: <20250918161301.5405b709@endymion>

--16+Ws99hoaRVt7hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 04:13:01PM +0200, Jean Delvare wrote:
> There are 4 flag bits reserved to store the device model. All
> accesses to this information is properly masked with MODEL_MASK to
> extract only these bits and compare them with a given model value.
>=20
> However the model definitions isn't an enumeration as you would
> expect. Instead each model uses a separate flag, meaning that the
> reserved space is already exhausted with the 4 models which have been
> defined so far.
>=20
> The error seems to originate from commit a5df4c14b9a9 ("i2c:
> designware: Switch header to use BIT() and GENMASK()") where:
>=20
> define MODEL_MSCC_OCELOT      0x00000100
> define MODEL_BAIKAL_BT1       0x00000200
>=20
> was erroneously converted to:
>=20
> define MODEL_MSCC_OCELOT      BIT(8)
> define MODEL_BAIKAL_BT1       BIT(9)
>=20
> While numerically equivalent, conceptually it wasn't, and it caused
> the models added later to get bit-based definitions instead of
> continuing with the next enumerated value (0x00000300).
>=20
> Turn back these definitions to enumerated values to clear the
> confusion, avoid future mistakes, and free some space for more models
> to be supported in the future.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Rebased, add 'U' modifier to '1' constants, updated commit msg, and
applied to for-andi.


--16+Ws99hoaRVt7hi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrvduEACgkQFA3kzBSg
KbZiJw/8CGrWk9lfvhFdnE8FvOBNRFE4QG0GLjqJuuaLXg+k1qa5kIdKPF5WfuqU
xWcyYgE/CcYdgigmHy1+I3L4hOXYnNd7ZhzSfBzlANArftJGq3Mvr2IBej9/tRsO
IS72Ow2JLGnfdE7B5qEZQcb7/hI+mTVgaCUyAVxjleauy/phOLGpy7gwbDnxzLOs
FN7wECmnl5aARoLxT3LxgycopFYCDp+JrVp2yABR5S7UK7ttQYYf9FhYX6dD2hsF
k0rhGEWSXkoJu7WM1ZVyvtV6xo+eopWka2/oXLXC7pf50VPOkIL7nIu2IAVc/OvA
EDPillyDreE5OLcw8axyIDrP5dwWHFa2ph2BLTJIjrfHmsFGnqw4ilRYtijh40cb
rPK1fKGpLHDx7+ZDb6dfQi8uVYhx+MVxXhzgiHSvTsVBoOBaPWmW/fD5ZkMZOauz
Pmjco2CRvn+PyHYCO4//9dqtz165FHMYnN71pzCqeX2gygeAYq84Y8xmt3n8BYtX
a1astLFWQQPtvX67Sm+w7u+IaXUhmBj4VXV+r50RQ0KAwwKx6J/9rrDXeMQJgeLi
/3VMrW5h/W8jfwG1bqGoAC21EwL060eI3q5Co5RQm8PbwcoZA0066sUk+Wxr7FhJ
W2pEVJ8mEwiwyHxpVC0mFBFNFgSi/Ncb3wjJbn2HtGxLyyHE7E4=
=7JkR
-----END PGP SIGNATURE-----

--16+Ws99hoaRVt7hi--
