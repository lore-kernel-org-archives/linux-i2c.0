Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816012;
	b=GiA5TsaGoNsqA1jDOQ8B7+T75u25aPimhZy0EH/loDlbHVCd5OCS1ox3et+vGu17M1BJ
	 GJJ0GyhP30BI9MsuWZJkffs/vz8YYh/qE91OzX8Sct43RmiFuI4E1/6e1OgSNvvy1xErC
	 U6MYycPmtwTdQaqALl2agHY1HohigQQtrOQubaCAm4vZprV1f4mpJnaGp7foV5vD7pfBD
	 t/GTas/My7jTLKo2JNb/43znE3Q3Jdk8cPBHSR4qRfhkQQQ7J26oBErzQ+ei6n/Hg68be
	 WbkM+Mujh/sh0/iS0AH+6IBqSGLDvefZIcYRkbFE/NOy2d+Pthz4CZMMgzt2wy4qTNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816012;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vNssu5S/OqDrPB3Q+G6ST4qXMTNu5i/ahR9bjMLGTSU=;
	b=ddERGR1jO95xHyfDv72cSLeAeKjkBSdtmQ/uaPBS0OXq6bPazX+NjIQg8MvW2wGgD/d9
	 6ZR+MVxscg98vp59GKIBMTuo7VAkfMlfmKxmhyIZVrNUggBLJzlaGmZTDR5SYtKtjBxAJ
	 kcHZA+6SAs0b3NEBg373nPS4h3Hee4wjk2XM+iBULjqoSOzE2T6CFsNg4PcbrPwSlMVNd
	 KTx0mBvJ3PmCYqpMaOd3Fp4rZqkVxpeivlXhTxEeHKuYfKTaooem4DkypodzxViEx3BNz
	 k/1mlPGudGliwCE59V946LMw7IdcjgerlEOVDHD1uUwdljiqklZ44ZWq8oVK9l5K09Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=aaIemIGH;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD0606A323
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 08:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08AD0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=aaIemIGH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=vNss
	u5S/OqDrPB3Q+G6ST4qXMTNu5i/ahR9bjMLGTSU=; b=aaIemIGHzT+TjTX+xyJX
	+iLTOdSO08Ly5Z0OM+m+PcFUXmiMYkXv476vEJCD5bGAHlKUNoYrEnzLXCZEUuXb
	4akN67akAVycUOr5SvHhZtEWgb0/0x89bC/OF02Upxvl6ZuZgDOyGTRmdrazJ8E1
	xLtXwwoXpSutCTlRAdimLhl/KYQ3GfNZGF75mYo/CEWUH9KXIYDwUktJJuLcZmKN
	Q6RQg4jj7MpomLyQu2x3jMsMDg1R57M1tAwNCIr0NmXbJBgNXizE2VHM8OX1MA8S
	iNIy55d5cOfAxepvMP4na4qdjbxuxC7QAnf9rgKD6c3XEDhHz4JTekJATPUvW5fy
	xQ==
Received: (qmail 1186925 invoked from network); 16 Nov 2026 09:00:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:00:06 +0100
X-UD-Smtp-Session: l3s3148p1@Ojp+KmBg2L8ujnv5
Date: Mon, 16 Nov 2026 09:00:05 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org,
	Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
Subject: Re: [PATCH v5 1/2] i2c-tools: Allow passing device file paths
Message-ID: <avq4AIoI-3T8P6tJ@shikoro>
References: <20260722-accept-device-path-v5-0-9c0bf9b4da26@brighamcampbell.com>
 <20260722-accept-device-path-v5-1-9c0bf9b4da26@brighamcampbell.com>
 <avB0jS2RfBHgZ6Zi@shikoro>
 <DMWGDZA99U2V.ZHHILKEL821X@brighamcampbell.com>
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
	protocol="application/pgp-signature"; boundary="z4yAA/B3q4qc3ldf"
Content-Disposition: inline
In-Reply-To: <DMWGDZA99U2V.ZHHILKEL821X@brighamcampbell.com>

--z4yAA/B3q4qc3ldf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Brigham,

> Finally getting back to you after a good friend's wedding.

Nice! Hope you had a great time.

> Printing an error instead of trying to parse the argument as a name or
> path is an undercommitment on the part of the user interface. It makes
> breaking changes to that 0xFFFFF boundary easier. When we increase the
> boundary size, we don't need to worry about users passing
> (PREVIOUS_BOUNDARY + 1) and expecting it to be interpreted as a bus name
> or device file path.
>=20
> Even if we know the boundary will never change, I think it would be
> better if users can always expect unsigned long values to be interpreted
> as bus numbers directly, even if too-big values always result in an
> error.

Good argument, I am convinced. I will apply v5 as is now.

Thank you for all the work on this!

All the best,

   Wolfram


--z4yAA/B3q4qc3ldf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmr6uAEACgkQFA3kzBSg
KbaLdRAApK+xHjuLMrpettnSiIiPHQZcVfAqenGGM6dOxtXAciyx9A5LKAj9rJvz
qVeV+d4ior04qsZhSZ30Q7zcGwiPf/OAfdadImuWROE0yu4jRTN0ZCdYkBeJXf+s
dQXnS6fVGxdF8h1enlfoj1IyFHQ1GMwZOoxh4YqQQNRa4+tc7X5cbikiB0ZLvIUd
b34GhOk7g/R6jEDZT38judsHKBj4WxI2y1LQf9/VkIF2309DW9p9qCB7jbH2c8KS
XAqqxQh0zLuBXtCv0D4xhgEg37d2/t2sNe00kzj/hrHxaLE6+MPPmFIukQcYEw0u
PebDIDX4M7Zz6hLJdL+kXiPOabZAg+NsPtS2yVBY1eDJJYVwQaSW/E643ECdxLeQ
A8RE3JMy+j75hkG3RBOjVNW5/95s36k9fL5fv1Ina4DMhVNkZgSMVlB/+tm+sL2u
gpf37lny4DgQ9IUL8svl+Ui5ma7ErQCgrwOSdmj+c8fKvVa59TtjdIlx2BZljHSj
71yoWlFOmQaNZfKkP/lvyKnLLG3P9svYin8eHHaWZ6QA5XE5zA37C0iPEirPcqxV
jKu3l+77HNBnEd/+ipx83l8L/O64W8/PHL4y5cc8PivszKznhdaAAHjHheePH4EG
8ttj77wj0sYxdmg+Sy/YIsQSC924p0VMGdF5di5D4XXHnPhWkkQ=
=yYWX
-----END PGP SIGNATURE-----

--z4yAA/B3q4qc3ldf--
