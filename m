Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00983CE0A1
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693595; cv=none; b=B2CDAbB4K1Bs8WTHzsE/U991vR0IEqa0jjGUq2gsn/ZbVFFjv+5D/VeleXOb6gkxLcz+O3sfxAymHJIN0gVW/WjbwAE5bFeg8hvXxTdAUIjJnRXxNbkSeYx3r6LHYMdPuiRo4kq9VuOFTNFEb1vSqeW/+Rt8M04XlFnydAP+UFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693595; c=relaxed/simple;
	bh=a5gc0uCdQe9/5DFJrAShKQrfw81He2Dn2U9WGVp3XB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5b2sLDNJhrIlAw5vfdIHeXk5P4IzC095yzbWDs0mWNv2z0ss+LeLj0yozGeoZQNRDW3tG5pmTD/CDIXwz5ivYRyzRFjJ9SvFj0JNezYKGF9FahnA0EzZVJdUMk2Sb/GavIOhATcyyQOhl6TybmMIURBGOZYTShZxomvFEGve8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LxE51Xik; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bwWsFulM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LxE51Xik";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bwWsFulM"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P3Zt4h981344
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 07:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MxI111Tk2C3/6cjEtvMbYrAZgT7NZnITlSROWVUr89k=; b=LxE51Xik4Aff1NH/
	sB30QEUnEG/p4C6471ZbfEZJ7FXfCuZGd0xT2GhjgvPHQS6QXTVURoJ0lKhZK95A
	DtAqqsnSQ5aPZoZCVcel+Z6ZkA4du16hcxsHO4WSPMY40lZIZe8Ten5TfAfhSzlO
	cVIQaDtGWv2z2diYDRxpVbJnnbnMYrqHE4od/XX7HUA2PTJM9YMaCJJW9P1zPe0v
	Kq7LKonaHl9x8DHaMWu4/bS8/Ht2jEjH3WDR5ddq3bNxXVO0BMnv+Gkd4tfglzWd
	YoTuCCZBLbosCDAH7hYGEOcuWBl2qo5R3GjYbLJHm17Mb4vQOmzcomaDnIbvWklw
	m7A04Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb386nr0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 07:19:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd6aeb3637so225404185ad.2
        for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779693592; x=1780298392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxI111Tk2C3/6cjEtvMbYrAZgT7NZnITlSROWVUr89k=;
        b=bwWsFulMwiSuCfIq7Og4lqHNNLE3dcbJj+pLNEiINZuqX/lY67YCfuAZvKpWNos6XE
         ohWNZQplmJi2OP8iSoG59aIZLHCJAc/UZe5X+Iak/hPoC8i470b93d75H+p+PSaYZFJB
         MUYQ9b+zh2fPP6DHM5KnqUo6i/3zGASZlDTyg+dLsd46HtacSN4snl6z8Aj8Qt0vwQZi
         DqXX7lJ2qcte3UWNVmOnEUZw+g4m2B1YQJS6If3iadDcC6wIjzTKrIZCKWYTHFkRIMTj
         jPdOdv3D4xMDkYLXvaDqz1J7XjPblhCdvDZAPNdNSQdy+SrrWKSGB63tRdxOTIzYQaDC
         u/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693592; x=1780298392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxI111Tk2C3/6cjEtvMbYrAZgT7NZnITlSROWVUr89k=;
        b=o9KPV+jWRFXR1NnGVkC63sDBTawtFi3WBM1t/6yRImjEMmD1anCNMOzca0l04grxo6
         nyxElIqenfcBj6hEOwj5JFHvKlICISCu348Jfmx+d+q4ZKxZmcpT9cBbDebVtyhDpBYq
         HXoeqZql5AMzmITnMCCvZH6PED3Ulk4IB76sKdsmGLET0b30fEOr5ZJD4XbqQPNAcIIs
         AaXt057mm4hvhPz+oesczYO+1ULhvXSwx9K3qPOGvAngrKoF7AoUDfyk7zXmyM/f+ApJ
         mDS2JyRpgfkhKTcYm6aLt7hf9NbCzCK0sbPf2lpvR2iScs6ErPxs8ZqZgbbe7XwtKiCF
         I2Kg==
X-Forwarded-Encrypted: i=1; AFNElJ+IuvQ7UcUhXUQiJ93y2O//9i5HoxlNgKRhTLi4jExLM1sOt1limArGQUQ1otZ0dJE949sIY2d7GlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4xo6b6+lnKmmMmad5zXSmCqL+WXWjqB52xgox+dRKyoIIOlT4
	eMwLGIFDyk3x63RUZ9tpXGxzfhPYZzYKUr403lG46eSUmgupI+UJugmqCHRloNJCrWIuMU8HST0
	qNMS0wXAqalyadu9qKoMLU8dWdeFWHRkRuRIJx/TXgUXcWIgxoSQ3Khqj6IKd/hk=
X-Gm-Gg: Acq92OEkO2o+GRRAxipJOPOP4+OjPdhbHNLEYf4U9l3RGXHHIpjCRG4/HGFXWxNiky9
	r4HSSssUcgRRdmgYw5YCu4msMwP5sJGt50+ZyAtGLqxm638MlCLGdpHkXw3Y2m/GHIJhivd/g3E
	iWHrpDXe8CyRZPd1txlmVSZyBK9qDR1CkY1Fcfz3veBV8eENYezBTNyXGb1jp52lHdzK9g7wGAT
	917sRYFnV0xHvlZXitWkJzhvhR60ODqZfb37OdpBnkrJEXiCb+dsippvKei8j9bdRHJXwXO5+7O
	h8K1288qdP56MpDodWDyNWELB2BLKkTiYY19XwYsPiIEAenZKDAuVpp2yO/f39ywvpANzzbgVhC
	UOOSRUrC4IUj66OZFiLS2mhZzeIG7Nzz0IZOiAHwTTByvqFTIiIlgBw==
X-Received: by 2002:a17:903:1aae:b0:2b9:5d1b:73da with SMTP id d9443c01a7336-2beb0741079mr150386785ad.30.1779693591586;
        Mon, 25 May 2026 00:19:51 -0700 (PDT)
X-Received: by 2002:a17:903:1aae:b0:2b9:5d1b:73da with SMTP id d9443c01a7336-2beb0741079mr150386515ad.30.1779693591010;
        Mon, 25 May 2026 00:19:51 -0700 (PDT)
Received: from [10.92.183.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f54sm87935705ad.10.2026.05.25.00.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:19:50 -0700 (PDT)
Message-ID: <fc30805c-b9e0-4fb1-8769-c7b995310556@oss.qualcomm.com>
Date: Mon, 25 May 2026 12:49:43 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
To: Bjorn Andersson <andersson@kernel.org>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
References: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
 <20260423145705.545552-5-mukesh.savaliya@oss.qualcomm.com>
 <ag_Ig7aQNNakiry_@baldur>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ag_Ig7aQNNakiry_@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KFmp3LyulfYQSiyfVBN_36ir6V7XaSrE
X-Proofpoint-GUID: KFmp3LyulfYQSiyfVBN_36ir6V7XaSrE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA3MSBTYWx0ZWRfX1TwBIhOR7ytd
 2iOf6BiIdJfeDMPn+0QhQXOrE2MVuYKT7WEHjb6KOCniapo4klLi+kwMrQhfGADR6rXKBKhHcSm
 Fem+6koCX0PXvPbzTEv9dYAOeB1uDeKMQKOMXTmNXRPwp0wtmPYKuA4GXjix0U2mQQ1/Myruf0h
 a8rj7klnzApoMWhwvUIitAzhDivTH313asFhmWxVc2fl179QGgn/gwsGNhAAH6a2g6NeAVAUuI5
 brpK1NwMH1kPZBLMCzbZf9MxbkuoIrbVEcW96soxUztwB8aiyOoz1im6J8jwF2f/yS0bVYmQjzn
 IRla4CRvWMn3xSpxi5hWIjEphdVJAQIkDxPmDD5jOuuBgN5tubVQKHWbb2Jo0b+mz4OxhbeRfDJ
 LSGGBxdKCZKoNmZPj0WVme0oQOh+W4ZZn4a0wQTM6TcCipkzpBw9Ibz2sA5RLoEDCsdaqiRHqFN
 5MjUpXV//XOGsA+UK1A==
X-Authority-Analysis: v=2.4 cv=PJY/P/qC c=1 sm=1 tr=0 ts=6a13f818 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=7O1uvCrluarMPFSrEYwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250071

Thanks for the detailed review, Bjorn.

On 5/22/2026 8:45 AM, Bjorn Andersson wrote:
> On Thu, Apr 23, 2026 at 08:25:51PM +0530, Mukesh Kumar Savaliya wrote:
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
> 
> "For GPI mode transfers" is there any other form?
> 

Good point. The lock/unlock sequencing is only relevant when the
controller operates in GPI DMA mode. In FIFO mode the transfer path
does not go through the GPI engine, so this mechanism does not apply.

Let me clarify this wording in the commit message to make it explicit.

>> driver by setting a single lock_action selector per message, emitting lock
>> before the first message and unlock after the last message (handling the
>> single-message case as well). This serializes access to the shared
>> controller without requiring message-position flags to be passed into the
>> DMA engine layer.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index ae609bdd2ec4..a396ddc7d8f4 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -815,6 +815,14 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
>>   		if (i < num - 1)
>>   			peripheral.stretch = 1;
>>   
>> +		peripheral.lock_action = GPI_LOCK_NONE;
>> +		if (gi2c->se.multi_owner) {
>> +			if (i == 0)
>> +				peripheral.lock_action = GPI_LOCK_ACQUIRE;
>> +			else if (i == num - 1)
>> +				peripheral.lock_action = GPI_LOCK_RELEASE;
> 
> You say above that single-messages case is handled, but if num == 1 then
> we will hit i == 0, set the acquire, we will not hit else, and then we
> will exit the loop. What am I missing?
> 

You are right, the current implementation does not handle the
single-message case correctly. In that case we need both acquire
and release for the same message.

I will fix this by explicitly handling the num == 1 case and setting
both lock and unlock for that transfer.

>> +		}
>> +
>>   		peripheral.addr = msgs[i].addr;
>>   		if (i > 0 && (!(msgs[i].flags & I2C_M_RD)))
>>   			peripheral.multi_msg = false;
>> @@ -1014,6 +1022,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
>>   	}
>>   
>> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
>> +		gi2c->se.multi_owner = true;
> 
> gi2c->se.multi_owner = of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner");
> 

Agreed, this can be simplified. I will update accordingly.

>> +		dev_dbg(&pdev->dev, "I2C controller is shared with another system processor\n");
>> +	}
>> +
>>   	if (has_acpi_companion(dev))
>>   		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(dev));
>>   
>> @@ -1089,7 +1102,9 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	if (fifo_disable) {
>> -		/* FIFO is disabled, so we can only use GPI DMA */
>> +		/* FIFO is disabled, so we can only use GPI DMA.
> 
> That's not how we format comments outside the network subsystem.
> 

Ack, I will fix the comment formatting.

> Regards,
> Bjorn
> 
>> +		 * SE can be shared in GSI mode between subsystems, each SS owns a GPII.
>> +		 */
>>   		gi2c->gpi_mode = true;
>>   		ret = setup_gpi_dma(gi2c);
>>   		if (ret)
>> @@ -1098,6 +1113,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
>>   	} else {
>>   		gi2c->gpi_mode = false;
>> +
>> +		if (gi2c->se.multi_owner)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "I2C sharing not supported in non GSI mode\n");
>> +
>>   		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
>>   
>>   		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
>> -- 
>> 2.43.0
>>

