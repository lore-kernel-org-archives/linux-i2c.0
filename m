Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D19258EDB
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332137; cv=none; b=ZU5P5MwaG748bneIlx4gfOo/j9s0s96IDTIAcLoiRmf+kvQzymyKm6mxkn+A1vKntkJNqgqkVuMHYmYOm2jxF/8NwnUwqvtx3tfOtOauRpICT7S+1ZH4kUFw5pbqlJt7stcIsjFDQfJwjlAhGxN6WUmJUBOAGD3rVWFuy7wBp0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332137; c=relaxed/simple;
	bh=Uzt7RvHwwqFSV3phhIIGejkiKsOxEO0Vb+GmvZWLI+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN/f5dGgK3qyODUCvWZ3T/OdbxhYSv6UukZ8vbB95cWv47yqYQzZrNTrtUkfwQSpFe681J9NYkckSIS5xnYgmy7ZACVdN/I8DxsV2IkXx1DZ8/8B/EgPvjKheaGRwvZLf6bOPMeqCWmiOp/1fVkEE796hmvjZaC05YO1Y5vanP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DoKPKbsG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UUX44s7B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DoKPKbsG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUX44s7B"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H54MjI2111529
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o6e4jsLCb9oNoLVirKnKjbtTHj3HOKLPKd3Pmm55v7Q=; b=DoKPKbsGJ4I0F6RT
	FF+O0s9IFeEQwFJlKdIz+VDLe7bQaUrSiLGCzf5C3MAfpw329GTdc3nRXpglqtj5
	Kj2BGFD8HBX3FpJvgWVkZlVwdIGm5O1i6Eda7tdDOiUXmFCFk/NzLm99bJkdor10
	hnUh8aujkznWS16KDKLat+rNmmCUVCjpKP+F+G1OQnUpbUHt7czKGYmQ5fNW7Sc1
	2SPjTurQQiZGKfyDRmiDlSBmdPKh9WKs5+c90bUDVInYsTV0ZgX4U9OTYdX4O/5G
	tyvryUJJcmFJkURu3duM1hJ+yIwUds2H1vlODtU5h6v/PJs7Ms0roq0khFFVehTA
	fY/Ibg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cchv4h2u2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:42:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb45a6b860so228390785a.0
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 04:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771332134; x=1771936934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6e4jsLCb9oNoLVirKnKjbtTHj3HOKLPKd3Pmm55v7Q=;
        b=UUX44s7BSLVb91pR/gukmEFCq1aBGk4BsOnZIr2Gpb4elt0ObRI/Zevys31WXVzToO
         jJe7ZSWp43kbzFtYNDzRlO+0QtIpjomhgkEN9xb0z/VGQOZo6ZOkorgQMNIwc7wHNjjW
         ll+gxbRiY8mPXNRaGyXFN9WnwLNTKvaY2WQ2JGUg+xzU4gGoQyTrY4RNEDocxp1gh3Xa
         MfSvVcW+K/21cuj2heIdiHbOQezOeKhwgOIiYLwzuoDR0W5nAUw+RSIujon0lDdIYC25
         jNk7IrZSqP1aayKvufwTTs8FAFaN+gr2dlUQalv5ge0xJfaE3iBAbrQJKkAMoyrOV2Cu
         epKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771332134; x=1771936934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o6e4jsLCb9oNoLVirKnKjbtTHj3HOKLPKd3Pmm55v7Q=;
        b=IWO1bNpjKudZvcIzfzkxxLJAGTkMTtB3Aya1O90gclW/lutXN8p0fW3j0Kd3/59T6J
         uKgH0iqQAUm8TG08boEww5AXPLHvqt2oOg42Z7Wud9D1/+ctQyNkOs3XsTzsu0ypeHC4
         M4V3skCKfdl8zKn8kmjHa0jJ2qmHpf+s9mGSiJnaTAh0z5LOT0T2MGFpV1NsnYOXeQiy
         MxWFa657espgan3fbeJQKzjIBeujQ1j0nDRDiw/B6riUMYYYiQv+MgCZZDJZx9xnBeDp
         B9yA6YQaaScXSUXiI9gM2FsSCUOdrkZZ7FL9IkfH6vLdaXVqP03tZm/8QQ+Hzcx+DbHf
         0pKA==
X-Forwarded-Encrypted: i=1; AJvYcCWbv6bXJSuuvK6Cf9gzG4e08A8hJbc4t85xzVs9zcjPrsNME3F9KJOhvyMlc6pT50K1VrhD8ckDTRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIY6w+k6T5wHw3bWbVFA0XYHThWeCBTpG3N8MJ4rRUvUH4aFv6
	Odu6lz8dOidThg5qBEQN7MRNjo2Z1e9gJkYr3ltI1UgB65FcGpHQV4goILvfCnM+6KzqwAJVz8M
	BEEfWvL8xA6sk/E2pyzf2mqPNNr0PE6tQpQVJPyy4aEf8JJZw2o2pcb3QKFF6AE8=
X-Gm-Gg: AZuq6aLFCU44NOREqP9rhik1eT2Vf/zZFcekGsXsZKsoABmlsH20XiOAl1K0l3OW+NR
	7N5HFRH/Bbm4FpxfclOOJJeG/aUvlfJVA3HyNsSL2gE3NAWZ/HkBd//YVcNKFV7amDj3ijIZJUS
	5FezgJmmJJyfqJBNcnkyOfDcbgmIhI9gyLCqwVdRPLn6HkHSNb0yFAj6p+ETZDBrk5iqgysJ8Ef
	GVMN3uuCGbHyR7v+4Gn2y+F9Qm2cbfUJ+eB52Z2mWslFVDlFM97nX+BYTlSIq3HNRDG5M8kGkeh
	cvtE+x4ElO7r1O9POT0fXnZo8LGNrJsz93MxNP4MODtMWBhQWlh99kNo6CL4qbNrvHonWyuPvdz
	Uv+DTf0fzAaOvkxggD1vYCMLvjMcFPwa7bJqGelJNMuozbrPEOCBTEiAQ865cURPRs9NigP++GV
	okF8Y=
X-Received: by 2002:a05:620a:2948:b0:8c7:17af:7ae with SMTP id af79cd13be357-8cb408b846bmr1269567385a.7.1771332133955;
        Tue, 17 Feb 2026 04:42:13 -0800 (PST)
X-Received: by 2002:a05:620a:2948:b0:8c7:17af:7ae with SMTP id af79cd13be357-8cb408b846bmr1269564085a.7.1771332133311;
        Tue, 17 Feb 2026 04:42:13 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc76278b8sm350008466b.33.2026.02.17.04.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:42:12 -0800 (PST)
Message-ID: <7e3dfa3a-f526-42c6-94d8-d6390dee0acf@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:42:10 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: milos-fairphone-fp6: Add camera
 EEPROMs on CCI busses
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-4-28e01128da9c@fairphone.com>
 <ae73eac1-4e27-404d-af73-88eed699db0b@oss.qualcomm.com>
 <DFQ3MBO2EAYF.1PRF2111N0U1I@fairphone.com>
 <44f65bb6-616c-4dd9-a7a1-ee62d5d217cb@oss.qualcomm.com>
 <DGDVK13XN7OO.3I398MMB95Z8U@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DGDVK13XN7OO.3I398MMB95Z8U@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eYAwvrEH c=1 sm=1 tr=0 ts=69946226 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=n6VhdLltzCPXJ-gkZbsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNSBTYWx0ZWRfX2q0/SyJef+us
 Xri+rM6SLRLTFmHZOteKsD5q3dfOnOSUPErlCIEBiHkPieShTYRZFu/L9Zbn0y3b8H3h16kZGlj
 QuyiJZ0ajv/2nzEPWAKDwerQZ3WDCYqGkJJnGHi3nRY1FrXOsTSYT4T2UNFe85wXY+iv8MyrtZO
 Uo3VMxBRqBd97LCxDuKZsypbD0X+Cvj9yZ5JBXfSEWnZV7VsD8qIAA72s8YRVZHTgQIn3qbjqkn
 /soRmh6xyyebpFxpbh8an+P57TjWP/GfFd0kQssrUWZnPQjfuqkDwKFPvBrTjs0203QWq1PJ2ru
 /cg+BUItEvWWCcoZJg53Rhd9X7c9YWCBufdkZyOKvGMXADWl3CPE6SwejN6QM1+t4GcykdVk1XC
 yCNmvWVnW09UZFHoJ44IDvOasZCaW84PjxWCUbwE9N/Br+echee69xtpEdZp3VPj7TyfeFEiW69
 TWkbvy9OWDDk42LUYVw==
X-Proofpoint-GUID: XKtkV1jQv2cUolQhk2TYXROWh3VQJZL_
X-Proofpoint-ORIG-GUID: XKtkV1jQv2cUolQhk2TYXROWh3VQJZL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170105

On 2/13/26 2:39 PM, Luca Weiss wrote:
> On Mon Jan 19, 2026 at 11:42 AM CET, Konrad Dybcio wrote:
>> On 1/16/26 3:54 PM, Luca Weiss wrote:
>>> On Fri Jan 16, 2026 at 2:59 PM CET, Konrad Dybcio wrote:
>>>> On 1/16/26 2:38 PM, Luca Weiss wrote:
>>>>> Enable the CCI I2C busses and add nodes for the EEPROMs found on the
>>>>> camera that are connected there.
>>>>>
>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 50 ++++++++++++++++++++++++
>>>>>  1 file changed, 50 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>>> index 7629ceddde2a..c4a706e945ba 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>>>> @@ -529,6 +529,56 @@ vreg_l11f: ldo11 {
>>>>>  	};
>>>>>  };
>>>>>  
>>>>> +&cci0 {
>>>>> +	status = "okay";
>>>>> +};
>>>>> +
>>>>> +&cci0_i2c0 {
>>>>> +	/* Main cam: Sony IMX896 @ 0x1a */
>>>>> +
>>>>> +	eeprom@50 {
>>>>> +		compatible = "puya,p24c128f", "atmel,24c128";
>>>>> +		reg = <0x50>;
>>>>> +		vcc-supply = <&vreg_l6p>;
>>>>> +		read-only;
>>>>> +	};
>>>>> +
>>>>> +	/* Dongwoon DW9784 VCM/OIS @ 0x72 */
>>>>> +};
>>>>> +
>>>>> +
>>>>> +&cci0_i2c1 {
>>>>> +	/* Awinic AW86017 VCM @ 0x0c */
>>>>> +	/* UW cam: OmniVision OV13B10 @ 0x36 */
>>>>
>>>> There's a driver for this one!
>>>
>>> Yep! Already got patches to add the required regulators & devicetree
>>> support to the driver, but since I've got zero on CAMSS so far, I
>>> couldn't test it more than reading chip ID.
>>
>> That means the digital part works.. I'd say it's a good enough
>> indicator
>>
>>>>> +
>>>>> +	eeprom@52 {
>>>>> +		compatible = "puya,p24c128f", "atmel,24c128";
>>>>> +		reg = <0x52>;
>>>>> +		vcc-supply = <&vreg_l6p>;
>>>>> +		read-only;
>>>>> +	};
>>>>> +};
>>>>> +
>>>>> +&cci1 {
>>>>> +	/* cci1_i2c0 is not used for CCI */
>>>>> +	pinctrl-0 = <&cci1_1_default>;
>>>>> +	pinctrl-1 = <&cci1_1_sleep>;
>>>>
>>>> Let's keep them per-bus-subnode so we don't have to override it
>>>
>>> I don't see any upstream example of that, would the pinctrl work
>>> correctly with that?
>>
>> Hmm.. I assumed it would.. and I assumed we do have examples but
>> ma-a-aybe they got stuck somewhere in the review purgatory?
>>
>> If you'd be inclined to test that, you can add a pr_err() to e.g.
>> msm_pinmux_set_mux() and observe whether that changes as you
>> interact with the sensor over i2c
> 
> Yeah that doesn't work. With the following diff I just get some CCI
> timeouts and at24 driver doesn't probe correctly. I'd prefer not to do
> some yak shaving to get this patch upstream.

I think the setting happens somewhere near

drivers/base/dd.c : really_probe() : pinctrl_bind_pins()

which implies there would be a driver in play, which there isn't for the
CCI subnodes.. But let's kick that can down the road

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
