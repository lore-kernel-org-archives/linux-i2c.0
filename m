Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798511;
	b=qFOvZHik82CjclZXF2POd/xXBNPSy4ZM6H+LsZbiFa6ragdx2+wBplhr5A3+pqaaTtTj
	 IDkSX4IvVHulJ1xvBDLW+sqIQ0DTuDsAMDmRo8LhYVm50FBgXLfxLMoyKL8U8vswmx+GP
	 YrM9ycQOLSPo30BwW7fzKU1RpLJGi+FuZlKV5Tsi6bCtTa2/Jse5Iazl8v5W/U9FwCTgo
	 dWrYzm52mwcQY5loaWUlPvDoNmLqTVfNvFUNQ54bpKiJ2joJPDNcSFX6DtZL8a272L6TJ
	 9F1Zk8kVwgiqjAzS93yfQ4nGHRU17Pdf6seJZax919y7vV8V/a+vq1wZkFQb8TKZTSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798511;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nVUcBePgUPORxVVepL9f4xAsZjZWbYf+c0fXJmPOHsk=;
	b=YP968oMRKOGY8wEpv6pUV6Azc1nUpz2oP4vz2j8YyfLStitU6ziF8f1/ywBUFO9PPyFK
	 5gkz1V39mySjVRu0bStNCh9DFKzQ7c/6/rqxwMrn0R2mkkE/AHvH1/7Ak5LYv9fUmNc29
	 tJp1tEU/gKBVA7CpitzNuXaucDOWAE/XeYwq79n0G5kbQrifl1aPxNXZ6bCULglUMfwre
	 6rXvhK9W2R0sD42w6KIvtVPAkhZ467yfCttyYEb2dhTERwlD3akuUw+TjGeBkk33UB7BS
	 yi49GsUXxAy5HSkS1YQGPTcFFkhteAX681pKOIMSMGTPwpEImUYMv6E9u8WyrnHthWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hkXf3N1U;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870F606D807
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 13:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1870F606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=hkXf3N1U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nVUc
	BePgUPORxVVepL9f4xAsZjZWbYf+c0fXJmPOHsk=; b=hkXf3N1UHHdbGQ2wOytX
	0E0roAVp45HjsZAHQHd69v1ND3Sh/QwV4uNmD5G78qx4eijShnQ1QlqVjS7bBGBw
	gl2M7BAV9qo5l7kubbGyA+Dc1XtSUHjtCQPPiEh1IrVLFNB3p2cjMMnrETO6R7I1
	hr2mmd2KziA5uPe/s1fr6hy4cfunXF/DkS3ABdmkyk5GSpAQxuXGJnCB4HpCeOhz
	QtYkJxdQ8d3iEurbXgl736lviw7tIebzmSKH+p4+KaoSUlwRtmZbuSOs41ZhYLaz
	oZA69gsrQV25MIslF/bxJWDF8Ml3hz6eiHFdUFYFRjAEcR+I5AhnB7611MXPS1lT
	hA==
Received: (qmail 736569 invoked from network); 4 Nov 2026 14:21:48 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2026 14:21:48 +0100
X-UD-Smtp-Session: l3s3148p1@GhHZQnNfEI7AwtcC
Date: Wed, 4 Nov 2026 15:21:47 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: andi.shyti@kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	ae878000@gmail.com
Subject: Re: [PATCH] i2c: sh_mobile: request IRQs after mapping registers
Message-ID: <ausxa9vGb2laTzbE@shikoro>
References: <20261017233416.47b09ffff48f.i2c-sh-mobile@gmail.com>
 <ausul_FO8-1JKEmL@shikoro>
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
	protocol="application/pgp-signature"; boundary="x7kVeiDzJ1b6cNZm"
Content-Disposition: inline
In-Reply-To: <ausul_FO8-1JKEmL@shikoro>

--x7kVeiDzJ1b6cNZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> won't matter here, as I see it. Unless the later pm_runtime_get_sync()
> the device should not(tm) be able to send irqs. Famous last words...

Which only matters during probe(), not during teardown... sorry for the
noise! Patch is still good.


--x7kVeiDzJ1b6cNZm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrrMWsACgkQFA3kzBSg
KbYC8A/+NLfjDMbQOaNK5WFerv7OBKXC7mNPPi//O/tJLSteN3HXojxeP0z2fq8H
XvuRLso6dJfXkduRNWc+eYEsgQ4p+g8E4Luo7Yl5IbpGiBgad0rpAQPhN34ppk5L
E1JhUI5bk7scBm/B9dY7UeciAnOHUT1SI7kzCb3TpfvGHMqN3ql83SevYuLP5Dxg
jGlnrPUae2zrKPaiZ9ViN30gCSrC98zCwHDPGs76q9DbYvn7acSSjsit67Vd9vhx
vl8TmPzkP9xb4iD0LyElkGV33hIwgjjXhQlWmUCv39nCBsh/uL4peljgYwZ+NKBE
NLLy9zcKsHQ/DbnqAVVPEODgoAvfQuUalLpqx3WRSqq+ouWHs5D9m5K0oQaMnaFQ
8bCNlSpUEZZFUGDDstoaqYyF/qy1QnbMYfonstHu/QeezOetJDclMaAnwoS9G3CV
B1Gh8MUgeQwr4KTAzVkDZRIK6FBajYoGfoBDnYWt3P99sP7oMbmfx/fRAgqCgGyc
hht5ucV0Bkt58BhHHuzd87RsoQkjzT287AIRxmzJhmE5Wl9QNpzHyEmLQfWSV872
343L1jTaI7gEf60Yn4he0ALyWayWE0kvV6h0mm0hwLQSQsWOCq7s2P86y/CbQoyH
/FwKiRyPAoem37dko5sJ6l5Asxlfn+6p/Ejpl26j9hjXfKWYSr8=
=RAe6
-----END PGP SIGNATURE-----

--x7kVeiDzJ1b6cNZm--
