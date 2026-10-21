Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611470;
	b=32L8FAvxWKKd7AeJeS71VHWV9hRU4wVaDGBiMuthE/+/XMDX+xgrACsGcX8+Ax+akiZs
	 cD1RIzwiec0W8b7zfE7AorWL1siffmFzH8jdkltKDDv3nmyPXK1MCh6lrIZl2qDJ5uA1K
	 bpYbulFRGqzfLCWfSEc7nzRJKFGP6dWoHWaFlglq69MVD+aguNx+3HsAvJdKt+I7erpac
	 3Na520NGamto/UdXfQBjefE+lxJvNXt0KGqYjji1O9MMb5oeOoC0Ryo24NjwgWTn4jOtY
	 4ug6peaTL09IRl/bJf6+e/F6bmbwHOGRIMkiSN8cXGFaPyL+sxKMN8kDj22iaYIrmAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611470;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=nPHHZPY8cs0Vhp5/Lv8tY1EjZTLznrizvwr8rpho+S0=;
	b=fL0Ip8rUOCEJmqoGPlsaa+zA6vHp8VNTUG7nLUo6Rgvhmn1YT8fhcqA/gYdn7wHDwNvr
	 PF7fGN2SKdEDMkiV6ifmt05Ke48PvHoT0Sjzeb2dCCp7P0EGjkYfrnaBONdwY9qqKZ9G/
	 pD/VBb1MddhO33Bq7wJ3yAKq/mjvitpOruTQ24GN8fFx4JxOWbtoD+IxyK8wn5vs42hWa
	 Q3I99VsNys80yZiU2VQPJ+ajiP+k4pCNEWW74mUrzwCy9wJZmG+NsFxRI2nkSGXKKNUUv
	 KKaziZXEHkBhw2+CJ3XtmwQtJTzkJFv9XGQyAjLQyPkfH+I30dKG6fthy/SMcdsZzXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=SbHt+epP;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B4606A321;
	Wed, 21 Oct 2026 19:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF9B4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=SbHt+epP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792611467; x=1792870667;
	bh=nPHHZPY8cs0Vhp5/Lv8tY1EjZTLznrizvwr8rpho+S0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SbHt+epPrJL4kZHSHMCppDe1r+sHIzSjP1VvW0OpukPvht1DclKmq12otuLuHR041
	 0RknQE8evxIKsn5MJifTVpKns/WOFvkdwWqSBxsTdYHu0tQGT16hcJCtwgjDzTYYuR
	 WvWfaJACJ74kU8Ql9tGDRFGp27dI+uSlk+1N17EOn5tY+tguP4w3s653zrmefLbzba
	 2V8/6uWQZX9lI0hEmmoX0v8hX5tpT2B62RxI9T/1aBZ4QQk89akhvnd3FcYb0fjfYG
	 hYG8+0tV3WlfZlFYzZ4zNy0ba/YTwOyZQkQvsfGUdQ5XUALHimN5bhqbAEbUvqPjDQ
	 gbVx3umMmHIIw==
Date: Wed, 21 Oct 2026 19:37:45 +0000
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Saikiran <bjsaikiran@gmail.com>, Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: qcom-cci: Suspend the controller 50 ms after the last transfer
Message-ID: <179261145907.36927.5158021314822941179@pm.me>
In-Reply-To: <CAFEp6-0wmUYhcF+_nv8U3WovxyHVJJFs1FWfN8xb9ogMOxpBRg@mail.gmail.com>
References: <20261020193946.51478-1-birk.skyum@pm.me> <20261020193946.51478-3-birk.skyum@pm.me> <CAFEp6-0wmUYhcF+_nv8U3WovxyHVJJFs1FWfN8xb9ogMOxpBRg@mail.gmail.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 36a95b9b0d8e66052e09ef6d37b56decf1c0c559
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 9:44 AM Loic Poulain <loic.poulain@oss.qualcomm.com=
> wrote:
> So, no, we should not rely on runtime suspend/resume timing as a
> workaround for this. That approach is inherently bad and fragile.

Agreed, I'll drop this patch.

> Have you been able to probe the CCI I2C bus during resume? It would be
> useful to see whether there is any activity on SCL/SDA and, in
> particular, whether either line is being held low.

I don't have a scope on these pins, so I read the pad levels from the
TLMM (gpio235/236, aon_cci) in the driver, on 7.3 without this series
and with SCL stretching on (MISC_CTL 0x133):

- When the controller suspends after the sensor powered off, both
  lines read low (13 of 13). The unpowered OV02C10 clamps them.
- At the first transfer after the sensor powered on again, both read
  high (114 of 114).
- At the 100 ms queue timeout both still read high (86 of 86), with the
  queue on its first command (CUR_CMD 0x08010339, CUR_WORD_CNT 1,
  EXEC_WORD_CNT 3, REPORT_STATUS 0) and IRQ_STATUS_0 at 0.
- After cci_reset() the next transfers go through.

So nothing holds SCL or SDA low when the transfer should start. The
master doesn't start until it is reset.

> I wonder if enabling SCL stretching support could help here.

It doesn't change it. Restarting the camera after pauses of 0.05, 0.1,
0.2 and 0.5 s failed in 19 of 20 cycles each with 7.3 as released, and
the same with Hitesh's change applied. After 1 s pauses it was 13 of 20
without it and 15 of 20 with it.

What works without depending on the autosuspend delay is retrying a
message once when it times out, since cci_run_queue() has reset the
controller by then. With that retry in cci_xfer(), the reset on resume
and the 1 s autosuspend unchanged, all 120 camera restarts started
(pauses of 0.05 to 2 s, 20 each). 91 of them hit the stall, and every
retry went through. The cost is the 100 ms timeout, so a restart took
about 500 ms instead of about 400 ms with this patch.

Unless you'd rather see it handled elsewhere, v2 replaces this patch
with that retry.

