Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921C2931E9
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777467; cv=none; b=FNQ9Goid2BcizM6Ws+3SgJee6p8k80XeJhl6grTuIhCU1MYSXTd3sd5HtohIAF+cpPJatOQy6JanIF19awnG/oI93bh3S86dTz89vYAnspXSZqlw+bBVIIqkjhYBpXYZHbphPcjl0/EGY8MFtbIqEcbFhBFOgGZCB/vrOq4fuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777467; c=relaxed/simple;
	bh=L65B46A8goJWpKzCf36fS5lhtfkQzprXZLX0JFXqj18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMtVv/glDtw+iq2e+POKEAJUipI+E9Qid1of1MPlKiFJrVFDoDlv4YWfr5QUOkii4SM4SvBWpynQskwgLu60ppWQvC/NrFX5+TGYvPoLthCEpum583HnEXKX7H5Lq5Uev23qctkliS7fg2/Z0skbHbBfOeTizRKZXPlzyPorWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZpOSxGEm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZpOSxGEm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=L65B
	46A8goJWpKzCf36fS5lhtfkQzprXZLX0JFXqj18=; b=ZpOSxGEmzwvoWDcucYIl
	CzOOsUDaXmufTTO4GJLFx88WUHrl5PRPYbggdoU++4Tgf8kOx73Jy21G0AjqmXcj
	76pqBNl4FndcSGd1gEu7h+0bCpgGy4GHKE55JrhrRm8+FptNoLWA2FyTTz+XWRFR
	pHnZ8Pi2rXc2yEDQgSsv7gpCPKV93Vc+dj+32/9aDlL9hF/7tQcj3F3EeYCbbqYx
	d+iDbLojIo+7ZdC4kbHsPwRb0uuK06i9PDZ6CJUEiWz7EoSjg7IyvzUpaYQ0caeM
	LlrqeuaQI4TRza3PU+TAfSRaeR1XKxeVskLULjvmQSwDNCcsuztfd02i2JcqPMN0
	mg==
Received: (qmail 3111719 invoked from network); 3 Aug 2026 19:17:40 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Aug 2026 19:17:40 +0200
X-UD-Smtp-Session: l3s3148p1@CF4ltydYFJoujntL
Date: Mon, 3 Aug 2026 19:17:39 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: rcar: add R-Car Gen5 support
Message-ID: <anDNM1Mxt0nWXJDo@ninjato>
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
 <20260727122546.4232-6-wsa+renesas@sang-engineering.com>
 <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iSysX90dcdyNC2tw"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>


--iSysX90dcdyNC2tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> How to differentiate between using SCMI and running on bare metal?
> The latter still needs polling.
>=20
> I think you should call reset_control_status() first, and check for
> -ENOTSUPP, which would indicate that reset status is not available.

Okay, will send an incremental patch to handle the bare metal case.

Thank you!


--iSysX90dcdyNC2tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpwzS8ACgkQFA3kzBSg
KbaxhBAAkBXYTLLyLEaPabvM6lMgNOHi4dkdCul8TIKW/jVYYAxZys+Jg8ZzfxTj
fbW9oqcdx2x/UNKgM2SkfoZTMSd/YHIpouwZXRtvo90udjXh2YGOilNKr7aexCfd
5EyAjW6FcvbO1KNrSGGFHxNZIqPsaXf1VZFhGmleFagdzRndAfl92XxkoPkRGsTm
FxjIHctjJe33WHdpd/d+zEssOAPAxJjyW1gpWgkKRLpHxzpkCgYpLTmBRQ1k2LrP
siAd1ZUwZpvFmvXF+EkXOP0Rx0EShLtREaPCkOfgjhwHV5txU1mP2kKD4ZUAs8HC
LNzfP2kqFdk5gD2v0fE1mWVYgAfz94U5xQHkaVPKj+eegokbhi59RhMHqywpwBCv
PrLthN3uHXQf9wRT5qahK/VurQKTZcuOYMhx5TEG4rDVDNpzG1DMQgB2J0+w8IWA
Cv0EzYQX962GcZP5xRdxKqmgXJ8KLJY0njokQBWfkcQQnDBp8uyInhHsVjG+eAql
ZkvxHtBXbMMMhwc0LtvDmTBNK8Y/TandMj2f+F0CH3SWnVFF8tD/T4Qf2CpCxhjz
mwDOsfIRv1cFTTsRawMeNjNFJuwC3q/iohbiZ7SonTTjnff2mwBN5qunSdlf6Vyj
oRJ0W+cC/7BID8CFB2SKwTYxi5zDt5ocHXMcYlZr+QchQt3OwBk=
=Gcky
-----END PGP SIGNATURE-----

--iSysX90dcdyNC2tw--
