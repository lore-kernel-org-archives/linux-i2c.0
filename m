Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415A439340;
	Wed, 12 Aug 2026 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536755; cv=none; b=H6p0dMzU1Yd/analAkjXS9KQlB9YF9dHOBEGHTinJZEx3lFjTV7ESRzg/JF/XWPvc93IsFm0+j4QganwOzR4P1gQmy1WePAlEYnOIqJJ6XONjh27W59JJv0vq0OuWnNvgOPRxAk5rp23HFEG+Drs4JJv4G77A71ayocVtoNXiT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536755; c=relaxed/simple;
	bh=tqIiakRRDWjE+Gl4QvMZSq4lHphrMScZEp1ZMTHjiY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/dmhLrxq7PXjcF4xSxTBpO0UGUefyFLl/8c6SpIsIQOsE+5/bOKv6dFEPBYZeBf/jya14ddI7f1zXf7+kUAvhj3yAl5UIBKHHyR09HbBZx1w/oLF1n1ZUlyp4OVukTovTKrCdHxY4vcA+VtF4cQK6Bn9BhrcWsUmdbnHM1EOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB908v0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB908v0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBEC1F000E9;
	Wed, 12 Aug 2026 12:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536753;
	bh=BFr1b3XKoASNppcZOacgydZ2RfYw4c/j+xtAQvGKO+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KB908v0b/JUI8pDAe7WW0RzX6hOzEFh0sXccF/SInx+LFcrtAkHUahhhcmK7psChI
	 uDcc0vl2qnckvwCbXfRq3i2bgVJe0Intd1zOvx13jK4FI26/L0V4nQz3ZtbWBlIaqn
	 +6CuqpRaEnceQtrw9pBtHpNqq2JdvEFJrJxPEldY6jRi4BnMlJcbcwZUz/m73Yjp5y
	 64Wjrv5bOHUfeR3yhWTyEzDQ2KeJgTTdXV4b8ewt959ng48+hK4bkyP5IhIM/YmLFg
	 pWn9d0ZV6A68t1Vq/4YnQ6zTpCS4qP82NphDzaPfNyAv4ES2oRpciCaqQuoDV9RZmk
	 4qoFEbVKuPolw==
Date: Wed, 12 Aug 2026 13:12:30 +0100
From: Lee Jones <lee@kernel.org>
To: Ming Yu <a0282524688@gmail.com>
Cc: Ming Yu <tmyu0@nuvoton.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v6 6/7] mfd: nct6694: Introduce regmap-based transport
 abstraction
Message-ID: <20260812121230.GP1072730@google.com>
References: <20260701035025.3082927-1-a0282524688@gmail.com>
 <20260701035025.3082927-7-a0282524688@gmail.com>
 <20260709092759.GC2045740@google.com>
 <CAOoeyxXgqfts9ytFEYLe=jCpBkPaPwrzwTBQX3oTsTME90CEBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOoeyxXgqfts9ytFEYLe=jCpBkPaPwrzwTBQX3oTsTME90CEBw@mail.gmail.com>

On Mon, 10 Aug 2026, Ming Yu wrote:

> Hi Lee,
> 
> Thank you for your reviewing.
> 
> Lee Jones <lee@kernel.org> 於 2026年7月9日週四 下午5:28寫道：
> >
> ...
> > > +/*
> > > + * A few firmware commands (e.g. the I2C "deliver") transmit a request and
> > > + * read the reply back in a single transaction. Model this as a regmap read of
> > > + * a SET register: @buf carries the request on entry and holds the reply on
> > > + * return, so the firmware exchange stays a single message as before.
> > > + */
> > > +static inline int nct6694_write_read_msg(struct nct6694 *nct6694,
> > > +                                      const struct nct6694_cmd_header *cmd_hd,
> > > +                                      void *buf)
> > > +{
> > > +     return regmap_bulk_read(nct6694->regmap,
> > > +                             nct6694_cmd_to_reg(cmd_hd, NCT6694_HCTRL_SET),
> > > +                             buf, le16_to_cpu(cmd_hd->len));
> > > +}
> >
> > [Severity: Medium]
> > Are we misusing the regmap API by passing an input payload through
> > regmap_bulk_read() in nct6694_write_read_msg()?
> >
> > The driver handles command exchanges by modeling them as a regmap_bulk_read()
> > of a SET register, passing the request payload inside the buf parameter.
> > However, the regmap API strictly defines this as an output buffer.
> >
> > This currently works because regmap bypasses bounce buffers and cache for this
> > specific configuration. Any future changes in the regmap subsystem, such as
> > initializing output buffers, enabling a regmap cache, or adding bounce buffers
> > for DMA alignment, will silently discard the outgoing request payload.
> >
> 
> On the write_read finding: it's safe as-is (REGCACHE_NONE, val_bits 8,
> so val_buf passes straight to bus->read), but I agree the read
> semantics are bent for this one request/response command.
> 
> Would you prefer I keep nct6694_write_read_msg() and document the
> in/out contract, plus a note that this regmap must never enable
> caching, so everything stays behind regmap as you asked in v5?
> 
> Or would you rather I add a thin transport helper just for the
> "deliver" command? That reintroduces the ops-style you pushed back on
> in v5, so I didn't want to go that way without checking first.

Please don't re-introduce the driver-level "transport layer".

Yes, if you fully understand it, document it.  If you know of a better
way to handle it that is within the bounds of Regmap, then please do
that.

-- 
Lee Jones
