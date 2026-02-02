Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CF2798E5
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049219; cv=none; b=V5Qt2WnmiOMPZXt1sQea7AFjkjpuS2hoCgRcXx/srj35/svHlt8RPDDYZaYmg4p235MPIiSEPcLKpJnrG7hrOWNryCt0zyILgzwP2iGstCVH2UBUpDO2U4PkbI5OHrk6A6dvCNbG18C6ZUexxcIjFnvsNWUP1HOv2ziDw0NFUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049219; c=relaxed/simple;
	bh=qQCeI19q43zhf52hQ/Lsl1XTZ3EmXNqwVHsbKSSnuf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeWcfXJtoXnGEbdU/Ohyt/eArnoQMtWMP0ioKPPbwK3284pLHsdqRvfRZLLueThrhEvRSS3C8Pg0sTu1Ro6Fzhfgca5yecQXDr0YMlsnVX/japqHUe4p3TAfkYBJiXa4rytiHZp0Or5ZRCdC0zdffEqvTZ1PuYj4EwiGg+iGvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G/okN7sT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LKJh3JWc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G/okN7sT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKJh3JWc"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CJbM42884466
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 16:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GN/RhHJOU3ALzGvjR26VdLNF/dFbKvBucXPsymijr7g=; b=G/okN7sTS/snq5ho
	wVV9102D2DlV4tNBPq+y+cm7ptgjxo6LFimX2Hk3jwnHObtFLVP4P/Ir0V8Ra2Nv
	KnTIrc82O35MAgXLTT6n0y6xhxXpih/Vb7IXRE6o3mZpvxgyg0kHwrUAAyDMMyhK
	3uvnPoi1DcS142IfdI+fpwyiblKlZOM3EtzWfcsSYKK6Zb9TsWoyG0J5+f93hzny
	jjpJCoRRDDAJWZtWxA7obgnEuvGJExMGhFjsLDgQkzNGOMvZtZAxxmzIj4bozYT5
	v3rhCpRNQsXb1TtnU3Vf76zZhmRF6gDxYViPpxqnLWM1KnnObAEscfbTGsKeHiCQ
	ZQN0bQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2uu3gqak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 16:20:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a77040ede0so45850455ad.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770049217; x=1770654017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GN/RhHJOU3ALzGvjR26VdLNF/dFbKvBucXPsymijr7g=;
        b=LKJh3JWcVTsOtV9ewHMnMgRC2ytkbolgpqIojC+tBGvSpLl8QqYHXgXvePV5JhYFDH
         T2qLhFTvwRW4oYFa3QbzDpYyu1aNMDLzPbn6F69QvQ8J24rMe8QbOQ9OgDheRdZppwtB
         TOD4+TAbWqAOKXHxA8kPqxyHicEyCge9MqR88n5aegWE/A1OdBYHXj/IPZw6Lz/U6K/e
         bL8NI1gYCsGu2jiHljcsdUTB3jSEYrstxDXTRLUNR6QicyyWERuONRuTo8HOmGR246mZ
         fy9NKxCgW72u0KvQcoCDb4xCGHglyBqUTGMyzdKFTrE9DnL2l9+3x0+VuK38eqJVU/E1
         OIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049217; x=1770654017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN/RhHJOU3ALzGvjR26VdLNF/dFbKvBucXPsymijr7g=;
        b=lveURHr4Ut/J4IwJ+mLEujk6Zz7SfFUgKkQd2yOQSObghTqygQNt2q0Diohb0BTpVo
         wUqkg8rK7+UEEvVnVLDYgnfxpPghX/4zzrDc1RQPfj4wN8ssgBw2i6qj2ph2l+0GRl6c
         Lhh83VQItgMv0+Qg4rryQ1eL26xMW8o/JzPXTOkhsUz45xcxw+gm1sTq3Nf67iXkENM2
         131tKAY0hCY4SFVp0mh8erfn+b7WZruDq6NjZ916S8AZef3n3Gt1h8kHPMsOXNxM2lBd
         wKTYBMcldYZ9UtGjcqrbOnJ24A4Fy2Tujmd4D3rxiwAycyh5JoPt9UUeIfyD7iNYEPO+
         vX+A==
X-Forwarded-Encrypted: i=1; AJvYcCWA047MhAoLZlZr2ErVYyLj0DYT3tHoOUPljv7sWKJGIub3biYGyPssN5PB//8BYCt9/7ctC82wyIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbpgzOque0HldlPACDAzePdN+7vAkKKTYCSPthnIs30fzz0xT
	1o/eDg5z5u4Zc4jxH3aUeR/U5+1OYuaOOSmApSP2vwVT0fvy5Y4xurhU//TzspGb7kFVli0DOeE
	7UNoA5XTj39TXaZ0h5fDucO36fHRwwvzC6alzDFFt7ZX1zjGk5DyuY570/7Ix73M=
X-Gm-Gg: AZuq6aJR8tg3UeguBvmjMFBadfDOvsJcVqZSxMTm8oAhmWRGVxRnIzlQ9qO4LRAJPej
	megMHib8hR7Z0Ruk21ThaOhOpaE9/c4dzPGeJc1Rrkxe3napFUC2tpri2mCYqYTliqzmn+B9J6G
	9gmD9w/ePgWDzG3jsO195klqS9WLo7FGw71qYqxguIf78RPfuKeV/cI4/tPRUnyWOgnVN0vPNF1
	XcP34bbFUzuJEZDDKvrU/0O5jj94a2WNsn07z7DCWnZF02Bvp2p55a5C39nWtCLf8Zz3T49qsAm
	RI7SgQwIZECMDxPUbRk0cGBS+KagnR3drzl4LRS1dp6UiGUX8JQYco7OgS+QFb9Ns7pfl+N2hYw
	uMon5n0HVKdmminA8/JoZEIDd7PjY8dHjCDAHXy8X
X-Received: by 2002:a17:902:e551:b0:2a7:cb46:706e with SMTP id d9443c01a7336-2a8d990ab01mr122086405ad.35.1770049217077;
        Mon, 02 Feb 2026 08:20:17 -0800 (PST)
X-Received: by 2002:a17:902:e551:b0:2a7:cb46:706e with SMTP id d9443c01a7336-2a8d990ab01mr122086095ad.35.1770049216518;
        Mon, 02 Feb 2026 08:20:16 -0800 (PST)
Received: from [192.168.1.4] ([49.204.107.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8980c8623sm139237175ad.94.2026.02.02.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 08:20:16 -0800 (PST)
Message-ID: <4e6ad74b-a717-4283-afdf-90301e63832b@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 21:50:09 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] soc: qcom: geni-se: Add resources
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-5-praveen.talari@oss.qualcomm.com>
 <ae4eeac9-701e-4697-9d76-931a6659e7d5@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <ae4eeac9-701e-4697-9d76-931a6659e7d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OPBGqGJUg1u75W1eWQ5Y2aBfsDOw8Owr
X-Authority-Analysis: v=2.4 cv=OrRCCi/t c=1 sm=1 tr=0 ts=6980cec1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JMgISmeAsz0pT9/O8qDBbw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zS6uJyjHEOQbzLCDLTgA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: OPBGqGJUg1u75W1eWQ5Y2aBfsDOw8Owr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyOCBTYWx0ZWRfXxEKMgRnMzTo0
 pOEnlTDzFgQto41L3goFJABNQlt6/2qPZwLE/lPwaAWFxmJWRAcuIi2oS/lGOo0ZencfZcyQONt
 347ZCXvqibQ/F+mR3VDGNH18m/lFRLexvglG655WALEqvMhBuzTADxJ1bTF5gi9sH9sRTfetG1k
 gxji7DnNydznYAoStXDQUux0wmCvAm9ijwoFycMYNqaQLOdaI0eOlSZjd0Nu9EVKRuwkfz1GT08
 9PPaufIiQD5wBua0mXnIaqgVsoL5TweKVUuKkzGq0DjMl2FsByTno9/8D06tgS3M7oMUObs8vwy
 SewKo/ftog5C/PyOU1bn8WW4I/aZU3Lir2wNI3oE+XMIsTLsgPV1B1+29T4YlBjT1keTQlhIKnP
 nycBryBuG3awJKAfwluo1FgFinR4xsQNUh2wFth+hPR5E7yvXUpUGQC2MDem2yF/ZeQeXkz41sk
 N5I3vmdw8RGnXBm6VAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020128

Hi

On 1/30/2026 5:41 PM, Konrad Dybcio wrote:
> On 1/12/26 11:47 AM, Praveen Talari wrote:
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
>> +
>> +	ret = pinctrl_pm_select_sleep_state(se->dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	geni_se_clks_off(se);
>> +
>> +	if (se->core_clk)
>> +		clk_disable_unprepare(se->core_clk);
> 
> All clk APIs already perform a null-check internally, perhaps this call
> could be merged into geni_se_clks_off()?

Sure, will do in next patch.

Thanks,
Praveen

> 
> Konrad

