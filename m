Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338443901F
	for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134911; cv=none; b=LQsFGG5mxJNUdr75BfNcWbbBGpc1ZXs90gqjAYSs9+Cbz0TZ8zAuBRKai4c/UQEFlgXaAJ6T5TmU90XcgV4Fb3QoBTtpPAmciFfknsRoWFq1NtI6BlSYIMgtY87eKI6jnyZw4uXKw0bfZTLltT8an5CIdmu0TbGobeZDV1OD4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134911; c=relaxed/simple;
	bh=dZHL6ALzbbg+d0OTHFPpy1ega8D7sQ79hXGEXtGGk2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzHEFngBaD59lqzZWtMPkNYWhPknT5UOJfJuUUKMI0v2+uAG7lvwkzqxPvT2nownh2Afggw8y914IK3DSGufCtwuxv2CTA0XiehLuk0+ExALxcRLGb5bqWuBGY8ZOQNJPglNc4X1QXNE2tIr0Iao0oeVGHw1+pYvNBUVgQnZl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7Y1h7iX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7Y1h7iX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B24C4AF0C
	for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 09:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773134911;
	bh=dZHL6ALzbbg+d0OTHFPpy1ega8D7sQ79hXGEXtGGk2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o7Y1h7iXC1ZdVfl1KUOlDDpKxFznmLXSdkFkkpD2R6qrfrJxHZWbeePjghWSZJ7iW
	 kHdGuco0Gs0skZt6PvhChT/yDUeRXjhDSLXDYgZeMURQdjEK4UvZ75eNAK8F1gCH/J
	 JMyTl3LDbhorPpLwwX2gigbzsDFTZmr8wfGHm5jVHaXNMsYZ7k3NjDXCLBmujQc4fO
	 yxV/S1HRDp9Mh+2ISz0crxx/r15tV/PaEAVnNYSbvjzvX7RpYQUaHnNBINfoQuSPFa
	 I07mRSe3f5Gx0Z11MvnR98//b94k11DXqYt/Q39jp/DttYudpWQ9ONHmo2MV4LeGo1
	 biYMSP3x4Lvpw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a142464316so3593271e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Mar 2026 02:28:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsNZAn114fUQJejjgZ695l/TZ1iy8sb583IXpScllI8AqFatFInaoxfidM/GvESHFcU9HVBwj9+Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaG3UiPY92ahvgRxyuf7SSNDZPd8pw/L7ThYU7AvSKcIDh4dKl
	V0tWFeiiXdwg9Qrtaz7EL52HpnghOL7dZ7VbIjuTIEVi0QEh/7DFQVTJZzptLPAHvXx6FF01o5a
	8rv81WYoOCxTy+XYKcwwS0nmASbFE3ffUMHWZJrNGAg==
X-Received: by 2002:a05:6512:33d1:b0:5a1:44c9:a8ef with SMTP id
 2adb3069b0e04-5a144c9ab04mr3592708e87.26.1773134910130; Tue, 10 Mar 2026
 02:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaFcs1miP88QWmtH@hovoldconsulting.com> <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com> <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com> <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
 <aacE-27iaYneKCJi@hovoldconsulting.com> <CAMRc=Mcx8Hu407arSEo3o-Xhmep_ZK4BM2TVi_55nXGwYcaijw@mail.gmail.com>
 <aar1PDUB2t7DgEP6@hovoldconsulting.com> <CAMRc=Mcv+ZMGaC_MD8WRH113rDuuxdiZXuW5JAXWga1V7vM_ng@mail.gmail.com>
 <aa6hcT7MROZqxF1j@hovoldconsulting.com>
In-Reply-To: <aa6hcT7MROZqxF1j@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 10 Mar 2026 10:28:17 +0100
X-Gmail-Original-Message-ID: <CAMRc=McXGZFVQm0B2OddSLLV8r513tDmbEzeY4hvPcakSv9N7w@mail.gmail.com>
X-Gm-Features: AaiRm51wQp574GnYnSDIqyJgBWyPwbXLgs-qc-SDGATXP4oGmj2-sapttc-0urY
Message-ID: <CAMRc=McXGZFVQm0B2OddSLLV8r513tDmbEzeY4hvPcakSv9N7w@mail.gmail.com>
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

On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Fri, Mar 06, 2026 at 06:34:43PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Mar 6, 2026 at 4:39=E2=80=AFPM Johan Hovold <johan@kernel.org> =
wrote:
>
> > > You have posted changes that will prevent driver from accessing the
> > > struct device of core i2c structures. This is unexpected, non-idiomat=
ic
> > > and subsystem specific and therefore a bad idea.
> >
> > That's not true, the changes provide a helper to that end.
>
> That was supposed to say "prevent drivers from accessing the struct
> device *directly*".
>
> > > Again, this is a core feature of the driver model. You can't just ign=
ore
> > > it and come up with random ways to work around just because you disag=
ree
> > > with design decisions that were made 25 years ago.
> >
> > It absolutely *can* be done differently. There's nothing that imposes
> > a certain API design on susbsystems. If you design the subsystem code
> > well, provider drivers don't need more than one reference (taken in
> > probe(), released in remove(), for instance via the
> > register()/unregister() pair) so the counting can be hidden within the
> > subsystems that control them.
>
> Yes, there is nothing preventing you from diverting from the idiomatic
> way of doing things. But my point is that that's not a good idea.
>

"Idiomatic" is a just buzz-word. I don't know why you insist on it
being the only "correct" way. People have been doing all kinds of
driver data management for a long time. You recently looked at my
series for nvmem - did you see that nvmem_register() only takes a
config struct (which may be a stack variable in probe() for all it
cares) and copies all the data it needs into refcounted struct
nvmem_device that the subsystem allocates and manages?

An nvmem provider driver only has to do
nvmem_register()/nvmem_unregister() and, while it can access the
internal struct device, it never has to in practice.

There's no:
  nvmem_alloc()
  nvmem_register()
  nvmem_unregister()
  nvmem_put()

I don't see why we wouldn't do the same in i2c:

  struct i2c_adapter_config cfg =3D { ... /* dev id, driver data,
whatever... */ };
  adap =3D i2c_adapter_register(&cfg);
  i2c_adapter_unregister(adap);

I understand that you doing the work will give you some discretion as
to the implementation details but I'm asking you to at least consider
this as a viable solution when used by others elsewhere. While you
have criticised my proposal for i2c rework - fair enough - I don't
think you have ever given an actual argument against this simpler
register/unregister-sans-alloc-and-put pattern other than it not being
"idiomatic" which is honestly quite vague.

Bart
