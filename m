Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FCF27A122
	for <linux-i2c@vger.kernel.org>; Sat, 24 Jan 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769255909; cv=none; b=FUCcsciH+KviLI8Ea2xrl320ua49/d9GCmVNPliftdKHg45BssxzcdyO0KIKloHmpcFQyYmAspvBJaU0gnJUs6XEw30pDldwkH8WziYVU+y15hNl4/dSR6VhZZkLTSPMCHYXLIUA8JgOmAVTMHf66bd5ZLWjB20dYZyJs2e3gzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769255909; c=relaxed/simple;
	bh=CUWd0gE6oVDCYdnu2h2ylu5gIU8T6EgndR3LLEMVxJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR1BaMF2oGNQuPTwtSNL5N3naWGRPW2xyK3ABZluO9Vm5QkHEYS8MS2sr54YmiBxnP3nnimYXl+PE20iQ7RangeQCTHODa5cI3WPvm3N0a6MBzei4mgxWtg0E73ltZmVGb3xoooLLZXlFeVohSsYbX+39QMewzmsWEMIyQnJ5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Ju8UGdL0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Ju8UGdL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=CUWd
	0gE6oVDCYdnu2h2ylu5gIU8T6EgndR3LLEMVxJA=; b=Ju8UGdL0tqWltuuQ0pKH
	h5hiHUBsPdfjsHn2bhz1vfAFxVntYWnlXVd2DJh3fUjp4p97jmgFUNALbMpRXrh2
	eb+2iP6ko3xTBEd21gbTAne+O+tPjER28MaC7Lxyo7ysx8H42NYM+ftSw0Be1v8O
	BqwVvbfN9ZJw7ysh149kVq/Dn++Slb9kFtItXhFKjgZEgDtLow8mFJBv29e5jr8P
	rIoOCHnBX1flkZN1vvE/7RlxW71dqPyPImcDiE4xOXyZ5f6YQarCsy6gE8/v78CN
	8yjgul0MS9AwLnwdUWW/J8Q0m+IQMR9rX4AGVSLc2sc22Bvw+wbtF2ozGJp2bqf4
	2Q==
Received: (qmail 1758874 invoked from network); 24 Jan 2026 12:58:17 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Jan 2026 12:58:17 +0100
X-UD-Smtp-Session: l3s3148p1@xdU3/SBJtJgujnu6
Date: Sat, 24 Jan 2026 12:58:14 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v6.19-rc7
Message-ID: <aXSz1uwSW5fvFv_U@ninjato>
References: <aXNqakUtNhWJdgLW@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VBLuOT/PjfOUCGbK"
Content-Disposition: inline
In-Reply-To: <aXNqakUtNhWJdgLW@zenone.zhora.eu>


--VBLuOT/PjfOUCGbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

> one fix for this week. It addresses a genirq warning in the
> SpacemiT K1 driver by dropping the IRQF_ONESHOT flag, which is
> not supposed to be used without a threaded handler.
>=20
> Thank you and I wish you a great weekend,

Same for you!

Thank you, pulled!


--VBLuOT/PjfOUCGbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAml0s9IACgkQFA3kzBSg
KbYKCg//brL/jItFUmaVL2J4OZzfvF5RRf7LSheFbL8+GggJTEkO/PCSdj9KkxgL
QV2ItOqqRAo0z5hqaaXme+4h2bCMxIvd3R+WhD01BLA6/4gHhSqr78dhnGrardSe
Uz5Ll6ORZV0MBzVm+AzAJsT5o+hhZq7Dg7eanOYQT3Lt8i7kigV5IisB9Ki/3TbW
XPFZ6VscWcTaQ6WbLC2HHE72/UaDB8QPK8728Ch6lOrL+3GnV+nZ0KStpO9L7Wu+
uDyhxF9alJyf66dHQ1TGBJdj53sqBe4TkbBSrfmvgdmiFoXW7ItBb1S1oR1uTdse
YqzHhs0EPZXlnyFSYh4P15j4yKLfK6xd5WhKaYAZUbNAqZJeMoyWSdBKvC8bxwqK
/lEegZ72jkWK1tgwg0BXA46Jc/13NC8kUtHB8yeDTHa+bqe2bUG7mniA2Q1Iqr1Z
jZtGKSrry70WY2yt030JIdtPtNNsH7egEkvcGYiY05zkSeWt5ZJA+PB/bSx1I0Gg
HuLhXi50kHcPGVnmPkLGcjb9R55EaUvo4mqdsnAilo6z3O3Br9afkytJGWOFExsc
nofRTQjyvrpGqcNaOvlLqYM9hlRI7XaR/F3p2LXqsFI9yib2sPEI08gOmLEYIHE4
sZRmEI2iCFJkWxonOIG7zqqNxiCtgH1LZgE4GY7hIP9RDkQBjmI=
=L55K
-----END PGP SIGNATURE-----

--VBLuOT/PjfOUCGbK--
