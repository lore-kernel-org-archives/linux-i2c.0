Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871876;
	b=HzLluS8I5HP65K/Jqt9qZFbzRjaj0dhmf1JksBXy+i5XuqrEg8/2jW2+EXSz37Fp2Mwb
	 Xq0V4bUAGnk8xysIdpgUUU6UdE0BjUWxnspLPxjGSLp6IdjHPBWa3wK1pGm8uaYfUy2Og
	 U37j985AAutttGKhVHXU/UpFX+FWadwcudj0LTdNMEG+gaGpYy7VjbufSib0q5jEOg3QT
	 GL9QC0HXXh2SFEsYkEwaGbAgmbSYCBbaiwQjDKqL0ogzHxCebRcDBod08dc7IOlWWEFjd
	 0RR1+pDJNCENnv0WleLj18ubCX6A9p0gY0exLDDh/b/wjWbHZNFuoMJ3+IbsinESTYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7QhU4psUp36lRhdSvaABTdCrK79wA+X/bI1t7JAA+P4=;
	b=M+quS4fdHbUUJyZDf+sHoWFIqVeuQIArjgSRB//h6QLbF2FYPl58cUBcHci12SR6R/gr
	 tHuc/iKXWtzOpQz28JFdnsUspEQiR7XSAEp2Ifn5Q9/iy2EarA12Vvyowta8X4VJw80rV
	 u3yTE6l0ENFtwTHS41/c3noVjsaH1LYo4FnWPa9RcrTRMEHrLptfe8KU8CAUpCmYYBrCf
	 aS8CUsDvnQPzonqOQa3e/5Ju0B1vSPREcQIfcgkSVtUoFp8Y1J8zrcDigGNxbbfU/Y0Ll
	 SJ79hUOdIVWArbRny52EIySOWhW0KtQY3Sll14eFO8+CX4MdhO7BUXv22xOe5M0fBZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tRkOqEU4;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DF606A326
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 09:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3DF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tRkOqEU4
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e20edd106so1113552f8f.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 01:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793871874; x=1794476674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QhU4psUp36lRhdSvaABTdCrK79wA+X/bI1t7JAA+P4=;
        b=tRkOqEU4xOzE7XVrSahnzZw+u+Bg+xLCpTkl91fr/FbW0pcnhNr9FAx3T+l1yNJqNY
         wtu4o+HNeSsr3GQ9Y4PIY2gJ0iNQSyc3FVJoDgC1M37qnJzbxCySN/8cUiR9s2Va+DBk
         KosHb7H0Cxd5RsHmRdULYyyBcbwoEqsLCzSl0vH+p4RN3/7gmRXOBbwpaAHG0uHWyxcL
         +MqGCI7/uKRT1akFropCNXnuEd072gwImdusnSv2T2vu1tM8gCeH10HLraP/JALreFzu
         y1Dy1i3xxfUDA/QuIkMRBtbFdAOM4gqDbju3s3PkxsA4RoiBUjUP+k+eHki80E+TxhiH
         8KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793871874; x=1794476674;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7QhU4psUp36lRhdSvaABTdCrK79wA+X/bI1t7JAA+P4=;
        b=N1XunzlyqfmdZC3ElQwrgM/NzJg0r7kkSI+8UhChOLoaX9mrbspc/H5SfNK0sOqNP8
         /BY8QTWKsBY5KR9r6J9T0/7HdMlIvngICfBhXvI0txYBu6zHL5iZkKihUeSXmSEBq+Ij
         c9zQGv3q/KnRVHPTuRtG37iP2j1hNnVMnkK3K8csXJaduwVydjyk4wd0D3ZMw1xCpljR
         blKRB1wsXvnCJV/2qK8gCDmBxD8cIIroo6dWnkOaSl1hj/kkYrX/ceD5dwHqlobvR2Az
         9icV6KjDQyoHW1QnlzpRGFnJf95AgGWXjxdk/q8VZvSz4odToIAq525duuAKKDDTlFXP
         gJMA==
X-Forwarded-Encrypted: i=1; AKwUvBzl4nl99BttunQdH3DQCdx2wFSn1w3IoBuNTqLYzKdpaF5Kg43J/KIX8SJ3iqRlBhkwYv12Ewbtz/k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6Gio1DVEcg+ecDCEmnhf7qQHZs/0EQArpMmPcWKPjefBLNZaU
	F0EnwIlQ9wmpjBEtfeIzWBhQaeNm6UwwvAD3aTCEOu0xNNfrhb+zObxPI/kZpl++Mvw=
X-Gm-Gg: AYBFou1NmOckPOsIk5LR+4o9TRJxUjUDYMvjJpDzNg2/bWdqoR+BdRHfK20DqhyCDIq
	8Kik1/fx+o2v7PfG+dcSZCsMPS5LJP/emce+SWjDzNiV4MbAY7OFz/e+FlVghb3nze8lX0bG5XA
	pVyGd0dXiEtX2CXnKQtQfEjPJRRVJdw6V+nNmfaP3hRCn+8yxQyGtgrfn3yhX1B8CfcZoL88MEr
	8UPs8xqndv6nKISUKShR7tDIB8J26tqitX0kS8YCN0dGQcQ/LccSl+uSyp0NuMNEhgqjFXxo/sd
	L6mkT3uWQawNiqYiiTDp/8Or/lKboaipXPap+6gGIU87Bxafa0eKKr11LmFkvJe1sSzvqxcfOF0
	pDKSmZ0Vs/a5Vp8wzSZtORZVnqmubgTkpf1bnz0rih8ySeIZato/BuFRV+VFd9ozEiTLzEHkkCT
	fzCtibrK9B404hsw5L5Odik02r4/6S1hTVzNKWCJxhn2cKJwasmuH/lcPpxsRdyC3M9SywsIDAz
	OEdQCKHe0GtuHBC1gtpRhMwZ0pOzkbr0AbaZW2cJbfB+CXOnG1KSQ+V3P1k6NknUKsdXiDCA5lf
	RY5eDVeFU9yIilDcDXu2S25pxukW4c3NSiEJI+lf
X-Received: by 2002:a05:6000:2997:10b0:48e:5e63:bd23 with SMTP id ffacd0b85a97d-48e6e2ef96fmr29363335f8f.30.1793871874143;
        Thu, 05 Nov 2026 01:44:34 -0800 (PST)
Received: from [192.168.0.167] ([51.37.126.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac17c1sm8628740f8f.10.2026.11.05.01.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:44:33 -0800 (PST)
Message-ID: <a83a948e-3430-4133-ade6-b30045b8b186@linaro.org>
Date: Thu, 5 Nov 2026 09:44:32 +0000
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] media: qcom: camss: Add support for SM8150
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-3-7a9534a9a22f@andrewgigena.dev>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261104-sm8150-v7-4-rc1-camss-v1-3-7a9534a9a22f@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/11/2026 20:54, Andrew Gigena via B4 Relay wrote:
> The hardware reuses the existing 3-phase 1.0 CSIPHY, Gen2 CSID and
> VFE 17x implementations; the CSIPHY uses the SC8280XP lane register
> layout. Add CAMSS_8150 to the version enum and to the shared code
> paths, then add the per-block clock, regulator, power domain,
> interrupt and interconnect resources.

That's odd. sm8150 and sm8250 are proximate both seven nanometers 
sc8280xp is five nanometers.

PHYs are about converting the analog to the digital domain and so 
process geometery - ends up making a difference.

You can get the PHY init sequences here:

drivers/media/platform/msm/camera/cam_sensor_module/cam_csiphy/
├── cam_csiphy_core.c
├── cam_csiphy_soc.c
├── cam_csiphy_dev.h
└── include/
     ├── cam_csiphy_1_0_hwreg.h    sdm845
     ├── cam_csiphy_1_1_hwreg.h    sm8150
     ├── cam_csiphy_1_2_hwreg.h    sm7150
     └── cam_csiphy_1_2_1_hwreg.h  kona/sm8250

https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/-/blob/LA.AU.1.3.7-02900-gen3_gvmgh.0/drivers/cam_sensor_module/cam_csiphy/include/cam_csiphy_1_1_hwreg.h?ref_type=tags

So yeah going by the name that's CSIPHY 1_1 same for sc8280xp and sm8150.

Hmm so much for my understanding of how dependant on process node these 
sequences really are.. perhaps the PHYs area fully synthesizable in RTL, 
probably.

Anyway.

The one thing to do here is to please _verify_ what's upstream now 
against the tag provided there.

If there is a divergence then we need to upstream a 8150 compliant version.

...

Actually its fine, did the verification for you, the 1.1 init sequence 
as is upstream is fine.

Just please tidy up the ordering of the 8150 switches.

---
bod
