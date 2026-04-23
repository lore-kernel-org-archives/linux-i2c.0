Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063A199FB0
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954001; cv=none; b=ckZhhoeLz8VBJv/jMwIVlXX3D2XkALnIApd/etwX+zaMdtzrrDYO/JqCXwhfKc4uEmBs2NpQJIuweUifxuOPs+fIden8VxLAmIjbcAJygC7RqNwG9zgxNgEEczEvLroYiP9oy51+ihMSiAqHfw0bS9ZJbHjFxDJz3b+oYkGJcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954001; c=relaxed/simple;
	bh=127/yzVKNXCtnq2BuF2Pn+pom/R/B+8FKlTgC2Gvq9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH6LSgFd18s8GZiSQUOEP6oUXSzAuKGxYDWiptYHqHhesh1GTgWMi/zUCO04yXAIaiEbjHCK/7EhKa6yG8hvad0l9hvBKYA85BJs1zAh/WKKQlOOO41L6I/hPpWNudjlA9ea0TxwWSA+V78phSs9p54N1JDVB79Kn4nYnf8joSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXuA5/li; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXuA5/li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6873C2BCAF
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776954001;
	bh=127/yzVKNXCtnq2BuF2Pn+pom/R/B+8FKlTgC2Gvq9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NXuA5/li70xOFPXVxp3ccW3OTmGMcWHrXJQRUFFvHWnsEN/2KThxt/xtmu3X/F95n
	 VXEDZC8UpFnrVBeT/ZvHnJ9SQkpEvMfUSUgjb3nzGlOO8/zqa3JlICcxd33iDJT/V8
	 chZXyr/Bc3X8M1/nGAOiKEV9b+ynLHVzhKZO007s7RAn04KNvg5Xlpvrgxi5neS3lh
	 csxeM9oVwu+x/DtBz+/+hP937MONphXGsKjd0w4mPauJ+bAKfCwcHncTAIkD0rjEf2
	 DUwQR2XqVh0uc92dxLnA9d3CgDS8Jk/KjtP/C+qhYRdK+/a7//gKNI+19Y2wmv6Njs
	 kNXurdfk8XcUA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38dd575bca3so69151391fa.1
        for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 07:20:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxEMPJ79oIGOcqdEm9F7x3qKwB93gJeMBRH8A619wVyy2dfA5yp
	He66pzyNXBLytrsZ7J76tUri8j4QSd1Q/yopLGUaWj68SIfDlTx+zXk2JqREoipUZbJh8+sk1u3
	1wYX6oiUd6e4VrJaMNmfRhQ7JFHaCVffuOWn9hu+hFg==
X-Received: by 2002:a2e:8e6f:0:b0:389:e6e4:3c7d with SMTP id
 38308e7fff4ca-38ec94ea792mr56535301fa.19.1776954000301; Thu, 23 Apr 2026
 07:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421140755.54222-1-marex@nabladev.com> <CAMRc=Mcxport3yb28Bbf5OM5VGCerfvLnCZQvLncpUO5--vbYw@mail.gmail.com>
 <210b41ca-28be-42ca-819b-de5f17dddec7@nabladev.com> <24649001-4d21-4ddf-a171-842b0e7782e4@nabladev.com>
 <CAMRc=MdqzeyvGD=typRApK0fKbpWoVT96_vAE-2yNymnjJxpAw@mail.gmail.com>
 <faba330b-f98a-4e52-a180-d62cdb9a24eb@nabladev.com> <CAMRc=Mfam_wONk+chgEi_hefBj+2+zhcSfbo0=Lxr_vOnvL1MA@mail.gmail.com>
 <bcbcc7b6-dede-4918-b229-bf546fb1742c@nabladev.com>
In-Reply-To: <bcbcc7b6-dede-4918-b229-bf546fb1742c@nabladev.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 23 Apr 2026 16:19:47 +0200
X-Gmail-Original-Message-ID: <CAMRc=MeFktvZ0x8L_-53Oi2Y4pFYng4B3BivwafdZ40Wz75ycQ@mail.gmail.com>
X-Gm-Features: AQROBzCd7b_9anTl417LIe4Egvhh_pku8YUqMZXh7cB6JofXb25scTjBEEDgsnE
Message-ID: <CAMRc=MeFktvZ0x8L_-53Oi2Y4pFYng4B3BivwafdZ40Wz75ycQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 4:06=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> On 4/23/26 2:17 PM, Bartosz Golaszewski wrote:
> > On Thu, Apr 23, 2026 at 2:04=E2=80=AFPM Marek Vasut <marex@nabladev.com=
> wrote:
> >>
> >>>
> >>> I see. Ok, please send a v2.
> >> Does this patch require any changes ?
> >>
> >> I will be sending the DT changes separately.
> >
> > Sashiko is saying this:
> > https://sashiko.dev/#/patchset/20260421140755.54222-1-marex%40nabladev.=
com
>
> What does this mean ?
>
> > Shouldn't we report the device as read-only in sysfs unless it was
> > "unlocked" with force_ro?
> This would be ideal, but I did not find a way to toggle the "nvmem" bin
> attr permissions at runtime. Is that even possible ?

Right, it seems like it's set once and can't be changed (Greg: correct
me if I'm wrong).

Ok, nevermind the comment then. Maybe just split the changes into
nvmem and at24 changes and I can take both with an Ack from Srini.

Bart
