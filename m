Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ACF244685
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150170; cv=none; b=AI+OHa2cv+qCvxAJiErJVGropUEKzVZqzT55HVZXswkypq93xU2L9jzWJOADLROq1Bftj65jlynso/PV2yHh/m0e6a0UO8bq95iysmhIEAEaiOFM/oH1zglSryvEs41jEdJPraIx8uCH1iDO8sxJRB9G4PovpJAAGXV/EeVfmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150170; c=relaxed/simple;
	bh=MjB4PmG9F1nMbW5nGldNc0Mw5C3dA0nRUxuoPh5AO7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4jzLMOSl2IjHpKlo5z+jGktk2sg00qyMP86e3EpfqlFKjDeAqLlZkCymbrdkeCqa+Yo6jnaA9vraw4YzEuIkF6vVPYSFZu8aQj6q5LkF819yVa7lvJCRCJHZpNkNwDLbKK8EpN0LSRLHb9lPMl0v2h+FYoyqaVORPCNQd7lQFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WJIXh54Q; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WJIXh54Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=MjB4
	PmG9F1nMbW5nGldNc0Mw5C3dA0nRUxuoPh5AO7w=; b=WJIXh54QIvpyhN+0Ulho
	5CycptCmQ0ptKEPxci5yVnlm8oFiuh0ZO/wQxP116LRMZY173FNwTLwEZHyuOuFh
	UFdaH0B36AnkOv2zsEn6I2YegAFLCf2j1VZvpx8SYuN+M5TOozY6/YpgCeJEVhvX
	gMAjjuvSwJ92Hyrod3Qz4m8BnIobL3uA+4ygJsuR4zQVqS28CTGh2QO/mSZLvc/7
	cgl6Lckw03GiTezQCF2qRUyJAGiQNIF+3Bjy03PgJlxxdneiMAZ3HTDidH6JQOHW
	QZRGPZrS6W7KCyK8AmvT7BarVdiCyTxIJjzO0zsZluI1ugWvVY4+4AMQop+e6xrt
	jw==
Received: (qmail 1764476 invoked from network); 30 May 2026 16:09:26 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 May 2026 16:09:26 +0200
X-UD-Smtp-Session: l3s3148p1@gMhLgglTVOcqAQ4KEBW5QLbOwWyJKVt/
Date: Sat, 30 May 2026 16:09:25 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Suresh Vankadara <svankada@qti.qualcomm.com>,
	Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Subject: Re: [PATCH 2/6] dt-bindings: i2c: qcom-cci: Document Glymur
 compatible
Message-ID: <ahrvlYI-WfHwUPMC@shikoro>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-2-bee535396d22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sbuNnDmWOaUg48ge"
Content-Disposition: inline
In-Reply-To: <20260529-glymur_camss-v1-2-bee535396d22@oss.qualcomm.com>


--sbuNnDmWOaUg48ge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 08:07:22PM +0530, Vikram Sharma wrote:
> From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
>=20
> Add Glymur compatible consistent with CAMSS CCI interfaces.
>=20
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--sbuNnDmWOaUg48ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmoa75UACgkQFA3kzBSg
KbZxqg/9Ef9VbcVm4iGwE6vGGwaE3/psSXTuu3nGvOb2pWx4/ZFeXoRYNRNPNo1P
VU4yXYh+voyaamDQ0ZzaWxZbvHC4SIgz72zNXoYyqBth0e2YyKjjrqnHo+OVtQn4
mu1kkJscvj3JSz7guMyWuznUVrSnK8BzfpaW93VRLKIsebSD9QfbFp4r3XHgio63
T5wjQTvAjfQgF6ur7yHLD5JTiT+Rpd9JEZvP6bLB/lTdMNhn7y1NE3Fr6uVb4g8B
Wj0thoYp1nfyxid86bSADfDL58Os9kokBxLbTcSTDNeD1Y3ZFFZT57sPqKdarO3f
74doMFofvvTph9s+qVAZn+oWti3HQRmok19YVx/oKmb43Ps9TqbrmCgj4ieAFnco
6djiK/0rJT/Y9lJYFzgkxq/0sxhUEZagtyZa/in3/IpcPmZTNkTbXX7VmNDjahBY
WEIayLPUjTvDIqovjHCo+3uFefzuvkdHWELaqpeBthIDeswkBjm9ZMh95gQXfUb4
xlJfonlZh5CbNb9c17H7zh/XXHXCq2KBsueY3LKf+IakkDqalGEAUzcMcXxs/SHX
4aOJbdPVDLqOqJjaIK4drq2q9FcdNcStLVHz86JMxq5+zWyonqPptpAqKt1qNOUU
ExvvQVkKbCDBI+eoe0ZBOGdufYpcF/MfsMiXAfP7k9R/0CYdFuI=
=S3Db
-----END PGP SIGNATURE-----

--sbuNnDmWOaUg48ge--
