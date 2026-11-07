Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078753;
	b=YpiwNI7vax9l3MR7EAGno9PfKxZRINod1Kr88KHDPNMAwnb0jnv0BcAzqi/H8nYhC1T0
	 xUnQXxv9D/txcyXa7n8ENFc0xFZeyZ13Bbmmr48qyOPpaO28mH0slRKbFGGFcUgAWIrJl
	 0y2FZLtPVnWuZ4/w+1bC7m+P2/JQMeQQzhCvXkrdvf0CdeCTB1UC5guC+NxE+sVzLpfCZ
	 Zxvyo1S5wWa2uMsT4b59VF6XW3qM7kOb3nsqtEHhShlKYRu84vI2xHtWZS583yO8E+lux
	 SelZUqTLQSzjuZMzDYQavR9ErhRm92hiVg8oth14zYEFgYO5ZhnfLUG3jKfqd0Kb0Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078753;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=epjkfjykBqSJWWauLayZ+xNrdWN9n/QQ/qi/Q2CXCVY=;
	b=ltmMwRuqrPiXwZOW7DfLU7wo0I3QW2Cf9DXWkiV+Ck6Q6FMZIu1FpL8O/mGKfUkLxG4S
	 gApxgwu0ytnv2z0Herm2STzwkHzvGRrjWtUx1FJY+Dq0nV/FeJwzErYioI4kCHd9B0E7k
	 bCryU/5tR4pB2kuF520OI4kDzBjhoJohtYimJP36j4JnWm0Bu6WJ+9I/1G7YHcNEbNhgE
	 H/CL53Ujg+7hd3wnDC6HykajwB9Ird3RvmBPz3NAAISWPhjN7gz0fu9jFdfLxXNYZz2SF
	 N2VwNYnTz9af+TvJKLcK6IgLzUZxDiJSaGuHHavqKqp5RolKA5TgWr5W+5ZqeP2P0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Xk9vQt2J;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83586606A32C
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 19:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83586606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Xk9vQt2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=epjk
	fjykBqSJWWauLayZ+xNrdWN9n/QQ/qi/Q2CXCVY=; b=Xk9vQt2JqutShzgO0Cgl
	Xy2omBKpJYFfSXxGPpOE9+4E8fKfjqTPsrA6F8pwk48ci5XYlz7E4Qw8oTFxagI4
	Ht6DshN3U6RCymBfgQ/q1zbsPVVh4zMMjaRjcm0hiQAO5UQDkNMykov0kyqER5LB
	h4gaOyVIPDiUJccRigcHZoYaZKnJtpL5I+++aDaH+ZMmAOtkIRWa+1LaxyW2DNiZ
	c86wHcRDasfqVMaV3rStmDUH4LiLosSQ7Gwq7CSVL8Or18mAkzgshP0oR+uhoVGY
	vggBf2XpcTM24w6ToTXbZ5qpRdrMGyhAP8xEbrYR8WPvBOULDUH+xhHKD2jlJlQf
	yg==
Received: (qmail 2591686 invoked from network); 7 Nov 2026 20:12:28 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Nov 2026 20:12:28 +0100
X-UD-Smtp-Session: l3s3148p1@3dFtgrRf8IoFFu4l
Date: Sat, 7 Nov 2026 21:12:26 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: amdisp: balance genpd on probe failure
Message-ID: <au94GvWWkYGwoNQQ@shikoro>
References: <20260708090552.739789-1-lgs201920130244@gmail.com>
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
	protocol="application/pgp-signature"; boundary="4WAgGPXbT/Y0ijjU"
Content-Disposition: inline
In-Reply-To: <20260708090552.739789-1-lgs201920130244@gmail.com>

--4WAgGPXbT/Y0ijjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 05:05:52PM +0800, Guangshuo Li wrote:
> The change referenced by the Fixes tag avoids a runtime PM resume during
> probe by powering the ISP domain directly with dev_pm_genpd_resume()
> before calling i2c_dw_probe(). Runtime PM is enabled only after
> i2c_dw_probe() has succeeded.
>=20
> However, the i2c_dw_probe() failure path still uses the old runtime PM
> cleanup path. At that point pm_runtime_enable() has not been called yet,
> so pm_runtime_disable() is not paired with any enable. The failure path
> also skips the dev_pm_genpd_suspend() needed to balance the direct
> dev_pm_genpd_resume() call.
>=20
> Suspend the genpd on the i2c_dw_probe() failure path instead of disabling
> runtime PM. This keeps the direct genpd resume/suspend pairing symmetric
> on both success and failure paths.
>=20
> Fixes: e2f1ada8e089 ("i2c: designware: amdisp: Fix resume-probe race cond=
ition issue")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> Acked-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Acked-by: Bin Du <bin.du@amd.com>
> Tested-by: Bin Du <bin.du@amd.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I'll put it in my for-andi branch, but actually this is a fix for this
cycle.


--4WAgGPXbT/Y0ijjU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrveBoACgkQFA3kzBSg
KbYdPxAAjFL6UhN3auOvq4H2n1B3Etfrq/KaLd8yaQtv5cVo+osovbVdcsmXvakF
hLLxaF/VIXlDwJ0xmSODXnX7cBLWUbaJejJpbElXInKlyfcEvnqgHRqnXN4JoGEA
gcrG8Z7aDZv474L9h928upjGZ5ji6Ja3JdGwBjGg6EXhYtPWrmf/e6LUp7rrXmRr
J2fkSJKQ/KlN3UGY55QF/28QDzEUVCnaBeO3JK8Xb+g6NmNcE18XtZbWBte7hDKL
Dt2YeEsC7I0fTxAwgG9fEd+fH4GmRrVaYAlVWwvHHPDHOyh2sjuSOvZ9+wpVXDOf
oSlPgfs5M5b9NNvo4z/gqcSCY6ndPDUtLbyGkgqvlPzo4kzWwLz1kCDo5z0NyfBU
oArmK055Nzjix9rx01SK0/mj2DvroSAiUh9YZQWUziMENGYbljfk3OcOwOGzLYYE
SUjNhmepqr4Q8Zjs7j73haaLMEIg+ANg2gq5dyWRbwwlNpjDHFVOOqskiLcBn2vH
6kURxeHwmEv61LrN3YP+pH3GAAeSSkOgCixoURVGaGvTcNdtgG5acRvh85ac7rPX
3E6IcQQ36tFbk1d8TEwwHrvpH3ajYKeyIoH3V59+XGX8tbvWRor+4AdebB+MN/O0
3n6fzI9/pe0a8safgHsBn3sGz3ueNOJyIKf9Cn86eZ141mT6wdA=
=KFNT
-----END PGP SIGNATURE-----

--4WAgGPXbT/Y0ijjU--
