Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD803DE449
	for <linux-i2c@vger.kernel.org>; Thu,  9 Apr 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751687; cv=none; b=kHmEdlbr81Yl71MwD7szlhrned56mcGKEHEiNifdrB7Hvcmm42rAmZJOIR5gQq7BmMAv57st9ilc+DzSo+/TKsW86JYlNOvufKVqWi8YkgHjsixKRH2NaDHHqjQbLHvz5eE0oFW4RSgCQus86Im+2b0Qu11e8cgF4u1SRQpwSHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751687; c=relaxed/simple;
	bh=KgYrTRAzAqR2qcRtqco8ayHZnGZegHdK68JQOVgPks4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DUf0infVfxju1eQ0IkpYptk8iX7zZtXf+BD5gBGRLHH59nDgRouRKlNmWsp9Wl1i8uOF70g6Iteeu25qJS97RlclppJjnCRUz4DG5jAXZtbVJFSXer6M+TC0Um+Yp5iNdjw7woIy15dE+PiDv4Ph+mOgVfc4hTvaD+ZM1i5TBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8hiZUcx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8hiZUcx"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cef263bedso573983b3a.0
        for <linux-i2c@vger.kernel.org>; Thu, 09 Apr 2026 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775751684; x=1776356484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPPDJR3OP9YsqgLCzmnEwDF9nzYo3p95aTxV4oH2T4E=;
        b=W8hiZUcxJ/KaIlX6ErNliEMRV3RnAr2nJc/zC4z4FBL5z5oi5laJj3+OjtPZ2XFKqB
         PUnuZ+jBzCZTrsz5hQcqCFfdSdRJzULV5aFvMHDq10fz5Ef7X9My7aqhFujM2wZwXOG4
         QPxsXuh/ZI/AbkFUHV8jjv8w1qmrjGCrwPLHc9CoUlkVCgYi5ojnYmfTUXtmq9P9KRMZ
         /vM/LJOvTf1fWwh19OKnO0tUPrgABNFn90dYE6mT0x2lUNfuvRKUOXOy0oE6CSMDoGYM
         olqIYUBb8xvpK9tn+yt6UnGs0dJJhkk0RO9qsgyqFlSJ/0aSKq/p8uqPVWDOzUPpP3ci
         sW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775751684; x=1776356484;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPPDJR3OP9YsqgLCzmnEwDF9nzYo3p95aTxV4oH2T4E=;
        b=RPCYXDqYDWb2JE8AgA+2Jvbpeww4KOvftSwq6qbU5Hc4FXznnnpIbT+nwyu/g7NDSt
         TBdN70uwSNT4OuIce+sqDbrQI5842CfZxwLK2y5bKMtpcPoT7XOELoniYfHjJULC2wc7
         60xfDYjNI9+qM1RERNRsj8vCyDc/i1ohiYQnZeCOr9OpCcCXW08UB6Ia78CAJ666+Ym4
         7oiw6haQDMdB4ku8HPaEMLg1BXW/QmCMFevs8UOHG64+1xmhk7zd10VWgheH/YdGx0hj
         RMQN9Y7eWajxOGTR/Z2vMqJveKUC8z6ny/SLB3na8J4NazoRvc43yVHYEAXYY/xKhTYa
         +M9w==
X-Forwarded-Encrypted: i=1; AJvYcCXGqln2vFc3jow2T4b7X2AG5yyhSPBX9+SrBFQ5Lf+I+KQiTKFhUz8MROyArldcpSHFSzUu7PljMwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4s/esEmWH81NsIg5GIMk37lCCNNCUzJ+IYVdT6FPRsItYUns
	dBZgECasFmPaLyfc/GuLSfVpY7MnIQtNZp9tqOcJ7j7jLV2PFsVMoMDj
X-Gm-Gg: AeBDievYrVkETHxZw11l9g2lcuJ5W6sE6xBeOLyMKCvYKNQ7AUlJkR2lOkV7A7MoZm5
	mvCGTUXM1M2U30rermWrOPPLWnYA1jLlfgW147YeVTQNwS78n6Q6UrPe6SFAcZ4sc5rzB8asyOb
	ocZ7PoIue8+PT7MIfdiqUGF8rxr9rQrpaol3H+eboDvNDZOALUJzYwhqQe39q1tTZ1eF/xd2C9q
	5cNhGaaMl1uAT5+ZUKhLZ9hVuckqrxCgiZ9QFzxjQK5hsNOeniiZMX9VEX6Fi0tt+RQMqjGzrHK
	b7YfXPLOM5PkrzM0vfBEDRaZ9p8tNLMvEsIYsXjL8PLLxHqPBv46qVawE4mPlpiNolZek2Ayoc+
	WxIttIpIo4Pro2NcDt3TlIE7xp5J142jSVYFzMfptJ3Vrw4k+W23LvuBFzECe0ZTcQr9zGZdd4/
	ytMVDgydZX2A95dz174gT8i61ZiftBU/1+jHV+kyzl5c2bvWuILq9Pxy9nGqE2f+9gqZKDPpXk8
	dXwwRGjSOA=
X-Received: by 2002:a05:6a00:2d01:b0:81f:9b4c:81c0 with SMTP id d2e1a72fcca58-82dd8abaaeemr4410862b3a.41.1775751684017;
        Thu, 09 Apr 2026 09:21:24 -0700 (PDT)
Received: from ?IPV6:2401:4900:8f4f:f496:6d85:c852:1b90:58b8? ([2401:4900:8f4f:f496:6d85:c852:1b90:58b8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbdfsm31162001b3a.53.2026.04.09.09.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 09:21:23 -0700 (PDT)
Message-ID: <968dafc5-ba00-459e-b31a-b46d1f0de347@gmail.com>
Date: Thu, 9 Apr 2026 21:51:17 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: i2c: nxp,pca9564: convert to DT schema
From: Akhila YS <akhilayalmati@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260408-i2c-nxp-v1-1-8276ccbd95fb@gmail.com>
 <20260409-rampant-swinging-wolf-51ab4e@quoll>
 <7930789e-6930-45b9-997b-0e5c850db194@gmail.com>
Content-Language: en-US
In-Reply-To: <7930789e-6930-45b9-997b-0e5c850db194@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 09-04-2026 20:32, Akhila YS wrote:
> On 09-04-2026 13:56, Krzysztof Kozlowski wrote:
>> On Wed, Apr 08, 2026 at 08:23:31AM +0000, Akhila YS wrote:
>>> Convert NXP PCA PCA9564/PCA9665 I2C controller to YAML format.
>> DT schema, not YAML format. Look at your subject.
>
> Okay, i will change it.
>
>> ...
>>
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  reset-gpios:
>>> +    maxItems: 1
>>> +
>>> +  clock-frequency:
>>> +    default: 100000
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>> And if you tested any DTS with this, you would see this cannot work.
>> Look at other bindings - you miss ref to i2c-controller and
>> unevaluatedProps. But the problem is that you are doing something which
>> would never work, so I have doubts that you know what you are doing. One
>> thing is to make a mistake, other thing is to post something can never
>> work thus putting quite noticeable requirements on review.
>
> You are right, i missed referencing the common i2c controller schema and
> did not handle unevaluated properties correctly,which makes binding invalid.


There is no file named i2c-controller.yaml to take ref to this yaml. I
tried testing the yaml file with the dts in my local machine and its
working as expected.

I even checked the status in patchwork and there it was marked as
successful.

>
>> Please first learn how DTS and DT bindings work, before you post new
>> patches.
>
> Thank you for the review, i will work on it.
>
>> Best regards,
>> Krzysztof
>>
-- 
Best Regards,
Akhila.

