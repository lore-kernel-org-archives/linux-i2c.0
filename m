Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744973;
	b=hetDgnNwQM9mO3E226FYjXUHm1Lp6wl85tc7DEsrkmKYqR3nax6DMVn7sk1EiDjqCSMh
	 Fc19sCgCbVF8fbe1TJyF/W+tw0/NAn6TYH21cCw4KfXWJji+/KGrZaEFFK2vFD68QIz5l
	 aFu2b7ODlOifOaPchSXEehuE5s3sS7oS6H6fNihBxYDMkaOXWlt8vPyGi/uPLS7vld9C6
	 irlH1WlZUVpHHD80rFwMezmbViw2Zw47nMy0YlUToL+1D9Uk3R8jmt9bH+wjM8OOFh+HC
	 tHolo+pRHtr8VDiIR5IUBQ3LEiCmHMN6rkRKwLOB3cKNIY/X6+2AkxULKwK9u/4GqCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Cze6EXMazudJouVIRWBezoVb+gMXv48f+e410Dy7G9s=;
	b=AH6aoKtqi4PSxORFH29RFjXebCRWemXKFC9AxXHhnZeZCTsSOenQQ1ENeG4u7ggPntU9
	 9Y6kosGD9l7wheVZuNZWVOUELCCeT2gSSulcFOiJr0Fb0J3UeJl1hKEtT+zODthCgysT4
	 gEulH8mrToBx+GVR3qXCcsXjaFgOzAdhDD9Jx3rf0LKfqtEowHmNPK6EDlh+Ry2vd2TLi
	 gK7MamsRwJU+9KCKCwzjkkGY7XWhjG+8DsXezi9+9jFH1IpqlhUbVeM/Xv2oxANhOHgTG
	 +7z+7Px7DYni5Ooh0bOqXzW2jajlx/Hk50XFdIGhlJ3ZKJnCCXuHJOiCtVvtqG9VJaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UMWGuZNB;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20142606A31F
	for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 12:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20142606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UMWGuZNB
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e46e449e8so2004568f8f.3
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 04:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794744971; x=1795349771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cze6EXMazudJouVIRWBezoVb+gMXv48f+e410Dy7G9s=;
        b=UMWGuZNBsMnss2pwsw8rRFNOryhk6F4P5MsSQtbTOUSYf7p8ABU3vk4PaN1KFgXJ4m
         sLw57i7wKveAJsqJXa81ii4bayts99u5hg3J+aNyMOI795yl24cB+IpfYz5/HXSDqzz5
         8J81IXNBLkrq8pNuLrlDSWMlsmGEW+JxD6BDFcXHLBQjB+J9eOnH/escoFzz40YDBxpa
         l4K4aqxKU+xhxj/c2gSNDaf+IV7G2FNCNjefQ2qzQHvzhnP9uPM67bTReYKQRNnzW10P
         /U8EwovAUK3sCoJtrorcb/qNryT5hTEQM7Pctt8EMwGpw2KT7wD4z3gD8bIyUjh/OWZF
         nvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794744971; x=1795349771;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cze6EXMazudJouVIRWBezoVb+gMXv48f+e410Dy7G9s=;
        b=Ff6VVfmLRuNVpc16HP+fGrp+UN1pEMcbGPEhXmreBnF74HPtzwD5g1KX/+Hg1sLBXq
         8c3rLYMNeBLPYEVC4Vf9clgivOSyqy58Grj3Zi1XuNUD5G1Og3gnPdYhlq7QBQ3TXsUK
         9Jz3aGaOwfxsmoQCeBk2b/NKQ64eeys5VDajNDYK8UZ3x8cUWQOS9gbDIqDyIA9qJyS8
         YKbcmWbJLeWobr+slJJ1stmWYRIaOEui9qNoiNWOiQGyDPcpgb7Wq4xHo85X288eVtPW
         Da0gF6dIuQpeSy6sc3pGjkacR6OTag7uruL8e4jZS2fwtZ0zolGd3qVEVBujJhoQLMwt
         BOhg==
X-Forwarded-Encrypted: i=1; AL+hErHD/27C1Bkxdr7l0fCO+JN1AQ/B40tEG3Lwn67PQyfd+Ra82+cCgQ866SR/MKPP3t8UNTwcsdFEZFE=@vger.kernel.org
X-Gm-Message-State: APuU4Z904G3irKVCwQMvw4E2deNnc9nWoFcZBkY3XTAiUUZ7ZvZ2UsIk
	zAvz7o0P8kK8D/VOK1qin8FPncCDfSm77szUWHdSltmx61yo7APB9mhJTZR6SGg0WEc=
X-Gm-Gg: AYBFou0Nc1Z5R4VbTLPh0Vg1q4yU1Vt2AEpWTwyZ+BT0SS+MZgjVwYSrUSSvuJa/KfJ
	MSKl+TzgfV5FgiOlfo/YdPdgOTjPyGBFYbnF1MADbAdr/gcwk8U4dLdGaMCZk+7ibLWvf5lqbQ5
	pHoGzVzS/VVh1s336v7gWPUZwiSLZf+YKj50vGRw8AURRb2ZiN6nLv3ljVRhPKxEi3S/n9RjxxJ
	8f0eJeCNUHLUMF38JIks0+XJWpcVQXkTEqyKNJcGM7UdFEwfbFGzCXTtiIk/lnVAucLslH2DdsN
	S08M/dScWKtyaPJv/4C0lYfDNxpIxn19lh0E3o58DcXVXUJNvwg4zQ3gmm0OU8Q2/bJgMloRT+D
	T+jjc1x5fe8wSKS2CjjJHuRgmHPqGbvXLcyM6bOin3c9vluEc5IlEJAOIkJ8pd0QjqeGku/KZHY
	mn4k8WlOvpiEguQwO5nxTV0oaxJqgKaAhaUVc2mEFtejrsEe6vt6EuIebrsV2jTW/+nBTKtpWu5
	/0ih5di/YSQ7KHn80eaII0tzdNRU3mZQ3iMuj/uWmu9DsgtIt50Rgiwa+WsGALDhkWSTHSimAlj
	Ays78EjoGB6cgX+PMVUSQuc/08r1ZnSugFN4sy1ANV8=
X-Received: by 2002:a05:600c:8b0a:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4bb55a95dbamr161321305e9.31.1794744970969;
        Sun, 15 Nov 2026 04:16:10 -0800 (PST)
Received: from [192.168.0.167] ([78.152.238.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb65ce005bsm126726035e9.14.2026.11.15.04.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 04:16:10 -0800 (PST)
Message-ID: <ea2dea8f-e696-4e86-be9f-248cb6ec86b9@linaro.org>
Date: Sun, 15 Nov 2026 12:16:06 +0000
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
Subject: Re: [PATCH v7 10/23] media: qcom: camss: csid: Add support for CSID
 980
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Atiya Kailany <atiya.kailany@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-10-8ff2a11835f6@oss.qualcomm.com>
 <130fecb6-5372-44d9-8261-c3ac88248631@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <130fecb6-5372-44d9-8261-c3ac88248631@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/11/2026 12:14, Bryan O'Donoghue wrote:
> On 14/11/2026 11:29, Wenmeng Liu wrote:
>> +            for (k = 0; k < CAMSS_INIT_BUF_COUNT; k++) {
>> +                __csid_addr_update(csid, i);
>> +                __csid_reg_update(csid, i);
>> +            }
> 
> Why does this run twice for the same index ?
> 
> ---
> bod

"run CAMSS_INIT_BUF_COUNT" for the same index ?

You don't increment a buffer index. How can this be logical ?

---
bod
