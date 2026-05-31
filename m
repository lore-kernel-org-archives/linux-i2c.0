Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D7357D08
	for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222707; cv=none; b=YJFxFaBdQAJXE4Lan9yWf+YyrYoVCigesMUMuS40OS/4/xraeRTZM/LSbkaaA6kEVt5rA+Qy3jcgX6oygyPRvmWuMragTgCNPX26U3LTyZ2j6LtM2xbMeopQmNQyAKVd2gh17dkSgV9X7qCxZ0W/avOdJI+ivvD2n5vTSprohAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222707; c=relaxed/simple;
	bh=6pmOo4hPpgU1UDgVwFhbE+3Q+EAt9YB0MTkz9gFUMK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8wBsBnOc0dWBJsNoKUZTp3mJ4yQKNmfESmHvucwZMaxb5uWwgN1Y0lOuBESnzizXP7dxQrCq/MrRJnGfuC6xXb6gZM52/e6B7axdJkPd9vCzES+OGgrPfChMLlUDliAeeiJE73u/7uZkm3D+fWAxzXkJDOk26QsXsMfQ0eS63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa6AP2V4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa6AP2V4"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so8414211fa.2
        for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 03:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780222704; x=1780827504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7IVg0Z/GtE0lxd89186+RKNusAM87gZCU/HngUTh/E=;
        b=sa6AP2V4mrTpJ4u2OnJeIe9YKxQqlpSy9DNV5NMisDYHuhfVtdCqqTX8ZcAp8Hne8n
         4D1FHAcR0QAkLd/Hz+/v+uZBjOURXeV7p/Agz6DNSP95MZlWO46R/YNTw2KPRc4GYjEs
         tZGJ2lpB4fHtbzDPFF3GB5eArptcMCKitCGro/THnEnqbpmQ95kzUvAeWNF5R+ybCdmy
         g3p1T30auQ6X2mE0nFp734isuCXh7tACFWa6lBbNdhRDa6dkTL0ftSERd9SQzAM8gewl
         GfA4xTD1HzPAAmIzv1V9ihtEYZZtnV5YwmDAGdcKttBzE8VnBWr6O6TpoBuMbvpAfCNr
         AKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780222704; x=1780827504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7IVg0Z/GtE0lxd89186+RKNusAM87gZCU/HngUTh/E=;
        b=m3CnAo2rp7LD67tXBCyvmkHz1KX00nCEWqWL1rD+Q3rfJ6IZjY50kaj0Pvhe1FcbT0
         05mkMXfqnnO5nBLPB5sdXJO/GXvRkxP9hRQOhcxTKdpF2Nlqf4Dyu+eOTVvuonLM0Tx7
         6gS1OQDcxA1QNnE2dWBYpkfOfnZvxAO+C7W2dpYual7akoG1G+lOP+ADNBzRtLI7+15J
         SBixVIHBZaDh+68hkerZzj0aePhJwZEmjSW5tWRa6SWLkdcInFUsOnWdZIGfzG72Ls+F
         89hWhuTHNauQMGCiyF+4+zDBtG3WnzTunB6zAINGpri7UHVmjaJZcOnGmhraBKwlprkw
         3vmw==
X-Forwarded-Encrypted: i=1; AFNElJ8xsU8pCaMH6di+FFz98KsgJnl84XLcvbqCOGMygxZ+HrKQLkX+NF8KVeZVmpqtppjU9WEUsPmSzWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJa2IZJZAAdqIgbt3anE1qJIZrDYyF0mNuo8rBzfXKKeJFMf68
	hCEyyhCfa905iAAcpDU3O8i9z6ErC9+D+/phr27Q/IlmRlNTJ8eF0EyK
X-Gm-Gg: Acq92OF3tAWP44WMZAYt8xHcGOjWQ60hLMYfJy5QbA0v1QHPi0wUp4OlfweB3UV+qMk
	INo9FwtgL9VPCX+6TO1qV2MdkQOoMcLzpj9c9p/d2s//HfKGuxp6dtEyXtaf5FayJ6f9gxsuOQC
	UlEkZD3/1uGmc4pGvJ8u3D821YPUScx8cgA886nDRNLozmhn5IhX9xC4wLLm4ARTmXcWy0rsx0D
	8lC30Ic+tQM/6K8UIyQl6L7Kp604LoD1lFJKy2Zpn42ozB5Xm7XP9DyM8ypuUApWJX0rBqtxdPf
	DrOJ7+jAdl3Rc1w+jVMHAGcmUYBTo6F6yGE5ryQDi2z8jvpVN2T+QksnubQECWBZmP5THlWdW7Q
	m23kZJfjq35IpE2x6CRg63i6LBxwDxFb3VRZjvyZrGPoVPF5OwKVGNQZbndqtSwfAdRsdbn4SmQ
	gIJFl45hKQcHnObHzT8vr7vl9VTHa+ArMuUQO3RTeO3WnXPuqxjq98TTm/2pOvzt07QY3kBLQ=
X-Received: by 2002:a05:6512:308b:b0:5a8:80ce:ba55 with SMTP id 2adb3069b0e04-5aa607af794mr1763417e87.11.1780222704172;
        Sun, 31 May 2026 03:18:24 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39659e2966asm15125681fa.32.2026.05.31.03.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 03:18:23 -0700 (PDT)
Date: Sun, 31 May 2026 12:18:21 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/5] i2c: core: add callback to change bus frequency
Message-ID: <ahwK7XsUswya3F1L@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-1-5292b0608243@gmail.com>
 <ahX44_rzaRlTLSLU@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahX44_rzaRlTLSLU@shikoro>

Hi Wolfram!

On Tue, May 26, 2026 at 09:47:47PM +0200, Wolfram Sang wrote:
> Hi Marcus,
> 
> finally I found some time... thank you for your patience!

No worries, I'm aware of your workload and appreciate you taking the
time to review the patches.

> 
> Some comments here, but I have high level questions first to be
> discussed in patch 5. Maybe we should start there...
> 
> > +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_hz); /* Optional */
> 
> Shouldn't this rather go into 'struct i2c_algorithm'?

Hrm, not sure.
When looking into `struct i2c_algorithm`, it has no information about
any other state. 

Also, the `struct i2c_algorithm` is often shared between multiple
adapters, so if it had the information about the current clock
frequency, it will be shared as well, which is not what we want.

To me it feels more natural to have this callback in the adapter, but
I'm open to change it if there are good reasons to do so.

> 
> > +static inline int
> > +__i2c_adapter_set_clk_freq(struct i2c_adapter *adapter, u32 clock_hz)
> > +{
> > +	if (adapter->set_clk_freq)
> > +		return adapter->set_clk_freq(adapter, clock_hz);
> 
> So, Sashiko mentions[1] that setting 'adapter->clock_hz' below is not
> executed. This is fine in my book because the requested new rate might
> not be the actually used rate. However, I agree that it must be
> documented that the callback is required to set 'clock_hz'. Or maybe
> even better, the callback should return the newly set value and this
> function then updates the variable?

I will look into this, thanks!

> 
> [1] https://sashiko.dev/#/patchset/20260324-i2c-mux-v9-0-5292b0608243%40gmail.com
> 
> > +
> > +	/*
> > +	 * If the adapter is a root adapter without .set_clk_freq() implemented, this feature is not
> > +	 * supported.
> > +	 */
> > +	if (!i2c_parent_is_i2c_adapter(adapter))
> > +		return -EOPNOTSUPP;
> > +
> > +	/*
> > +	 * Update the clock_hz for non-root adapters, even if .set_clk_freq() is not implemented,
> > +	 * to allow the clock frequency to be propagated to root adapters that do support it.
> > +	 */
> > +	adapter->clock_hz = clock_hz;
> > +	return 0;
> 
> So, Sashiko is IMO correct with asking what happens if setting the new
> freq in the root adapter fails? There is no path to restore the old
> values for the children then, or did I miss it?

I will look into this as well.
Spontaneously, I would say that if the root adapter fails to set the new
frequency, the deselect chain will restore the old frequency for all
children no matters what.

> 
> Happy hacking,
> 
>    Wolfram
> 

Best regards
Marcus Folkesson
