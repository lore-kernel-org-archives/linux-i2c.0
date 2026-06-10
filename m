Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD74301465
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111979; cv=none; b=U4sjYrWGg5ZEk6tolJMP4q6qQbZB9SZSZ+HFTlqjwKVGT91n1ZQKhfQp99T0jndxAFRLN3NR+IjLoFQ1MUT3rvDqWjWY9hHTfl9cWdfEkTaOEAZdkXsLehK0Z4q/E1Z5RGdIItYZqqUOkQ4Lq7g0xsbHXHEmoo+LZhuvayoVRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111979; c=relaxed/simple;
	bh=8gVef+i5aBB/TodM6O2mmrxaXKNJ7bORsie7srbCQ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLc8WscGhJEkbAvaEnVvpWOGZTmZqfMBQpW0gdoYcrDWtT785CvuePwUYV4bMUoQQHwWvG9Z17jRuKNxpY0UZrWLKAcpIRpBkk6DYs7V3n0GyCN37kP0v2wqhfx2cxjxb4Ek8GO/2A6SZvcjpeevHKUMSlrWvVsRFF0uTvUxtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SVVbSTWK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SVVbSTWK"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eeba68948so5061451f8f.1
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781111975; x=1781716775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pVIUqk60X3mtO/EyF1HBZLhTOOViiGUvSRCEiWmEXc=;
        b=SVVbSTWKXZd3GAnED9JmXToL+MLTsoQbLrAuiwtLCBBbdx6BNJLgN01tAu8VoZqTAo
         2qDr/eQCu7O2dE4MzjAw7RLTx8biBNoLXwDDQf1WLfhbP5IKAg5FTtK8xuqwVBmmD4My
         KO02cDUq9HN5KRKCtIyyC8uqmClRnmXeSEgO/RRePGUDxFrbVTchqYlpuk8daT9EDQSq
         9EATtIwtPSHmj7KqSWv6OFBPkyRFnfj2FOhGkmFTOu7lb/gBWK0MeklxhoSQOQw5GTIo
         SdwVdKDpLN+3GZSKActQ+jgXa8DkRrYAHUfuuad/htsrWMqRKvYTklVmrSfIcV2FH6H3
         X+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111975; x=1781716775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pVIUqk60X3mtO/EyF1HBZLhTOOViiGUvSRCEiWmEXc=;
        b=o1vhnI1Bv/MfPkpokq0ge4vUPS36lbkrX+mRwxe4SRpRAe+JG3dL09EZVQoNmz9LSr
         Xdre/lgocTLu3bz0T7QnBFZ0ktAlcurJK9fwKvuQVXpbbFWpwSrqDPWvnZSu5njVgaSQ
         aRuhhIV2N4OXPtf3YeBFni0M7E7LzsFYGKt/fhFrVSf3CoH5AUvdpp4uhQ+Ca0UU4pHy
         l6GgPCN53EQMbkujkTijgq/y7dxbe/LxPbL9z8a7eF/c0sQlcOG0cX0vWgk2QtMoDlwB
         7zqTtKhM2pFqYG+ErhZhi6H8MVw47AMBW6V7DFSdJZCT5PA4y1UKsEyAb2XDkWLNHLAH
         PnIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vAbHt4bW7ovMuLwgTKnqtdHrY8pcoQMFKHBBMg76q/+bhVH5SVHXO3rm9AL5+mZdY12j9CbTY714=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHWEXI5k3Wx5ymK5BCLWlbBVWf2fS0vAYVX7L0VS4p68ySpIc
	NDYrAzJbrFKdBecntCRL/StFqfLoHaAStVdO96aI8MrDHypsk4y0WoISl5lX6lEzJjU=
X-Gm-Gg: Acq92OHxqsYTUk8hs1/CLzsumxpz3xep41/Gn3GZZ6q3WjsuT6E9uftaKMLp9vjmDB6
	hziKpunSVl6kFQytmobS5dXCk6N1x0k5XTb9/mtlyYzTR+Vz40fmppvZGn/LkNuyj9D5SGqSRVw
	UvWMOGdRhdWhzubSFcSaqs9tRXvTiXN9B2A6iSvSvlW4L5CpVRvE7bKeZ1Zt1uSPr/YeTYftGap
	b/1m1dwrZ+f2O0vqYCFZYcT3bppjRJEpNRtkqLETK2bt1684foVxmoW8Ls88dlTsSbtloVrqgvW
	9mttCcdd8O69z0JvNTzmKhEENJTi6QCgu30xlM7KH8qEnhFIeAkk1E4ebIzxj60bKS8ZCqCIaEd
	GNo8yxhFFo54UGiyfGTQ1xKXl3Dq39qKcoXWch67WbRYfRU97lF96/XWYX6JkXUwSKd/ze1c0Nv
	JXYejQIc+9SAwmPaMvpW2hIeFgVtcOXY0QwPcO3ZT4MSwhIunvZrypYkHCFihkeSQgRLtMYxw8y
	OsrktnPLUKEsTXtoXkLImnIAQ==
X-Received: by 2002:adf:e00a:0:20b0:43d:6fb7:fedb with SMTP id ffacd0b85a97d-46030623307mr28085493f8f.36.1781111975399;
        Wed, 10 Jun 2026 10:19:35 -0700 (PDT)
Received: from localhost (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f351ac0sm128033042f8f.27.2026.06.10.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:19:33 -0700 (PDT)
Date: Wed, 10 Jun 2026 19:19:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Piel <eric.piel@tremplin-utc.net>, 
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <Akshay.Gupta@amd.com>, 
	Guenter Roeck <linux@roeck-us.net>, Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Kees Cook <kees@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v1] misc: Use named initializers for arrays of
 i2c_device_data
Message-ID: <aimcUxM5qglrL8EL@monoceros>
References: <20260515162734.469327-2-u.kleine-koenig@baylibre.com>
 <CAMRc=MfxgY77TozGqUsWrjsTmBKnZLm0dziAn1JAiTok67RXnw@mail.gmail.com>
 <agwvkt_iWF9UUR-t@monoceros>
 <e1149cee-3b7c-421c-91ab-fd3fe94f3c0a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iwab4l3thezp33dc"
Content-Disposition: inline
In-Reply-To: <e1149cee-3b7c-421c-91ab-fd3fe94f3c0a@app.fastmail.com>


--iwab4l3thezp33dc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] misc: Use named initializers for arrays of
 i2c_device_data
MIME-Version: 1.0

Hello Arnd,

On Tue, May 19, 2026 at 11:45:49AM +0200, Arnd Bergmann wrote:
> On Tue, May 19, 2026, at 11:40, Uwe Kleine-K=C3=B6nig (The Capable Hub) w=
rote:
> > On Mon, May 18, 2026 at 09:53:08AM +0200, Bartosz Golaszewski wrote:
> >> On Fri, May 15, 2026 at 6:27=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Cap=
able Hub)
> >> <u.kleine-koenig@baylibre.com> wrote:
> >> >  drivers/misc/eeprom/at24.c             |  62 +++++++-------
> >>=20
> >> This drivers lives under drivers/misc/ but I maintain it separately
> >> and send PRs to Wolfram so they go through the i2c tree (historical
> >> reasons really and maybe we should move it under drivers/nvmem/?). Can
> >> you send this separately?
> >
> > Done
> > (https://lore.kernel.org/linux-i2c/20260519093806.1567914-2-u.kleine-ko=
enig@baylibre.com).
> >
> > @Arnd + @Greg: Should I split off still more or is a single patch for
> > the remainder of drivers/misc fine?
>=20
> I think a single patch for drivers/misc/ (minus the eeprom ones)
> makes most sense here, since it's really the same change across
> all drivers.

Should I split out all eeprom drivers? Apart from the at24 one they are
covered by you and Greg via the "CHAR and MISC DRIVERS" entry?!

Bet regards
Uwe

--iwab4l3thezp33dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopnKAACgkQj4D7WH0S
/k4fugf/bcymQNxipHKuCs3y6EjRhz0IzwRnZant2QIPkumYP1kHQKmMEfdHIa/j
Gdt+0owXkKQWYvEV5DsyMkz4gNbIaUiif146eWetIMCQXTiisad2ETJPP279nDSw
xbjkXTn9IwgtaZx1ETR1oBoQsQzUsWzExDhtyOfhDsULU9B0zKcdK9lriaMgsVg0
uEdTs0mXp06UyR56RoR3lE5wtnYgOSS95Yb403TqZ7mRYzBdooxBk8cZmW3J2G1m
x4yCgrUKh3cT+KAgHI7qIGY1k/1I/GSQnjEY6lYb2k96I2nYYJgoMMdCBjsDTn2h
2J/GiZLXq5pNLPOmsxl75JAe8fy8Mg==
=h3pA
-----END PGP SIGNATURE-----

--iwab4l3thezp33dc--
