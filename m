Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481680;
	b=Vqvz/1voqUg3uXfpU3aan76CYucOTm2B1SmNg+gP91awl7bwjogz3gD9LsOXbi0n/vr8
	 j6Hh4+07ksTDpkOdrICsqLM6QAJz8PrK1XskMW6D+0x/DzZBXANUVlrqGsWERi/37ztwi
	 T0SfiELgzoS6Q+uizfCCb1ckrr7C+IpX0HUaaDm7ZId6833vmTvkaBJz9g0BlvvQZ8AI4
	 IhHom0FERGjw2n02IjWXjOUVR64Pag36hHWQEWKXAYHLZraXy10W98tdfin/ERws3A7Bz
	 q+d4cTtleWEUYvjUpJU+QgSk4+A3USblooh+NcLD8V1W3wpMuu1lzDlhTK7zy5HIGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481680;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ubg4AEkATiFLcqvRQpZvmfN60e6D51CpTXEj/n5v7CA=;
	b=GqPlX4gFvoOgMadLOgtlX67yEaIf1SRxsX5xZuerHppOVI8ImDE3K5SETvv1Drg+qNZg
	 sKnbU5fVjapRtivZjN95XlyR++SfH5IAcJt3Th3Uxsbo/li3lQnpJtQ49EByhcncV1Hu4
	 mXddS7iRQORGcYCGdex70gVRx3Ri8z6dm+1gh3KM2ah0phS32OBBfQIwx1QUL+8v3N2bT
	 lUz+x+eLMnPEszI5Wlzhv5Dv8G+AB4aw/JyXzRfdfmf+WUWmTQgk4J4g2LVZi0oBCPYQk
	 w+IibLAPZQbzCvccwPjzWLONAJyPH6XHgjqeBuy51DEZrEBpo1Em62mnBlqFP9s9UIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=J86u9tKZ;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DECA606A886
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 11:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DECA606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=J86u9tKZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ubg4
	AEkATiFLcqvRQpZvmfN60e6D51CpTXEj/n5v7CA=; b=J86u9tKZajYvjV4vQ2Q7
	viG26cY0fKxHO2zsYYIDPp3trX+sveT0ZSy/+88ouKwbaB5oGjbRM/zs2IdJHwR2
	Dbz6PjwTd/gWYGQs30IcMpPZeVhtxx0eCCfDCNQvrpFuUUY/YE8lRiu4ARc8+8DR
	58N7rZJ7usvD7zFJiRxwLF2RmPeB1jfbrEtjQe1HWX9HmZqaQr2xf9AyErBaqOKz
	vgML4X/r0QromyU+yZCcggUIO7K/Vm5uMqzQ/dJD4M/kWi5oRIDd4aIBgpVofNrQ
	YV8K+CRbtxZkS+d0GdLOdm5QJtdbFUE3DiwfUcdiXOu+mYx6P5QXGbh6IDgFw2/2
	PQ==
Received: (qmail 964972 invoked from network); 12 Nov 2026 12:07:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Nov 2026 12:07:54 +0100
X-UD-Smtp-Session: l3s3148p1@ClW8UhJgpMkujnsG
Date: Thu, 12 Nov 2026 12:07:53 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] i2c: dev: drop unnecessary sysfs device lookup
Message-ID: <avWeCa9OmPGrrm0J@shikoro>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-3-johan@kernel.org>
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
	protocol="application/pgp-signature"; boundary="IThiOqq/X3bw6YYl"
Content-Disposition: inline
In-Reply-To: <20260827102043.673273-3-johan@kernel.org>

--IThiOqq/X3bw6YYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 12:20:42PM +0200, Johan Hovold wrote:
> The sysfs lifetime rules guarantees that the i2c-dev class device is
> still valid while its attribute callbacks are executing so drop the
> unnecessary reverse lookup.
>=20
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to my for-andi branch, thanks!


--IThiOqq/X3bw6YYl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr1ngkACgkQFA3kzBSg
KbZH5RAAru6ukLh3amQf+U7UwZNtMbH2orcRtMPUxBqVlVYClTU/dN66ZANaCWas
/7qvoOc4aUPM6zGzdXB3KeQAfUPaY5iDjfPRPSm4RpUUP01o/7FlKf6q7IXTPmXB
4GqpVGkdpXsBLjVDJGLvPS5sdfUkl91bfas6wTHhSIK4hPVpkoKfMzIOIziluhE1
NtQ8r7FCUpV/KkjrJ+5NpQ+vEwdTmUh6mbrlPvTFfigYjGpxHl8zj8f5FujVQ/QE
AO2IjDJS6OC4o9evxblw1X0jRiw52AflQ+tZ7Z/FOU6NBUABgPhpS/yNI54bQncZ
m7ArPwiw0oDgoLTY5oxWOZxid/rmYdLFDX/nkCdX2Gsf2+xKaf/DyHaDbBlpV6Tg
VIiDItXeB0IQvMFDfKbyknhy1rCvrGlu4owUuw7RLFVixHTfgNNeqEhkMRO2AIuW
bOOly64z+RX1whRQpq7lmNmYANe00rfGUGqooY/Y1idPHJCz5P0vBm0Br5bpypzS
49sUYlld5EEEoBP+ghjrrDJhHxUQ+xTKGrv+fuF5FiJ+qYBdojgnIRjM9mFTJiUX
ptPhdrFPO2/Dh+e+amSwpkzUsWj34Xpi1EcXnhPvsvjcFi0JCXoZXrQTvxb2lx69
5t/RMWPsn9siDsDHlrx4N7XRqUUIjDcukWyPwzV8oAdMHq+fvFs=
=Jqk2
-----END PGP SIGNATURE-----

--IThiOqq/X3bw6YYl--
