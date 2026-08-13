Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7435E1AF
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591810; cv=pass; b=jl9DK0MVatQ+y9z+FpHmM9QQjXxgkwykHai+JHKzmgVt4g0rh6vXC3yTnakHm1FllAcLdKwKcBJLKOkEvvvjvfvKHruDG9P18coh83WeP6M/Chl7QjSwDjyJYIIlUyBsaCH0XNNtHW+PDn5ByABhU1ZzVN6eAeR8Npk3NQlT0O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591810; c=relaxed/simple;
	bh=vnxLhaj6tQ8Clxuh5zpbuIzE7N05yzLZnFlnrerBSX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqo3Bmjpc9vbjix0bP9tQovZ8+7mH+K7tJHl3oZrr8xsMDmMvYO9nNBzAs70JJG1wAuaRUZb0f2+yW+pS94nUwPatSsycJU3QnGDEV7pSlc7/S6RExcDKu/ApFiSrIFfWmOzRlI3zLpkXNWqKg1pc1zSB37YCmlBKD/GNHCOYGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OAx6Nlv8; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OAx6Nlv8"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66843304cbaso2361507d50.2
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 20:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786591807; cv=none;
        d=google.com; s=arc-20260327;
        b=X7xaSjNIDkdlETR4f/FZ2INmlw7b2MD023fI38hjpx+8YUpkudx3UGOZ8DnfezNgop
         9I5jiNEjS2spWfcCjCyYB744Q39hZBTKnvZubv/C1AJRMS0+F7UGI3r3loWJaKlsxHY4
         MUu5RrAbqGPFE0EbCVGXIua3LtfIqQ1JzmlEaC2iUtwrmeYfuM363TLSZw7c4MVgs/PC
         s+Rg47rEhvsSmSAAYlL5/DRJtgDdfcl/14XJy3xMH8anVZjvHZQaS78uDKGqWjE+Mmhj
         qBnDx+oM1ldBQ2BAYC2+A0uU9l6W0jwE9d1D8bq0ZUbKFflvPBAy+Oa4/zbIQ99cZLt1
         hWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uAJYxuWYQfJvsQUaJRIL+oMrK23LCX8rJso9NIjzZ+0=;
        fh=wn95+6K+BB15g0woVZZa8a/Ff8lCtXnHZxl74bc+R6M=;
        b=S7z8bTbT4KOFL0O7ZyMbpsGihYE+SY2E+owpkIMSaAU8c7qJXiNVcu9ta2P3Vurit5
         yhVyPLeDf94s1MY6nO71CXHvfAZ1YEN+Gf1BIPufJjyotcmWcDvxEggeaxkUviJGnlUw
         7marduDDyp9cifhNyoIJbPbIoiRAATnJLtYXQcTxfbtzdJn4nH1NDXgksBCn4N7XiEbS
         AO77p9svGBrvpDuborZMfCEul1FI17CzwM+SEB5lXPaSC6FHaI44EH/4+19AMf/ih2nV
         7YpFfu2cmT+9knvz9NxMHDqJWsLbOsb/K8XtQ0xhfvxKAQ4EsmPGfJXFp/36HN3JJ+in
         0rpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786591807; x=1787196607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uAJYxuWYQfJvsQUaJRIL+oMrK23LCX8rJso9NIjzZ+0=;
        b=OAx6Nlv8Lp8VNM9MU/S2oPBY4HmKAsc1e5D0gwad75hx3KEb8J5Rgqr8Nw6SBtS6E2
         GVLLlhrAuR2/fd58PauycK1DITwy+BOUG6VJquh7ueOBsOTg+laEUF3x/3UR6c+FDF7u
         4dYkpKQBPHt3xiUuku9no1UguifURSfKH02p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786591807; x=1787196607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uAJYxuWYQfJvsQUaJRIL+oMrK23LCX8rJso9NIjzZ+0=;
        b=Y+chAUncfUaFdFTei2v3H4NE1Z9VcSbT+atfgraRplUC/1qGUtqitYxkIPonrscasZ
         FraFctI547iq1UZ9wOEGECq+v3a4AJFzS8upG8skt9fGZ9YNPJvrrDb4djDz9yKJzFxt
         PyPOYSzE6+sqis7UGGKe6puGUEVOdRM9buoD/+TEW81lM2zy+ZCif2ipU7a1p9WyenC9
         wRIl4pXIg3U8CbY7COKMZ+GvP/b3KwvTm2ioVEm3D3fe6FdqpyG4k6Wc953vETPUDnp1
         oPTiCBIb+DDZZaKP+Kf/AQyL0unDCkuXhHDlV2RMyO/G7OByYrfYiu1LIsp7hr0sQz3j
         FAtw==
X-Forwarded-Encrypted: i=1; AHgh+RqsVnpBaiMubD8+nYRk4HpxFebYAL13//IccH5L/+PKbS8jRsgQQ9Hizaggv5yhCWgoOPOXiUDn1js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsqJASMGEHLUDiTFE3JSyx2GolGKBzWn2gfnGSz8MK7OViTQr0
	zh2qAwZWG75c7PG6UEG/2jX+NScigSA/GlSHEG/YsYNetSbVjov/fO8I/25/8IAXZcNdJyRuHdS
	zjySrgNTsU+4OR9rKmzYY/tffqT7VghddZhcxi/VR
X-Gm-Gg: AR+sD10jHyK3c3Yvqo/Cy2HIw4OiPmu0rpsCMM1Fj0DFZFGaITOJBbyoIfOGOBgFPiB
	PTavE1ic8bwGqUhado3/nztE7NffbYw5I3klwhzsbeEmy7N6T9l/JYooTUQezI5dybSW6aY7d4i
	ZY3ibq5SEokTSwa0CvybTcsveBq9MiXk8kyAfifkxMJt5yRUTNObY2rMszL8n2Y5gxcHdDPTabt
	Jr+KYlrIf8FJj3yARPDe4IM3FRflVdaEI/cFzUfV7/GoIa2mlsJHOmpSe72VzDWA8yWSSGq3cKa
	txcmhQ1vz8hlIFw249TMZn8XMNJMSeoDdt4y/X3b6sqIAkpNWfH3gg3GSF8x/dIF6fThSiwbLqU
	R8Nd+IzYoVQ==
X-Received: by 2002:a53:e5ce:0:b0:667:bae0:e565 with SMTP id
 956f58d0204a3-66c515b62fdmr981398d50.30.1786591807078; Wed, 12 Aug 2026
 20:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811122011.3539250-1-wenst@chromium.org> <20260811122011.3539250-8-wenst@chromium.org>
 <an02idvk4GtZIMfn@google.com>
In-Reply-To: <an02idvk4GtZIMfn@google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 13 Aug 2026 11:29:55 +0800
X-Gm-Features: AUfX_myrCG3oNTwmlZwHDJSbsoCHFr7jcGIFmX0-QgCkqwSa3XLy1HbTAXteqh4
Message-ID: <CAGXv+5Gf0sYKvvd=JsdPsahvHCKr5rk+YiVu6SCY6ZQicJzd6g@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benson Leung <bleung@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:14=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Tue, Aug 11, 2026 at 08:20:07PM +0800, Chen-Yu Tsai wrote:
> > Up until now, the MT8173 elm/hana device tree has set the dedicated
> > regulator supplying the trackpad as always-on, simply because the Elan
> > driver was missing proper delays. As a result the delay for the
> > Synaptics trackpad was also omitted, as it was not strictly required
> > under such a model and delayed the availability of the trackpad to the
> > user.
> >
> > The Elan driver recently gained proper delays after power-up, with
> > adaptive skipping of the delay if the regulator was originally
> > on. The I2C HID driver and I2C OF component prober library gained
> > similar adaptive delay skipping. The device tree will be fixed to have
> > the regulator not be always on, and proper post-power-on delay time
> > added to the I2C HID device.
> >
> > Also add the post-power-on delay to the ChromeOS OF component prober,
> > so that if the regulator is off at the time of probing, the prober know=
s
> > to wait for the hardware to initialize.
>
> > [...]
>
> This looks harmless even without the aforementioned patches.

As mentioned in the cover letter, it is harmless, but will delay the
probing and subsequent enablement of the trackpad.


> Applied to
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux=
.git for-next
>
> [7/9] platform/chrome: of_hw_prober: Add delay for hana trackpads
>       commit: 81c1c0cb68a13d14dd1bbffcf4c49e26f9a6478c
>
> Thanks!

Thanks!

ChenYu
