Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2D231A41
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785126980; cv=none; b=mL4Q48CRSqdXXi7by7KM2Ip2oiJ8bkZqfSW/p6VG9Y6S1sxuTI4AxV/vmNEUmhktQwi+HFynYCmdgSxCmrRFPm3TAcPjChAHVQMrQ+SxyLgC0zbZhtXMzg58l4RBDXsaQ4i3B3QZW8yqsz3NGB/0B6wqlsF7+MZA3kasKyqC3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785126980; c=relaxed/simple;
	bh=OpkEkk3jbVeV5MrTx6FPVxE8QuZYIguCkCIzBD2ATT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkDEbL9YvgQ22pvFReBnfwLf+0VkONThs9YGj92KBn6gEbu9a2HvGRXub+812aqFJiV1QJVIxGFs9VpCN/mTRRfbyDaHcf2e8kZiMtzTEI8LLIabGu+5Of0IyfJRA93iWmgnX0ObbrXlt7dRxMXYjl5uKTWxf1+0RrSFiq8Us0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GkegrthB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EcH/S+AH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GkegrthB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EcH/S+AH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R1frVf2240179
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 04:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qr4qG+4xCNN2gbsB6WsO04DOPM2VsmsoKamq6H18COg=; b=GkegrthBEXnqZPv9
	+d93sblE2AmJmXmb+V/Fy1DUtSOQbS04+qzWjpDEHCnPJbQMlbZJrB95nXOTVfeC
	xANstxzsuyODkxywA/5+P/bNgm+BX02l9sDL6/DOAJNUqvDCtfEPcQK90CF2t9gH
	Zevf78qdzNzXdbt/ibxlyJQqEBUsiclemjE0gfMus5tNzcAaa0lIP49O7+kLpVQP
	80hGJC7cPHVEZClbCVR1N58X56Gdg0VLsl+yCSd4so/HrWI4Iq6Eir/2LHiI5C7o
	lnZqkUi7xpk5NamPEA6vtavRgQLrpy1cT6I+0SaLezuVsOKJlm6qpeOLhVQvWkVj
	fe/JOw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fnsxs0sj8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 04:36:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cccfa32670so30270905ad.2
        for <linux-i2c@vger.kernel.org>; Sun, 26 Jul 2026 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785126976; x=1785731776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qr4qG+4xCNN2gbsB6WsO04DOPM2VsmsoKamq6H18COg=;
        b=EcH/S+AHkHlTYMDZZzZ8P6b34kQYbwAxdtmsek07qkr2/YwPs0R3oWZL7LHzznej3W
         n2j8PYMhdu5FUK+yOo03C/2gJ6lyHeY7LKe3ECo3NNj+zRvf8EimhY0rUy/ALSy+efGI
         zmPknKIUvBIl8Qa4Jntjh8i8gmxeCqOMqQytMOsA7TkyMQrSt+tWPvlssD79Melb1xMH
         uuT37Fh7RcGEnoICvi33aPAbT88RvoqNUn/nKV15hnfQ4njMcATDIeCo+lbqkZQXcwGH
         aqOHzsMhj3imShbFm8L2JY8j8mf3qaINy9sIj2xMDsBXHPdrpfOBc7Qu8BFwxij/lgz8
         n/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785126976; x=1785731776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qr4qG+4xCNN2gbsB6WsO04DOPM2VsmsoKamq6H18COg=;
        b=nBRa5+sWnRAfJoDURhF7ueuXIuC4HVL1nf26Z/mwoWDzekufOVJsA8b1TKSyYCR4R9
         41U7T5rotVyirzqUEd6Lw2w/FGirCnoxKqY0Xe1TLVlxZ4BC17hNc4L4j4wjPkeaiu6W
         Zy96QL0qjKYLrqncKtvUZTCtd+VVXTSizig8zbraAW63pHyWnwQwDytV9O4utHMqv0UU
         LYj/rxtU79uMbQ0t29L7kO7QGvf1xGaK8R6HrFAl26FkcwE36pBix5lDjyaiLXKEmWHJ
         /FN5HkInTJw9TjA0/KbKJ6haiRZLTg1ZOMHt1U0dWoMCI8v6uLy+grnXtZok8ODRV4+G
         pMdg==
X-Forwarded-Encrypted: i=1; AHgh+RpCL8aGQuoQaMgfPsBB2KoCrQOt4LyLnXQPcTORqs8OFuLmzdJbjLuRtcgVmCT1GiHCDmADZla1nhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wssJaIqxnW8/DK7YetZL08fW5+Np/6ZwFBTen5N/D22+DV8k
	HWPbpqtduknVvG1qDIp8L/xX24c6pOnj+A6deCl3gxktOByxdKeOa+xv36hu21/uXTwt3zmED+n
	tBUARuIoHro2gtPp+EbBAkGqHx+59SkmsArvvxU6Rmo2jiqy2MbO1qCIGeTK9wzU=
X-Gm-Gg: AR+sD13Z0BbDW+s5E1qdlOtsifSEQs5/OTYWLNUQG1P3CuCqK2/6fJR6SY8lt7t0NIW
	uKlZ/TwWgq5j/K0d0fj1Sjg/jW26FQi5JcWdOk0fvuiznPqpHk0e23N2mahC57Qkk2IC1nxFapS
	8/48C/vDK2u1UOIraAwGhIBGEWKbjbkFsR4bE7xfj94jxjDVbCbmC+PeWZ9lBO23j+GFCpGhPAO
	8yaXgBYw3snpgJwJMlHaQEYhH+290O9s5Q3T7aFjYWo6tnSLsw9bafvmpwp8C6gZfIV6ZV/E43F
	ACu+UA5RacUC63ZdKpd391jy0Iqf4NryYg8XtENUe1+pDPYGg2rEKxJoZN7No4E8ifQdMwcj7NF
	j1LdLLPTvFFUp8IDZAqI0OQ5oynTsMUmEeA==
X-Received: by 2002:a17:902:e809:b0:2c9:9dc9:e423 with SMTP id d9443c01a7336-2cfde84e377mr72868725ad.25.1785126976457;
        Sun, 26 Jul 2026 21:36:16 -0700 (PDT)
X-Received: by 2002:a17:902:e809:b0:2c9:9dc9:e423 with SMTP id d9443c01a7336-2cfde84e377mr72868295ad.25.1785126975991;
        Sun, 26 Jul 2026 21:36:15 -0700 (PDT)
Received: from [10.217.219.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549cacsm27102186eec.16.2026.07.26.21.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 21:36:14 -0700 (PDT)
Message-ID: <0581856f-bcc6-4a2f-b13a-db9fe356c3c4@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 10:06:09 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: i2c: Add Qualcomm I2C slave
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com>
 <20260628-i2c-qcom-slave-v1-1-8b0a5c01f9f6@oss.qualcomm.com>
 <2a21f549-294e-43b4-aed6-b779d84cfd4b@kernel.org>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <2a21f549-294e-43b4-aed6-b779d84cfd4b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA0MSBTYWx0ZWRfX755V/K2x45p8
 JZXWy3nDxPJSnmV7v6iz8r5DhkL4OGVtO7hA/BRHCAohlHdUHAfiiRD/ZbADZhMCYlBAjcD7FXi
 Y4R51hFofSSoK3GiehxpParTHmjjEzlsqLfbjA8Z+joVGIB43c2IC/sv2x4Ni6NAUdT1sv6oe/d
 GoLVo4cSDjgKZzzgwETafgaIHYsd+9XojBYMG5gsW/Abayp27qcO5Ydzmpa9U4BpukEXHjeMsc+
 F0uBO4jsp5SrgwG1k4rrnZxi17s+SgaKSw1ghek1IozDq161lLx5vgwHAFB5g5v9HY3PxXnppdL
 JA3fa7wKiy4aFGMTajBZax+zQ4jUaDOleWjvHhhe17mroKy+15aHkneqDKs9STHZ2zK7wm9UH1s
 vVSOO76x+1+PY/mYsnEEd6OObSdKqqIOcNpkA1p9iRRVi4Bl3+i7tDJzkha1+HRanNT+WG0RLHk
 Jy544j5GUWn+id5p0RA==
X-Authority-Analysis: v=2.4 cv=EYr4hvmC c=1 sm=1 tr=0 ts=6a66e041 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=BpNlaLRTw972n_5ZLSgA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: ktJz8tld2LmhC6P1vwCF7oWsQQH62hBH
X-Proofpoint-GUID: ktJz8tld2LmhC6P1vwCF7oWsQQH62hBH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA0MSBTYWx0ZWRfX2Zs4fEIAjeWD
 Cqwaly76tBkmK2bGZ2T+74hydY51ayw5vg0vOT0C3tsNsPySCFl14gAUTMo5QBDQNo8GBX1GAi8
 Pa14ugdWeBxrnlJnKeLsiplBjOGdzbY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270041



On 6/29/2026 12:02 PM, Krzysztof Kozlowski wrote:
> On 28/06/2026 16:39, Viken Dadhaniya wrote:
>> +description:
>> +  The Qualcomm I2C slave controller is a dedicated hardware IP found on
>> +  Qualcomm SoCs that operates exclusively as an I2C slave device on the bus.
>> +  It supports FIFO (PIO) mode for data transfer and does not function as an
>> +  I2C master.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,i2c-slave
> 
> Such compatible makes little sense in upstream. Please look at other
> bindings how to properly create a compatible. This has to be device
> specific.
> 

Sure, will update with an SoC-specific compatible string
(e.g., qcom,qdu1000-i2c-target) in the next revision.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: XO clock for I2C slave
>> +      - description: AHB clock for I2C slave
>> +
>> +  clock-names:
>> +    items:
>> +      - const: sm_bus_xo_clk
>> +      - const: sm_bus_ahb_clk
> 
> Look at other bindings.
> 

Sure, updated the clock names to xo and ahb in the next revision.

>> +
>> +  qcom,slave-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      The 7-bit I2C slave address programmed into the controller's device
>> +      address register. This controller operates exclusively as an I2C slave
>> +      and has no child nodes, so the standard 'reg' property cannot be used
>> +      to convey the I2C address (it is already used for the MMIO register
>> +      range). The address is configurable at runtime via a hardware register.
>> +    minimum: 0x08
>> +    maximum: 0x77
>> +
>> +  interconnects:
>> +    maxItems: 1
>> +
>> +  interconnect-names:
>> +    const: i2c-slave-config
> 
> i2c
> 

Sure, will update to i2c in the next revision.

>> +
>> +  pinctrl-0: true
>> +  pinctrl-1: true
>> +
>> +  pinctrl-names:
>> +    minItems: 1
>> +    items:
>> +      - const: default
>> +      - const: sleep
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +  - qcom,slave-addr
>> +  - interconnects
>> +  - interconnect-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
>> +    #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
>> +
>> +    i2c-slave@88ca000 {
> 
> You need to fix your terminology everywhere...
> 

Will update in the next revision.

> 
> Best regards,
> Krzysztof

