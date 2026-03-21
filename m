Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCE257825
	for <linux-i2c@vger.kernel.org>; Sat, 21 Mar 2026 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774119212; cv=none; b=p4IMg1+2i+cprJZia4miP7Lkj+gpBxxqEgwwxsFKkJJiJVTZrLmk5IxVPlnisvVRzKpSVlm1YKXcRg21ceX5yD2mp4rY5cIjCldD3DVy6rTBdREc9XMoz6JZlPQqODQnzRrabLGwWvOT9yGDsGR02JHoNswqUY7joGeH6Pcmezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774119212; c=relaxed/simple;
	bh=jrFiSy8UirUQzk2fGfIl9Sc+caY1oTjJrVaugRuUSAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjMZCUvrI/OGEXcF4JbtU7Up2rmvpyHpHvo8tv3XC47BxQca2LMIhILFMSAgTKtRc9heM4NRZhEUAAZRQp+h1isjPFSLYfqhlLt6aaHlX7NykdQzKtY24OHLAsVr951Hb0vN3J7F5SL0xAavInzrJVBqNxX/171ol599Wz37vmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EYbRzcg/; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EYbRzcg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=jrFi
	Sy8UirUQzk2fGfIl9Sc+caY1oTjJrVaugRuUSAc=; b=EYbRzcg/K+vdMJktpkfe
	l9pKxOyhzdePsr9Lpb2qfzdVrxNMKSREQxL3zqxPOhdZIo1jrEQy2Is71Gq3gdaY
	Bxx+UwUQLxmiJaCteB+dzYCn3i6yrU9mocalVsGCmUEZ7Af1xMFNksXBr/pbXFTD
	6UZ7cduCRtMUcC6k3Jfa7v1C8w4bxZdMEAWjYR8SH7WdWHzoBr2SyErv0n7P4pMD
	xeeby4EfOnmaDRtETXXOML6uXirnzkt93FlC/gNVl3VVfvR7biZSHbR4uYQ+YgS4
	cC5eNECxsTunM0rbdQCmUxC13nezirpQ+04ugqmuu/Xwucv73UN/kiqZsQ4O49hR
	2A==
Received: (qmail 2010729 invoked from network); 21 Mar 2026 19:53:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2026 19:53:25 +0100
X-UD-Smtp-Session: l3s3148p1@0a0HUY1NpoYgAQnoAEXFAPccZfR0+Aoz
Date: Sat, 21 Mar 2026 19:53:25 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [GIT PULL] i2c-host-fixes for v7.0-rc5
Message-ID: <ab7pJYZ68SXC_j6w@shikoro>
References: <ab4-Fe7_muMFBnNo@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kreLmOjw0K5QxrQ+"
Content-Disposition: inline
In-Reply-To: <ab4-Fe7_muMFBnNo@zenone.zhora.eu>


--kreLmOjw0K5QxrQ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 07:52:59AM +0100, Andi Shyti wrote:
> Hi Wolfram,
>=20
> here's the pull request for v7.0-rc5.
>=20
> It contains three fixes for a regression, a reference leak, and a
> potential NULL-dereference.
>=20
> Thank you,
> Andi

Pulled, thanks!


--kreLmOjw0K5QxrQ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmm+6SEACgkQFA3kzBSg
KbaF2w//SCCJDVsH2LIpubXtsBXUNTJ1ox4yBivK/izYpd+tVGevO00Idu/Pmnei
g5B27W9qogCDOf9wtPRfTSZfKtjdWMIA357+5t10mM5b/DRBV8pew8bMShl8IY3f
hKOrQh6OtLBmURaR3DWuKGWu32PA/voQRI7RmxXA9XQ7XlQC0AvYi2fVUNxiAiaO
njTCSI/Dnpb4QVr47+Txg9fkt9b4S8CFu2UTe3P2sM3OpFWNv7HiNuEBZViNg3j5
VnmDpdobqPaiVh6pRbn0LhU8KcEvggDBtL9/BpM2u3HV30rKlLpS0UcRUzi2mVHE
NgAH9kUJli3K+0tgPGD+D3MW2faxA28/pf1O4V2BE+UuELIBc8GN4ovoTrqmgLK0
cd5zQbj3d0yaeCQWwNcxrprMATe8pZaWeAi3389jOh8sHs3T8CKBZkLjScdlTZ6A
ME3U8HHaiIEylShZ4kTor3/fgUuWjS/OYYY18iOQrXnLrNUU9k4VilF9OtVbC9FL
ngu/4/ssBTdS2JJWvof5vPIePQfCaLnWI9cn8Io5h6t6Qajk+FUOw7OWruRrc171
xdN9KCIcq3MhYECwxOF44ai/wcLKjJSgpAsyVaYbJ5yLSl5qyHkiwWp+DLuzSYga
6WiEZLArGSSKJ1ivDGwmX38NCgUqAMftql/unHEDteLQk9f7uus=
=j9Mh
-----END PGP SIGNATURE-----

--kreLmOjw0K5QxrQ+--
