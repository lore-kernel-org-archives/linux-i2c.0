Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A733984B
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331111; cv=none; b=PvopzCW3KfqR8VhaVnqV1tsLuNJbWDCYygVjAf05bCXuvZOedGT5PkE48Wv1kBGbxXp0i8FGk+CcF9LjSFchVfVc6dOuol5aQ+IrqyvnkE5dfzK50jkWmFadNTHTj4g21K98NLDjhUhCpwkfUJgS9g8OKslUosDrIU+AZsmbLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331111; c=relaxed/simple;
	bh=DrDwj/Cbmj8Cu+rIbWYsfU928hPLy7N+65tW0GD+GdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaCh1qNLsB1D9p+jo5J3LLUq/ORX1uQJ2iwy0Dgh9z/Reov2q16qD/rNo3Wmk9OJGSDOpYqI8aHiMvDbVH4kPzCTxM2NHrDH9wiRyvqF3rvXM+D5jED7MHwl6xyauZ7QVSV2NAxqw7R9nKrcpp8IEVC/rEQau4uD9H3Zkcyek20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCSvKPaV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vg9dkPST; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCSvKPaV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vg9dkPST"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HB3lRC1943250
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NmWWvqkr1dj9SgTFDELa5mkiI7lMFXhwkqqx5kev2EE=; b=VCSvKPaVlhaILGcm
	J9VANFxubFsURjP9cDbqwPLnUqdUN/r5Iw0AmTp3aDS8QdiFdCjsusBHhvj8hrqW
	Vq38SpMFNtyc8X8sXUW224MM/Fce8DPB3nxJVaXV9bh4RLQ4neyofSrxCeXn0smY
	KEWBXmipLiwjug/MgC2rN8fCYFFeW5Yg1Qq2gIx/0pN8lOlSGVa8wNUEIaqkrFa3
	p8o/W261klZ5lOD8hIV06r2G2UfgVSXEQdScom8RaXsgVfkoGV7cEJI764fKEhwB
	+2qjhYQ2ngy9X4/E3Ep3HecGKzj33lmaJLbv6nGihT2jvIPEL9//Lb54/Za8UBSy
	YSQ5fg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g08m3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 12:25:09 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89545f12461so29488336d6.2
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771331109; x=1771935909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmWWvqkr1dj9SgTFDELa5mkiI7lMFXhwkqqx5kev2EE=;
        b=Vg9dkPSThoCNlCXwUg4nbmRSv6LA7LDNj8oamzJAp2so0ZKlsIJi08sM2gEwQctAFq
         aempXvUJaEyK8fCyk9eGuq3/xlS/QQBJ+4tlPRsK5IFpcE26HE98Am9J435d4SolG/Zg
         INfndSuFnOd2x6F5Qbwj9PXmRFdwLrQygdJ9raehmuCk42+1g8DgVbRsoiMt38J1M/Zi
         S2BzPMW50rCDrIXX4V5UxHFojFk0cb2o8qkATERD+H8oeCnmIrL/vwq82pbG26Ydq4kk
         6Abr+pPa++JKvkFz/DUIir9wUiOThegrf2liqHfNmrYmp1S/HMulSFVvu74G2JnEt7Dy
         y8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771331109; x=1771935909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmWWvqkr1dj9SgTFDELa5mkiI7lMFXhwkqqx5kev2EE=;
        b=aPLRmm3KV32K7hmhWRaHJN6+W4wyUj4j9/7vq5WRYwHc2A/PWABergwxJCRvcbQKtf
         jUG+AmXk/BZjZUZ4//nLqjzLsVu01VuGR9JE6RY0HCnhNgeHBcMuN03muAAEHnwvXjIq
         mNyohxq7RpY6v4cnCeyNE6lOBZFt2Tp6Ui1WpZ/iZk4QCNC5MgQijbSgT/QRRt8m3aGg
         HfZNbsoDvoL8gBPr1kF7K+MfyRttm4cQ2k8VnLlDFViTtYYl/nB+VpyE8rwg0P1AfBx0
         uQwAtmacChUOtNsHqQrNvuhJAc4jyoyVswRDvUQWcZw7aBw7xi+MbjF+fDvRBwnL+eBv
         vo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVR1Sn3O1YYQR1hNM4Dm0/ZrEqFPNSBRSH2IYNxGDWO+VhzHi28Aft6bNz23pJKx3vS7PQ68ALhKxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3KWUlQp8Lk24nn4dt0kWbApapPD+p5XLG4FP4+FOExsKJQb4
	83U3Yp3ScAi4ZENaeWOQ8+wfu8Yuf3ykI8v/1z4yzUF4cqc1cEcNBzPU8Q9/lsq7QJii0Q5dxxV
	oz+2IBTrrssxNKDK8Lbzs0dT6lRilXQojmHAb0Hn5Kq6JX2KUL86J9sMHiA3Zo4g=
X-Gm-Gg: AZuq6aIgkAM8dnaV3Sb2Om2XhV4PDveQ5Zla4uJLiJG8X8wkIzGjeJ5/7O95dwPFhMH
	00DeFvljKKL2QhEX9jHVuMoypWgOa+nEwP2FsNO8wSRY4pTBpYlZMuflLwNagYlchbX891Y1OwT
	fHoWW5zmrvguZFhMgyRBjYXTCY6VhTJcf0UaT6Ik0VH4eyXrXHPRzG2o8GFu0dcMOr+WOXnvHf2
	l7Npo7YBKOswQijdk1dURi9tJAF6cNzUo0gRxIeGBUh8SmE//Dvw5RH7eZtkP7xqyZ5SobAL6Re
	pC+0pzR/81io4IiBnYAQspZGBEr1IhWX/aC9fqjoqul0AhMsLQFbsw7a8C1qQ9MLsOSS5fNtucy
	nQfttD7F7qiqHOTgGQXY6Ku1XnKuNPaMwZSHQ8P4Ipn/kF537zvyoWlxfrwUkQjlA7XpTJfsY4h
	zn/eg=
X-Received: by 2002:a05:6214:8101:b0:897:430:df71 with SMTP id 6a1803df08f44-897347af709mr139685996d6.4.1771331108835;
        Tue, 17 Feb 2026 04:25:08 -0800 (PST)
X-Received: by 2002:a05:6214:8101:b0:897:430:df71 with SMTP id 6a1803df08f44-897347af709mr139685626d6.4.1771331108399;
        Tue, 17 Feb 2026 04:25:08 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385f5dsm351920966b.20.2026.02.17.04.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:25:07 -0800 (PST)
Message-ID: <ac490ba8-18d0-47fc-a662-5a202c5ba95d@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:25:04 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] soc: qcom: geni-se: Introduce helper APIs for
 performance control
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-7-praveen.talari@oss.qualcomm.com>
 <af0eba46-329f-4979-8b8a-fb5dbe2ad992@oss.qualcomm.com>
 <b918cfa9-1f40-4aee-ad91-d6425798bd07@oss.qualcomm.com>
 <24f967b5-0f15-4aed-a81f-ad54f8e541fa@oss.qualcomm.com>
 <92dc98b7-8047-420b-9743-4bcbc7e30fed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <92dc98b7-8047-420b-9743-4bcbc7e30fed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwMiBTYWx0ZWRfXzeNXtMmrMWKO
 4r5hG3qKH64DPPi6jwHhpYETDm8APD8r8dlPbHl9Mx3XVGFlgwUjgyncEhv4J12RYsoEHtXeR0n
 S8jAb/vdF2fdjGq0YGt0W5bSzMKZTX6e/6lzfHld1YrICbVdbaouuV6r6oU2ao3LRlRs0w15mRx
 JclV3IBQTtP9XsShlpE1pCBzZ8vj6mFhcbv9KMIBGETQXq12m97gWJI8IbOvEAER19Asur0aTZP
 jsM19zvhWFUDrwj7gFgTdfG9nYFwbylQM8v/3I2nI+jsN/qT42LoCQOTS2ZSCoAlPPLrstJgFDY
 bo/3d/l9mcJhyEXTMKFPNjgOX8HEMasCb51xo+IMp+l/dkKXaEzEn8H6Ph7DkCbwNROKSpR6PIg
 GxtziHw0/NuPwTd6FNQW4VFPqddnKwBk41oAXorMkJz2jVKAmNNxHEnqoJa5ovObzP2Ng5sYW/F
 8hg1p2rVV5/OoFsmpnw==
X-Proofpoint-ORIG-GUID: sq_Db9lUtGeUzLBjpcijBWayulH---P5
X-Proofpoint-GUID: sq_Db9lUtGeUzLBjpcijBWayulH---P5
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=69945e25 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=mwp93uWdNOBgBzRbo8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170102

On 2/4/26 6:42 AM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 2/3/2026 4:44 PM, Konrad Dybcio wrote:
>> On 1/30/26 5:54 PM, Praveen Talari wrote:
>>> Hi Konrad
>>>
>>> On 1/30/2026 5:53 PM, Konrad Dybcio wrote:
>>>> On 1/12/26 11:47 AM, Praveen Talari wrote:
>>>>> The GENI Serial Engine (SE) drivers (I2C, SPI, and SERIAL) currently
>>>>> manage performance levels and operating points directly. This resulting
>>>>> in code duplication across drivers. such as configuring a specific level
>>>>> or find and apply an OPP based on a clock frequency.
>>>>>
>>>>> Introduce two new helper APIs, geni_se_set_perf_level() and
>>>>> geni_se_set_perf_opp(), addresses this issue by providing a streamlined
>>>>> method for the GENI Serial Engine (SE) drivers to find and set the OPP
>>>>> based on the desired performance level, thereby eliminating redundancy.
>>>>>
>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> +/**
>>>>> + * geni_se_set_perf_level() - Set performance level for GENI SE.
>>>>> + * @se: Pointer to the struct geni_se instance.
>>>>> + * @level: The desired performance level.
>>>>> + *
>>>>> + * Sets the performance level by directly calling dev_pm_opp_set_level
>>>>> + * on the performance device associated with the SE.
>>>>> + *
>>>>> + * Return: 0 on success, or a negative error code on failure.
>>>>> + */
>>>>> +int geni_se_set_perf_level(struct geni_se *se, unsigned long level)
>>>>> +{
>>>>> +    return dev_pm_opp_set_level(se->pd_list->pd_devs[DOMAIN_IDX_PERF], level);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(geni_se_set_perf_level);
>>>>
>>>> This function is never used
>>>
>>> it will be used by UART driver, not for I2C/SPI.
>>
>> Adding unused exported symbols is "eeeh"..
> 
> I keep in mind for UART, i have added this API.
>>
>>>>
>>>>> +
>>>>> +/**
>>>>> + * geni_se_set_perf_opp() - Set performance OPP for GENI SE by frequency.
>>>>> + * @se: Pointer to the struct geni_se instance.
>>>>> + * @clk_freq: The requested clock frequency.
>>>>> + *
>>>>> + * Finds the nearest operating performance point (OPP) for the given
>>>>> + * clock frequency and applies it to the SE's performance device.
>>>>> + *
>>>>> + * Return: 0 on success, or a negative error code on failure.
>>>>> + */
>>>>> +int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)
>>>>
>>>> I think with the SPI driver in mind (which seems to do a simple rateset
>>>
>>> APIs were added as generic interfaces shared across I²C/SPI which is specific to firmware control, not Linux control.
>>>
>>>> for both backends) we could do:
>>>>
>>>>> +{
>>>>> +    struct device *perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
>>>>
>>>> Then, we can do struct device * perf_dev = se->dev;
>>> I don't think, it is needed since this is specific to firmware control, not Linux control.
>>
>> My point is that it doesn't have to be specific to the auto usecase,
>> further commonizing the code.
> 
> This API will not useful for non-auto cases as well.

This is only because you make it so, with the above suggestion we could
do without the .set_rate abstraction in the SPI driver which only does
an opp_set_rate in the generic case

Konrad
