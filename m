Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D906396590
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518569; cv=pass; b=YtQQj6H3Of+0zwOvZNfvPIeZeG7hsoUGWO49OC/Eb9w4L5zmNI0B10oqkk8aRqmBgD7JheOB0J48Rb5IdhkvOwnQ7wFzWoPseAKEuqnvq1x10vV/WjzvT8g5dUHizRJvjx2A0AR7MoiYsLr5SJ+I+J6ylwRvymuGhJEjmJ6B8QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518569; c=relaxed/simple;
	bh=7knoakIKaubGmtXGun6YWaShT3Bs+tTtvHK7ZAazb4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBzSJn1jQ9ySKTD6o6MfI8/0J6w5+b5eNK1FfEZ1p6TYQhzMZd/dvRDEhstPKpWBSpEa3cd0Znm7sobxFOB0qz6tOxrCUgfD2ipP4dzB7bvaQP8+K1mrsWuBUoaFRSc5CXPPCaNbdA9dCWj/Gni3OHOOPaO3oxVvkmneLAUBh9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+Whr5MQ; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+Whr5MQ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a298acb395so1064518e87.2
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 02:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774518560; cv=none;
        d=google.com; s=arc-20240605;
        b=e3/QHR+8bhAFIHBeIm8lCRlDiC36bxNFKakl+OYMQHqb1igpN/zHzbf3KYDxeuRXCS
         qvZfOAK6Egv6RbxDIqai6NPgHq28U7SHAiCDpRsOQ1WbvI51CMIyXzpla+IzhyJ5IiVE
         HIObjnVfRMaBFj/U/7wWTrcpqeWbQ2OIzVwgkwWms4Q2KBGETmIBY0Ywy8ZgLYXYXEP/
         XJysfGpTwYgLhhSq35NN+iXjyr2HrOxWygaJdcEziVB8QxpKklXyHRatYGQNZkpC+Y/5
         swZaWmGrAHcvZPWHmvUccnSvvGOs+IBYss/pMrhNXDj4gGOtAxV6SSw/fzLbvpsCKqEY
         vbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7knoakIKaubGmtXGun6YWaShT3Bs+tTtvHK7ZAazb4A=;
        fh=gEhAtBsNlets+BxVfXLQ1ZYQZr3jnQvXWs30s4FiLx0=;
        b=hfj4KnVzkfXMFXERrfJD7yse+wvClJZT6fk7qtTEhiy8sGrPA/ZtMGBTYh3Zn74sUo
         Rt0DEpd/uC3ahCeRnDSsI8QCKH7y/WpFCqAfkMf+W32Jozu6miAF2mGcxa25vSCr4zrR
         rNGbJdJO8lLCu48pfdqNDRSCLhGzaVwsYbWhblqsF5LqiVmI4SNkGqiCj0DwfihAEx5o
         mu1Lr40PrmxgW/EluArFujTmJqFc1PRfxkJ2t7SVOCSetxg5Uv1QMBjQYj/5iENQmSdJ
         NtGVgG8eafMUkfvTJah5IpRLbdbwcSnXLbAlLlpDptVo8+Q4w2Zre17Klfq/acSdNMwg
         VEuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774518560; x=1775123360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7knoakIKaubGmtXGun6YWaShT3Bs+tTtvHK7ZAazb4A=;
        b=W+Whr5MQdTVsjfWAkhUplX/Lxi61m3riOa1khl4NKshyaH5ETIh0+FFlUJQb5aAFo8
         c4I4dwJe/SOXzNmPesfRgwChLAikCXMEXC2Sy43IVJNNTRAn2FsCF4ZgvL8OuBdFSxui
         413y9IxywGBuWSg9ouggbK6iVWFNsEKGjBQ8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774518560; x=1775123360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7knoakIKaubGmtXGun6YWaShT3Bs+tTtvHK7ZAazb4A=;
        b=Os5saIkSBv6KDUZ0FhXlExiaC232DDFwircsSjS4hxh9TElN/Sx1uubSS4qnYm1ukW
         AVO2RsZpJUN+kUEoow5IKp53MJQcIZUk0spKvl9bE6kigP/kBRgnMDCHKNPmfJKQB2CP
         dz0Ai6vIxmTtENkgU/Da4j2jna43yCb5rnhejgiscoVckuUca5mjUxAnp+q7Bl+T6Fxa
         tyJdOq9n+FXjtpPQuYT3/yItfFOAqpkpp8VKxyCu+XC607kmedwtuWUrwWRViPVUTLWq
         bjhpIhUyK050RMnp7n3ndL1RW5x7HbN3svF7cqDH/THRoSR92tCQlWXSukdeKQllKt8R
         vV7A==
X-Forwarded-Encrypted: i=1; AJvYcCVOGLda2ak1YEMoGcRQl6ybJ4A47EZZZEuknu+yrfuQ5jYAhyfXmIAYDMpfy1mAR69c3tUqWYQuxHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5Gt9o5BqKD/TJONAB4SuOC+BJviNrGuQtUWiioX4quwexQnx
	yoVmWJ1f+YA0I3qwDrR7kF0pN76dxQkD5JYnTULEOeOW4ktOlm1/KHvLoqOHVHP0loG1FQTvJUu
	6gJ7VKCahNinhRob92uPk7YZgsjyOd9XlmaQXLr4O
X-Gm-Gg: ATEYQzzwb7ZkkUHNq/uWMKCf0XoLf1oixZWESKB7OirndxM8rLNtF/EHb24RZdfW4I9
	Tpo20Ix0B01R86ZCh72NYdXwe6DFLntwAnvHXCpk6UiDoW1SJtsjhqQXIKI1WOnQPANjHTKx3eJ
	88RkNyM93UyjAK6uDrAVK241Q459/1RemNxa/kjjG4/4BuFOn4QCekfqRq52NIyv9dMXWZNSZJr
	qtNuuAlLQ23/eSj90HYBLa6xiLVheN9aaRPSivOm6WOsVeg2m7ys+UxELveB0HoYJHTrSjLe37L
	HouHWRW+AP1obDa3tNnZRDRnhX8zykyfDpqN3g==
X-Received: by 2002:ac2:55bc:0:b0:5a2:8570:299a with SMTP id
 2adb3069b0e04-5a29b995643mr1745645e87.34.1774518559747; Thu, 26 Mar 2026
 02:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318084621.4127757-1-adlavinitha.reddy@mediatek.com> <20260318084621.4127757-2-adlavinitha.reddy@mediatek.com>
In-Reply-To: <20260318084621.4127757-2-adlavinitha.reddy@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 26 Mar 2026 17:49:08 +0800
X-Gm-Features: AQROBzBAalqKzp35Y91nZQL13UXSFnXuvsBfaF-bjpY0zqhQlozBnv2cKghChRQ
Message-ID: <CAGXv+5FYSCG4NYqUcBTBAvG-6=EQNStS5qRnzYV0oGzJ9dJ1bA@mail.gmail.com>
Subject: Re: [v1,PATCH 1/1] i2c: mediatek: add bus regulator control for power saving
To: adlavinitha reddy <adlavinitha.reddy@mediatek.com>
Cc: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 4:46=E2=80=AFPM adlavinitha reddy
<adlavinitha.reddy@mediatek.com> wrote:
>
> Add conditional bus regulator enable/disable in mtk_i2c_transfer()
> to support I2C bus power gating for platforms that require it.
>
> This implementation:
> - Enables bus_regulator before clk_bulk_enable() if vbus-supply is define=
d
> - Disables bus_regulator after clk_bulk_disable()
> - Only activates when vbus-supply is provided in device tree
> - Has no impact on platforms without vbus-supply defined
>
> This approach provides power savinggs for platforms with an extra I2C bus
> regulator, while avoiding runtime PM complexity.
>
> TEST=3D Build and boot on MT8188
>
> Signed-off-by: adlavinitha reddy <adlavinitha.reddy@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
