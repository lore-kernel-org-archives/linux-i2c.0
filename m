Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93733F5A0
	for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223138; cv=none; b=HiChYHYYNJ+T6rK7CkebYH5jNhnFjzeDCj9Rogt55JKZvV6D8cuBkrvQAJF+OQq7ADSnpuxpLZZJ/GdlvIWvwG7jQsn0jKbet4UD1jkpwUvNyekF2+mqE1bhh+uvn2ywIZ15Tddphx0IOJDceAozAd9hkYKQCc8cDBn3izCkVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223138; c=relaxed/simple;
	bh=e9Zscnjlb7eVW1JuWllN8dr+9XusTB26pfEhJfepi9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJpkIVJyRCfqaW7OjdRU1Qjg/dvjy/LssdT6UFquU0ysKCupTxpBL3cZynV5RxRgD+jUEekSkKoZbddtUO0pujHBqx5SbGtuqkjbU0nfNLLzOcE/7K5vfadwhkM8CmkUACCKkG93NkKjv4MY9Dz4I6Qa0AFG7eeiCcgMGjzhXMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRa/ByZS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRa/ByZS"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3967725a77fso4259451fa.1
        for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780223135; x=1780827935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xMYihA9IlT7MGBAsYy2tN6OXn0Itk+3Xj0eqVjjKY/M=;
        b=CRa/ByZS4fqMVTvyep5GBYbVd5o21R2QhjklKzvaDqs3xaCtPY4Kyuqyzwy20vMIA/
         vjh5k+gZ0wO0fvuVQZC1GJKMY7pLpfQOdL6i5IlGzvek4vAUbvNRbpWBeSHdGrn3H4nQ
         b1e6Pos046H/tq4+0tlzHCfE2Id+YvYGvY/AJOUsidrV+bQTi8tJ8rujmMt6Q1T4nJb3
         oLFDZyup3mmTrtFjS00Kg+tIDDHDmSoSPaz8FVPITLu/csB+vfI+Q6Z2B18eaAQQEAzb
         /q6aN/1E3VZac8E5Q9Wxn91mITVEW2UzprlRKJ3lUNAiF7Vfx/Pfow0BDEOd/ACmK+9F
         lAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780223135; x=1780827935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMYihA9IlT7MGBAsYy2tN6OXn0Itk+3Xj0eqVjjKY/M=;
        b=VrTMxstjidvFBkEAUuEtYPlU3LW+bh9qg9kz33eLQg+wLodKVJJ+NbFsgdlwZWJATM
         Nai1AXH+znudzkpK50oAu4MS/HwY0Edi8FLzYOJV2u7AJgswrvdQAlR9k1xOxSwUSkLE
         hyDWZpVaprdtyi2trCikqv4u4aPryyvHIVy2ZeKmbzG18HDlelNTZOzG+8kIZlWVk/QM
         2hjW3+jvT/4rGtaVIFUaamacjW+YrRJrxc86vzvdObG4rw2SgF6a3On0fG7b0D4E2Dll
         D8doffUH3V6QTSrc3hU86uzIoVwRzeY6dCJRzOXMtR5ngee5eO7LVJsfB3fBlUX3uErR
         gTKA==
X-Forwarded-Encrypted: i=1; AFNElJ+tTnpYYDXDI7vtKoJuCIeGMa3jdinYGjao336E2g+p8JZMn2EaxXS8t6N0gAXj/1Y2hk/L3wBLIB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsPGIZkekPwsapO2uFADhfPyu2TOzkOsq4eCA7E8fGvHzepjx
	bZWW+yZafc2T7oaHAvuZC/oXfS8SdUCjKZILqVygFKm7TrhYmDkhwZE9
X-Gm-Gg: Acq92OEZqj7q+ErrJKmmebcE2usefI7gwf5jlby8W7sK3/bQnG5H+YyZh3VDYJIM6eI
	KWWPLJxbVBDNnr6Uu9rdRHaiBkUk9uopWTZE6xp+komtJ5vF/gnVVl0N2M9XO/rmUfgHANLE6mh
	za2A1J171dm5wMPINGFiifpk6D5hx38m7oamOE3Mp/X1iteb+3MJtDQnnPAZivC2+TmSxlhxTOD
	nZtGSrmbwVjtrax140lyal0ue/k0qh3prKwipKif2PV3G4VECwMopxlX8tHXkISFz4BNFKEhmNb
	NPxevwHWappDgH/u7W3Ea5xDLiVA50bUTTwBcWySdtpwHMI4guPi3FmrvruKbB7M5+LGEXTXkpO
	4FLGI4Xvwv7ZnMP7KCLzEefWC+lQ5g5huA/Zn3PGfP2/BrA01w7fAX2Hzn097qyKLzvWb4I+N+G
	jRSKXZ2im1VYMAJrtdajG/NSlcIlAfsm9s1f7k40YUJnqdw8r69NmyN4AX8MTH68qtuTbF+rE=
X-Received: by 2002:a2e:a548:0:b0:396:78b8:27df with SMTP id 38308e7fff4ca-39678b83166mr6460391fa.8.1780223134727;
        Sun, 31 May 2026 03:25:34 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3965b3cb6fesm14245011fa.14.2026.05.31.03.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 03:25:33 -0700 (PDT)
Date: Sun, 31 May 2026 12:25:30 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Message-ID: <ahwMmgy8hRaQ-x_7@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-5-5292b0608243@gmail.com>
 <ahX4_WaqodYt3PmD@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ahX4_WaqodYt3PmD@shikoro>

Hi,

On Tue, May 26, 2026 at 09:48:13PM +0200, Wolfram Sang wrote:
>=20
> > +Multiple muxes in series
> > +--------------------------
> > +
> > +When multiple muxes are used in series the same rules applies.
> > +
> > +Transfers to D3 may interleave between select-transfer-deselect to D1,=
 which
> > +results that the bus speed to D2 or D3 will be at 100KHz.
> > +
> > +Transfers to D2 may interleave between select-transfer-deselect to D1,=
 which
> > +results in that the bus speed to D1 may be at 400kHz as the transfer t=
o D2
> > +will set the bus speed to before the transfer to D1 starts.
> > +
> > +This is probably a bad topology ::
>=20
> In documentation, we probably shouldn't say "probably" ;)

Answer in next mail.

>=20
> > +
> > +                     .----------. 400kHz .----------. 100kHz .--------.
> > +    .--------.400kHz |   mux-   |--------|   mux-   |--------| dev D1 |
> > +    |  root  |--+----|  locked  | 400kHz |  locked  |        '--------'
> > +    '--------'  |    |  mux M1  |--.     |  mux M2  |
> > +                |    '----------'  |     '----------'
> > +                |  .--------.      |  .--------.
> > +                '--| dev D3 |      '--| dev D2 |
> > +                   '--------'         '--------'
>=20
> 400kHz leaking to a 100kHz device is bad. I guess we cannot do much
> about it here because the bus speed is a board specific parameter...
>=20
> > +Idle state
> > +-----------
> > +
> > +Muxes have an idle state, which is the state the channels are put into=
 when no channel
> > +is active. The state is typically one of the following:
> > +
> > +- All channels are disconnected
> > +- The last selected channel is left as-is
> > +- A predefined channel is selected
> > +
> > +Muxes that support an idle state where all channels are disconnected a=
re preferred when using
> > +different bus speeds. Otherwise high bus speeds may "leak" through to =
devices that
> > +may not support that higher speed.
> > +
> > +Consider the following example: ::
> > +
> > +                          .----------. 100kHz .--------.
> > +        .--------. 400kHz |   mux-   |--------| dev D1 |
> > +        |  root  |--+-----|  locked  |        '--------'
> > +        '--------'  |     |  mux M1  |--. 400kHz .--------.
> > +                    |     '----------'  '--------| dev D2 |
> > +                    |  .--------.                '--------'
> > +                    '--| dev D3 |
> > +                       '--------'
> > +
> > +If the idle state of M1 is:
> > +
> > +- All channels disconnected: No problem, D1 and D2 are not affected by=
 communication
> > +  to D3.
> > +- Last selected channel: Problem if D1 was the last selected channel. =
High speed
> > +  communication to D3 will be "leaked" to D1.
> > +- Predefined channel: Problem if the predefined channel D1. Set predef=
ined channel
> > +  to D2 as D2 may handle 400kHz.
>=20
> ... unlike here. We have MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT defined
> already. And I'd think we should only allow bus speed switching for
> MUX_IDLE_DISCONNECT to avoid out-of-spec scenarios. Opinions?

Answer in next mail.

>=20
> > +Supported controllers
> > +-----------------------
> > +
> > +Not all I2C controllers support setting the bus speed dynamically.
> > +At the time of writing, the following controllers have support:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +i2c-davinci                    Supports dynamic bus speed
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> This paragaph is easy to get outdated. We can document that only
> controller drivers with the callback function implemented will work.
> People then can find out if that applies for their driver...
>=20
> There are some grammar correction in the Sashiko-review[1]. Most of them
> look correct to me. Can you have a look at these, too, please?

Sure, thanks for pointing that out. I will update the patch with the
grammar corrections.

>=20
> [1] https://sashiko.dev/#/patchset/20260324-i2c-mux-v9-0-5292b0608243%40g=
mail.com


Best regards,
Marcus Folkesson
