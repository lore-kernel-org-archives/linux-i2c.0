Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A22D8DD0;
	Tue, 16 Jun 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608543; cv=none; b=rEmF2uZixedz2cKffQEKlEfX6UeW2A6gyIuSMMewu9xPN4HIXd8XpI6xvueZAxSwELsM9KePUA4KvgeTiG/7FCXchjKWASxPdDF+SK2fXMINX+UG5g6eMaJq3UYvCG0fDwxG3tCWB19pRo77AKzFhl6dKOXYWIzIXT65fjl0qd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608543; c=relaxed/simple;
	bh=/SQg1eSQHyDsO8CKSo+KC9PDL260Dt4CrvvH14zYOiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nng4tH1E0BBux82Izk2T4Q+irHg78PRpKoyUheHAUqqkSQW83/j9k8taHYEF3gjUqQUmPdKfyUm9TH8AzWFWMou9w0jeTSeAVPceMfUSIw/IWqQce1hP/AnDejGUFsPdPRY1HOLU3N3qKuh9HdP0wPxkzawLpyEn4eQtQMYXO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK0Mf91f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK0Mf91f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD231F000E9;
	Tue, 16 Jun 2026 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781608542;
	bh=/SQg1eSQHyDsO8CKSo+KC9PDL260Dt4CrvvH14zYOiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gK0Mf91fmvjaYbm9ee7gp0kUIUbW1cpM7zGCvRJ4Vc0TjO604L7MPG2WfBAuFbEg1
	 3tbrBzu2M/saijG6P5Dl2YYlglyIrOC8w/+lgqKL1vbHeC4ucVt3Tt21ocF+PSJfVL
	 tqgd3q4N8nzMgzjs1Vn/vN4+sDDacQPk+REfQegu+0jzy+KRqXcnA994aD38muJ/Jq
	 f6XtQBmxGTRkG7V7ChK2H345xaOMJ2teGRdnFm8Nzb53VN22wdGV+liwg2xEpVuFoX
	 QC7pHGWs84D0BaGkyRH5sSRpg0sfKH/I9rZ/uF7vKxorpngF8ItTDxKzaNvVWLscoW
	 HpcIdjuJtetug==
Date: Tue, 16 Jun 2026 13:15:39 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
Message-ID: <ajEvCWMxniOAT1pS@arch.a226c7d-lcedt>
References: <20260611122704.7559-2-wsa+renesas@sang-engineering.com>
 <ajBGibftf679T6P4@arch.a226c7d-lcedt>
 <ajDnbQJhfeICowkn@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e34prxwek75i5q3w"
Content-Disposition: inline
In-Reply-To: <ajDnbQJhfeICowkn@shikoro>


--e34prxwek75i5q3w
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: i2c: i2c-mux-pinctrl: change maintainer
MIME-Version: 1.0

On Tue, Jun 16, 2026 at 08:04:29AM +0200, Wolfram Sang wrote:
> Hi Thierry,
>=20
> > By default I used to list the subsystem maintainer as the bindings
> > maintainer if the binding wasn't Tegra-specific, or in this case the
> > original author wasn't active anymore.
>=20
> I understand that. Yet, since I handed I2C over to Andi now, this entry
> becomes kind of stale then. I wanted to drop the maintainers:-property
> completely to avoid changing all the maintainers entry once a subsystem
> gets handed over, but Rob disagreed to that.
>=20
> > I'm fine being listed as the maintainer for this if you don't want to,
> > but I prefer to use the thierry.reding@kernel.org email address for
> > communication.
>=20
> Ok, thank you, will fix.
>=20
> > With that:
> >=20
> > Acked-by: Thierry Reding <treding@nvidia.com>
>=20
> I will use your kernel.org address for the ack then as well, I guess.

It was intended as given, but either way works fine. The corporate email
is primarily important for authorship. On the other hand I'm always the
same person, so at the end of the day it probably doesn't matter all
that much either way.

Thierry

--e34prxwek75i5q3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoxMFsACgkQ3SOs138+
s6F6JRAAwBssz5VhtPDZHvrzvcWYw4kY7h+ULIec7HkOiYHCMIB1EvxPZKVRXSqB
U2gLnRvIfrogWmf0bgmOznFGlVf1lnAhJ4NRpzzZvG56ceV3mWso+0G/EhtrfYMM
b2BWR6h/ib20DcmkE5WrPa5NCdmzj/SO5LK7EoZqv+k2wYC7P1Q36q4uX+JO2iDm
ndF1iQOITRLs5/liBPDeFNtSeDklT9ImoCmeaRoyQiIxwwqn2Wq1GvYOW3NxUkZo
qWHn+8oGQnexwHpaPOPyYP0HDVwRTtjjj77GTjqfouLdjvpJCSHHRg0/9RTA9X/0
40Tu/YpEwjhAzvK+i6/1TBdQp3xhocWakvFL8ZWJ/ns0BuxUuYXNIkmYlscddqfk
xbVRSKcVcAvka/U9ng0BvHfQttQQLfjsUwv4Tary+lJfvYDNKgbFWYIyXm0oxNR9
65PBzpCogce3jvnVkx7C+8JNG7gZNW5N2dMRRwFPh2xzfy5MwWohLMhZyx8AoTu9
Dq1pSQMPbi8YF84L3raiXSP5CSUrGD1K0Jm/mOQaPu35oFkBiSlf99MjKRjZtqs+
ZLWiBRhUp7/k8rb5P+1v2k1Wizp9xE+99j3ETjsejrEa1lVOlRJ7crvbawLeym1p
0Ci70FdAagB6fTLokprnWaqc4iqAogd/ybMrN17RayN/I+IBQiE=
=/H4P
-----END PGP SIGNATURE-----

--e34prxwek75i5q3w--
