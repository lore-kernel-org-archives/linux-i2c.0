Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08230171C
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783426592; cv=none; b=ZQNp/0TQhkLGv84OxH7f+j/KSBwjD7qcj+ujoZ9/BhOHIWd2UGXcLVosHgpQA3YlWXyiG8138079oM+9ilG8lBqD9xawXxMyxIy7DW1r77gYSax93Y98QSoQOVyNJhj+As6/7QnFDTSGYZEMHekaOg+IXv6CiMfXEjoY2YBUs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783426592; c=relaxed/simple;
	bh=4293TNgoQ8DIEVsh61yjRy4qqwMsI1rxnwh2mEzSQZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw2GCeQ+LhDrOr89xD0cAjPTa6WEW/A778AMlIIk/gtFJMp/qf5tc+9G0YNlNecLK+4SIYhU86zKa+WfnaCzTlykVcNQ0sLivw3de/6xSmE2VI4TmZuIl8N46WBdttIeDSRQj2PzZY3t9MgC67ot9nXAboy6v/SuiRP1SM+T79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k+vlarNk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k+vlarNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4293
	TNgoQ8DIEVsh61yjRy4qqwMsI1rxnwh2mEzSQZQ=; b=k+vlarNkUu6oOI3sD+Je
	sJD530D5cI4Y6ohc0CqBM8BfmGJS+X8oQnsfGnhzySC+QrJvK0a01fMOGucamtEC
	xK4GrFA6KgjAH/WLpEv/h0zzNFY8xjfV0kuGofMlG+9v2x1vS8A5HSL2uKwhoZ5w
	Rc4SySeRe0zqqfQcZb53deswTl3WmbE88FLTY0egF3tecUPg6ekitCQ2syZFvdnD
	cKjI2/IYDa63q7AQBQykm386JFwvuFK6fa9/Nw4NaZ7WYwgQ6KLrQza24EZ+cRwL
	neeRwpJtk3IRo3m9CCj5o7cGfSrSSZopnbM9xwzMAmz1EozcBnko8toZMMvbO+f7
	Ig==
Received: (qmail 262256 invoked from network); 7 Jul 2026 14:16:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Jul 2026 14:16:27 +0200
X-UD-Smtp-Session: l3s3148p1@DgM7XARWRpJQT+F6
Date: Tue, 7 Jul 2026 14:16:27 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Stephen Horvath <s.horvath@outlook.com.au>, linux-i2c@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	=?utf-8?Q?Beno=C3=AEt?= Monin <benoit.monin@bootlin.com>
Subject: Re: [PATCH i2c-tools] TODO: add file and describe items for the 4.5
 release
Message-ID: <akzuG3VpcoUWRhUr@shikoro>
References: <20260705181043.3757-1-wsa+renesas@sang-engineering.com>
 <DJR7QS1LOHU0.2PNA54ULDF2PF@brighamcampbell.com>
 <SYBPR01MB4586AD69D431CAD2D26ADD68C5F12@SYBPR01MB4586.ausprd01.prod.outlook.com>
 <DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kOFo92DXN3SBH7PP"
Content-Disposition: inline
In-Reply-To: <DJRA1PB8LKKJ.2RTZWEP2LVRFF@brighamcampbell.com>


--kOFo92DXN3SBH7PP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Using `i2cdetect` on the i801 SMBus controller, I see that it reports no

You might try busses 0 and 1, too. Some laptops use the Synopsis
controller.

> Interestingly, I see warnings in dmesg upon running the above i2cdetect
> command.

How many? If it is in the 120 range, then every access from i2cdetect
fails with it.


--kOFo92DXN3SBH7PP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpM7hsACgkQFA3kzBSg
KbZjew/9E4xuqq2JL3FnTG7u0YzDVMW7ElFOTZ4ZiWVR2+wSfHAIG6bjAmNX5J0T
B43hSfJiLNXJMp0vDgfBSvoGX34kri7/jMjpVwGN7F59hwdxp74KteyE3iuYdB/M
p9fo7h51G8NbQKj5viLNoMv3LqbLHwGztfYsCFrV1pu8uolerfP0uzJSUkuCQjPH
/kNXw3c2CMxcTYQDgHKFJEPSrWM2UaETivR2zqhJhBjL2/DQ7xZLojfpGQMJUgZ1
ngMdoqGMO2z1egZ3JtFeOIj8T65eeN7rt24DSsX5H0u2dvitez2uW9pwfV9JcIMq
FLbIaaIQ5BkSeqdRFAqVnldXkwjjAWxJhcb/Rc4CVD+m4pco3MLNxxljoNdXHmgw
CZEMpM0uUWeJ+9ouTJuhxMk6RvO9FD1uMSt7m9yXvKyxxSMKtz8n8SRipJMEAT9D
zdMqBcJRHXjxkSpomrxhyzZEV57re+CtDdQqc8S1ZEs+zk5cCkNrJkE0eXSmlM31
D7Wjh9CY+SqyYQtSZlmshwjhdyNBH35Ean/q44KE2nUFgx9Alni54WAdAautE5Kl
xwijMdei9ucjp1u8/l0ugkfUshLsdVOxwF8iUHuHoVzWb+XHLdJgAirXXFQezcnq
eRVDZh8g04T3SVKTuP2O7Gk/7oHeklVmtarRtrWq4OZBbSIZp2M=
=ugLO
-----END PGP SIGNATURE-----

--kOFo92DXN3SBH7PP--
