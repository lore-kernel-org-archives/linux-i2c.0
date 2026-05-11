Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D43CE485
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495326; cv=none; b=bdNXajnU/jEpfxqKCkY577C8IyD5V/ZclnrLMvxCI8IFDSpYqbhFI6YJc+Mou07MB0bBPRhC0iU80JMfe/Rhxgi7hZaGyD3J0g4oRc4ovQSYwY32wsGS+kmflwzh8o6VoeNMwce6V0x1yo1S16t/onAEjzVqi057pVryQE4mDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495326; c=relaxed/simple;
	bh=YxYicyujQ1JwUglzX9tz9nxidX11FGuQpt1H8k8UcQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZm/N4BTm3YuXcxL/cbw/kkW6LGNYWSjwJ+pB4ON5kitC/LpnCExISQmsHd8ABfoM7KIELpfzKzRnRswkAW9rrELtSFfUc+b6IU0NBPI55IlouBKQCjMhYbu1CR6DRHzDOzzkdfrQ6I+cMLGaGGzDmtsgSvTxIryXxOAfytT0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUPAd5Bq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUPAd5Bq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A9DC2BCF7
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 10:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495326;
	bh=YxYicyujQ1JwUglzX9tz9nxidX11FGuQpt1H8k8UcQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HUPAd5BqMPHcVfpyXTGyj4lg2pMGtedmzqZiajPobvYj6MjcAlsIUMR/RSwRv/+WE
	 ezRyanB87xEUjjXyiCfJdcZZag49HiOwzG7FdVQrwBp1v7G8964oWmmkvsXXUJOCBy
	 XkIGMlOlz3tMSTpOry7mCcvi3X3DcNuxtYbv9OmtITirMnOll57iCoXdn7bS2/IWvY
	 1WzffaWxwXA9JDlJH9cKrePNenv+9XcEz7zpOqo82TSOYhwBPWfjTPzR//jpflsWl9
	 9xyxD3tEC788097tUpEXLRbPlDmPnD0lcHdTeUSsn6DVNxpfjYuY1iFzM+qnlg7nTh
	 wVKsJPSrAj2kQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39397d63804so47264771fa.2
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 03:28:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9LyAT5WXBzVZbOlWulxmxzfqLK1p5wb5DotdPdQJXejn0pPHSrMukyOSxWZ0KZtG9C0iiMj2epXa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtO9/51AFzmPFJs36zoM3lMhZH+Ri0FKURVGEBs0fWIAp18aEk
	1sJrm/v/u77fuuXzGEkX700Zjm80Eb5+NiYzsovvAui01DOBZCUTyWz3WEVmc47FXLK5dMqZNYp
	yk38GCrJrlJeVba/ZMI+ysvwMdrhU7P7x/ZsD9H+ekA==
X-Received: by 2002:a05:651c:2107:b0:38f:e28a:617e with SMTP id
 38308e7fff4ca-393f4ef7c91mr46708691fa.16.1778495324694; Mon, 11 May 2026
 03:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afiNrr4Llm0LWw-5@ninjato> <20260509091208.18346-1-jie.i.li@nokia.com>
 <20260509091208.18346-3-jie.i.li@nokia.com> <af8IB46ST70lXVsk@shikoro>
 <CAO3NRJg3wPVLgnyd=eD=TkkS5J24ww9WP3nNuiCnCL8=aLEmwQ@mail.gmail.com> <CAD++jLmcFEcHoCWq_4=7so5gV5Usj45n6qOYj8xrfsgAYufkEw@mail.gmail.com>
In-Reply-To: <CAD++jLmcFEcHoCWq_4=7so5gV5Usj45n6qOYj8xrfsgAYufkEw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 11 May 2026 12:28:32 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdGd-6vUabTd5aJpjMbxRT3Mo8YH_jVyZzGLPyFsvce5w@mail.gmail.com>
X-Gm-Features: AVHnY4I8LqBfDvZs9wgXx4oyqy8FlsJurcqggpDGRGpYW5Nz8PNWwaCnZOPf26o
Message-ID: <CAMRc=MdGd-6vUabTd5aJpjMbxRT3Mo8YH_jVyZzGLPyFsvce5w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: core: support recovery for single-ended GPIOs
To: Linus Walleij <linusw@kernel.org>
Cc: =?UTF-8?B?5p2O5p2w?= <lj29312931@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, wsa@kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:19=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
>
> On Mon, May 11, 2026 at 9:25=E2=80=AFAM =E6=9D=8E=E6=9D=B0 <lj29312931@gm=
ail.com> wrote:
>
> > Thanks for the heads-up, Wolfram.
> >
> > No problem from my side. I can send a v5 rebased on top of
> > b47bc7c022dd if Linus prefers, or leave it to be resolved when
> > applying since the conflict should be trivial.
>
> Send a v3 based on v7.1-rc1 I'd say.
>
> Bartosz can merge patch 1/2 and offer as an immutable
> branch to Wolfram to merge and then Wolfram can queue
> 2/2 on top of that. This is usually the most bullet proof
> merging strategy.
>
> Make sure to put Bartosz on To: with clear intent per
> above and he'll probably deal with it.
>

Am I missing something? Why does this need to go through the GPIO tree
if it doesn't seem to touch any GPIO file?

Bartosz
