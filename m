Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F94A53816
	for <linux-i2c@vger.kernel.org>; Tue,  5 Mar 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632101; cv=none; b=O9Bmmt0S2eu6k2RyoReWk15wWV97IazfzQgeA8yrCQUp/y42YM6wvQieiV+8fdYmy5laMTBAlfwPBTc0WQUfu/WZ2NKVp/JgtdLKwzeM+eZX5G/EQErfLGSJH/rj98JPTFazbj1jUuY3PuxxzJPqQTKMkhOlrSzOnWYFDWYzvcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632101; c=relaxed/simple;
	bh=zMP+w0Cfq42h/7Zxcdr+Gac62y0jdG9tdOzTgDnntpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0gmDH0JTcDEom95hlbCLX8RGi+hExaaDEQahLF1RB3ov0X9Ke2BcT3CyPyTMYpF+ub8wNRX61i1eIwvkgHsFFqj/cIADkyRtcuAvHQ3g76GF2fjGe1ugrKtA2bdPtbEbTOhimpDMmiXGlymNWN8rNYFudSW9BNIB46L2xcPz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if9DFU8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if9DFU8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF2BC433F1;
	Tue,  5 Mar 2024 09:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709632101;
	bh=zMP+w0Cfq42h/7Zxcdr+Gac62y0jdG9tdOzTgDnntpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if9DFU8k9O872BuvG2cAJNVMD8r7MQi+2pWcBKWcCLK9fCky0cHNJAquwnKv15Yng
	 eUNIz5EYMBEixytQjqIgQojCbQXmHVRrQybxsw4uqhb2Puk7/Dtdc7eqUIqOv9aSer
	 dCgvf18Nq+EKr0PYR7ALc8jfPdcJ4OIHYOA9deyzf+/B40018xCSHeQw5H4BxaFOtF
	 GzGC70Dzx29uxgiskzyKCz10PtGVrfk8qsmzWX8Kq6pDqkGKzJqDT7bdFL8UVC0E9r
	 F5gVHSNYNDms892gUijCTdR89BbFVKrBhEiFlY0X31EG7khWlAKFo3k8YvWW96ti+c
	 1PSvzXbLYccyA==
Date: Tue, 5 Mar 2024 10:48:17 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@kernel.org>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [SPAM] Re: [PATCH v3] i2c: i801: Avoid potential double call to
 gpiod_remove_lookup_table
Message-ID: <tmhdawkgkaxeg6qj556luilzbddq3vmqynpo54vd6lkaj67gia@7lyq5xofvpby>
References: <8d35529d-8ba9-4bdd-a3a3-00d67ab6f2d5@gmail.com>
 <CACRpkdb0WDyK7wnJ-z9KWteAp_epnfyXShGB==tzoVZxG9i0Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb0WDyK7wnJ-z9KWteAp_epnfyXShGB==tzoVZxG9i0Dw@mail.gmail.com>

Hi Linus,

> > If registering the platform device fails, the lookup table is
> > removed in the error path. On module removal we would try to
> > remove the lookup table again. Fix this by setting priv->lookup
> > only if registering the platform device was successful.
> > In addition free the memory allocated for the lookup table in
> > the error path.
> >
> > Fixes: d308dfbf62ef ("i2c: mux/i801: Switch to use descriptor passing")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> > v2:
> > - cc stable
> > - free memory allocated for the lookup table
> > v3:
> > - cc'ed Linus
> 
> My bug I guess, mea culpa.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for your review! I have pushed this patch only in my
testing branch so that i can still add your r-b.

Andi
