Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0E357739
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084693; cv=none; b=jqgKwRH959pY0O+MR0Ki2sEXwuTZ1TaP3m8/CRRhIVuAwd+9HKHiYH2jtKo87QUOIqALMPeoFtgGaELuWzHyzfeLm09e/Lad8e9Wy1CRXdxGpqHCNQohSzUEBDf+985OXNIJ8/BdJF3ucL9Pdl7IvRQXKDttqx1bRGoAI7HOn9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084693; c=relaxed/simple;
	bh=3nufpehgZAqLneOpjlVJdhJwS3XjJIcDDnmgAXBlG2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAXXuS5ZbbPQfDWTC1ji2uNDGptWJngCYO5nyiEea4LWq2PxCocTc/mERYFOn24RHtt5wbF8v6H+Z+drxB3UK19OGI1EnCFLJ4xGxSFxly4yGbduZtdkK6To62obib4w1+pZilMN8l7pUJIIpNeWwD4tyYGgz4ipX/AjvOs0esE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=IOBVgIRi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="IOBVgIRi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=LK/v
	NoZ5TCRaZ6dbks9ug9JwgBDvtxE0RbXnMruAoCo=; b=IOBVgIRiNWK0g20yFzax
	QyKv2AmI5gdUWztEvBNYd8w9JMpCD8RcqWVrtNCnylAH/IZ4CCjVDjpEXFz75n6D
	82/ZTEp4QgreepIaRCGURhGmi4aqAx1ZP8b7VBE/BT10llqbmMTP3NYfwzZvEyhZ
	LItYfOn4nHO8SvugX1DeVdEAHlCgJUL1907b91QziKUyx8obQr2BXf4s+X6TDm7m
	pAOaAg1k/llAOo3ot5JtBoEGrTiRxGt+uJPQkpiqEXu+nQ9Ipid+2nRCULlo7JNu
	G7+nzV9N/DpagPq2Zq4eQZiQgRGkSKsB5GDJ+BngnPcWdTxYQFq97ifXRN5QzvKz
	dg==
Received: (qmail 1526275 invoked from network); 29 May 2026 21:58:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 May 2026 21:58:05 +0200
X-UD-Smtp-Session: l3s3148p1@lPlRQ/pSczVdnheM
Date: Fri, 29 May 2026 21:58:04 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Gero =?utf-8?Q?Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>,
	Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2] i2c-tools: Allow passing device file paths
Message-ID: <ahnvzEQyKqWfXyrS@shikoro>
References: <20260312081808.347978-1-me@brighamcampbell.com>
 <DI4RFLES1MXN.31HXMQMGXAXF7@sevenlab.de>
 <DIT8HHYY12ME.3IGXT8OU1CGZ8@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g/zoNCC71Yooft8q"
Content-Disposition: inline
In-Reply-To: <DIT8HHYY12ME.3IGXT8OU1CGZ8@brighamcampbell.com>


--g/zoNCC71Yooft8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Brigham, Gero,

> I had worried that doing the device path lookup and opening in one go
> would be overly invasive. Of course, if I can make that work, then it
> would address the concerns that I brought up in my previous email. It
> may be worth the extra effort to avoid the ugly variant struct I
> introduced in this v2.
>=20
> I'll take a look at libgpio. Thanks.

I think I agree with Gero here and that it is worth getting rid of the
variant struct.

> This makes sense. In the strange (but totally plausible) case of
> conflicts between bus number, bus name, and bus file/symlink path, the
> order of precedence should be as follows to maintain backwards
> compatibility:
>=20
> bus number -> bus name -> bus device path
>=20
> I'll fix this in the next revision.

Sounds good!

Looking forward to v3, happy hacking!

   Wolfram


--g/zoNCC71Yooft8q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoZ78gACgkQFA3kzBSg
KbaTgA/9EGnLFh1VgvCLaSV4lKg/QTocXRLS8QF9mZ4g+KvJQaoSkG0I3JbGfrQi
C6AzSzPN7YG08c5z58LG8CB4auvJaWohYuDcfpuzTa2blZw8naLMUJ8n6EMCegs8
RdMKW++KoBbpFcp0g0lC5f36B/GFuwSVnHpP1OPxdTkZrdzUt2cLDZNMQbBo4SVh
XpBtKgr0WH2GgluSz8M+Aj0tMph88U2mBF5YN4pVHdnx/w63YHpgorZYkh4pq/dN
UX3A5N6+irYExKPvfM98d2/dAZsrX0BmEyS7uogkksLm1wLlWHQqukk1LGAtTX4y
pEx0CUCKIYWjQSgfD6q6ku23PqbLTcQMf6Adui06icSUui0s6rIpzYn3TupLEw5y
2+jhSzHeLoksEuNiekJlD/ERWXFtqV+4bWzD/XCOL9yd5BQ86Vpu/XmA3JXwfR7x
xQNHFz/Mz1Zji702NtSZ0AdUZBGFbOft3YkwJ0yrn3JJsEoFG5ZTBa+Y4Mv+nco7
Bo2myjIklNDWsjtfxCFSwBvLQdzPGXn2g0/ti4Sc7kvjaAzTPNhsnC4ScuOzPGvS
3HiQWiYPjj7+JtPXZRj0SaNMjjYwhx4SFGT82P+Uer+LMFkVDTSoMqzQZlS7ilRa
2v8gDwc3ATADJL6Eden323Cddweu5QVZb1IvCtaTJVcnz10236E=
=V4+0
-----END PGP SIGNATURE-----

--g/zoNCC71Yooft8q--
