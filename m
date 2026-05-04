Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43603176E0
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882185; cv=none; b=rmCee4yUwwzuLivmhdiXU7ippwMtTMXGddnKqqtVh0PFZZSA2k4GCSDE3ysEwyMMFxsMWGPAa+88jMGdhZFaLP+tOypdME7GG0eZ0UgBnTBh5zzkF1KTxDDrB+IV4h/uL3q40uUNN8qpKB4YrAsdupQKTfQ6zOLwg20Dp5fJJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882185; c=relaxed/simple;
	bh=aD7Rc1PUf3rAQ1KXJzL1xkR8KsWNuy46k7pB63PTBRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPP2iDjWXe2CqG0O+ZDHn8NV8e8kWLCY5jNanFdw6pL2ShiGlCETH0PZaROjMR/eqhukWVnS8wUs7Hqagq4vxJ4Op7STEgk+mNluCqInz/ULkmNBCKYCNh/dEExkIzRE4fZH+hZSvVaDMHC/nogqt/ABpGJgsG2f5uWsOpyUAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eqjsksDx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eqjsksDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=s0JK
	RxGRF1MDDjrb4nH55l8VyOvbI3YHbnWlwm3TMiU=; b=eqjsksDxsDZxTr31kmzo
	+qsvWILzSMb+aobeA3/DlGquoX2LXAMLvJWSlMsXQKgbMQRHvxybf/Jp1MxLhnqj
	r0ba0jJ/V7N9ZWpA7eFeHkszQjE3oCkn46WThiosVYoLlWcyTWF0ScbDgQdxTV/m
	oeNhW9n4dlbCOubc38cvhBhyYIF7no7GMOB1lAiXy8XtpAL5RifPsQpAZGFFfFky
	Md6eTs3WFyGvMrziInNq9vvkS8B9ksPG4yeo2Qoht9Kqc0vJ3PO07bRUWvbQGBFC
	xaaGBG85JrYHmY1o+Mk5IyKmVxbOEAVswo3LXIHph+OOfy+AwnogOAiuraR5Nw+j
	jQ==
Received: (qmail 2093763 invoked from network); 4 May 2026 10:02:59 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 10:02:59 +0200
X-UD-Smtp-Session: l3s3148p1@UvXrW/lQdMoujnvR
Date: Mon, 4 May 2026 10:02:59 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] i2c: testunit: Replace system_long_wq with
 system_dfl_long_wq
Message-ID: <afhSs8h6Jrnbk37h@ninjato>
References: <20260430090810.109232-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JjzRX0Og4xFfWKYm"
Content-Disposition: inline
In-Reply-To: <20260430090810.109232-1-marco.crivellari@suse.com>


--JjzRX0Og4xFfWKYm
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

Looks very reasonable to me. With your detailed explanation, we could
probably also remove the FIXME next to the workqueue.h-include. This
seems to be the proper workqueue now. I will fix it when applying.

Thank you!


--JjzRX0Og4xFfWKYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmn4Uq8ACgkQFA3kzBSg
KbZh6Q//eebDarBJsiUaq2WuPSGAmjoA6JscMwO18qEq0jyJ1Abgir3m9Tc8eqCw
oAmwbl8CyzvlF91gP7rWg03dY9v2w0B0cLSEh51z+TM0og8puH/+GGmfn/E1EBsb
zjOgAbG40aFKBgWwttmMGTgJjEz3e1GGTkF6tuAp5ZVozUN+z/Nxsk+WEpaIb0gp
mxVaOGuP3p+WTR/YljxBbBZWbDEwNaI0NqpxlBd82oTDRQLEKxNKFQ+KnHaiaetK
vZNzTYMyHA/BL1SGw57oh59F7To0CsP5U8f/W1jVQ9oiGiibEreNaw1gJUMMIbcL
zs3y5b79hab25DWl32WUiuRs9na6lKvDiD4B+1AuN0ASd5bsy36IJspB3QZVFYKa
KfYnFRfHfWjfDN5YfJ2JemSYEd4CmMddjS/Oq53qyXMASCRDh//+29wNb0I0NgXB
xs659chINYh7coEKh0zWPfTKedkhqnWw+DvUUGOnowgJB3D7cd8euMc0FECYgJxM
e7+HWcu5nBnzjyacK7L/tTD2n4Yo9C++yA0h6odfEhUQRK/yYyGroF2B/vqrb4B7
h1nxJahVDcVbVL5MN6E5sp5h3ifVq7fcjQ5fMbGo9U14rqNa0YrR6eRDKjZ7SoIj
/yKyFrAjUp3/i4YYzfVapBF6jHVu8GmcCa1WOkZu8VO4nEcZytA=
=QGw9
-----END PGP SIGNATURE-----

--JjzRX0Og4xFfWKYm--
