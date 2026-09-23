Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6FF38330A
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167694; cv=none; b=bEq/xj3TlmB21uu4XzbPCzlPpznm40bYL2m2jPZTgIr4o4gAEwNkK9cjI7IHZ/3cJgBkd7p3VS/1VvHgqbZRJoFaktu7htRrn2l0ghrl+lYtowQLYaWZ0nrei8l8stAwHNS/Rt0idi/KiUopX2YBsB32AH6DAg7eqSLC+bhEr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167694; c=relaxed/simple;
	bh=IY2o/9Zd0FHMEWHyc0k2wv+f7cAv88OH6tphokM1gso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hqw56naozC4wNNwyNnh70k/rzBVdMuEgTsBVyGQModqeVUrylN9AWHePGzleifODa2yWTTKE2bhvrdoN59qiZqgzpSKeMuX63omXQA8dGYlLCmkSNXdd2SsjxSZXzmOtXg+8AryLUYr654JLiszq4euiWuosaNGg5Qbwdca0Xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Comt8vul; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Comt8vul"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1a631f6aso103373966b.3
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790167690; x=1790772490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SLuek/JnZcrHdEol8bs1CY5iS+EZUcbu/8zASCIc9oo=;
        b=Comt8vulNJSzEfrWtzbQpLlA2WLwL8E+hI/7Vxzy3p4qTVogQ1pMHK3q45X/Z61pPp
         gqB11bctP7gzA1H3LeZkx1Y9pxRxY5uRYkFFzrXuwGh262uxJwVODHKrIHxLLD6eXzNr
         EBGweZBmTallHSNSkyXwmZ++huUu2d/M1+HLC9XV8ZJDOXl8bqDJAySM4Gic1sGMo4YS
         EnOLKW8fyl7FPVh0a/WB6HIGXUJpg++K+dW9d11yOpr/WFBsMx0EJMJRAsrHAkqBMKQZ
         zsVbaTKzO+KfJ3NRwpiWJrYbwQbPH9GPt8Y8bG45XLZI/3t+OH97yDCNewuxB0lBL+TX
         hTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167690; x=1790772490;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SLuek/JnZcrHdEol8bs1CY5iS+EZUcbu/8zASCIc9oo=;
        b=izYvOEm5TjVt/MOfvnmxl2yBEaJWzP3w+Vtzl1I+9cqa7ErxNw5arGwR6eW0N8s8UR
         BAcqKg0ciOcQLWhOFIjdam/N7S6v2cMz/faKGRt6dmXhCNbgN33WZdwy+aAx5AaAD4Ti
         cRX8mtOxBcgLWQibadqj5ZYaFk3vlce9XJ39tg3J77U6EU2PX3S7C4wtVyWDEUkEuq2O
         yzHuyZSoJHSVOiB0ozCWAqEnMWrRHLvVW2yHPQIuR3d8etgt/9RfPRKXIpqlk/3CxDIa
         b25nE5mg+R7/ZuP/BDNUnkrBkdSU5wT+88ltWNumYQKV1a0p7pdHSOg2cbZwAAGCX1LT
         Z6aA==
X-Forwarded-Encrypted: i=1; AKwUvBytL0qQCZ6LvJSzcMldiEdtR1xbVKOHHOzsGLwmSpZ9xK1A2AeIocGOja02cNNhL0FoDTn+uwJCyi0=@vger.kernel.org
X-Gm-Message-State: AFuF++nPo/7C4pCXRjndZvZDSPYNqLyZe4ImY5nj4HWgfYVyHQeMgUaF
	8rj4SZPJM5MP7V8lHuD4Xa2B3xJQuVNObTSaMBciCDU5kQwliQrr3K/JpFkN+izF2zc=
X-Gm-Gg: AYBFou09lK7hOhRwIRsZGy4rF+Q43rKpLMu9Di9TlTKXI/cp4s0QfmMrvaScWl6d4y+
	UafXcId17mRM8H+5BKlwWm6uZfBRblnnGSIHhn80S103Bbk0wrImJG0uri29t2yWQarij4Bjyl8
	4dvqzU1QHnMHEKbZ133jSzcuzrQ9FnAp/NV7RiAZi3ipHLh6alDEs4H2DmbHNJJsU8tU04pIHS3
	7IMkJ3WY5JLKEkMswxbcy5APqngRSD8NPzBW+XshfYo9FMkXesoMDkxkEYXLJTEbqnXMVVahSNJ
	6l8POWlZnK0qI7VF27edxOzPemVoXbq15FKaIECSSY9j8E9ef0Dx36Wu6/gyxHD1Q9Sn6cH6nUI
	ejFtF27sOwn1EYkfU1lcfQLyWO+6Jnzj65AqH2fWZxHUFzpwkpSgyiREvdq11kD457lArJxnFzr
	ZPq6BnSbSisWKsrnyk/nxh6glOg2teyx949L546TgVw48QGSxv4oe38CFZjd/EZiFWr/V7Ps7ap
	ZV3eI4UWfPwzoosLSMM
X-Received: by 2002:a17:906:9fd2:b0:c29:f5d5:5aa6 with SMTP id a640c23a62f3a-c2aae2b6a2amr198058466b.48.1790167690003;
        Wed, 23 Sep 2026 05:48:10 -0700 (PDT)
Received: from [192.168.0.167] ([51.37.94.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6ecd17sm112583666b.63.2026.09.23.05.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 05:48:09 -0700 (PDT)
Message-ID: <97595856-b932-40fc-b39b-04016517069b@linaro.org>
Date: Wed, 23 Sep 2026 13:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/15] arm64: defconfig: Enable S5KJN5 camera sensor
 for Qualcomm boards
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Suresh Vankadara <svankada@qti.qualcomm.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
 <RbdPcB-QGL3Q9kH1vj2YTIDgS-JUQ3rmbo-QovaLqE1ij0XTZhsPpaet3uWWJI9Yag6wL3TciIvWVqVK4TcTzQ==@protonmail.internalid>
 <20260923-hawi-maili-camss-v1-15-cbbb42e534ef@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260923-hawi-maili-camss-v1-15-cbbb42e534ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2026 12:02, Nihal Kumar Gupta wrote:
> Enable the S5KJN5 driver which is used for the camera sensor on the
> Qualcomm Hawi and Maili MTP boards.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5217de386edc5e32289e453288db0bd9449d4c6f..fa35db683bb253e83af6bb25f702e3127761c086 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -960,6 +960,7 @@ CONFIG_VIDEO_IMX412=m
>   CONFIG_VIDEO_OV5640=m
>   CONFIG_VIDEO_OV5645=m
>   CONFIG_VIDEO_S5KJN1=m
> +CONFIG_VIDEO_S5KJN5=m
>   CONFIG_AUXDISPLAY=y
>   CONFIG_SEG_LED_GPIO=m
>   CONFIG_DRM=m
> 
> --
> 2.34.1
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
