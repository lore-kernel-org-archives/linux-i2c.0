Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8F3F44DC
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785472; cv=none; b=G9h691Q29n7YsJMH7hdmS3fJt40HwxFvdo1GcpMx239gr45Mf2kLhiTVVud9tqgiC8fkRSxpC9zcrz8q9OiC+l4GQADKGyV0ZTGl8FYuVOSWwW5aTSGS4gUgTdbKXx05OYu744lwn8V3fdKYVAaH5LzFJxXDQJ7GjM9EUTYKNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785472; c=relaxed/simple;
	bh=i3it/QJBC6ckD2rmxh+eJnocRSEVreIqnZQSdK6diF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH+O70wCTuK8ONP+Rf4d9liMaNCWCXacZ4Vzld2UNMq6PXSuX7j63+/OUlDdJcRJ/ZhW/wDZGPRxjOdnGLC0GoIo3iR3LGWXhkII4+HNLXrCllk/MqxLDs3gTio2q172yukxGq1n5D4SThqlwGd2B9WRyp1ClJYz5Jndd/sEz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FUKNi9zA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FUKNi9zA"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so731888f8f.0
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 05:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781785469; x=1782390269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3it/QJBC6ckD2rmxh+eJnocRSEVreIqnZQSdK6diF4=;
        b=FUKNi9zAs1nTh9J+5HMq7Jenzvo9jLXvtJQpAlxChEZ4c2vvMRcV1LiQtJ+j7gelKx
         CXEvNLElJIFJBCH6n6rvKyC2yG5lEBm4eYWIBqIpXU2LItKaewN+umSiW/rjuSI+yvik
         WUdRCeFn1xOMm0u2doJN1Bf/i/z56IY2qC30SXq1vhSufDpWaXiChO//BagvwtKBUBZf
         iG1SDP+Ppu1RcSvRHqjLCSMMIAfDP4V92Zk85ia3SOV2ygQ92TLmMFHgBsl0aHl6u33A
         CZrtWgEjm5hf/dFu38MSLtl/nJEWGlqOhJIduHNOTkP8p8ukVipCHQj8mupGMgwMjrCa
         NkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781785469; x=1782390269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3it/QJBC6ckD2rmxh+eJnocRSEVreIqnZQSdK6diF4=;
        b=PxS50h9zaLV86WWi/76vrqpjigux0XNnnipJB2DVdz72Tj440NDtDuxzm2exZHn6bb
         L3FauJrxzYI+f0dQscu6m/NtsYztHIY33oE/LDncnhcyufDBblBjgp80UYdc8YxNo/Sm
         VHW11lzsMYjS4sqaNOQVJ0NOy8uQbm4+yU8Vj6Pdw8LonmWfNCEOM2J7OouzY1GIza4x
         CNmYeudgXPLK0ramVsUVI6gYxjdedl2iua9dM+Stj1J2TUytwy9DohUOm+Z1f8sft3KB
         O4Wf59moHOemd2ZceB60nzexiEXgL3tUI+Y2awvs49zM7u0dGvvrVPDKjOQe2bI0ebkp
         Pu4w==
X-Gm-Message-State: AOJu0YxCj8Z1wFpI1Ea8PFd5EbaHiGWgB+6TFJrrsZ/jvooae671L5yD
	7XuwqSeLgiddzTups9fyVYkedpUVhoHLDdxuQd62K52FHMVIma0KWzpSXSKMFYoCACo=
X-Gm-Gg: AfdE7cleKpqIR2IyFSlnUWvByYyX95TSEgQi5fAXDL9P53aTTOB6kbyBG55Ej1y8yXb
	S9Ao+XBs6cT+rV8VdPYz4SuSRjFbhxhfXlkalbmzNYiI7Ag/8AR1q6NhzEIBskjHhE/jGFc61cp
	oEtgResLr4AocNWuYGwo5LXxe0aWELoC0Kd6JFr/T9Cdunj6mmcNjC+WJ13vcqEUFLfqTosQU2q
	J0v4PsLIihufRELo73oaUw/j3f+hnOdoXz8UhjgPs95uenvauMy7ut4bvu4DAx777UWHrfeNwH2
	1I6VKhffJPsInvWORHwGzd5WbIVCY/HTYRqM3KViIlz7AhpjYW5mxOLn7DapOwr6DJbJG665yR1
	RkzqJX2Uyj10zeHn4L6samzKl/gnCQJyjDsD7sxT/pbGYGxBTw0YQPYwbMV1/1KcVnyst+ciqcG
	eyePgum40PyNdH1N/MGQ==
X-Received: by 2002:a05:6000:4b01:b0:461:dfe2:c7ed with SMTP id ffacd0b85a97d-46240cf9358mr12936537f8f.27.1781785468838;
        Thu, 18 Jun 2026 05:24:28 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-462236047c8sm18637457f8f.10.2026.06.18.05.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:24:27 -0700 (PDT)
Date: Thu, 18 Jun 2026 14:24:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: pxa: Use named initializers for the
 platform_device_id array
Message-ID: <ajPjJbYrtZJ09rDW@monoceros>
References: <827657abb02edb39bc90f7336194f614d383770e.1781688767.git.u.kleine-koenig@baylibre.com>
 <ajPSo2zjDvq7CflO@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xydv7gm37j36422o"
Content-Disposition: inline
In-Reply-To: <ajPSo2zjDvq7CflO@zenone.zhora.eu>


--xydv7gm37j36422o
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] i2c: pxa: Use named initializers for the
 platform_device_id array
MIME-Version: 1.0

On Thu, Jun 18, 2026 at 01:14:04PM +0200, Andi Shyti wrote:
> Hi Uwe,
>=20
> On Wed, Jun 17, 2026 at 11:37:36AM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > Named initializers are better readable and more robust to changes of the
> > struct definition. This robustness is relevant for a planned change to
> > struct platform_device_id replacing .driver_data by an anonymous union.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@ba=
ylibre.com>
>=20
> I had decided not to take any patch anymore for this cycle, but
> because this is part of a bigger work you've done, I will squeeze
> it in.
>=20
> Merged to i2c/i2c-host.

Thanks. If you want to rethink that's fine. There are still so many
patches pending (to be applied and to be sent) that there is little
sense in rushing in that one. I'm happy if you take it now, but if you
reschedule it to the next merge window, that's fine for me, too.

Thanks
Uwe

--xydv7gm37j36422o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoz43cACgkQj4D7WH0S
/k59Dwf/Qly5NL/UwzmH9SGXQ9SNDwkQFK1OEwGEL/IQWwoKeioIZUOJhiC0Yuem
S6CeHWYyDacs8T3Xu/HAXobZYxf5mBCIaS6k+bJR/J3TWI0c0DN/bk06KsZz+uA9
RTJMR8E+tY8Z7mYRMPHlqCyftkWlPhAzGF/5WmlRpabOqdEJSicfxs0teQoNsFcB
kWiVdblbu8czhvMLchZJYUkN/D4VSZYQvg5vlxATlErlp9qMgPa2fQib6iFaYsRX
zLxXxbVUBuL5FiNU7c22RjnSRxPLCVskR4caUfbt4CovYKtybAnuhszYvv3eeazF
sP+SoK2n4S3ws8GUQaIk4hqzQpvBhg==
=JUQL
-----END PGP SIGNATURE-----

--xydv7gm37j36422o--
