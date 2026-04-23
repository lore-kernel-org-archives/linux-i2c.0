Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1E311973
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930188; cv=none; b=mnue3CuDEyJTIwSoZ8boZIZLR2B24cAWirjv1ODo88OHzkeOnq+i8cMrSlEVJy+yNpk8BOVv1cU7BB2YDZ27CCIQirFR9l3Vi1UlNsHn/d4OdF8gD4AnKgSB3X/unHpot+VXZeqOMgaut03WQGpvC2j7yZQltHvtv0M1Ukpi1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930188; c=relaxed/simple;
	bh=JtdGa6G+L1Cw57le4y0yN4OuqHi1KwvKyW3sw0H+4cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It1zOl2Ln0iMbSeWLoIbZmB3aKho00jGeUBxjlJm2HhihVsuI9HIt68CKqmAGM0MsvZ2a4l+kgD5smFEJ2HIjtPzOCusOIEe34x3e7LkF2RjGhJ2vSW5pc5zk2moL33vGPfWIqFrkaq8ldAHclc1MOtK2BdWxcZ04Y93uzdFa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQgYL2Bi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQgYL2Bi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF57C2BCB5
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930188;
	bh=JtdGa6G+L1Cw57le4y0yN4OuqHi1KwvKyW3sw0H+4cw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gQgYL2BiUBF718Lms5blGM2SAGCi/bsWzSDJPdIL9XX6pANwqzjxiz6Y8HR79fxJR
	 bldWPgXSprR4GjrHtfa/mEmSE2Vy9yqvBOQjq0Qk5qIQ1g+S0sF3rMLD1wcBN1zBoD
	 zu4+DmtY/uhuGj8qW1/SMpT1iOkEoMAJeQ18LH9XpV99HJ/HWxw4b/fnU63mxH9NbD
	 uUHHcQQIyWoTTuS8Cu0CdpTPEJJcsFqhLMx7ATksgTlAvfQYZT4StCeulPt2jIhtk0
	 HKHOPTsBeA2RZwXsWg4A20AmsvvLqN7StjvSodDBDSS7Mk+berlLjfGA2gmHqtZkKz
	 HCw7zbiCWgieg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e7d983f91so68100851fa.2
        for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 00:43:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YxALk9bdSUDMcBcDHaFhwY+LP/glc0jznGaUH1G3R3II78lF/Lf
	Z39jK/Axnv5HSMbpQCbagZKCWZucoR3cq8SVHSrcJBn74tA0rCwQqRkcyUut4e3LLAbqQISIEDz
	ESxEFRgO1faA7EYTwfsGmPb3ZVCwAsjWpHph5LrA8Nw==
X-Received: by 2002:a05:651c:2109:b0:38e:8411:c300 with SMTP id
 38308e7fff4ca-38ec7a987d7mr83176621fa.22.1776930186993; Thu, 23 Apr 2026
 00:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421140755.54222-1-marex@nabladev.com> <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
 <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com> <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
In-Reply-To: <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 23 Apr 2026 09:42:54 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com>
X-Gm-Features: AQROBzAztcXXoPIbc0LFI4Kz72zdmWoggm76GA-BeDUMh26hRUJkgH9p1g0b3Os
Message-ID: <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 7:01=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> On 4/22/26 1:33 PM, Marek Vasut wrote:
> > On 4/22/26 11:07 AM, Bartosz Golaszewski wrote:
> >> On Tue, Apr 21, 2026 at 4:08=E2=80=AFPM Marek Vasut <marex@nabladev.co=
m> wrote:
> >>>
> >>> Handle special-case of AT24 EEPROM described in DT, which contains bo=
th
> >>> "read-only" and "wp-gpios" properties. Interpret this configuration a=
s
> >>> default read-only, but with the possibility of unlock via force_ro sy=
sfs
> >>> attribute.
> >>>
> >>
> >> Patch looks ok code-wise but does this really make sense? If an EEPROM
> >> is read-only, we should forbid writes in the kernel. Which board uses
> >> it? Can we simply remove the read-only flag from DT?
> >
> > Currently I am not aware of any upstream users, I plan to introduce one
> > once this patch or some for of it lands.
>
> I have to amend my statement, I would also like to adjust an already
> upstream DT to make use of this default-read-only functionality now.
>
> I would however like to get go/no-go on this patch before I roll out the
> DT patches.
>

Yes, go ahead.

> > I have is an ID EEPROM which I would like to be able to program under
> > special circumstances (hence the wp-gpios control) , but it should be b=
y
> > default read-only .
> >
> > If I remove the read-only, then by default the EEPROM is read-write,
> > which is undesired. If I remote wp-gpios then I loose access to the
> > force_ro attribute which controls the nWP GPIO from userspace, which is
> > undesired.
> >
> > So I think defining this special-case where wp-gpios and read-only are
> > used together as default-read-only is sensible.
> >
> >> Admittedly: the DT bindings do allow it as read-only and wp-gpios are
> >> not mutually exclusive but I think it's more of an accidental omission
> >> than a planned feature.
> > I think it is currently an undefined behavior, and this patch defines i=
t.
>
> Also, this default-read-only behavior is effectively the same behavior
> like the eMMC HW BOOT partitions have, they are also default read-only,
> but can be switched and written to by setting their force_ro sysfs
> attribute.

I see. Ok, please send a v2.

Bart
