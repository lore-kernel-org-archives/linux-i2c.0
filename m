Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273823BC687
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324727; cv=none; b=k5I92t/nnsTQ/E/PgR8T5Z+drmSFRugJgDGGSdS4+QKqQmNhgbev+fFxdPYaGPT+49SXfTNk9nROj3L3+1pkhnh9xohFc84sk84NnlcARYupFzji7ze+cs2gmP1ysGvcRgbvQVTPeKMtuHxQOQD5SPoKZmm/T/fiYSyVlDVPR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324727; c=relaxed/simple;
	bh=z7OicjXIPwnXNSvovi1vAv2Vm9ubdmiYGd9IzH02SY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbQj1jQY1tM2dxgkejh3E/v0WZMWZEgbwHbNBrFWDcT+qPdgAhAjvvAqzLM/FbE+GA4IXyOPFX7jByi/bXgcJaqXjcDv9ckVktoLvkOOtfP1Z4dAMrZ3C6OlRtwEdMTzIBrEt4QgIKBVI01006TCmraInLkKX+9HaY4xV5FfifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZfYOmh1H; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfYOmh1H"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49041e84237so83728105e9.1
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780324724; x=1780929524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nvwED8RGbgBltkwL/n3QOtv3k8HO8bMEi70W4kuUWA=;
        b=ZfYOmh1H0uOpAUKLYv9lX07qwTQHC9zNrdXSyRXDTx0vyf7OhtocTWuOsm/2wiOo95
         dLDyv6B6NMJP1ePiPc+6inMC5p8aURq9SvC0E2E/KRkyDJx1gkBGmqgb8hlEJbe9SZoP
         O0N2dErTOURqKKIP1TOVutFh6nXiAyI9sbTMNtl9F8BU4iH1UdjGFbzFwjeG4i56BSmM
         2PIA29DIWnY9AjOiNYkMblVBo0W3hBhVtQST4QeFRmzC+HiD7xFci6N/UNnBbnEhldfx
         mEQGByD973I2wEkc/KfeLDaZRhzL0LrVLZeKb2jYCaKUHGJLBwvFtovgzxn9ZxvwLPkl
         IF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324724; x=1780929524;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4nvwED8RGbgBltkwL/n3QOtv3k8HO8bMEi70W4kuUWA=;
        b=PrEDeewT5lXW0HzSWVi7JqyEy58eJ9DG/bdGPzuthKtILgcX5F/EjKSuAp0ld5eVeM
         12LIy6eq5rjL4X0EeiGjHc3CXHgf++ikHV08rFmcw2eDY5vR48ZE/JfpBl1BwN84+s2h
         tt5L3J9dUMz6H8+4mKUgr4f5XunLQgosSY2dPjnLewVt2Mu1cs9D4UsuSYRNaauJ+Dhr
         Ys5CvOvy58LFN0vGaS9GkADsXFqaaGdLhNijltEpdlNId9sg7kS5kBV/BOg8071jpItz
         QJr8T9V5HtzkSdaai2i5gfascNSS8sso7stYHdG6op+Y2fToZJCZHaXK7ZJAClPIe+Ae
         +rVA==
X-Forwarded-Encrypted: i=1; AFNElJ9dIowGF7ujjDp/G/GfolxpsRP8bgUEqDQ8AzjP4VyZJ+y7DUiKxpgR6C+ttxhxDNx2vZXhJABEVP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWrCwDAeKQrEeV97txrJRn3YvfqUPt8RLtKM7rHHePwTMGnxB
	VPKFnjrf/49DRMNpSFYDWT/gNaWUuQG3tOpnn/3GWKssMzPwwNQ4DZeFewjhy2JTfiYo9t842Qb
	kzBejJB4=
X-Gm-Gg: Acq92OFfAqSNf/fDzyVEH8BmhUNp4n0Ww9lEhCNeHSzvKS3K2NStMG65uBbo1rzJTN+
	DONcLRF1RPoT2LKBMMCuYdFSCY7FtdGhcvCv8m/lq5O0DeA+qsCTN100xD88nUejk/qJkwv3dYJ
	TAcMVhIXC44Ljt0Zi8fR+ssd3kPwHyc6DCYDWCy4carPkexZoLJhkLR8V7W+EgU5+9sftA2piie
	afjzYuoOoycHQDcIeCM/NobdLvxROev4t06xqBd+5U6JcEVvGS1+tJyxjxIk1q9kntSr24gKah/
	gbUveMUtQgC779X4P+p6hdqG6mZQFHsnLEzB/iL8EqmeZ8eXtm7so24ecLkwks9ayTmjl0AWlXl
	ovtaPsuAVX9o+c2GDA7PsaNl/ABSW2iKDmy5zzkM5YuawhDwgsbmr5aBAEt1aHTREeaaePdjCUz
	Rpk+HjMo4QajbmSB2J9Ir5TIqw6VCuUmIhrG2n7ZOA3F1hO+4T+V0tHv1h
X-Received: by 2002:a05:600c:1d0f:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490a2a22bb4mr161598635e9.6.1780324724515;
        Mon, 01 Jun 2026 07:38:44 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.233.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0467957sm5620835e9.13.2026.06.01.07.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 07:38:44 -0700 (PDT)
Message-ID: <be2ee914-0c5a-4a6c-92a8-85a7bd72ed12@linaro.org>
Date: Mon, 1 Jun 2026 15:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: media: Add bindings for
 qcom,glymur-camss
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, Suresh Vankadara <svankada@qti.qualcomm.com>,
 Prashant Shrotriya <pshrotri@qti.qualcomm.com>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-1-bee535396d22@oss.qualcomm.com>
 <8618255e-ecbf-4f55-877d-09cb2faa6f50@linaro.org>
 <5fdcnv3k7w2r5at3oun4eldgbmh2o25rmb234urksy72le7an5@ddl4aapbjexg>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <5fdcnv3k7w2r5at3oun4eldgbmh2o25rmb234urksy72le7an5@ddl4aapbjexg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/06/2026 12:24, Dmitry Baryshkov wrote:
>> To be brutally honest, I'd rather see effort and buy-in from qcom engineers
>> in converting to CSIPHY as a distinct sub-node.
>>
>> Pushing patches to hit your own internal deadlines to the detriment of
>> upstream quality is not OK.
> Can we please get an update of the the CSI PHY series? I think they were
> some time ago, they received some comments and there were no updates on them.
> 

There have been three versions in the interregnum v6, v7 and v8 with 
Sashiko responses only, no carbon based lifeforms replied.

I previously agreed to take sm8750 and Kaanapali with legacy bindings 
but those series didn't apply to -next and so will miss this cycle.

I'd like therefore to move _all_ new submissions to CSIPHY as a separate 
node and to stop accepting legacy bindings.

Frankly instead of being pushed to accept legacy stuff by qcom tech 
teams I would rather see them engage with moving to the new way which is 
ultimately beneficial to them and their users.

---
bod
