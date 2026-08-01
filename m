Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E23546DE
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618160; cv=none; b=d+lzMcdTxzXB/0XJUqaGiDdYFcosDEOCil+E7fygtNMJWf8jBveULcptoZg4kyrH7lxYeCifD5tSU/7eMfkKQDOTzXH0V/lDe/BEL+Dkn4pzcLnWOMTeEqNGOT4FJFechf8tO88A8vB9gjysFBm65/5ky0HW/OCbpxLCEM6Mmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618160; c=relaxed/simple;
	bh=xwwA1YvI/X4mutqLIpkbuE4ICC1y+3Y/dUHwcE6ZnCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtIIYrgoiUryIfCzwJWgCWsCz7qGrBm9Yg4aXHDBJLRHTX9ddJTbDHq9w41m2VeKpu109LPL70XUWtsWXs+bICzVoJ5dMZ032HjuL+lrLmmDhLy0TMtSlS9jFq6EeWdQ53PjNK9kxab1szXTKxpodEQ83QJ3ECgwAkKqfghdhos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KBLDwAHD; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KBLDwAHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=xwwA
	1YvI/X4mutqLIpkbuE4ICC1y+3Y/dUHwcE6ZnCE=; b=KBLDwAHDAvlkUu959dME
	HJu9Dl3iBTtLVwOtuIhXPCm8v9sLSxb0DCCU0bGHJcaiik85fUyaBxR4x3itu1y2
	9vWPpfWg+Y9+TukkJYrMjJEnwK1dFsOq8MdpBLodVOZwLJ+ABHzcp0NSjtMEm1bj
	aP0A8RQqcDQl9fG9c/32jvc+KzQB/Mc4DcC0xxsf6yhLtvImPucV8in+5YaC3fGW
	Ug29mZwro0Iyvl5Su7mn6KzTJOwJNM4pK1USNtBajB3RM5PhwveT0im6ckLMrcku
	pTDn5BNGB4vVbEwWaMVyVN8cCYI2z72/p2/UskRiFB0hrO7lxwWP6JPnqsVOJBBH
	eA==
Received: (qmail 2496436 invoked from network); 1 Aug 2026 23:02:36 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Aug 2026 23:02:36 +0200
X-UD-Smtp-Session: l3s3148p1@TZ7lnwJYKKwujnt8
Date: Sat, 1 Aug 2026 23:02:35 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
Cc: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Message-ID: <am5e6yBm-4ZH1W27@shikoro>
References: <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <amZkf3lu7gjWhw04@zenone.zhora.eu>
 <0c0d1406-949b-49ee-b203-3833b9f8433b@oss.qualcomm.com>
 <ame2tX1RwOo4F6Lk@zenone.zhora.eu>
 <cb1e00ea-658a-416b-aef6-46c151d15685@oss.qualcomm.com>
 <amh5l4Yvwemws6Cx@shikoro>
 <fc90084e-c9bf-43da-bb8b-43a8d2d0cb7f@oss.qualcomm.com>
 <amoaEGX8Q4zwHF2i@shikoro>
 <be5ba8e8-15d0-4fe4-a66c-fe7ce8da6cc3@oss.qualcomm.com>
 <amuy0mdHQlYCcRfb@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1qJfCwis4bv+clGb"
Content-Disposition: inline
In-Reply-To: <amuy0mdHQlYCcRfb@shikoro>


--1qJfCwis4bv+clGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 10:23:46PM +0200, Wolfram Sang wrote:
>=20
> > Given the feedback so far, would maintainers prefer that if i drop the =
core
> > helper entirely and keep the dynamic timeout calculation local to the
> > qcom-geni driver or should we continue exploring an opt-in core-based
> > approach?
>=20
> Well, I suggested a potential way in my last mail (Kconfig option). So,
> what do you think about it? Does it handle your use case?

Another bit which may be important for you: there is currently a patch
set under discussion [1] to allow changing bus speeds dynamically. You
probably want to base your work on top of it and/or help getting it
discussed?

Happy hacking!

[1] https://lore.kernel.org/all/20260719-i2c-mux-v12-0-a5010d623a57@gmail.c=
om/



--1qJfCwis4bv+clGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpuXusACgkQFA3kzBSg
Kbbq6hAAoYOvUh7GIllIPMFO4jAtyc0tuw1DDAPrJxsovz3cOGtm03SVzXLiQ2QM
Eysn/mQmoczzYnkEpX7UQAYyJBTUVn4IBSCrrQkximE84QnfsRdOnsZRD6R1s8w/
/WcG8nBPWyHlqNcvZDOrKyk+LIRA8WtD2sr5/Fqvnb/92H2XTeHxfoK/YA4xHROT
qCugmqdH0LIU5i5Ys1LZ4rYsi57yqCa4dHC8NZnT/SeSKy3xQlSKiaOWbx435HBE
bpKNrokG9oOQU8HKWVQCZA+0xbqBfk/iC4zMg8IhjDikfjuCb7ydxbQAjbuTkm10
Db+3FEGgHDjPmG52M1lfSeEiLCSMGrWYR4ktYLriJeF0irk49GSwdbKBHZJMWAM3
pYKwoNIMy50Xfa5hJywCeD4tuowDpMQRQDyj0KraabOMhGJdClpI6II3ZiNvbKz4
HrK3IsIFt6ywU/K7oUcZaUTcVkztpkLS4uQ/8k5duI9js3P2s6Lnno8PblNLN3zu
q/266a2Bk40eTbRFzIaGrTTFtgPWjxMruOmAfNg2+JNLB0TE287WbJjLybTV/YbW
s1QYJGE5HYq6puYVLnpZ0cdXwsUZ4t9IOuFLN1IjF8loLOIBUrGRN9H5CJwFWAFN
/H+naDrdeJaF546jJ6eS2tUDFiDfgiTR2794FI2Hzyq0XXnQNS0=
=ToTX
-----END PGP SIGNATURE-----

--1qJfCwis4bv+clGb--
