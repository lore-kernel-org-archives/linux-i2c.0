Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A513655FD
	for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224144; cv=none; b=roA+RIukQAfHpex1tvuHLwZsKn4PJvdQZ+yJR2cJv6Mb08o5jTzPPGY+XAPC1WWBnneDRzL/EDicgYChIVYrkK0mJ8lHQc2QjEF1WOCQcuNY7vWBD2nZlp9CJmDnoIdnWsp9RP1swSi7UKNBBQuQ0edLCku2XPSx04g0D+V6UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224144; c=relaxed/simple;
	bh=IocCa73rf7kw/jZJ8Wjphwt1PovjtrER/bBR1M7xXNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVN9bGlY2aSwXn3GdD6NN3TRK6uXuQB8uaN13yYFaccx1cKvKfoNIaTIQcUjgSwMsycKg8Z67oQuN2I8QDRwoJ6Y3I2cfI1Me0sl3TQ8PlFSZuwPsUIi2XviiOJ5z2bP8lZ/N3ku6lDBaz7SFUv4C0j0ZrAPUGioU0EUif87/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pp/Qht4t; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pp/Qht4t"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-396770cdcfdso5198851fa.0
        for <linux-i2c@vger.kernel.org>; Sun, 31 May 2026 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780224141; x=1780828941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=INehRWTHTBM1ilUwastePElIHNWnGH8n+SvXXUnd6iA=;
        b=pp/Qht4tG5f2xTyd9OCsMDBpGHCyX56saBZPfRPlezRY0y3djtDwTZgn3PbfNX+0rN
         uoyNpF8FQc1zC/W6iGDmYTGSZ4P2C5NyTAwW3VyHO3AUgqZWNUVINFD56mamC6rc9wo3
         zLlo2Bf9Se0F2pVwjcIpGVAclNTe0kKzh1lYpAcDZM0WnLagy06kSAnAh9vjldueThy8
         +xgmbn7gr31CTozhPptZGTrnpYY3unvj5U1EyEFrgWm7IqF0eg5eROxwSogdFjUWGGLf
         EDwiGG0p+t6C9HZTX2VW6v1sKxaE2+2gGB5BiWOjdoDXV4XvwsRdvaWb5m4auagLF8y6
         zWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780224141; x=1780828941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INehRWTHTBM1ilUwastePElIHNWnGH8n+SvXXUnd6iA=;
        b=QAO5Zp763Yh0Xrk4bNlVMf4BjFOw8UciXMZlG3i4dT/B6aaJ5vyBp2rAmt0naetkNq
         kJVMKq3Km5bbiRQOdmU2INURRMzSYLX4ZTVFGDgl1ccpVPeN+6E89vYYijP4RlC3L8AL
         yG+tdtxPlQYiSSWDMovg2aA2kP3vb9dfZCKULQQm74pP/N2mNS0tbCzyxFibAwe5phhm
         5VEyRT/DytgwyJ08LbObv0d/V1dQSwKAOIHJXfT6h5noqT7qh4JSqcDYo1FngITDhlih
         LgASDsZuVngd/x6EiCauiCDpXBOD9fRiXXqZ6ZuRrb7QnD3UKuvvdujR1AzKKHksJ2yr
         reMg==
X-Forwarded-Encrypted: i=1; AFNElJ+IESkzqjKmB+l/B/cs3F/i2wgfybLloVUO6suZk0mpr5nBNbzSrlrN01tuBia4GaQfRblMHHOCxPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbC052V0+Zy5liAYv6s8RsonmaSJOpODPbPDwI0DLg6pH2UNZ3
	8qtuuvQcatdlH0WDJeU9E2ZouDXmhzDTRpGSzDODRS0oZ8xzwGTckAwz
X-Gm-Gg: Acq92OEpsbbVYYIi03yeo9VoU8H+TZ3HR1DgaFfU1SC+u00XzO45FxthEqOj8/52iT1
	Kwjr4pdEaxQqHrNIG9LbmuI8KNGbEFeyYhBiSifjqDpONJKKzzWSf4t8sk7bj5fecb5td/eZsg5
	ah0geK91n1nP8uLA0mHep004GrOSDPopjdBbXP0rczjhbzNFkg4eEMFx7egUbIQIq3HogVG26+D
	lNdLN7qpmRiWshiHFqmVTwaQYXL+R/QMdIU50zkp4xUB9gaucL6+5czhKSd9asEXMq1WafGK/zY
	1ShlsvDSISx0ONqFh4fj6mtWOfuIVTvAba7Rq9LfiUaBqAtt4d/6/oUD07/VGQSFxLB5NuF5uPA
	w4kg6Bjcs1f1UCXWP7q4YveBMoC09fKI/y2F6JIHci68CmaXLDXJYvG/thrYaS66HwN8spkIcEO
	pbWQxKK95Yxmyf20CAlKijVLrHSLw8J+iPIeGeiTzvhzTjfbC86Umxmdesnbi/eaDG0gmKhzc=
X-Received: by 2002:a05:6512:398e:b0:5a7:46f2:9860 with SMTP id 2adb3069b0e04-5aa608ec07fmr1928751e87.20.1780224141104;
        Sun, 31 May 2026 03:42:21 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b07214asm1480110e87.21.2026.05.31.03.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 03:42:19 -0700 (PDT)
Date: Sun, 31 May 2026 12:42:16 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Message-ID: <ahwQiJAwsPl2uJ5M@gmail.com>
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

Hi Peter!

On Sat, May 30, 2026 at 08:54:51AM +0200, Peter Rosin wrote:
> Hi all,
> 
> First off, sorry for being so incredibly slow in getting to this
> series.

No worries!


[...]
> > > +Consider the following example: ::
> > > +
> > > +                          .----------. 100kHz .--------.
> > > +        .--------. 400kHz |   mux-   |--------| dev D1 |
> > > +        |  root  |--+-----|  locked  |        '--------'
> > > +        '--------'  |     |  mux M1  |--. 400kHz .--------.
> > > +                    |     '----------'  '--------| dev D2 |
> > > +                    |  .--------.                '--------'
> > > +                    '--| dev D3 |
> > > +                       '--------'
> > > +
> > > +If the idle state of M1 is:
> > > +
> > > +- All channels disconnected: No problem, D1 and D2 are not affected by communication
> > > +  to D3.
> > > +- Last selected channel: Problem if D1 was the last selected channel. High speed
> > > +  communication to D3 will be "leaked" to D1.
> > > +- Predefined channel: Problem if the predefined channel D1. Set predefined channel
> > > +  to D2 as D2 may handle 400kHz.
> > 
> > ... unlike here. We have MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT defined
> > already. And I'd think we should only allow bus speed switching for
> > MUX_IDLE_DISCONNECT to avoid out-of-spec scenarios. Opinions?
> 
> It is probably not unwise to disallow MUX_IDLE_AS_IS in this context,
> at least until someone actually needs it. Which does not seem all that
> likely?

I agree, I had this in my first iteration [1][2], but only as a warning
though. 

Maybe I should reintroduce `idle_state` again and only allow
MUX_IDLE_DISCONNECT?


[1] https://lists.infradead.org/pipermail/linux-arm-kernel/2025-September/1064986.html
[2] https://lists.infradead.org/pipermail/linux-arm-kernel/2025-September/1064987.html

> 
> However, it seems like it should be fairly OK to allow a predefined
> idle channel, as long as that channel is not lowering the bus speed
> compared to the parent. But maybe supporting that can also wait for
> an actual user?
> 
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
> 
> Cheers,
> Peter


Best regards,
Marcus Folkesson

