Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514219;
	b=FKIx5Ih5gv9Hv1G5WLoCW1zqGyjwgA77s09JLsKZ3xAU8s52eGG69BxiASz77rI2Q/TT
	 xpro1aoTqMl3lPTkY3SCaNm5wDCYrLn0tdtt2hkcD4rTO47JcKOcEyunbKbu6TqloSEZx
	 F+p+l8VBhqS/9Sz0F8nQSSXNBJmDSJRj2yJ07ME+94e24MLx/hSsc0Pn+7aFMimU0p0Oa
	 f0h08B3fKJ632PYhgbyNxBzOtYcY+LUhRvPJ2W+gNtVhtU+yXeEejgbEoJ1/siSKTHwMe
	 Bh1MeQvNVInLAyNV8VH7ukHSkqGJNiAgu8zt85zgpejgBCjXvSDwKNbzRTUpVus8iWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Z7ixIHGB/x6muOCf12bPPxl1sG73TY3AqjMKZ2p7Iqw=;
	b=0FdRg4qwBDUC8ZODcq5SnV645YegMakVinC7s4yR/pCbI0+gYtH5PsQUogO/WvOFXL8r
	 53R12ypsgiJlnPgcnB8Y8ZhQzpLamuVmXNC4ep7X8DiAX4BtnvvRMF6Z9OSIQKSiOKI7c
	 E0LsSJ7psTs/je18pxYP9uiir2kR7lr+2v1eDvMl6DIB4j9nQ0cThYqKWk89TMXJqgulI
	 EamhWk+q6ZOW3fQaiexbLvisxKL5Hbc95E/nageGQwJT2R9BXcvmREybdiuXQP3RTSqwe
	 PUH3Z0LHvCPOqIoyGNi7drm9i7l9L3BeHBYJkAPLy0tbIR8yOA7tP+Jcr2wuQvKBZ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmCLP9gt;
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B366606A322
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 09:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B366606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmCLP9gt
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3adfb744fa6so3515251fa.2
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 01:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795514217; x=1796119017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z7ixIHGB/x6muOCf12bPPxl1sG73TY3AqjMKZ2p7Iqw=;
        b=fmCLP9gtyFynzPpKhVinxN3fvX0HMhPJbqD1her/p9bj1TkyZMQ3CUW2x1K2iN6Q6x
         wZ4W5yjzxqt3fzPs1oofjP/eOC6ezr++bplcBpOLgydsEwa/ibvh5ZgR4ciR1XPO9Nun
         tJP8gaFyKB3uXo1JAq1nJVoyQ3d6zu2DJFMcAnm9FOJt6bYNI5jAISAfNXrcQZLMqqbS
         XbcOsFJ/qBdpwrj8ya6lkp1s4F/MKwr8F9x6FTOxCEkFzlQMc66c57dzu5b4dZXrAyqU
         sjyN/lSUSN7rV1QbdPFM53mzZAdsRIXj0FmSSgxsnNdCJIdXXBRN5ZSI4uvoC3MJhezY
         xrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514217; x=1796119017;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7ixIHGB/x6muOCf12bPPxl1sG73TY3AqjMKZ2p7Iqw=;
        b=pJh+VAcLcPmn3wgZZsCkVlIeYI6vVlpYZQi6BlAnebCdUgkzrhba/dcU94cMTxlxPW
         M0lZxxGJHcKRNarzqvkfRBQaIAu6TGk9iJmDrw+8UCot3f6nV1M2rxHUJtTN0DOYo1vr
         I8DMk4V1rINPfTWHaZKsUBuQi+RVjsfUX4iAJ08XYHEVmbXmmW04pENmY2CRRYfOUxQL
         9HZyGxB/JEACotfYxBzBXYp6RaoWtswgc6KYenMIihmY6Q5TUm8cQWv9JE7QvZzISuRm
         kW0K06EdGem5dzh8b5vmsXMwvq5tOtJuOVS7UJDmmWUJGe/xw0dganPnB47CcjfE2VKX
         1quQ==
X-Forwarded-Encrypted: i=1; AL+hErHtT6d8ALXrrtdqeio0EXZG7NaqAdfZ5RKCC8Y6YqdhOQnDohrMGLzgsvcy1NRDGUWRMDMQ0wdPmp0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w4eWmscbpoz7bXoF7ED4iADY6mI+dSS/++jmNNWitB67FmGC6
	IsclTJX2Dzm1Kp5Nh1gUYdzES2FAcsC+7MfTfA3wSW8e15dXeniEfHVqL9S3oNcQsI26NOORmJA
	0EtseFCQ=
X-Gm-Gg: AZFdTZchDwK857Ni3gJcDQd32fqJFDam2NCu9xlqVxedc9aq6+BgU+x2bK9ODmY2nRg
	M5ZF8y/3+ejuRMFFkreHFF5FtOQo3SG7kp5Dts/vR78E9wiOQQYC9k3qYccHbdx3yWInMgx6i3P
	fRJg7LXKU+uoV9xKUvo/V0ftNckRGvd/q+6Z4+NiwTjOfzQ7WOmTPla/xcR6wcBn8W94u9Pf9YV
	IMGqCR108APgHqwHSC9ij9VNSkkgK4qwI7hf3nrgf1X8yY+PiYsD9wls4UfMJOybh+N+14ocmqo
	p2kO/jkO7RhDZL0VfwuKQ6COrNwoitrkk5ExVh9NDWGwPBXCQfuPkvIqDm4BT3XD2CZgk3EAKLL
	tdObq+Pu64eOcmZ1GgKkol1RR83jY48v5UNLBj9mcqnn/9B2xoJNximq78SzaZt3KS99radquQ3
	wyyccQnkpUGOK5M3sV4tBAXyrIXfvNKzG1SVWB8Esexo3O0Cwr6ZpQtwPX+e2ikgs9a4tywItOx
	yyU6cVYuZjFi3DPDnd6rk1oAF8iYKJDtgeiGKkz7fCYDqfQncbcxhp/7+bvReIoELQvMJYKTziT
	v7PG2YWdb2isUSF7GDebVjVKiidW3PtXXQjCt9QDdVtbKPAXcncswMxlLCBn68yq4jecPXQ8n7q
	lEI/3l6c=
X-Received: by 2002:a05:6512:b88:b0:5c1:5488:f57d with SMTP id 2adb3069b0e04-5c1bc85b735mr5132306e87.4.1795514217327;
        Tue, 24 Nov 2026 01:56:57 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bcff86c4sm3570448e87.22.2026.11.24.01.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 01:56:57 -0800 (PST)
Message-ID: <da038528-5b25-4956-a14f-1827ffe2eef8@linaro.org>
Date: Tue, 24 Nov 2026 11:56:44 +0200
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
Subject: Re: [PATCH v3 2/7] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: Andrew Gigena <mail@andrewgigena.dev>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>
 <21be3761-9da9-48c6-aaa1-b56f8625167a@linaro.org>
 <ab79818e-4b4c-4b58-bd2f-57d9ae4cddc3@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <ab79818e-4b4c-4b58-bd2f-57d9ae4cddc3@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

On 11/11/26 01:46, Andrew Gigena wrote:
> Hi Vladimir,
> 
>> That's an intermix of names, and you will get a review comment from
>> Krzysztof about it, I stand aside.
>>
>> Here too.
> 
> Krzysztof did comment. I kept the vfe0/csid0/vfe1/csid1 order from
> sc8280xp-camss.yaml in reg-names and interrupt-names, and asked him if
> he prefers another grouping.

Exactly.

>> Drop 'gcc_axi_sf'.
> 
> Downstream sm8150-camera.dtsi feeds GCC_CAMERA_SF_AXI_CLK to CPAS and
> x1e80100-camss.yaml has gcc_axi_sf, so it is used. Can you explain why it
> should go?

There is no CPAS in the upstream CAMSS stack, and it makes it irrelevant,
that's why I asked to remove it.

I believe one day CPAS will be modelled as a separate device tree node and
device driver, then it gets its SF AXI clock.

>> Drop 'cam_' prefix and 'cam_sf_0_mnoc' also.
> 
> Prefix dropped. I kept sf_0_mnoc because SM8150 has a CAMNOC SF path.
> Should I remove it too?
> 

Yes, please remove the interconnect, it adds nothing for upstream, and
I believe your tests will show that the image streaming is not broken,
if there is no 'cam_sf_0_mnoc'.

>> Or C-PHY, right?..
>> In fact you shall drop bus-type from here, because the link between
>> CAMSS and PHY's output is not a CSI-2 bus, it makes it inapplicable.
> 
> Agreed, bus-type is gone from the CAMSS ports. It only exists on the PHY
> sensor input now.
> 

Thank you so much for working on SM8150 CAMSS support, will be glad to
review the next version of the changes.

-- 
Best wishes,
Vladimir
