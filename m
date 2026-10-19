Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792428651;
	b=wpFKxThZQ37f1e7d6cyG975wYsLZIzUm5LCBlW1diXCjoU/fse+mOtzmt2ia2MSV+PFX
	 Vg/qv3OEGa82EWfCaMCNGOrC0HCZzSLn9uzHdbsJZZQ6jV7D720TzOFDsO5jYq30zbI8I
	 XUl48/sSTKtzanUF6I7nFjr5Q8xmvw7SSRmTjbQdSW4OUuO9zBOYkYBskOIHBpEEU7IeW
	 JkpTTUxavz01SXWFhIKUjzBI4GUsH/+/DXgpgCZRk9I10P1cOc7Qb6DcNl+IocqDMz3/V
	 yal14Z8yOVBAzUuJjrYCtziWGVG0zU8hnlEYvyumQMrx96h5oir8YvCiL/vDct//b9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iVwRMBbuzg7b5pNfa4A9rRUh+XfwqITm1ddr4+PZFxo=;
	b=44h9jl7SPz/FnnMOWjmJpuyLZl8kOvLaJcoxBi/lVT0/b++W2cbkuO/LK0uOZUPELRCx
	 Eozl1zSlKk5Dw7bfDloV4axCwjTaQ6gg1xMnMGxSkW5qy/0ak/HptAhgkC1y2+ZsuvUVR
	 p5UDKp5Er2KcpbgzwB4buOBN/A1hkRsxkKX+/JVeg5p4e1Xyt+1Udy/oZAkv95vIZj0i2
	 axx8eM8EMm52Xr2b9yoJvsX3CIEImLueO/NRQTgywcWuwrkJzcA4aX2620M6n6X6EKEF1
	 ZXAKgj6p3xdx0w7kNU1I6dx9ZKmbQBil/QLXFf3jdCzfFeLpJcqnqC4Jd3O1WSk6ZPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=wRRuBfgs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6B606A32F
	for <linux-i2c@vger.kernel.org>; Mon, 19 Oct 2026 16:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B6B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=wRRuBfgs
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c43373ae89aso227879366b.3
        for <linux-i2c@vger.kernel.org>; Mon, 19 Oct 2026 09:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792428650; cv=none;
        d=google.com; s=arc-20260327;
        b=T3639J9GmgwDTjvH4IzpmGw8CMUnD/oA0FgvQL0BPl2xBNbfOLP23KubGjIuaNVcwj
         6vzFzH/1CpN9uNRivNJVBE9SWQIL6n9swQXM6nIzsCGM2TAWl5chlDEq1h3YlrxRiQcB
         jVSZZ9T0LnPVO3Rc5tkpo4Fr30hNw22M/lCdcYgi1xnBhfY6TYWQ0P8QE5SKr4nzTkhn
         pHPicWSrh28tt648R/gAXkkspI/C1QudirJ/NNxWI8MiFAgXTXXC086s/tgxUxuk04CK
         rSpnZW7uLmGJJEkp6CXlBE9J0mViaaWWHi1zeNrrjq8xhLik97HRzrgs85DGX2FLH7CI
         ujDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVwRMBbuzg7b5pNfa4A9rRUh+XfwqITm1ddr4+PZFxo=;
        fh=mCm9zxYABXiO1rPQ6D6mzsBaklRsXSV5K5bDAHfFU8E=;
        b=ORso7OhJ8OaQmrbAhn3y5lbU2volmLidRY9NN0LsdTDZsgdQ+aFdc6h66HtaHAPC9m
         qY4+fM0s2j9D8laSpJvWV0KoOwTfYEWIgDCYW0C1vEeSP5c+rf0bI9LYwwC2Mv54QUWB
         Px0p3MaUV43l4SfbN2wBnO3KaIJutDOeTN8jbPXLctsByQO1xTQGWZ8gr17FmC97AOyo
         GKQTxyf667zyTiaaiYQHREPriWas6BPLw+AMstRqic1YknMKU6oldi54VWDNcPm+3XaR
         SlAwM+KDYOJ/na7UOUWSvWeADRHNNhAy0Kjnz83Qou6L3EK+oBY3MnPTFEHoGgdfuzdm
         jNIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1792428650; x=1793033450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iVwRMBbuzg7b5pNfa4A9rRUh+XfwqITm1ddr4+PZFxo=;
        b=wRRuBfgsl2skC4jYuNJzx3280933O8iSm6sUVDKwqzC/L+aCsR3XwLNoqs8NRa3AO2
         s/ro79j0ncbri5v2xGLaLZAG3c1FaHMwDY2PyMSig625U/69u9hgA8DWdu0B3jMOfn4c
         y0sh0RNUSNeoR44CulbmHpzOeaDm0FBUTc3L5caY3vUAbk33cvh3s32bBFA3Q1BSkpsL
         fYyRYfZEsFVzV5k88nkU164YKRoSt2q2m+kDbBUno5O31iFNJEKIBZEVMsF42EbsVKMi
         z5bzngU4T9YW/7xs3Lc8anoiEqeOZTP7GARrwzj662jFI/BCb+5SnpzHyYp/w98HGpWA
         jTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792428650; x=1793033450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVwRMBbuzg7b5pNfa4A9rRUh+XfwqITm1ddr4+PZFxo=;
        b=HkfnRJMyO+KqhzAcFsZXqjFKp1ou/YbFpGApQpCSuPbu5ErDq+1a9oJVXAQCrLpbvt
         AlOdw3d8YNRcG43j3YhhhJ/eB21EjwJeI/rk6Rm/uO3sdCIFTyqENlDHCJeEAxBhOMFT
         NFeDhXvpFH3odDvtcr+RUBiha15tKsEfeSEN9oIIVyErV2BTxXGwQEY5EfR/ZjH9DXO1
         PFEhQmSddLt5Ni1jx8I/cZEaOYePoy0JdJwobEHfIh8g/BtVMjguULnU1jJCYqA3zEk1
         /xnmocP4giIaoT6jYQDNmusBzBy+QPedUhDMW93j9DkDFh7kuEYrgO5A1Hu65rqWVahx
         9iDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRNwskIITjMWkDyFljykvRfDZocYeapHUJP+W5mDCumw+SVC9moAxLS9ipWELg9EVauZ0x/WZLHWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5XZ1tYsrYdSPKv/ztW/bDMRvHX8sGc/R5ClB7PnXbyVLv2eaP
	Z+jZdHu2OkzeVQPXeWrvhEWHFniAUSbrk1nTupqCU+J6eSKByeYrCwjceCKal4+xP3j5CfWgrHc
	gWVAzjun4NN2ZPk9aLjbN4+tIQQtp5X1c1xV8xrEoQY8WUlvVse3n9h8=
X-Gm-Gg: AYBFou1V6Qu98EdJy6zVaTgg0mSd26j5hOJ9Iw8DKm7Yr5T9G/bKs0ia/D+XM/CyLDn
	0LEfvrjevdOil5sTdpS9rFsfq+VsCfwCrZQo1T7bvwKziEfKL25IzjN3Tuc6mslBmVzXBCDy6YQ
	5dOD3PQeIjbUGJrsRJhl88VKjBSr0seX0ZggQW7oKOCreKABI88yp7nrziQ33F3Kdji6IMpf4ij
	Xp3lZNaC4njLlOML9PpGgQoUzRoAglSJlOBgFxYFsKB+k/FTiP92UrZ8vdQSjekS0s2iRW1yx6D
	03J3PuNCKirfNuFmZaTAvYuPLfBfKlye+ajLY9JR4Iy64WjGw9v+nekItePmfkq49IRtmhgP0ba
	Lp6LFTomMzy3E
X-Received: by 2002:a17:907:c819:b0:c32:8cbb:fb3 with SMTP id
 a640c23a62f3a-c419da3f531mr597229866b.14.1792428649640; Mon, 19 Oct 2026
 09:50:49 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015-i2c-rk3x-disable-v1-1-81625845c175@flipper.net> <bfe8baa4-e740-4908-9d2a-4defc5240a82@rock-chips.com>
In-Reply-To: <bfe8baa4-e740-4908-9d2a-4defc5240a82@rock-chips.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 19 Oct 2026 20:50:38 +0400
X-Gm-Features: AclHuK8q0YJA2qpd7bG850w0xtzlJFV0bFMuoGTJWJoEbLnFUaD8-ggaMzyW9Gg
Message-ID: <CAKTNdwFYxPeaG6pZn3SYoR6cPAtON37ajo4nZpPE0Hm=y2c6Lg@mail.gmail.com>
Subject: Re: [PATCH] i2c: rk3x: Disable the controller between transfers
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
	linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, 
	"david.wu" <david.wu@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Fri, Oct 16, 2026 at 4:33=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> Cc: + David
>
> =E5=9C=A8 2026/10/15 =E6=98=9F=E6=9C=9F=E5=9B=9B 22:00, Alexey Charkov =
=E5=86=99=E9=81=93:
> > The driver leaves the controller enabled once a transfer completes, and
> > an enabled controller keeps tracking the bus. If the lines collapse und=
er
> > it while idle, as happens when a target's supply is switched off while
> > its bus pull-ups stay powered, its state machine wedges driving SDA low=
.
> > Every later transfer then times out, since the timeout path only reques=
ts
> > a STOP and never disables the controller, and the stuck state even
> > survives a kexec.
> >
> > Clear the enable bit once each transfer is done, successful or not, so
> > that the controller does not watch an idle bus and starts every transfe=
r
> > from a clean state.
> >
>
> I checked the vendor kernel tree and saw another case that you perhaps
> need to fold something similar below into your patch, along with your
> disabling controller?
>
>      In some case=EF=BC=8Clog like this:
>
>      [   12.393926] rk3x-i2c ff150000.i2c: irq in STATE_IDLE, ipd =3D 0x5=
1
>      [   12.416592] rk3x-i2c ff150000.i2c: irq in STATE_IDLE, ipd =3D 0x5=
1
>
>      The i2c clock is disabled, so the pending irq clean is not
>      worked. Disable the interrupt after the i2c jobs were done,
>      the error log would not happen.
>
>
> /* Disable i2c all irqs */
> #define IEN_ALL_DISABLE   0
>
> i2c_writel(i2c, IEN_ALL_DISABLE, REG_IEN);i2c_writel(i2c,
> IEN_ALL_DISABLE, REG_IEN);

Thanks for looking into this! Do you happen to have a reproducer or
any additional info on how this state gets triggered? I haven't run
into it in my setups - did I just get lucky? :)

I see the same write of 0 to REG_IEN just above my changed lines for
the case if (time_left =3D=3D 0), which makes sense because a
too-long-running transfer might eventually complete and trigger the
interrupt with the controller disabled, unless the interrupt is
disabled too. For other cases I'd be interested to know what can raise
the interrupt.

Best regards,
Alexey
