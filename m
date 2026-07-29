Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023D38DC70
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338398; cv=none; b=fpMXbqv40eUOIhi2xKuO4ici5YoUaZ1l/wMf+izt4cEBne/Goj20MXq5OfTORH/TMO9fVJVHLgFHsYrkuVKju41yIVZd0sy/rBNJXPIPLJ1kz6ro51x3pefDu8E9K767PDPyxKOKxrOHqFhZlQw43vQaiqPpfeItjfG0b84k+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338398; c=relaxed/simple;
	bh=+eYtpeZ/Sy648DyX+QcMeNqlXPHpe+Xmdd7Jc76vnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxAuPyCOEskPGXgXPDi2aARmDzekMgZJHoePY4lAaarSvfEOg4dUtKvDddUT323wmZpThHlNtCztD4AuEes1+MxT8I4HS6amYcSqZMU0DquJV4yE+X0GSsEA+YZri/bMK1SXwZMEb4WzPv0Fhj4LbCY24cHf8vY3SojOk6Lumrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G+glq38u; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G+glq38u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=mqHR
	osCLI5FWt/wjqM8+7R0jK7y/O7u+UjUyO3zLTIc=; b=G+glq38ut5r9CGATZ0nj
	dRXe9/cKznpuuZqTKaD+Jo7DY1n5lIVQRgrC9jroUWPxI4/zUH5jOGxJ1kf1RxnI
	W3iKvKkW6DZU3wNZsh/oVWBCYHkU15/E+Zej3qtOoXeBWaSL0Gq4q3ugBc1Fn+A8
	fNMI77IlvnViS7agOddS6n1kK59jceNFf28MayDWhWXG83CxtMcJTmJU3LQ1I5M0
	EAjQ99deCC3+4cSWxfS+yJdQ3v1ERvM3KI5FQazzuYuo5b5YI2gWnv6p/uciV4Rv
	729Aa5jhLRJsBTs2VwE1iR940wbgZLbAePL/kpvdGh8p3npYzL9UlLL4JhiKfKoY
	nw==
Received: (qmail 1407183 invoked from network); 29 Jul 2026 17:19:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jul 2026 17:19:44 +0200
X-UD-Smtp-Session: l3s3148p1@GbI0fMFX9R1tKXBQ
Date: Wed, 29 Jul 2026 17:19:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Aniket Randive <aniket.randive@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Message-ID: <amoaEGX8Q4zwHF2i@shikoro>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
 <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
 <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>
 <amh5l4Yvwemws6Cx@shikoro>
 <fc90084e-c9bf-43da-bb8b-43a8d2d0cb7f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NtvOhe7XX5qbYL3+"
Content-Disposition: inline
In-Reply-To: <fc90084e-c9bf-43da-bb8b-43a8d2d0cb7f@oss.qualcomm.com>


--NtvOhe7XX5qbYL3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> I agree that the precise timeout is platform dependent and cannot be deri=
ved
> exactly from the transfer parameters alone. My intention is not to determ=
ine
> the perfect value, but rather to provide a reasonable kernel-side default
> for cases where no timeout has been configured explicitly.

We have that already. From the I2C core:

1572         /* Set default timeout to 1 second if not already set */
1573         if (adap->timeout =3D=3D 0)
1574                 adap->timeout =3D HZ;

This may not meet your definition of 'reasonable', though, I understand
that. But you need to be aware that you immediately enter
regression-area if you change this behaviour.

> Since kernel-space clients have no generic mechanism to tune adapter
> timeouts on a per-system basis, deriving a baseline from the transfer len=
gth

This would be easy to add. We could introduce
i2c_client_request_timeout_margin(client, desired_timeout) or something ali=
ke
with basically doing:

  client->adapter->timeout =3D max(client->adapter->timeout, desired_timeou=
t);

Or? Then we would get the theoretical value of a client. Which is maybe
exceeded by the board specific timeout set by the board designer. It
gets tricky, though, with userspace. Who has precedence then?

> I am also suggesting let userspace add something on top of this if the co=
re
> derived final timeout is not sufficient.

Why can't userspace set an absolute value like now?

>=20
> This is an option for userspace. Should we expose device attributes for
> kernel space ?

See above. adap->timeout is easily accessible.

> Yes, and I fully support keeping I2C_TIMEOUT as the mechanism for userspa=
ce
> adjustment. What I am proposing is complementary rather than a replacemen=
t.
> The core could calculate a baseline timeout from the transfer
> characteristics and apply a conservative margin, while I2C_TIMEOUT would
> remain available for systems that require additional headroom beyond the
> default calculation.

If you have two ways of setting a timeout, people might get confused.

> > > Do you see cases where a transfer-time-based timeout with a generous
> > > system-latency margin would still be insufficient?
> >=20
> > Regressions. You could time out too early on boards which worked before.
>=20
> That is a valid concern. My assumption is that any calculated timeout wou=
ld
> include a sufficiently conservative margin, based on measurements across a
> range of systems, so that existing working platforms would not regress.

You simply cannot guarantee this.

> platform still requires significantly larger values due to exceptional
> latency characteristics, I would expect that requirement to be addressed
> through the existing timeout override mechanism rather than by forcing ev=
ery
> client to use a large fixed timeout.

The only way to deal with this is 'opt_in', not 'opt_out'. If you want
to provide different defaults than the existing ones, I think you should
make this available via a kernel config option, so somebody has to make
an active decision "I want that and I know it can regress".

I am still not convinced this is all worth the hazzle, but let's keep
discussing...

Happy hacking,

   Wolfram


--NtvOhe7XX5qbYL3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpqGgkACgkQFA3kzBSg
KbZXSxAAgw+bXawtzSmPKUNc2txknub8t038XxD+4R2DYbrcklEirwTz9d57/wJN
o+Va+Sth4SPhpU6Vf/ro9Xg457PsYGPt1hL/K/EsgDa3qzUJNcMtKpcYv1VjFl8p
DL3zHGJGem+6oubojT7Bi2osbq2RjszpQqHxz99TBATuIerC1CZ6dPJgYWw3ZtEu
AzlgzVzMOj67CO71JY9gLWem/NphCPNXubp4kmUEul5wh2yw+KN2La0j1+hbQANm
nOj/62+Jz9HuTEjYtDqYxsLgF/hIVkAss7epAEpp8NAzEfFOgY55Lti5OG+y34qd
SX+3eVProWKxiSZueRelQ/Xrymn2erpqkMAFQ40XMQkYU+DL0MGeA5A4YZV3H94V
rZhyA/qDwdDVo2+bUou68rny/RPY5wqUUkN1ef1KMHF4b8F7F+dFWeAyM6U8RVSC
jt7f3fDWTd4wxaVbZIuyH8aOy7zJIwiDioCUwlAVf5tZ/pewOZBeY7xnC3/FABYW
WBY7DfhCP25jsLerh8XFLQ4SO/JuY9cmDYpi9qd3mmQcHc85yKSfLy8n9VhbDa7a
sObiPj8LS7CQggNOOo0r0eYdLaJpM4+KvIHtYV0gDDMx+HF7rV9HY40g4M53aYXh
3BPsCuwwg6HOpHDh0Twv9iGipJDJcDU0xOpw3xoDMcl1cgFgxR4=
=rCdS
-----END PGP SIGNATURE-----

--NtvOhe7XX5qbYL3+--
