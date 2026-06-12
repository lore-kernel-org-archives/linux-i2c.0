Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F63D5247
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250844; cv=none; b=gYCN6CWFGgL8YPooYNVYAzpF0hXpQdhRPEljbfiSBeSP0S1oGLZjHVV+pSUcrGrp3GGRgELTVQzUDXfmeIkB3PXLpI3dHTpqWyh6p0KCgXkdJufoLvpYWRHr6ihijuS5hZI1pv7ighxnN+FAsz47KxwkCGlS0M+6h15Pecqx1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250844; c=relaxed/simple;
	bh=QBbXSr/c3akYemQ3kzkXquISdpepjP/Y0O5V7dwTJwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuAM0F1SP4V1koZL6tqTV058n5VDVVRTj3SBdVLz547yNQl/dMXgMYLMFwumQvHQIJ9ILx1hUJkG9TSgESq+BlEzi8NfAEqIdLetWSoTKqWnm9oNternX1WxR3Pi6+fYkVOonX6TPxvseyNg6t8hhxxr0DH1J0JGJ4Gls5dUTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0XRd3RE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0XRd3RE"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3967701fc3cso328911fa.0
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 00:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781250838; x=1781855638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YJ6W0UJoQmAwaQGvuK/o3SKo9denIg2VA3bJEyyrOY=;
        b=O0XRd3REwQ+hL3+Z/uzTLTyWtn4vfUV/1UwMutQmF1cUJy9JmK3Un/RgNaApnoZ4rm
         0wXUU0jZ7/3WDEXNal+6Zz+M4+ikJuJ2/x+LKi1Hs0xkxwyRn6r6Rj09r662z72E7b1T
         LGqExvLFurJsHeA+VJiT55uy9CrrPDdvKm7i6GdBQsjBdfsT2VS081/SsY/BkCgcTX1F
         O0ztj+ajpNR5HxfD/JLOXnOOd7JHZ/V062uytcfAxL5GVKxYXhHXVFSgVAPxLf6MxmVf
         PJMmStSb6tmoety+DlFDpmG/nYIY3WyKj71Xu/7T/pOHStYDfp2w/6UE0DD78KBquXbl
         lz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250838; x=1781855638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YJ6W0UJoQmAwaQGvuK/o3SKo9denIg2VA3bJEyyrOY=;
        b=HOtGJp2JDhxRyF1BeNDl7lSkyOYEOMNC157q9bZqrbQA0qod2Y4lZwEvWYZjrEb4pr
         lWyB0Jv6xKc4nZG/HWXC674L0QgDl4osmbEED8qQOBgss/u9+OojgX/KkqJZ/EbNtxto
         z6XdDRvpYTZTdgvHKRd87bup8Zd8gDwxZEWHPguKCNJKAuIZXaKWfdfZnEWzGBzYeQkP
         0BG/7CtFz/69yJwsUyaNHmzlQVbeRn+LHGSRutiYL8Vx9DkVKhDk9tCjxJjnfqIBsjXI
         mozmI2g8x9ymG8sJQVLNOtJNxarH7gQP5TiDzM26Q1ZsNlM5k3LXOWxA0I/UaomuKXIs
         ezbA==
X-Forwarded-Encrypted: i=1; AFNElJ8tnwISiuOGzAA6BW83e69fBjSCNeGmyyXyTMpnl4aCk+ihIGtmSyG0Qm4NNHOiYNR545RDRE7GRFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPV9+vvTFab/60Ea+C0n2tLR1MUJhsbI7YzO/6yDod7dFgVP3A
	SixmsCVtGss71AwwonW565gYuNFCaNiLUfk1E/HtQ54uNXISUut5mPKRH0+LWKZD+zI=
X-Gm-Gg: Acq92OFInk8VuuKIuuxTJj6LaXkvrvSyWiPfWHqIn9E+nVTWq+V4BwtZkfBu9e3FDUV
	jApcdtmPrjuelBi2NCpUtXaPMf82xgYIv4NVl7hAnjm4q9iRncMLmNGfv5AZ0l0Zt7Ir8y4+YUP
	Gu7iAhWl9iZxwaaeIxy5Io3m6kstCpmGnON7THye36UeLXFAGxnPpePJVVI4ogkIBMMCNxo76Ns
	Rp9jRt0XM/D3ZFCW5d77Ybrm00gMiOpz/UdAxq57sVA6BflO9NL9h4SEmSxCcGCceNOPjEa3wno
	UEUZmk2zeNzpwHogsqb5iyeLmiZ4GHRczY4mSDf+wyPLVvHtl7IqROBkZJDNkmNhn8jXSMjZZ8N
	9wYD6fTBny69XcKdLCpD2mIbhGq2l3KOP9V1RkZ3Cw0y9b1h8pvfFQ5el813G7Wkc+U3uC97e7z
	AWV4Dv1a0ltdMUhicuLU2gNgHNkhyI/yY9EsaW5HUBsEEuZmTrevsTANcyuSNXrutl5MmbrTTeU
	es3gw==
X-Received: by 2002:a05:6512:b91:b0:5aa:6fc5:642c with SMTP id 2adb3069b0e04-5ad2db715f8mr228537e87.3.1781250838480;
        Fri, 12 Jun 2026 00:53:58 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b4516sm308890e87.72.2026.06.12.00.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 00:53:57 -0700 (PDT)
Message-ID: <ad62d09d-ea06-4b65-937b-6dc49581bebb@linaro.org>
Date: Fri, 12 Jun 2026 10:53:57 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: i2c: qcom-cci: Document Shikra
 compatible
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Suresh Vankadara <quic_svankada@quicinc.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-2-ca1936bf1219@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260608-shikra-camss-review-v2-2-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 17:06, Nihal Kumar Gupta wrote:
> Add Shikra compatible consistent with CAMSS CCI interfaces.
> It requires only two clocks.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
