Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3444063E
	for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543108; cv=pass; b=p3od9RURw4/+xbl9JkTG8fxcUyoQGWCRJOhg1uA027pRrAvvU7dhNlDhcdnXzEv51t7/mvEHG5811PAKzhnb34SO0+f6rQBDgPh79E/LrSQ5eEmwqymJXET6CszqyvTbED2DmcDLy/J6qeVpvnaiT2DhWkrayk4w1Wy+lL7os08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543108; c=relaxed/simple;
	bh=NZR9oJcFKVLcrgem1bgASUkURlhSqxs9JZAAiNdx57Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ps6duXZIweteVWnzPzSJsxgJbP7zAYhebOWIJAm+6gEijWnSfLzj++uW0YxsObwVFmJ9eJvR2a9LJr2CvwhKiuYwTc3jfm9VBeEXAnvJclVKupVT+yWhD0KjSggK3F+YDHOOlGExzbKOTDUErXuMPXP/w7RdktGeIDRpGGcN2yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ1ENgN4; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ1ENgN4"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb4so72745585a.1
        for <linux-i2c@vger.kernel.org>; Wed, 16 Sep 2026 00:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789543079; cv=none;
        d=google.com; s=arc-20260327;
        b=S8OwVX38+seocmSEX8MOC6XsieZ7j7I3b7r1mwz6LReiHA0qj7MODc1jBDY/kwurEj
         Q5mB1mkxEVk0CCPdFg3gubfWmesUE4ig/E4x6YcY3IjNTw54s0b0T2u+vqLRy4TYZOOg
         AF5ey0OArEdKi4auaWiz2hRCwPVYZ7YWJK8eV2iCI0f81uvOqLxqT3LhtxSVwT6i5KKL
         I0QN4LN3orv557RIus3dh8y+XsfryVtG0x9S+eM9G6tJtUhzmWpZfxlhP/qF0ykMbT5q
         FkTE8LrPV5Wc5980DHuyLoSiQFuo+TLgCXwIju5ysz/VtMIKgSIeOlrFzwN/x2YJqhQe
         bbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HePzGTrSXdk0LNKW30I8iTNCaViy2K7dGjEo2OIzHmY=;
        fh=WLwtwOYk+WspdVZDcIvD2wJn1eyBHKN01VSls449Bps=;
        b=so8Wagf8deJaSHteGbiF2UPzJRk+war0qVlExj7M4mMFmiqMqr0qXBURYVrlkEqb2A
         fO63zoQrfccqZn10s9XDBr2l/AhL+6PHRd8owDuWGDklvVdONnP4CkjtlYfY3pScOfOU
         7LJS1QKYXO3bj+FS725auYL5htPgD7Vws70M6oR5prD0xbl8nnFRNdJxyxUHCQjEv5lf
         4RhckvVZQ6E8e+Ztx2f2WkK4I8CM0/F94dPC6om8dARfcZyo/vI46px+40j6qw+p1PQm
         0q+MJ7yysLZ6CP1AnW2NPz3MVjEDJSnrjxps2HCFiju/AwOu7cR12uceN59wcCAdrUr3
         UyIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789543079; x=1790147879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HePzGTrSXdk0LNKW30I8iTNCaViy2K7dGjEo2OIzHmY=;
        b=pJ1ENgN4u5fI4oIyvdZIi/FUm9YUsmRo5XHoLZQdvFmP8eXh96bKKvMIYiodimWiqJ
         PstVXZqGfiCkx4PXPFqVwf9FlO5vWSYCSgtmhVw2SIdIazaHzZDKqWLZp1Q8m9v3u+uK
         s/bldKH4KY8nrslJTmMXbhFd/P8Vg6j4H9WQT1fi0oBD+IG8jpwc24ihHXlH1MRlrU5o
         uWj42z3jmCUyJFfaJbG7dq/DVxwYTKFOpwi8BOrwYGQ9Wbd7pXFNTXx0HYoCVH03GQ6s
         o6LVRp4o4diTX5bB7/2TfPUwKtzPd4JZsPP/ymZlULZS9Nbc4+BXLns7D+W23MSb1QUp
         gouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543079; x=1790147879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HePzGTrSXdk0LNKW30I8iTNCaViy2K7dGjEo2OIzHmY=;
        b=pI7qUv2/cewKc6jr74DVwfglPc6mIa8SktV1K6SKCjSYuIT0wSFvN1uOY16TY65J+3
         A6RZ5hKkh+zwXo8idu+APAUHg7wyxptn+zSzI57B63DoIMqAid5pAl2GHz5CizxiCilm
         +6h2RCglhmUXTdVBKj4BcK+hK7hNH5UNTWvFCKxx6BdVAmPd8zAEAzNxTKkaMqcnDcD5
         +TgvUr3YrbVkhFndRXG4EmDthsKK0NsU0KcyyL5ji8CcQRwuvTo+CDbbIUF7Yd5iGcIq
         3wQmmS0m3fplnU3SRmQ59LxpYuXGNWeFFs+rSa4uBjmoRW2a/7RJgaot+6OImLv5gZV6
         GwMg==
X-Forwarded-Encrypted: i=1; AKwUvBx9Crdhee1U3osYYxfBZZajwYMKMuUqdv4byNL2lwum0Nert9C4p4Kr9hna1tnpYgIuR6mq6HSZxSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nAD1rvC2V6p3NGe4F8FA8VAsG/R1QuVnZBCKHmTOsCHDaQeeMn
	QiRG7IeYj/VQMHjummPo2U6NuM5JIjyAJNmtJEkhfZ8VpiHH/iZFiTHOBCI0PnQfDrjSfJsggWh
	y5Md8JOjB0Z9EgjbTLnoMzg94rWTrkXY=
X-Gm-Gg: AYBFou2g7eLDkj8El7bcPq0PoY3NpBaXb8nyCFlKqlHE4YCUrjz8Ey8tCGJm69cGzRa
	viKWxL+at+l51xhjszODCjpj4k8gxGHiMc0sXpZ7SCC6k2yCISA0xOKPPfkuMVrKuZXvx3MMSMe
	alWhRKQ8JlVY8fn27WUWLx2gHNNz7yBe9BuY8ruGJr6Wdqob1Y1K6tHdrCuLMTX7YaoYgkRpOHI
	BOlWBPNvaUpwkFalhkqSbAmoVX6nh2FcOK6rx+/+6u7NOhw238ccRLpOrnAUnlP5T5cIej9/IEv
	Q5XJDqIWNi0BGsdpw9uS4jf9a2ZkZy29cFixaspZDd5LwImd6wZEoMr6
X-Received: by 2002:a05:620a:4008:b0:93a:7bc2:d75f with SMTP id
 af79cd13be357-93bb790da17mr204175585a.36.1789543078899; Wed, 16 Sep 2026
 00:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916070631.1965713-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916070631.1965713-1-vulab@iscas.ac.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 16 Sep 2026 11:17:49 +0400
X-Gm-Features: AcwNN1VnmMXQfeYvkGasjznx5Qwpu_KfApsjjbpvaD5udE_w8aTgwLskI1UsZGY
Message-ID: <CABjd4YzNzZ0nnO4Xgw1JsRHhj9Crc6diX1uJnWHpHvd6BcPk2g@mail.gmail.com>
Subject: Re: [PATCH 04/20] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andi.shyti@kernel.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@prisktech.co.nz, wsa@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:07=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> In wmt_i2c_probe(), i2c->clk is acquired using of_clk_get(). If any
> subsequent operation fails or when the module is unloaded, the clock
> reference count is never decremented via clk_put(), leading to a
> resource leak.
>
> Switch to devm_clk_get() so that the clock is automatically managed
> and released.
>
> Fixes: 560746eb79d3 ("i2c: vt8500: Add support for I2C bus on Wondermedia=
 SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/i2c/busses/i2c-viai2c-wmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c=
-viai2c-wmt.c
> index 2cf3cc0165fb..74ca93b44347 100644
> --- a/drivers/i2c/busses/i2c-viai2c-wmt.c
> +++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
> @@ -117,7 +117,7 @@ static int wmt_i2c_probe(struct platform_device *pdev=
)
>                 return dev_err_probe(&pdev->dev, err,
>                                 "failed to request irq %i\n", i2c->irq);
>
> -       i2c->clk =3D of_clk_get(np, 0);
> +       i2c->clk =3D devm_clk_get(&pdev->dev, NULL);

Maybe we could go for devm_clk_get_enabled and drop some more
boilerplate which follows in wmt_i2c_reset_hardware, while at it?

Backporting this to stable seems like a stretch to me, though (it's
quite old code, so there would be quite a lot of backporting for a
rarely hit resource leak).

Best regards,
Alexey
