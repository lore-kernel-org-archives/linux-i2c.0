Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769C39B947
	for <linux-i2c@vger.kernel.org>; Sat, 30 May 2026 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780132635; cv=none; b=nHxn29qd2NuOQuO2dcOeK2HoSC4XO3UuZ3s+8Brvy32K1W75CvOL/cOPEw7bKCLbNSL63A3dT3P0K6aeFUxAJV7lFCbjQQed9RSSQ54rMeMXuV1ES+fz8RONkHSguu5qw90erXCsanV8eYGBA9mr/NDHm6xwFE9QBkbT+YXRL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780132635; c=relaxed/simple;
	bh=6pPZWf/ZI+KpbIxcPon8S5FgeqDvzfA0U15hbqnIMUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqcAMyODZlCw5EKsgf8qkOFLW8uk8sanAi+p3YYA04bKw9P9seJuIST8XBqmFuvHiD8JNbLgnIE85QHxKWVcQ7+AacohfagpeUVxV1+6mlaoQgV0XLZcUoQxcX6F+g93KZ0MXnBFOHZLNAFXQ1kbfgxoKIdW7yjVif9jSoAA0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HcwBzck3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HcwBzck3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=5Tz7
	bz6dX9G948lnWkl0CzkG89ZjwO69Hb6Asux763A=; b=HcwBzck3MSSjwprJqLpb
	D7oSe1xJTw5vsdWcMeKaMqKdFlEj1kEJeN6+7pyPGDPbfq8GgIhIUIAtgo3B83g8
	BJLkjZM1PmtxjFq/7rlOYZQo/A9Vub3g4YCBY0f1DtBGABRlL9qcTZZxDVBDUkB8
	crsJwfVH9yvaB/NgwXJenfkROx6JsD/Zu3RuOFDnyA5PaE2fXhJ68XVP7yZipdbY
	K0+30PQlZc8TP0qtdqsigcjpJI7hXekHeLoL+BYJkN+xQUyev/mqOaGkKG8Zxx2J
	aH5smIjF9LBRvRrKPLB4C0t7QjH0BZQWkmS8ysJE+7i4ZUYWJg/cs9JeDhf3/z/Q
	jQ==
Received: (qmail 1702015 invoked from network); 30 May 2026 11:17:05 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 May 2026 11:17:05 +0200
X-UD-Smtp-Session: l3s3148p1@yyHJbAVT4aKSAB1K
Date: Sat, 30 May 2026 11:17:05 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Message-ID: <ahqrEe_m4K4T7LaC@shikoro>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-5-5292b0608243@gmail.com>
 <ahX4_WaqodYt3PmD@shikoro>
 <776cefab-fa6c-4092-8b95-236a3eaac729@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776cefab-fa6c-4092-8b95-236a3eaac729@lysator.liu.se>


> What makes the topology bad is D2. Without that device, it should
> be OK. So, the question is which is more important?
> 1. protect ignorant system designers from creating a topology
>    that includes problematic devices like D2
> 2. allow multi-level mux-locked muxes with variable bus-speed at all

My take is: as a generic operating system, we should try hard to
maintain a reliable system. If a device gets stalled and blocks the bus
because of a too high frequency, this is really bad.

Now, if this is a flaw of the HW design, we can only do so much but not
more. If the HW design is OK, we should not introduce risks. This is why
I want to disable this feature for MUX_IDLE_AS_IS. It cannot work in
this setup, but the bus itself is likely designed OK and would work at
the lowest speed.

> Checking the rules at run-time feels complicated to me, as devices
> may come and go. Also, naming people "ignorant" over a mistake such
> as the above in 1 is perhaps not all that fair. But, it feels sad
> to disallow things that in fact do work.

Like I said, as a generic OS, we should play safe. If someone wants to
implement a more risky version, it can be built on top of what we have.
This is agreeing to "I want this and I know I am on my own now".
Obviously, it reduces maintenance burden a lot.

> > ... unlike here. We have MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT defined
> > already. And I'd think we should only allow bus speed switching for
> > MUX_IDLE_DISCONNECT to avoid out-of-spec scenarios. Opinions?
> 
> It is probably not unwise to disallow MUX_IDLE_AS_IS in this context,
> at least until someone actually needs it. Which does not seem all that
> likely?

Exactly.

> However, it seems like it should be fairly OK to allow a predefined
> idle channel, as long as that channel is not lowering the bus speed
> compared to the parent. But maybe supporting that can also wait for
> an actual user?

I agree as well. I hope that Marcus' use-case is MUX_IDLE_DISCONNECT.

> > > +Supported controllers
> > > +-----------------------
> > > +
> > > +Not all I2C controllers support setting the bus speed dynamically.
> > > +At the time of writing, the following controllers have support:
> > > +
> > > +============================   =============================================
> > > +i2c-davinci                    Supports dynamic bus speed
> > > +============================   =============================================
> > 
> > This paragaph is easy to get outdated. We can document that only
> > controller drivers with the callback function implemented will work.
> > People then can find out if that applies for their driver...
> 
> There are other such hard-to-maintain lists elsewhere in the text.
> Not saying that this makes neither those nor this list a good idea,
> but it is an explanation for adding one more.

You mean the list if a driver uses parent-locked or mux-locked. What
about putting that information into the driver? The core could enforce
that it is set to a meaningful value and not left uninitialized?

Happy hacking everyone,

   Wolfram

