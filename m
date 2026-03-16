Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0EB3ACEF8
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679656; cv=none; b=rLfwlnI+Q0bEZuvRolOuMQnuPKLJJ23Sx+xY8CodHHhbpMT3t42X3FD7GlJW6ZXt4FWroXWHnOeIm/EBrDR2oWekYXYKvrtXz9AkB2kS1c57/Kw8L8IjHe37P9YDjf7hCTyPuHyKbRwBIWP0NZMUmp//CCNQQcQruWmAhDEi084=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679656; c=relaxed/simple;
	bh=+rAbjFpJLF5ELTGsyzXHo5dgEzatb5tWHpqXy6BTmYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNghMcshWfRCBcrLnhDhMGxrwOeRgWeotAkQ3997j/aHuhFeVGkcalEm1ntK5N+zPkoenCKVt6IjObie4LONGlr6o3OagCy8kQgXqOblI5SnnSNXfuVgF65Fx3wAp+iV0/aMBKmgMZPudkUWAVCnzPnS+rNxc5UsnWxnNyID9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGtekfTq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGtekfTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B224C4AF0C
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 16:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773679656;
	bh=+rAbjFpJLF5ELTGsyzXHo5dgEzatb5tWHpqXy6BTmYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cGtekfTqFvVrF7VJ1xDN/03QTDPDcdo5LNi8MIeHSIezK4Gd2z+GQ94TdThe3wfdg
	 6+jwBMmOqzF85kgS9jF7LvwgP5JGWXJpkAzraz3vFcajQZUHBvO0WRYzQJE7J0Ytmi
	 Gwi/li0g/v/vcXP34ZAq++FsOnJ7YYiJJNUFiQULiaw3n4kJ58eE6KrMSVjMGnsO4u
	 IMN7zeBsIcQrt2UTsOQo2nDc2fI+SGolMG21oQW9QYbqop+gZh52CvuNSngMbBymF3
	 pYqZPEns6Yy1LnHWMLVS9x1ZnrWuY6XLupN9bxQWg7FscMFBB3zIghh1qubhnfJmuf
	 WBpxVo36e6R+A==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b96f02b4329so860724866b.2
        for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 09:47:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOc8hzeh/S1gtIUxQtTxn/wIcjHAeffSI8x+O3S/Lc0es8+grZY47U2wSUBm8eSn87fNXaMREk1lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzypu/af6LjVTs/hcXYzhM4/a+VEE06wmRkZiI7Mt7GZ+xM8S1Y
	riBuyR0fokqK82KirEY+Q0tospXN6lfTOFeElfK0PJ0eqFXjB5altG2+OnFPjBVZSlMfC4pupRB
	egpL3BukGHo4hHluRm+gLuJS1GYLVsw==
X-Received: by 2002:a17:907:708:b0:b8a:f2cb:8088 with SMTP id
 a640c23a62f3a-b9765392113mr794224266b.33.1773679654788; Mon, 16 Mar 2026
 09:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com> <20260313232125.GA3618633-robh@kernel.org>
 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
In-Reply-To: <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Mar 2026 11:47:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
X-Gm-Features: AaiRm51ex9uUeaeovsj_EfQkcC7S4igdlkgu0QdNDXmYleGKXTFGbzYmU6uj8IQ
Message-ID: <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
Subject: Re: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 8:50=E2=80=AFPM Jeremy Kerr <jk@codeconstruct.com.a=
u> wrote:
>
> Hi Ryan & Rob,
>
> > > > +  aspeed,transfer-mode:
> > > > +    description: |
> > > > +      ASPEED ast2600 platform equipped with 16 I2C controllers eac=
h i2c controller
> > > > +      have 1 byte transfer buffer(byte mode), 32 bytes buffer(buff=
er mode), and
> > > > +      share a DMA engine.
> > > > +      Select I2C transfer mode for this controller. Supported valu=
es are:
> > > > +        - "byte": Use 1 byte for i2c transmit (1-byte buffer).
> > > > +        - "buffer": Use buffer (32-byte buffer) for i2c transmit. =
(default)
> > > > +                    Better performance then byte mode.
> > >
> > > Good, I like worse performance so I can use byte mode.
> > Thanks your review.
> > Will remove performance statement.
>
> I don't think that really addresses Rob's point there.
>
> The selection of mode is somewhat a driver implementation decision (and
> so would not belong in a DT binding) - *except* that there are
> considerations around the use of hardware DMA channels, as covered in
> earlier review.

Am I supposed to go read the prior 25 versions?

> [My understanding is that the mode needs to be defined here to select
> which i2c devices have a DMA channel allocated to them. I also
> think that byte mode may be useful in some scenarios, but that
> consideration certainly does not belong in the DT binding spec]

But this is selecting DMA for the bus, not specific devices. I would
think the decision would be dynamic based on some xfer size. Certainly
if the xfer is less than the buffer size (32bytes), then there is no
advantage of DMA.

Or do you mean some instances of the I2C controllers have DMA and some
do not? If so, then ...

> So, how about we refine this to *just* the hardware-specific component:
> whether a DMA channel is allocated. A driver implementation can then
> select the appropriate mode (dma, byte or buffer), depending on
> implementation-specific details.
>
> In that case, we would just have a boolean property, like:
>
>     aspeed,i2c-dma-enabled;

... yes, this is fine.

>
> - to signify that this controller may use a DMA channel. The choice of
> actual mode is left up to the driver implementation.
>
> Rob, would that suit better?
>
> This way, we don't have ambiguity on "buffer" default vs. absent
> property, and we're no longer specifying actual driver behaviour in the
> DT.
>
> Cheers,
>
>
> Jeremy
