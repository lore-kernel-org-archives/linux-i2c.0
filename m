Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC83EFD3E
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180913; cv=none; b=lSNYTS/fKeiYYhYduGHbE1E6jpAObbmoLgSfF62a8JTigFLDpXI2amZuOQsvmVv86DSlRbZC3HvsuCXRVIhGhaNRUW41Zke968mJxDExXGsxIyL+RAJsPR50TFVeFXKYuzn8twVEzLWGNrExg3HefuY5cqA7cPqlKAM6dqyFVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180913; c=relaxed/simple;
	bh=5pCDtqwAbdqVxC2BWIdV4EfWWQAoZ4nexXRTWSu0VrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRwVd8OwiAtShezvNwTCi/qqMNF7TTTt0xmAWoxVzVgnd8lZMacB07Z0XG5fZwjvEcTF2YSPK/48l/SI35+yOqmBe15CgZ3kZWiQ8QgH5GKbwDK5ljggn8xaawxw57TCldyAPb78WvlOIC0TtZWFONlnM9lBK89go1WwHFt/Bfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BtyWsXDa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BtyWsXDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5pCD
	tqwAbdqVxC2BWIdV4EfWWQAoZ4nexXRTWSu0VrM=; b=BtyWsXDaC0mZ7nwaiL8O
	+YMlpb7hiWMayqroIYCwBFDj0UGWG+ME7Su3htk5McT8+iJOGNMWiUR34z9UpsRo
	cMYtGYziXHNIub8r4KwJEREMkZopfYMdQLkife6UlKNcvBuAvSDrdwQOxj4UItcg
	NjRUe5G/A3Xf+2CptZvr8lZh/whrUEcIt8R1AYEHxio7alpa+uRDK7ck4dO/TAer
	VhzHJsBWfipZ5/NBVazpkcKDYP/yioxQRZSznKTW9DYv/+WNGGSJQ6H8BaXvlwev
	cnMehwxbs7XLqcabr20h/nKYFJunZF4nGJmsNMWI4L1bD2ue6G5rcJHfvZj+46q1
	3A==
Received: (qmail 191920 invoked from network); 19 May 2026 10:55:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 May 2026 10:55:07 +0200
X-UD-Smtp-Session: l3s3148p1@+pju1SdS7nlUszca
Date: Tue, 19 May 2026 10:55:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: Use named initializers for arrays of
 i2c_device_data
Message-ID: <agwlagmrvKLSbrSn@shikoro>
References: <20260518164510.805502-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W9IKEd7McofY8XNn"
Content-Disposition: inline
In-Reply-To: <20260518164510.805502-2-u.kleine-koenig@baylibre.com>


--W9IKEd7McofY8XNn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 06:45:09PM +0200, Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>=20
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>=20
> While touching all these arrays, unify usage of whitespace in the list
> terminator.
>=20
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> Forwarded: id:20260518134035.644762-2-u.kleine-koenig@baylibre.com

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Andi, you might want to apply it early to simplify merge conflicts.


--W9IKEd7McofY8XNn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoMJWoACgkQFA3kzBSg
KbZSwBAAjnWJPK7L4VmC5SbPY5KzV9Foc78oUBc6LgoeQ83Z0yavdd5wV0xd9JEK
s2ZNy6jlF7P9ScZlxhwFL6vi+MhtkqOCqBswjjTj1nPuQzFBMU8jXosBq45knQ/l
T/YAJyQVELeDPOv1IpfcrVT3SK3601XdGN3HXWrsOHyLKZmfaUk2KximtmxrjWIN
nxe2KG3RFvKPwGe2x/t0eUpVXjiIILvhZABluV4EoHAskikf8aieAUvbXl0xwpAA
Zqfgb4O0k+cB6zZJZJEfX02Ituhr+jb2NOhVBTIWTmgIXOIXD40NCcFGfSVX/8cU
uOMVYYu/WwsCBJLEoLNZCJBvKIl3yrWgTr3Q7mnG4F7s4Ye9qnMFma8ncNcxxkdB
r3jWP9eBaCKe00ntmOvY5sxxXMwpEzptgx3DuhNqU0VoYkAwwkqlFEbbYLemHS2l
ztJIhmaY7rsWB6FXyWkYTXtfFqP1Vl0ddlH9CZdcO/eGlbrcLvaMmG/KCEVxNpbs
MbpgaQ+m0WJyQflrK2w61k1ihsvyibdAIzQU+rLjrZ+oao4B9miqXoTPewd7aL1X
VJ6s/wWI6pD+yGKXIKYFz4i+8XS655ptx1NspSFMCIBqwdkuNRxF5DORHdpkXmkF
Y+MG2MM71Wx0peXPxKN9uOj+VWkofGCyrNj1AluTfEVegLP69FI=
=W6Pr
-----END PGP SIGNATURE-----

--W9IKEd7McofY8XNn--
