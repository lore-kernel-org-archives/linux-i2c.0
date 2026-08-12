Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875C377023
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786509596; cv=pass; b=HPAsV5NLEhwzO36dtlTeSQgYfAjfD2cJOH2VCHXzM3FLUSIVAZg6GglKjZWhscHR3Z0DBWT4yYu+MxfNOzU48Ib104j+2n+LQ6GD5uF29Y4VcIyP0i3WwyTqSOylA9zBOpwlOCaAbrV3BDbBKU/TgbRzij1mkeyfKbj3SS5sI/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786509596; c=relaxed/simple;
	bh=Bn5EA8mnuFm3bH5umIuq0sbge5qbiERu/rawKyKCdjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7fza0gCu9VIfSu2J2k83qkeLdwDoDFA4jAq+07rsGvEvWSuUX3w/JU9F0t5PE70AC7tbJMiBelt2I4OFwulJkpegh4r2lseb6HYnM9ZRCHzbyJ2Vs9nQqGyd1vAHAeadROHiYYiuKd7piVr8ig+aq/VI6V6Lufm3jpDmbWLNYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SCEhEFlg; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCEhEFlg"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-45691990234so310103fac.3
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 21:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786509594; cv=none;
        d=google.com; s=arc-20260327;
        b=jypESech2Z2BnOkBHrfVtXHJQxZ4fpw9FpFHQ32YdySVFJya+tcHWoxcNbkA2G/4BC
         Yr+YZAYpjeib3EsuRmdNEoL7tTnya2h0K+ST37EH4WX2QU0LTMIg+EkYIc9jyKOOx1Gl
         1vOX8cde7UuXAyaliXCDv03EtwAbeng4GYnwmr6nuoz8lPXrxxkzAt5hVK3RNA1kRwEU
         swKqAsm0bIKUZUrD8wyzK0fudTZPquqct039r+Z/cpHLSkyJtmQ5arbOcmUfIP/xP8ox
         I/BDv7YqJourM3YNLulHiwwjFoHNRqmJtmf0yzrlzSP0QOmonM5JK8CG0wy9f5YX+SK4
         bd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y8EqzbJg8fD3KowEEfKkshsn5eXfhPp6NSIWl0mIxuU=;
        fh=dJj7PDYxvC1F4/uI/jvVnPLo78OW+6jetYZnylRw4cQ=;
        b=SwtT+OJxqEpYpV2BnowHsUSFSRLGv6gwkGRneperrf/jH60G/R6xIkyLoz9OMrmH5s
         LX8WKoqSDCsQFUX+hUV/P5i9fuwtEHRPIUg2V5Wc7EsnBUUiJbiVA6UgdAy2OHHxRH4v
         5ePPXECpX3A8zpS6WCTAbfZgiZ6FwZlH1h4C6tVHpq32o/6+S+T8oZR4Ol1M5mAdUkUz
         dagDL8t2NwC0LOuJ+t1Epw+H9puYOPY6Qwc+u27fdoIn/41AA3qUik9bC3hSfLt/D2NZ
         QUHENBVdjqUNAl+DA37RX8LiK6ar8zWB+9tcy2VqXZspLV8HYeou/jnC0uqs25KivlmP
         46qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786509594; x=1787114394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y8EqzbJg8fD3KowEEfKkshsn5eXfhPp6NSIWl0mIxuU=;
        b=SCEhEFlgd74xOyfBIj27VZ9v0UZnM9YfgSkzGDtY8wgdxjQPcWSY1DsH/o0QfXTwHN
         2Le5BFDtThj66x48BVeVT2jfg6y+MLmBwxerE2AuLgXtaK7q5oI7e10w2/I8YMRcviXi
         bcPIb3/pImk6nK08Y20lAkDKR2wdUKqOOd+zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786509594; x=1787114394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8EqzbJg8fD3KowEEfKkshsn5eXfhPp6NSIWl0mIxuU=;
        b=q7jU2aZ5BCwNHAC5lmIL3b+thsFPEe0sm/v7Ox3jnFICnqCtv+dRsvwnIPpF5fBwD3
         CI90Nybw/ixm5wLW0CoB3EEtQ4JggOnY9Glwb3bW8cug+x8hvudYHjI3YV3B2V/CabJC
         5LVsKSic4vLXG5uoQ03cyNxq8/8GzpFIHRt6J3xYgy6iE/pAniEbrnjkuX5muXYsPdIy
         /d1Y5IdkKy5tVO8RttQ8KTJhnWHMHHoMp4D4MEFKLVeWhzT9H4BOAStW/7Qr8aT2jr+V
         z2kzATri1qQm082tT+XAc6IXJiYPCgyEg0MXBz6mnvewUKWiqpul8BmEaxZI/IN8bvup
         O5ww==
X-Forwarded-Encrypted: i=1; AHgh+RoKdlEIZq+Ek6lK6KxrXAxFsMiZ+KJzVAzsSxNYZ8G4RKFeYzkiZyTMhjCIN0mAJgHERBaXSdseXCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPEd+dQ9mDYYXrOhz/4q9rK9B004sagmTNzXzzXHncZApmYqn
	13/9zOqn5O/88urr+GsQHyhFj5hBMudW1xqL5JwkTF/ed+jERqe++7cCFN7W7NbhWBVrs0FryRs
	CgI1B0g/AMud0OM4CanO7wXnN0ol0X3epSMkAKp9u
X-Gm-Gg: AR+sD11/aM99Xl13nl/oU7e/Ek+9cwMdW5W2UiVGYqRwxFix+B7MYYHrNj5AE98l2Ml
	R2WRcoX0Fh8GMVsOMvLVK3ndClNB5w41uY2577849abVFT+rzo0CuWJHtjlwb102YmiFweD9ma7
	wCcMrF7zYPJK9fC/d3B50AtvfHwKTTLlqP21uDoAgVLTWwayAXsSUkh+LBUxQRvPi8sMQ5PpYZW
	/7r0jWfe/6fpKdfEytjxBxeZ3W9nob98lrKD1GU0sujfhD2yM2Kq67MapfV37bQMCsePbmTQ2OZ
	mqWWgxkDUF4NHrRupapKeMaustLHuvGYyeOr3SEpNZpKL1CUt+VXCa11zavnBiJhh4Sn0BqH5p2
	TckQ6GtA=
X-Received: by 2002:a05:6808:2f13:b0:495:d7ec:b6be with SMTP id
 5614622812f47-4b210ca8dc6mr1833103b6e.18.1786509593853; Tue, 11 Aug 2026
 21:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811122011.3539250-1-wenst@chromium.org> <20260811122011.3539250-2-wenst@chromium.org>
 <99ad23ba-f8f2-404b-960e-1c22a20c9ac4@sirena.org.uk>
In-Reply-To: <99ad23ba-f8f2-404b-960e-1c22a20c9ac4@sirena.org.uk>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 12 Aug 2026 12:39:42 +0800
X-Gm-Features: AUfX_myPgwTrMoDWlXxd7K4JTdOxXQP71DAA9qzbfq1hbTylwiYJcqKiFEh4if4
Message-ID: <CAGXv+5EeEQM6O8Vb8e8fGjRzMe1icmz=cPm3GoKLxvEO=weVcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] regulator: core: Add "enable and wait" functions
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:43=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Aug 11, 2026 at 08:20:01PM +0800, Chen-Yu Tsai wrote:
> > In device power sequencing and initialization use cases, it is common
> > for the driver to enable the regulator and then wait for a certain
> > period of time to pass before continuing.
>
> Please don't bury core changes for subsystems in the middle of random
> other serieses, this is the first time I've seen this.  :(

Sorry, that is entirely my fault. I was using an old v1 recipient list
on the previous two versions and that list didn't include you.

> > One case in particular is not optimized yet: a regulator left on either
> > by hardware reset default or by the bootloader, but does not have the
> > "regulator-boot-on" property set. As the enable timestamp only gets
> > updated when enabled by a consumer or by the core, the first enablement
> > always needs to wait.
>
> Just take a timestamp during registration if the regulator is enabled,
> we check if it's enabled anyway so we may as well take that as the last
> time the enable happened.

Yeah, I just haven't figured out where exactly in regulator_register() to
put it. I think it should be after the supplies are resolved, so maybe
I could do this in the "final setup" part in regulator_resolve_supply()?


Thanks
ChenYu
