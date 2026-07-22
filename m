Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D27379960
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711179; cv=pass; b=YFqnkpFw4At9x3lQRKwd0F94oIe72W4Ubcz6bS0RRzZi6fnekQxPvKAgooC/0SPv551B9z2zS8Ne8Y6Ru0pdxGxWFEYeIROIDix0sdAcAgmOknSwKwqyDklNtiv4KabxdWPidnN+d4ZokgK+u4kCE5no1lgI0+jweaei1uX+hK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711179; c=relaxed/simple;
	bh=BLf9RFIv5pi/wJMaN0h+Ctg6fapOu6Q9G57hFPSuT04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm83Yth++Qr4MZA8zK8GBGrFr8DOrVqvP8byHikJ2bVeLDPeTeWQf8yGNt3TkF5DaVajhEZYLZouppE/d1Q9h4A2qZDtpgcQRbkmS8TzU/ciP4e/GKdYrty7fG8hP+qNHhDGWoG55G7xrtRhQV553jWXBr3slb2f3NylsWoTzm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kPihRLOv; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPihRLOv"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6682259cae6so6216090d50.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 02:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784711177; cv=none;
        d=google.com; s=arc-20260327;
        b=J1U7xMashRqp9/0AhwLH7MAX0viJ4DjOmU/CHDuTsXfzDIRqQ52KWVT55sjs8vjzwg
         w1Vomg2+CPMIh5rRpSf4W4R9PhV4LpB4ZSxXEhFMHwA60aYUk7bVmY0sx+nUtRSQaTPv
         qOcLhQCx5X9Q1jJXvmHi46IaiT+K+ugI1P7wEXXWAN0OZmzpOEXZo7zAsbJej5J/j5NU
         vgXdyXelxIYxdzgq6LtMhp71/xoAusxUQktTRXUNJsuVDvT39y9OVbYKulHA0inIOPCm
         lhvXH8Eh8LOF3xhRcua3YLq2g2akQLeNR0DxQBQBBsrZP17MNrKxbkOdbMPY2OYKDOls
         6mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fzc7jLJOwKFZM50nrRR9HIoeoA67mID89Z/e+R2bL4o=;
        fh=XLx2EI9VxOZ0Z2wra/K4Soasq/q/OfwSivvI9/KnWD4=;
        b=n07QyDZocyDMNLnP2hINIv18M25xclCKgZgjwjyM7QO8kEVZ1t2cwWNPxU7SrAtvXx
         ggWMpaGtkp1OPrqVPjHV0KHokDCIhvR6OlUsETEZ3pojPr/Je9SKueTPdoS/IovREXTL
         1CPmubNdQd5xeSlkyVR5kHpz39bHIMjx+TqJzlQ9VgzToaIhKx2D0ZUr209Fr3wNAU8K
         ksN6NLqL+VqlWfVMnViYe3dEIuYeF9IhJY7LkYU0AvcaCP9BE6FPM16TIP9Mdc9mj2F/
         MsGdnxEQ20VhIZG3gysELUt6ghHRpBLjyH4zZhn/W7ZrIDkiWQTIgwiV+yq9QAmHN7cj
         vNZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784711177; x=1785315977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fzc7jLJOwKFZM50nrRR9HIoeoA67mID89Z/e+R2bL4o=;
        b=kPihRLOvc9nNrQgH4XazHoHuE2iqpX+vJGu6Pr49lRHuhJTmoKBaQNvid7LlV31955
         7E2pZRieWFEzZJnqzodaIWODl52P0OlTgYewDVWUwy6XQMRUgLkMOjnp4+BbI7qpOReh
         /xtwXA94fcpHMRRkyOvCJTOWRaayyhcLhclSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711177; x=1785315977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fzc7jLJOwKFZM50nrRR9HIoeoA67mID89Z/e+R2bL4o=;
        b=B6Nc6gZ71GzRqnivU3c2oqqrfg/eydJ1YvcD0lvCEwKP/3zGaoygy/lA21R3iXGNZx
         FEZ5yuz2M5Azr4eNiLoOgMqLAafuIjL1+EIbzt5DmTgP44LzPSbiWetwX8gwbFWSn5qR
         +shg8sCzakYLB2xvhAxQ6XInMtRvtEriQpBWlF9XwyJSQLhDlKodSoYkGgTK+rWRRiPA
         iK4UhZvpNme+6BCx8GLIwUaaQ0pN/tCJ0uufcuGstZArHiIl/2hxP9R3ZlDAIn2erWyQ
         QXZMqyHpHZCuPLIHBlVDBlePSU9Pr0Ftn34xKPZiKa/dESYRVqG+a0E8ttGC2ryD7hpu
         UDAA==
X-Forwarded-Encrypted: i=1; AHgh+RrkrrOxHW+w4i2Z13cexAXM6ErZHT0f+0fT1Dgy3+xwUh8CY6KLGIFbTYuUUz5nfdnNgrv+0+UGInI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDGSpoCCeldoYk7jMrk6386LFSHyRMH/CnNtew3HdNcwUYM/Ph
	YgSKLpQIIGJom4fRot7WDBFe+QnACfSYA0noEovRoTt1/Nj8eq1+E0rkXojAkF2dK8f2nSo0zek
	wZj8bOTnkU+F34BS8zFjMnaZX85w4GTo2jI+jS03y
X-Gm-Gg: AR+sD11tK2Mfgp4afhWOnC8WoBUkqsiMLqMTGlYsTeoU3LphSajDG3vOrLaEXNkGKt+
	xy/YhS4FJ5cDSIuxFMQ54vCs/5kJWMTVOEFYMN9CmVLK2e+QcWsNVr6pIK1XAQWQvD625U0ufiX
	f6/sZdqxnfgj6tafko+a6CUs99kTpbFUnwAieGbknxprYV6MWzqxR6G8u9HvAHisB3prhJTdX0C
	wybtsltfsyiEedwsly30JqZBt/b74NyUmVjsqwdA9fCIG+kD+Paeno3s/KQ2QT2sAMQ3iOu9tv9
	QrjTdnW2R6dPjI7d
X-Received: by 2002:a05:690c:6c8d:b0:81e:6d03:40cf with SMTP id
 00721157ae682-81ef26ae40bmr73897997b3.54.1784711177267; Wed, 22 Jul 2026
 02:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721075226.2347933-1-wenst@chromium.org> <20260721075226.2347933-2-wenst@chromium.org>
 <al9BwHbG5IX0mIem@ashevche-desk.local>
In-Reply-To: <al9BwHbG5IX0mIem@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 22 Jul 2026 17:06:06 +0800
X-Gm-Features: AUfX_mw54F9BihKerjVbrM-HX0v6EAfSTuk3G7vvEfoFi_SJki_3pQoN0j1OPTM
Message-ID: <CAGXv+5HXtSovddkws58oUfUcucC3GKqTt-GgvXs27ALFjyFRrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] regulator: core: Add "enable and wait" functions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 21, 2026 at 03:52:15PM +0800, Chen-Yu Tsai wrote:
> > In device power sequencing and initialization use cases, it is common
> > for the driver to enable the regulator and then wait for a certain
> > period of time to pass before continuing.
> >
> > In cases where the regulator supply is always on, or has been turned on
> > or left on by another consumer, the driver could shorten the delay or
> > skip it altogether, provided that enough time has already passed since
> > the regulator was _actually_ turned on.
> >
> > Tracking this requires support from the regulator core. Introduce a
> > "last turned on" timestamp field to the regulator device, and "enable
> > and wait" functions to the single and bulk regulator consumer APIs.
> > The existing "enable without wait" functions are then converted to
> > macros that expand to the new functions.
> >
> > One case in particular is not optimized yet: a regulator left on either
> > by hardware reset default or by the bootloader, but does not have the
> > "regulator-boot-on" property set. As the enable timestamp only gets
> > updated when enabled by a consumer or by the core, the first enablement
> > always needs to wait.
>
> ...
>
> > -/* locks held by regulator_enable() */
> > -static int _regulator_enable(struct regulator *regulator)
> > +/* locks held by regulator_enable_and_wait() */
> > +static int _regulator_enable_and_wait(struct regulator *regulator, uns=
igned int wait_us)
>
> Hmm...
> This comment a bit confusing, perhaps adding some lockdep annotations hel=
p?
>
> ...

It's already there, just outside the diff context, the first line after
the variable declarations:

        lockdep_assert_held_once(&rdev->mutex.base);

> > +     if (wait_us) {
> > +             ktime_t end =3D ktime_add_us(rdev->last_on, wait_us);
> > +             s64 remaining =3D ktime_us_delta(end, ktime_get_boottime(=
));
> > +
> > +             if (remaining > 0)
> > +                     fsleep(remaining);
>
> This style is discouraged as it makes maintenance harder. Better
>
>                 s64 remaining;
>
>                 remaining =3D ktime_us_delta(end, ktime_get_boottime());
>                 if (remaining > 0)
>                         fsleep(remaining);

Ack. FYI this will be rewritten based on concerns from Sashiko. The
wait will be pushed over to regulator_enable(), i.e. outside the scope
of the lock.

> > +     }
>
> ...
>
> >       /* private: Internal use */
> >       int ret;
> > +     unsigned int wait_us;
>
> If you want to make it more private (the above is only for kernel-doc) ad=
d
> __private annotation that will affect how sparse will check this.

Nice. Will add that.

> ...
>
> > -int __must_check regulator_enable(struct regulator *regulator);
> > +int __must_check regulator_enable_and_wait(struct regulator *regulator=
, unsigned int ms);
>
> ms or us? Please, double check all units.

Yeah this should be us.


Thanks
ChenYu
