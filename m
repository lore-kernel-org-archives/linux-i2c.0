Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371608;
	b=EIMvHxdin+8u3/OEVLGT1RtWT/PtSbqcAWe13Yf6wwoSNqPix0FiAOJWKCrXyEq7vDuc
	 F/VeXjxYxsqiwWArFTDQG8WLqh3VRH3oXGHhIeX7+MIDZ2rWkLfSVtTxu5+Sejhi4F3bt
	 GleiAbYy6wK+nwvuYWt93a910+y7vcrPl2TidPFtnDAckbeWP7pccIeJSBDwJDUfZDmel
	 B9Xdy9vz4tYPkqd3BDesda8OZ/guXonXSmlMbw10stSvsySOCW46Ab0IDMwlhE1AJ5a8l
	 kReufpxFb0hGxIRROKZV9eSWe60lGXtN9uIh9rEnC7gyJaxhP5KpmA3J4JeqD2mMxoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ldEQiD3yYw9PYXG3yEuMCLLnL2/Mwr5f7MvpqEQVi2o=;
	b=4VZZPul5j1Tp88+HN3NAJGKr3eMObynlfAyC8Sy2IDZYat+pGJPbMQkccHE9LhOOeve0
	 U/bn2WD7gDzQ/bBBzc4RQWfxBLqlxitP0RAxPTrynHn4LVonZr7xoWCHSL3m8h7LVKbgD
	 HnccWa1Oa5urtQJ0vq4IR2Qco5+CDmY6lM7sZjcz8Hf6wsbVvpTj/me+DKh9+6IA4LOMv
	 OfyCr9o+2VXaJEI+287mRCLviPOGnN0966L1UleHwKsYPxNUFMPqA9jLVQ7UPhHhuRPxW
	 D9oyHRpUBjJ5dUjjbWTy70CC2PZqE3DrZZiv/3aIt7e4dW0xB5KPqyZHqgDuIYfbg7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wI6/c0oR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C6606A31A
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 14:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 251C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wI6/c0oR
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b0d91601bdso15906167b3.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 07:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793371607; cv=none;
        d=google.com; s=arc-20260327;
        b=S9nAgb6+G8n+czVDLLUffaKBHPMZ0kjbifbbaDMjdjCAVMaRny9V2GhaFPZ5XXy6WC
         M7TD7YTWIwPSoOG1kpNlpWgUePi0wzF5CMEjDl9nfa8MSACCU0RqBORLQmx/xmHi6wvy
         SBDZNJFZSQFmnwljuCJlffokv+Iqb6htTBzOdk6KzPsppr0K+mkfTwoJb1V+b+qHUVcO
         ydN1+Vn4AgZU+fmm3kJJX0n+DoSPn7uWnZw8ZhRtF/R0H5EO4PGRkWAwFuzW5iPWQigv
         pvpYmxzNK2n5m7AUBwl2nAZbmf4pTWswt4hFaRczVEQijgLIr0tXXyn6bMGH4mEHT/ns
         5u/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ldEQiD3yYw9PYXG3yEuMCLLnL2/Mwr5f7MvpqEQVi2o=;
        fh=PdXgacge+4iBXQ2IjJ6shLUfQFtN2/5ETqwwLo/eP4I=;
        b=CsvMEhifyb0V5hxO2YzFd7ALke6V1vJeEswQ7SnMvhPth+LYKnIivTizbjcXd99ugI
         4F+pCJ3tL+0mf4qzBZtuvOt8rTjiyhZ2HncHCO9ty2oO7mtf0LKixwhQi9ukclrfjZvZ
         pYh997hXy8eBSmXZc1JUgCkwfMdBPElSWZPW5Ox0rdLrE/d1HxNpwZ7/LvdJx8HcR2r1
         XoGc5mSPlDiJf8GMu6VNKbA+sK/fZjTPlhOpCn4qw34QWp+UXJdXhar4VyyTRcnm5syu
         V6s+VqXJ3GHx3vk2IlemQIddG87KdPUP9z8Jc2v22rMvpWVUT5T3AIS3pSmz5hPJuedR
         eUmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793371607; x=1793976407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ldEQiD3yYw9PYXG3yEuMCLLnL2/Mwr5f7MvpqEQVi2o=;
        b=wI6/c0oResgsgq5b8xhMVt/Y6kYk/H2ae6jbf2ayU65xNQSFrxQdj0VOiGPvhU7xgO
         y+qW80YTz++RZsX/GhMAVOYRfH2il2CjwqzD2eYLrgE1+YCNKVvCYLrVSH1J6BkA4KKu
         fGSeyxOhzQySNt7MtIKPDSRv2LVPOw/BdqNxXYtZNVHWJFOam+0Vw/HOHDJSl3xu8EH5
         jzUrfLRig3Ab/mdiLwd82zLd9Rbk4qdgktO4xiS2JEIgo761YcWUTNFNG+xhw6MAgbnZ
         HdzCKjOzV6bA+mJsaUewy2vobYWahPAm+Gno+UeAwZLY3/SYR61iI8Lze6J4VFjfuPsk
         RZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371607; x=1793976407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ldEQiD3yYw9PYXG3yEuMCLLnL2/Mwr5f7MvpqEQVi2o=;
        b=23uPNIx/AI4WzgaM8mE0X9XixSekXsWHUB8jdzWQC7pUZZZGuZ9EwEvRDV5Jk406F8
         MmVVZ4F7iw3tLZ1eR+PMwPm6pA+WFaTCTgjcrTzbWCATtpHTexwQOZ8OfnrgiS0yRHqi
         MNuuGiQaC4d4NvPsBwG2lsnrSbVHNzXb0EGCw2yrCKAA5cDf1NHBcoBUoVFcAPAAJRYw
         gs1v1BEkNsI9PfN5wPQrLB3rlAbAfZxMSaPme7INUqGiURZIvwSfixnAUpFvZSK/5Knh
         vxDns4nlbIsk/3IkxDx6cQveDLzkgLQckFJBb0wnrmWlMfjmHq+iW4knY6HikGSkzugz
         c3hw==
X-Forwarded-Encrypted: i=1; AKwUvBzLjd9L3Pd/ZTj8E3tSbh6bYGDOSP356oLar8HOvo4x9eLVs/3UoE0MqXSF6nOYChChdFiy/KfoxbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8/TuxYGqik/pQYYJBoHbYjDj4ylt1gtvzAeT03vBQZ617mHua
	NHDmxGbaIyDK607QFkLWoLcrJi//30/ohcsIZKSL9xt1HoDJ08efJyYG2+1RFPpZrLeio7KUiln
	stByLETV/7lrvyRTivax1ws+pwMRMuHk=
X-Gm-Gg: AYBFou2To5+uGMx8dg30o5tanH2vYF/tmmL2DezKTiAAU4ocBHSA/oLcmm2dhmRQSu1
	wngncduBilyDDKeCBjufMX7fz3AY1Qj7qYVn0vu0xgmV4TqyQ4ZtIkH4xppEBC6+TQ64DyG7+iV
	qScZisjZHHbKJ6aNUS2mJayvTPr/Yr1dK1jiF25HZZbw5VvrmndRnRLW2/4KtQFT03UVc2lY9IG
	395HAlwvuwppufOQFj6olMatzA8La+9GWucq71FzWn3gX+nE0msIrbVwpXu4Vz5RBOo60OEuOfr
	HqjR3a0Z8Kv45F5H677IE+/KTw1rE7yYtSb6/zCxmmk3D6ACX8cpVBKYt2KBF8KMSPKCrBlxLwV
	4YLDENikkVN2X08IG3zU8CENR3Y7MW9X19VbC
X-Received: by 2002:a05:690e:11c6:b0:675:6c29:c985 with SMTP id
 956f58d0204a3-67a8d3dda68mr4094771d50.22.1793371606158; Fri, 30 Oct 2026
 07:46:46 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016125229.1798791-1-thi.zirnstein@gmail.com> <20261016125229.1798791-3-thi.zirnstein@gmail.com>
In-Reply-To: <20261016125229.1798791-3-thi.zirnstein@gmail.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Fri, 30 Oct 2026 20:16:34 +0530
X-Gm-Features: AclHuK-GWiL1q4_WovgWSO5m2eQecD3gBL39B7xCULqbPJrTNpg-6D-hsXEdOeo
Message-ID: <CAKfKVtEOOGsJSV0_im=-0u=N=fxkDuCMnAzt=1ZfBs4A4rg_0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] i2c: i2c-xiic: fix waiting/clearing while atomic
To: Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: michal.simek@amd.com, andi.shyti@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 6:24=E2=80=AFPM Thilo Zirnstein <thi.zirnstein@gmai=
l.com> wrote:
>
> Use non jiffies based waiting functions,
> if in atomic context.
>
> Suggested-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
> ---
>  drivers/i2c/busses/i2c-xiic.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.=
c
> index e68e17bdf0ba..fc9a0628cb67 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -359,16 +359,28 @@ static inline void xiic_irq_clr_en(struct xiic_i2c =
*i2c, u32 mask)
>         xiic_irq_en(i2c, mask);
>  }
>
> +static int xiic_poll_rx_empty(struct xiic_i2c *i2c)
> +{
> +       if (xiic_getreg8(i2c, XIIC_SR_REG_OFFSET) &
> +           XIIC_SR_RX_FIFO_EMPTY_MASK)
> +               return 1;
> +
> +       xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
> +       return 0;
> +}
> +
>  static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
>  {
> -       u8 sr;
> +       int rx_empty;
>         unsigned long timeout;
>
> +       if (i2c->atomic)
> +               return read_poll_timeout_atomic(xiic_poll_rx_empty,
> +                               rx_empty, rx_empty, 10, XIIC_I2C_TIMEOUT,
> +                               0, i2c);
> +
read_poll_timeout_atomic() expects its timeout argument in
microseconds  the current one is jiffies. Can you check it.
