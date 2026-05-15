Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3F368D53
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834575; cv=pass; b=b/XCytGQXcEdiq9STETyLzHGNknvLUhddlUiYBdUFXfybbpvMxtvVglshhldDfQQn3xuD2wVU65LxeURDozfayvjiJLjz9+UoYkJon62rxj3BGGvmpaCEZb5J99j1ztXsUVYpjGNpG8G0/496EsIUJqHdcjMyTKf/FjmMzffH7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834575; c=relaxed/simple;
	bh=kIVb7Rn0DBrbR/tdHs0st8zFiQDcqlEHGS5Y7M4/1hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+uDQUTQXRsoO/0dEO1ceOLmvWd7DkXUZtBb5jo9iqYo5xOjBRMIhXx5Bwoos21t6zq1PWxYL8QGKqgsuxhRkdIYlAzDFp9jhA9Wf9tgWJT5kVYFes5vFkhJxmArWtMUWagttZxOqQr3EvLPVbkI5Np+/AM9F2LDdo30VE3i0P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMyhv8+N; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMyhv8+N"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651bc83e74aso11711054d50.2
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 01:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834573; cv=none;
        d=google.com; s=arc-20240605;
        b=C6v1szFTrkQI7AJVdDt35Evequ+PLLsiGsvRq/dH+B2nDof+tYogE0B/Dyu55/XjFp
         WBxi+6br2yvZA4D/2q4Zm0yL/1DJj8YRtmEQ/vWJE7QoP/9olQBDixawZtlKM4l95LtG
         TrPcDQrqt2yORakvcsPaGx+wptXRib6PwEIBcfi5j+EHXvmeimeu7nOkodvKfsfETySP
         xrRkRyTrGnY3ijR7eJZxb3oCSxuc9uMKKT2j8Q40ZtArTrfmeTWp+Wvzy5QgKki7rNon
         uEZlKFOKodojffnHn3qf1luEK6EIOzCara4Id57smwBNOba1+jhtbpyLHz0+rA40q8R+
         VAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqerFP1ZN9krhO+NQgHUFbrEHV8W7RtHQhpONw2B/SM=;
        fh=mm06Js9TpXQ1uSruY8tX2v/KeNWle5zAvdhqUfRSGKs=;
        b=afLvL9J0GpfsqjRyJj4mcz/HA8RAAmPxyfv+Yox8gYTq/smDyx8Mb7O2ETK0ap7TTW
         dETcyXKO8SryDcPkhIOX4xf/oCQSfCPmx1d51Qy8bP82ZFqyuibeK8iAkQunlLSOgnn0
         LASl6LiD7Smqi3ahW0PGxJwm09tNyqQFTYxRtAyEqZJIfcJFqMrtx7gv816C0T0A1H6W
         Bn3ttvQxlAi6yehQpF4jOXcvMp6TXIpKuVXkzhCdxeGWq6DT++gJJ5erfBP4C4X0KW/K
         xgG2rSdOVBxfEO1VA5Kb/EqOP3wLLQ3g4NNyylrq/wH3BhNIMofv5D3hx6sfUDf3gRwF
         +XIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834573; x=1779439373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqerFP1ZN9krhO+NQgHUFbrEHV8W7RtHQhpONw2B/SM=;
        b=DMyhv8+NqZmAS9c0tgeQXxCsr2Its1wNsE0Us8L5HYAlbrfKKjl/CIl4sUP+2TnrKK
         MJ0oEuONrncFrJhUa1xo+o9tFfBcYycnZ/cJzrumTJorg5S3qy7uwBWRJ4iF4Fhle53u
         /FzjiizeJOFRH4VfD5uUop6a6dydU2TtwsLvdAtkG13Ad+gBKf/YQPQL4jBfS2NQHQ9m
         fciRDG3YeJcllrdMHKHy5zb3aRLd3Md+RIoBA71DmY21At3SzkNNYZvmzR0ykoa0feys
         QURfXUFDH9/pBoHvJfChP5HZd5Dlcctr/IJUhlmzo8lSWZfX2gpTEfPV9WZrZKVwgpCc
         rDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834573; x=1779439373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqerFP1ZN9krhO+NQgHUFbrEHV8W7RtHQhpONw2B/SM=;
        b=NUClGmrKC+3KtyubbW39UReNQOlV3IMSH7FzzUfIB5VEWjekAAtuhRS4yABe7TT5z7
         gjSygp0Bw1wk23A8vvqz0gCMdoNhIN18Ezudxor5653Nx7IG8f44THK6tB3ELgWXUglG
         2yXlot0XsC/dlSmsOrK3HXsmbcAcYAJeIEOQOizazHEy7vSphCKj1S8bmT8LBWckFiWh
         34FPT0c73QvfaGCTgJYhJEILvXfs5EeghQzzeZ50vWyPNUlbnhlnwWhMzNe+WtqlniBh
         kB4Xnen+784eRdUlrCkMf9xFUjYMx0fQg0s+/HJPW2MUBWUOiS11FHkZaDFylwLZntVT
         8IWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vYPaJGY0r6N/rpfT84UAFO/XG5tcLgnJtBJ+By6Moi2ZM3TOVOmi5s6OxvzxgtZOIqAqz9VBMdik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyreLcKMEiA1ulTAUUfFrrhZK/SlAew68dSCMKpP7XacjCIt9GU
	Ec+6QfVmHj90KoWuoqJwxPagz6vEIUaB1+M5aIl3odfYRp2Om3PDoHBokgVHflU1F3Q/i7WWgQp
	AdwNP0YECMJUDLU10X74rwcbd9VyiEzsj3OjbyYlWuA==
X-Gm-Gg: Acq92OGqO1DtxF/lZgz53J32ed+tcMkI/zrV9ZYYQhf3g/dSmS8Rou0b5Rk3/4JIz1T
	OXQEX/OYmtR/eD9LZmlOmSS/4mbdwPFJ9qjdCAUGupmnhzb5GEvcTb3SG7sg3AAKVYaXkbb9+0z
	SbYl2EvH/wbKlOQ9wrhjdNY5vXxiY4IrOBG9EXIjQeSizvPARrBAJenZtZyNhCx5XftRVbMg4bk
	LBItH7sTvpSK6AFA6FdMIlp7PzZtmwK7M7bbGfwyKYAClkfSfyOCQAC8ewldyTXKS+5RQO9XH+N
	ypauBzLFd6RgPwh5oTc=
X-Received: by 2002:a05:690e:11c1:b0:65c:4b93:4261 with SMTP id
 956f58d0204a3-65e228e2050mr2929469d50.64.1778834573102; Fri, 15 May 2026
 01:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514103740.5416-1-chaitanya.msabnis@gmail.com> <1ce483f8-1d9a-40c3-a45e-6ca536010b20@lunn.ch>
In-Reply-To: <1ce483f8-1d9a-40c3-a45e-6ca536010b20@lunn.ch>
From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Date: Fri, 15 May 2026 14:12:43 +0530
X-Gm-Features: AVHnY4JEjymFDabfng7P110Y37cdzsT70TLrv5QMB__FOlUHUuBPsZy2L1nMErY
Message-ID: <CABjkosFHLErOziCrYhJJxtpMg01t36LqAfr-zz1wE4HSZhfzFA@mail.gmail.com>
Subject: Re: [PATCH] i2c: davinci: fix division by zero on missing clock-frequency
To: Andrew Lunn <andrew@lunn.ch>
Cc: brgl@kernel.org, andi.shyti@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

That makes complete sense. Updating the macro to Hz is a much cleaner
approach and aligns perfectly with the expected unit of the device
tree property.

I have track down the original commit for the Fixes: tag and send out a v2.

Thanks for the review!
Chaitanya


On Thu, May 14, 2026 at 5:46=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, May 14, 2026 at 04:07:40PM +0530, Chaitanya Sabnis wrote:
> > When the 'clock-frequency' property is missing from the device tree,
> > the driver falls back to DAVINCI_I2C_DEFAULT_BUS_FREQ. However, this
> > macro is defined in kHz (100), whereas the device tree property is
> > expected in Hz.
> >
> > The probe function blindly divided the fallback value by 1000, causing
> > integer truncation that resulted in dev->bus_freq =3D 0. This triggered
> > a deterministic division-by-zero kernel panic when calculating clock
> > dividers later in the probe sequence.
> >
> > Fix this by isolating the division so it only applies to the Hz value
> > read from the device tree, cleanly assigning the kHz default otherwise.
>
> Why not keep the patch simple and just change the value of
> DAVINCI_I2C_DEFAULT_BUS_FREQ to Hz?
>
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.ker=
nel.org/
> > Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
>
> Please also added a Fixes: tag.
>
>        Andrew
