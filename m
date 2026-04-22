Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137164414
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776883648; cv=pass; b=lEvNJiXcyxIKObwWINkZ3THemNQd+zgrOH+PhJ7AFK1NSLmhtwMpeZfXU9ZTrsYYyjVdIzUOe/51q/7fRM7rxyP0OgWMQI3HvJntJLneexRv9pqTfScwN15Nzfl4y91jeEtf7POOPGmaqfwZCP/zsRjQDY837AW5vDDOHM06nTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776883648; c=relaxed/simple;
	bh=koO1gTzJVerY/oBMbjuuST5CEbfWNHXW583XAUNa55Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAHPlApnLzr2AyArx1Q0Zw4J+O/juQTkSUP9er8ix5CNHnULJbCsIV52hZ9diSDvKqewzS+Jbr4D6vSdfBPkDgt/FUou1qDBGKX64M4v5NoTBzfULHrVvtXW/oaT0mUxhpPZ4ByfqJ+mSbkMSfzr5l4Mc8U5BlH4nkxpxG55uX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjpyRkox; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjpyRkox"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba5b107eaa2so369211266b.3
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 11:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776883645; cv=none;
        d=google.com; s=arc-20240605;
        b=YK0AGPJq7eY1OTidWhO+BphqisCkEnTiwfBU2rc5+Jv2IVyDq9Ivj/M7KKJN6I0eEk
         O1VSV31I63QWgTS5NIiL750cVJ2nm56lOA2SaH4TdP3uZNRuRRfhgU6IiZLmrM486MgP
         VAlqxcUqmJjFlRayKNAZK4Lf25LPvqyDkvl6fJ60VABGL8H0f2Zt6iCJI0oXkIWeYqTL
         KbblKqVpzOsTx56cXdpTbxX9K4j4Q7HQiV/KdFv1xfhq44BjG1Sq2SeYgXNPuO0Q6sOe
         bbS+3/XEna8RogfUCevQjofN/HhdIZ7oZWfPdzMibPSg3+zJL0mC+TP5MPRJpMTxRYZK
         NdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a4tbV3vnwAWI1orS7bjpXKGapwTuCv+wj00co1PEd0U=;
        fh=9G27kY4gL9/9GKI6uDt7KH4cNyWltY9kyDtOEklYibk=;
        b=E7dNlJlhbWhh9iigb5U1zIHOp9AnU5mE0i1+doTvdi6ZvhTIMvM2sYTfI41qUtTp3s
         m6k2Y6mWB+3TdM/0RYEb6i2Xtlz/pyYCQV2xU1xGCtnGSZA8MThU0gWODDLXfFaGbxXO
         QgOeb8XpsZlluoT6Zm6rjVyjP5VaKI0ePoSloUmCxeZMetU9SzEV+s0dyuksUuNezKXe
         3njd47St706dNoBcbPaGtBYJdlQ/DK+ffQE9fQewKz2FDebEGjF5SYi1DZaFwI89D7YH
         cXP8SbFIgixWqK0WskXX5KVerqofno8DumvltQtDdIy33rhm6nCAjoGT9cAg8u28viBW
         PmIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776883645; x=1777488445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4tbV3vnwAWI1orS7bjpXKGapwTuCv+wj00co1PEd0U=;
        b=BjpyRkoxTEP7pMYuUq3XWTKQFJeerQ9pGmGo4Ns+SPEvAhZBepfcNw/5n2hUgamtnz
         fMMsYRoMwxFi7YlkSD2VJ3/JdAiNSWi4svOUYJ2BDWZXFYaFM0lInUolSYt23EN5PrHQ
         lCQlaJoZI1HF4j+kThPWs6AJCbuDuGUZ4XhiGorSGMsR5pi4HpoWvht4RsqoQaM/zbuz
         uTzxeYo9Re8ew8h0J1gadmA9TgVXOzeGticFkhmvO3+G1FYTgbRYOnagMz+L4MHbTKjH
         4k1jmx7/3SZXPehEaCzm7FO6omFFG4LedpGInmSpUx71tQvZFssKT8Hz4XZ5UtH9PN+x
         dQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776883645; x=1777488445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4tbV3vnwAWI1orS7bjpXKGapwTuCv+wj00co1PEd0U=;
        b=c5DaSojxS7j7qnQWTC9S0JeN8PtdILe9uyD+Miog8s8265IrIM/0jMmCpJ7JoPGtHY
         u8K0xGf9HomsUcSaR7PcDJhqnV0RElGc+OrluNbR2Jk/W0FqxCVHtZD/fNV9fvLWHNSz
         H82X73/pct5fJNsMlk4Ton4LlZ5zAzT9hzujkQsF5j/iicgM0kmLftmD+oy517/wSJei
         D+iUjW3o4L0yr9gnZxWyaMIxHNnxfaDkVSKEWuqotONQCRye6rMyPdU0c9DEhZ5MJ8Ck
         gWIA32vFAvlrHnm+jbepmHnv+SQ8nezxTwJD8Xesm6d3c+A4dgJc/27NArHN8Kx+LiqX
         OUeg==
X-Gm-Message-State: AOJu0YxLkNqJF9A8ed4mG6bRoOdEcr2VYODVDWAiOzVEd2kyCqK1Dd09
	GR74vIzAzN2n+TYwX6VXwpznDVkC27VJ7PWX1RmE/P43Xa9ctE4/4mFtShdrYUH14XujeP3kyju
	V4bbHImket/15CyHScWlnZIJS0U+cWM4Si4Sz
X-Gm-Gg: AeBDievtHdNLJJRkUf30NVEknbLOfKyLGoON1x5A8TgbXS9hyuTAzgMCEljei2/6stE
	bSF+Tv7Kg7IYXCq2RVcug3f9NdQcjZF1bPyCNswi0CD2bSWkvNBG5vMo345I/u0m3I7SAiUs6sL
	ke+SHLGauDpg9OhLsJ7FrvQgSmUsS6Nq0WxL2rzsw5YlUUlW1Ct7n8qJpiDxDU4i+m7Piqk6eym
	hDgIPHVpMPpuJzv+xJ1D3xC0g63UbO+KWqpara56jBNTM5Y087Q5oQTDVxjqWZdcalBo/2EEfDR
	oA7i6franEP3/jMy20xF
X-Received: by 2002:a17:907:3f12:b0:ba7:f5fd:ede0 with SMTP id
 a640c23a62f3a-ba7f5fdf234mr730503066b.6.1776883645234; Wed, 22 Apr 2026
 11:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD++jLnk_5KG_q1aCtpOrTCbhtK-FxXH6BhPFSwukyt2F4uxmQ@mail.gmail.com>
 <20260201111812.18945-1-jie.i.li@nokia.com>
In-Reply-To: <20260201111812.18945-1-jie.i.li@nokia.com>
From: =?UTF-8?B?5p2O5p2w?= <lj29312931@gmail.com>
Date: Wed, 22 Apr 2026 20:47:13 +0200
X-Gm-Features: AQROBzCdqKXfgmKgxFT-Yi_N4yfa0Tzd0YRSe3TdEhbBeGIcCvxPNLhWMlBLtbM
Message-ID: <CAO3NRJjHRoEpSE2YRCN3XFC+oF4w-heCfpQStKQEkgZhO61oxA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] i2c: improve bus recovery for single-ended GPIOs
To: wsa@kernel.org, linusw@kernel.org
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

I'm just gently pinging this patch series to see if you have any
further comments or if it's ready to be picked up for the I2C tree.

This v3 series already includes the Reviewed-by tags from Linus
Walleij for both patches.

Thanks for your time!

Best regards,
Jie Li

On Sun, Feb 1, 2026 at 12:18=E2=80=AFPM Jie Li <lj29312931@gmail.com> wrote=
:
>
> Greetings,
>
> Apologies for the delay in responding.
>
> Thank you very much for your review and the specific guidance regarding
> the return types. I really appreciate your patience and time spent
> guiding me through my first contribution to the kernel.
>
> This series (v3) updates the helper function to use the 'bool' type as
> suggested and includes the Reviewed-by tags.
>
> This series addresses a limitation in the I2C bus recovery mechanism wher=
e
> certain open-drain GPIOs are incorrectly identified as input-only,
> preventing the recovery logic from functioning.
>
> Following the suggestion from Linus Walleij, this version drops the
> previously proposed "force-set-sda" DT property. Instead, it
> introduces a generic helper in the GPIO subsystem to identify
> single-ended configurations. This allows the I2C core to reliably
> enable recovery for open-drain lines regardless of the
> instantaneous hardware direction reporting.
>
> Changes in v3:
> - Patch 1:
>   - Changed return type of gpiod_is_single_ended() from int to bool.
>   - Updated return values from 0/1 to false/true.
>   - Added Reviewed-by: Linus Walleij.
> - Patch 2:
>   - Added Reviewed-by: Linus Walleij.
>
> Changes in v2:
> - Replaced DT-based "force-set-sda" with a gpiolib helper.
> - Added gpiod_is_single_ended() to drivers/gpio/gpiolib.c.
> - Updated i2c-core-base.c to use the new helper.
>
> Jie Li (2):
>   gpiolib: add gpiod_is_single_ended() helper
>   i2c: core: support recovery for single-ended GPIOs
>
>  drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
>  drivers/i2c/i2c-core-base.c   |  3 ++-
>  include/linux/gpio/consumer.h |  5 +++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> --
> 2.43.0
>
