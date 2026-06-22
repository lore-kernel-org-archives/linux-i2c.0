Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F640D596
	for <linux-i2c@vger.kernel.org>; Mon, 22 Jun 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118502; cv=none; b=rzsf5qwcwQUZj0sP+HeeGq/W9RUGTOVMsaZ4DH4SxqPRYbcSC1YiE0SraHNp1TlE3KkdxDnMGFsAYqNzQbtC3lHdbaDpDocfWzpxt6xoOjl0NF9v+6GKeooGvMP7m4DPmxlDjXBGhllc3VoKl3byhOWovNALFvdOGhG9QjxkHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118502; c=relaxed/simple;
	bh=qQTtFhw/wv+OBtSZyVVUMARrX6SiB6roESMHGgr7gFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTA5dhwxmK0yste8e3AefoF2OzW7UL/Qzikkto6btgw/ypRiFz2WW/rIt/cWOraoLz4+tJ2Ox1gpd1PSwkWRjFBy0Rhf4jFjDN1FBqnpTAvQYnGCGE+qvfqyxJ+I5oCUAinBv2+jR2QBD+1HS79c/044W4387yYL4vtT8r3q6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QdrFh0qN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QdrFh0qN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+F+v
	unX94ThDVapfucFbZRppEa3U2QTA7uDfKQ5TvRg=; b=QdrFh0qNqBHm6M/jlnPh
	JLMTA7R8FJM8VUITtN7aGpzbHABzd54IuMzImBDcDxaIBs+iY/GS45cXY8JJf+F0
	Mq1opl4lRO8uysb6gucthwuARn+EWBLD3wf9DbZxxoKI+ZZDAqKP3WURs1pmNn+z
	As3RfpuiWym+rzDVSjbdGfgkv6r3wA/16lDKpKK3V87x4j4QQqLO7UqnL8pFjEk+
	qGGSaYw5VZ9LEqtpb4pbROqR4Arcj0QCN37XlR3mr+A53/8Bd1B8frQtSIfyZV7w
	wkjMftFU6yASN0AtQ3rw3oQg6lHEuyDXjYpkSkWoRp2fY/u2Cofe/B2XlnUvVs2K
	PA==
Received: (qmail 1895140 invoked from network); 22 Jun 2026 10:54:58 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Jun 2026 10:54:58 +0200
X-UD-Smtp-Session: l3s3148p1@6/sNzNNUDOAujnum
Date: Mon, 22 Jun 2026 10:54:58 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: "dlitz@dlitz.net" <dlitz@dlitz.net>, Jean Delvare <jdelvare@suse.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: Re: [PATCH v2 0/6] decode-dimms: Implement DDR5 decoding
Message-ID: <ajj4YuedtNBEElVv@ninjato>
References: <20251106021356.208986-1-s.horvath@outlook.com.au>
 <aXq19uxerWI5SvcX@syra.dlitz.net>
 <SYBPR01MB4586E27116CAFBB44B16C493C5E02@SYBPR01MB4586.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iW/7IA8awPiEdyIf"
Content-Disposition: inline
In-Reply-To: <SYBPR01MB4586E27116CAFBB44B16C493C5E02@SYBPR01MB4586.ausprd01.prod.outlook.com>


--iW/7IA8awPiEdyIf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

> Here's a quick patch I just threw together, I'll probably also submit a v3
> eventually.

Please do. I already have plans for a 4.5 release of the tools and this
would be a great addition to have!

Thanks and happy hacking,

   Wolfram


--iW/7IA8awPiEdyIf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo4+F4ACgkQFA3kzBSg
Kbbk9w//XYwhsothbmB7QAta2oN5818JNwK6FsfIxePf72U4it5W4No5SOqmxnut
dtgS2/tI7xLoPr09SlUfybqHuJX6I9UNvZo0KoyM1N0jAF9bMxW7ZJfE0JaxwIUe
nekoEgwkvBErt+OJi7Q3dju8tvlzrT6ys/tjwBFSTBqqPJqtldspc9UXM74MjhM/
i8G7XOBHAxhUYtIiZSTsJANGDeNwX7/WwI2qqQ3RJMSYQLSp5IA4gBRuIjGmW75B
ofs+x7t7z/hRlKROpqOeZjP699X3oweXQSjuRmmGjgm5gzpHmOK8OXsM5o5EHjC8
CmYs+HOQ1Ovgtht3tF2j1CKhcqbNX+hmj65CuvIdawCGNc6QmZrzjTStOr4zpTXV
8/nmhYgnnv9U9PEVBNJW54u4Vs6aJSogaiC0+MAF3Dp7vK3SH1fJ409nhvmCrmf0
WtgN0xV9WszaKsDWnMkqIjz43ab4Z+McUkrg+P1ZgUPxDOQ2sJwIlguJdkEUKJXG
WXStUU7rWvF0wiu8waFUS1fl1KoOBN76Ebe/fRPMFg4ishQX9hnGv3QZ6mdEhMZ7
H+3KTnsOJ0nec/x3Rsu5LzCpUBU5FnXj5J9pubLZ0Wn6KDt9/nuYTN5QqcLClyod
6e0sCtGc+YEpSmtrCWCew2Vfo0agebuT7W2AxuR3BxD7U6J11kQ=
=Rz/b
-----END PGP SIGNATURE-----

--iW/7IA8awPiEdyIf--
