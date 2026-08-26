Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83353FA5CD
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763603; cv=none; b=B3YAtDEQv3tO1Sorf6BzzHKdN4XQdWJaXAj5HELJ5I4ZOIEuZeY8gcsnrz4gsl+SU0eMwDSbe38qtxVzw9sKm9H6PIAAfXrGvNbcVi9fzgnzAHiO0dfwOYef/2eB+j1oGEVYYsjwRjhTq7HuUMYUksQBq4W9b3xLAr3Lj8f0vGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763603; c=relaxed/simple;
	bh=QKYEZSeC3zmh2XK/BKCGZdm6AMhBrblM3gg+XaeZC6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHB/gs1PK47+RPsIlHYOKsRADt7EEWjRI0H6phSwOOxMWFcH9z2JY/okY6y+WrPznYjyxR7d/JG33wj+DcdJBli+7E6Nxova8tJCb3Ul+8go0lgs50glJ8VB5byEWl9v+o1h28x8r3TMDWRuI4bnM10OevIbqeR1dwRWn7MIYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4eDBhYw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OP8bvpGo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4eDBhYw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OP8bvpGo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGv5co1522792
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 16:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	saQ11hVcBW5itbbn9VIVLqXbwdVnQ9NNog4ncbm+MC4=; b=A4eDBhYwS6J4U45k
	3lUCx4utyWKsmAADkd2m+C0OQM0tS1jKVJ9y9u2PryXyeMMiz7MfYfPP2Xo44qas
	jodA0ttOqSB5Ia4BHQJ8Nwoidp5w60wYokACT8FAmfLZe9puvzB5pHTGNt+BYqm1
	pcFSWpwEukIMdO0GyNo3NwjTW1eEVJJ3890JxWs3S4CYlO+IhIWWEiK/iwdScjrf
	Im7VMB/C26d08XgF5VdTUDFfPXduysEFF7rBv3A6MWw1qsmXENPApPuK2aI5280o
	/2SwQBEd2IsamWe8pBBZdWr/7/RGthdKGQej9g8RhmIXMNFaL2Irk3MYuSFhfR/N
	Hp/1FQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k362d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 16:59:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3954def0191so2374960a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787763588; x=1788368388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=saQ11hVcBW5itbbn9VIVLqXbwdVnQ9NNog4ncbm+MC4=;
        b=OP8bvpGoOoXQFZgUUJlqvien+Nm+d/B/91uiEG3hQW1tuY3mj1l3wwv8CMRp1yzH8C
         eRWCalUklriNjoK8qp/TlCm6oEY5vi0hyJHIpgyvE9nQ/qKvTf6UcnNT3BCQqRk5uikU
         IbV19ucfbnNWN0K4t7or9psFvFpNJEQ3DosHno1iiooRuah3uzA31RTAlDq8hPKBaVyT
         UguMQZP5g+fiASASb2ZqSVAauoSUu45u0zT6g5R+U9bkfhlPhyJUrhVHIscqya1ca8iO
         pjAMunGOtaMvRv00WJJkg4hVOoUgnZE6ApXlo2l/Wg91E/NBDX3sUH9K645xeH3+D/iV
         +SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787763588; x=1788368388;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=saQ11hVcBW5itbbn9VIVLqXbwdVnQ9NNog4ncbm+MC4=;
        b=UmUbcioxsr2HNuY3bh7FMZ1OAnMAArXbjzlPG98SOQTONFYHWedPdhIOWExtnkrzwN
         zly4rB5iDMAfP9hZz0gFsjk4xSijyGxntnhsEOSzfLmU/H8ki7ueAh3wK2c2zUDMrxeA
         GoIH1vSm09Gf8yHmZzoNjubUq5EvNv4L0aYvPivMaZbX4orI/xYNCc2+kc7AG7YzgWsm
         qWVIn1Rqv+e6vw6Q5oScm0fopu+XZVNHIgDJcTPNgpJ7voXF6zryG6r2ipDFxpbzpWy6
         nvQe+8ZdmRf/rWvFFNOpj953Wg/9OtZ924m+d6sOVLtxKcSa8SVKPGFJlz+WbmKDbQI/
         D1WA==
X-Forwarded-Encrypted: i=1; AHgh+Rpc3TJVPY7iiDEpIS78gPkiT2yIr6f7zRvgrLVbTl8oic6lufndSoMuAb+Wn2bsPx0PlzK1UwB7yoA=@vger.kernel.org
X-Gm-Message-State: AFuF++mmjTXNa5bVuLI5DDEk1hr+2lkSLul/lnAwQpPyWcBoyygh1sEx
	AixtkNWwoUHjzd384Ee8At4CWoh1eMdUBpfaQZCGEpCKKNwx5KcV/J/tAxcrnfmNPMlmXfInqzg
	dAK21sbM3qAaNOaIf6kdqUw8s6LB1OSt8TFot5g37I7lgsgbZdRxTCNXy3fy2yQqEHHczru8=
X-Gm-Gg: AR+sD137axnRcrSSsYbINCJvv4voJBIDMmgJ/650JKzCTaxDV7y5zIklMj/u16sHUzs
	kSKEczdAHHs8eGUiiMCJFZyyzx8xtRWhJNv/Me8LB4QCfXw7ndNsMpRsWLrLa5esUuwYEgJ6doA
	VByPJPIdwYGH+iUBcwQ4hmXk5uW4OOTfLoDIR/3HTqXUhAATWyATcyA7VKrda7LY8rPFzAbEfqd
	Sw4+vLws6w2qHX+pan/Jc42qNHAhhY8HIQ4CiFc0AHeFu0gESL73Y9YbAdGB1CeHduvUNIOoUyV
	q21OWpPtx71O8wg3jRiYRXvJZJf64ohAp7NL4dh2yqZMhvOMGMiEu+ds11of+VtXpV2y5uYrJaA
	2N0/fL4YyMxcqDAo+MbHDjjCWp7Q9GkK3y4GQfrAsVBSF
X-Received: by 2002:a17:90b:4d04:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3966d1fdb01mr15288877a91.7.1787763587856;
        Wed, 26 Aug 2026 09:59:47 -0700 (PDT)
X-Received: by 2002:a17:90b:4d04:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3966d1fdb01mr15288797a91.7.1787763587238;
        Wed, 26 Aug 2026 09:59:47 -0700 (PDT)
Received: from [192.168.1.9] ([122.164.80.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b64c48sm8792338a91.8.2026.08.26.09.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 09:59:46 -0700 (PDT)
Message-ID: <8d747275-fe32-4fb4-9c57-ff9bfe13ad1f@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 22:29:41 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: qcom-geni: add I2C frequency table for 32 MHz
 firmware-based SEs
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-2-e09cd39d01d7@oss.qualcomm.com>
 <fa199e71-537e-4bce-a0d8-ef59fe871bf6@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <fa199e71-537e-4bce-a0d8-ef59fe871bf6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8f1b84 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=hGlz9nroTSpjRt0Kr7HQew==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DGHQIYP18U1F1bl52OQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MSBTYWx0ZWRfX6qKu/FKcCuyf
 vd3300B8XBnjQ9B3+mW1/AD3iTrug9xsQq6cl/afCZuq+UFDrudu1EhIrtECS6sIpa6wM//ABV4
 kvcqeFN6kzDshDClH5q7yevv2RIt2j8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MSBTYWx0ZWRfXzuP2nUajWncH
 Z6aSHtkHBgIYvwgCdML52KXo1tLTe3I9aG5OwLqKtxjQDMGsEx7+qHzc0cYL7s/218D5/+JGKsV
 5kFRbZlR8iX0Jr8AUyVOPtZ+ZR8VsiQ80RzLTi64CJtg/CIcEGCBERUr9YdVUCsqgMHxW0zrQ79
 +CtI/Q/JuVk/U+mhDXdbaHMtKd+IFz8lt/fQmHBz/0lDlG2sUaJIvzPfhMlCH1iErC/SzB5HOjV
 6dRjR+1VIECiKfVYG2aRfheb7zDSGJzgx5UcG/TMLV74WtFRQY4HaKDgv2KW8sTUtccg+a3tWND
 0JLKU6ubmHFgupZml7BXstYX2Pfu05QEpZjT7X5Ng/5UZKpHtvI8yowEdov1aJXOSOv6sa0tN/8
 d3yWRfH6gJy02zL9rBG06G8+6nk6M+sBnRrq89bmBFu2TBN7RvEhaGqJP3SLpkSjFlBb1z0qqJm
 iTpKJKbF8kfN9eJkSRg==
X-Proofpoint-ORIG-GUID: yzqYJedYXTp2WUOqIT7_8lbJlkyUbmmm
X-Proofpoint-GUID: yzqYJedYXTp2WUOqIT7_8lbJlkyUbmmm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260141


On 8/25/2026 10:50 PM, Praveen Talari wrote:
> Hi Kathiravan,
>
> On 12-08-2026 14:00, Kathiravan Thirumoorthy wrote:
>> On IPQ5424, the I2C controller can operate on both RTL-hardened SEs
>> and firmware-based SEs. As documented in commit 506bb2ab0075
>> ("i2c: qcom-geni: Support systems with 32MHz serial engine clock"),
>> in IPQ5424 SEs use a 32 MHz source clock.
>>
>> The existing frequency table does not provide the required SCL timing
>> parameters for firmware-based SEs. Add a dedicated frequency table
>> using the SCL counter values recommended by the hardware design team
>> and select it for firmware-based SEs to achieve the target bus
>> frequencies.
>>
>> Move geni_i2c_clk_map_idx() from geni_i2c_resources_init() to
>> geni_i2c_init() to ensure SE_HW_PARAM_2 is accessed only after the
>> required clocks have been enabled.
>>
>> Signed-off-by: Kathiravan Thirumoorthy 
>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 25 ++++++++++++++++++-------
>>   include/linux/soc/qcom/geni-se.h   |  1 +
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c 
>> b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 00013b41a6f5..15835f10b062 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -187,19 +187,28 @@ static const struct geni_i2c_clk_fld 
>> geni_i2c_clk_map_19p2mhz[] = {
>>   };
>>     /* source_clock = 32 MHz */
>> -static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>> +static const struct geni_i2c_clk_fld 
>> geni_i2c_clk_map_32mhz_minicore[] = {
>>       { I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
>>       { I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
>>       { I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>>       {}
>>   };
>>   +static const struct geni_i2c_clk_fld 
>> geni_i2c_clk_map_32mhz_fwcore[] = {
>> +    { I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 25 },
>> +    { I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 18 },
>> +    { I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 6, 15, 29 },
>> +    {}
>> +};
>> +
>>   static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>>   {
>>       const struct geni_i2c_clk_fld *itr;
>> +    bool is_minicore = FIELD_GET(GEN_USE_MINICORES,
>> +                     readl_relaxed(gi2c->se.base + SE_HW_PARAM_2));
>>         if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
>> -        itr = geni_i2c_clk_map_32mhz;
>> +        itr = is_minicore ? geni_i2c_clk_map_32mhz_minicore : 
>> geni_i2c_clk_map_32mhz_fwcore;
> The source selection remains unchanged when using 32 MHz:
> writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);

I have to check on this. But in downstream, we didn't change this 
configuration.

>
> However, what about the voltage requirements associated with the 
> higher frequency?

There are no such requirements in the IPQ SoC.

>
> Are they automatically managed by the underlying provider, or is 
> additional handling needed in the driver?
>
> Reference of konrad change for CCI I2C driver for 37.5MHz with voltage 
> requirement.
>
> https://lore.kernel.org/linux-arm-msm/20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com/ 
>
>
>
> Thanks,
>
> Praveen Talari
