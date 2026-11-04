Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819716;
	b=DISohpmvGsV9lVyILB4Fe5bGRBdzoVGiHB8yUoCZ9egCSseClekcrD2U372QLcaoZQnO
	 B0egbwGRf+KzYszi+dwqHm76JLroLpXD8YEjVBW4yKoeLlWAbVqu5PMg2BHicdm6bFSTj
	 HCoRPOwBmPAW7Kh/fwosi1wdQ6s1ocw3dcMKFJk0Fi21VKmjN59lBRLfCEqeQ390bYdp6
	 gpI+RQrHeLrWzCCdM6sbWydhzxoZ32fbh3dvEZuw5Vw8cGTwbhf8750LR/Eiprwmnp1+V
	 hIDwGmpSD1ZpEJQbeSe4a5F+1AZPOVenO1d7nC4xGnsM1S28tQpt8XMHfGwch3vO+Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819716;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=n7BS530HV1lVozfJXYDPjT1FuSJaYmtiEdjDoPBh4cQ=;
	b=Nv6Q5XfCqqNH6bzsu6lakayxnw2aEjntg6GfkB6Pkz9MMrifUeNm0eMxuGesU7QGDKp5
	 2Mx+fToeXcdoUAu2tiLKIuhyfcFZim9VLPygUeZmaOuxCgOxTfqZauXodI8Gr6526clRN
	 e6p7PwF5511BwsiIpHZf0azwWBKEpWJv9b1BnrlcM9qg0PB5c/FOpAmKSe09i1rHvw5q6
	 mrq5ms+MjfPUopQgNneGig0TSyAFl+opSaJxZ1VdVK98jeIA7BaRG9pffE3ErCOU1D/Rs
	 kGzniUxPSFoVYM56oFoasWChrnrB4JgOnSnIhfQg4SI2F4TlVKT+5X5MZP7dTebVt6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=UgiGrhuQ;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217A606A32F
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 19:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C217A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=UgiGrhuQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=n7BS
	530HV1lVozfJXYDPjT1FuSJaYmtiEdjDoPBh4cQ=; b=UgiGrhuQy/mGgu5Jhrxw
	U4iW26+36DDe3grM+u14/NvLDCpHeZ0xiuEvuDfDUqellkU1LwhONVcAqHtWqrir
	+SR14FFVUQSG5N8j9hT4Cqak0uszM2oARxHzVMCg+ItnXftQckX/LD8VCM+MbgJc
	OtVMgXRPjBzQAIuW9E6952rvSrTqZbNRihe/dNbxKmeIUosago8yE7dRio1e5h1I
	7r89PejZOdMx37FuhZ3BUIHM1jqAtG2m+yjmE90HpRiC97xM4UAvVvWl+2AQIqkd
	Vyu6ZJYFPFaN7JKPddkG2Jo+0Hsgr4JxwNT/o2TWXoegl8VH2SscRRg4OhSg9R/h
	jw==
Received: (qmail 833035 invoked from network); 4 Nov 2026 20:15:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2026 20:15:09 +0100
X-UD-Smtp-Session: l3s3148p1@LaeQMnhfGLvAwtcC
Date: Wed, 4 Nov 2026 21:15:08 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com, Chris Brandt <chris.brandt@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: i2c: renesas,riic: Drop clock-frequency
 from required
Message-ID: <auuEOFZ8Vo1OUTw6@shikoro>
References: <20260806111018.782380-1-tommaso.merciai.xr@bp.renesas.com>
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
	protocol="application/pgp-signature"; boundary="glWaHYKG2SMFiRw0"
Content-Disposition: inline
In-Reply-To: <20260806111018.782380-1-tommaso.merciai.xr@bp.renesas.com>

--glWaHYKG2SMFiRw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2026 at 01:10:13PM +0200, Tommaso Merciai wrote:
> clock-frequency is described as optional, with 100 kHz assumed when
> absent, yet it is also listed as required.
>=20
> The description is correct: i2c-riic calls i2c_parse_fw_timings() with
> use_defaults set, so the core falls back to I2C_MAX_STANDARD_MODE_FREQ
> when the property is absent.
>=20
> The stale requirement only produces dtbs_check noise on boards relying
> on the default:
>=20
>   i2c@14400800 (renesas,riic-r9a09g047): 'clock-frequency' is a
>   required property
>=20
> Drop it.
>=20
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Putting it into my for-andi branch.


--glWaHYKG2SMFiRw0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrrhDgACgkQFA3kzBSg
Kbag2w/+Ppbl0Sufx7faX4uyhGSaA898V2UbRRgfxY7pqzPN4eaighcl3Y4DMLH9
KQauzZK95aseWVDMJn2Q6OhVSxSV+aPLMnGKICp9LORM2rrfO8j7TbV0SrTUrl4R
0YUEJ1tB0wlBZqOjx5PQkbfAhZTSQLzjtwX+m0pZ4vf00O2q1q60dxJGCay3tmbJ
F6DqENIdCVXeZBNTy3g2+ZWtZvZWoPM3Sq5HBboMogQAYlfmSjinIlwgxxtNAbXj
1nwZyrmBtMZmdb6TUeEGB1wRxUaFhUrxx5KOqEox3Zvrvt7bzK6X5dAik8y+EzX3
Q34yblqCZ6g9+h1Em98vgc2i4M2NgEQKKhCCqCuKBkFGvR3C+TG8GXMsLtuYT/4g
MTGPvQaX+N/uMGCw+fF2BQY20DXsYj7Cc6vDeAycAxM3pnH4CeUAhc6OmImM1clc
rTPueTxD7uWJ6brrziz4wXHQEX7pYcGoDTbqtr4ORbJW8PNeroznAGtYVv+swR0b
Ki7W+6l5+oyaoBHkAWDWctyilzhlo5kC9tayAFkjiZR9tBG3R21gBRnbvWVhl8Fg
q1PHlIRIiqCeSyK3+iRAxrKizOz8hjafmf/nnI5oyvom6omsrFSm87q8s3trDi6J
9F0+uO9FXfemivdmB1gu4yPfrzw1WK31Wdm4l+0SfMwtY+p2uC0=
=UmDj
-----END PGP SIGNATURE-----

--glWaHYKG2SMFiRw0--
