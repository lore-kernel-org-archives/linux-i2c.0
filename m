Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FC3A641F
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472038; cv=none; b=NXLQWJjIisa/65pHyp2t85aV8HCO4K9lkCxXJKcdfzt2i4yXis6qXx13D971GgtsAuKaPXiClZeArNfx0ns/orywT/2Q88eY94AtdyOxbC2Msu5cg0ACIEZCn3Cap5C07OdhOZGqrN0lJJ7EJU2Kwm0mU61RBHkAOrpzIfNG3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472038; c=relaxed/simple;
	bh=GTiQAylw2Gy7jQRIFDgoUPGAe10WNXg3tEcwHqvujOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyeSWh/2rTqO7RlxdA8EOZDND7ltbnovdjkkuQJ3RaZtMT1PIpYtEkHjdDtAKf2r4XC4p6kjt7OF04TtDiB8VR0OsOOB/plQ1YVMToPk35zUaSb09pbuqNXyMknHssSWT2L10L38IMNyM4ypUUYyIpT0WQ0N3mPj7DSe/kV6lvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=J/zBOk/n; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="J/zBOk/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GTiQ
	Aylw2Gy7jQRIFDgoUPGAe10WNXg3tEcwHqvujOY=; b=J/zBOk/nhVzzmHlk53ta
	GCgTs9NWbjOR374Fd3lkvZZ6RGavScZqeQv3jkSTeoAKUNojrhudoRpNDVGdSa/Q
	7OvWgwli40IMZO+e1s1yEiOuqHtCObog2ewYRE3/STQlaE64So4/hLIT72l7xrFC
	56/MLDAqSEEtvkPTXN3HXYh02jxjU/IOK6XUZEbB+ZFoox6dOGjpiXxjYQSVew3D
	krwsnUrH1d17FIoPAGmMAcZSahH6mFQdDZeWdYejzeNfTtxKsUk7UIEer9lrPShe
	iKvKGnwo193X/zZZ7TOn4d6iGGfcj4LYLU50cqhHcpyKib3KOSRkFJ788ZGChzWY
	Ng==
Received: (qmail 3178139 invoked from network); 3 Jun 2026 09:33:54 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 09:33:54 +0200
X-UD-Smtp-Session: l3s3148p1@QAAnc1RTGqQujnsK
Date: Wed, 3 Jun 2026 09:33:54 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH i2c-tools v3 1/2] i2cdetect: Display mangling and nostart
 support
Message-ID: <ah_Y4k_ygee9QtWA@ninjato>
References: <20260127-msg-flags-v3-0-e7539945db2b@bootlin.com>
 <20260127-msg-flags-v3-1-e7539945db2b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1bYYZk7OBs5f8RNA"
Content-Disposition: inline
In-Reply-To: <20260127-msg-flags-v3-1-e7539945db2b@bootlin.com>


--1bYYZk7OBs5f8RNA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:25:57AM +0100, Beno=C3=AEt Monin wrote:
> Show the support of protocol mangling and repeated start elision in
> the list of fonctionnalities displayed with '-F'. We only use these
> functionnalities if they are known at compile-time so i2cdetect can be
> built against older kernels.
>=20
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

Applied, thanks!


--1bYYZk7OBs5f8RNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmof2OIACgkQFA3kzBSg
Kbb2HQ/+Lsw+uqYfzNg2/zdA9EMD0FjQGH/YjdReDYuFzfUy2/xVUsu1kn/TsXNb
bdlSroQZxu9nYhkQW1+ghcr4lHxo9iOyDpQKgLlMhwdm3QUxsFNm2Sp2zoSntWF/
2lzrcBGdJf8YKsr2JIo3BcwLZePoqdpOWDuS4sqd1q0xGw+ZGVCSUwbV65LD6ju6
Piu0R8hYqa/Q5+lE1s+1gLEq9hiXj/GW8Zz88/pBjkLS6CJWh08tqPnJgxZl9m9X
XquXivkpW6+bIv3hgHYk+is7Z6uugK7BP9tvqeXpGouvg+5aafbzRbbecx2+6XiC
R67oUc6lpPSSKx1FM3H2l4UvWyVoSBgBgkU5+JcWCI2cURhNUbbTNjiBsAmtGGDX
tU8sXokQoc8HltKtPO3qm1hNMvGVZ92Fk/+V0waWeM8ky3D0Iy6F3cOlQnYtVnRT
poQGCVRSs5bMOA12g7PaxINkW2FvghS2QKRvJtOvO93OnbbmDmWLyhel1Gmz9WrO
rc3YpkAR0TvLFuBP1LJpFurvwCNz6Ru+TiolZLynnh8opbxNOZ+vAmzrjQQHdebC
fXQXrNP/AQ5UsdDVJS0xR6JWPvmrA2eztDC0vkhDYPeUaK5brBY9aFI7RTHR7ONq
3Fs3ojNIhCd/HcvRAhKrDZVIXrUQHLFtaHMd0jjem5LkLVCn7ME=
=2g5e
-----END PGP SIGNATURE-----

--1bYYZk7OBs5f8RNA--
