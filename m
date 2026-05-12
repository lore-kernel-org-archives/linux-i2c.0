Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D23845DA
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575668; cv=none; b=D1LeiRFJDEjuzVhsQeW2Mk+U+WNh6Ufb/8As007F8IelHG+e0sO4AJ9Whrc6NA83tGEvF4zMmzBut/Lxn9zOyMlmo6Oo/z1FtvmN8I7HoRdx1+oXxptZgDC+KXFuKUm8VJJgijkVB1LfW6Y5FmuH1mRwnHKK4OPzdJSsv/6YC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575668; c=relaxed/simple;
	bh=w98VA95s3t3DWWPos/TgmDMCypg9HnmJFWLQI1FRGPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeNQNU0Dubp0ATFeIbYYncwGefnOcybSrKA86/kDWPXwWTpJHEBfXMrNk0WnSi8UVAQjjHA4jqySFesBP+QBhIjfMmrt1uh4Lcs3lq7tBUfos6zt+tCjJ70WMk7B6Mp13SdivzivPfWaLTussjs1PDmVkVaJTjQ0TahhwvV68pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqh45Cju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqh45Cju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEE7C2BCB8
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778575667;
	bh=w98VA95s3t3DWWPos/TgmDMCypg9HnmJFWLQI1FRGPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wqh45Cju6dGkq63BFa2qd6NT8EdgHDZv+704HehEBmhGLvvHXd4E0dbrGdmDNDWWG
	 Bb9JN7u+gW5L1A5+WJL4ToTULguswxJN4uLyv93Ecm9T/Mlcp6ZlSVTywCyCR+FTXX
	 6jyXUqxnNvDYm2AcZwWl6Os6yYsnXlPAnXpe/jS9ti+NdiFXnPuHOPpxuioXcOfcL1
	 xZUfRyEJ2I9Y3ari5vOy4T1hcKUhRHqOcTRoWJuFwBYbttJmP8SM4r1LYE1Ys+vkGM
	 bpKT07jRk16JtAlDXnQT6vkof2Z0UkAWPUxeHG5UHI1qMBmCFJvmzzYvWjS0AbDwDH
	 R3aNMkTivSVzg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dea72099eso5365096e87.0
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 01:47:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+JyPiAm1KWGbG2/CVvpB1Ww1qW/CamNuGPh7TSWi1uAW0XdLcq8iHEJaNbqtbE62fnNKqHbq7hnIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFFNaiVQ5pPOCWC229AhZWE9wXi5oi7xvRdCk0POPyg4FjVAV
	HuZarPriF6eQ0FdlPQ4/ItLwDJZOQUFHiqc5lyTAg+cx/b6wufwILmFEXEn+DMaIOeJ5fftXidj
	aEu5Hfajq+V/ZUgT4QfvwoHazBncrfTM=
X-Received: by 2002:ac2:4c50:0:b0:5a8:89c5:2c0f with SMTP id
 2adb3069b0e04-5a8e31e0f40mr536289e87.25.1778575665775; Tue, 12 May 2026
 01:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512073139.16343-1-hardikprakash.official@gmail.com> <20260512073139.16343-2-hardikprakash.official@gmail.com>
In-Reply-To: <20260512073139.16343-2-hardikprakash.official@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 12 May 2026 10:47:34 +0200
X-Gmail-Original-Message-ID: <CAD++jLmqaz326e5TmmgYr_xFjKbb6izFydnzuYn0Mc2-B1jG+Q@mail.gmail.com>
X-Gm-Features: AVHnY4JyxuA878_17Zsh5MWnJ4LW4ymphqteA4V3eeDrDkxjpOiQJxQuRYpq9Rs
Message-ID: <CAD++jLmqaz326e5TmmgYr_xFjKbb6izFydnzuYn0Mc2-B1jG+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl-amd: enable IRQ for WACF2200 touchscreen on
 Lenovo Yoga 7 14AGP11
To: Hardik Prakash <hardikprakash.official@gmail.com>, Andy Shevchenko <andy@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linus.walleij@linaro.org, wsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 9:32=E2=80=AFAM Hardik Prakash
<hardikprakash.official@gmail.com> wrote:

> On Lenovo Yoga 7 14AGP11 (83TD), the WACF2200 touchscreen controller
> is wired via I2C2 (AMDI0010:02) with its interrupt on GPIO pin 157
> (confirmed via ACPI _CRS GpioInt decode). After amd_gpio_irq_init()
> clears all GPIO interrupts at boot, pin 157 is never re-enabled,
> preventing the touchscreen from signalling the driver.
>
> Windows keeps GPIO 157 INTERRUPT_ENABLE (bit 11) and INTERRUPT_MASK
> (bit 12) set after initialisation. Add a DMI quirk to restore these
> bits after amd_gpio_irq_init() on this hardware.
>
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>

I don't understand DMI quirks.

Andy, Rafael or Mika has to ACK this if I should merge it, otherwise it
looks superficially good.

Yours,
Linus Walleij
