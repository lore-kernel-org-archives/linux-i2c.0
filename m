Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95887347511
	for <linux-i2c@vger.kernel.org>; Fri,  6 Mar 2026 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817635; cv=none; b=fUIGLS4QX87Y1ZyBZk/4MDp+FsMIJVdUR2OaXfSYqDxsFnIktE9On/2rnNtxMf2H01T0l6c+Mc+mUY2q0sqUfbx4XP3itoFsqUtokLcfDFO8oPblAGL5ldt1N58OSl0X9NlDeHrcB6vud8hWgE1FU+82RAoY28kkL/k7Wcbmnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817635; c=relaxed/simple;
	bh=GhclToYLpG+7UMFBLf2ZmC1LGWDj2lllBQ5Rm1+HHeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5ClpC+VZ/kGJdTIKLG6yTo0fKPObVh1mygQk4rjanbVCm7Du8mapf0LWsyi1xrpW067IKedaR/BL/YFZ/GBMX4z3NWliRx2eExKSCLjNA2EihkUSNwPXiOfUN0lAdP48EjxHjeYjhh9mlOqdOmcBOrHptmvApGK6OEpZjzspAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0QuKWwI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0QuKWwI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3279CC2BC9E
	for <linux-i2c@vger.kernel.org>; Fri,  6 Mar 2026 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772817635;
	bh=GhclToYLpG+7UMFBLf2ZmC1LGWDj2lllBQ5Rm1+HHeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X0QuKWwIKsmDcGnlrpUm6yB2pihXgA6QnYd8IUEibiHrSNuEYsufpgaFky3ft/E3x
	 +k8gLScehB45uN8ll2nCrg5MFVG5cOFzng7aczmmuJ5UPzAPDrkBxJMFeNJSdAx519
	 4glCNghhsAObrjBqFZypUFPzqllh7KiwB+xoPuJkuzsdgnjT1nsaoASrVs8OgX7q1U
	 n9Uro5kGEi84Fod/pkVvc1TpFDLWICaWPjxCVGLbe85A1jY0tzAQCdn8i50MQZeObX
	 apByZC9DaB8qvVYwrGuaci2xaYMI0+UVEcIcRptuZD0LUK7vw+EgyePqCRkDzbPKQA
	 BCoheQn++AkqA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38a4234f91dso5501311fa.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Mar 2026 09:20:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXduTxznEer7nVd1oZNBs5tHKO+iN3/UcACAmLGU+iM/istY6sTrvt74OElWVEBj6yrN4ZK2T/qxaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRPVfjy8gWC+3A7lQ+80+mrZ0xfxfsGOZkfAVmrFm+MFiC96g
	Fa2KoqrLDUysStVSF/TpQ8TgQxY/o9xbnoMLcKLZ6Ws6aHKUkYf00SB5AoSlivPpEnJe7lz+bPW
	YMmLbmfk7WLqzU+sXxTxbD5TMsYvbGbFIcVPXJb6vOQ==
X-Received: by 2002:a2e:8a96:0:b0:386:8f97:d0b8 with SMTP id
 38308e7fff4ca-38a40d909b6mr9281811fa.20.1772817633825; Fri, 06 Mar 2026
 09:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com> <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com> <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com> <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
 <aacE-27iaYneKCJi@hovoldconsulting.com> <CAMRc=Mcx8Hu407arSEo3o-Xhmep_ZK4BM2TVi_55nXGwYcaijw@mail.gmail.com>
 <aagSewpM88KAZDcJ@shikoro> <aar3rj7Db6NmTVS_@hovoldconsulting.com>
In-Reply-To: <aar3rj7Db6NmTVS_@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 6 Mar 2026 18:20:21 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf5Ydt1JmaC63B-3wGXdLdYvE4jHhzD36t=PUTzuWfw2g@mail.gmail.com>
X-Gm-Features: AaiRm53pekvMkksI4fYGSCWmOvo94JFARCgE7Q2uLvo1sVDayAaQxKa6carQHj8
Message-ID: <CAMRc=Mf5Ydt1JmaC63B-3wGXdLdYvE4jHhzD36t=PUTzuWfw2g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
To: Johan Hovold <johan@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Khalil Blaiech <kblaiech@nvidia.com>, 
	Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <mani@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-actions@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 4:50=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> Bartosz seems to agree that my suggestion to decouple the driver data
> from the i2c_adapter would be better, and I'm willing to do the job.
>

Fair enough, I'll leave this for a couple of months then.

Bartosz
