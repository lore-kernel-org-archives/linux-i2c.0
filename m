Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD13F0AA4
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586093; cv=none; b=uGI6hDRXolrGTSGXOMML4MVKJzISnZxnYk0vZ2dcKJXRU6r6rRBg7b5PWQ6B6mx/eZHLfvSAa9K56QpOZqS+E1JhLrg/k1Y6RqCSAE5dCdinlp4VbQ/r9Gpfg46oz8cSMplJeU7I1rPpHn/+ORbscDzgp3GqaW2ilHBQkk3rVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586093; c=relaxed/simple;
	bh=v5m77H2AqJJ4tTbaOUw+5/3V+CtMKGQKg5H4OPgb+WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+URzXiBMd9jXoE6wZlwm+7BW9iGoxAl2gQTMdU3KbIz3wqqhAURsXrYpWuKRL0HLnxd3mEDPTRdm+JYJaWP5D4oEHD6mKWhosU8KfYYK5+uuuD1llDCcPnY5wDsYU1LCOE8k8/+X8ucvl5AOwNlfrsqfEik2dOY9E+f6932ELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaT15KMz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaT15KMz"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b015b2d792so713966e87.3
        for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783586090; x=1784190890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THSFgL0Y2FKUJgLIXJuUKx+xnsBMsYVZ+QMA86TDiMA=;
        b=kaT15KMzYBo6KDRBn63AAZhPmvK0VO9ZDI5Q/1J0yuAPUEt2iJhSOQenyM7YAFNmtp
         29+f1F4J0T62q1W/VUMBDDGxXUIkun2t2BJFb2eSTMFx0ARNAaqSpyNy7Ls3PHOb86e0
         Sg8Mv2tLV4Z4xCpDLHDdla3JoCG+O8IE053grvBh242HaOPftjlEwlcEe2lyhfOoI7Nl
         zr5kLNOWqdiamRFlmT0s1IYCxeH/y0k0ooheHaf5P5OMYr8OtYZy5dBYvDO49WTnkO4w
         LC+QRY6tJnHCSbfyWBEEo7EOMYT9dGj2Aa26Pue+JKnvKVXUkSHnV6UzmMPM8bxDHaFj
         mftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586090; x=1784190890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THSFgL0Y2FKUJgLIXJuUKx+xnsBMsYVZ+QMA86TDiMA=;
        b=pmxKeHq0nuFMlCsH9UU9CoqKJ2GeR8Il3iuCc3VKoCUvMauXKq7IjglwN0v95+5Lcu
         suE82BobMriIeJGC0zDVgHvxP0AXyBl62lqV0+ZYogjhhBLaGmCXThG4waXqTKjgqmzT
         12vsI5iIa4U9oXg/YMPHnewjG0GlR3a75X7BwRYNlVHEKQvcvXnX6RWG04Pj3XsGCY9P
         6VNqHszCbGnvG/FEiG9X6ORCVNKTzflUxriWepo0jmStwq03HCE/JS6p5ZU+SOVE9prb
         03N+0LNkoQOcqleBpyG7GYSB5gHPF9YYxfwWu0QPYdJQKL8IO4GQhHLkEFY5b71ouX+N
         GO9w==
X-Forwarded-Encrypted: i=1; AHgh+RoeUXfMaWHzLtzFTtxAmRh01+PjHR3pAEiynPxDa2uigGC55EzwShv3v8P1fHsl9m3+EINlf1y6pj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzffKlJTNkiNGReUWqTw9I05B6UBFyfSUeePHEW8J5LgWrWyCV
	d7cOqmFQ4osbcHq+BsQ74yP5giN+pavcj8EJCFs/Oh216GDpmBBpA9Ih
X-Gm-Gg: AfdE7cl0IVFbI00BmcEVUIDBot5HdrlC3Ovw4BfOi8JebY1riJLwnjVbzr8OfS/wLkb
	e5TIlK2qYRZaKqj0JbKjriXiDUJodNDuIFXIjQwKN8TjyrrzQgoyUiMG0QHzF4VXGLMYmH8gkEs
	sIidXon2rVHc9TzqdlZf39yd7pCFM9g7G5dratQ4A1p297vLeuKIkLywT8ne5Kok8FTfJwsKoi6
	MC2csWzkBjTSxgiYVOuwBYXlQkIA+Z14ikGRmgagI6GWEKf2alcr88EqXh2sA8+xxHDlTtNQBwM
	3W5rlplYwtJVz4vy8gMlrNAlWHkDSs8XxmOtftEW3HJiyVqNn+HdpnotipN2ps1aAkunMLValn6
	2TTXnLN4XklYh0VDAuA4HESVzWv/voyzeyLjCchQ5W3r12vAatq8D9uW8a0CO2bYSYCVJnrTX4M
	VuRjb3xV5slnsQ5yYBgoJMEEpNe5XebaebQ7Gly4YwCR+PufljXw==
X-Received: by 2002:a05:6512:159c:b0:5ae:d399:ceb8 with SMTP id 2adb3069b0e04-5b011472e03mr1731318e87.56.1783586090129;
        Thu, 09 Jul 2026 01:34:50 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c3a15sm5082954e87.68.2026.07.09.01.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:34:48 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:34:46 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 4/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <ak9dJm5GVfCOqAsU@gmail.com>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
 <20260708-i2c-mux-v10-4-09dca03c8a15@gmail.com>
 <ak6lWKWDM8XwqLgw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak6lWKWDM8XwqLgw@ashevche-desk.local>

On Wed, Jul 08, 2026 at 10:30:32PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 08, 2026 at 02:16:16PM +0200, Marcus Folkesson wrote:
> > The bus frequency is unnecessarily converted between Hz and kHz in
> > several places.
> > This is probably an old legacy from the old times (pre-devicetrees)
> > when the davinci_i2c_platform_data took the bus_freq in kHz.
> > 
> > Stick to Hz.
> 
> ...
> 
> > -#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
> > -
> 
> You need to rebase this on top of the i2c-next.

Thanks, will do.
> 
> ...
> 
> > +	/* standard bus frequency */
> > +	unsigned int		bus_freq_hz;
> 
> While at it, I would dare to suggest _Hz as we started doing in IIO (id est
> we start following more closely the SI units in the suffixes of constant
> definitions and variables to be case sensitive).

Sounds good, I will change to Hz.

> 
> ...
> 
> >  	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
> >  	if (r)
> > -		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
> > +		prop = I2C_MAX_STANDARD_MODE_FREQ;
> >  
> 
> See above about rebase.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
Best regards,
Marcus Folkesson
