Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFFE43DA31
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206943; cv=none; b=h2FoGt2iCrKA9dTCMACJvUZAd1eOM5+jQ0edCeXx005UPEqLG2WWCDnkUWlPavNh/kWENJMSnUAbyJPt/dtKPMw4J2AS+Jvv8xtsiMPmyLbz5h77MQ2Gtw9i5q8X0qLSp4YRjnb3TPbSRATjcbuUqmguJuGxFCBiUEck99dnIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206943; c=relaxed/simple;
	bh=STzTxb6AkecD0Oj2uXWbAE7smRP8JD9AAxkR2Qux/Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDI4ybVvb8RNsLBywEfqojeqk9lem69wT1yXhCkatXdhRvHCM9XxIvejmmpZoJQ7MK4sBCBn610gDOdhzLo2YT1b75X2/lv5DAEzhNAjGNEZ/rtAl3GX8O9Wmw/rlJJFsUE6ZOPC323WdwcKGehrF0sM8HkwuABiNLV6jiV06hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBGFhqUB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBGFhqUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57293C2BCC6
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772206943;
	bh=STzTxb6AkecD0Oj2uXWbAE7smRP8JD9AAxkR2Qux/Sc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LBGFhqUBtQI9BbpwK46VoHQn50/6CaY1vQ5PIc4y5spoYCP25Jf0LROem1fHBjUy4
	 yeI4JK9t+VAFfxsB/FRVdfK2qMAp7BaBH+/oWL+LnHZG992H0B/CcnUUAoiNPkt5su
	 u377zsPtAQxl/Qcm2oYsywZEuG0OqtFcTLP7OjoWey7QG/JHyvrV4iN6xZaOIqUa06
	 vfJFlrWT+r202v79WRMwFVhTxOamgJ/igAb5KSIJ4HqzNmfDIAyq7QGRarn4/4y6Qh
	 NxQCbSDcfMyB0gb6ik4hp18xL7FM5BoFy0P7SgHelPVuHedFnta+qYHiFlGS3xx2xF
	 pZng7DsL48SLg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-389fac627c9so23471531fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 07:42:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6Uqc1QioTXdliQjbZvb6CWK8AMzMkFZt9t6DFadTRx7nGDWVfEKwskE8y3ZXZKvpUVjQzvbY1uXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72HZJvLdOeFtwMy2GBjvD4oKbPZ+m+JrUpG875Dpnf8V0OpgL
	c/0fvHHjpzpFtOPmM5RJY1NlCmyb6iW/+ItWDdEShyhhYIRTi/BzLb8PtFuYzY+tcEX3Z8uF3Ys
	9AmDOWwGbfXuynmfFLiXrKcvlpdWSi3OP9libNILjEw==
X-Received: by 2002:a05:651c:41d8:b0:384:9b92:c5b7 with SMTP id
 38308e7fff4ca-389ff143720mr18998801fa.15.1772206941514; Fri, 27 Feb 2026
 07:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com> <aaFfEsfh0xTh0b1y@shikoro> <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
In-Reply-To: <aaFsZbiLYSz_YEjw@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 27 Feb 2026 16:42:09 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
X-Gm-Features: AaiRm51scY9nN4P8ovfss040XTmsPoSnyMQYg9QuZyNCyHcgWecCdT1v9mdLWqo
Message-ID: <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
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

On Fri, Feb 27, 2026 at 11:06=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Fri, Feb 27, 2026 at 10:08:34AM +0100, Wolfram Sang wrote:
>
> > > Wolfram, I noticed you merged these last night. Please think again an=
d
> > > let's discuss the end result here. There's no question that there are
> > > lifetime issues in i2c, but this is not the way to solve it.
> >
> > I did think again and do not see a way how the life cycle problems can
> > be solved while drivers happily access the device struct of the adapter=
.
>
> There's nothing special about the struct device. What matters is that
> drivers don't free memory that's still in use by the core.
>
> > Whatever the solution to the core problem is (revocable, custom SRCU,
> > something else), I still think this step is needed in any case. If I am
> > wrong with this opinion, please enlighten me. Pointer to some existing
> > thread is OK, too. I didn't have the bandwidth to read the revocable
> > mail threads.
>
> It's not even about revocable or SRCU, that's just an implementation
> detail.
>
> It seems all that is needed is to decouple the struct i2c_adapter from
> the driver data and have core manage the lifetime of the former using
> the reference count of the embedded struct device.
>

I feel like we've discussed it already under v1 or elsewhere.

This is a weird pattern you sometimes see where a driver allocates
something and passes the ownership to the subsystem.  This often
causes confusion among driver authors, who logically assume that if
you allocate something, you are responsible for freeing it. Since this
is C and not Rust (where such things are tracked by the compiler), I
strongly believe we should strive to keep ownership consistent: the
driver should free resources it allocated within the bounds of the
lifetime of the device it controls. The subsystem should manage the
data it allocated - in this case the i2c adapter struct device.

I know there are a lot of places where this is done in the kernel but
let's not introduce new ones. This is a bad pattern.

But even if you decided this is the way to go, I fail to see how it
would be easier than what I'm trying to do. You would have to modify
*all* I2C bus drivers as opposed to only modifying those that access
the underlying struct device. Or am I missing something?

Bartosz

> Then you can use an rwsem, SRCU, revocable or something else to handle
> devices going away while they are in use.
>
