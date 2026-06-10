Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D9352F95
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124959; cv=none; b=YP3Ja92kfNb+g7dV4HRZrZx1tCK9DfSDbg2QEI68n5VP/xZJPnW6SmY0dczFcpb72m/d379lGSptn900N5XuY1Iq/lxkwkXut/h3zYzniVGs+cad7Lij5sE5EQZitJmqN82GKVEIRFwlmxNoca+hBUDkg4bHxbYYeq2uC1WlUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124959; c=relaxed/simple;
	bh=/VZfFByEjb7HXA9kc+kXN7xF/IaBiiq45b8U88KCxAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJB5h/dqGOrwePigPb1vJpAqL4xXjv8klHIehdQxo7NWIdOqndBo9P+IFaStnT9zYaQDOMgbssNWDiqQcIr9Hp1B9agLwIth+VEBwXm8Ih8zyH0veNhABxi7Bhw42EQKhonpswaI9oCDKe/YYsBgO2C+fBqaHeTUaqCjV676+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=aqF584/G; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="aqF584/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=/VZf
	FByEjb7HXA9kc+kXN7xF/IaBiiq45b8U88KCxAw=; b=aqF584/GofLzAyi59R9g
	BxoO1TQ61fBToQdClkAol5IK59Umdx/Zwdg2HUGjCE4ZTxLChSTBSJC11BSluSwo
	6z7sCykdTBM3B2LmUXN9C0I9ckuy8F/wSUeEQ6FXcDPvmLThUn51REIAzCNClgLZ
	2joV8t8gYz/axexLoZ7q74se779u4Cl+G8dI5uF0nycu9WtHpp2Z49vW8WrN+HI0
	eJbPt5QjQgzJ2YaDFQOrBWjoDgOwH4gzPPjW51jtDSaYW/sM6cqt4rNqmIj5QZwi
	0G9oBtYZ7Ykm1tOkiGWuDq53I5bhj0SiaIqFFvwcJloXhn5D1vwG44DZKkQ03T4n
	Cw==
Received: (qmail 1838928 invoked from network); 10 Jun 2026 22:55:55 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2026 22:55:55 +0200
X-UD-Smtp-Session: l3s3148p1@B8JHeOxTdNQujntj
Date: Wed, 10 Jun 2026 22:55:55 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH i2c-tools] py-smbus: update outdated link
Message-ID: <ainPW5a2jWOTgnfX@shikoro>
References: <20260530132934.2818-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t8hRAXrgMpxvyQ50"
Content-Disposition: inline
In-Reply-To: <20260530132934.2818-1-wsa+renesas@sang-engineering.com>


--t8hRAXrgMpxvyQ50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 03:29:34PM +0200, Wolfram Sang wrote:
> The I2C wiki is stale, point to the git repo.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied!


--t8hRAXrgMpxvyQ50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmopz1sACgkQFA3kzBSg
KbaAMA/9F9TxmxiybppdRf6cJBuqwKyxKd395RD95Rx+a9E6y7IujjjkO73Lr95y
B9ODXcD5CgKwNsL+mm3Hl9C+0pla9WH72DZ20MUV5R+sX6eLWL2dgDclkLD4ajuV
L3SIMg1b8z5/nAw4O2YqCaSHD46QmKpcoOLSLHjs63cqrqg0MXamWvp9XumXN5NM
TSDoaA5GyqHggAtW2964Ij+fVENQZX4v+ALx6iCjCJLd5n1o8U7g2wWEHanqtve+
WlL1IFlVwO7lhVnnCwMYL/me1J0FhmrG/7ULPNRLsBjE4QCmLEfc7MvhpyPqtMxh
xLA5CSUSCrmMlxqcmFlQPCdRcMSuNfblpAZXaHt81M00p+/xfFlRBjj+mgBpN/Lf
U7YYLoqrMS3aBkp5Ap32mGOI53tk4g7e1s+9xVQeS+/EsJnj2ecNttk3vHTwfU1U
kf1d7byQ7k+WXkuJg4WxDyPjO8SnQ2gqQwD4piG5H7dM4E2DAkG9tbiXNI2FuoFz
6lqutdL4WN36J9XAah/qYgK0f6wlkgpvgyVrEcy/AMX+zZFUq4rzl4uhfmgmQ/J8
nuXlh1H9lFOMMhFCvr+az9v8pf+v7LljvdIPqeW+F/J3OfN4DheyXO5mrVdwQu9Y
637AenKEnEFIOkPJw3T4hQvdc2Fyo6JGDNy/e0O6aaC8lR7QDEw=
=Jsb/
-----END PGP SIGNATURE-----

--t8hRAXrgMpxvyQ50--
