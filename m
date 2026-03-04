Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4491836074F
	for <linux-i2c@vger.kernel.org>; Wed,  4 Mar 2026 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642590; cv=none; b=cpsZtleDFCjDbM40RkgjQDjRdCHpRbvYckMOfVwmyA43JqD9euho69Y/37RaCrM9VYGcmSFtrmfsdAypzmEQkaNiKYARVvuAOJMA0Sidg819NQn90SgXN9lt5Ct467H1bEv2tJZOgFsDht21djxBncN9URQuAnbRkb6Mvqzo8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642590; c=relaxed/simple;
	bh=9OqUlajEsyaPvA+Ou3Wj1PI8aRB4Ig+mv6GW9s47I7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt8Yvts36h3wRzdIt1s+7PeYEy3vh78g+WtrvJJht/xwmBVIUH26l/adYsi1JUrtVvJwDj+T6zDS2/90+yrJoumBflOrYW7dgXZbLJXe3og4YiZp9Bx/K6C1ZxtfFA/eaUFUczR86+3B9XBbaEAib7ZLySvo9PyAy5viXgxprig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCnC9O/I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCnC9O/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E6FC2BCB3
	for <linux-i2c@vger.kernel.org>; Wed,  4 Mar 2026 16:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772642589;
	bh=9OqUlajEsyaPvA+Ou3Wj1PI8aRB4Ig+mv6GW9s47I7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BCnC9O/IEPyPHpuW1wYYPFqUtD8Auc9hKfyd5IevjyB07JJKZkdFVkpg5xJe7m1aB
	 Rp5C7ZjunBgpIR7oPDlQ/cEkAserS1HUaBfTXz9EVXtOAFmLsOn4farl/22NKoCPMB
	 g7nIrOCcWHUQ+RriZE98eM1CdYTdRD4N9HWz3mz0dLZ2rlfNEtz5h1RMoxdu3D+wPz
	 Ncf5DhnDycHQZI0sgXpnvLT0NcPmh9wexnD8Pfctkd9FNFtze74AZlrhhG2+wWYfiT
	 vym5YN+i6bt495P+C8KFs3NqRA1k1AXAo8ef9HA3wlYvkHs+3KagTEjXZ3UldKE2cS
	 DdyMCBd6SkG6w==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a3066b68bso11387561fa.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Mar 2026 08:43:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLw7dzoJfC/2MYkDJ+Kkq51LE7JxfDBa8xvl3NjdQvvCAMDBh+npT4tweNR0SJONL5bHlmZUc/Pow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhig/GI705nczp9H8Hiy3mSQ48srFkISnVNQZC3J5xiO81w0Oo
	Rv5o3LkuHJijxLIeayUsWOsd88LStATMpE5sf0LkvNLMl/4M+xF9xTzAbP2TghSZTAxgbcOH7/4
	j4PXg5cxGKduZTJqskg2wySn7+It/Co3ReEo26DFaSQ==
X-Received: by 2002:a2e:90c6:0:b0:386:e9ba:1de7 with SMTP id
 38308e7fff4ca-38a2c7b90a4mr17313261fa.33.1772642588346; Wed, 04 Mar 2026
 08:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-i2cfix-v1-1-a95418e9217e@kemnade.info> <aagNrTJYj-MdeBRO@shikoro>
In-Reply-To: <aagNrTJYj-MdeBRO@shikoro>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 4 Mar 2026 17:42:55 +0100
X-Gmail-Original-Message-ID: <CAMRc=McAvQTc=yZngaHh54B-ZLAfLf_ssFQc-_EUh4zjnuOR5A@mail.gmail.com>
X-Gm-Features: AaiRm51-_KL7ZixwZgVk2_cm-jJx3DIhdOxUqfoRDQxWkcsWqF3-bp6Fl9c1u1c
Message-ID: <CAMRc=McAvQTc=yZngaHh54B-ZLAfLf_ssFQc-_EUh4zjnuOR5A@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-core-base: fix devicetree alias handling
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Frank Li <Frank.Li@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:47=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Andreas, Bart, all
>
> On Mon, Mar 02, 2026 at 06:04:42PM +0100, Andreas Kemnade wrote:
> > Parent device is not set up there, so use the new of_node pointer to
> > handle aliases.
> >
> > Fixes: 0ab80451c70f ("i2c: allow setting the parent device and OF node =
through the adapter struct")
> > Reported-by: Kalle Niemi <kaleposti@gmail.com>
> > Closes: https://lore.kernel.org/lkml/EDF3FB58-4747-442E-8463-6F1C6E5689=
62@gmail.com/
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>
> Thank you a lot for this fix! I will apply the patch. Plus, I want to
> describe what it also made me do.
>
> Bart's patches are in for-current and were planned to be sent to Linus
> as an "after -rc1 cleanup". This patch tells me that we are not there
> yet and the patch series should have a full cycle in -next, so we (read:
> I) have more trust that we didn't overlook side-effects. As a
> conclusion, I will move Bart's patch series to for-mergewindow and apply
> your patch on top of it.
>
> Bart, I am sorry for the delay it introduces, but I think the smoother
> the transition the better. Maybe we can save some time somewhere else?
>

I think there's been a misunderstanding. I've never suggested this
should go into v7.0. This is definitely v7.1 material and should cook
in linux-next. So yeah, feel free to queue it for the next merge
window.

Bartosz
