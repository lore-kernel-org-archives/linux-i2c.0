Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464E40929C
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206088; cv=none; b=ufcaj3LjsU/KM8Qzzhhe7ZDtjJ6Dw/NYTaevdFGFdIJkyrAPTuncrs/bRK+ydR5ZrkWz0vJhm2exvwKEVcsWJtS7PByOVk5J2vfx3roIJjElQlefUlyKaMsLl6xtJPsu4ScLeR3YSn5p36mwwWOIO+Vu6vWDHXvIJw6dGjFRJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206088; c=relaxed/simple;
	bh=4WwgOrkLN5ycs7P0MSvxo1hs9FvUNhGNX7cmtj2PVfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM12T4cGQs981hHExPxOyqIioLC68LJ2rq+B0kMGtMCDRziQkuqVUc2u8uP9+JNy228h0sGcKMeT3mhemneq7LUhQjC674Spz6s2+meUXjnNr815A/Tq12yTe9PnyusDg8+k7VaIVjngd+0t8b7Kdf/5P7pcCoYf5j983YTeSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bb6R/pMH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RulH4RvR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bb6R/pMH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RulH4RvR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiTQh2754615
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UwGbzDMA77YhyXgm0vP9xVA9KFFUubCrmjhkgXBCQ34=; b=Bb6R/pMHezzewbEz
	LLJQA2E/rLkNcy0lsD2HgSOYdirUXyyMEFSJKFV3uYytFKlD35eru36532uBFjod
	T64XnEQnrcqtVVgNNnvGjbwwuNAX8dSfh6uw+ip6hcedk89YaX0871Dj7ZliVLbs
	rmhzdPP3jeLX/eVXTTlYhwor55qAonT7OdBQVuYDDf1s6lxXkSkG0hEvUFpXdihu
	FUy95JlMjybaTlXx09m5THkzBEoD/4GUqmfg5TeGKGJfpYXfZDzht4rcBnu22BlI
	JycQ9xET7OeIwUgBhIL6v7Hxkzi47OVXQj8xbB03CuD8K/fLS2ayBgtT6uATCcbS
	zp9YUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu1098s7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:48:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso10261742a12.1
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784206085; x=1784810885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UwGbzDMA77YhyXgm0vP9xVA9KFFUubCrmjhkgXBCQ34=;
        b=RulH4RvRnb/vc77KaLknzYekxpyjzWMyGbeC+sUJBpv039YBqgYbthBXOWDxqSdNU/
         tRtc3A4yKp7tKgTKB3UFMhaBNXfoy03DqVYSYM485irkS3NxtKl6qGM3scLNmaV8WQmF
         +5nkP/yOODCUU7ZV5+s5di+HyOpHTjikXFnTEEXByHU06s6mGPAXwh9Qt2WvdmVk0i8S
         b9PzLYWN4ruQm+nprsXugFbAaFHAqBpgCCs89Ai68kXUpP31H9lOeCaQrf2Ccg8w6MCI
         0gACS1tVnx2pzuKEsdRz3Enp8oQ2ttGp1+nNcLOcH5A7TEQ+rbbQhG3QugUEUwlPddHr
         91nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206085; x=1784810885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UwGbzDMA77YhyXgm0vP9xVA9KFFUubCrmjhkgXBCQ34=;
        b=ss0QsyUro52bvlR6+fVmSYdWu6rgoPPVH/m9iSoLiBVXPQ4d/VfTSzyRj44tOFEIsS
         px7+VCC5KEkW6fxGqRnX+bV47UUttJLigRHqKPjqHqT9Q/Nm2bNxd6YM/FzBiqs0/yB2
         /tkCbUMuVNmDF/JYsuQORhODmDA+lhuuyv++wOhEuXO8pUbuC+ERQES5HvF/bFW0qX6X
         KBexdOZ7GaOjH2TJOj7P2pE30MX7OGuoz8OYeohAf9yVdivBxLyLqr+i6FmlPJejYiK1
         bnpq62UPZKvJo9xUUwnIBVHwFJ6+wdo/PNPon4ZYd+b1qalexzRpibJqh6aJ4rKOwUXT
         dMgA==
X-Forwarded-Encrypted: i=1; AHgh+RpbJO9i9pzJfQz8i2u3wVCqPyO2xKA6VxgTPol06XHMUdKoo9SDzhapas/9WBWoYpLn+q08jsU46s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFQZ6P2pMcsLXCjHcOy5fOvOYEYdNxAtmif2iBjUATtk6MUHQ
	4FuzN21gsFnBR3hjovsKa+w2k2zLsLfWEDnD/TegMHEspojR8oUOEY3c/wYU4R308PMoB4sxKYD
	IqELfPqWGEPTzDNF8oSGvn6WiD1ohBoZRKei5noNPQ03L2WGcm5DXVCL+JnWCet0=
X-Gm-Gg: AfdE7ck5PhZvkP9DE9ocoEkIehx1TkAs7aq3TVfb6G0NS7HF2uSkPZWhGIr6rlLw4iT
	5UR255bym6PYE48G/dkq7P7bVHbQWmWZ3F6XW/CrVT+BA38nrjHE/7sEl2DPrBbyfVvzIb5M241
	8gZgn/uFYyCXNLg0ZrtOpG7cJn2zBSO0M/StRhKtIwCEQyWrNJt00ARpuUdRhc05flI52maBJpR
	Xf6dB8CvUSun5RgFtzEtpZ1CdOXzsFnXUyQ5cVeRCKCk+F3KUh9+rGDAPRChHnzxvmbkC9WfdFM
	RWZlDD2a53Ip10oaaZIANaxJ86THzBqqI+MCeSCbCk0OzM/y2ePqNOt+O1kiZpcxEIqw3jJ9LEc
	1Di1Nzkokggy0ov9QN4Fm8H0mOADvdMPP4Q==
X-Received: by 2002:a05:6a20:db0a:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3c34d5dd5camr15385998637.32.1784206084974;
        Thu, 16 Jul 2026 05:48:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:db0a:b0:3bf:c223:4640 with SMTP id adf61e73a8af0-3c34d5dd5camr15385962637.32.1784206084526;
        Thu, 16 Jul 2026 05:48:04 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.231.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd403a7f7sm10961801c88.0.2026.07.16.05.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 05:48:04 -0700 (PDT)
Message-ID: <d6f69a98-84e1-4784-b84a-16b387b479e5@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:17:54 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn,
        kees@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
 <ee424097-6f29-4605-bd0c-242190a7b376@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ee424097-6f29-4605-bd0c-242190a7b376@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YthGPgEDsstmYkiWCmJtCgXeoUGkzY2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMiBTYWx0ZWRfX8KZ6Dl3QzC7a
 mCUFecEQZodxXcC38VJAx+TvkRxek95kk0b/8Xb9z81OzRgGSevu97pQF3gj63KQXlNawosOnj1
 FC0/HF3KtZyRCDUt9oryL5cu2FI8/fjp8DmQcm3E3uuSpQ3m2f/eG6EHWma+/dZdGlslSAjZQlK
 5ulLhk0bD1AdppP8Kwkh9ZxTm3Eawa3nwOdPjcxagqo+MUf7Il+xF7as+LgtO0MAdV2bZHauda8
 jj/wCtP1ZcyrHIolZIO6yPSMyEk8/GCZ8PlaMJh22ZFYR5elpd3JmzDJlEI68TP40wzd7+MpTuL
 2TFzHMx3IcghuW9G+lCRVviaVZwTPwLcCqeoL/QOnzcRfI7+mjQuzqqftTB77htmaQ+pLLqf0Zh
 Yh5MvRdTX9yn0VSZaUlRij5q2GZxcdUtEQ2Dpj5hMiJAVmqozfcAtDrHl60YVTwfbonkd91mH6U
 XF/jbuxIKUOt4+focLg==
X-Proofpoint-GUID: YthGPgEDsstmYkiWCmJtCgXeoUGkzY2t
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a58d305 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=OlrBKP18NtReKxGUJ9moaA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=jn-D0AhQX9NsX7IxBaoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMiBTYWx0ZWRfXxSLABAaMIsAq
 B3RCyXbWOb8+FzaXgOzrGp97p6ElENDcIcBwd7ZJGL7KWJF5pCpknEWzYrFaZARyyeJ25dOL+Qp
 BhFHVEwWau17m66HirySrKyX6yeLLsE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160132



On 7/15/2026 5:54 PM, Konrad Dybcio wrote:
> On 7/8/26 7:10 AM, Mukesh Kumar Savaliya wrote:
>> Some platforms use a QUP-based I2C controller in a configuration where the
>> controller is shared with another system processor. In this setup the
>> operating system must not assume exclusive ownership of the controller or
>> its associated pins.
>>
>> Add support for enabling multi-owner operation when DeviceTree specifies
>> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
>> shared so the common GENI resource handling avoids selecting the "sleep"
>> pinctrl state, which could disrupt transfers initiated by the other
>> processor.
>>
>> For GPI mode transfers, request lock/unlock TRE sequencing from the GPI
>> driver by setting a single lock_action selector per message, emitting lock
>> before the first message and unlock after the last message (handling the
>> single-message case as well). This serializes access to the shared
>> controller without requiring message-position flags to be passed into the
>> DMA engine layer.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
> 
> [...]
> 
> 
>> +		if (gi2c->se.multi_owner)
>> +			return dev_err_probe(gi2c->se.dev, -EINVAL,
>> +					     "I2C sharing not supported in non GSI mode\n");
> 
> ultra nit: "non-GSI"
> 
Will update in next patch.
>> +
>>   		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
>>   
>>   		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
>> @@ -1098,6 +1115,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
>>   	}
>>   
>> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
> 
> Let's use device_property_present() instead.
> 
Sure, Thanks for the suggestion and review. Will update in next patch.
> with that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

