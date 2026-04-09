Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CA3B9D99
	for <linux-i2c@vger.kernel.org>; Thu,  9 Apr 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752641; cv=pass; b=D52Mf3g5TVR4VXre53t17RH/Kd3wKyCyFdZyCzx4F3dOMai+Bgq0Cr/reXBEeOQHST6Mx4+YIYCKQ3iJx/oqOMcfp1paAF7usHSPv60bun9uj+XzFihldkLFZM9hVZbiRbxaE3fvImLYd4sCS+aLqxQMK/ZBmVs37ijThKND6eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752641; c=relaxed/simple;
	bh=0/YeY69ktax7xAvFlmlWRIB5ZF6q0vZYsf5nGL0qfHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6rDs+tW9IUBUvVd/Ddb/fj2uTmM4UvOV0WowusaATn4Uy87p4n4lgKtJorAIH31mGJ4pGN93V33YtRhzHhq5kIwuoFcMIoSQ8vdDPH9RnF7YRNWrJ1xV2Fbh4sDWvYUUYOpFIk4WjvowrJOsWSARvQDcC1UjuXBPHyCHr9ufp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2WlRB04; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2WlRB04"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so2206672a12.2
        for <linux-i2c@vger.kernel.org>; Thu, 09 Apr 2026 09:37:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775752638; cv=none;
        d=google.com; s=arc-20240605;
        b=SvOW2/qKFzcaKhis8vuyCTvVjFUszzpBLKPiFLH0DSvCQ3T/vcMW6/OMiAnDkfnpRW
         GB2CF2/Du3eP6EcZLSJmULzHF1HIWaUsCYFKRFV8KGA9TaUSDxfrvtwXU7DRVHTQ7FEY
         fZNDj5RwRDdXbkhlV9N3jkFdbqRF80EgZJDqLwTapz9kik+K70FAmi8nYpSvZQfaNrFg
         ahToMZWAR/7+7L8fWgQCneQtROESBLjsJ/7YTdk0qI4R7dEddEEbChvbwSjf6uuIrVOB
         3Y0xytpVOmgkYtH7cQmOvGIKXIl+LQrerVuATKFLNKcO7F21w6bqWAZZeem5RgqeQ4ym
         6h2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+UAGY8HPWBNZ5o3qgVOf3XDwl3FBEuhdTjIiA2jewZU=;
        fh=oHpBUik4DAC14oPnO7Vd6vt0cmg1QfBgdj77jDoP+q8=;
        b=Wa7BsPv1fmMiID4wJGUAenxf2m67d+mLUTEvhxYUu1/iRdaSBekrOEVGaZJEo5ooWr
         gU/9s7agsfNI/gdIn6JUJpFpO+FI+rIw1QnJ2u7OZEnSLO1pu7vxK6tECk5r1wktMqGL
         /gu0Lpm1vkizwM4Ho7o851k/sMIVL+35GlWtyZtdZQGhKXLxLEiyl2KYX2TWnftXaNBe
         cPpQywjxwRCGOoF6r/S10IDywRXbgomlkP9chZSuDoA460ItECIH8ZgbAKlQ6+MJlD+X
         DT8Yq1/cvu5+/7o2WYZC2k3w+iIHnW6m8+7Uiud9/sgW//vVVN4NBnuWXt75Op3AYLWz
         jicQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775752638; x=1776357438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UAGY8HPWBNZ5o3qgVOf3XDwl3FBEuhdTjIiA2jewZU=;
        b=g2WlRB04I9NdWkCI5EIbZgKgPbH/UuxOCaCaK72rSr6QXHsHO04AmcsSfnEs4pQTgD
         HGXbor73gWk8C6pjFpCSgs6zfWktmElumo53unQsfyYUMP0njx3OJzzpzARfX0HJ+QkU
         DbpNetQvGkTbvQ8pF572zXdtECBTHHowIprd5QMLsPEcMUmLEeNuqTRSJv9eeOMKruTd
         FbdBqnxHBlPpvOIYBlHefFP9x9OTmdMzODChGbVZcmZYR1BPIMBBCpHkYPAejUpI1SNb
         EJXukkPSfnYQj3Eqi+Vqb0Ak7bkiBZGLXEztPsSdomNtbI7C6Ff8FVvIIdJrLdTGpe+p
         tV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775752638; x=1776357438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UAGY8HPWBNZ5o3qgVOf3XDwl3FBEuhdTjIiA2jewZU=;
        b=LGoNnCYF6tctjoKCWvBe/gFIKtybXiAC4+7DeR0WMeT94iOHlsLHr6GZliywg4Her3
         xxzbu9hkLVVYLLHtlDz7sFK/pPCg+WWRkFTdgiLv765nS/c8gnMu7Qp0WlQvxTklQQyk
         3n30Rb9BfRnUZjn2tLPPPzm18g9SVIJwiOpZ367bF33RQe1iWs4MmOqyWxDT6umnKqS8
         Wdq+kKFYFlLIRukdCmKkUAWZQFbzMo+m4JLGTqkdJeRR2ETvKcODSQ3/V1Au0nMWID4w
         lexNhYbweLQ3Hwf1DcByx5bdp6+sxSnN/eIfmBOXIA1z1G1bXlBxD1ULcWmnxsfsZ1FB
         Omtw==
X-Gm-Message-State: AOJu0Yz7xQRFuHfeVBb3Av92hQjIgMJYXCjNbFrTI7V6qtJY88AbCQXU
	T6MSIV0tXSwnIdYqWABeX9x+j8O9o+EZJbt6gKq1JA0fDDjcRGX6mn0vouD3abPtnLx/JIMa+9v
	Z6YtZMQa17gdHk8c+wJxfdAGfTpQvDy0=
X-Gm-Gg: AeBDiesQF00R/7DSyGYadEFIao9IpKD/0ppsf2j4n1JuJlMj7BNa8/kmiVncEZ+XW9K
	15D6CZh8+ZduozzG3ML2qRzxaikOUPnOq2lo+TH5Og0m1KJRkZlsfRfnJ8SXXdUXnRu1KsEVn9a
	fuJg1DJQvD1OTyAdVwaizwiPts4BVPeMyTZoawjprTMg98pUwbebQP5RZoBlSuIAs1wcMM0cs/B
	k9MJg6+KQnTVwzzJK9w0AMSPAc96RFXjQjMo4iXKbZdhpCLUx2YgwNRg0NpoKTk8WZYu/Ze4/jZ
	ULwJiJVW8z2GWIo7Wuji21ZDAh2wWJMmpoZlxWPPP0fpdrhKs6LPMvuNp2AqA9vbl630pULlPPX
	CvSM1SA==
X-Received: by 2002:a17:907:a2c5:b0:b98:427e:218d with SMTP id
 a640c23a62f3a-b9c67957b5dmr1371549366b.25.1775752637713; Thu, 09 Apr 2026
 09:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327030310.8502-1-rosenp@gmail.com> <adfTdfty7q0nygeo@zenone.zhora.eu>
In-Reply-To: <adfTdfty7q0nygeo@zenone.zhora.eu>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 9 Apr 2026 09:37:05 -0700
X-Gm-Features: AQROBzAopIFp8uM7IAtQmj1wGMGJ-yWga8r_OUIuPCkKpKHali845xMLuNe82Bk
Message-ID: <CAKxU2N9tkjDeE6Zz6diMEMT4uNzYg4D36gow0BTbaC=AyAeT3A@mail.gmail.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 9:29=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> w=
rote:
>
> Hi Rosen,
>
> along with Luca's comments, I will ask you for one more change:
>
> ...
>
> >       /* Protects aliases and use_mask */
> >       spinlock_t lock;
> > -     u16 *aliases;
> >       unsigned long *use_mask;
> > +     u16 aliases[] __counted_by(size);
>
> ...
>
> > -     alias_pool =3D kzalloc_obj(*alias_pool);
> > +     alias_pool =3D kzalloc_flex(*alias_pool, aliases, num_aliases);
> >       if (!alias_pool)
> >               return ERR_PTR(-ENOMEM);
> >
> >       alias_pool->size =3D num_aliases;
>
> this line is not needed anymore because kzalloc_flex will resolve
> to alias_pool size and will set it tu num_aliases.
I believe that only works with GCC15 and above.
>
> We can remove it.
>
> Thanks,
> Andi
>
> > -     alias_pool->aliases =3D kcalloc(num_aliases, sizeof(*alias_pool->=
aliases), GFP_KERNEL);
> > -     if (!alias_pool->aliases) {
> > -             ret =3D -ENOMEM;
> > -             goto err_free_alias_pool;
> > -     }
> > -
