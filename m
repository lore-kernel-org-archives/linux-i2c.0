Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72D27FD4B
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741895; cv=pass; b=G5/xd4agLFrJiUszcczmzByvaKvpD1vDLEICct4kvWzLka3alYK0LmGqelfVcyTiReTzZb9QYKNyhJw1kIKIBsAep/hRXCs04W7UDJXjTRb5OtyILRTd+JZlz5PUWUCvNPbwNRMASMIyPacA8k/+oWut5mPts3wqtczo14RuvRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741895; c=relaxed/simple;
	bh=UxMJ/F2lB9mJJrynu//npxeqx2aElpyU8JJeKc5ehWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6oUzAbqvY96QeG5wCBGZRWPKYEkWkdj9Zlltq7qWa0jxTddjuNFVUkFkR5/sdgbJYNRBVuyyGLdrEb75tAwguUUdzQJV4vVNtNvE0Zlyf+gGeqyrYSW5JZEwPRpOFSekdfEnrukwRTKox6lGhXgbkJCK9uD+P6JMZjE/PbYhPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCJ4nwFd; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCJ4nwFd"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39f20d19895so21898361fa.2
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 00:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785741892; cv=none;
        d=google.com; s=arc-20260327;
        b=aBlA3Zud+xWdgF2EasT9BcpHPgjPEhwiqzwpEpP4zSv8/LhrbS95f6L1s/JeJxrfOu
         N5j6bpltPZAprPPaQ+fCGVlRe/lWQ8tZXmECsXeztE8u8A4IjW5bQUSQUe9qtz6Tp4ov
         UrObnV3supvfOQf+3qTvqny4UuRCt/sl9kjxVsG2MvFXZe/FLJy2FW9vyFaCe8d3qw3n
         HuAf8kaL5Gegj6ZHqEaFGRL1gMmxJSb1bn4vz3pHbjJ+nZPQSSZO0JjUOKnPqF48JU7e
         1apv0dsWLhGMHGywXieLXhFhL1FpFo6cAt4P2ZFGKz0MHGSw7iq22NppP+giRwWWHxh/
         Y3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PdyUQ4xcGPHc5vl0Zwp0XFzGelE8gGBuGNsLR1SwvOE=;
        fh=HVCjsAN8yC2EHZE1vWdFpUBjZ2EQzwW2vt+3yUC+nZo=;
        b=QerHGmCMIsFbdYhuhpOKZP4faP86u4dL6X1Dm6MeCZ8h/atQ2srnDjeJiYOynT63AP
         CMf80e9AJZcrMPgJoAB0d+VzAuBQy/Of6FHDX+TvvXWNCzVKz6osVrwmHEf1pLlhpXzv
         oOwTsLYgcEqYi/WJVhvmd6nxgyVZDkr3p1QXDkWOL9+fPORjw5HmpBWlSoLnglUBu6tP
         /jXDBqElVLV5DwyEcVDfik7VG9uaMdx8ZQWABFrEYqJ5YEQ57jceAMPC+9o7X0uF0br/
         NvAWHU4YV+gAO39UBpQTWF3/PzXvBwxstNiKTsp5XRgNKtp74anQcD+3gjmj7JwUOi/m
         ABUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741892; x=1786346692; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PdyUQ4xcGPHc5vl0Zwp0XFzGelE8gGBuGNsLR1SwvOE=;
        b=CCJ4nwFdYlk18BkWHb+zlaGdRskoaV/sEQrTJoVPFwafPPDGW96o0ZKZSc1ZqHTeO6
         QfiinGuxsl+lt+sKXkP4MJJZJtYcZbez47Nov5RYdL1CUm5cj/ami71fO7wRTH58eQHI
         h5hmRXSFJBCtk2qZmUwIUJLYUykLLn+3GqXvPl/S9G0Oh7shJEBZZGx+26t5P7HlFaUi
         h8lQWIOYSUSje02t78GaotsVwO+cMDohVhpAiGn3LPC3MYjULe4whcAhtwETUOgiRy8i
         EeApPk5cZM0sz7LyAsmnLIBbl7IEcDRPxv6ccClQ+w3XCAb55dsL7MUGwsp55u3ODgmX
         Qu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741892; x=1786346692;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PdyUQ4xcGPHc5vl0Zwp0XFzGelE8gGBuGNsLR1SwvOE=;
        b=MXNDWYeM+cRD1LomkUb2fqXLjvUzKev7Auuxv2Q8lS/3yO4cu9oQR+kcVrB7vVb5EG
         VSzo3IkRUdHJUcBAG0X+Em4bc7LLVe+X3mcd7tpI5Lbp8lChmJigAWUqqL4Fh8H5IYk8
         AmgZgqvQQIGN1UkhSRxOM4dhbPxvfa7ORAresy9L9qG10nZgIzPoWJ1qdhRfboBiTrSw
         OrXsL5mu0WEWEaURaQIS8coqqIXD3S2rQhN+4R/RuS+wcizQJb6RSE38MEp9Dx0Gh1Ox
         6iM+AaI7F6KdcgwU74+ezn+9J94nOkO4G/bupCZElfILtWbLhMWfVNUU+xnsWtVgIlXZ
         6y5A==
X-Forwarded-Encrypted: i=1; AHgh+RoLEhVaZ7z44IzboCOyu/lglQrAav5YM06pGvLUDi8R+TJtP3TbHEBQdpiX2BD4IWxTVSeYJHTsa5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqd/20TZ2quRF3tqMWenCjSugfYImZaiuMT8he+0OpiDWMnMB6
	lTNwLcRIn1sbpbIK461cqi+PXS6jsyirXVzW1wrcZaNXxUBdDvdzm6DUQhaoR9sbKJwxxlqOyrw
	VFHQGi6KEFGw61OsHxosKDerNHoDu0O0=
X-Gm-Gg: AR+sD13g/5KyZUKQQBU5jiNNBQufFKn6DjyR7WQNMfyrU2Q61QNKmTQhT8eXFnkG2sy
	dDzKDqXM8bR4kua/popMsAajiPu6qAb6SXtCpXIGpm7yD2iwDEQGF/VN9xCntuYIdgLoJoMT7Vo
	b7xaMW1yOJbWAQFaHvIBQVgPdTR8AmMQC5NMmEFrZia3NvJERUhRVh1HqMQWKNafHcE6nhL3Ydp
	NPXTs7VrKa4K2BW5ac3TAPJZWWqkI7ZVRShUifOHDJNkl5xmDH5ntt/d+Oi/XVYPvFwOfr1zW5R
	CGARUtyKqVvj5w2KkUqbvAGgdvzG1BbKS68HxD4K++7hAos=
X-Received: by 2002:a05:651c:43dc:20b0:39c:6e2c:23c3 with SMTP id
 38308e7fff4ca-39f8613cd0dmr11794621fa.5.1785741891607; Mon, 03 Aug 2026
 00:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-3-muchamadcoirulanwar@gmail.com> <DJVQDP9J54K1.AANCLIJC23YF@kernel.org>
 <CAO26r3QDbT07dTsMfMB8Y6H+qBzh-PQxgcTTVKqJ7C9yv-emsQ@mail.gmail.com> <20260803014308.35ce74a5@jic23-huawei>
In-Reply-To: <20260803014308.35ce74a5@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 3 Aug 2026 14:24:39 +0700
X-Gm-Features: AUfX_mzhU4wYhxOP2FAXZgZGaEkFuYq6L3OyTBG7NvndPDUEM5Vzh4T4eYBOrtY
Message-ID: <CAO26r3QYVUP5VgtrgwhGeqbJsWZbL=qFVVHvuRNXPLaYB7txCg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] rust: add minimal IIO subsystem abstractions
To: Jonathan Cameron <jic23@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 07:43, Jonathan Cameron <jic23@kernel.org> wrote:

> > From what I traced, yes. iio_device_unregister goes through
> > cdev_device_del, device_del, sysfs_remove_dir, and ends up in
> > kernfs_drain which waits for active sysfs readers to finish.
> > Please correct me if I'm missing something here.
> >
>
> That covers sysfs, but IIO has a bunch of chrdevs (though you aren't
> using them here).  I'd go for 'almost certainly' for whether synchronizes
> in all cases but we have found one or two races over the years.
>
> The way it is supposed to work is that the unregister takes the
> info_exist_lock and sets the iio_dev->info pointer to NULL.
> It also wakes up any one polling etc, and returns errors on all
> in flight actions.  Every ioctl takes that same lock and checks
> if info is null before carrying on.  The lock is held across
> the ioctl to stop any racing with the unregister path.
>
> I can't recall any recent paths being discovered where the
> lock + check was missed but we did have them in the past, though
> normally not about IOCTLs but about in kernel consumer drivers.
>
> There is an outstanding fix related to those, and read_avail
> + lifetimes if people allocate storage in that callback but
> I doubt this goes anywhere near that area of IIO yet.

Thanks, Jonathan.

The lock+check mechanism makes sense. AS5600 only implements read_raw
and doesn't use chrdevs or allocate storage in callbacks, so it should
be safe from the race you mentioned.

I will fix the SAFETY comment in iio.rs. The current wording is too
broad, so I'll narrow it down to describe the two separate sync paths
(kernfs_drain vs info_exist_lock).

Coirul
