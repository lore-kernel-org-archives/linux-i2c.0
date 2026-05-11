Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FFA3815D0
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484319; cv=pass; b=K0McDW1StttHXKXljupEpnpCU58Uhj4UGyBSS5lEj9frgqqXcd7OH1RfFJpMq3Fq/+02/jF/ODgzcNqnLwOo11h+TNAZfUqVJpSc355QiN9oZ4lFydOtJ1T2phS9rUkHQXRPU9bLvB5MpPgCh5EMF9EvL2AAO0ArAQm836quA0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484319; c=relaxed/simple;
	bh=WPIR++09QQ0jKO5GREGgLT94QitCwjpX35YmHLkPHWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqykwrC5ShBJT0tlsBkSEkNCBmhFl3E/iLhoedtRL5jMnxTQVsySIqekmSjX5SGTLiEbUUFAuDMiLzjbYT9LDPlY/fy6r+OgYf/vXQcUcroUYeoP0CcS8QeLDGuwjfxc7dNlqsHSgq8UuAvb6Fih7hacoMaZlGC5ngGoHmXIaCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tM/jlhCK; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM/jlhCK"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67be41d5eeeso5895888a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 00:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778484315; cv=none;
        d=google.com; s=arc-20240605;
        b=L+ZgFOgeCo8ULpF9SD/DnizE1TQRF46cAn0F13e3vJSnvkDqpAVdHYc1CDNYFZfRnc
         QH+yS+jrGsj+TZ3u1xgfGC4zBwd1OumuxVSmueFwTj8bxW9dCoGRiYXqt6iF5ETtt9F7
         2+0is7ShYD+c92knkzcEtA86wubFMmoaEe6zp0t1Qo5j2L3oczBcrnbGSbZQTBznd2Rq
         KYZJz8kUXdzWOOEb53kQnFzJNR3ukiAvZu83gukcfkMruOKB3r1S1HhjxTafoAyVV9oQ
         fvOXxDbhaV0p3H+1mljXcW6BbSZucdQEaaEoSDklHyShkiwPkzqbIIr7/kykC3W4sxk0
         w4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WPIR++09QQ0jKO5GREGgLT94QitCwjpX35YmHLkPHWU=;
        fh=r41Sz94sGrpi9D/MGeBvFA/PmXIpGAmVpLfuRk5dLZ8=;
        b=dgPXp8BFtiqn3tHGAH5NHWRXxK33Vv31xn8NRwwELd0HFcqfrdQhvExKElK3x/gqgd
         5Jqwr6RfjkN/vBBTwA1ryypH98ZvDmzsPDSrWy+Mpn4xb66GqBQVADr/5cvGLLfnlnBf
         Rwvp9aDMkwH2mXxUfVb5kbkOHUyZskEwp/qrDGZvsb3udj73COvYu3a/7dJwFrD217rj
         IXoSSoesJnpn37OQzMILcOz6728+ITWXI2YMsdOGgitpk/RjYvTobaMeAy9ArvvMaEyQ
         4A85eRvhNC8f7dQw0HSU3aW4x4KYPMaGkl10Gm+4louvVntVEtDoWB3ZXi682l9HhxyY
         bRWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778484315; x=1779089115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPIR++09QQ0jKO5GREGgLT94QitCwjpX35YmHLkPHWU=;
        b=tM/jlhCKXKYwxL731D8GE9f7vmJEuvwi+e2oHxufLAqBbLEkkK7yLOxOXZ1HHnh5WG
         f2LRcxueLhB/b0nYRIV+33J+uORE04JH5Gd3GyYjwGkgcWUop5o1XLzhk+VjBYGaIPTv
         Wi1oR4PT1r0bfMgFs6uDKitMOgQUR+ehfvfrBpz7F75+uTtnxVfZIHGgaDOvA93XyOwG
         4PYzpCaCsfcKZ6m6XYRd7w3tv+7FRyk/qzXNF2aamPzC5jAfchvZnzlrdZbvqOMysBIw
         e6hiOxJqD+u/U5tMawnSpSDr9X7jGr8vySW/LyxN3pyV5G3lMpz0U39TMs10u9He3jTF
         7wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484315; x=1779089115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPIR++09QQ0jKO5GREGgLT94QitCwjpX35YmHLkPHWU=;
        b=KMJjSNdQDhGvCFh0CyZBEhojHfYRlt6FViHH8+OTYu/7YPy9uoOQs1OXivQaCyDtcV
         Iwpb/BSpOnG97W7GUWyIDhwpMKxFFs5x+CkwLbKAmLgYqOcYqsKoIXsi5vc0/9B5XugT
         6WBQpelV9pAgI9tSD3V95Oc5XtkmsHnkfBVJSnrYeVMAmJyynOOkBPmukmUsij4mHppI
         v3JKiqc8AUnIL8Qer9PTuaqtVoBfoXl0NsrhGSHOy809HaT9awh/f3E7uTy8zGMpJafP
         YiNDl7vuyRoDT2PXTdwt9sGHBRJvaxV42DKctFQM6Pxg5iHWOKyk2eA+85PiZiUEUB/U
         depg==
X-Forwarded-Encrypted: i=1; AFNElJ+iif7CN+aRi5Oe11ROlGMLb1Mzmsg38xqG7AbEJmX5K3Z0cSvNbNYLO3MkrKfkx3QsX+mnVFYUYJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaF0xtoyVXCosWNc+1pAFqSzSBXAmEKUGrO3QsbXrARKildie
	yz33To4HG2wbTfeCmkcwXpYfB3hfLBX7ZMKD051PypYn81DaX9VWzEyKsKhph5KND0LVr9/niKV
	saA0GejIG/DTK5VGqm0lQRklXwPlue2Pl6p+F4+g=
X-Gm-Gg: Acq92OG6iHsGvmsYSNFgwNJatrpnp4i3iJtLOZkG+2pgmeC0toKu+1admsSQuLTsiWh
	OFtgq0ZbKtOyzpo1/6Kn1x9wPn+i6bnXP8GZSozaosnqqQ6JBCdw2ZgXzCPuxPOiboF6cwE0M2Q
	8rfDezSqH/MhIFasNHJX7ZNohPC+7mfT40F/XPCguwNAQUiVJ8ndODAd6cbuDTaTw7uRaPbcl2C
	O+EuC7uSNL0pN7gsQBzlKT5+yvSzyuV6S3Ws0aK7SI6FsZ9tMjjVjUODLi/E3oIWdxhp37kAuSw
	i9rhX69R
X-Received: by 2002:a05:6402:a58b:10b0:67b:8974:1cf2 with SMTP id
 4fb4d7f45d1cf-67d6489fd27mr9200739a12.26.1778484315242; Mon, 11 May 2026
 00:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afiNrr4Llm0LWw-5@ninjato> <20260509091208.18346-1-jie.i.li@nokia.com>
 <20260509091208.18346-3-jie.i.li@nokia.com> <af8IB46ST70lXVsk@shikoro>
In-Reply-To: <af8IB46ST70lXVsk@shikoro>
From: =?UTF-8?B?5p2O5p2w?= <lj29312931@gmail.com>
Date: Mon, 11 May 2026 09:25:03 +0200
X-Gm-Features: AVHnY4JTLQTwre4BDMy5zIVUfyhZspJrBjZiGJN2Wra4LJy-KKsI_b-Tt462w0U
Message-ID: <CAO3NRJg3wPVLgnyd=eD=TkkS5J24ww9WP3nNuiCnCL8=aLEmwQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: core: support recovery for single-ended GPIOs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linus Walleij <linusw@kernel.org>, wsa@kernel.org, linux-i2c@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Li <jie.i.li@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the heads-up, Wolfram.

No problem from my side. I can send a v5 rebased on top of
b47bc7c022dd if Linus prefers, or leave it to be resolved when
applying since the conflict should be trivial.

Thanks,
Jie Li

On Sat, May 9, 2026 at 12:10=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Sat, May 09, 2026 at 11:12:08AM +0200, Jie Li wrote:
> > Currently, i2c_init_recovery() only assigns the set_sda/set_scl
> > hooks if gpiod_get_direction() returns GPIO_LINE_DIRECTION_OUT.
> >
> > This logic fails on certain SoC controllers where open-drain lines
> > in a high-impedance state are physically reported as inputs. This
> > leads to a "deadlock" where the I2C core refuses to assign the
> > recovery hooks because it incorrectly assumes the pins are
> > input-only, even though they are fully capable of driving the bus
> > low for recovery.
> >
> > Update the recovery initialization to use the new
> > gpiod_is_single_ended() helper. If a GPIO is configured as
> > open-drain or open-source in the firmware, it is safe to assume
> > it can be used for bus recovery, even if the current hardware
> > direction is reported as input.
> >
> > Signed-off-by: Jie Li <jie.i.li@nokia.com>
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I overlooked that the change with GPIO_LINE_DIRECTION_OUT I suggested
> for this patch is at the same location as commit[1]. I already pushed
> out said commit for -rc3 and it is, thus, already in -next, too. No big
> harm, but there will be a little conflict when applying. Sorry, Linus!
>
> [1] b47bc7c022dd ("i2c: Compare the return value of gpiod_get_direction a=
gainst GPIO_LINE_DIRECTION_OUT")
>
