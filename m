Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676922253B0
	for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915111; cv=none; b=O04exbLIk3K3k0HV2wjFT6QMyNrKPa91XnHzqVVG6SFmGsaYNgJ6xkmnePZSaX8dYUC/Zg6hwug45tdN408jvRFGG7FOLBGUvDaTpy7wPHpcuf1veoZgh7Yzy3l0hslLxEvlDYnjHGckSaaiT99DAkxjamIT46ZdufBiJ0nF9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915111; c=relaxed/simple;
	bh=wVx0ewCEj0eGt3gTjSXza66ZpDVawBTHYhsNkFd5hfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP+BR7OIuVqguNonqSpO5/KpHderfkKtiOOKbd0yoEFm5LapoiR7L4q3snJzEp1Xw7M9WDk2WdGBjZoAeqsfXgxfOZEQ4rqPqw3L0L8hEFcIoUsW1+hLzmhU4zm3QDIgNhYgYs7aoVnzRcxhu4s3HrflSH3fyn4k1MdRpx2PDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nOC3m1f2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyFqQsUN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nOC3m1f2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyFqQsUN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KD1NFR385656
	for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 13:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SldAAXYyWL4PsEQXU1+h4WL4rjsnsAilMTgilthX8fs=; b=nOC3m1f2KxH4Vegn
	Dk77+Uz+uHp2Qudke3ybOyykc8ZkbvqSBeucu+o+3/jH2vGY2AIMqJ+hJynClh5B
	YKDSfInbSDjV/2UsiAjBD4G67/WKCY7tAcIJCV+i5b5BImZqWL2AYNd/YOw9ACQX
	BGEEhaL1L6yuDIFsjaE+BaitftTbk5wiNrUWziELmyp2VlK+NPUxUi0VV/DnNjuD
	3F56DJB0H06mEwZ3bb4m6a9VnbmdU6gVCULPf5EyEpq4+J4b2mBxwh+aK7JPw49+
	g1LzaaCt7MAn8M2slakSEB2lUVyELH1MW5gMHG113/kPR1MJM/sOskrDl8dnPFD1
	CNUnpg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta7q81ka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 13:18:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c533f07450so118460885a.0
        for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 05:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768915107; x=1769519907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SldAAXYyWL4PsEQXU1+h4WL4rjsnsAilMTgilthX8fs=;
        b=AyFqQsUN/ftR1Cv6tp1VkvsLI+ykske5pI77WGQFcWyGOfFWLITre9Tt4kSzpBk5OP
         AQZWwfrksiJFJAIXdoP/5lm0CcLEjNIqyTqGanF0GWB6aQRk6csyD5potkhvjwpO1nas
         d5MEJ/1pFsTnfcA4qTEkCkPMBXpfC9rieGVFhFZsJEVeTO0rizIZablDHn6s5SrSQ9B1
         aHjzIicgKoLANmyQZ53Lu1vu69OBiZ9NYj+pDzHCCeBsYu03wlNCZ1+SLwKwA8A9KEGy
         i6MB4PZ6rCoGYCxI8Y7Lr7j4gEgLqjRtQIA/r8/oRxTsO/z6UN/nQFWtv0LqpjPvvZFh
         R2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768915107; x=1769519907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SldAAXYyWL4PsEQXU1+h4WL4rjsnsAilMTgilthX8fs=;
        b=xMJVLdotO1Wor4p0Irh17YXkLMHIYTNz73pwDkCNtgvVJ0JtErRaYvuxXn/q7U6RDb
         ZLqvu2Ou4pHYCfclVg3KTxchv6L8cYK7uIFggZemnHjR9Qv7QaCwHIWu08oqxgXqxWTO
         rtmCvvP/FOnSEXlkcETpOaR+5W0IonccMHyMSHErXIotMgIrzApck3hXDJdQxgH+7oz4
         qNJDkzI46vRUmhFg5sHxnj6+BTcvOu1iIrAhcyzkW0mKzztsSaD+68l1MqHjr8hQhnKo
         nA0vuSc3rFNHOpctDG4Qh4+FiMDnIsrkh0xf7EWA7+jnAfUly4VW34cK1YIqHXIcXraQ
         gX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3qpO9SsrRboUc8j3gtz2rhbCBOXwlcTrlTEoQlw4EBwCTP4iRr5q6E2Hrm3CV/WNJHO/RiPyFjDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYVgd4op7tHCYOimasiHUek8uCWtx8iCQHfriVfQ6w/abqrXn0
	r/iV7KKe9cWv+294efP59ndXhh4taS4I3uB0ftUyQr3nT1l3sopVHTrfHMdW/xgkGhYKzyKwfcF
	vI9gfzAbf+BhpjTxREeMJTH88SwugPJqOjyFte+DsdnZ6RZvfKAmS0HQpc/h3N1s=
X-Gm-Gg: AY/fxX6K/SNMwRJj1jiv6lC3/vnSzCadeEhyrTAk1go4KLp5UGJOdz7fmXTZ0sTPKc2
	lvVZzQdpNu6ecU6HSCdy8RSG2rO6I60ou/e3voSYnUuvK1/3w+HKtMIBZL1hd4kAQAedfFrGI80
	zbxfzAqUX4lL71Fi7p3SIS/ABYJ8FcCztc3DWx+K7MclIuSvnxjZu5XtWLDqjx98gVNirbJjdcu
	HGRKaW18spSdJyvqrWHJ9Fh07qXf7VQsmnDzpy+a3e2KzrK2zrh+PXqmZvdI3NErrEXsR1EVUq+
	UVLH4+K0vUmirXkiofj0qzXz0rBKSGN6DQW+ETyBu8X9bO+k1DywfUVeErkrsU2PvJ2MldshpD+
	OLSQ22AUe4mPvb9P18xkwdlhyk56OdWWrwM3pBcozPnFn8yTk+n7bdzvtnmjKEaqvcA0=
X-Received: by 2002:a05:620a:298f:b0:8b2:e19c:67cd with SMTP id af79cd13be357-8c6a67b1298mr1491841985a.9.1768915107336;
        Tue, 20 Jan 2026 05:18:27 -0800 (PST)
X-Received: by 2002:a05:620a:298f:b0:8b2:e19c:67cd with SMTP id af79cd13be357-8c6a67b1298mr1491837585a.9.1768915106861;
        Tue, 20 Jan 2026 05:18:26 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9763sm1330649066b.35.2026.01.20.05.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 05:18:25 -0800 (PST)
Message-ID: <cb2430f2-8601-4c72-af6b-10f1ff16c188@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 14:18:22 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: i2c: qcom-cci: Document Milos compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-2-28e01128da9c@fairphone.com>
 <20260117-obedient-galago-from-eldorado-8e0ba4@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260117-obedient-galago-from-eldorado-8e0ba4@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4JPfRBs23SHNWqtGHhzuXe-c2QGuTOyD
X-Proofpoint-ORIG-GUID: 4JPfRBs23SHNWqtGHhzuXe-c2QGuTOyD
X-Authority-Analysis: v=2.4 cv=LPBrgZW9 c=1 sm=1 tr=0 ts=696f80a4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=ezRqCCqFh2AFBysmAOIA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDExMCBTYWx0ZWRfXxylNEqOTP2FL
 kLD3AXq9CrOPnyU8k5fWsEJ2LLIVhSWF6Gu2IZFyNGIcco1aCyZpv5SfDIhFSAPim7bpiO3tNK4
 diIXzS2NAFgBC4dFY8SQZK6R2WLiJgjzK+GdnA8/lfMCDsaOzIY9hiU4tHZD75LgECvqTscCAtB
 5ubZbgemARAYFHZRoLlTUaP3hCG5gFkukGk4egIbhjDGJPJhx4DWBssFD32jp9uNCJflqyjKaPM
 jlL5Y/HvTtPjeeIPPzCuaQ/RZ2u7V6kOtbg+A7GYR/FTCDv6MHQF56bdhPhG+hmwRNLyYhcDzR+
 0BmHzRCu6l+lzloyYj2jxoTop8Z2ZYILkH0GTVSk4aJPdqPhpGPlb6fguRO1KrgeBpnNO3qk8cl
 2Lm5fpg7dkr0cOXNYJ1+m74q98qexslTXqGmPCbaTI7IdHdD4XEF8hFDr/U9+aye1tY0fIYk9TG
 PdEr/A/ZqXHpAmDQWWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200110

On 1/17/26 12:54 PM, Krzysztof Kozlowski wrote:
> On Fri, Jan 16, 2026 at 02:38:56PM +0100, Luca Weiss wrote:
>> Add Milos compatible for the CAMSS CCI interfaces.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  .../devicetree/bindings/i2c/qcom,i2c-cci.yaml          | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> index a3fe1eea6aec..c57d81258fba 100644
>> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
>> @@ -27,6 +27,7 @@ properties:
>>        - items:
>>            - enum:
>>                - qcom,kaanapali-cci
>> +              - qcom,milos-cci
>>                - qcom,qcm2290-cci
>>                - qcom,sa8775p-cci
>>                - qcom,sc7280-cci
>> @@ -263,6 +264,23 @@ allOf:
>>              - const: cpas_ahb
>>              - const: cci
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,milos-cci
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 3
>> +          maxItems: 3
>> +        clock-names:
>> +          items:
>> +            - const: soc_ahb
>> +            - const: cpas_ahb
>> +            - const: cci
> 
> Same comments as other discussion these days - I guess that soc_ahb
> serves the same purpose as camnoc_axi, so this is just last entri in the
> if:then: blocks.
> 
> I really find this binding terrible - around six names for AHB - so I do
> not want another combination...

I dug up the CCI doc, it talks about the CCI having a CC_CCI_CLK clock ("cci"
here) and a CC_PBUS_CLK (AHB interface to the rest of the SoC).

The CAMSS TOP doc (for Milos specifically, but I would assume there's a
pattern) says that for access to CCI_0, I need to enable CAM_CC_CPAS_AHB_CLK
and CAM_CC_CCI_0_CLK. CPAS is a wrapper inside CAMSS that contains most of
the programmable IPs on there (notably not the CSIPHYs, at least not on this
platform)

It further mentions that GCC_SOC_AHB_CLK is required for *any* register
access within CAMSS. Perhaps it sits right in front of the xNoC-to-CAMNoC
interface.

This only enforces my imagination of CAMSS being a fully contained "bus"
(perhaps somewhat like AxNOC on 8996 represented with a simple-pm-bus)..

+Dmitry, myself and a number of our colleagues were deliberating how to
best represent the hardware going forward and I think we at some point waved
the idea of putting every camera subdevice under a "camss: bus@ {}"-type node,
which would hold the reference to the TITAN_TOP_GDSC. This seems fitting for
housing the SOC_AHB clock as well and therefore concluding this discussion.

Konrad
