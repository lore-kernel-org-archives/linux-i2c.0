Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFF283FF5
	for <linux-i2c@vger.kernel.org>; Fri, 19 Jun 2026 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781842804; cv=none; b=Fz10SE7A0acnJDifiRtyvk6SlvXjXSbQKYQh5Uv+4ZSd83hgfkJJUXKx8IkK1iaMhYQKtR3T9yf1l58YB+pFQYf3WKlO5mYTATvXFemtxJeoXYU6gTOjqLFie8Y5ZpqOcI3QoDDNKuSlD6XIXVnBY1K0NbO/3ClP5JeE2Kp36bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781842804; c=relaxed/simple;
	bh=I8IlpP7IcXdBPz51MV0iVNn9IPz8SpnCsq1DEmJvFS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFV/y/6x/yV6Z0Lf/OkyNiKH7Y2mrN7iL5hAp02cdGQ83zjg+Wrh6nOCmeqLD9s0uQOVgaFZoM4nxjUle+A43Bx1xT7ITi19QGhz6i3f0hYimoGVEYZ1fAry50kSmOmWGEiqhIqRMkOUIPE85khVKoasQwNm/j7Jez44F2GBMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=kQqJGqjR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="kQqJGqjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=KRyH
	nZsc3pPdzRUZ257E8WzHog+CRayG5qmdm7sz090=; b=kQqJGqjRE0bxXcoOjvKi
	GFOra5mTYqLvCjkZaB8Y3N+66TUXtquzJm47Mml4DuI7sUg2+LQhBeBcq/ZOAJnD
	IZBKTvKTOWHBIfFD0W7p9FHi/IJ6wxVDfbiO9REVQIMb4wYecBvdV06M1cAM0Wj8
	nYredI0DqOU9GZH6ahrA0tIVZtjAzUaqtluX0rBtKZ09+18IiwAvXOyXnGCK+BM1
	EcBh1cX6E2rqDeNjvX9vTOB65zMpdM9u9iSgWIrEkZBseaqsIbawi7FQZ6tubflE
	1/Yv8z1ZHeetn3CNTpJoYwmCdtBTl3Z+qHB3UfIHm/rkHv8wYZ2zkJPhTUWRTC7N
	lg==
Received: (qmail 811218 invoked from network); 19 Jun 2026 06:19:58 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Jun 2026 06:19:58 +0200
X-UD-Smtp-Session: l3s3148p1@23MKm5NUlr0ujnu2
Date: Fri, 19 Jun 2026 06:19:58 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Tejas MD <tejasmutalikdesai@gmail.com>
Cc: andi.shyti@kernel.org, wsa@kernel.org, vladimir_zapolskiy@mentor.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
Subject: Re: [PATCH] i2c: core: move idr_remove() in i2c_del_adapter() before
 device_unregister()
Message-ID: <ajTDbi7Nqvz7zqKE@shikoro>
References: <20260618184610.6536-1-tejasmutalikdesai@gmail.com>
 <ajRaej6d2npPBeca@shikoro>
 <CAH_Vg8ZUy8CmequdD9i6h7y9kRhiMe7Jmuq3qy=_BDsp2iANuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="guCfh+Cn0I+W6xq9"
Content-Disposition: inline
In-Reply-To: <CAH_Vg8ZUy8CmequdD9i6h7y9kRhiMe7Jmuq3qy=_BDsp2iANuQ@mail.gmail.com>


--guCfh+Cn0I+W6xq9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 19, 2026 at 08:52:47AM +0530, Tejas MD wrote:
> Thanks for letting me know. Will check before raising the next patch.
>=20
> Learnt something new :)

:) Make sure you check linux-next, then. There might be something in  it
which is not in Linus' tree currently.


--guCfh+Cn0I+W6xq9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo0w2oACgkQFA3kzBSg
KbbqKQ/+Pntv/NtLmwE8pcEZMfk9ZMXO8loKvucr7m6f9BO4zPXEA+PFRzgSJxDZ
34iptTTxrYfc0dFZemJlMHGIl/42K6LYWcYgrcTg4Y32qcVmfU9Vc6znmDGvBUwn
C1vRF7NVnI1UX12KIkurY0XEuXu1SqV18Z7ECERlDJ2Zh3T56HJuboFOxv7mErpe
odGe6uFyXAwxj64x4sc2AWJBNW+ZtbP0Y+HIQtBMHPnuynCKGmRQApqJ4IceUbaF
vxs3ozsgN18yhk2Nu8bm4/4AoDVwitO9In1BWhG47D9M2OanYCJ/3sjkgZizJjS8
Cpd1hjzXkjCTlgn7BoLsC4TQfskRQlSMaUqTG/+5oVXGwsNiLQxrSjcfbz8Q7n7j
r9SrsQJ+EIswSgF0KGLAQ5Hcm4gXG30plDh44jh7rTd+csaWL44uUZGhaho37voH
/jtgwOE5tMiC6h4UPSvErtzEkpjafDytX8wELLKfNWjFNnEFaN6TIGoWwy8U2h4C
OoRn3CSEAf51JU+5A9fDq7lXbYgUavzhRZJA/9mZtst5W8U32a4lRwvrAy6fNCE+
/NBqHbGGXjnp1B6BsiERh43L+5/dQOq7HriGRPWaxnoPZ3nxAqNK51CvAmC/nB7n
nuM2DD4wSDmS6Sxcu5vpE75C198EIxfphXVll9Qydkp6Adqjhi8=
=fMyB
-----END PGP SIGNATURE-----

--guCfh+Cn0I+W6xq9--
