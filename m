Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B424887E;
	Thu, 29 Jan 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697534; cv=none; b=KZ5QDEYy2zXD5g9ytOTrHel5p+bSIOMGWDXoy5EAuPaifvZUQtMl3zYqy7GR72O2jsIZFoCouELVMxA5//7lbupxq+iHJtpSUKC/hJsHfreae5rQ8vDN/vjXNjGGa4QVdgdcW47ZhY/ET35dqYpDZsOaokLDwsmyNze841O0QbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697534; c=relaxed/simple;
	bh=J0CXaR9Xv5YMEu9lpIeArNADiWmdVJJkiFyMfktIAKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7w1hga87kzXKW1qL7Okj8tZMxnP87G0lQ+yWK9bDhx481ef406okybX3/Kw1qZf3dUIJ+SHjtmPY4i8YXRwE1sRf+uenRxhcsEvWqUZZR7Ma81gxA/BUmqhnE9sXKhIy2ugCTR1CXGbdxMNga2DEYZfHb5PprEU2HOHY27Es94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WbnsN7PG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WbnsN7PG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769697534; x=1801233534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J0CXaR9Xv5YMEu9lpIeArNADiWmdVJJkiFyMfktIAKM=;
  b=WbnsN7PGJaaFycTLppuna32ETQkIrEvVk+YG19xuRg2JP2cu49r6ZEZC
   ZZnCVSxz8P01SvT3tcfiP9AVm3iY3fR2I108udZYFYACSUNNzF1dzXGOe
   kZn5p5X0bszIMDxLpSCSVBEfiveg0fALlxWw4I8egvSLWB9SwV8IEBDAX
   1jwmcTiq4WxT18uzAWcPafNk5QgdU2BVlEOaqc21/hUKx63CVfPutKaNq
   vDJm/UhFej2n3rwzdRjgX0qOU2nI7NasUbhbyeEtaRqEc9TyHBdwr3o6D
   k6m7uvuh3MtIxu7SKQ2xmNiiXCUfshqhlKYLMNIWHBckfWMMjIoLFpPm8
   A==;
X-CSE-ConnectionGUID: +Dt0Y6cyQTuzuPO9xDe8Hg==
X-CSE-MsgGUID: QddSZY1lT5m2ozRhjc7+HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="96401232"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="96401232"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 06:38:53 -0800
X-CSE-ConnectionGUID: mQJ0XTNXR/eGlwmM7QaAwA==
X-CSE-MsgGUID: gW0mzCeKRs2s9OLL4qA+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="213552921"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.155])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 06:38:49 -0800
Date: Thu, 29 Jan 2026 16:38:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <aXtw9h8WUs5H9MgC@smile.fi.intel.com>
References: <cover.1769476820.git.zhoubinbin@loongson.cn>
 <402121da829497fc97f1461c8aaa3a44252c3f06.1769476820.git.zhoubinbin@loongson.cn>
 <aXh000kBfaqd1G9H@smile.fi.intel.com>
 <CAMpQs4JTqWr6AqRwEO9bcno-_MjjE8GKm_kUvrpy7m_tLMtuSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpQs4JTqWr6AqRwEO9bcno-_MjjE8GKm_kUvrpy7m_tLMtuSQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 04:07:06PM +0800, Binbin Zhou wrote:
> On Tue, Jan 27, 2026 at 4:18 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jan 27, 2026 at 10:47:57AM +0800, Binbin Zhou wrote:

...

> > > +/*
> >
> > It's not marked as kernel-doc, but looks very much like that. Why?
> > Same Q for *all* cases like this.
> 
> I didn't intend to mark it in kernel-doc; I just wanted to comment on
> the variable.
> Is removing the `@` symbol sufficient?

But why? If you want it being properly documented, make sure it follows
the regular format.

> > > + * struct loongson2_i2c_msg - client specific data
> > > + * @addr: 8-bit slave addr, including r/w bit
> > > + * @count: number of bytes to be transferred
> > > + * @buf: data buffer
> > > + * @stop: last I2C msg to be sent, i.e. STOP to be generated
> > > + * @result: result of the transfer
> > > + */
> > > +struct loongson2_i2c_msg {
> > > +     u8 addr;
> > > +     u32 count;
> > > +     u8 *buf;
> > > +     bool stop;
> > > +     int result;
> >
> > Run `pahole` and amend *all* data types accordingly.
> 
>  Moving 'stop' from after 'buf' to after 'addr'.
> >
> > > +};

...

> After run `pahole`, the structs are reorganized as follow:
> 
> pahole --show_reorg_steps --reorganize --sort -C loongson2_i2c_priv
> i2c-ls2x-v2.o
> struct loongson2_i2c_priv {
>         struct i2c_adapter         adapter
> __attribute__((__aligned__(8))); /*     0  1064 */
>         /* --- cacheline 16 boundary (1024 bytes) was 40 bytes ago ---
> */
>         struct clk *               clk;                  /*  1064
> 8 */
>         struct completion          complete;             /*  1072
> 32 */
>         /* --- cacheline 17 boundary (1088 bytes) was 16 bytes ago ---
> */
>         struct regmap *            regmap;               /*  1104

It's better to keep pointers like clk and regmap next to each other.
They are semantically coupled as "resources".

> 8 */
>         int                        speed;                /*  1112
> 4 */
>         int                        parent_rate;          /*  1116
> 4 */
>         struct loongson2_i2c_msg   msg;                  /*  1120
> 24 */
> 
>         /* XXX last struct has 4 bytes of padding */
> 
>         /* size: 1144, cachelines: 18, members: 7 */
>         /* paddings: 1, sum paddings: 4 */
>         /* forced alignments: 1 */
>         /* last cacheline: 56 bytes */
> } __attribute__((__aligned__(8)));

...

> pahole --show_reorg_steps --reorganize --sort -C loongson2_i2c_msg
> i2c-ls2x-v2.o
> struct loongson2_i2c_msg {
>         u8                         addr;                 /*     0
> 1 */
>         bool                       stop;                 /*     1
> 1 */
> 
>         /* XXX 2 bytes hole, try to pack */

>         u32                        count;                /*     4
> 4 */
>         u8 *                       buf;                  /*     8
> 8 */

Also think about it (don't blindly follow the `pahole` automatic mode).
This is much better if you move the pointer to be the first, followed
by a count, result, and others.

>         int                        result;               /*    16
> 4 */
> 
>         /* size: 24, cachelines: 1, members: 5 */
>         /* sum members: 18, holes: 1, sum holes: 2 */
>         /* padding: 4 */
>         /* last cacheline: 24 bytes */
> };

TL;DR: don't use `pahole` blindly. Use the common sense.

...

> > > +static int loongson2_i2c_wait_free_bus(struct loongson2_i2c_priv *priv)
> > > +{
> > > +     u32 status;
> > > +     int ret;
> > > +
> > > +     ret = regmap_read_poll_timeout(priv->regmap, LOONGSON2_I2C_SR2, status,
> > > +                                    !(status & LOONGSON2_I2C_SR2_BUSY),
> > > +                                    LOONGSON2_I2C_FREE_SLEEP_US,
> > > +                                    LOONGSON2_I2C_FREE_TIMEOUT_US);
> > > +     if (ret) {
> > > +             dev_dbg(priv->dev, "I2C bus free failed.\n");
> >
> > > +             ret = -EBUSY;
> >
> > Why?! What's wrong with the error code returned in ret?
> 
> I want to indicate the bus busy state if it times out.

This is not an answer. So, why do you remap error code. What's wrong with
the callee's one?

> > > +     }
> > > +
> > > +     return ret;
> > > +}

...

> > Ah, it seems it's a helper. Please, return the error code from it as int and
> > not irqreturn_t, this will make things clearer.
> 
> How about just define it as void:
> 
> static void loongson2_i2c_isr_error(u32 status, void *data)
> {
> .........
>         if (status & LOONGSON2_I2C_SR1_ARLO) {
>          ........
>                 msg->result = -EAGAIN;
>                 goto out;
>         }
>         if (status & LOONGSON2_I2C_SR1_AF) {
>            .......
>                 msg->result = -EIO;
>                 goto out;
>         }
>         if (status & LOONGSON2_I2C_SR1_BERR) {
>          .........
>                 msg->result = -EIO;
>                 goto out;
>         }
> 
> out:
>         loongson2_i2c_disable_irq(priv);
>         complete(&priv->complete);
> }
> 
> and in loongson2_i2c_isr_event(), I reference it as:
> 
>         if (status & LOONGSON2_I2C_SR1_ITERREN_MASK) {
>                 loongson2_i2c_isr_error(status, data);
>                 return IRQ_NONE;
>         }

> Its return value is meaningless for loongson2_i2c_isr_event().

Works for me.

...

> > > +     u32 possible_status = LOONGSON2_I2C_SR1_ITEVTEN_MASK;
> >
> > Split assignment...

> > ...to be here, which improves readability (no need to go somewhere up in
> > the code to see what this is about.
> 
> ok, I will put  `possible_status = LOONGSON2_I2C_SR1_ITEVTEN_MASK;` here.
> 
> > > +     /* Update possible_status if buffer interrupt is enabled */
> > > +     if (ien & LOONGSON2_I2C_CR2_ITBUFEN)
> > > +             possible_status |= LOONGSON2_I2C_SR1_ITBUFEN_MASK;

I expect something like this:

		/* Update possible_status if buffer interrupt is enabled */
		possible_status = LOONGSON2_I2C_SR1_ITEVTEN_MASK;
		if (ien & LOONGSON2_I2C_CR2_ITBUFEN)
			possible_status |= LOONGSON2_I2C_SR1_ITBUFEN_MASK;

...

> > > +     strscpy(adap->name, pdev->name, sizeof(adap->name));
> >
> > 2-arguments version is even better.
> 
> Sorry, I'm not quite sure what you mean by `2-arguments version.`

Use 2 arguments instead of 3. I.o.w. just drop the third argument.

-- 
With Best Regards,
Andy Shevchenko


