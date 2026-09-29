Received: from mail-pj2-f36.google.com (mail-pj2-f36.google.com [74.125.227.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0341D4F4
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663966; cv=none; b=TdLAnSbVkOSP9IUnCo+jLMR4gfpkaMj8UXNZOOqkLqu7rwhRKmvl5BRzVpNgItQP3TeqSBXavJ44mTET/Z+fn6EsOWPrzFEFjeR1woy4dLXkBjQ0Hj2SwLnuvHBcA8xWd3RiPKzy9vi/azNaiFV4bSnfX5F/U4rQ2dawN0GyVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663966; c=relaxed/simple;
	bh=SRsw/tmGhrITB7iknroQoKntO6GufEwstdQEaDctWiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeOKdgDmac0lGE6XQsQzkAfE1BoO542r/hXRDZwi7qNGpYjs5am6aP5x3XPUk7MF80V8I17qKkh/gUGGiszzxISbeJK1S2d6Tj1JtsVxKAB47gXzJ0FBXRF3ECmSMfewdq6RsEekBV8W2I4KHJNalaNRbgPAbnuXSSFOfCu7Gbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMpwY79m; arc=none smtp.client-ip=74.125.227.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMpwY79m"
Received: by mail-pj2-f36.google.com with SMTP id d9443c01a7336-2d8fdc579daso22821555ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790663964; x=1791268764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22ruvcxtukeWsFb40u9FymOfAi9ABkPxyopNdx14JWw=;
        b=WMpwY79mKo5Yi9pOBh/36IrRF/Mt6SYBaa+fANGTpMoMXQ9zWDQPaZtX90ocqnbhLP
         IKYW4buu5AVf4xRIJJe08HiAws4pxN6Qa/NJJOYEGlKZFMrWgkPEq1yRuks867/V64ns
         hR8L53a0du/Au6MLgILZSma/UrLltV6tA9zgELX+yQ13hYJS8XMaocWSajnNiBlMJgEG
         Yeuj0geRAwMD7vtvuM7lEQtd4MHlnRVsCTX3qgWTnsxUGx8VlZv8BYri18EoEOtek99d
         EnS1Irhbe6TrfCVDd7dpcJ7s5xQy14ZztQOX4/Zekq7xj0Lb9VHsQt85QTp6IfYXFYh6
         9bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790663964; x=1791268764;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=22ruvcxtukeWsFb40u9FymOfAi9ABkPxyopNdx14JWw=;
        b=jG4ZVrV8uQyz2M+kucIZDd76hJU2SKwZSI7cLl5bYvpftMHXxexjdLtAtYGnlAXZUd
         +//ILsrudm2ds8v7aM1Z7HkkvDDMMUbL2+Giv9I2DbZYvd1ogH43+hl9qwB0gxoOfp/b
         cT+XLjIszysRrqSZ6xOHg7O3yqVBu+9i9XOVDW8z5v2r4PBFwUSWSBkc0ifgHhoPtYiX
         YKe1C9k5g/LP36TtOzeaGTzgUMVtvaEOquLGouVPPVRayiVDswWUzwicwJWAFnNLidEJ
         02W97R21Fz3nsxbAX+ve50VivomhksNz7zNdqTmsDeyfYMtQm9lRwN8OOzKGc/pVRc7x
         WeaQ==
X-Gm-Message-State: AFq9FYJb1Vs9sIEmFnLB+2KDGFs4TaoaSMU7lIO2vn4+swSt67honTzP
	a3NlIXHMkJeO+cdxTCUDC0unHM20p7+nhVx83Kjfgi2aIhm8xxatPTAk
X-Gm-Gg: AYBFou2j2bh3CNb9xQIJ+5LMLYyWzNfRJkyo+EvAPD6EBYI0R+0SSkP6L8KQ7+pWniD
	SxURZwmUZxzgC5+roKae/HKzOH3epUlYN7GVh1yZ14La+UWHO7cyM7Umq1IqxQCsvxFaaKuqVTy
	0+dmS080INIKaVmLPMA1MGze6tI4nrD0JbQiAo1AdqpM6pxGpOTUzLhlkSbLKBsiCvykNiqfXtV
	+ST37VhzoesElrNRTvmf6CTdcgkxacJJNgDcTi6uHD5mMwt37aXVRR9L1NuLeJdVfx7QUiHOZpn
	G3YhMrMGmziNCQ6i33aZ09g8kkb4puNsrzrO9q7skBduMy/xfvrd0Fj9s2CQc3s808wgmHZzoYB
	gqXxoHLlswhoC1WS28Puq/zokwM+YY63pyCvBMs32jeP50OoX8+RvivLh2qz2cK5GuJjyXjQoND
	aaOAZUYF8BWeoAHpc2uekaxcEM6dadm7Sn/YjoMT41JWhh6IiwlWquioBCeyVVnROL+bn2hDGf/
	5YtQP0T7yANWFVNWst8rJKU2PgG3Vcbfa0lOXTJrgwiPg==
X-Received: by 2002:a17:903:2a90:b0:2dd:c100:3139 with SMTP id d9443c01a7336-2df7e24f3e2mr164122085ad.53.1790663964139;
        Mon, 28 Sep 2026 23:39:24 -0700 (PDT)
Received: from [172.19.1.48] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2c7822620sm4538185ad.37.2026.09.28.23.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 23:39:23 -0700 (PDT)
Message-ID: <a2fb259a-1e73-4c0f-bd35-6d59412537f2@gmail.com>
Date: Tue, 29 Sep 2026 14:39:22 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20260921083753.1109826-1-zychennvt@gmail.com>
 <20260921083753.1109826-4-zychennvt@gmail.com>
 <arpdMZ1KHd00_oLK@zenone.zhora.eu>
Content-Language: en-US
From: zychen <zychennvt@gmail.com>
In-Reply-To: <arpdMZ1KHd00_oLK@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andi,
Thanks for your review. 

Andi Shyti 於 2026/9/28 下午 08:29 寫道:
> Hi Zi-Yu,
> 
> ...
> 
>> +&i2c2 {
>> +	status = "okay";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_i2c2>;
>> +
>> +	nau8822: audio-codec@1a {
>> +		compatible = "nuvoton,nau8822";
>> +		reg = <0x1a> ;
> 
> please, remove the space before the ';'
will do.> 
> Thanks,
> Andi
> 
>> +		nuvoton,spk-btl;
>> +	};
>> +};

