Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4001C75F9
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 05:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325546; cv=pass; b=g4uAXvTE9qFzskWefz7GY7Y4I7k/oPsEFpLrC1z0naqVwNPPr8IT3qUhCWQw5l8mc2NMyjBm1MO3O4BoL7gwmGhf5qy5O79odlZFYQtNuVPLHZAiGmT1cYs+luJm51K09iYl/RNQ98/3cpX25eeR9wWWPv1jxosrcYQhBJM52JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325546; c=relaxed/simple;
	bh=NLHqvXto+f3RYXsUmTwIi3mwg7y/IwmK5K15JRyNzIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxkznuxY5whRykH9xgJLwWP/+oMrDJgv7eXX6a7spL6dnvwSQ/ou6t6giSWb89Wui2X4rhr9Ds38PSuXmXqkF5WElx+njtliWkANBd0t4nYaTupOF2GgDbypok+pMpTR9tG/bzQgDUSz9rkCq3Fzk32YUX98Er1Dyil4iTdSX8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+3L2msJ; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+3L2msJ"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a1981228f8so5900401fa.1
        for <linux-i2c@vger.kernel.org>; Tue, 01 Sep 2026 22:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788325543; cv=none;
        d=google.com; s=arc-20260327;
        b=mWG4sQxlr23tYwqp2mRw/NsKvPV59ApHVyPQmBREKWUv1bil6m6Fj4f0EAw8PtuulC
         pmoc0cHlplfefImogzYlNk1OWEZxG3VBir1TKyHc2e60gEf7HpUtMwFXT75tQny2j348
         qrqdTX+rz5atnlqcE2XsQTZWb9UDPdFLOws3PH+pRuLvITGy0uhuyhDcfKuMVSInO3Eo
         UQo9cptaA7QBtpzTtpi3gQoZeKtG7OKThKF+ugP6krUHkCHABujtOc1nM3E6qCf/fyNz
         1DRFr10DXNGmflLQptDYztU0rbK8KG9UcgFqgXK4aa4GlzmfCyDg9HRIt3F1bGD9gnem
         xYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7nkXBkEBfR4l2iwoI8t7QwAJBhpGhm5orDlZN2BZ1Zc=;
        fh=1jn3ZD3Zmd91cEiJMaOWUKRisYYC0cxah/WVRlhKPqU=;
        b=JQK2eoWTuBnYnL2ADfLF2r15Kek37B/V/m27pvmWDZ63DCibtKd3kyPowaolJ47PYm
         3aZvoE3JsQy0//Kgr51bse3oMkzysZ0i/cJ8RKtKxl2NDeXaCEtayAAU5KKyfzx2B6M6
         8DidIGofmfIXP0qC/eKGQw0nbtWYEBWwsWuigT6BZOj+0X/wVSJKk4ZrGWzChezWp5L4
         PO1hLjgqhbu1PeNpzCncksFqvvl1E9JgIuGjm/Z7TTRyjj5YsIoJmWWk3vwau1OZP7Md
         TlJ7ja4tnvjyu3+Nph4ExoMbrMbjjg08hCNR157GPZUrDOTDNTGwfTgsgUulaRm3qv8M
         k3pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788325543; x=1788930343; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nkXBkEBfR4l2iwoI8t7QwAJBhpGhm5orDlZN2BZ1Zc=;
        b=l+3L2msJAclDMylMVngKESVYDuDdURyx2Mz0xwSZRwUENOISs+SVYaKdmAj6a0vj/Q
         U3LuYg6FXLS0q95etYUfeekJlW+VYIllaTiWRFZU0Cpiu1b5dJi/yvoKH6nGD1+tAMIZ
         uUN4w4fU0n9u/PBHoTpvdwqOdpEk7AWyrNdc2KnjejONHMRwaWgwNG3TpHE7KRFYNZuW
         Fw7BZoaB1Ft7Qrn2Nw185WB4mIKLu5oab5NzaskwOlreLKesmeOz+JNWD3fZ7dHv/cfN
         /+Ux+ats7H3/JrMgzHuwqbilYa9m7LjF9qdjWB25m3q12RwFHmWwLWxvuskoxe/BUuaA
         T0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788325543; x=1788930343;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7nkXBkEBfR4l2iwoI8t7QwAJBhpGhm5orDlZN2BZ1Zc=;
        b=crYu3+KRw0LsMJFMGMFoTJ4bhtRHZPgicyn6HM+VwQoglUdOsf03DyO9zvEIosKVow
         11q+RrR3n5de5ByRglHQFEVBUda+LrBfx8l5HA7BGILGZryJzcWbM8c2UVHFyEuAkdDb
         xtAEmcDKv4kZMI8Zx99c/DsBsXGpAa9gN7E5ApEDyoPD9dTZYJFOUGAXuh9iDzDp1uVO
         THl62oBUDvcxfR5omoWPVsMVpZHAYpjL/2XiQNXpRDPAgf+0VR1cKupe9/lt74cXwHtD
         TMISQNFJ0VCP3DTnSRzhSKR7fNqyleoosklgjgzjTj8nZH5AROIJ2U+qORCs6/n4pTNF
         +A7Q==
X-Forwarded-Encrypted: i=1; AKwUvByVeIy9SzdfSJQgS7dkPpyx5L1H+3muFpUtSzROEaGzXb9e09uIxVXXTeP36WoD8xBwTWJy1qaPlIM=@vger.kernel.org
X-Gm-Message-State: AFuF++kZEIO44pi2kTYQJHHCoT/24Z7IQVpPh23TpGGL5tCFmVtMeQaw
	v+miIJudJiFN8MuqFbwvsG7x6rqaRqKDHEJfKOeBgF+db9edlYpoD/prF1+2Sz9j0J13zGJyjoT
	1cZJtEdeMDm90gFeDfAKIhcWqHWLM7+s=
X-Gm-Gg: AYBFou3SIn+qgHxCaQAL/v7+PXJm0BrLWtYeTdNx4rkDGKw8jvrdGWsz4a0Ogg63L4X
	0bxifpcT7Dfm8n+wY61n0GgGTpxZO1/V90s2W8OZKzaJRV0zVPpdFETvx2BsjQrwbAvf3UcURbP
	gBv0d4ACX7C+Xxg7i1/+6qUlBFGF3RPFM1Q9OOI+GAsNpd+PIeOK6nYpo5V3o5LwD3Gd5TnuBF/
	d9SnDE3sGPhKKQtnhlSnrBPu5h3KFfh30VCQRSZTuGJDjrNKyGBAGGkUk/IGohVMvwn05UVdMCZ
	SpJKsSzFdhYiq8Jb3NPl/IwOq8yTxNpTomC3bGsHr7IlZpU=
X-Received: by 2002:a05:651c:a211:20b0:3a3:2a41:c0c4 with SMTP id
 38308e7fff4ca-3a34ffdf928mr3036391fa.14.1788325542808; Tue, 01 Sep 2026
 22:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
 <20260822062725.60519-3-muchamadcoirulanwar@gmail.com> <20260824010726.2849f3d8@jic23-huawei>
 <CAO26r3RLnX4HXrKDF6akmG722Q2CvDU-uJ40Yfuu_wwJdGgA9g@mail.gmail.com> <20260901021420.144a64d3@jic23-huawei>
In-Reply-To: <20260901021420.144a64d3@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Wed, 2 Sep 2026 12:05:31 +0700
X-Gm-Features: AcwNN1VwSx9iXjAYtJBmAc-tUFlWH0dfDFzrjPh6nAYPikoQ80HU5nlzzOFlAv0
Message-ID: <CAO26r3S4t0GCAep7J1suedPZZA85=vCzrWXA4wR=Lox7wceVDw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/3] rust: add minimal IIO subsystem abstractions
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	brucer42@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 08:14, Jonathan Cameron <jic23@kernel.org> wrote:

> > > > +        Ok(IioVal::Fractional(v, v2)) => {
> > > > +            // SAFETY: both `val` and `val2` are valid per the Safety contract.
> > > > +            unsafe {
> > > > +                *val = v;
> > > > +                *val2 = v2.get();
> > >
> > > Why get in some places and not others?  May well be a gap in my really limited
> > > rust knowledge.
> >
> > This came up in v3 and I answered it then but forgot to add the comment
> > as I said I would. IioVal::Fractional holds a NonZeroI32 denominator to
> > prevent division-by-zero in iio_format_value(). NonZeroI32 is a newtype
> > wrapper over i32, so .get() is needed to extract the inner i32. The
> > other variants hold plain i32 and don't need it. I'll add an inline
> > comment in v6.
>
> Ah.  This is my lack of rust knowledge (and forgetfulness).  I'd avoid
> putting too many comments in for the benefit of folk like me who are
> still failing to find the time to learn rust :(

Fair enough, I won't add the extra comment in v6 then, I'll leave it as is.

Thanks
Coirul
