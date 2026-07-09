Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2573E7BB1
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586035; cv=none; b=Fbq8OfjVdkTHPZZRWb5oS0grtxH+18vNdaif7Lgadh7+vX3WnWx/sATwu2fS5WIuweRdf5UoUeplKjrCSFfK2EHFOQTeaVBURVTvWBbvXn1mmtBxMQGIZ76jTi7u8phjVuufa7RzdPI4LFmHmSJRCZWb1OTi3j+oHV8eeKK+WOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586035; c=relaxed/simple;
	bh=TPRtn6A80Mn/spKxDN6QBMjTm4oZsTH6ypctlg8LR78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7PJyFypInFczkM0M8EeaJ1R/xrznfdmxW9zjdYAxbIkF4/0WwHXJyjRau7RXWM7er93/JHRfphyWKzNxMJCRw9UAcpdbsINgwohcaCbOV7gOfkcBbVact7acdfeJAQLU1VP+bvDU25Ns8h12LbveppDZpiqToa5+IyUzvwKg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxgBy87m; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxgBy87m"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b015532f7bso878972e87.0
        for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783586032; x=1784190832; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TPRtn6A80Mn/spKxDN6QBMjTm4oZsTH6ypctlg8LR78=;
        b=hxgBy87mO/L89009V7kbXaoRLq+pPE8TxGLYW0sXZNYGj8T+Qav4yFAB766jF6rMCz
         FPd4iRNgmU+42gD3ZOwnxVCDnYzAFQ2BlH4nfHigTVJ+wn2GuD0LDho4YXJ15HuJcWd1
         ku13hD6VTcJydc3nxSgcPX+mIJmxOv2UeBy6/fQirkkeo88gEZXGHSUPKtMfcerylPPf
         s+vyKZLLL2OHHcpaNOSrCk9rHuffGvPh9uU9gq/nWU+rOkZR8hWBlIUcdOTGDWuwT8rC
         438N8/NVMUCplYDC7mS6sZfP60onuQLGpGNMs8kkHUdDs0XmrIrK2YQHJSpefUFy6uWD
         knfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586032; x=1784190832;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TPRtn6A80Mn/spKxDN6QBMjTm4oZsTH6ypctlg8LR78=;
        b=XdbUXotbl3DmDsApPaIpP8ckJYW8ZGA1dz+X61g1vlRW9N/YYV2sdCxw+mAZOm5p3C
         Ac4igMACM5GuRkNi7zWKqVRdFVNqE4vKN3xUFkl+seP+4fYELGdlmkjry/vDO9dX0geO
         hv33gjZ9Ky+rbxC9Mc2SeHlvxIol7UECG6nwYebdud348hjhrKHGZ2okcp/UixDHiVTp
         ByHAIBScqKrykiqbL9UmmZXiFJV84xvrr6mYtx09Amtmmc24wQafAr/DTfMTV9LLYo2r
         CXjNV863GS3lpzLmJ891TmDt+abL7YtErLW7Kj0OXjFkjo1f8ESJCYTYWsJSkP/PDNJ0
         xVrg==
X-Forwarded-Encrypted: i=1; AHgh+RoXt+569KYwb+0JirYEsjSiWeAy5DVFUnYjOKdHUR1olznocp8OVsv5TsqcYPtLt9s4IhnAtkyCucY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmv4d+siPuiWnqZU7vifS/CAN5KGUHWTo596WrSoW/j0W3l7Ht
	HS8pBPBB5bJtYK1SQ6Zey58J+bthOQXXbKqqeLU3mOAn9m+FHfRmd5IL8RULQ39KK9g=
X-Gm-Gg: AfdE7cnVJMbx1LDkKe+8GbflePPiJWwBuChTa9R9MJA1Oj5cAnC/xI+cFWCiGYhpsld
	KGNyUFBp0IIBPzTiiKJr8M71uUtex3uFTkcTmM7/RIYurnCIKQ51Tv9cbjhKa1hbh/Ti6B/XwjF
	KxpuUXnRn0z8m0LP56sYg1gcVwTAbnAlq2fBN29dxH88luaQkNbPw2WZV5gonhLzG2rQ8NP1N4o
	QcVcYSmWx7fnDrB0uxnHN3oFdxBqGkpwcSdZeSAjfIXEyIlwiQryr7xocn8zEoxJnP60WCDIFgX
	D+6ttjmd6uTBbUgzqiwLQBeWF7+Aoo+YzSEwPTbFC49fh1ccdzLVeABMJ2l1gmfNCrNg/wXyLnU
	Y5Mnt9p3RjVpoQqRXr64cVeb7lulQQ2ZiIwp+pwC/3M+Gi3AyvdxT1BVLZcvRoY8csGYQO09PCF
	g/0ndthNA/RuHQ46saOIgloi7aZZHvMF+JetM3hseQwjDaYJ3YdA==
X-Received: by 2002:a05:6512:3af:b0:5ae:bcf8:e7d0 with SMTP id 2adb3069b0e04-5b011477c08mr1015479e87.55.1783586031526;
        Thu, 09 Jul 2026 01:33:51 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b13542sm2253471fa.11.2026.07.09.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:33:49 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:33:46 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 0/7] I2C Mux per channel bus speed
Message-ID: <ak9c6nGBsgMTP099@gmail.com>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
 <ak6m6srzX8dd6_nT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ak6m6srzX8dd6_nT@ashevche-desk.local>

Hi Andy,

On Wed, Jul 08, 2026 at 10:37:14PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 08, 2026 at 02:16:12PM +0200, Marcus Folkesson wrote:
> > This was a RFC on how to implement a feature to have different bus
> > speeds on different channels with an I2C multiplexer/switch.
> > As no major complaints on the design came up during the review, I
> > decided to submit the series without the RFC tag.
> >=20
> > The benefit with this feature is that you may group devices after
> > the fastest bus speed they can handle.
> > A real-world example is that you could have e.g. a display running @400=
kHz
> > and a smart battery running @100kHz using the same I2C controller.
> >=20
> > There are many corner cases where this may cause a problem for some
> > hardware topologies. I've tried to describe those I could think of
> > in the documentation, see Patch #5.
> >=20
> > E.g. one risk is that if the mux driver does not disconnect channels
> > when Idle, this may cause a higher frequency to "leak" through to
> > devices that are supposed to run at lower bus speed.
> > This is not only a "problem" for changing bus speed but could also be
> > an issue for potential address conflicts.
> >=20
> > This patchset has been used and tested heavily the last months
> > on a custom board based on a da850 (DaVinci) platform.
>=20
> ...
>=20
> > Changes in v10:
> >=20
> > - Fix gramatics in documentation
> > - Move {__,}i2c_adapter_set_clk_freq() to i2c-mux.c
>=20
> Can you point to the discussion where it was suggested, please?
> It was like ages ago (too many patches to review) and I probably
> missed and/or forgot the rationale for that. Also if we move
> to i2c-mux, why do we leave it in the adapter namespace?

Hrm, it seems like the mailing list wasn't CC:ed for that comment.
It was suggested by Peter and the rationale to remove it was:

"
I'not sure it's a good idea to expose {__,}i2c_adapter_set_clk_freq().

Do we really want to make it so simple for random (non-mux) I2C drivers
to muck about with the bus speed? Any bus speed changes not coordinated
with mux-locked bus speed changes are going to be problematic. This is
shown by the discussion about D2 for the multi-level mux-locked example
(patch 5/5) -> it is problematic even when the bus speed is changed by
the mux code itself.

I think these helpers should be moved from i2c.h to i2c-mux.c.
"

>=20
> > - Make set_clk_freq() return actual frequency
> > - Reimplement idle_state (from earlier version)
> > - Implement example on idle_state for ltc4306
> > - Link to v9: https://lore.kernel.org/r/20260324-i2c-mux-v9-0-5292b0608=
243@gmail.com
>=20
> FWIW, I briefly read the v9 discussion and haven't got the above move,
> seems wasn't discussed there?
>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

Best regards,
Marcus Folkesson
