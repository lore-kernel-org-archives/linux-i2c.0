Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120C38553D
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655747; cv=pass; b=NTWtathRcboQKNkYPVhlmlzVdGco1XLGcvih968shMZsbk3R57HDwbS5T4hcYfpcIlTfX6qGwDHXIOwI4J2I+Nu9rEVMZWkFsn/15ahzoYbyk+jImfXk8Vspwf7PkzEJ4tfN/WHZvUmHTbTDBHvGAyeTXYgGS0PoO16hAzsSZ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655747; c=relaxed/simple;
	bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SC9jicYuA3cjaJPjraW+Q6S1beFPiji8CKVYNzofEjTznsprxQav27NxR5s4lulyo+thUIX+0j1lkJveM0+knDIuXRcXcfuNDU1ZqQEVrqXCPxLnsz63dVuOAac/Qv14hzkAYQcCvDRAtPa0/2SU2SwSnxaNASCdikRv5ngaJTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fp6d+grA; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp6d+grA"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59dd4b602bfso6054594e87.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 08:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770655746; cv=none;
        d=google.com; s=arc-20240605;
        b=TC14DCtOh5h5Lfx4H9UwG7srsK/q89tJp0bswgOoMM1WokfFMHrKujAUlzJzYa3lVE
         vH8hqWJPyN5frfydhgb0ygua/QvSOq3lxS91bQtliz23A174rzYo0A6D+BUX2vSqrpga
         s0jktCbOc5pKclK92r3BNTdOfgJRTycZEMMXj6zP5bEIBDUXDd7VjpOZzeDwD33w/K3L
         K81DUt2nK3Kj4ljcwRQmfjq/6CimbN1PG0Fe5RBIrxbTO9nLYquNnwPtXmYBlEFBt8qh
         yplMDZ7AaIFwTcXyqzK9+hQOl8cYObQn0WaO8oriRXi9KhVA1rMLEgpuXZ1ZXdPI1dUK
         9nbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        fh=ltcxXVpIi01Pw1eLY3SeEwpX35ePL9M6cPm09t5JMAs=;
        b=VPZnIeuWCSJi56EX9Xeco5UEc+hhdIRtefHsszSKLfg1F+3eC5UnVMsiD4psk1v5Cm
         3ZCo0eKaVLMy9F5zeK9Pvsw9DSRxxuTJQxl8uoY+6Pw4lQs/noKOI1Omp9o/VB03GUSw
         4oYQ5TY+KgrV1ExM4pWdf2dJdzDM8wRpe0ImLvRDGT4INDWLINu9Q0PzCH7PNOk7w8nM
         zGKzGI49rteDb4PnBLuNvQOp8Eh3JEnbX7X29Pgw4B+PAMcLdByFfD0gw/eWlsNigQAh
         BrCLUPfHlBeyG2d3I1Esrj6MS8sRdpVyFBEvQLPr5I9Ofu6QI7Mc3XdpB004g8KmceDQ
         N3Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770655746; x=1771260546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        b=fp6d+grAQEAUXI+9d4iDRz+MxzAqT7bV0sjxYFmSEfcykDarYrVxvozFsS6xn3NPla
         D13NVlYbrEpOUt6Fgfw2Hhg3EAQ3P5LztjmtSeVMKZrgLHpSEnBh+X4vcA0FiEvHsT4b
         GIt0L89iAoauEaCRY72qO76frNlCS72jtKXqSvbAwhd9hb6M+l/INDa9QADMeJCi6DSE
         jF1LrxcY7EBHBSDAkxKjszvskMnKrUpJEnuIV5xRQFSWPDNxQrrEP584vq2KsYwO+0jd
         3VDN+ewqwdYGbI6WqCFwWWsiHiH+9P2+ynsnm6YSFrvoYtKKWSJ0RwMSdbwVhRzTqyVA
         2MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655746; x=1771260546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e972ACE1KBb81KyEkGcx+64PEjeQZgX4SBpIgZiZ/gI=;
        b=h435Q9oYz0sSQOxbuek53FM2M86hS/WqGquRTM3mB0H9UEg9Mr5k2rdStXOPXxmZP7
         54DGRW/QbJLDD++NBMleJDUp5tR5NKPj0eIXBTHYHaSmWXmOlvJZUtj4CSfbawHjM0B7
         riuCTiu0mx/t0Yp7bF39/5bCMuS5wYez0tLROlsgQKOKvHXUgA4seJBdKi3Ghg2Hq+Tw
         FPTI+r1Ii+eSzXwZwlObJs+964CF5twuD+9uzvl+cJG2ZePCT1H1uiNYLxOPeIqX/hVa
         k4pPubl6N2h65MWuYvMpaq54QvJykUj9cQ2JWNTTcgwFUxc/nO1321n/NWWxiMYpmT0Z
         4EzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdimiSHRgwpfJxc/Sv2VupPbAMnWxcCwn7WxSTMZE9+njLInWvkN+pGXZCLxffIRR66GhWwM2r5Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9dUbGVMsVhntHK1Xo0m6sqkyWbtgu2v0p7aV0ghd5rqUGXK2
	x+QMa25HhLq/qRGEcBYPQGQeJF8HwgUB1KX4cHpPXOLZ7AtOQh4NAvudijQcfcXn1W7W2uiNSP+
	Tf7mgEVOFjK+nsQsk3pswJie4tRLEio00nuiS7EDf9Q==
X-Gm-Gg: AZuq6aLWrJ/USpw5ypDo13Ti88csL7c53UO+zBpP/iY6wEHo1uerLHSA3ZpqLxqLdN/
	lgZ074la4hVccQz+NZ5ZUySPWZjkK9hXKxYmfhDQbbmoYbJVu0nZpaSHzkiXSVNlSAO4XnCNt1p
	8EMbkRmSTDjIjT4vPCZUq4ZQhOxUyF7DvGvWqkRe9QbeM6ETxyfLxlcTkMnOn/hT9QWblF9/9EZ
	oYN3HeMLPKO8Fu3b8P2EBpGLpezozZ6q27XbpgiFZy5MUvmwqDIondk8dwLbbjbTIwKy7acgEW3
	6vWnpP/3PZV0P29iddB9eD9RTBhC
X-Received: by 2002:a05:6512:3c86:b0:59d:e589:c977 with SMTP id
 2adb3069b0e04-59e4515c13cmr3221840e87.26.1770655745469; Mon, 09 Feb 2026
 08:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com>
 <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se> <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
 <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
In-Reply-To: <793644d5-4d4f-8ee5-7fcc-369536801683@axentia.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 17:48:29 +0100
X-Gm-Features: AZwV_QiQvQ7mrYQqbOHRiTV98ZgKaltKf6NrojsLO3GMYCFwqcEgvdtufeaSCsk
Message-ID: <CAPDyKFqCveBs-_VcWCm8OCegbpwnW3=0iGa2e5KUNmSy3TMA+A@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 at 14:50, Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> 2026-02-09 at 14:39, Ulf Hansson wrote:
> > On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
> >>
> >> 2026-02-09 at 10:57, Ulf Hansson wrote:
> >>> I have already applied for v8 and it's going to be in my pull-request
> >>> for v7.0 in a few hours.
> >>>
> >>> Please send incremental fixes on top instead of a new version of the
> >>> series, then I can pick them as fixes for v7.0.
> >>
> >> Hi!
> >>
> >> Sorry for being late with this, but as the mux maintainer I'm not
> >> fond of
> >>
> >> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
> >>
> >> and would not like to see it in rc1. Can you prevent that some way?
> >
> > Sorry, but my pull-request and branch was already prepared.
> >
> > Please send an incremental patch on top then I can pick it up as a fix
> > for 7.0-rc1. Unless you want to manage this yourself via your tree.
>
> That unfortunate. The patch series has not yet made it to the next
> tree since it has not seen any updates the last few days. What testing
> has these patches received?

The patches didn't make it to next, for some reason. I queued them up
last week on the 4th Feb, definitely a bit of a stretch to pick them,
I admit that, but I trust Josua to help with any kind of problem to
show up.

In regards to additional tests and reviews, lots of people have been
helping out with this and we have also received patchbot reports that
Josua fixed too, along the road. Moreover, the first version of the
series was posted already in November last year.

As I said, let's fix any of the problems on top, it should be that hard, right?

Kind regards
Uffe
