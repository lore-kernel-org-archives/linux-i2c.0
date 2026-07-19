Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C7038D3F8
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470083; cv=none; b=cwJrtj2F0qLWptrPCUnIfj1lsHwqZOtxA3Rc/1+yVcJBDfLIQByXv5qWsMpb6A4YMP4SBxJfNI0ivFffqFqSJYyfUDuZJU5zLrxlfoW1T8gmByFEBZsyfFoDyds9TT2Eawa50gA8sBuwULdiBB+aYmVe6bbYtoj+1AMIsGde10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470083; c=relaxed/simple;
	bh=9DwiF9IdEisrQm031eI0iEyPpeWjFiGOio82h+Gg4/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6IE3iV3iKnj7UnP6wqIthWc5b7/bSoG5Jm43iC4OHw5eRkKH9KapYX5WLrHyYKrCBUF6QNJQwfk2DY2/OnMM0c5CqJNXw6CVju3q9nYYj2XyoQdofke/P4VUsABgn/LlgcIXfAxJ067tiT710pwRnouNojk79Kg6DRSy1KQxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBxyfAwA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBxyfAwA"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39ca0a30148so76153971fa.3
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784470081; x=1785074881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hviuhQxk9tmkFzbE+ozJvymbpZxDhoz38nMQh318+So=;
        b=eBxyfAwAg/ui9kYVOj9qrEyS3BuwhQ2DU+EAkMKYqMXb/UzhBJGH9T/LN8aYcK+GYL
         5OnaMduvL+jnG9nAGOfYtItsOgVqPVJVvrQqltmoI4BfJtkTZrHTH4xgnO5daE0DDisn
         o+N0lsTsERjD7FHc3GlfUzHM5erhTBPgQniiC1r7ebWWcOaMhrusKAicpljvbZEyCnGJ
         4Sz7O9IwELAgALNksezIOiHazWE3XmlQKBfS+tLOTHS5afIeuiFIUZby2Ew9yXfyn774
         VDrd8ALzPMUZbeQiZIMn3SPhEFpspy+cR+hqXGSKyuFp8HnZnf1IP4aNrWnLXZWrYO4+
         KAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784470081; x=1785074881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hviuhQxk9tmkFzbE+ozJvymbpZxDhoz38nMQh318+So=;
        b=AVJtUWRlN68C5I8yrB/ZDmgrc6cf938vVufMM16Miv4soQOMVPh1yya9T7CPxOKCb8
         qZYl7EonJ5uVGiVxaibe03LhXZ/GB+aXTbR4EQ1fq5l7QU8PtatVNiBPCtm7KYTS6BzL
         47uogGvTCdTrEcFI4RANQ6fnwS1kdGoWFdbnLREmd1l8u4+eSHJJg8H1ivXfJ2waTCYe
         oAg0kTnEMP2x8shUdDIBfkBLVyQYOLEH1DAE7T5t0qkxiDYTFuRNJ1aD0ShW4tYCwxOd
         XaTYSVWC2HAd2e6NWPKqWVuDjxWpRxm9iF6asjElUeJ+plOjqb5w7EhFpGshK+7QporT
         HLUA==
X-Forwarded-Encrypted: i=1; AHgh+RoqUt2MJ4m/O4HU8PRB9GkzD8RH86WIIEW2UKCdDXuBrhqMrkQUcIJyERaw5cT186+ouhpn8xqoC68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Fb57OIxO9QbTNeygnupp248cUFetHo0HU/oEZRwOnd0iZrrD
	tJqZVOdf1UP8Gynz/5P8IGC0t3T1RyBjFydW5wq/CsGIRne1/F9Ei5FbTIMVf8D69qg=
X-Gm-Gg: AfdE7clk8wDTm+Ce1vtwQD3Wv1MqkeExNkVmnfNvPucA1nkD9Dk9o4DuctXPPrwjfl8
	4sNv7qBgELpggnec3ykiOmC14Ugtl7oE1k9+bpK0r3j+JZIN3WXNIEKVecGymu/Awzn172oWMuS
	cm7ZtlH31ETT0WSlutI8ZkLuX6S4sty9pDWb3/bbp2YX9Sej+BCzRZ8g34X0+QDprSvJa9y36am
	L7KhWrpZ/kj5/P3+dy0OYdlrvY/hcuDMumiRDP1rBiHoEO9FhBoQgrRwXM8KVrApw+oALthjP2z
	2TSdAuyUVSoCqMZpxaf6eOTiJrvsChj8RMnJSMqWv9pP9E5XlFd1yN5O3FHGsN2Uh8FSfOCIPUG
	2SoZSUtYAdJkTq3dgkK9TRtvvy2qqVTwDFT4nFUeuwSpLF5DtxQE93v96wGYjpuacE78gYMJaTW
	rEXqV575xY2aEdYmca31sQC9vufjn2SzPOGskbzYQ=
X-Received: by 2002:ac2:5fe9:0:b0:5ae:b489:b844 with SMTP id 2adb3069b0e04-5b28f9acaf9mr1417664e87.32.1784470080335;
        Sun, 19 Jul 2026 07:08:00 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e2480csm1794315e87.72.2026.07.19.07.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 07:07:58 -0700 (PDT)
Date: Sun, 19 Jul 2026 16:07:55 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 2/7] i2c: mux: add idle_state property to i2c_mux_core
Message-ID: <alzaOzSFklfpN18u@gmail.com>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
 <20260713-i2c-mux-v11-2-72bb8af8ee8c@gmail.com>
 <e2d4fdf8-4dae-43dc-95ae-b9aa1884fdf5@lysator.liu.se>
 <alfZYOKCjf6CKN6i@gmail.com>
 <c0b47180-d3df-4b58-9311-d02734213716@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b47180-d3df-4b58-9311-d02734213716@lysator.liu.se>

Hi Peter!

On Sun, Jul 19, 2026 at 02:39:34PM +0200, Peter Rosin wrote:
> On 2026-07-15 21:02, Marcus Folkesson wrote:
> > Hi Peter,
> > 
> > On Tue, Jul 14, 2026 at 01:29:01PM +0200, Peter Rosin wrote:
> > > Hi Marcus,
> > > 
> > > Sorry for the very late feedback.
> > > 
> > > On 2026-07-13 09:19, Marcus Folkesson wrote:
> > > > Muxes treat their channels differently when idle.
> > > > Let the mux core have this information to make it available for
> > > > internal use.
> > > > Reuse the same state values used by CONFIG_MULTIPLEXER.
> > > > 
> > > > Possible idle states are:
> > > > - MUX_IDLE_AS_IS: Leave channels as is when idle
> > > > - MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
> > > > - <n>: Enable channel n when idle
> > > > 
> > > > Default value is set to MUX_IDLE_AS_IS.
> > > > 
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>


[...]

> > I think I will introduce a few defines in i2c-mux.c then;
> > 
> > 
> > #define I2C_MUX_IDLE_UNKNOWN	(-1)
> > #define I2C_MUX_IDLE_AS_IS      (-2)
> > #define I2C_MUX_IDLE_DISCONNECT (-3)
> 
> Hi!
> 
> Please keep AS_IS as -1 and DISCONNECT as -2. Using different
> values will make it difficult to get rid of the use of the
> defines belonging to the mux subsystem in case the actual
> value has crept into some .dtb or something like that.

Got it!

> 
> Also, I think the right thing to do is to put these defines
> in the i2c-mux.h header so that the drivers can find them.
> I assume .c was a typo?

Yep, it should be i2c-mux.h.

> 
> > [...]
> > 
> > struct i2c_mux_core {
> > 
> >      [...]
> > 
> > 	/*
> > 	 * The mux state to use when not active.
> 
> This is not 100% accurate. The value stored here is never
> actually used to set the idle state. The idle_state here is
> only what the driver has declared that the idle_state is.
> Perhaps word it like this instead?
> 
> 	* The mux state used by the driver when idle.
> 
> Agreed, subtle difference, but...

... even better. I will change to that.

> 
> In the future, drivers (most of them) could be changed to
> use this variable to store the actual idle state. But, as
> mentioned, that's not easy for i2c-mux-gpmux since the idle
> state is under the control of the the mux subsystem in that
> case.
> 
> Cheers,
> Peter
> 
> > 	 * Possible idle states are:
> > 	 *  - I2C_MUX_IDLE_UNKNOWN: Unknown idle state
> > 	 *  - I2C_MUX_IDLE_AS_IS: Leave channels as is when idle
> > 	 *  - I2C_MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
> > 	 *  - <n>: Enable channel n (starting from 0) when idle"
> > 	 *
> > 	 * Default value is set to I2C_MUX_IDLE_UNKNOWN.
> > 	 */
> > 	int idle_state;
> > 
> >      [...]
> > };

Thanks,
Marcus Folkesson
