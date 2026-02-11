Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA550353ED2
	for <linux-i2c@vger.kernel.org>; Wed, 11 Feb 2026 04:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783839; cv=pass; b=BOSBDlJttuy2Lr+VGjzZiLkXibZSTUTxpczzKmPr/hu1StOWYjbeBLq+jxPBYRrjMlKBkPGCpLj5vSt/X7mWn165Q05Hn9mfCXwkxNsRLRD8vN015nWlNUAZygWOfjDQglOSR6X0iEpNJYM8wNSarngoBr0XSgcJVRPXtiAnaY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783839; c=relaxed/simple;
	bh=AYf9PzYvGROYCkBsZp+oebw62lOGvJB1aK9owXm/Xl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEtpBy4+2d8APEHdIoYhzLGVvKJv5GL5NXmstCuT13+otq9Q5mCw1tgrlkXtgJDaaylvh9kMQ+ey72xc5h0f0dVjTheAizybfZH+bCq8/cboNib4zhCNK3SofF62LRy3IVWSRq6gLn1ZDPHlBGALoiSJeBESRkGJv6Gc+r7BunQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXFjECIC; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXFjECIC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so2228452a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Feb 2026 20:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770783837; cv=none;
        d=google.com; s=arc-20240605;
        b=GbTqUU6q3jnQcFt8bgct1/msXwSkOyT22EQhPiB2bIK+tyPJrqLnueUDX/v0l9A9Py
         boBxtSBhzstARlHsXcLDnvAeFR8w670lgKHAzFFBemBhIAKE0bMWsG287P92gKFvs8FH
         Uo4BxpbG71Ajpo3+GV6kn7CmCEKqeBJCcfWnCS6BlLP3nvovV34+46cOYq+VX8AGLsHN
         dL100vLH0VryIAFUhkSNrYKns0ju0ylI8N4IemgN7OvpbhsUhEDbWXJDjkrdqeFOgG/h
         e2Yah6q0RKBkxzb8l4FMJsOxukynmbiGBLw7uiKmQC0RG7bmmng+0flS1gM110LI7qbd
         3SmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BIWA8RluXGR6oQRlAJWI5a2TCkKeGW1RA568WY8/pdo=;
        fh=Us2J/GF/iIqXy8a2MFzuFZBvbq9RQnjEChEhBqeBSd0=;
        b=Y3ir8WeTdhDB3seWFI4hBqt39dsLWYCZ8qkT4fUCxJG8h0E8rKWTigArruMVPZE2c6
         3c0qODsIBO/I+SGBWxRRGkpEL4UmK3K/tKChiRadn8tQC/PPmva+iYGWZZ/lI05Y+143
         veIGwWnWQN0njxvq1iD+iOrvu+j3IUfshyztdUYtVI1auXeR99pP4KgPpei/lzPy5ylt
         4vIjbqIzX6ceZoZFOpVpXR/2tu3NhUJd8XZEWagUxN9pxyLcVUxnFyrmr1C+8CWDeTVg
         gOK01L5nr6hM+He4d+p40JYBthxhGL3JpyogeKHu7dsrEZ4LLW02/tXIYDH9kk+za2cZ
         CX3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770783837; x=1771388637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIWA8RluXGR6oQRlAJWI5a2TCkKeGW1RA568WY8/pdo=;
        b=mXFjECICsGhvMbXmCou3XphOP2ikapvNxo/la69670OYIqQJUxvroCjjPeB+dgbfBU
         pzib0c+m/Vv4hWKcDj9/Q4SDLTn/qJQDS7/OXLt9D+maB0w+vd9Iae4fN8Z3s4SMf7nt
         yVhA9K09itvV7Nc7cPAVtMcyVKxuRisAKsXzWKl1VDiA9EtwRaRfEYVcHC9DKCRkF1Ke
         lSVUQ2YaT3ba96cO5fR5WSBn00FB4Sp35g3rYLjdDeUnLzV/D8M0mRvxSXLAI0qFETYO
         GHbeIAM7YsQdClLN5EIKUiKiRXlXU7y23AGxGMO47mc8YZNzv9QMZfqJO1FR7oBfIXVf
         M/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783837; x=1771388637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIWA8RluXGR6oQRlAJWI5a2TCkKeGW1RA568WY8/pdo=;
        b=NV9EUVbLnW2m3tPaWfQlzdHXvXLiXWm3zMWQc0IqDnxllMHKmCHuUcyeX360uWyWrN
         luSDKoKQnB+qPCe8tAdYjA83NGnC1ZFx/qzl6ow1/JipxXcv9r00ICIvZry2gYMIJ+nh
         Aj1QyD+8albBNoxVSHoCN5qVoJIo9TZFlXrMh89gLaEZXls5IJP9OHBQ6aVtLk0tYedn
         jJahUBfyjzsHtzosBmL7wcIpajmZQDPdr+PMTA9Z1/qesDlrleyJtTSnaXsBFtDzFLvN
         QR3fegFuiAE+TrTGrsxaxd5JShXWKcDHcdn+B1pGSJPUSgiKfnkOtD046FVuZ/60jArK
         oSlg==
X-Forwarded-Encrypted: i=1; AJvYcCXit68j0WOdDizC/D1019h+DEjqilo6cE4Q/bh6s/o3nxlrtt5JFxSO7LQ2pcrqbhTPb3uwlsjgxZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywdZqQbHFKFuU5vSDUqWrC8HQHNtCkjqh/rm50Mo1peolUIFfh
	DXgO0dN+tdlFGvEItSNXTKWpWJgK3hPNbeC18sb9rIRM6yYr1bc0OU+x6Gsmq8wc38VCCbmxA4H
	/qbE+frnDpW0EpdcWSXjbFaQZc3ahKgs=
X-Gm-Gg: AZuq6aICZa31BMog+VoRbV+ot0CZ8TeHhcTGHQNLNAXJnxNa9df14ZP9wt048y21ZlS
	olayMsamXM7nzt19kXVyKDhsCKfN3EYt1lx/JDuAlz3PFqRSJGd0ySN0EifYcShQ3Qq/R42U14R
	sHTRxo53+n6uNvIYdRi5oL1UrC+FsBonK6mFBJXBXATqCQm1uUBDqz9l93Jj/vYXEL6DNS43Zxf
	77t+Nr2BYRC9DcFBgYgc9rtyT9jiCveMZgahAbXg6bDcAEgG3oHtDkjNT/UUHYEY3N7l/hcAXDM
	Yauj+BvNqb6hiWLNsgbH
X-Received: by 2002:a05:6402:1e88:b0:658:c11e:44dc with SMTP id
 4fb4d7f45d1cf-6598418449dmr8359535a12.32.1770783836845; Tue, 10 Feb 2026
 20:23:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211025057.29746-1-wanghongliang@loongson.cn>
In-Reply-To: <20260211025057.29746-1-wanghongliang@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 11 Feb 2026 12:23:45 +0800
X-Gm-Features: AZwV_Qjs2S_8KaNapnjsnLabauF-uP__2B7rU_oiaYXijjPm1jJP5WmfKCg6UMk
Message-ID: <CAMpQs4LeFNEXyg-fVDiSDpEVdbPAY5Z5gL7-5s5uZ52BWmXP5w@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: add i2c clocks and clock-div parameter parsing.
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongliang:


Bad commit subject, it should start with:
i2c: ls2x:

On Wed, Feb 11, 2026 at 10:51=E2=80=AFAM Hongliang Wang
<wanghongliang@loongson.cn> wrote:
>
> On 3A/7A/2K platform, i2c ref clocks and clock divisor maybe
> different, through firmware parameter passing, "clocks" and
> "clock-div" are used to describe i2c ref clocks and divisor.

I feel it's necessary to specify which platforms are different in the
commit message.
>
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> ---
>  drivers/i2c/busses/i2c-ls2x.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-ls2x.c b/drivers/i2c/busses/i2c-ls2x.=
c
> index b475dd27b7af..562bf32a9d6c 100644
> --- a/drivers/i2c/busses/i2c-ls2x.c
> +++ b/drivers/i2c/busses/i2c-ls2x.c
> @@ -96,6 +96,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev=
_id)
>  static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  {
>         u16 val;
> +       u32 pclk;
> +       u32 div;

Place them in a single line.
>         struct i2c_timings *t =3D &priv->i2c_t;
>         struct device *dev =3D priv->adapter.dev.parent;
>         u32 acpi_speed =3D i2c_acpi_find_bus_speed(dev);
> @@ -107,12 +109,16 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i=
2c_priv *priv)
>         else
>                 t->bus_freq_hz =3D LS2X_I2C_FREQ_STD;
>
> +       if (!device_property_read_u32(dev, "clocks", &pclk) &&
> +               !device_property_read_u32(dev, "clock-div", &div) && div =
!=3D 0)
> +               val =3D (pclk * 10) / (div * t->bus_freq_hz) - 1;

I think you should update dt-binding synchronously and verify whether
the existing i2c node in DTS{i} requires updating.
> +       else
> +               val =3D LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>         /*
>          * According to the chip manual, we can only access the registers=
 as bytes,
>          * otherwise the high bits will be truncated.
>          * So set the I2C frequency with a sequential writeb() instead of=
 writew().
>          */
> -       val =3D LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>         writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_=
LO);
>         writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER=
_HI);
>  }
> --
> 2.47.2
>
>

--=20
Thanks.
Binbin
