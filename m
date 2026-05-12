Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E24921BF
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583622; cv=none; b=nO6DKrLVZlBVQFACUbQLCqaGqsiu/Q+ut6AoVhb+7BxRn0V3PmscegM6AC51tti8N9cEnqu9zrONcOHsbKKDUcw0GBqfCg9se5EpXCIePsX8DMMwQ9n2sz+mqpo/XA6laBSy3SG01nVyAPGUj+c1owePlCJGH+qSU9p5dpTH7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583622; c=relaxed/simple;
	bh=+jTtx3Iz5bF5a1JF4Rpr3zAsGBVSwo5VUltpjnN/uuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRC3M6X3dPVHb8qms7qW+jXxF/gQa48OEd+s07LgWevKzRY5M4u2x3DVqI/vGQDZL6BDzzn+g9PxHVYIPqHJ3Rcw2R6KdsoZ4GB/TezJfEJ887c5Kq7fqrpetOS0/RJ/DzhQliu3NxF3D3zZ06+Wh5eTxkA5JFU8bsMG+0V5ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLRm2COV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLRm2COV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB96C2BCFA
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583622;
	bh=+jTtx3Iz5bF5a1JF4Rpr3zAsGBVSwo5VUltpjnN/uuQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XLRm2COVxNt8Nx7UxrZZKK6jdJ90nHSPX5/snRbyHP2wfO43BoNvk6hwwReqN7rrx
	 nqi7MAIQWnvpCRkxrYm3jIpn+VGi2aKwQyZPMpgiGO2Cn7gP5PpPnhZxTQtmeARUvu
	 i6LS7/X5EjRp6jWuSucafYAsppzFhd5TV3lLQiuY1l1cug95edw9Hqzs6w9wCpofTw
	 o+y2byBKH+6p8rSesBULubw58HS0ggMlK4XUSw4HrjKn5OI2EAjUvdlPq9dwA61RgU
	 2IxWMFw/3/5jL14cXeAZ/7K6nkGuc1Gd6En1LjbWZ1sl79YsgH/QOL+O0BDwQFtRtv
	 9W+DY3Mew9EoA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a746f9c092so8417587e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 04:00:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9gntyuWpJIl8sahhhLek+0Npfr7kFlOGeimTLw9TqEfuvi4FV2DqXphP/iH5nAgSPhZhka4pa7Ndc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0EExYzt6v5mGzcfh6Br8Y2OjCdvf+1kgVDqTQKs/WUYfi2rmi
	37sTJ5/WGzopMarD+4UhRYPJYquIIZYzIOM6wGoxEbtrQbcHfPfeb95bomXdeQgVH8k8wYJhf/W
	3l02IstsW0oP/jQhSSHjDM/Xc/xBVzqk9g4FA4uaozA==
X-Received: by 2002:a05:6512:686:b0:5a4:d0d:84e9 with SMTP id
 2adb3069b0e04-5a8e0ec4f2cmr953327e87.4.1778583621007; Tue, 12 May 2026
 04:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511162528.84508-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260511162528.84508-1-markus.stockhausen@gmx.de>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 12 May 2026 13:00:08 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
X-Gm-Features: AVHnY4JUWD-2XbEZf2KfYaUHlZcZhYkZFupHjJQOGud41KwRZc4D7MkUO2hrL_s
Message-ID: <CAMRc=Mc-EbMu3eUrMA5UDCEp-xzbyndy8_U8OjfcTDJcATThQg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] i2c: Add i2c-shared-gpio driver
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: wsa+renesas@sang-engineering.com, andi.shyti@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:25=E2=80=AFPM Markus Stockhausen
<markus.stockhausen@gmx.de> wrote:
>
> This series adds support for hardware designs where multiple I2C
> gpio based busses are realized with dedicated SDA lines and a
> shared SCL line. This way N busses can be realized with N+1 gpios.
>
> Currently there are several Realtek switches that make use of
> this design. Samples are:
>
> HPE 1920-48G
> Linksys LGS310C
> Zyxel GS1920-24
> Engenius EWS2910
> D-Link DGS-1250
>
> While at first glance this might be a usecase for the new shared
> gpio architecture, discussion and testing shows that this is not
> trivial at all. A shared gpio is handled by a voting system. If
> there at least one user that votes for the GPIO to be "high",
> it stays high.
>
> So the implementation manages several classic bitbang buses with
> locking/unlocking in the pre_xfer/post_xfer handlers.
>
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
>

Hi!

A couple high-level issues. You'll soon hear from the DT maintainers
and they'll ask if the i2c-shared-gpio compatible corresponds with an
actual piece of hardware on the board. It does not, so the bindings
will be rejected.

A virtual device doing the mediation is fine but it probably needs to
be an auxiliary device instantiated dynamically from C code.

It just so happens that at the same time as you submitting this, Marek
Vasut wants to enable shared write-protect GPIOs for EEPROMs. This
seems to be a similar situation where the default is to keep the line
high and drive it low if there's at least one consumer that wants it.
I will rework the gpio-shared-proxy driver with that logic in mind.
Would that be enough to address the issue here?

Bart
