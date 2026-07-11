Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088523E342
	for <linux-i2c@vger.kernel.org>; Sat, 11 Jul 2026 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783799048; cv=none; b=o7QcgoneK4OVZ7JsZmaIbfb2ZieeqmbXnacvhj2xR0088cVd00QFhAexkk8ktE3rwhgiPy1TcoTdr3m28rW2XuCmKJ5QvF3tln7ft4UBApVis869WbN6PzP2OpnXahuWnKGCHfrHkJI6fOsXRu/iMs25yfxPRmM50XgnEjx8XkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783799048; c=relaxed/simple;
	bh=4E/9C710hwhfTnJJWp8TziQbkCYGGalKg6pS3AvkiWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC8Zk4rXxRYliq5hQeMnogjiBMRJn5Vc/KsEc9C5HFqR0MVoZdx5EdRlQoZ80LplXqJSPz3NrGMWf6PIeQjZT5voXq6yyK5iZgXrUpwBIqcZO5Dn6eFXWZUO1WqyjwfrV6BA6qk7udxUbGfe9BsFagHgE8ivP5n3MXiFvqTLE+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NpzsE0M3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NpzsE0M3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4E/9
	C710hwhfTnJJWp8TziQbkCYGGalKg6pS3AvkiWw=; b=NpzsE0M3Nk3ZM9hDhGnW
	7HuyruxPE4Mu7+wprH040potFmBtMYSYDJFLy/AlEtfFm5fLyfjMebgHe2S3u4U1
	QcwjeTOwbZ74KVUeQFB2hxr1xhCwbPtDwtDENuUfreU21L4h4c8TZe69Eq6EPd9X
	7pSO2IEWlyveb5qOT7AcdhkgBpF3BJ+M+KX30J15AzT7vVJx6B7Vp7+/oilxiINB
	oGIeAV5QjrauTo6NhEsP40icw7yUA4JNt2QkpvRXw2D116wS2hL1ftlQE2K7d/Al
	3RRuvMXg76MZaLBfSRxrmrCcl/EBS9qZmC5TzqYbamzNq0szCKjNDQYHvs7tKXDe
	Gg==
Received: (qmail 1982497 invoked from network); 11 Jul 2026 21:44:01 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jul 2026 21:44:01 +0200
X-UD-Smtp-Session: l3s3148p1@gl0xFFtWPtkujnsS
Date: Sat, 11 Jul 2026 21:43:58 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 2/2] i2c-tools: Document device paths as I2CBUS arg
Message-ID: <alKc_hwhYmFue-bs@shikoro>
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
 <20260705-accept-device-path-v4-2-c62caa708a9e@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F+eKcEKVvETyPE7i"
Content-Disposition: inline
In-Reply-To: <20260705-accept-device-path-v4-2-c62caa708a9e@brighamcampbell.com>


--F+eKcEKVvETyPE7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 10:27:54PM -0600, Brigham Campbell wrote:
> i2c-tools now accept device file paths in addition to the i2c adapter
> number and i2c adapter name. Add this capability to documentation.
>=20
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>

Looks okay to me. Thank you!


--F+eKcEKVvETyPE7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpSnP4ACgkQFA3kzBSg
KbYJJBAApvD8ghjlm+Bd/3Gbks0iGl0j9zM3FExEyduAmXiuWOPs7zRFWAIfN5dx
eGj1mOFGdboR0CWMCmvbIGw7AHUxaPS1qC5F2iTd6liio2vqfOc0W5ThdwhW2WsC
0iU7C62fpo5s6ZU0JsCPY6oTPopEyCe3+RHfg1s8rn2K3ziOeEmwLuILu/GjJTB0
D2aSycva5zUcSqlkNshBCytio6IgzmhvEwvrVe95IEXaiGhiWGwJibKdXbroRY/e
J+YZf209qrCKYBVjwk6VnMP7hK7zb4LpCMWGXa1X5+mDVLWP2Ix0e+Sj7MIOZh/Q
KlJKw9dFSxS+syNW0j4P6mPZSU7kIRpKYZdryGqdJut3CEXDb3/Y7IdseUCkumhm
L4IzLWXn+aRNzyntO6ylB7+6d8CY5KWeXrdrgniwJLUC3HxGXfhwdpkS3WOrpfv6
WokPpHVhUoR9uzm7Ucrhm0tubt7GAkDyFkYHSeX4mA94CN/doXMfuUQVuBNeGk4q
MuuB0UVxPjyRSgGouFwy6X5/dBNreWOgCEc6mn7P/nU7g0co01NMA8WsvrFD2mw5
KV34AbtYYR7YO9+nmbdHfUyvuCRsklbVmEvd5O+yl1DhvpigYIbrGy2Iffd+jBlb
+/BvPoQADN/88kREW514fi3jWkjrOzhrTedY8vow6ykT3etimok=
=6gUH
-----END PGP SIGNATURE-----

--F+eKcEKVvETyPE7i--
