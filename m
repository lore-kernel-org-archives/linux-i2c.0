Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809038;
	b=I/XbWzqJ0kd6QP0wDKpXEP/ZyY2cr4vryW3QRclKnB/HAOrVrqDwUuuFmL/aO3SJz5WQ
	 3dU3kGBL8zksT46T8Xqyczha4RsYAB67ex09kRQ8a3YLIlpzZF19Id9a0dcT5MyMqYEPn
	 zcTZ0E9WKCB6NBoecZE3cocbU6/Dy75Q4pLFyNj0XlBMr+ML9SpCGf0r9fr0U+Hm6DJ/L
	 QudWTL2BwdcBElsxHJtEwgMs492G6FWcvRsE9tnpjU3teg3Rn3t/ys2NqtBM8rZtMSZ/d
	 YvAFaLta27BTKJcXfQtIlP/2XgYHcXkp3k02MhimD1B5uAbNT4YCx48+lQEg874grZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WGjQzXDbihJeW6cw6LNSbBuxJDvDK/XLahSbUoADWnY=;
	b=APLjEF+5kwpavHaUEQzozMX5fLVTe4y22kZhfE96VFEfunT5Q3yvd52P2eY7ufremlmV
	 0ddkLLqnfhQric2ClaargJyMMjXGjgAPKp43aLVyIjQQtSIOccPBSZx5TI0ZlfIuGJ75k
	 aDaiAqXaVQdbU0KoRCfthVfHE8MMjNcJoFEL6ikSx49g7SppL9p9UeZpYLpmA9pHRHKGg
	 MJpPJnN09+4Xl4Iv0qlyBNSh9IiUbffLf0snkf22bbYgeayTlI9rI8DYj8rg6daWtn3pn
	 3oIyoV3ipZcvIH7O7v0+RGS4SuKWwE64F2UoLgGQ9I19rTHItyzv1sW8bV8OuCMp72A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=raiqF4yg;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE84606A33F
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 16:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE84606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=raiqF4yg
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so8094435e9.2
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793809036; x=1794413836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGjQzXDbihJeW6cw6LNSbBuxJDvDK/XLahSbUoADWnY=;
        b=raiqF4ygK5JlaCGtO2waCV60lOHlih3bqY/lQOUAr5R3FP/h9GqOq9C9WlKrIiK43p
         DXycWEIoorIOR+t0tgYbutbTXDTie3myKpP4X/w5OiftollhGD7cR4paG4TEfRddYHv9
         XXIbRBhINwHfyoqGWrS9Vzfs//UNKLRrC2EWrOL2dcp4OVQSaWoaQWAwyz+o/PMv2ir3
         pSHwmu64dQI8dodQraZsnCHpfI8Iyysr7ciYmkqsXNvK50Z6BrjiHgO/cUi37Am3CwGN
         HUsYStNjCWrLTzU8jLkNGuDqPZI8Oqq2d/qm61DK56PrvpeVwwMhLbF+GHtnzFmAgAvJ
         M9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809036; x=1794413836;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGjQzXDbihJeW6cw6LNSbBuxJDvDK/XLahSbUoADWnY=;
        b=w+OwlmnKX3T4HisHVQlL+DafLitJQMxU7H0s/T6cUsfBzLUD3gI/74yGAobLHiCQBo
         sFlUCFqOxYb0i+laMaEiuj5Q6Ju78QJSqDSwOnWJq6jR00pF2g2T+jz3FRARsFtMdOol
         20Dm57CxpyTWMPDD/qaKaq7/vAgayxNPBjFLFmX2L+IyFrI89FjYe3w6T7GmlcnA/ikw
         kXMOd/3HiGlqDrWv0mbbRWjLEiJJwRjQ4roDo9O2oyGNzT5udt5KKURUld5JsjXrduqP
         EDB4Duk99mXMBnWoPQRONMSq9KGwnJP7S7aVyiyaVZXy5soIgbDuo5fitwQzSZ93c8No
         iLHA==
X-Forwarded-Encrypted: i=1; AKwUvBxvOR7qHAaPb0UeTU5S8RRXmwe3nHuymmeeDkcA8kdKW0of/0aXmFiVw29MI+wKP3pnvalvVqt7huY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8q1H2MkzQ4PstSosfuUU9LH4tdYjzce29KlnQiBanbZa/CLcrw
	DiaeHaWF1qh+b6njh9pq+qDEBRJwSsJ2GacDZDRZAW9dLsWoG6IPDBrOqKO1hlmiVeg=
X-Gm-Gg: AYBFou2jl8BvJ551QMAYrKUPrExcw/oAFW2/xYfXuOzF7X//cbebrDFnG7RdPz0sLG2
	VxHguA0G1sXIUmI8rq4smARHIg9MWyUx5nNKg4M8BQFcd2/lVbCbkDyNVIrkdsiH2Gi/v03Uppw
	vD569gHG/4xfMb4epOs9KdjedxFNvNEmEfGOaqoNf2NtXVLOfa8jgrJMUIhcRHpKYt3PTVh0Hoi
	I6kaQT60ouxFfsRy5O8drFjYThpFcYI2g8G0+wHJ3KL2cePTfrIntmDiWen6WR6CP+uuryCHPeR
	fLmKcLhGXQRUpEJRb/cKMgUGQSH+3Kbvxp5yxTprO6IoN1mG45QcPtfXuTF0KJ0CJi8rq1iYiqN
	8OzTZUl4Az3Lqxhq+FYloryFNMFCcglr9kMH8WJlaylS84INC1FAqES+GXcqNeIgm8iRLBZGC/9
	HywLpcvh5eI+e1MZg+kMCoRv0O2SQtEORUKz9RCPQtAMUgnQYnomy3MgbO6q7IR9gXzjlar7Tdq
	bS8AkWdEDGwpnygMJ5qRG8dG4/q2ikjQ4KE/SXTRBNcmfEWrG3uQFuojYN2mPq0ZVQ8u2i8DqmB
	so/YH1rAduWxzbWEHo7dNgyUtazGT83fIFZNp0n/9eY=
X-Received: by 2002:a05:600c:5295:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4b3c3545146mr75677375e9.21.1793809035955;
        Wed, 04 Nov 2026 08:17:15 -0800 (PST)
Received: from [192.168.0.167] ([109.76.163.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm169274795e9.5.2026.11.04.08.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:17:15 -0800 (PST)
Message-ID: <7acf1f64-a2ac-411d-a235-69ea52231623@linaro.org>
Date: Wed, 4 Nov 2026 16:17:13 +0000
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
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Suresh Vankadara <svankada@qti.qualcomm.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-media@vger.kernel.org
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <fFfGGWaoXA-LdO6s8Xh_kQWQfncXe9YNdpcj2yNkphWHAR_V69LdLOcuhXPsbg8dEUSN4j4yygq4wPre5cz79w==@protonmail.internalid>
 <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
 <5817be6b-7180-407b-acb5-8c5fdef4edfb@kernel.org>
 <73b1f591-69cf-471b-9763-a0b719c74501@oss.qualcomm.com>
 <fac8cd6d-c3f7-4ed3-b0d4-7cb8a7a6f451@linaro.org>
 <d92a8aaa-5cef-4416-b1c9-46ecfc6b2745@oss.qualcomm.com>
 <CAFEp6-3ka3ZKzCoLQ5BNv0YR+yhYXVRwV6G6rM8Lx_9hZ0RqVw@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <CAFEp6-3ka3ZKzCoLQ5BNv0YR+yhYXVRwV6G6rM8Lx_9hZ0RqVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2026 16:11, Loic Poulain wrote:
>>> We have a series from Antans to address this though.
>>>
>>> We should list the clocks the SoC supports not constrain that list for
>>> one specific sensor on a test-case.
>>>
>>> ---
>>> bod
>> Good to know that Antans has a series addressing this. I agree that we
>> should list all the clock rates supported by the SoC rather than
>> constraining them for a specific sensor.
>>
>> One additional concern: if the clock selection logic still always picks
>> freq[0], listing a lower rate first could leave CAMSS unable to work
>> properly with sensors that need higher bandwidth.
>>
>> Could you please share the link to the series? I'll rebase the next
>> revision on top of it.
> I don't think Atanas' series targets the CSID clocks, only the VFE
> clocks. Ideally, we should make similar changes for the CSID clocks as
> well, but for now they are not being considered here.
> 
> Perhaps add a few comments documenting the supported rates and use a
> single rate for the time being. Once the CSID clock changes land, we
> should be able to revisit and adapt this accordingly?

Its the same principle though.

I don't think there's a valid case to exclude clock-rates purely because 
one sensor requires the higher rate and we aren't willing to do the work 
to make the clocks smarter.

---
bod
