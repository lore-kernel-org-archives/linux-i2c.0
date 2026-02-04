Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F101340DA4
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 05:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182337; cv=none; b=IsqZOjPzYiDtyvVzV//idPkL/vJdfjI8fzIjcykkF6UDDnzV4fwPy7tHHjftRzBcHkxXhepY0/n2vJlYsJNslys0QFch1K7LzeGtM7XbxNbJON4kedeQNW+zV3n8NZ5L/8goZ8gzJkVUiL/Z9+BMy05J7RYsozfYYCbgfwJ4Fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182337; c=relaxed/simple;
	bh=pZbP/KDm3d9zf7rWC1WJ+TPqscXWFX0xVrRW0kGXTZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4uA9hxvBp9jQeEaivo6abUbvUUpKxP/sqTFmN6pYlJAfHDtaVyuFaglHl/TQ5roF3rfrbG19YQ1NNETyzGAHej/jY3sO6cExAQJN2fEfIbYmfA2CAUTdsSzMqfBVqirMOcxGh8GZXaqgj+ODQRDLusPkMb9qTJcczRHKbHF04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bc5mgXxS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fDBU3BQp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bc5mgXxS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fDBU3BQp"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6144gIQq3824323
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 05:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QTGIdDXWEeHzCVDoRyE9D4/yRVEIvH7oRcS5mXl5a6Y=; b=bc5mgXxSTRsnqNKB
	J+GM7FQQl/VbKh0idS9Gy2i//haHzHcbruxMz+cfdYKGyw1RgJA/wtYYJEBNhfgO
	tGOstA6lYLnku+3w5GhSnpmOyXn/cdjoRGPdloQoBLvGs7BnzxmvQt0z73ItQ9lf
	tmAGntFasgdTyF/amFjvgyTz3m+T3/qCpgXfpjMmTJ3L53FSSduKwwkSuJdGgd9r
	hwZy7fgwFDQhbVcLaaaqoejrUE/ywq6mEWBBEE3kWsCFicJpg0xqtttrryAMas+3
	emr/cldusnZe6TGSuU4BIYENqqYiLn0xXv4N1w+Cf1UrOTGpdCuB9cekLiK09j2/
	ADbCZw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3g33k5p5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 05:18:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso3829819a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 21:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770182335; x=1770787135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTGIdDXWEeHzCVDoRyE9D4/yRVEIvH7oRcS5mXl5a6Y=;
        b=fDBU3BQpfjCu6eW0Z+4HRumg1mU6V4p3IIsRuGxzOGLV7oBZp2iqBzXcnmcSEuek6A
         rFj/K7Ss28KfCO8rlrD6KhDHduMWt2tz/CsLcOjx68i9JccWsYLk/j0RD8Oz4GWaxkRt
         ebBAxvcL+o3Xo3nBovKy0kXdQXD4TcPRRUBk6TMMOSwiy27DkcdexQi77A/iLJOhI42b
         /EMNpzsXGY+SJkbLgIg4mMSgKvrLZadf7JAqjsaWZbrhhQxzsM9UV8CsNk0bfKyBNkU+
         hbUFfxwxPB3Pm6eQgPtcRAub3/VSWr/uHmYtrRWNiWBY5hZieQYz5RlkDeitKagKAb5E
         566A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770182335; x=1770787135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTGIdDXWEeHzCVDoRyE9D4/yRVEIvH7oRcS5mXl5a6Y=;
        b=foMplZ8zI+3YugfwTZiTdyP524H0ZYXLxesEe5Gpg7YLl2yyp8ZSNZCMdiNdCyLeBN
         aUqi1ba/ON+MCs7O7SNZM/19+lOGA8t817t2/17oM/chmgtgP/qTZi2Nii0uyHJpuEyZ
         AjYrQ0J7bST4cvWTD08eJ3WA79Q66gzz5qU02gSx9PDh1hr4+4mXbY/iWK/dgkP2lHKF
         MtvO8XZquOnAhz4Cb99vYHYd4v+0oscqrt6Rpyqen/yvI6jjfeax/fB8+ATQ4Ul68W0F
         pwWKqWQmIuhpTUNPLc1gTb51xXSHOV7fzm4T+PbPaLHs3/U16ICwL+CBNrfU6F3oBiGo
         Afgw==
X-Forwarded-Encrypted: i=1; AJvYcCWtdvJ5O3LSNd2YWbUGfmR6+smHdtk9SwRNKaEeqisSRF4mCATfo/b6j7ZjzYRfk5eKheDpub0duUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTEGBGm2gmSDe15hrya7RS5mf8PICCACT6G6Vck6EHuYMi1s+C
	AzrQYfjJPplM54DLv8leNDwBbq9n4vUwT24J6/K9dTZwJ0A3InmiQnUFGRAr8vxhPJvltQPV5dT
	JmU5f2hHSdb4DwSL/AIE02Bzdz0mtx3CLpqhYPHqFSa3QMLnFUJS5IxSYNvsLy7Y=
X-Gm-Gg: AZuq6aL7M/r2vMMnrRjZbPnkXsB37fWrF4eHAL3uyyjBpSTHMCyqiJDDHUUfEJaTGwq
	/j4itMCKDHF7v3ZstcY4ejSou0U7uQEBHrsh6wRpDvy5SvA5RUQ7P8ssruNsK8wEXwdaCNBy3kq
	kLS3C2McZutOtFpYSLRlP5oj/TxCYWdZc6rX5vGDm1Jg7z0Fn/6sHsolPRI+Xxsl6zpXsJ8ptQ6
	0xoN8KwpmPEdW9cHrr6J2Qs9Awsc7eul0pMS0m3eAO/3Wr6CZHQ3+dvRwyZzE0r6VmlUKM+g3WK
	HJTadNfXBFH8qIQ+6tgMmDZ7uelQEj8IOARf+KKP7eSpvBxaIs/XHFISwW+ZR2JnPVMRtuJ1BgW
	Avoey4IFQTWRf5pdxiz/Ny4I8P+mldPud3s2bdZqxJA==
X-Received: by 2002:a05:6a21:4d92:b0:350:7238:7e2e with SMTP id adf61e73a8af0-39372438780mr1706540637.45.1770182335063;
        Tue, 03 Feb 2026 21:18:55 -0800 (PST)
X-Received: by 2002:a05:6a21:4d92:b0:350:7238:7e2e with SMTP id adf61e73a8af0-39372438780mr1706504637.45.1770182334502;
        Tue, 03 Feb 2026 21:18:54 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933854321sm10224445ad.3.2026.02.03.21.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 21:18:54 -0800 (PST)
Message-ID: <06d16c97-5db0-4c2d-9d30-68fc2ef1c5c0@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 10:48:47 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] soc: qcom: geni-se: Add resources
 activation/deactivation helpers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-6-praveen.talari@oss.qualcomm.com>
 <ff9a2aa3-1b2b-4001-82ce-198c61a4b637@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <ff9a2aa3-1b2b-4001-82ce-198c61a4b637@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=afVsXBot c=1 sm=1 tr=0 ts=6982d6c0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_TUg1R5cyTUgEzYIA1EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: tGVjsRXxKGJ823FlUbeGn4fVuR_3BMGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAzNiBTYWx0ZWRfX6QrfzbCsdumT
 uEaGE4/BKwA3qYGBgyNt06uIitUK2Ko0Dmt0luHX4bzIj2+sw+Eyd26LNfuopL4vC4uSqSD9QIY
 IuPYnlt+KGJTWS9O7kJAK/7NZmcLZ4WbMO9lPo6q30kB4l55tcOC1RCcevCSaJ4e3upIJf3X7U0
 Cp7YrxgjNDLY82X+gU939iCs3QE7n03zlvvYjsAAxZsTEihv8JTHCjIknJWUmlkxB3hmUWLVuO9
 3H0Oui37GjkXBL7Ms8XaPWlWCMxlqp33iaUx8Lao0vVIZlWUPl5qga8dZ7x/5nPlATyYUgmGnFL
 d7lTOZ+Crmo/C/MDnUOXPOSXQO74cOT3b0ppVDKb6wT+taKY99YVX2/Hn9zvCuSaiNPSrcVPCTo
 k0EuCTud4KrsShh8d9/wUJGV50F3NQ0DAFITQmcYtzzNQROEsV5v/HpWhuNRhRM2Z3WlGx6vtTO
 P1K+iXgKCp6EBNA/0aw==
X-Proofpoint-GUID: tGVjsRXxKGJ823FlUbeGn4fVuR_3BMGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040036

Hi Konrad,

On 2/3/2026 5:50 PM, Konrad Dybcio wrote:
> On 2/2/26 7:09 PM, Praveen Talari wrote:
>> The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
>> activation/deactivation sequences independently, leading to code
>> duplication.
>>
>> Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
>> power on/off resources.The activate function enables ICC, clocks, and TLMM
>> whereas the deactivate function disables resources in reverse order
>> including OPP rate reset, clocks, ICC and TLMM.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +int geni_se_resources_deactivate(struct geni_se *se)
>> +{
>> +	int ret;
>> +
>> +	if (has_acpi_companion(se->dev))
>> +		return 0;
>> +
>> +	if (se->has_opp)
>> +		dev_pm_opp_set_rate(se->dev, 0);
> 
> This is still unbalanced at this point of abstraction, notably
> keeping the RPMh vote at 0 permanently after the first
> geni_se_resources_deactivate()  since there's no counterpart in
> _activate()

I don’t think we need a counterpart for this in the activate path, since 
it is specific to dropping the vote during suspend. The vote will anyway 
be taken again as part of the transfer after the device resumes.

Thanks,
Praveen Talari

> 
> That said, the serial and UART drivers do rate calculations internally,
> so perhaps trying to be overly smart about it wouldn't be a good thing
> either.. Let's add a note in kerneldoc that the activate must be preceded
> by a dev_pm_opp_set_xyz()
> 
> [...]
> 
>> +int geni_se_resources_activate(struct geni_se *se)
>> +{
>> +	int ret;
>> +
>> +	if (has_acpi_companion(se->dev))
>> +		return 0;
>> +
>> +	ret = geni_icc_enable(se);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = geni_se_clks_on(se);
>> +	if (ret)
>> +		goto out_icc_disable;
>> +
>> +	ret = pinctrl_pm_select_default_state(se->dev);
>> +	if (ret) {
>> +		geni_se_clks_off(se);
>> +		goto out_icc_disable;
>> +	}
>> +
>> +	return ret;
> 
> nit: this 'return' always returns 0
> 
> Konrad
> 
>> +
>> +out_icc_disable:
>> +	geni_icc_disable(se);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(geni_se_resources_activate);
>> +
>>   /**
>>    * geni_se_resources_init() - Initialize resources for a GENI SE device.
>>    * @se: Pointer to the geni_se structure representing the GENI SE device.
>> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
>> index c182dd0f0bde..36a68149345c 100644
>> --- a/include/linux/soc/qcom/geni-se.h
>> +++ b/include/linux/soc/qcom/geni-se.h
>> @@ -541,6 +541,10 @@ int geni_icc_disable(struct geni_se *se);
>>   
>>   int geni_se_resources_init(struct geni_se *se);
>>   
>> +int geni_se_resources_activate(struct geni_se *se);
>> +
>> +int geni_se_resources_deactivate(struct geni_se *se);
>> +
>>   int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol);
>>   #endif
>>   #endif

