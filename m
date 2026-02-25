Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D713AE70C
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029545; cv=none; b=mUkagK+5B7vAsHQ4TiAy4ljzQvMlDOF4TFnsYgRocUW7eKln4ggpEAVv8YjuArXWu/XovlPtOPSBoSSynOX2Um6mkIUmnHfejBHF5B572FjHMkbDvSJhDhL5NnpiqpMGMrctYP0MBhooTVI/9xEBu0k3JA0XWi+R1N86V7mbSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029545; c=relaxed/simple;
	bh=SzQvn4vau6FpBe/PwNL0nk4M12ycm7A3Y9acxzimCnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPKakzklz5E5yMgQhRYl+gqDIGITc5A6eC5FpTxMJnugFV5CNRR+jrDMvLKO3HnVuPYS6wo1w+j/ir1k2bTNZEi3iUl30XyQg8K1/hWRNyVUbQ/SbkmI+n1eSmOCaYOsrQqB+17vkhEcMFA647NGsRzktxiV3KZk6m2DpqTpWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=InRQ2lpe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=huIy1Jdt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="InRQ2lpe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="huIy1Jdt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9Spdd229664
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CFC0QojEPG4lOdIZ8IPpP53jKc6Om2BjnjzFZDb3UgU=; b=InRQ2lpe2XMx0e4Z
	KFaTLQm0ldxroUfwsBAib1203EYmlpCXLKRfIO/Zcqo1sUvgYnCLDYPlIgGKzFpl
	OUTTGxnZ4OcA6GS4V7Y3Wq2jROHysLtboOXTuor9F6SPNByfzxEUfr4/wSnkwoXs
	QFIKNyQQ+hmcc357kz+mojxBW79qQNMnKvC8QPkNRkej3tIu3Npg4NFk8Y7jDWQE
	2YITozTkL84d9b4wLzp4XyrWkTKqoYnikJVJ6AALmwKun1BTwjpEXKFwyz9ruSNj
	Pq+QylC7fSHeHdATqmf5TbrgnUFhIBUEl96Wg0F13gcV4pymM4sVMNauXteCTE+u
	kwTBSQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg37ug8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:25:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c710279d57so573918685a.3
        for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 06:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772029542; x=1772634342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFC0QojEPG4lOdIZ8IPpP53jKc6Om2BjnjzFZDb3UgU=;
        b=huIy1JdtCTXFXyNIm44p0dDQwwomKXDSC+3Bke1Fuk2y3d2P5aT8e5ljwKCccOm5U5
         KRnoHrQqSxUEFXrB63Z6J2XOoRrUX5donRmJgRAeYgeizYKBtX9C0fmMrBVXt+SOPYbS
         Pdg3/jQB1vDPziS1ofhZY3kS1fmxP1Bp530uIbfigrzzfhx9NvPePCqzyV3bf7y4zpfV
         PQdeO6ET9ks85slujNcAjcNPy50nPfGqgwB2p/z9eIWdpxIHqsIFG6RjPls8j2hKw0bK
         +yCTh4Sf3xmXSGy5aOkjatJ0uLQU52n/MfZW6FRa+AeJpxU8fuEvA3oRAnb2xPM+oAuw
         HVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772029542; x=1772634342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFC0QojEPG4lOdIZ8IPpP53jKc6Om2BjnjzFZDb3UgU=;
        b=t+d9d3Eu/gX1xAo1gX5VcWFWYPqGjJvosWTvbX21NLuTBqQDGRy/SCO2f8EoMSO5PL
         BqfdHGoZ62Xg6Kj3OfVKbMl2e8INoyrUyGfkn6YM0jYjRt3y6q5MTLeQ+dERQd0wzNAV
         2qjWXGljEfKprHls5VdPjRa7qWCZ5RwwDw2tb0/o569PPJ1tcMYAKr6pekqwwjg5Mf0D
         JDceGAc4jDDO2QdjwjGHokcGtT0OqNvG+pazNbS+wk5qeohj+QnV5NS7Ihr1pheNk32l
         6iIZgjMnbBX5ofSZkz+/9/A0zOBNAwma/YIIvg9LnutPUx8zWFVxpjV09FN8ZSFq2nzb
         RKLA==
X-Forwarded-Encrypted: i=1; AJvYcCV++eKRdmv4xAbxsiXRBcVQ7/Dmb5QLzLBzDOvXiiQplV3XzHtM4dpcpyUjOT0I/nnw/ptv0s0Syj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOoWNwelMPUenEr4JLAlptJ69qXMBjooXpuFv0LJwWRHEQoBde
	iu9TTz14ZDwpSR45G/2/s7WAr5JE+aOyNDF1OKOEPeMTdv5whhXAMmH+S13tg9Oi2rgeW+VF/6t
	1N0waIdFqWduuSsiUSftGDjoVx/Dwmg6hHXEVTpkOJUY7esvkGtzuHiqv5MeWJOc=
X-Gm-Gg: ATEYQzxufRI6pGNdyfkofS73/qtorwDYzmoulnx/1DmgNfI1nJfaB+coelORbEXVwHV
	eLTnsRNh0TkaOVrKQWwEXsWlhu1Da5MAxN9c7IB29I2o0pTnmhTjdztFMOMnL7fnmsHL+8O9AWW
	Q+A8o/7f/Mg2ZSHz/y8OqlBqZlRyJLQMLof3gR5U8/asN+vfPFarQqoxy9l8dwCcmwxOCeYGUDl
	8igRA5SSQSot+dfAlSLeiFHEp85x6ukFGChTGHV0Zlga4Cg/gNovsFJIccmFu3RfFxhFRBNQo+I
	EYKB6wwp/Uhl1goDLfPY/r8nlMKfZnRooCB3KT5f2BEuDjp8Hp8Au2taklK1+2aCwdVQoP0ZSDg
	DO6cN7P6Cbg8/PgAq8ONAU9/Zj2jU1X3A6HwTXFMkzChgTagPZsoU8JrAnQGbR1OFEH1L8JjKWj
	qrF7s=
X-Received: by 2002:a05:620a:298a:b0:8b2:df32:b900 with SMTP id af79cd13be357-8cb8ca1bec8mr1586510485a.4.1772029542283;
        Wed, 25 Feb 2026 06:25:42 -0800 (PST)
X-Received: by 2002:a05:620a:298a:b0:8b2:df32:b900 with SMTP id af79cd13be357-8cb8ca1bec8mr1586503885a.4.1772029541573;
        Wed, 25 Feb 2026 06:25:41 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e4c27bsm512688666b.39.2026.02.25.06.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:25:40 -0800 (PST)
Message-ID: <143660f3-7379-46e5-95a3-7236bae99b3c@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 15:25:37 +0100
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
 <ac490ba8-18d0-47fc-a662-5a202c5ba95d@oss.qualcomm.com>
 <85bb3a9f-d54a-4b4c-8dbb-6d5461ebb037@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <85bb3a9f-d54a-4b4c-8dbb-6d5461ebb037@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=699f0667 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=NxmpmgPpEGV0oUjcLtEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzOCBTYWx0ZWRfXwVcf5qP2/PfU
 JGEqbKFqtlsVgrIHJbIynxMl3ZQv/LvsPDRQS/gNUhJ/WOh2UFujmJBmIzkkSKXpnXti2s33iLI
 cOuKPJNWvle0bi5AfiyOiSh5yzBaO44Yx6+e//dtG9TThOXXa4VKNfV12oslnvglZm/Mscx9KZh
 8TLSqjitHZlyB/TOxD9FxfieuFkmbSpzYeY6gzp+WfVwC3lAzdZi8bTk7zLkPzuBfeadTrGOWCk
 CPhaJ4nPmKdx0WmUIy9F7QsXs7KFKOdblQ6Mm6CPHBAtbusXlSNcTJFQeG5Z2Qg8/sC/tx8u+Bo
 9WveBk1G7DNQzJBtnAqwVhiNNalRcybtx28gGeCq9EXNZGTrUh/jg/MMFQr36lA4J3HKVvuHQ6A
 CmiaA6AOR2L+0aw5cHrjEVctnNj7nlPwaB+s41fOMs66kplSsKivs+ClsvdoZwuQU/eVCtRLPMi
 tJqWZcepyvV7MSgHiAg==
X-Proofpoint-ORIG-GUID: m48RU5X0qYkTzLpCZyYszwR-vMSRlskp
X-Proofpoint-GUID: m48RU5X0qYkTzLpCZyYszwR-vMSRlskp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250138

On 2/20/26 6:23 AM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 2/17/2026 5:55 PM, Konrad Dybcio wrote:
>> On 2/4/26 6:42 AM, Praveen Talari wrote:
>>> Hi Konrad,
>>>
>>> On 2/3/2026 4:44 PM, Konrad Dybcio wrote:
>>>> On 1/30/26 5:54 PM, Praveen Talari wrote:
>>>>> Hi Konrad
>>>>>
>>>>> On 1/30/2026 5:53 PM, Konrad Dybcio wrote:
>>>>>> On 1/12/26 11:47 AM, Praveen Talari wrote:
>>>>>>> The GENI Serial Engine (SE) drivers (I2C, SPI, and SERIAL) currently
>>>>>>> manage performance levels and operating points directly. This resulting
>>>>>>> in code duplication across drivers. such as configuring a specific level
>>>>>>> or find and apply an OPP based on a clock frequency.
>>>>>>>
>>>>>>> Introduce two new helper APIs, geni_se_set_perf_level() and
>>>>>>> geni_se_set_perf_opp(), addresses this issue by providing a streamlined
>>>>>>> method for the GENI Serial Engine (SE) drivers to find and set the OPP
>>>>>>> based on the desired performance level, thereby eliminating redundancy.
>>>>>>>
>>>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>>>> ---
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> +/**
>>>>>>> + * geni_se_set_perf_level() - Set performance level for GENI SE.
>>>>>>> + * @se: Pointer to the struct geni_se instance.
>>>>>>> + * @level: The desired performance level.
>>>>>>> + *
>>>>>>> + * Sets the performance level by directly calling dev_pm_opp_set_level
>>>>>>> + * on the performance device associated with the SE.
>>>>>>> + *
>>>>>>> + * Return: 0 on success, or a negative error code on failure.
>>>>>>> + */
>>>>>>> +int geni_se_set_perf_level(struct geni_se *se, unsigned long level)
>>>>>>> +{
>>>>>>> +    return dev_pm_opp_set_level(se->pd_list->pd_devs[DOMAIN_IDX_PERF], level);
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(geni_se_set_perf_level);
>>>>>>
>>>>>> This function is never used
>>>>>
>>>>> it will be used by UART driver, not for I2C/SPI.
>>>>
>>>> Adding unused exported symbols is "eeeh"..
>>>
>>> I keep in mind for UART, i have added this API.
>>>>
>>>>>>
>>>>>>> +
>>>>>>> +/**
>>>>>>> + * geni_se_set_perf_opp() - Set performance OPP for GENI SE by frequency.
>>>>>>> + * @se: Pointer to the struct geni_se instance.
>>>>>>> + * @clk_freq: The requested clock frequency.
>>>>>>> + *
>>>>>>> + * Finds the nearest operating performance point (OPP) for the given
>>>>>>> + * clock frequency and applies it to the SE's performance device.
>>>>>>> + *
>>>>>>> + * Return: 0 on success, or a negative error code on failure.
>>>>>>> + */
>>>>>>> +int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)
>>>>>>
>>>>>> I think with the SPI driver in mind (which seems to do a simple rateset
>>>>>
>>>>> APIs were added as generic interfaces shared across I²C/SPI which is specific to firmware control, not Linux control.
>>>>>
>>>>>> for both backends) we could do:
>>>>>>
>>>>>>> +{
>>>>>>> +    struct device *perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
>>>>>>
>>>>>> Then, we can do struct device * perf_dev = se->dev;
>>>>> I don't think, it is needed since this is specific to firmware control, not Linux control.
>>>>
>>>> My point is that it doesn't have to be specific to the auto usecase,
>>>> further commonizing the code.
>>>
>>> This API will not useful for non-auto cases as well.
>>
>> This is only because you make it so, with the above suggestion we could
>> do without the .set_rate abstraction in the SPI driver which only does
>> an opp_set_rate in the generic case
> 
> For the generic .set_rate path (which is managed by Linux), we do more than just call dev_pm_opp_set_rate().

I see, you're right. I glanced over this.

Konrad
