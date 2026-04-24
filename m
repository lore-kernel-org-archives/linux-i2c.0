Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C952F22256F
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018355; cv=none; b=H3XmMncCIHBcOU3lG6tfK0XaAzRIYdraub90pbaxFqcK9kiDorSZaXinH290AjAmWphM6UONanuB7sCi0nGkyFO0kvxdrudgIkSK2JRnWP/HWWCL/yngCt+EYvNO4xs5EFcz+/azH5sCO3hXY4zg0SBmEDbRu78LjQmrs+A6u1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018355; c=relaxed/simple;
	bh=2dpDTfL+kVbHUNaQeGHXGiDLbTwBsCQs6TRYjfHOQH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ki6b2B++BpfkszGYlLTgEnobFRBvA1RWl1SADXm0bzZUMg68dsZbqEWVmqtUYbgHryFSMDPKG09zCVtbm2jEhNizoU3rRTeq+9kaUkcFpo0O0P1znMTja75qCIpb/fW2SEVlHKYbJET1Eo2iuiKQxaxZBaJfM0uZot0eQBdzNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx6PST2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx6PST2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E5DC2BCB4
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777018355;
	bh=2dpDTfL+kVbHUNaQeGHXGiDLbTwBsCQs6TRYjfHOQH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rx6PST2Wu1CRMU83jUbpAHG1yLdcAOOiTr/p2D7StG0rVqbQIpNeWMeZo0ofsq3bf
	 ++XhcmTWz3y0/FVXXtP9i2XkONs+VYosfB02lIaKXvcbcWOheLRU5CwnDTRUxwdez3
	 VdTkLzthK51kYUP4clAc3fNh5EubpALUVRt8qhddEo0JI/nAldLg3oTZEq8PNyPak6
	 0YOZxBakA2b8Sho33YhOO8qcuUctOJ8Y+MfKIkRzZf8KRZ7LMDFbRsDziTUNR8PJKp
	 HTVfPjMNBUnWdtA4Sc9KlYmtMbtURIBV4EWxqWnQDI2ty9cn1JskzwMrvKeyBn8QXy
	 OicOgagPGelnA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e7d983f91so80179501fa.2
        for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 01:12:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Yys3sPLe4lV94lp1y2Rt9f4zjajo3AjrB8ztdOog3jLfmDFpCdA
	lYhhS2ledL1GEzjO2jxm2WMQCfhQNwIRiFIBWQLNjw2ma34MVGR0oFFZeZeBWubXbvPoJCxHP9D
	qPqmWe4RU4jrl2axshwWZ13nNspFnQ+/Mt7r5OHpROQ==
X-Received: by 2002:a2e:bc27:0:b0:38e:9566:a309 with SMTP id
 38308e7fff4ca-38ec7ac7625mr97898741fa.28.1777018354093; Fri, 24 Apr 2026
 01:12:34 -0700 (PDT)
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
 <bcbcc7b6-dede-4918-b229-bf546fb1742c@nabladev.com> <CAMRc=MeFktvZ0x8L_-53Oi2Y4pFYng4B3BivwafdZ40Wz75ycQ@mail.gmail.com>
 <4a6c6822-28e1-4838-9262-f7b758f92736@nabladev.com>
In-Reply-To: <4a6c6822-28e1-4838-9262-f7b758f92736@nabladev.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 24 Apr 2026 10:12:22 +0200
X-Gmail-Original-Message-ID: <CAMRc=McSHzmOZ2DgyiZNVVaeQm7QVG1GGnwGAPXUGdh7hPOS1Q@mail.gmail.com>
X-Gm-Features: AQROBzAG-xAt8AEYFGjNvp6vhvTiAxquIjQSJZgzmzuphSjEvPrhT7GNNjEaJHk
Message-ID: <CAMRc=McSHzmOZ2DgyiZNVVaeQm7QVG1GGnwGAPXUGdh7hPOS1Q@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: eeprom: at24: Handle EEPROM with both
 read-only and wp-gpios
To: Marek Vasut <marex@nabladev.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: linux-i2c@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 9:15=E2=80=AFPM Marek Vasut <marex@nabladev.com> wr=
ote:
>
> On 4/23/26 4:19 PM, Bartosz Golaszewski wrote:
> > On Thu, Apr 23, 2026 at 4:06=E2=80=AFPM Marek Vasut <marex@nabladev.com=
> wrote:
> >>
> >> On 4/23/26 2:17 PM, Bartosz Golaszewski wrote:
> >>> On Thu, Apr 23, 2026 at 2:04=E2=80=AFPM Marek Vasut <marex@nabladev.c=
om> wrote:
> >>>>
> >>>>>
> >>>>> I see. Ok, please send a v2.
> >>>> Does this patch require any changes ?
> >>>>
> >>>> I will be sending the DT changes separately.
> >>>
> >>> Sashiko is saying this:
> >>> https://sashiko.dev/#/patchset/20260421140755.54222-1-marex%40nablade=
v.com
> >>
> >> What does this mean ?
> >>
> >>> Shouldn't we report the device as read-only in sysfs unless it was
> >>> "unlocked" with force_ro?
> >> This would be ideal, but I did not find a way to toggle the "nvmem" bi=
n
> >> attr permissions at runtime. Is that even possible ?
> >
> > Right, it seems like it's set once and can't be changed (Greg: correct
> > me if I'm wrong).
> >
> > Ok, nevermind the comment then. Maybe just split the changes into
> > nvmem and at24 changes and I can take both with an Ack from Srini.
> I have two more ideas I would like to run past you ... how about either:
>
> - If wp-gpios is present, set the device as default RO after boot, and

Isn't this already what happens though? nvmem core requests the GPIO
as output-high and drives it low only when it's doing the writing.

>    let force_ro sysfs attribute toggle the protection of the device back
>    and forth afterward. This would however change the userspace facing
>    behavior slightly, because right now, with wp-gpios present in DT, the
>    device is default RW.
>

Or do you mean just the file permissions?

If the latter, then that does sound logically sound but yeah, it's
asking for a regression report. :)

> - Introduce new DT property, wp-gpios-default-read-only or
>    default-read-only or some such, to indicate the device should be in
>    read-only mode by default. That would mitigate the downside of the
>    aforementioned point, but would require a new DT property.
>
> Thoughts ?

I like "default-read-only" and it both allows to introduce this
behavior and not break existing users. Let's loop in DT maintainers
and see. I'd just like to clarify if we're talking about sysfs
permissions or GPIO behavior here.

Bart
