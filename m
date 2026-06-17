Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF93803DC
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687632; cv=pass; b=LF/rqmsABI+EJJBV1i4/pYMyKaaTorAaP4d7nsqehTSEXUaKZvM5MaoIVHBcQXqPtF+3wzf69tC6HI7dCvKPdemIqxn1ntTWl6wkKJgxS/yQDqb67STC0ONnygLf8cy6FwMyyE9wNIh66n9FO3aDuRr8ceujp66HTTqvyrY/e1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687632; c=relaxed/simple;
	bh=3ois7uJYLekKAQG+JspaUzPJU4OIUiESd+WUf3xjbcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIJY1F5fGCF+FaQTOxwe31aQdud+5+uK4wYX+mPTD0rBMLV6F7ocBCdgmEwlhJyjI9RXzV7dl05y1JIpS082AMQt3pbVJd1BxkJJpZlI5SgXn/VaQGDs9tlNJ6re0Rz0b02NgIsqbKZPiDAo0PUxIQsTUwIx55pW8aKgPWC2+QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM80f59C; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM80f59C"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7fedf0e99bbso2910127b3.3
        for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 02:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781687630; cv=none;
        d=google.com; s=arc-20240605;
        b=EE9kHtW/6iDnRh8bU0tMpfbvKUvTU0cGYczPpy4ry5YksNHG6/uu2/uKt9l5Db2Z3Q
         zjd4g+eyZJmVLRs0qcw9ThQ85b41NM6RKczXDknZdpC6nLoYq/D3hVAeDwSJzgzjphLR
         HtfB5R07k5W10szx8oY4z9dqQMn2Q2M6bTt7KH91wwNXJZoJQj+y0zPdvdcDOo08zZ+y
         dGGqLKY8lsqo38MOV2xHMNG1rOx9u08WOlldrfivJ9l9jRJ3PNW2ZXrpMOPSTbI1oQE7
         d84x11k6/NIPwO48xJnBx2SozGvQx+OfJenT2sNfc/Kq7pgWsvPYhZzR4R/VJUYeEt5O
         2cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ois7uJYLekKAQG+JspaUzPJU4OIUiESd+WUf3xjbcM=;
        fh=tsYmZoMtkHmt70D7yBpURG+OfHqEqutk05s9giJXdWo=;
        b=iBO6hkuaeCvy13UqJ/TUPPtQq8WbDwKzZ+7WM/a07KFhnRRnGkVBoxra8/zXtsLYYr
         WdCSfvU3AKA7PBz91+1JUhmQZ4bI/KrqxQPi6o2h8vBI4c6pYR1iLvlZazWz40UaRHy7
         nb6+Lj2GMWtvlLRsgEbJxpnTQW07ZeBeQSzFXZLFE47lyv9Gr+3j3haNoPtKQZNYeNFa
         Ta7hQFN7IBMXnlzfHjfGxG5om4/Af76Lu7MJeRz3JeGSGXGJQf93Fh83KsRBl/Ddj9TY
         Vx4fDhRTSCVthy+YMk0938EQR/dtEiWxOc3GR4bCIFv6VlsuLPVcvWZWJ+56jLO8bwqe
         8bsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687630; x=1782292430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ois7uJYLekKAQG+JspaUzPJU4OIUiESd+WUf3xjbcM=;
        b=hM80f59ClM++3AVcJ2XmRvulL2V9Dp3mmcHlmaFgtBtNYYVG2W6klH5Bq76HjpHCbK
         bjdkqPBeRmo3cuiHcezDxsb6hfXI/iSCY4ptvig03OLFSxxUXIo4UoycjsXO+EGwt75V
         gbyrkQjYcYIDt9AqP+/9i+7Of6fV1ub1d83OAScWst2dtXwLt8z7qpVp79UFnPGuF5yK
         lg5T0wBNXVrVKRwoa5cJdyMAQsIr2bvrS6ICk0QWuFY0OOsikTV7ZA2vFmqg/qD9tI2h
         bfZyJHhKxJti7zXlHsLpgx7tJ4HvQ6BcPbi/fUa8KNjYFv0sNoumrxwQxuBspCk/hp/Q
         YXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687630; x=1782292430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ois7uJYLekKAQG+JspaUzPJU4OIUiESd+WUf3xjbcM=;
        b=spVNut5S3/+baf8bkH01AOY62nqDq2euryXUQb49RtXHUPT10vsdMltucbB8yWrG7l
         U73yAgAAQPc8yaAhHn0Sz2ZYoHtxJe+Xb+sa6Bbj8Uvz8hL3kWE14/1fUKCUZJbP7P4G
         plbX2MzZLjdumKw4TeisZaZbQdHbcWx40upeHSnharusnVN8bTjq6V9/qPH2UrlnEv0U
         jrajj7XAjff2bi4Z5ovR4EXlpEO6MkSAiJ1J4RRCMr1WVyz+vCT+FYNilP0600BhNEuB
         lGX4DSHYMuiHMujh2Pjh48pDxYRU0Nc6A1RqpwETMk+qsvqw1pMDVkhH/ljNMXPwxo4j
         FfkA==
X-Forwarded-Encrypted: i=1; AFNElJ+4z52wgi8Fg7FdpT4jsbz4gd6pTh00iXe1Tux1Sii6rbacact7CpKvpHpAhfQzMfs6Wx9tRyZOZBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgESphf3+woiXRNK84+Yo6+VrxdRkx86GN8Q16+D5aTqbIIz2
	3of3pV6/104u23U2JwD7PsRT6bbLsvFEfruzlB0F31WFYuDA6EYosRRgq1Gc3q805ZtU7VJdY+G
	ou6TjWPoQefJQ6oomm9/90V+zZ+RRewk=
X-Gm-Gg: AfdE7cl9FKK3MHe8KfLCgBU56vVwknC0Ai8WenHo0AkaYrPTQ1jOBQQKEHHE8oXisLf
	2qovxMYg6tCbUseHAbjNVI3AOOEU7xjSpgCSc0LgPpidsEITBj94X5nNnZcejT5k3rXdAIAoiDp
	d82aMMW1ie3tYtLscBEhPgGAuj/Q20yCDc+33dFLm+QAD+d+VXSIaKXXnh+HDdfB+LzIZnYSy1+
	fheDh8T5mYodc7+be4cQyHkTVawnBqzG5SOVPYzlXuaiisM2n+CdfSFktxClXxZhGulrncIVZv5
	LOWt+yK/B8NUFgb24yIOJDRR+Sit
X-Received: by 2002:a05:690c:ec1:b0:7f8:7e31:28af with SMTP id
 00721157ae682-7fe5e3949a6mr25687807b3.49.1781687630339; Wed, 17 Jun 2026
 02:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611104857.242153-1-guille.rodriguez@gmail.com> <ajJcxgVejqzlwo9A@zenone.zhora.eu>
In-Reply-To: <ajJcxgVejqzlwo9A@zenone.zhora.eu>
From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date: Wed, 17 Jun 2026 11:13:38 +0200
X-Gm-Features: AVVi8CcpI0W5riwjaqmESRlTpsqx7BYL6KjvKyJMbak5WMtWwLSsdGYOX4x2Jls
Message-ID: <CABDcavYH+=xrCA605me+6XrjV3QmVAqdfEmAC7SwFQBT4GHarQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: stm32f7: truncate clock period instead of rounding it
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"M'boumba Cedric Madianga" <cedric.madianga@gmail.com>, Wolfram Sang <wsa@kernel.org>, 
	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, linux-i2c@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you everyone.

A possible improvement would be to derive the clock period in
picoseconds rather than ns and do all the timing calculations based on
that.
This would reduce the rounding error (from max 1ns to max 1ps) and
help the solver find TIMINGR values closer to the target bus
frequency, while still keeping both freq and tLOW within spec.

I wanted to keep this patch minimal to address the spec violation
itself, and also to make it easier to backport to stable. The
suggested improvement is a bit more involved, but I wanted to mention
it in case you want to consider it.

Thanks,

Guillermo


El mi=C3=A9, 17 jun 2026 a las 10:38, Andi Shyti (<andi.shyti@kernel.org>) =
escribi=C3=B3:
>
> Hi Guillermo,
>
> On Thu, Jun 11, 2026 at 12:48:56PM +0200, Guillermo Rodr=C3=ADguez wrote:
> > stm32f7_i2c_compute_timing() derives the I2C clock source period
> > (i2cclk) with DIV_ROUND_CLOSEST, which may round it up. When the
> > period is overestimated, all timings computed from it (SCLDEL,
> > SDADEL, SCLL, SCLH) come out shorter on the wire than calculated,
> > and the resulting bus rate can exceed the requested speed, violating
> > the I2C specification minimums for tLOW and tHIGH.
> >
> > For example, with a 104.45 MHz clock source (e.g. PCLK1, the
> > reset-default I2C clock source on STM32MP1), i2cclk is rounded from
> > 9.574 ns up to 10 ns. Requesting a 400 kHz fast mode bus with
> > 72/27 ns rise/fall times and no analog/digital filters then produces
> > an actual bus rate of 415.6 kHz with tLOW =3D 1254 ns, violating both
> > the 400 kHz maximum rate and the 1300 ns tLOW minimum of the
> > specification.
> >
> > Truncate the period instead, so that it can only be underestimated.
> > The error then falls on the safe side: the programmed timings come
> > out slightly longer than computed and the bus runs marginally below
> > the target rate (375.3 kHz in the example above) while meeting the
> > specification.
> >
> > i2cbus is left rounded-to-closest: it is only used as the target of
> > the clk_error comparison and is never multiplied into the programmed
> > timings, so nearest rounding remains accurate there.
> >
> > Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guillermo Rodr=C3=ADguez <guille.rodriguez@gmail.com>
>
> Merged to i2c/i2c-host.
>
> Thanks to Alain and Pierre-Yves for their review!
>
> Andi



--
Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
