Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624316;
	b=eGlncgH0+Hio2M7kYvTEJe2q1o0cytllTxTImM+V9iZ7+B6f5l6B+o1DF74oYkZvBvW9
	 79HSZYvq9okS38TtwF0H1LRl3dlPk1JRUEeOri1lod7b/WZBMkLzP6LRo61GqlIDksx7C
	 BrfH8ZXcGnM0hpHb6Bkfxp3I1/s0l0EaqinOQfaCdKCyt8DqOnTMfxMwqdklJgeWldv/t
	 QhGxR8b5kn5pABcqrjSb+ZpzuXF+wQexR5IrqHr7kT1qASdBIdvRcjy4aofmDhrF7c6g7
	 SM6OQwz4jKQvqlnX5xIelkwA5yUgbIqyG0mOMEgE75Jl0wLYKh9+LcZHb0E6s+EEp2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624316;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LfM4uAledb3ebU9yvjdbYO/mTumVwk76mc2SnxdRhO0=;
	b=oNyYkSbJTx517bOruY366/lJ2Cw616hbKXvdkPcfA594I7vfJZAcCwCHFDCSQQWYsLVy
	 Z4WBtQZUL1FZN+WVXpGn31HxYj9j2LTtWnXULcg5L6PkctSalt6KZtxlj+N71fZnYeBcI
	 /4cl6mHZAr0326BuSBsurCZj5SBD2KTBVILPgaWouRQREQcZdLg2tjWXRSVDkEsjBKrHK
	 vgjDRbeHbw7dpjnRctcq6FqjnOzhZKAEODp76KB1AeYT7cvpt5/+oVyY4WmqQrhcJ3hBH
	 UWNEyMy/PXzXXrJ3UcrJulZj6b3US4GxVOJvmYJXpAQCOF487efUBUECbossq0TdbyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sgANBLTL;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9038606A33B
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 12:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9038606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sgANBLTL
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c315869241fso414636166b.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 04:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793624314; x=1794229114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LfM4uAledb3ebU9yvjdbYO/mTumVwk76mc2SnxdRhO0=;
        b=sgANBLTL4YAZDwMklFM2H02NJCcXk/PdaEgxBT2cdhpFkCoMZ6HxQPXwP3Z2b/DFeS
         wBWKIQCNz2vp3MFn2A9bfGLKJ+KfLCGxipZu5An6Be8/ZVkEo19A/rATSys6diqxaHtx
         J07c97i7fSaKZ2780Unuy3tmV4cGWFeFHLzoWzX4v2isazoe57QuT9koARmMIfnAKsIg
         vRgOeAcNKiSUpqC8uifA0GnafMX42orf2CX0h/BEp8yZMiZlT9lmRhupAQC5noRBEu2H
         IjpvebFG0o6EmmhdW3s2jUXkFps/v3WUdE7w11o9r1todRotUMvA0pTU2vV/s7A53Br4
         03sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624314; x=1794229114;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfM4uAledb3ebU9yvjdbYO/mTumVwk76mc2SnxdRhO0=;
        b=X9mGuiIRfOYiIgkIAM0e8EP4Lm0nWlsgC1VuiOc+FgHBuUuCvDUaAH5bkdIruF0+Go
         qLUaNfSyxYt+L/x2HFdnVzug3JIUJiJrYY4lfmeDIKCJ4IefeuzFnGH1oW4qjDmgwd18
         ybCTZb5ohEAkRCXH3MUwh2iCEIcttaXm2Mz7JOlHIlaBp/2jSAt5FxAGHQF9s5wtBtKN
         JJ5nysNcnb+zUHjJv/YzSRSUlqVf07fHDvkOaczKUGXWpfHs4d0tUbsvtA3OaqCSOlYT
         /T2zZ33ds3Xgou0SGJVwQK+z2j8aTB7DFHeDC8t/6Pzd9MCJ4Vu2AAdtv4vKcRWRVVjt
         mUZw==
X-Forwarded-Encrypted: i=1; AKwUvBzm7DYGvldTU/iWW8Akf304AJIpzccMzVzFY8KF4uMnHe25EWP3pgt8shLFhS5/Yz8OFZ3oqc7V1lo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ditCVwdd7a2bCSWaZ/ZPpp0RRqUULR7R4X90ye40wkq+dOLA2
	ZKddnUhN9AqGd7rZmQrHKJ913hEDw/bs9bWul2wwBqHcYQUcVkl0hwuC7WaMCdAeloU=
X-Gm-Gg: AYBFou0tp665XAWx8bNJM8pTxQ40P4GgG+UZc18RFWUjLaeOx24JZLVXzNmO11EEkMZ
	u5m5WnlbCGRtR6wtYQ6ybFJTlqxPyyehnS2oBEenWfMWYXqlXrDVCzQ/J49ChiWP0z2PEk55XlQ
	DGNtmHeGxH2XcRVvbGSJI59LH0ne8EKhUqTudrUYnIwHtY4bmKjQgiRS26VWdXtH1vofyfG4cp3
	wK22dThzDnYD5pEY7BQdNABFTunbrhTh7Efq0UC9J8q+Gv/cOO7aociUp2MC68GqQv8ML92a3tI
	cZobcC97CueTpsnB3aYnYUDodWBlQ8g27z0lUWrzd7sKiiYeEJKdOBGUjhSUsNbsIp27P/zDHEl
	V1BNlOwIF4MVOpIT+61vr5ZQM06d7Hvn9ybyFzgMEa+2CWprvEZpvg7xlkDiFpN2wIq1hEa3N7M
	eV/eh98Sk+3RLTR9XQWPEKyzlwr4EW+LdI79v+/N9YjyUiWb0nbqeZImXGjDHhNoSuiC87FLtmM
	R2lpyDT+xbPJRxrAk5zOc46ydqCUNujMVAb0d5Owb/PBCY194+DV5yRiO/Ck2f0dQNaBRMoyk6y
	F8GZbmulZElsM0atSPTxWcA4/p+GPKqjfwcj2A==
X-Received: by 2002:a17:907:7253:b0:c29:6400:ef8e with SMTP id a640c23a62f3a-c4ca7aa5303mr800564266b.42.1793624314046;
        Mon, 02 Nov 2026 04:58:34 -0800 (PST)
Received: from [192.168.0.167] ([64.43.42.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca0f376sm3476980a12.26.2026.11.02.04.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:58:33 -0800 (PST)
Message-ID: <fac8cd6d-c3f7-4ed3-b0d4-7cb8a7a6f451@linaro.org>
Date: Mon, 2 Nov 2026 12:58:32 +0000
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
Subject: Re: [PATCH v3 5/5] media: qcom: camss: Add support for Hawi
To: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-media@vger.kernel.org
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <fFfGGWaoXA-LdO6s8Xh_kQWQfncXe9YNdpcj2yNkphWHAR_V69LdLOcuhXPsbg8dEUSN4j4yygq4wPre5cz79w==@protonmail.internalid>
 <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
 <5817be6b-7180-407b-acb5-8c5fdef4edfb@kernel.org>
 <73b1f591-69cf-471b-9763-a0b719c74501@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <73b1f591-69cf-471b-9763-a0b719c74501@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2026 15:25, Hangxiang Ma wrote:
>> On 30/10/2026 12:43, Nihal Kumar Gupta wrote:
>>> +static const struct camss_subdev_resources csid_res_hawi[] = {
>>> +    /* CSID0 */
>>> +    {
>>> +        .clock = { "csid", "csid_csiphy_rx" },
>>> +        .clock_rate = { { 480000000 },
>>> +                { 480000000 } },
>>> +        .reg = { "csid0" },
>>> +        .interrupt = { "csid0" },
>>> +        .csid = {
>>> +            .parent_dev_ops = &vfe_parent_dev_ops,
>>> +            .hw_ops = &csid_ops_1190,
>>> +            .formats = &csid_formats_gen2
>>> +        }
>>
>> This looks strange, why is there only one clock rate ?
>>
>> ---
>> bod
> Hi Bryan, the current CAMSS CSID code always selects the first frequency 
> listed for each clock in the CAMSS resource table.
> 
> In camss-csid.c:
> 
> [...]
> } else if (clock->nfreqs) {
>          clk_set_rate(clock->clk, clock->freq[0]);
> }
> [...]
> 
> For the CSID and CSID_CSIPHY_RX clocks, the hardware supports three 
> clock rates: 200 MHz, 300 MHz, and 480 MHz. If I remember correctly, 
> 200MHz and 300 MHz is not sufficient for the sensor's output pixel rate, 
> so we need to use the highest rate, 480 MHz, to meet the bandwidth 
> requirement. Thanks a lot.
> 
> ---
> Best Regards,
> Hangxiang

We have a series from Antans to address this though.

We should list the clocks the SoC supports not constrain that list for 
one specific sensor on a test-case.

---
bod
