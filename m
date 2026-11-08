Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145236;
	b=avWVO8nFYj3x7tbXeCQdvaVAwzwj2khPEh0fqE1XjfjBbQzuLjpU3z5hyaopBVrP11bY
	 WaniPL37aPkfTUZq8zFvPI44jPWI+uQacvFp9sKF3Kgvmq6+nnPuDRX1JE5XIid1rlVdi
	 uug0i6iWZaux6v3HQsxGsoMSS4jBu1jX2VIQoaCAFhzn4HK4bNH+iX9eWoeRbKX21aq2s
	 Wiy7wSX1BIXz6Z1hZVul4WvpDD/r8NdDTMP6nDWPQscNUInq+rbGnHC5PDLroGS4cH9aG
	 JzsmjnLcr1LtP9mSd9KcBeUGHbGJQJCveRtboW8fRg8A5HgoRq2ugtu5z2ctJryOjCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145236;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5+ZiTVjgAoY9WmiLtiGcJ45ZbwJkkM3n8rvr9vPsvlg=;
	b=aDDVy4qiL4fWGnpGXZLuV2Ve9VaRYjpVzNHVaLF7HA+JyHcOzpb7PcLTfU1lV9gji8Iu
	 C6bfEA8crSqff+FJcsfYEqmie5jjrhrBWrEU3i5EI79OPwIMG7gMzs6j+hWyRyn3e2lJK
	 mKJzjw6s/N0zCCoiggOa6FPLLwXbggTNkBa9XOA0AfPkD1eiE8h+CPGh1XKwQn4z1NRDl
	 AJdzyQwm9mvjMsoDn3uc2I1J0jUTo8blx2rHZ1EoFtjCPhOA87MQoAa+UvoROrTBtV+UP
	 OXoqC8LX7euKzJTpw/tCE9/6Y4n/1svAiJ1kbtyY/+9CMcG4q66HC/14216rmCpf5aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=mIEk0dTp;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33F606A31C
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 13:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E33F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=mIEk0dTp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5+Zi
	TVjgAoY9WmiLtiGcJ45ZbwJkkM3n8rvr9vPsvlg=; b=mIEk0dTp18YJ35JWF+5O
	4qaxeYw3eA5U+8OeO28gg8q1lqalztoGio9OZXZkVtWIs1BPaImu97zKwnXoXPbU
	Hs+obVeaa/djEPiuCUUoQXYsREgIhx6jjdnBSZCHZXIKI9/LjSI9U9QgJFghTrba
	xxVWjwfE7geBnQGlXtFyoGh0DItYHaTZl2ge0uE03r47hRgBcN5imKRGVmIcx0xl
	56yBddTHW1m+NiHGAGmTqgVQ5oF2iisn1qzUo4bAOeywpleWwI1zkZIYH5aj7uL9
	3frpzWV8v4kAnhuS8ZIGLex3m9Jz1CAbimty0X3cBEHent1cpsQR/usFuK6fhwQS
	oA==
Received: (qmail 2859629 invoked from network); 8 Nov 2026 14:40:31 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 14:40:31 +0100
X-UD-Smtp-Session: l3s3148p1@BZcq/cNfbIUvQDC3
Date: Sun, 8 Nov 2026 14:40:30 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Tandra, Vasantha Likitha" <VasanthaLikitha.Tandra@amd.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"jdelvare@suse.de" <jdelvare@suse.de>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
Message-ID: <avB7yqDZ69juNrXb@shikoro>
References: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
 <al6c2VXwLFcNRLu7@shikoro>
 <DM4PR12MB77657106776BE150FDCCF7C093C22@DM4PR12MB7765.namprd12.prod.outlook.com>
 <al8Xa6P7YYRwOn3D@shikoro>
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
	protocol="application/pgp-signature"; boundary="5dUM5y6MIi8PrsYm"
Content-Disposition: inline
In-Reply-To: <al8Xa6P7YYRwOn3D@shikoro>

--5dUM5y6MIi8PrsYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vasantha,

> >   Could you let me know how you would like me to handle this - should
> >   I keep -T/-R as set-only for now?
>=20
> Yes. This is the way to go.

Did you have time to work on this? I'd like to include it in the new
i2c-tools version which shall come out somewhen this year.

Happy hacking,

   Wolfram


--5dUM5y6MIi8PrsYm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrwe8oACgkQFA3kzBSg
KbaY8BAAoyDv9tg4gNqvm+VWc2fU+alnaTXk2SVwSJCXx56UGSER2zRVPeMp6mqT
yBzdVYao30cFHACNvWfgzsq+v92ItwmhYvKaHcw1HXmi3+cxjXtQY1u+cdEyy2/R
IfgnWndc2g2bje3/9tC3KSmvsxEQ0fsx/GGVMH3px+qVVc4yASjdbVwr0R34EhvP
BPlkQFH4kNc2j+n8wb65EKqw+M0zVSD9LnIHchQmqzzGGUd8/IILr9oV/HPS7Btf
eR2OnibnC9fK9Jj5wQWktYCOTLWLWBR9Ymfiw9Kk04/5QGEXktpX2rz/Wp/yBfPw
ud8q5WMliI8PesRcJL9AHqwLkz2rq4IxN32830ULZ8AU/Cye/Vm8GaJcDIvUEd0v
8rAkjVXqv7yq0wMIIbqBDy/foqUVpsm1oKi5nHaU8PYRR5Z5pB3iSy9rkMPRKdRK
dwn08B6QAFxHkWrPIPtjvR77VWCxxMlWBmF2wJXuT3M45nuZzeJs7H7Ho4mkeqNH
fNsQhKnQgNWRGYtZ9/o2hqJ8iqzu5drjCRzm/cE2MgbOWfV7uJFLPHavT4z32uYV
Ca5METQGxQWaaKJSzWvCenZ32jzsy/qYQwx+J8vP7siF1XDVoaq9g4ItrKx1cftm
cDB7ogEve9gBX1OXSK8wvCqmYeHxLSFM9ojWxh9spH839Z4+qUE=
=nuWt
-----END PGP SIGNATURE-----

--5dUM5y6MIi8PrsYm--
