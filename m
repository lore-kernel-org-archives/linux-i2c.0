Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA7320A0E
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024018; cv=none; b=B00tAaDpaZtu9XfV169BQd/fTS7IaqwN8aB/I3YvWyrIFbSlwaq9GdGJhRL9hI7KVSHPTKkQtL+uhAALfU8CHv1kMar+I+za+bemmmd1mvT6yIBJmfzaJu8U1ZJ0KWfCfc19vjiXNO/mmQqMAj9U17ICye+x69W/1HAAW/B+/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024018; c=relaxed/simple;
	bh=TB4b96XI3fYzBbGpPpgvf6jDyYPKZb5+YXF6MnApTCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDTcRgCPJbi+gz7fIHYw3VaI4iiDdraM8GyORrsCLaNdyXtUL2KL8oPkAqZZn0t/9aTQOT5+xbSE2OtXX96ESGT7TIZlS3Pxb27u/zLfX6UnitG0p6/qEIJ8hDv3uqsy0iObk8VnZIO/FKcnuUQfihkRu12fbQ0jRLDFEi48UXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OdeH5Qp0; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OdeH5Qp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=TB4b
	96XI3fYzBbGpPpgvf6jDyYPKZb5+YXF6MnApTCM=; b=OdeH5Qp0c6WweZVmpCa+
	5KrLAaM5UOHMQd1vL2E9S7nQYTCyXxbVXdTIeY2B3KkbViHXu/CH2hKQ/6gK5ael
	S1FzTOa4J1Dap8IVJEsMcETai+t8r1bjEw6Hoqle6ce7nTpMCkQIn+YRWkaLoFIm
	82XjZJJMvh36bViJFpvgyWLCx1ZhPUQEMIaKyegyf45pi0XzCPUk63apnc88mSaO
	MSBVp3Vwp2hG0XcErHDhpQSKfhCkmnjM6VFh97HLtIXvUxdrZhxQdTTR5C1l/f2K
	3mg60KuZl/no9XV/20BWGg6s8ZJCUwTwmvW7oDljqJNocVc9du8MdO82HS6DsGqe
	hQ==
Received: (qmail 221069 invoked from network); 14 Jul 2026 12:13:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jul 2026 12:13:23 +0200
X-UD-Smtp-Session: l3s3148p1@8V0CdY9WsOYujnsO
Date: Tue, 14 Jul 2026 12:13:22 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Cc: Brigham Campbell <me@brighamcampbell.com>,
	Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 1/2] i2c-tools: Allow passing device file paths
Message-ID: <alYLwu9rxeEjPNrT@shikoro>
References: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
 <20260705-accept-device-path-v4-1-c62caa708a9e@brighamcampbell.com>
 <DJU1QIKM2DNQ.UOLEBWH0U0QQ@sevenlab.de>
 <alKYhB6PKffxI2vt@shikoro>
 <DJXC1KBY7IXJ.32N5ILIXL8J4N@sevenlab.de>
 <alT-251aiK7B0ViQ@shikoro>
 <DJY6TSDILIMA.2RMO1HREUOALC@sevenlab.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QTVUQuRngxSsxzNF"
Content-Disposition: inline
In-Reply-To: <DJY6TSDILIMA.2RMO1HREUOALC@sevenlab.de>


--QTVUQuRngxSsxzNF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Agreed, though I would keep the return values as is for this patch set.

Yes, I agree.


--QTVUQuRngxSsxzNF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpWC78ACgkQFA3kzBSg
KbaeHg/9FAiHYxbzdd49egcckwpW7jvzcFvIYPm/CJpzqj6hNthN9JJrC6Qq3Lxl
GXkwNlbVyCGXIeJtYxJFaPm+lPpOv4CFUjkoVyzHup5U33cRkoxfRCXna/yIZ+SP
8idvAbyWCxIStf93uytrbDFUqdsH9DRQDH7qmCaDp9tZqkoUKM96BbcWQM4RuEOv
Qd2MYWp8StYMP2d4jg4J9+almjilG/fhy8px3rUGBSVVjatKQnxBgDSCaVN2N756
qd6IQXjt6IKJdeIk98C7wihVdvZlHXyJdikkF+fHCPxLPPFzmgpBidiSu78L91PE
C4TmrPMmMZr/2du1O/ZFPOS4nd+67zRvX7vRUe5oKpQ428tCfjZbvVY5Zxpm/vmC
C3zsnU52dPvGQu35Fx9Ck14USmGgBVVkDe571oXMc46sSZASQXD/s6SrF82eDwW0
OpN+rgvJFaL5whpYj5zhzGJ+phnEpSPIXIk9K52OKC3f9R+IwPcO5SqMb8q/tfuv
oQbhRfL98QeJSW6kOojvWaMAwcWAfRXtyDUKEKkQ6ZBDH7XK6Qv/fTJ6Z5hJfK7P
3ah9d4tFhw88zR/fNOxK4Ry1WVn0ZdOsscFdLb0z0aRNUIlEiDry6+hZfPFXk7Sd
AjMIXjThc+PkfSHQNYGaSv1isZAUZMe6EC/+p+8d+xoXgEwvK/4=
=XE7u
-----END PGP SIGNATURE-----

--QTVUQuRngxSsxzNF--
