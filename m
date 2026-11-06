Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964612;
	b=ZForxxvNUtgPJ4sNgwLpzo650rDba0yV2hiB+xXlMMf079a6Sw7T5mkHTae100IPWpwe
	 yVXW0Tl9h+KPTHnXVGD2PQUKcD/DVhA4i8twgj2Yqen1hWCzVs9U77uxek5Kf0lAXPCZl
	 hU0Zpo5fR7HcnBtCpEY/KWkcOTeSEys9XIyfI4PHmZyVyTMqryD4iS+r2T+7NsPK7qT0A
	 gG8DlxbzxzbM/tIVCBAq6o+YAp0fBjgt4+aCldePGoeoi7Cd1rOw/UH73pqJHzJKUJ7/G
	 WW5aI0oAqM8kpeSzPasCcoBYhteummxTfDZZRlxP8cSQrnBoZfj4U306pRi6jmFwxEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zrC49F3NolngETQSjBIcHOxeA9JB7YQ05h7CAGEvXyY=;
	b=Lk9tWM9RL/AQVB1mnxNBjeW/XoKDzRahWwHLRnn3+RjHkSsuNypHXVpXkIlFoMYf2i/r
	 LPmEXv/6Ag3G7YJRrThmst/XTjauVKuRscEysCLoUCMFADIBOWFpX+Q1qWtsGMR0LIVmO
	 JHKUgzUJlDtHAPHVKETE5sIyjsQvovQ87dbBHNWdqN/8WdDZbCj9daebo42j7uocx7mUI
	 F3zaKfHXtC30gRtqOcFnDnRiklSdhM3gn21Jnpw2K3ra4tKDoJAjpdMHaHHYNvaO/B2mX
	 TftxJtiC/DkegTT07Nb+SLUVw0Y9CpErjNwZC9ScqBV+d57v7tPGcyqC4Mww2Yu+QHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VStxkJ39;
	arc=none smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BD606A337
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 11:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE5BD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VStxkJ39
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3acde6b7b29so601071fa.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 03:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793964610; x=1794569410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zrC49F3NolngETQSjBIcHOxeA9JB7YQ05h7CAGEvXyY=;
        b=VStxkJ39qneuOJaq/J71c2Z6J+j/tr6TOo8baa41Eoz2q2wur8CzdBg+qSIeHMkL0G
         sUCnvI8LvAXNTcM4DKs+cw7Fr1CIxHTAUOkiZjWEBTATLhXHLNSmCfHi0TG0vK/x7vUj
         MQBMokoZsj2L0fcN9bkP3asG9ZGu9YUqXwZ+pE5gCXd26qnmSRobs1/tyw3SlLiIYgCr
         PLOPD36u51ltTi1bg1fkbLC8483965q+kGhSTEKkILyTzH/urw3jmlwhJzosO4JXJwqg
         r26bOoV6cOj8YBJ7xSO3cpN2VpYCmezWwrWwGjoD2q7+pKu5F7j/I8O4h8BnNEIL6lCW
         fX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964610; x=1794569410;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zrC49F3NolngETQSjBIcHOxeA9JB7YQ05h7CAGEvXyY=;
        b=vI3KrxjY/pv7wk6dp5jLaUJqmeje9S3Q0/hgsnQ9hSp7ccV1mz9j7S07X0NHxGJeVK
         ahtRYl2XTfqMoeuYAxVZGp/Zl+gdRgPRyhmZU3ItRCb1BMxaP36h6faUH3jF468ypk4y
         lBckJYkh4reNufoSch1GqEBRod3gLH7a5bqiiijsr0bZzF4fldo1sZ3z2lWcmWGa6ccz
         Hb70aKkugjfnqScxfdOMYF8S8gf2e0cGJqfoqi/hU0/Gh8T9tkYLplHNZSZbZGsrds5+
         pgTeltIDaw0kP+HghPeoYO0N8wADEtUTVo8OF+OAXC1XHIHSIOmh5EHWAPaaSq+B03Bp
         +s+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmb+MOX02UR3xGJEABjlOc63YMYjLBjiZ243lVvSgf5nF31G7GIiPjKi8ydUavUFSqvLhnquyQgW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uaJShxAebp+uwqcNIIHGHVCFyiBL09HoWbh3IwmZ6BSUdD0wS
	bZ0FfOLspv2gDsPsfZV3QE6gAw0URjDm+9O79giHf5GYmy7bch8eqNEt3LAQ6GWr+mo=
X-Gm-Gg: AYBFou1Oh8mdsBhUZF3yACiLn7VxuWoGufvhnBn2CeKCKO9DdXcpDS27RSyTIx1dhr3
	XS1vmXnh9DCuSobczUWW0PVLQiYuzpYztCsHLBvc37ryq3408xtw8xtwNYJ+Yfx8mCxAgskZttM
	kBUCH+JGk+LN0o4OqPcOhu/iTFUbz+WD59JtGLlmD+B2ITeGhqdtoKpxOUr8tfTJyd8FxGNhh2N
	PNddtLgHGJgIwZ07XY0ZRANW0QcR6TZIrYBozhcPmL7/AuSAhykUK/oQ1+nGoKarIpXV3g4VeQN
	jkaximhxqufjymbpC7HV8EjGm57rFa/C397VP215VhgaLe5vs9HC7B7A3kjUzQnnBcOWEhfZcD6
	EpGh4vU2JIYA38W8zMtm91/TSntEaa2PosioLcV56EStu7L1D8aF1FM8hee6562EFIT03PuS6VT
	bwymyCD4+KSFGxrQiYkwf5xby44GaXeumy7LdIsLAXvcwz0+GcYOX7FOYZ7CZwZeW2gfUN2eezW
	O7Gy3JAy9RONWnQvrO7IHHW/UMx4He+WE73QiiR0T7+RifdhqH0OngwTPP7Ji5MEjzPy5KzrfqL
	Ra0E4ecNt6tKIbft6Ijvk9QArRV6SeUP9FatRJ8sjmIdywaBxGPul4GsJ5lx3I4euTZwyUbGQna
	kv1/8Qg==
X-Received: by 2002:a05:6512:4285:b0:5bf:b963:7167 with SMTP id 2adb3069b0e04-5c003c5971fmr847652e87.6.1793964610129;
        Fri, 06 Nov 2026 03:30:10 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acf5fca873sm2468511fa.30.2026.11.06.03.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 03:30:08 -0800 (PST)
Message-ID: <6f206d24-8e63-486f-80ae-68503f3e3c53@linaro.org>
Date: Fri, 6 Nov 2026 13:30:07 +0200
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
Subject: Re: [PATCH 2/4] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Andrew Gigena <mail@andrewgigena.dev>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-2-7a9534a9a22f@andrewgigena.dev>
 <904675e8-701d-4fd6-b418-6c0dcc9288b9@linaro.org>
 <5ba03b8e-1d51-4e66-a802-37e63814f5d5@linaro.org>
 <CANn8UmccjAh7PiLpbGHrhDR4yn=w6uiDYU01aoZvBs-tGkgNsQ@mail.gmail.com>
 <1fd0e1a9-ef5a-4fb8-8c55-556b62b73ace@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <1fd0e1a9-ef5a-4fb8-8c55-556b62b73ace@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 13:24, Bryan O'Donoghue wrote:
> On 06/11/2026 03:06, Andrew Gigena wrote:
>> Hi Vladimir, Bryan,
>>
>> Thank you both for the review and for taking the time to explain the
>> direction.
>>
>> Vladimir: I understand your point about the stand-alone CSI2 PHY model,
>> and I agree that is where CAMSS should go. I hope this series does not
>> give the impression of entrenching the legacy description; that is not
>> my intention. My concern is that I don't think I can do the PHY-API
>> conversion properly within this series: as far as I can see,
>> qcom-mipi-csi2 currently only carries the x1e80100/glymur
>> configuration and no upstream DTS uses the PHY-API path yet to take as
>> a reference point.
>> Converting SM8150 would also affect the other CAMSS SoCs that
>> still use the legacy description, so it looks like a separate and
>> larger piece of work.
>>
>> If I'm missing something, or if there is an existing branch or series I
>> should base that work on, I would be grateful for a pointer. I would
>> also be glad to help with the conversion as a follow-up if that is the
>> preferred path.
>>
>> Bryan: as the CAMSS maintainer, could you let me know what you would
>> like me to do for this series? I am happy to keep the legacy CSIPHY
>> description for now and follow up with the PHY-API conversion, or to
>> fold it into this series if you think that is the right thing. I will
>> follow your guidance.
>>
>> This is my first submission, so I appreciate the patience.
>>
>> In the meantime, I will send v2 with the review fixes so the series
>> does not stall.
>>
>> Thanks,
> 
> A) No top posting pretty please with sugar on top.
> 
> B) Since we are reusing an existing PHY init sequence there is no need
>      to port all of that stuff into drivers/phy right now
> 
> There are several complexities involved in porting existing bindings a
> new topology whilst supporting the old.
> 

That's exactly the reason why the new CAMSS changes shall rely only on
the new CSIPHY layout only.

-- 
Best wishes,
Vladimir
