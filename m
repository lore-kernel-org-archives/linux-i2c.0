Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E942EEB1
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515707; cv=none; b=Xh5LVMN4nx3JzLYBHFavCvuV7Z2XwQwb5iR1AxlIRF8OnLI+dR4oer1FHdOXSx6xu+En9iHk4q41GwiT74IvK9ti3p/zan9QzSBVRqq33gSE4yVLqRQ5ANYK17DHmFoMuuh4QZtQ/MRgFC/RJkutgJgHJ8TDuILI+7P4YRDWicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515707; c=relaxed/simple;
	bh=zA5YFpQlFoYRjsDXFcfMPf3JArKLTbi7sqnmAr5v+iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6YmGXORSYy6QZibWS53lEG6+zkkt4SrhlAxX1DlYlvWkhRaYt1vee8DAr8pEzRLsu2L2nKEz+qtDQyfgVPQZNem5+5eny0jMEmtpkJ15Mof1cRFmANuUE8R4ds/qHx8VsECbjbRLXCXQNAhfKFt/5gVPeSB+V8n0pyIqgXMmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUHQE0y2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUHQE0y2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB3EC2BCB0
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515706;
	bh=zA5YFpQlFoYRjsDXFcfMPf3JArKLTbi7sqnmAr5v+iU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NUHQE0y2kM8DwuVOCV8L/Bz9/UVLQnEHvXOoqvmlJq9V94X+FBSnglfUVoOrBaL/7
	 A+S1lKgJzSuy9xcMqLCSMeZAq/DITsLnr4YSc1xb417knvBYw6E9snDU7/EAiQYr34
	 w6l9aJftDanmYdskJpwAqLeLZE0lQb8a6RwKjwul7r60U+/PSXH4NEhPy5n+l1tFMn
	 ZqM/8/a0y83Ti9tLRdLWZtf8azpXQLSSIlL9hz8y9gUL1ym4A2MgB06Kdg1lW54Q8b
	 ciadjZ16+pEPAZ69r2hUSmFqlUuNQ6d9j6F3rhrmvC4LCCuxk/dqZLif5Y1FG2gOKn
	 wLJTob6ktsuFg==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e7d983f79so39448721fa.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 09:08:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9yv3CfNxstfvV3BXPmTFPiWFl22CK9MJqbUxvikD0CruC1e4YnbTuuBe1WsYjp2CbqXFcuvzNZEJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKGfwc89xSPz1NudYgKRnPLjQI9Bt/m6BdVDsvJmd8bzlFe+c
	a5PZ6R1PYol1fzGe9/ztWF7tXNVeBUyYpO/SHUf6WOcvehpPVgnACXC1L4Q+1q/QSZppAaqCddq
	DSszBEndg1d+1J52OIWb+YKyP7bDhMF4JUu7bp+VLlA==
X-Received: by 2002:a2e:a588:0:b0:38e:a12c:418c with SMTP id
 38308e7fff4ca-393c410af2dmr92872731fa.11.1778515705390; Mon, 11 May 2026
 09:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
 <20260507181711.2696783-2-markus.stockhausen@gmx.de> <20260508131830.GA1135235-robh@kernel.org>
 <007a01dcdef9$05ba7140$112f53c0$@gmx.de> <af9xGlIWG_OmREzX@shikoro>
 <00ef01dcdff4$42318c70$c694a550$@gmx.de> <CAMRc=MfN=jNiPRp_fS9T-39s7c366ak4MC6DWGFreonCZM92FA@mail.gmail.com>
 <agH4HKEQ0BGK4fbt@ninjato>
In-Reply-To: <agH4HKEQ0BGK4fbt@ninjato>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 11 May 2026 18:08:12 +0200
X-Gmail-Original-Message-ID: <CAMRc=McU86SiA_MnyQd+GT22tDqyjmA7go1y2v_BJcPfeUszCA@mail.gmail.com>
X-Gm-Features: AVHnY4LuHaKJqji1rZ9_fQG9cC9m6pmOTiW_og0EwNmhWjZSbNdmp7GoDtuqnqs
Message-ID: <CAMRc=McU86SiA_MnyQd+GT22tDqyjmA7go1y2v_BJcPfeUszCA@mail.gmail.com>
Subject: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: markus.stockhausen@gmx.de, andi.shyti@kernel.org, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 5:39=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > >> @Bart: is it possible to share a GPIO so that multiple i2c-gpio
> > >> instances can use the same GPIO as SCL? Use case is explained in the
> > >> cover letter[2].
> > >
> >
> > The way it works is with a kind of a voting system. As long as there's =
at
> > least one user that votes for the GPIO to be "high", it stays high. Is =
this
> > behavior fine for the recovery use-case?
>
> Ouch, I guess this will not work then. SCL is high in its idle state.
> So, all busses except the active one will request high :(
>
> I guess Markus would need some kind of locking for the shared SCL-GPIO
> anyhow. Like bus Y has to wait until bus X has finished SCL toggling for
> its transfer. That's how I understand it.
>

Could Markus use gpiod_toggle_active_low() to make it logically
"inverted" and then vote high, when it wants it to go low?

Bart
