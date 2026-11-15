Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782047;
	b=gfrBe1ddWU7638L8pJj52tun4edU8MwcrQ8NF+JhZOhCfa4A/z5IdJe9SwO1w+Rugvd7
	 +Pg9+pHyIuzBsKcDchGQQqje79kPtkg22khuJWiL4d/aGQT154+sIhIx4etI84Mx3uXm5
	 UEWtanXDscIm3i1mMl2EYltw3qX1VllcFvGKrsChWnsQJ4D8XLmC+PtRPzlHlRxeFeSFg
	 ga7lvo6YLtWy++6b+MjXq+dvL50ALBa/0gv8q0WUwGl/l9owRKPyljVrL7jOKll84GJU7
	 dh+txfJW9Yg2nz9IX2+bJoip/AW4KjGpzA39QCDUT9Hygw+8qBUHtp4789bBTjmNEpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782047;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jePNqdXMDGlA0l2QRktnYeDxUmKi0mZY5cwbCV42MNU=;
	b=wLiDT6JH+3YJG+wCD8msfVqc3wI3yxdtw7THzc6yKgjEIlZEzLZN9q5QxaUDbWu5+gLl
	 hhF8wU+npWrQULpl4yO+ccQ0sQ1cSYS90U3D/n9xyLahiUAFTL+ujyndfKfeTiZAxoz3/
	 9rHEefo+9WpJuLkHga3E+xWxiad6IXo37YC5vXQ93A7zd038ncYS2V7I9xDiE7L6ruFUf
	 DJnb1J+ShDH6QLNt+TRcQSylIni69oH6uagUmmtxc3dXN5wacORKFkYfpT03j4JSnG+kY
	 15XBNXV9P1p/eFJlh6nSkKy6fRaSj4TbxPEXghyjATvCzkPOOOqZadn2a9QRLPS73tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=g38utFxU;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52560606A331
	for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 22:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52560606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=g38utFxU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jePN
	qdXMDGlA0l2QRktnYeDxUmKi0mZY5cwbCV42MNU=; b=g38utFxUGsR36hRx6OF9
	JATFSTP0peevUUuWqwq8RVfC9Z4RpzeyYIYZoOGt6N62cgaJGA/4ujo7SAm0N0Gw
	Ds7KxlgnZKq7V0jUuBe6O3Z1DjCbZHvCmrFBJWBaTg26CWwtyDMVS1b/A0KrSvP7
	VrAHDFI/xVJO7apsqBvb6fslWMfQiZulR8TkcxrKE8XFChoqLHDygmGdKPAuzWON
	h1d0YQhN5XhL/ijMa89BKc2pD2mS8suSQLgYKi1RkaaLWKArCmGCLhRbo6aDkJsm
	D/iYJUVYe2QyCwWjFD4aB83TACaGbMxX9mbLDwjLr/BnhA+VopVyf2p6A1cWHwTO
	yA==
Received: (qmail 1046932 invoked from network); 15 Nov 2026 23:34:01 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Nov 2026 23:34:01 +0100
X-UD-Smtp-Session: l3s3148p1@ZpP/QVhgxoEujnuZ
Date: Sun, 15 Nov 2026 23:34:00 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
	Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v5 1/2] i2c-tools: Allow passing device file paths
Message-ID: <avozVLlVBDmYy6tc@shikoro>
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
 <20260722-accept-device-path-v5-1-9c0bf9b4da26@brighamcampbell.com>
 <avB0jS2RfBHgZ6Zi@shikoro>
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
	protocol="application/pgp-signature"; boundary="ZfTyF0djsLjiJRXB"
Content-Disposition: inline
In-Reply-To: <avB0jS2RfBHgZ6Zi@shikoro>

--ZfTyF0djsLjiJRXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Brigham,

> > +	i2cbus_ul =3D strtoul(i2cbus_arg, &end, 0);
> > +	if (!*end && *i2cbus_arg) {
> > +		if (i2cbus_ul > 0xFFFFF) {
> > +			fprintf(stderr, "Error: I2C bus out of range!\n");
> > +			return -2;
>=20
> This fails if you use a name/path like "1111111111111". A diff like this
> makes it work:
>=20
> diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
> index 40d863f..47ebffa 100644
> --- a/tools/i2cbusses.c
> +++ b/tools/i2cbusses.c
> @@ -436,12 +436,7 @@ int open_i2c_dev(char *i2cbus_arg, char **filename, =
size_t size, int quiet)
>  	char *end;
> =20
>  	i2cbus_ul =3D strtoul(i2cbus_arg, &end, 0);
> -	if (!*end && *i2cbus_arg) {
> -		if (i2cbus_ul > 0xFFFFF) {
> -			fprintf(stderr, "Error: I2C bus out of range!\n");
> -			return -2;
> -		}
> -
> +	if (!*end && *i2cbus_arg && i2cbus_ul < 0x100000) {
>  		return open_i2c_dev_by_nr(i2cbus_ul, *filename, size, quiet);
>  	}
> =20
>=20
> That should do it, or?

Do you need some more time to review? Or are you okay with me applying
it with my suggested addition?

Happy hacking,

   Wolfram


--ZfTyF0djsLjiJRXB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr6M1QACgkQFA3kzBSg
Kbajig/+IIHXJyAd2jWYHq5u53VOAq3rRAx9c1E2HPWrfVFAhpoIJrqFJdLilsdM
6jzuRR4pZpBsgPpCk8rkgFyPGp3uJW6eQ1hhVDEj3XThtOqngaka/uP82PCrxDT4
Ch2voV/qkkyzRMtRI5g+39cpZ/CqywqcNRWNci/GADuYVtxqeYxPVM/62NFBoAXD
Vgff+GTOKBgO+Poq2KEWHrtfO4Jzywu+4UNt7PyB7H61eRFc98GDazTN3lkl+AbF
cG4dD13HICLThx80y5kSiLJXHeTEzXE48TRo1i3FDxVGw5DO+5REqlNqBRNwYXhP
LXzVw/lhHCrHjlDS6WAQ+pdgQhslAe3y8j+qY7A82dFNFQH9QprmXMDl2yfN+Ioz
3rxqSsaV225iHdPjeV6x+JzmwlxEQd+gNkt+PKk1idjn8UwSD+8gcm8i3SaPYErA
1Uw2wevZtDsiRmOs4eTyDOYkFRlWpjQpbp1YrjpCiK8KTwxslbfVSxo5KLSVZs+1
U/JgrpybwJTHi4gegjPnSbRziL4HNFZ9AdmlYu/xEq8yrtOleRogs/OfMsLc5ScC
1UDiQbCq0+KZqlTpALV4HQQ53xnTjMgASRkY87kp9zM0iNxk34+XOu78CFBeMKkD
Op4L7eqB6K+VM8VrZFYoL3+t422LuCRWHaypk0/8KqCCacfKiPM=
=Z9B3
-----END PGP SIGNATURE-----

--ZfTyF0djsLjiJRXB--
