Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0E317142
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882056; cv=none; b=dMI2+jD+x80ovqp19AwnRUYKI7tn9/l+Kcs59R3fkX70Wby0Tzw1HC4Au4x0KinuHFtvkWYhvZoKwxwTQN3IpJTsN3VHcNdUrEVZWVkhNaFvGR+Ik32zwEYaMaIv+xr5+EcJolEU7uaxsPWEHtPMKg+uZtjkNZ2wiiFcZQg9PCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882056; c=relaxed/simple;
	bh=6nX3v3Px87Ducl5a8oyQxwCLPTE9qc6pu0ldnKIqw1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK85uXSKFZb/ahcw/bM36xiEtlQMi72aNsQLBcHDi1pDkU5AHkVAsMy3e+JvQtjsT2K0Mikj6IfsOa1jzuqIQ7dTcmOF8h1iRv5Qms+6sB3mJ7NZPaGTLgIkFcAjPMMLRG+jX5OHzWfRwPpFSIYgrCJD64Yr7qGmcjhQLDKmyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OvOXCt+t; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OvOXCt+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=QaY8
	vthKHk+w1zbdFTwwMDU2Q2SgmE8fAYteZe7tLVQ=; b=OvOXCt+tyznVunzBNtsb
	t3AzQFDzvakHHQIvLv9Sv0Ncu4lu7IDGGxHGNvhx+qrWT98J3piVDjNBzNUts+sr
	LoK01DnK8Cemee03LkA69EI7RwhgeVCDgS/peQsfMeEIEdgNfDCCcIoABOG4acb6
	XErPehfAoMZJIbL4E+IUVVzVcIXuE5PB8TQI/Tla7SsNA/dpdRewYXRs+avq+2LU
	sHm9eeP5vvUKNXtjyjjhwQKuxkXiaOYRDnG1pMY5v8v07VIXhrpdrbKMZtomZbnE
	ZMOTOl+F0d3sSAB3iBxMhojxpYCzroP6TWLcx/Da3VCQBt7DBP+e2RmdD2O51l2R
	pA==
Received: (qmail 2095580 invoked from network); 4 May 2026 10:07:26 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 10:07:26 +0200
X-UD-Smtp-Session: l3s3148p1@//rXa/lQgL0ujnvR
Date: Mon, 4 May 2026 10:07:26 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] i2c: testunit: Replace system_long_wq with
 system_dfl_long_wq
Message-ID: <afhTvm8OmSpj633b@ninjato>
References: <20260430090810.109232-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ml+rf6EXNXYFNKMn"
Content-Disposition: inline
In-Reply-To: <20260430090810.109232-1-marco.crivellari@suse.com>


--Ml+rf6EXNXYFNKMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:08:10AM +0200, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected, but it is a per-cpu workqueue.
>=20
> This is important because queue_delayed_work() queue the work using:
>=20
>    queue_delayed_work_on(WORK_CPU_UNBOUND, ...);
>=20
> Note that WORK_CPU_UNBOUND =3D NR_CPUS.
>=20
> This would end up calling __queue_delayed_work() that does:
>=20
>     if (housekeeping_enabled(HK_TYPE_TIMER)) {
>     //      [....]
>     } else {
>             if (likely(cpu =3D=3D WORK_CPU_UNBOUND))
>                     add_timer_global(timer);
>             else
>                     add_timer_on(timer, cpu);
>     }
>=20
> So when cpu =3D=3D WORK_CPU_UNBOUND the timer is global and is
> not using a specific CPU. Later, when __queue_work() is called:
>=20
>     if (req_cpu =3D=3D WORK_CPU_UNBOUND) {
>             if (wq->flags & WQ_UNBOUND)
>                     cpu =3D wq_select_unbound_cpu(raw_smp_processor_id());
>             else
>                     cpu =3D raw_smp_processor_id();
>     }
>=20
> Because the wq is not unbound, it takes the CPU where the timer
> fired and enqueue the work on that CPU.
> The consequence of all of this is that the work can run anywhere,
> depending on where the timer fired.
>=20
> Recently, a new unbound workqueue specific for long running work has
> been added:
>=20
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound wor=
ks")
>=20
> So change system_long_wq with system_dfl_long_wq so that the work may
> benefit from scheduler task placement.
>=20
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied to for-current, thanks!

BTW, what does _dfl_ stand for?


--Ml+rf6EXNXYFNKMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4U74ACgkQFA3kzBSg
KbbPtw//fawRp0QiFR7gUmKeKMBNjQcqFj3W6c8ZjqhF4aC8iUyeH+mbxiLepeqg
3vPMVFoRawM2Bf2gevmmimHDP3cpHjhs5obGcPJA1+v9MQA2Jj6rxGlj4ATemNIt
xQHSg/ODI0+OC3oJO0bJHp6bAK5z2WtqvqxpyD0gABJ097YUPZi21soHq4ykDhJC
wduLwx0aH0G7mtzg0gFF0EZmn3S2bZ95y6LtfLkpiteteX4d8Qd9haz1PrUS7niJ
B0ewnuPtC7LYFjH19V4BdI/x047IJ+SeOx5pik6qkjESk1MzU74Jdx8tGCEetCDK
TF07qJxLZ/wnuSdeGs39pl2XNPFpuagKmpm0jioTpLB3eNjfuNzIyhWbrJCfzqPm
6GoVvAu3HqlWIa70Cl6qfTP3pNrZoIcCI/6jLlsgQtPROi9dsQUPsYXg+oYHZcj/
iYsOD2NnhQS3uQOMClrWzHuxdJVWLo8fE8v9CgayoDYYOmbJ59CeJsqv0mnMfSqD
F5/sgU3IIWDtlDk/x/0ksGzTlIbRahx9jpDC0oAXOzFX4sbi+eN2kju10qYxTvmg
3fEZ8KvbV6OQpsyxEUs1pJ5dihB/TAd4ANPGQkTxvt48IDzO6AAfCFIEx8LUoEdu
AXpYUIyZnirjrjdjjDhrM4B/tTbv3ahtKdrtSIwEExgOhmPQgo8=
=EdiP
-----END PGP SIGNATURE-----

--Ml+rf6EXNXYFNKMn--
