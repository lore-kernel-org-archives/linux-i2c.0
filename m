Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742C2F90E0
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518128; cv=none; b=R7+C8nmVsEtXcTocVXQIe8xxmJM5PYQRZG3CeLj+YCNmJkTLcP3qrML4X6OCbpxUOD1bxAPpTNayXCjd978QnLDyiRI3duAU8zp9o1PwbkehML5RzthLe8yFZH4ZCi+Xy17XsJ6JLU02kGt10JG9RMETFYiHnWpokS/tqAqxhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518128; c=relaxed/simple;
	bh=Fn3Kq18k1/hMDDN7yL5CXZ/ziFrXLMx6EbDgh56AroI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jG6oBCX5da7GJIMd/b/K0dasjOXD3MpWb412m12LH+SQsQpNG+7AJ/fZsQIRyCF/6q9RGqoZORaAo9URthxN8KfUQ00Jy/HiFdoQpHXBovdOPonjsVXyX1DuWT05yMiFrJqNSHe9IFfcMCHOG2ioLbN/j8T8qSMQSV/WpFybRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mqEpa8np; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E3Weo1B/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqEpa8np";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E3Weo1B/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3Sni2579673
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 13:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bAn5oRAOD1QHpE4ls+17l31BEDS3aVXn/PHrM1rmmKA=; b=mqEpa8npHQGKRky4
	U80gPlXm4mghET5zArMq+7DG1VPZLTGiUEl4bjrkCDaiZHZq5crl0ewMo8yj+N33
	LBVfjba4sEO35K8TYrTMIGRmpyYBBKQRt6bWZXXfJMZaEkAPnAmH0ozlthXT9zNe
	DVp8Oi1r8+gwgf6APV5WonRJCBhZ6B9eq5l5MFIbyOtQ3ZTrmqFPjUz/6DvcgfCT
	UL02NTdgZMRKFVn6YwmoAPkPgSi6G1lppx43zdJO/9sxC2SVMHsFSRTVjAVeNa/l
	klcxCn2GGIdZsHcNj/xxvlIvtgRz0/b7siQyu6u2k1jEy7sm5zVWOuJzXRpXQos2
	USBa8A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5gayum-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 13:42:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso7298831cf.3
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783518125; x=1784122925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAn5oRAOD1QHpE4ls+17l31BEDS3aVXn/PHrM1rmmKA=;
        b=E3Weo1B/Qo344/g93G7NdzlmBuTr+ISe8eeIbkrTKPdRDkmVbsIhgYjMOUHG6x8oPo
         iG1ZsnsQc+SQFkTXkzGflx6yFNEoxJwkbrGrW3Uqsr+yaGcCgtlk8c20+HmZlHtojbn6
         vNNmvpN4tP2tsshWavJTtpeSS9f+nVrFyqeodA8T3cnaD/i2vUE2JZZFBurrf1qBCqrp
         6dVPmKN23YE598Ii0GZ6GTW7tkbPtTg0HqoSUjXTkFDp5QLjel42QuEBDm8utvlfqY0r
         cNqRvzlwpZBrPZMnTJurSezWpSClTOZZSLU3O11/96toN5pKTyYmPxuEcY/k/mqbPP9k
         /q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518125; x=1784122925;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bAn5oRAOD1QHpE4ls+17l31BEDS3aVXn/PHrM1rmmKA=;
        b=kujF64A+alijVFDbdEqVM3JHD0fChqRY6dHIrvfzGLhWoYpv8dLyFLmn5g42HdhlVX
         Uy8FrguZSSea9kF86I4hmKSzLu6RKFc5uELJYH6aAZdmrYdobcIxAkVwAzpH0IfzfgvN
         ijmtMkUBM9gX1cRmfiVpkXMz1AIHVkN721cskHzT17J2ubx5bASoCHu3VkBjSkaX13ke
         qJ91kLyGlBq93A838DvIzwm/iRynqusol7NBRCuw9s1tTSXjjHaH1XqykhYFHPxdQWTE
         CtOAzUYnQK4Y8MtRaSHvtn6UpkLhv/0c5k2M7mgMKFXhNA2gaDpQTtMlRyn+do7odFx5
         MkTg==
X-Forwarded-Encrypted: i=1; AHgh+RpX2JHaS5iqAzbaJsbrDUcuPYgKj7g+dW07r1t3XVMaoXMSNpyxUC9QL7IzxkjnmZnYKsxj8zkomj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKaRhEXz904Ywu1EOFmBnlZsxyVBIGqlS6BiRynl5qGgWmsuY
	CPqleExaGKxDMFe8Y21TNjykuZLw+rud7kquTeu2e5WWr3UG1vp1DGewZ9DWUuUehbpAVjyrr8A
	a5/g2hBRPbht3UAme3rBp8D9KfCiJMbbK6lSPF5xGt+yqrb3WFHFJmoEEWdsk9vs=
X-Gm-Gg: AfdE7cmMR2waeYoxn5Dz/gPf/y9WeAgogwwTkldqSIhYs2FoH0HF+GE5mN/LViYGcXw
	r9F1gyIVujfmlLdRhxBwIZusijBb5sUZbnGO5y18GfDrM7fCqMrbjVOkeQ7cvIEKZ47xBL4rEDn
	n6xkkgl69ehMETquTx4FcfJcnaYzgKZNSLDy7Td9yXnpiO/S4tKcQ94SWuXTzZLl2AiQ7XldOMY
	LM22nriN9E9sMRJB6NLhFFZNVIl8CE1+9a+e90vhKwhq3XKp11Y/Bl0pl07x6Qzjhk/EF5/QTg3
	fVA7sYK8HNyO5oXy47LMAjGaWpjfHw9tFN5Dabk6SPDdmKj1KwGEEcaJbmDG+VB+FSF02RNx1VN
	N2eXCbMhwFB16avsUMOsqDBbvhtWoWr0M1hbf7GpUKOWMsNVaiIz9Kz4p1u49ZwC8rgzipQ2LAg
	==
X-Received: by 2002:ac8:6f10:0:b0:51a:8c99:1f0d with SMTP id d75a77b69052e-51c8b41eb83mr26573621cf.60.1783518125453;
        Wed, 08 Jul 2026 06:42:05 -0700 (PDT)
X-Received: by 2002:ac8:6f10:0:b0:51a:8c99:1f0d with SMTP id d75a77b69052e-51c8b41eb83mr26571551cf.60.1783518123041;
        Wed, 08 Jul 2026 06:42:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2110:e352:d7b8:8bf2? ([2a05:6e02:1041:c10:2110:e352:d7b8:8bf2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a58853sm48871385e9.1.2026.07.08.06.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:42:02 -0700 (PDT)
Message-ID: <713c728a-f68f-41fa-a64b-09ccecef9157@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] Add VIM4 MCU/FAN support
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzNCBTYWx0ZWRfXxDUAwlsKx9vL
 e+Z2g42jQhxkCU95tNZ/Xbi+73IzqzPV9UDnOPAdDP23QQSFP79vXHmpagyjZGeMvKfu+cqlbyJ
 O90ATOeV0Mbzh5d6HQzSZEO4FE00wYk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzNCBTYWx0ZWRfX6Zw4YTF0uX62
 qt/RCPaQDMpgQiM2FbAtes81W0MMXaOa7ZtMMdZuA9wwasOkF6IObjEiOT8MukK0XvwfoyB8l8k
 cubZkvqcrZBUTOEJWL3GUxCak45plqAwZvoVSqpz4LaUeF3m4Kn9nSBdusVy6XRbOlDwkr8iHWp
 wRKBaGEzcAsxjsx90wBX0bUyS8DTnB+XmXMr0wsffdo/puL1N7d4oDwEqY4V4FWy5LVnKaZzH2y
 PxsGMAh+OTJ4EvBvHD74vG1J6O0OrvpeX8uSRDqxPEVgS5FMIbkVAQQJQoZXTG2eNQWTFQQGhU3
 6tMyPI8geSqOzpoHwIyhY5Y6m6FuCSlrsIW83w2/U1+DCUNGmncYO6nrrbhPV9w1aIv6zA1Rzdb
 wIfbB45yH65bthN6fyOJ69BjgEZKyEYHHYdV0Z4QlKgY+y77K739XPKMwof0p+jRRwe4mBQBwds
 DhG82UMiVEHGRn5XVxg==
X-Proofpoint-ORIG-GUID: Rxr8psvlnyWzJ0VeH8mHxo2vo4W91u8b
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4e53ae cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=J7wINilrcEgEcG5NXz0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Rxr8psvlnyWzJ0VeH8mHxo2vo4W91u8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080134

On 7/2/26 11:55, Ronald Claveau via B4 Relay wrote:
> The Khadas VIM4 board features a different MCU variant compared to
> previous VIM boards.
> While it shares the same I2C-based communication model,
> it differs in some ways:
> 
>    - A distinct register map with its own volatile/writeable register set
>    - A fan control with 0–100 levels instead of the 0–3 levels previously

That means for a eg. 100 ms polling, the first one takes 10s to reach 
the max speed, while the second takes 300ms, right ?

>    - A fan power supply gated through a regulator
> 
> This series adds support for this new variant by:
> 
>    1. Refactoring the khadas-mcu MFD driver to use per-variant data
>       structures (regmap config, cells, fan platform data),
>       and adding the khadas,vim4-mcu compatible string.
> 
>    2. Extending the fan thermal driver to retrieve the fan register
>       and maximum level from platform_data,
>       and to optionally manage a power regulator for the fan supply.

Through which tree do you expect patch 5/8 to go ?



