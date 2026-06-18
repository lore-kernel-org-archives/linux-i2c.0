Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692330EF6C
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815939; cv=none; b=BpHDoPvF45+tlbNhcdqWlgBdsBGdKxYmXE1q2gF2+GY6z1EvqPYGM8jS4K+01ssQnLuAGRPGob/fEMEwFI/eTLN6fcAZDyEaTLUE4GVAZI2XajG2d2/CzvBksW+KfneS4qI7eLlOzTTkOviAbdeUOkbJZUTPJpqKIJ0siI4K5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815939; c=relaxed/simple;
	bh=82svEFDyUn6/zcDgO/BqQKFHS6AKIvFod0+MPV1B4VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH36tEDI+8qIZUgy42A1SvHC71WNPfOQPY5LdfkpFvwg4/hWEo+/EAMRuPfC8em8ttlAxCTt3oUe8/F+YlxvR1gfmDLdSUc4UHPc0qXx1FVydH41tXMEeTVFZN6arObqA/WTyGct4vcGE6TOeeasezfmAtWeKjsXGWhdv8I5Qo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VaqZ6/PG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VaqZ6/PG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=WsPx
	MeqlJSLPKBalW95UlyMLrcaZPK8zf9sXgyIgLZY=; b=VaqZ6/PGKOrl08JhAaFd
	lEPBcM8SrEY/HRulOrMMx6Rh3PtEDyGE79OL4zbFzHPRrTu5QFTeyaDuGrkBN1LM
	iZsaAUZsRQkjqLRTJealQSTeBnZaR/MAA1i57uzIWtzyoGlgbj+L/SKdi2xwePth
	Otc1NgT2nrVaoouRdTnHTIwccSx+tZHeyFyQ0XodHLT8pnAp9zSqgnN6mtzbGXBD
	o42eLZD/aaBUpFon+hwctiJE1dec6rT4xTaG85e7SxkmNzsVC5YNnk1lzQVinhZD
	923k+iK4kOCOyjpXF2QTbi3LRa3JR25y26oRPO9B48xku1Fxut2uaT9QGKudvuzn
	xg==
Received: (qmail 701548 invoked from network); 18 Jun 2026 22:52:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Jun 2026 22:52:11 +0200
X-UD-Smtp-Session: l3s3148p1@SvSbWY1Ulrsujnsq
Date: Thu, 18 Jun 2026 22:52:10 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Tejas Mutalikdesai <tejasmutalikdesai@gmail.com>
Cc: andi.shyti@kernel.org, wsa@kernel.org, vladimir_zapolskiy@mentor.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
Subject: Re: [PATCH] i2c: core: move idr_remove() in i2c_del_adapter() before
 device_unregister()
Message-ID: <ajRaej6d2npPBeca@shikoro>
References: <20260618184610.6536-1-tejasmutalikdesai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UOxfY1EouxY4rP5s"
Content-Disposition: inline
In-Reply-To: <20260618184610.6536-1-tejasmutalikdesai@gmail.com>


--UOxfY1EouxY4rP5s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:16:10AM +0530, Tejas Mutalikdesai wrote:
> There is a race between i2c_del_adapter() and i2c_get_adapter() that
> can trigger a "refcount_t: addition on 0; use-after-free" warning.
>=20
> The sequence is:
>=20
>   1. i2c_del_adapter() calls device_unregister(), which drops the
>      device refcount to zero (the adapter's release callback fires
>      and signals dev_released).
>=20
>   2. The adapter is still in i2c_adapter_idr because idr_remove()
>      hasn't been called yet.
>=20
>   3. A concurrent i2c_get_adapter() calls idr_find() under core_lock
>      and finds the adapter.  try_module_get() succeeds because the
>      owning module is still MODULE_STATE_LIVE (this is a hot-remove
>      path, not a module unload).
>=20
>   4. get_device() is called on a kobject whose refcount is already
>      zero, triggering refcount_warn_saturate() with REFCOUNT_ADD_UAF.
>=20
> Fixing this by moving the idr_remove() call to before device_unregister().
> Once the adapter is removed from the IDR, any concurrent
> i2c_get_adapter() will get NULL from idr_find() and return -ENODEV.
> Callers that already hold a device reference are unaffected:
> wait_for_completion() correctly waits for them to release it via
> i2c_put_adapter().
>=20
> REPRODUCTION AND VALIDATION: Tested by inserting a msleep(500) after wait=
_for_completion() to widen
> the race window, and using a kernel module that spawns two kthreads: one
> calling i2c_del_adapter() and another calling i2c_get_adapter()
> concurrently while the module remains MODULE_STATE_LIVE.  Without the
> fix, the WARNING fires reliably.  With the fix, i2c_get_adapter()
> returns NULL and no WARNING is observed.
>=20
> Reported-by: syzbot+c0291c8c9aaa473c7721@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc0291c8c9aaa473c7721
> Fixes: 611e12ea0f12 ("i2c: core: manage i2c bus device refcount in i2c_[g=
et|put]_adapter")
> Signed-off-by: Tejas Mutalikdesai <tejasmutalikdesai@gmail.com>

I'd think this is fixed with b1a58ed9eab1 ("i2c: core: fix adapter
deregistration race") which went upstream this merge window.


--UOxfY1EouxY4rP5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo0WnYACgkQFA3kzBSg
KbZcvA/9GS8mFTLLrYOkBxNfMXrETYuVFBBtDIo5vbLUtTe9XpTV8xYfGYJq7KUf
aILYN5LBjyP9oJSs+shHp40qNHwaVpj9UbO/OvT9ZoNU0WVyq8XThQtSziRd92hb
/sRpLCjY3pOKfNDnzuWKZ7BObplbzBNFeHrq9eu9ZyyPkxwI7FGJ46ImMFJ/MUqN
48I/XSxr5BNAGFKDGFUMbwns97xsF+ADrahI8QsplCvNHGmZuTaRNX8mOw4JYFeQ
grM82woVxlT5/or/B/Tnt16XNH+3MnRxoYvT+d1yZsOZxROWIr61SgEQOxuxLXKm
qIOvhGW2GcsKv/zjFFh9iUuG6AgR5odky5E+tMec4Moxa2xT0P4a70d/iW213VcS
n5E/9Wq4HanUgzM0Y3STl7+QORjw9neVT5LPgM3NK1qLdI/FmKrwpCEbbilpkGZj
nh+y+FfPLlIqLLjCYZjhLue8h1rPRPql80qp2k9orUA96LdLcWEFYKDdtSLs+vQv
P8ul2aj/865jyHc93AMXmvHFfxvomio3yslN6JJ/sueDl831IpypD4dUidxMt1So
mYfLfv0dRh/7e9qXv4GLloSV3D1BwAiK5ytvcEzvAKEjA3v6xuHedOz3lDOWqinq
npcd/IGbFX5rLtKazAeYf9mmOvQ71EDLfPlFqJeRc1ihlqiO9zY=
=llwT
-----END PGP SIGNATURE-----

--UOxfY1EouxY4rP5s--
