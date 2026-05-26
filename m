Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C82030A
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824875; cv=none; b=iSCEucnRb0xiSWo1EyXohccQOBIF9VLXtWjqnn65Syw9gmulhmJWNqZg7wW2EJ9KNG2cwHSQ7MIMokv0MwRjX7LgWdccdXrR3MC8xsbxw2+EhXAjESpiTzNuxOxwCVxLg82/RIvj2GihkLiS28NyAUBO8j82gLuTvkT9xJkh/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824875; c=relaxed/simple;
	bh=dyISjKvoMcq6OFFmmRq+N2Uk8bxqT3aVh3eZQ5TE/IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON1kKCkQyrTe7tkULqwf6zl0BimAj1JBelK41EhFLAK2sKDSeszdJtSPcoBGjjgRHPk3FX9By4RnuZ446fG4YmoXKzKN0c2XXOuM3sexCRyabYTYuFFdjDTO4N9IWi00/GduhCQGlRWBS66bhscMUv5O7V5BZMEWb2KwpZyMlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Pm1FXxNK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Pm1FXxNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=yHu6
	1V9glS/Y4VHMiUleiLB3zLNBd4rcjKVPWNimHUk=; b=Pm1FXxNKnGU6CCHHZm0Z
	7o46lu3vYQzXzPorLDSse0cHtyGWfIn+OSCg5qA8BngoLL6PE9qkn8rAZzN3PqhB
	bQ27AUqzoh6cjJxY+8MXa9Yv79TMfBxgANsZvX4+G2dSTN1+B1VHxKKX4ImKtTCd
	aok2REIiE9bikt9m2rAxA9V0nqVeW2aM0ciboQJHG7ihpOWk50trcYdtQCv5Yeza
	xAC4+PiSz+HzUUWPkVtIuBR3PT+HNn7zAo2Fvok6gpa80eD6S92zLdKbhbChtWRz
	+Mf9fQ3zsaus4YYbmfDcq0XD/b4lcXXyk9HjaLG5ZPsauovq5GCrPYcMD+1QISRK
	4w==
Received: (qmail 387587 invoked from network); 26 May 2026 21:47:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 May 2026 21:47:48 +0200
X-UD-Smtp-Session: l3s3148p1@2/gExb1S4VOSABpf
Date: Tue, 26 May 2026 21:47:47 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/5] i2c: core: add callback to change bus frequency
Message-ID: <ahX44_rzaRlTLSLU@shikoro>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-1-5292b0608243@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-i2c-mux-v9-1-5292b0608243@gmail.com>

Hi Marcus,

finally I found some time... thank you for your patience!

Some comments here, but I have high level questions first to be
discussed in patch 5. Maybe we should start there...

> +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */

Shouldn't this rather go into 'struct i2c_algorithm'?

> +static inline int
> +__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
> +{
> +	if (adapter->set_clk_freq)
> +		return adapter->set_clk_freq(adapter, clock_hz);

So, Sashiko mentions[1] that setting 'adapter->clock_hz' below is not
executed. This is fine in my book because the requested new rate might
not be the actually used rate. However, I agree that it must be
documented that the callback is required to set 'clock_hz'. Or maybe
even better, the callback should return the newly set value and this
function then updates the variable?

[1] https://sashiko.dev/#/patchset/20260324-i2c-mux-v9-0-5292b0608243%40gmail.com

> +
> +	/*
> +	 * If the adapter is a root adapter without .set_clk_freq() implemented, this feature is not
> +	 * supported.
> +	 */
> +	if (!i2c_parent_is_i2c_adapter(adapter))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Update the clock_hz for non-root adapters, even if .set_clk_freq() is not implemented,
> +	 * to allow the clock frequency to be propagated to root adapters that do support it.
> +	 */
> +	adapter->clock_hz = clock_hz;
> +	return 0;

So, Sashiko is IMO correct with asking what happens if setting the new
freq in the root adapter fails? There is no path to restore the old
values for the children then, or did I miss it?

Happy hacking,

   Wolfram

