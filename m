Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610290;
	b=bsFOUz+CyNAViRfpmCWLHtfmicOwXcPG807Jx9rjPykFcvqI1HfPVaaGxa63ztfM3Av+
	 imM6Bebi5PCQ7MOrQyTjHCl4EzenU9ZBDScghY76k+g2xcohgneZZhfxYjycAakucWop/
	 aXJ5Q4KnRNS9888EuVndkcNA7nisn1J5UdyV6ciZzH3v9n8OP7UKwop5JF2kN6N1ZdPIz
	 HAadupeqzhPjw436Sb49k4am1QOGGFgiaB9YyS4Pg49TcRPqH12JmzKm4qfLEzDLAbtvW
	 AkIMUkABopAq6D1n7SI4cjgvxsbejTZ+sFilSdWA1DWIw96yOceMIVdZu8eyErmRrew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6OMMDQTVoFYMkW/indxgds3s7rWaF3OYRrED5RcBC8A=;
	b=3krPvtciLIVQxqAylL/v8tH+Ce07FI3foh1sYIycv2IEOSNXn5xNovrdits/r/xthBZ7
	 2SvQaPSXqtRRBqbm3VsFXijx4lbA5OgOsd+w3O45kGDF2WWGS0J0rLfwX8AR+BgsLvcU/
	 MAXb1bSNaoH8vxpJgZqU9XzLELzWdsgJJ9z4yRcAm2dN/fCZ4SzXPjCMJg00ulHz0KlNx
	 f3H9ka1lDs53ekrqvp1p7PQLvlqMokOfx3BpBYcUzbAzHqAQoU9sE6i0/jlpYaXeZd6Gt
	 KAjBpQnq7cw8Am8KdUWzfT6Nxd+U5l75ik/ki7UWMYqwpJyipoSR/MgoELoXZ3ADcug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GuY/VUVA";
	arc=none smtp.remote-ip=74.125.228.71
Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA24606A332
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 09:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA24606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GuY/VUVA
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6b189af3189so2316212a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793610288; x=1794215088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OMMDQTVoFYMkW/indxgds3s7rWaF3OYRrED5RcBC8A=;
        b=GuY/VUVAezJtbfFdh33XY8NJxSfDBqR48lh0LAsVjL1ogF4222zSGkl2BA82PRzjqr
         jz6w2/X0EfHrvTbqSHz1jLNFNpsvN54eYsQatClkI0wZdus+gR0hk4d2xu1qa24GXnTi
         hoCRWhPSQV2Ad8hsVP/J+TcSSxWX6EC22skDu74YBgH96et3RTz/1TaROzFKi5XVyHSd
         Yi2U2pCjiZO+CVMdSBmQe8h8j8Bu3wRDjMLPSWDDH8VXmCUeA6bX6W1PwnK/IYdErP1b
         SkxEupLZ/BgBwZNFw0yhCdK2QUbBxG3VVO+j6szdGslz8QT+skiB9DDUZP3IUjSfXR2c
         cd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793610288; x=1794215088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6OMMDQTVoFYMkW/indxgds3s7rWaF3OYRrED5RcBC8A=;
        b=Pdxhcu7jyMZibQmrOdLaDNygR8CSXRx2wXA385BW9c3H+VqhM8FO3He4U8X8qsuCQy
         hccvJnqBuGXRhgnKMvIfF8AbDPLlnhXsdfoPRc4z2azpZK1orclOrD4v/Kg09toi9cvE
         gx2DGP/KqekG0P0Qi6JAarAUdk3XHls5G4UZBmv6EkA55niM4z80D3u5cBQyk5pLl/Qp
         6Ur1/uLSvVeOiN0JhatEZHQe+D/VnFcJI5uU/j8aJ5WJP+sKRG/+HvzwS/YKwciaTrc0
         0+bRnKULptkvXwZPwDl8gzjh10VVEyiLchW9bPUNryXS6YImv5htCJbAs6MBxWJzPDGf
         ZesQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDa9Y5c5jKmQtHIu1++9ZkykepEwmmGfYDwIFwl1oDoBrCxE/YszhVg9KwoA4tNfeQWd0HDpgNDjs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPbOaR47G0PRbl14JbEr9GvCJ0SZSomNxrB1mZiDoI0sjrfS0m
	5WzXzxinsUrsdnA6762JHwkNIu+XgsYyiqLET+KpACLljJCbUPYipla5
X-Gm-Gg: AYBFou0KVi+oL8iAFHmjZgx/I1Xe0Xty8yqHwJOY3GHzZ+XfoIIk4HDb1nSxRYhRDse
	EWLdBokth/ZUyQvFQRY8288EkyDBujm/26FinE3rVmrmPpQyt1ZCMfr+FV5qQ4bMm09StRINl4y
	MmU+Ex5Orw14Mzc2J3Ws0sU+gmDQjgwbkkOt1zbtfEs4iYP9Ka7viupRpaCcPbt/W/OiDD2hLh3
	aW1jMA+B9Sg4mndAr/DolXenGZ4qhdHP2QjgOBt4oYNfGmPfUO+buaX0H26Ibl8yx3Qp41Zv8w8
	dh6qLUvlmCLx+sTFk5a4ZXKjPKIX5V3EQwB6M53OZiFpbfxw4rg+RizxQM/pTznnoTRgyetOCmT
	k7xY1QYjvJuiEZXoKsgqZnHo0/L6ob3tnHTjS8KRD5SubwyoKqv62FmcJkehgRijTgfW9Baf+Ur
	TmpZdYhcDQVGRCN/D5D7xOcX1hUoVeUKYmC19ndq7o0aEVEBIt09IzeepkpzgIGsFPKmnH1NlA2
	Lp0L1ySFbHwksq0N1aJDVgqefF2i5RFlJym7uoQwxzWIWJUxePCE7uBi3PEcZZxqo9dg0dRcviQ
	1b5fjXJJuwlTta/8n/APeFknVWkjhcumEv/d+X91lZ6C+Jf7b00cqHagetB3oaSljf4dQ4IaiLO
	5u1PDVaVRCJmW5aAW52GdE1pnC5W7k3v0msridQ9sFSeLJQTOD7opnvk=
X-Received: by 2002:a17:907:7212:b0:c2e:3f49:df04 with SMTP id a640c23a62f3a-c4ca793bcd1mr730834266b.1.1793610287846;
        Mon, 02 Nov 2026 01:04:47 -0800 (PST)
Received: from thi-server.fritz.box (dslb-092-076-089-226.092.076.pools.vodafone-ip.de. [92.76.89.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabf15694sm358429266b.81.2026.11.02.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:04:47 -0800 (PST)
Date: Mon, 2 Nov 2026 10:04:45 +0100
From: Thilo Zirnstein <thi.zirnstein@gmail.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: michal.simek@amd.com, andi.shyti@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
Message-ID: <auhSLVHIh8mv-KUA@thi-server.fritz.box>
References: <20261016125229.1798791-1-thi.zirnstein@gmail.com>
 <20261016125229.1798791-3-thi.zirnstein@gmail.com>
 <CAKfKVtEOOGsJSV0_im=-0u=N=fxkDuCMnAzt=1ZfBs4A4rg_0g@mail.gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfKVtEOOGsJSV0_im=-0u=N=fxkDuCMnAzt=1ZfBs4A4rg_0g@mail.gmail.com>

Hi Shubhrajyoti, 

Thanks for your review.

On Fri, Oct 30, 2026 at 08:16:34PM +0530, Shubhrajyoti Datta wrote:
> On Fri, Oct 16, 2026 at 6:24 PM Thilo Zirnstein <thi.zirnstein@gmail.com> wrote:
> >
> > Use non jiffies based waiting functions,
> > if in atomic context.
> >
> > Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> > Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-xiic.c | 28 +++++++++++++++++++++++-----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> > index e68e17bdf0ba..fc9a0628cb67 100644
> > --- a/drivers/i2c/busses/i2c-xiic.c
> > +++ b/drivers/i2c/busses/i2c-xiic.c
> > @@ -359,16 +359,28 @@ static inline void xiic_irq_clr_en(struct xiic_i2c *i2c, u32 mask)
> >         xiic_irq_en(i2c, mask);
> >  }
> >
> > +static int xiic_poll_rx_empty(struct xiic_i2c *i2c)
> > +{
> > +       if (xiic_getreg8(i2c, XIIC_SR_REG_OFFSET) &
> > +           XIIC_SR_RX_FIFO_EMPTY_MASK)
> > +               return 1;
> > +
> > +       xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
> > +       return 0;
> > +}
> > +
> >  static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
> >  {
> > -       u8 sr;
> > +       int rx_empty;
> >         unsigned long timeout;
> >
> > +       if (i2c->atomic)
> > +               return read_poll_timeout_atomic(xiic_poll_rx_empty,
> > +                               rx_empty, rx_empty, 10, XIIC_I2C_TIMEOUT,
> > +                               0, i2c);
> > +
> read_poll_timeout_atomic() expects its timeout argument in
> microseconds  the current one is jiffies. Can you check it.

Ack

kind regards, 

Thilo

