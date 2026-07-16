Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E532D45B
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216535; cv=none; b=tiDC/sMaCFQv2dKJs5k12VVniNgzc9pkJ8ldAJpwskZiberUTsd0Ckri6FlINVoSoam54yaiM2NoSwz0uLMPhCEUSl8k8tEht7xb6tApYx1yMB8NZUz4m76KAqJYN+zf6SA4wTo3UxHXkYu8T3SKTlRYgZqnn6NrewTxgIXazK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216535; c=relaxed/simple;
	bh=2uxLxcE835A00ZFf2fzWLEmwSrEwyrxGFbjGEaB/3H4=;
	h=Mime-Version:Content-Type:Date:Message-Id:In-Reply-To:Subject:
	 From:To; b=KNExPPZg35XW5sjTjYg30sU15ejb3jJ2FHga8zxS3MhLicc5mwDqnRyn1x/0Pl1Yq3VZOcR+FGHyA72KnifHdUA8H9qkdxKifBlhbiY2hKY3G7mkNVcspDYrwHOECLU+oNdBV0+Ji2AIiH+Tb8ws1BkiJVQ4zgWTIxfMx2SBn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=EPFcGPq8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GFmJXv4d; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="EPFcGPq8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GFmJXv4d"
DKIM-Signature: a=rsa-sha256; b=EPFcGPq8d2IzRogrSKlID2ZKkkigGND0k4Pr+uCK10MYUma+tZqbuGqkHtF6dr7X/upwb+xO7CiCB4BRdcvpHDOtHb74Unu8S0Qdm65Pa5YcZJK8kgXlW5AIMZ3cGp559U8Qoq5P6v4B+q+hTy4z5n6F0Q24ft+PCDyoZYyqd6LTmx5dSBwkjTV34rBYxXXoGIkqK/fZqklcv69casglkbt9F7eobyrgIkt4T2CzHOYOKsYA8sObo8Ty9VVe9EL6G25Em0eF0uAWlidu+E7tU7Rim3+CIg8bpzE8s+g0E+QsN+wcCyrlZbpmZKb5C1pgf9vMw/kquAjtlNPBr+UZWg==; s=purelymail2; d=maxwelld.cc; v=1; bh=2uxLxcE835A00ZFf2fzWLEmwSrEwyrxGFbjGEaB/3H4=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=GFmJXv4dSLbZa8CczFbWKmquor0+3MHEKUy/pa67L1/FvF8S/a8Gty8PL9S4Z8FAJW9PBBeoXbKYlOhy4wb/w0/j5hNcd8MzLERyDuEmzmqNw3cj2XRBtyzTsKsHHwUB4wCHMcx+Y7wkniYGHU0u5cfuEIRMlU4/i2cG2hXUWg0H57bR2r71QeY/cQsQbV5emKL6Swvm9DZL4U9HpW0+TyIz2RNxISmJ2n2B3+KPAvoVQGNmVRpNBZuqU7I/TXJLPX1DrZbPYdHIZX/Nq7etW3xeZ+JBLcMK/ryuDEFU0m5q2o0eLe/x8crKeq0xleIgKjEXnl7rhZDPgu38mBWMow==; s=purelymail2; d=purelymail.com; v=1; bh=2uxLxcE835A00ZFf2fzWLEmwSrEwyrxGFbjGEaB/3H4=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-i2c@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -869916158;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 16 Jul 2026 15:42:10 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b553b2005d72e963ffc5f361ccd83aaeebd9f8653ec8d7da57a75fb9063c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 16 Jul 2026 10:42:02 -0500
Message-Id: <DK03YZ54GKNM.3L8H1WZEWOLTP@maxwelld.cc>
In-Reply-To: 
Subject: Question regarding i2c_master_send()/_recv()
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Andi Shyti" <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2

--b553b2005d72e963ffc5f361ccd83aaeebd9f8653ec8d7da57a75fb9063c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi all,

Currently in iio there is a large series removing the length checks
against i2c_master_send() and _recv() calls, stating that they will not
do partial writes. Since the documentation wasn't clear on this, is it
possible for i2c_master_send() and _recv() to do partial reads/writes?

--=20
best regards,
max

--b553b2005d72e963ffc5f361ccd83aaeebd9f8653ec8d7da57a75fb9063c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTMrEGfAFxnfnRQ/UIQghIb0dl/iQUCalj70gAKCRAQghIb0dl/
ibS1AYC6bTUaqE5S8tjs2auAnhvS06rlSpx7OJzPUD7BzVfYGnRbLlKNeZd/fuIo
v9wr7/MBgOuEdFE/r/FbiMcJD+5gGqO99Yd9j+/HabLbWsc8O7btzyEefnb+rMjX
dLasKLHkwA==
=rTp6
-----END PGP SIGNATURE-----

--b553b2005d72e963ffc5f361ccd83aaeebd9f8653ec8d7da57a75fb9063c--
