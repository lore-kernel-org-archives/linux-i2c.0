Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFF439914
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142195; cv=none; b=NorPDZczhkLPOF+gIE1bGBBvu+ahpYKvtkp+OUg9GvFs7mH2UmyI5fRl98UZwj7JGc41Yro/I99XXRpHDzIQhaClFAtVa9YEyAJU2vp+TP2H09AkCQFvVgsiT2H2uwDm9OhTyyg7vD+fa/eq2KZw486W7bgMfu3hquQcXsLqpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142195; c=relaxed/simple;
	bh=ymcwEyj4DH44lCx0ZNPdZS5dt/MmYGRlis0pED2a1s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVrWS0eKthL+qWRalnwsPV5V+6BWjbC2fq+0PzyJIdQf3ZahCNqdRrLQmULIuaYHmicbh3P5FM3pchcAFQJ4DCRPj2LGtfFeS+h4M0WptOW3iu4WLcKtCnl7nAyoCFnvMft0wG1pFT0gPLcI1cmJvcNNb16kdvwC+iPesxVgAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAvxfL3a; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAvxfL3a"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b021916bd3so4840178e87.3
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784142181; x=1784746981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pc5zej8Cp2CJIzssMoKWrKfQALA6yoxrIoO3Y71lFVo=;
        b=VAvxfL3adq8MieGhCxV0zxZM4E2nnarNlPTw6le2jQ4W4BLvEazjOiqQS0ktHqnoaP
         xID/+jdbZvDbEOs635CfdFd3CPZljJ8qc8FXfXAgxOHIBjkuCmFSFGOte2uP1sVVCSHQ
         lkD6QHOEevliImVrV7PD+URS/N1ON0CljY58Wo3/WvscuHlfA2FJ2hfGYL7dsP7m/Wm4
         BFJzL5ni/XZ/NnRNA+G9rjYdgn2Sv8P2ZOHgIBbOI+s6gjD1noQWdz1lQXDrEPF2FY9w
         k7EE1CFvCifZMo3C9u8TxcmRaRZnM98id3JxOXriQzIpP9UQFi4ePMXRY7phVAuTRZxr
         zlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784142181; x=1784746981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pc5zej8Cp2CJIzssMoKWrKfQALA6yoxrIoO3Y71lFVo=;
        b=QiSH/IjIsANnL23d7Sn89HWNXH6bfPh1D7CnNDtidYBETKyweSK2TMj/xNpoPFQx4S
         erRKJDTZt5zlhtIyq4XzLMNB0hBio90TPJJkVVVaGQFCT9V6McQLxQ4srGBeZ0QTwAEp
         AiJjKxszhJ3n+22dBHSMEvhueLSwF4fZ21CATDdDLNjZeIl4FQ4YFDWz9SLJUI3zIovI
         lqGTjIKU1bXRIBhJF/Twu1bsw8SN+JsTK8KSmD8CQ+NdRO81UgRDUlzF9DgCWl6CmWeu
         EV1MwiExEwjdHr3AlwLB6Jai3fxrbYKEd67puhk5dFA0Vad1mf4G22LmeUQbYMAe4uLo
         IN/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6g68zY9u5mPw3aBe0gDDTxE9F8hOPg5VYtDC5hZFgsoTVkBUs9m7FaZ4OSUOLMEhNYHuOEwFcd5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr/WevHa2raSYjFGLoY9t7e+D3fHkbC9yU83ERNZaWkYdafKec
	I7tLAN5z7xHzWddsnjT6JeFUlTxEwbiQWXhNWzzNc//h8AkY2ZMETOCU
X-Gm-Gg: AfdE7cmRY7crY7zO7kH6kqgpKG1xSeVqWxZWk1yQtwPG2ohT5LngltxpXc8Z+m9hawp
	ZldcMwnrM9+4sOeycJuCJfnBOB5MKumEXBLBD/l3Ndi9jMG5oH8uj57uJSPHuf9SbQPxqgshJ5c
	xqJqV+aEYCb+L104AGkDIEzaNFixELEuYqs3ItCMDRbWU4n3z2D1jkGkJJEJG1U8q2Y/fazgM0F
	+c8sSsLAJ5oNaOhR723dXd2pZI5Ef6syJFaA5QHss9lsjVGirxzXyGq4jNzXTVkirQ4cWNPY+G2
	3I/0x/ruaOcAuTKO4YRdq2O0rzWzGx0VrDKPijgJDJfrey7FYNypndnACtrq5si0Mb5pPGzfyNA
	gFS80SKj/1vWy2Aoy4aWVCpIJ+souBFlMy4GqcmRxlShNic+Ufgq8A+OEPdLllXLr4IXylbDbab
	XTmfPvMUeGlINtKfRa0CRGbHhlapT+9L36YmZqjHhXso+Z/YKc9g==
X-Received: by 2002:a05:6512:3d1c:b0:5b0:1760:facb with SMTP id 2adb3069b0e04-5b15d779c02mr1056769e87.21.1784142180582;
        Wed, 15 Jul 2026 12:03:00 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b023b5931bsm3701194e87.42.2026.07.15.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:02:59 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:02:56 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 2/7] i2c: mux: add idle_state property to i2c_mux_core
Message-ID: <alfZYOKCjf6CKN6i@gmail.com>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
 <20260713-i2c-mux-v11-2-72bb8af8ee8c@gmail.com>
 <e2d4fdf8-4dae-43dc-95ae-b9aa1884fdf5@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e2d4fdf8-4dae-43dc-95ae-b9aa1884fdf5@lysator.liu.se>

Hi Peter,

On Tue, Jul 14, 2026 at 01:29:01PM +0200, Peter Rosin wrote:
> Hi Marcus,
>=20
> Sorry for the very late feedback.
>=20
> On 2026-07-13 09:19, Marcus Folkesson wrote:
> > Muxes treat their channels differently when idle.
> > Let the mux core have this information to make it available for
> > internal use.
> > Reuse the same state values used by CONFIG_MULTIPLEXER.
> >=20
> > Possible idle states are:
> > - MUX_IDLE_AS_IS: Leave channels as is when idle
> > - MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
> > - <n>: Enable channel n when idle
> >=20
> > Default value is set to MUX_IDLE_AS_IS.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >   drivers/i2c/i2c-mux.c   |  1 +
> >   include/linux/i2c-mux.h | 26 ++++++++++++++++++++++++++
> >   2 files changed, 27 insertions(+)
> >=20
> > diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> > index 681a201c239b..edf16683dc83 100644
> > --- a/drivers/i2c/i2c-mux.c
> > +++ b/drivers/i2c/i2c-mux.c
> > @@ -247,6 +247,7 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapt=
er *parent,
> >   	muxc->select =3D select;
> >   	muxc->deselect =3D deselect;
> >   	muxc->max_adapters =3D max_adapters;
> > +	muxc->idle_state =3D MUX_IDLE_AS_IS;
>=20
> This is insufficient. AS_IS is simply not an adequate default.
>=20
> For i2c-mux-gpmux, there is currently no way to dig out what
> the idle state is, as it is not exposed by the mux subsystem. For
> i2c-mux-gpio, the idle state depends on both the idle-state /and/
> the i2c-mux-idle-disconnect props. For i2c-mux-pca954x the idle
> state can be adjusted at runtime. Etc.
>=20
> In short, idle state handling is a bit diverse, and I think this
> adds to that mess.
>=20
> I think it will be a bit of work to come up with a scheme for the
> I2C mux core to accurately keep track of what the idle state is.
> One way to deal with that is to introduce a new "unknown" value
> that can be the default for all drivers that has not yet figured
> out how to feed the correct idle state to the core.
>=20
> And that hints at why I think reusing the mux.h bindings #include
> is bad. The mux subsystem simply has no need for an unknown state,
> and adding that to mux.h is therefore out of place.

I see.

I think I will introduce a few defines in i2c-mux.c then;


#define I2C_MUX_IDLE_UNKNOWN	(-1)
#define I2C_MUX_IDLE_AS_IS      (-2)
#define I2C_MUX_IDLE_DISCONNECT (-3)

[...]

struct i2c_mux_core {

    [...]

	/*
	 * The mux state to use when not active.
	 * Possible idle states are:
	 *  - I2C_MUX_IDLE_UNKNOWN: Unknown idle state
	 *  - I2C_MUX_IDLE_AS_IS: Leave channels as is when idle
	 *  - I2C_MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
	 *  - <n>: Enable channel n (starting from 0) when idle"
	 *
	 * Default value is set to I2C_MUX_IDLE_UNKNOWN.
	 */
	int idle_state;

    [...]
};


Would that be a better approach?

Thanks,
Marcus Folkesson


