Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933248;
	b=09LTk96B874vykjUIsSbOvzWIla2+VDHZ+K+FydYWr5i+jkLycF5jUfPCfF7/r2T2b2G
	 1XS/GbSok0cJTWFbC7mNqPgijlMXEJpuaupeA9btyUz5G53/DUUm+JtF6jk+AZZmT+q8v
	 dsMVCiy8berohA8eLIef+hs8/espedndt1eFV0+d6orA6Ir6qGE7/TFcRdLPaRNoqG8dH
	 fKKQNjGN6QCnMrCuHSFVQON5gAn/8xZHq0jUG6ATz6doqAftRcZ52zeanfpSYkbUF2bki
	 XMgfHUwmMoEkKgb1dVGxcHEIFWb7ZgqrJyUwAGnvLR5Cjfeve1WdMBnoF68qa2kehnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933248;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6852XYg4nQB/at/PLi5oS751NBudRh/wjJbfpaCbjiE=;
	b=0DPoa9LpRZDIXoDNHGvYWhNumePz1EQ6FZWBhKtLIhVr/qzPb49Ixosvga/YP8b9fgoY
	 kWKgM9vx7lfIhL9i6u2SkW4BQ0K5sET7mEiLgwl+zmgcl/Mw+XMj4+H1NQAbdIN62e2ZL
	 9dcF6FyBOT3hcdsXMOp4auQw+j7fBzCP1spCtzqotO3SQD1c7kO/FSvc4hlvC8WeVtpz6
	 qCVBuXT9HQ2dnC2pz3TcNmWumAXYAw6pWoFjD7T48hLEZBNFNnvj5mFgUrZk4UfB4DzIr
	 yy92+6I8Ryep393EmYVPcg7ycamSlBiGo9y6Iw3oAeBqu87UrQ68Z4MXmftwS2m4MMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D649606A31B
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 02:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D649606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c423b145922so22225866b.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 18:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793933247; x=1794538047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6852XYg4nQB/at/PLi5oS751NBudRh/wjJbfpaCbjiE=;
        b=mLtOAYoLc+zK3h/4xchrl5dh/PQ5N95PCBjVqyKSvvniTgVW0+FhW3x6uZOZbsUK/a
         WLxfc9US7pFIqYZSQXxCd3uMjgvvjcMJ95r6GN9g7LjwajJfgp04mCbG1q1POK7v2sRt
         iwPtAn7I7eTmWFI8jJ6IYktHomXF385KX2VZkJxqZPw0V5W9CkZ1I86VpPbvM/6ZpjDI
         ZRIYLuq+EkxFgDuRTiDw9U4uwGteS5Ps12q0ds5zb2IIcrRC2kcnsQaOlacyzCpDt2/X
         NbcMRED3m5dK3JgmbILEmvtOv7SxGPWF0o7lJynWbjW3VjMsk+wEEpD8OAoleVi+iurT
         7qhg==
X-Forwarded-Encrypted: i=1; AKwUvBwtMJdc116cpSk+xviuLHqhztIi2Gd1fvRrGbT+GIwb+JO1SHW0pH9wzmsC9HpMODNs4GBHvE1zocQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Guej/lty1Aj3b+xyEVmCbFajLBhl+NgTPe1L3UozZ1iwimTBA
	MoSqT8jXLm2F/PNfTA5otL5p7XSawlP8BAXSSBaktvP2J8L9xumc2fRf9tX5B7GPToaWRg==
X-Gm-Gg: AYBFou2jiVZX7WLM/bhuctYXaPwIGxWdqJ2DACaQBejhyzKjwr7K2gOZDPCupNAVVNd
	24jBIkNJ+81fYtfbf25a5AunBlzAMzZfWLZYK2NA+wG8bIVJqw4SvZgM5l2UJ+VFZKp855vdBRU
	1Jz4D2LAjyXbWFhroVnAmiu/GZ+0TvTA6JoXhyCNwrt8FyJWzqIdII3M+uYmbR2qIALMO48NEtr
	WJoghYtA5x9gtQMBi5vyyahcuSTJWBQoRqy1fvPs6EdJd59THXIL0VHZUkzL+0ttSj57cVSMPIN
	Ka6ymbg17mgfOTaCrZSBb/2x9KyuZjOMFsrdxRcsvD7IEJgFFJ4XIkJ9+ipNq04o59J3meKtI5U
	GEwuJdJvMIO03DU+uKLi+AsQCm1C5ouvesbd2qr1zyP0G2ucH9eVZJzsEGYM281OHXi1O5BSdXf
	o+fk2Q+pokT+GyDZ+tB44Eczq+C/IArz+5XliZqPxaR6rJjjcIjqQMwJuSnGpsa3OEHYfvWXVIy
	z+IhW/vO3lGzlvUu6IFiWexQ3xkZEuJPUzx76AeFTRKtwkh17PZbe51Gbmu7L9u//gReiIa71r6
	kBWTN32XU7vngk3FNp4NXSCkk5okGTxcLHUQWJ66uRQoTrrlgOUsVBZg1uYuLlXbQmc=
X-Received: by 2002:a17:907:fd17:b0:c25:afb6:2d91 with SMTP id a640c23a62f3a-c4d344a88eamr92429966b.2.1793933246689;
        Thu, 05 Nov 2026 18:47:26 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356eab3esm37688266b.87.2026.11.05.18.47.26
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 18:47:26 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49134c8509fso138139f8f.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 18:47:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxuvby3SNzmiqkdA1gpzUt6WLU/EGus6witQ0IiFvF4etWyoj94OJVz2LIELOZ9en72g4ig93waOLA=@vger.kernel.org
X-Received: by 2002:a2e:a80b:0:b0:3a9:db75:823b with SMTP id
 38308e7fff4ca-3acf3b2b509mr2161401fa.17.1793932922440; Thu, 05 Nov 2026
 18:42:02 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-3-7a9534a9a22f@andrewgigena.dev> <a83a948e-3430-4133-ade6-b30045b8b186@linaro.org>
In-Reply-To: <a83a948e-3430-4133-ade6-b30045b8b186@linaro.org>
From: Andrew Gigena <mail@andrewgigena.dev>
Date: Thu, 5 Nov 2026 23:41:35 -0300
X-Gmail-Original-Message-ID: <CANn8Umedp8s=rupOkSdi5NBxOE8AUnWSvfyeQsMSohZG+Hce8A@mail.gmail.com>
X-Gm-Features: AclHuK9yR1l3Ka6EneLFe1X-dNaa_gcGDfVBlZZtGQ6nC7Dgsgyzy5WyWv0PGgw
Message-ID: <CANn8Umedp8s=rupOkSdi5NBxOE8AUnWSvfyeQsMSohZG+Hce8A@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: qcom: camss: Add support for SM8150
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Bryan O'Donoghue" <bod@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for checking the 1.1 sequence and confirming that the upstream
one is fine. I've fixed the ordering of CAMSS_8150 in the switch
statements for v2

Regarding Sashiko's note about the VFE-lite clocks: I confirmed it on
hardware. Routing the IMX363 through CSIPHY3 and CSID-lite1 to
VFE-lite1, the stream produces no frames and the clock stays at
19.2 MHz without the extra match. With the match, the same path
streams 10 frames and cam_cc_ife_lite_1_clk goes to 320 MHz. The normal
VFE0 path is unaffected.

I fixed it by making the driver also match the vfe_lite0/vfe_lite1
clock names. Since the same problem affects sc7280 and sc8280xp, should
I create a new patchset exclusively for this fix or include it on v2?

I can send the small media-ctl/v4l2-ctl script I used if it is useful.

Thanks,
Andrew

El jue, 5 nov 2026 a la(s) 6:44=E2=80=AFa.m., Bryan O'Donoghue
(bryan.odonoghue@linaro.org) escribi=C3=B3:
>
> On 04/11/2026 20:54, Andrew Gigena via B4 Relay wrote:
> > The hardware reuses the existing 3-phase 1.0 CSIPHY, Gen2 CSID and
> > VFE 17x implementations; the CSIPHY uses the SC8280XP lane register
> > layout. Add CAMSS_8150 to the version enum and to the shared code
> > paths, then add the per-block clock, regulator, power domain,
> > interrupt and interconnect resources.
>
> That's odd. sm8150 and sm8250 are proximate both seven nanometers
> sc8280xp is five nanometers.
>
> PHYs are about converting the analog to the digital domain and so
> process geometery - ends up making a difference.
>
> You can get the PHY init sequences here:
>
> drivers/media/platform/msm/camera/cam_sensor_module/cam_csiphy/
> =E2=94=9C=E2=94=80=E2=94=80 cam_csiphy_core.c
> =E2=94=9C=E2=94=80=E2=94=80 cam_csiphy_soc.c
> =E2=94=9C=E2=94=80=E2=94=80 cam_csiphy_dev.h
> =E2=94=94=E2=94=80=E2=94=80 include/
>      =E2=94=9C=E2=94=80=E2=94=80 cam_csiphy_1_0_hwreg.h    sdm845
>      =E2=94=9C=E2=94=80=E2=94=80 cam_csiphy_1_1_hwreg.h    sm8150
>      =E2=94=9C=E2=94=80=E2=94=80 cam_csiphy_1_2_hwreg.h    sm7150
>      =E2=94=94=E2=94=80=E2=94=80 cam_csiphy_1_2_1_hwreg.h  kona/sm8250
>
> https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kerne=
l/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiph=
y/include/cam_csiphy_1_1_hwreg.h?ref_type=3Dtags
>
> So yeah going by the name that's CSIPHY 1_1 same for sc8280xp and sm8150.
>
> Hmm so much for my understanding of how dependant on process node these
> sequences really are.. perhaps the PHYs area fully synthesizable in RTL,
> probably.
>
> Anyway.
>
> The one thing to do here is to please _verify_ what's upstream now
> against the tag provided there.
>
> If there is a divergence then we need to upstream a 8150 compliant versio=
n.
>
> ...
>
> Actually its fine, did the verification for you, the 1.1 init sequence
> as is upstream is fine.
>
> Just please tidy up the ordering of the 8150 switches.
>
> ---
> bod
>
