Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279A313550
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474605; cv=none; b=VwWBW9D8N/FhLiyrFJ5/l7cilbmk64EIVAW9abtAp+eypQ9jC8AFoKbJVnJ5c2amKEvd9NDKxWZaGoondNwCfFbLQHTFku9Jec6z98FdjBETsPN+10CRmNIf2Z0G76S863TNDRlq0aZXP9ndVC16hSFi/+WdXC2yVrt2zoys65s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474605; c=relaxed/simple;
	bh=KYTmWdCkzi4ZeFomh2vR1ikSgEuPoY2tyFbdDD9n6fM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwfjV2pjP2R/hZKiwqA0yRNkTj2rBQuOrkeBSAvs1qxtaq4Pgl132QZmQTX1jlTp7EekAmlMfUpPduPCqP2c0CVSXyiOwmrx+NTqnRQujUCKYY7H8JsxbrnR8aohHOhiLclWIDkKmvLJ4uSXFLUK5pPHDTuLs/SPRgHjOq8lwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JveeZMtv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JveeZMtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360C3C19425
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772474605;
	bh=KYTmWdCkzi4ZeFomh2vR1ikSgEuPoY2tyFbdDD9n6fM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=JveeZMtvHh4b2GDnkkVyoJrGK+Q2MGZFf2Lk8CJ9YYMT4wWsD3PjgDtK7j34pvmkY
	 E/43eNsIP8bpY89IsD8OrgREu5LCcRj7pKs0QIYodWLXf6g93QTVZwpnizkwSMkiD/
	 BAD5de04STMakF6ho5rUZ4mdp3ksx9UZGqEhuoNweZ5bjy7iVs4ZDhR8XhmlSfKsq9
	 aqUCS3W32PniuLquL7+5UC0sVXuXO6bNivAp/drZVWd+BZ5RPwdd7zxREDEk7BANKu
	 a8pv6i+LfkS2BDrxpBLMH8Xyj37KtCQY5fLs47mdIwqbIGRRnNAtweJ8U1AdATlvx6
	 qVNNtRXG2g0rw==
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1279eced0b9so1766361c88.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Mar 2026 10:03:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4xhiwXN4hrMaCBCKYhC6YVJYxa5pEAr5cniEfiPMUER+9uFCwBy2KeeQx3KH3ZiPzJ0emYq1aCcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymAVV7bzoFPPTKUkl+nZXtnqjx22YDtbHIg/qFtuOWiD1iWe9D
	zygh8FH46SiW8cknP39AKCTgOOvodXz0GY62gT76L+9D7NbAb0VWBBbgUk6ftW6zSOu/BVg8gax
	8pnM7boCbhUppUAfOo0O1GeONGFiLn7nZ0PliwxyEng==
X-Received: by 2002:a05:7022:6624:b0:11b:b3a1:714a with SMTP id
 a92af1059eb24-1278fb78dd9mr4239860c88.12.1772474603495; Mon, 02 Mar 2026
 10:03:23 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Mar 2026 12:03:19 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Mar 2026 12:03:19 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aaHI_VavZugXjVoL@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <aaFcs1miP88QWmtH@hovoldconsulting.com> <aaFfEsfh0xTh0b1y@shikoro>
 <aaFsZbiLYSz_YEjw@hovoldconsulting.com> <CAMRc=MfcvD1nJy=zpoCkSkJq6WjyXQxFUZ4QE6vyCS+XFCn5AA@mail.gmail.com>
 <aaHI_VavZugXjVoL@hovoldconsulting.com>
Date: Mon, 2 Mar 2026 12:03:19 -0600
X-Gmail-Original-Message-ID: <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
X-Gm-Features: AaiRm5300NChK-leJ7j5rh6yPxkWOdKqgHQ-hP_JtNKBqi3Lo4LpSjP98XQOjgM
Message-ID: <CAMRc=MdKF29McBJ9U=qELkzf9GYV1CQpRF7U6OweDNtVzMXo7A@mail.gmail.com>
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
	linux-actions@lists.infradead.org, linux-media@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 5:41=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Fri, Feb 27, 2026 at 04:42:09PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Feb 27, 2026 at 11:06=E2=80=AFAM Johan Hovold <johan@kernel.org=
> wrote:
>
> > > It seems all that is needed is to decouple the struct i2c_adapter fro=
m
> > > the driver data and have core manage the lifetime of the former using
> > > the reference count of the embedded struct device.
>
> > This is a weird pattern you sometimes see where a driver allocates
> > something and passes the ownership to the subsystem.
>
> It's not weird at all, this is the standard way to handle this. We have
> these things called reference counts for a reason.
>

I wouldn't say it's *the* standard way. There are at least several differen=
t
ways driver subsystems handle resource ownership. And even so: the fact tha=
t
something's done a lot does not make it automatically correct.

> > This often
> > causes confusion among driver authors, who logically assume that if
> > you allocate something, you are responsible for freeing it.Since this
> > is C and not Rust (where such things are tracked by the compiler), I
> > strongly believe we should strive to keep ownership consistent: the
> > driver should free resources it allocated within the bounds of the
> > lifetime of the device it controls. The subsystem should manage the
> > data it allocated - in this case the i2c adapter struct device.
>
> Drivers are responsible for dropping *their* reference, it doesn't mean
> that the resource is necessarily freed immediately as someone else may
> be holding a reference. Anyone surprised by this should not be doing
> kernel development.
>

I disagree. For some reason, you're defending a suboptimal programming
interface. I'm all for reference counting but mixing reference-counted data
with non-counted is simply not a good idea. An API should be easy to use an=
d
hard to misuse. Given the amount of issues, this approach is definitely eas=
y
to misuse.

I'm advocating for a hard split between the subsystem data (reference-count=
ed)
and driver data (living from probe() until remove()). A logical struct devi=
ce
managed entirely by the subsystem should live in a separate structure than
driver data and be allocated - and freed - by the subsystem module.

Let's put aside kernel code for a minute and work with an abstract C exampl=
e,
where the equivalent of what you're proposing would look like this:

struct bar {
	struct foo foo;
	...
};

struct bar *bar =3D malloc(sizeof(*bar));

ret =3D foo_register(&bar->foo);

And the corresponding free() lives who knows where because foo_register()
automagically introduces reference counting (nevermind the need to calculat=
e
where bar is in relations to foo).

I strongly believe that this makes more sense:

struct bar {
	...
};

struct bar *bar =3D malloc();

struct foo *foo =3D foo_register(bar);

// foo is reference counted and allocated in the provider of foo_register()

foo_put(foo);
free(bar);

The equivalent of which is moving struct device out of struct i2c_adapter.
In fact: I would love to see i2c_adapter become a truly reference-counted
object detached from driver data but due to it being embedded in every bus
driver data structure it realistically won't happen.

> > I know there are a lot of places where this is done in the kernel but
> > let's not introduce new ones. This is a bad pattern.
>
> No, it's not. It's literally the standard way of doing this.
>
> > But even if you decided this is the way to go, I fail to see how it
> > would be easier than what I'm trying to do. You would have to modify
> > *all* I2C bus drivers as opposed to only modifying those that access
> > the underlying struct device. Or am I missing something?
>
> Yes, you have to update the allocation and replace container_of() with
> dev_get_drvdata() but it's a straight-forward transformation that brings
> the i2c subsystem more in line with the driver model (unlike whatever it
> is you're trying to do).
>

No, it's not that simple. The .release() callback of struct device embedded
in struct i2c_adapter is assigned from the bus type and only calls complete=
()
(yeah, I too don't think it looks right, one would expect to see the associ=
ated
kfree() here, right?). It relies on the bus driver freeing the data in its
remove() path. That's why we wait until all references to said struct devic=
e
are dropped. After your proposed change, if your new release() lives in the
driver module, it must not be removed until all the references are dropped
- basically where we are now. If on the other hand, the release() callback'=
s
functionality is moved into i2c-core, how would you handle the fact i2c_ada=
pter
can be embedded in a larger driver data structure? Provide yet another call=
back
in i2c_adapter called from the device's .release()? Sure, can be done but I
doubt it's a better solution.

Bartosz
