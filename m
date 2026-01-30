Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5A2ECEBB
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792419; cv=none; b=sCTwBQQPHQV0JbFYG3k5vt1en9BsG5cgIUE0AAOoDkagg54zBBZQcOv1YESXT2E/JSlWalAblAqRWfeWqFTPRnVfMTdgNPsUTBr30VgSAN702ud0Uccazg2JrFnNLhs66uUfz0jCcuVz5DGBJpuGMCV4xJhOKSNvkeJsCCh1CgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792419; c=relaxed/simple;
	bh=ds9FPB/5pM/kv71BElJIzPABzsNvdIriGuFb8MtF9aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UC+XjXJxEOSrebM5NDU+vgpbuAUX5/U+0jeStCUkNwaoalxuw4jidLr+TKkGq73mqaPvJECMFwSBvABUQP3ipcld/ezhtQTxrK8/0LTz41vD7MdWtiin2apcVq4ZS6O+/YWXVJo4soLaOMVpK8P6mDK7cnUQ2LRt/dAb83MJNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETVG4Gog; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ij4K67B8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETVG4Gog";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ij4K67B8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAS0DL2992836
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 17:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zb3wuqHKR/ACis16psjpt8hkng4oZUPBMQt0TeF/IN8=; b=ETVG4GoggPSEaYNk
	6YHAzRnjxRiZh7Xx4dz9GvBUz7xr1SdT49lC3wM/p+UWgbGZIERkm9wBRnb18OBX
	/CdEwng+GjYziTZMu5ut41hKvOJfV0BFeNy8vFpOlctpICRlhaPD+ZjnvhA1GDgN
	x1jqq+BjuV6/3GmAPBNTHaGIzEg6g3Fu6aX1baiN71EVT4nAKOY6hrOZXtf8ydui
	nFEXwsIGX7nFfpIlz/VEunlKcyqVOp/6f7ax4DXwKKXxVY4u0jTWBQAUjkd+iWg5
	R9gaM5y6JNnC15HIbSR4gxCmR23Sxt6Op7sTJbeLXcIKC7oii/2kolwnecNEGzAM
	Xi+JoA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0db1kke7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 17:00:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a863be8508so31827885ad.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 09:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769792416; x=1770397216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zb3wuqHKR/ACis16psjpt8hkng4oZUPBMQt0TeF/IN8=;
        b=ij4K67B8W4+zReJoZoHMbVr51iw2mNObc3z+W84NaVYfiq1j8EweEb2i+gV136YQIi
         iy8SDHShVyaRfNoDfqwZV8b489+Q6822Z3HXVRzbrvkVeKICs7wFQhtk391VtV84VEWu
         WFXTi/0qBM6RttE9VYpd3aPKsi88wcz8POyT2iOpq9qPD7KXRvTcKhy82+ZO5lvkaa1J
         hKBnwtlaftXEaig2eSIeLsGn6O6+bspKsTx5h/L11FctdimN/NryleHiOiou0JXy9cGg
         h0RLiYcAg/N7KRdiH3f6ysy6cHStGT2bDwguGDK+9jicsU5nS3yrdshkPcw9Tw9KF4g1
         JJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792416; x=1770397216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zb3wuqHKR/ACis16psjpt8hkng4oZUPBMQt0TeF/IN8=;
        b=vSk8h0WJ/5QTxunAV5hFsBb4bedzX+X5MiUGGFddgS2asSdRo6k71mosmsCWn1SMlT
         VQhuoNfaf67Wj8/8DZbpXQqcFCF4fC1FuZMISIW2OHOiirkkZPXwtCEh6kBNz02iCwFr
         dHGt6tue14H3by/9qJhIrjhPaRojJUtMaqxvY+kVVzdY1TCwZXJB9nxaJblr8vS+m8wV
         iRc5BYt2Axupn/sgD/lNXmBSO1aMqcvLB5XhALTz0Z+qPqgiNr23yxOT2d07dCXw1Y5V
         cPlMTE0wuhLU1XGRdPDM+gsDUybppvdDqEDvORgAw1tvnTxIKIGHRzFRBBm3q3twBp+m
         YY9w==
X-Forwarded-Encrypted: i=1; AJvYcCVeIpRFOpZIENzixGVYg9duS+WnCX8SV+YMRTPBnNL6cwZR4MU8TE3MM8MaoU3TsbpGQoIb8RQsyoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9IqqaXmJZCZuuIcZj3V7UjQO6/IY8EXg4my3iDZisMwbyLCs
	snyvrrLURaPJ4vjCCmHb5WxIHSgC7ggp6vw9GVlmUKv0oe3y93Kuz6pFzvOdpzDXWNlSGhRAQqC
	H5bYhXRZSXuOB2EXsTEI/eZNVkpXppyA0d2sqJavt/rfP8ntSOPiz9BT73CdWCAk=
X-Gm-Gg: AZuq6aKJ7qYfNsuOfrDpS29cmj79bJvD/gCMsKxnYWwVsflHasvQge5KdlNIPS8g6CQ
	0/AjIJBb5APErAvBxXkRfBK3FGx+KwkHHaCcCS+Ebmx6251ypBOfCHlwFGYpjyBfyMaPWvEm4D+
	W1FnmqW8hWLgL96USdnvdvKF9ZOJwiw0V8szZ3KNMzHGHSM3D7UxuX2ff/intl5/vxYrfYqx9JO
	J4UoSudbqg+6mRXrMt/sD0pBwD6ML1s2SgvHFCfMbTOTLhhTpHeuKTYSz+35RejLaJuoUPXDbR2
	zDNsA9OdRKSrTIQkPS2ObAkuR9kNSZOoCP1REpntdH1sP2dfUvJQ7IH9RTYhvI/PQu7sRDc5cm5
	mNvH5StN5Un0g6qkNdTekfTPUwIWNVuyqpet5RRHm
X-Received: by 2002:a17:903:166e:b0:2a7:8bf3:5677 with SMTP id d9443c01a7336-2a8d81bae0cmr34347785ad.59.1769792414700;
        Fri, 30 Jan 2026 09:00:14 -0800 (PST)
X-Received: by 2002:a17:903:166e:b0:2a7:8bf3:5677 with SMTP id d9443c01a7336-2a8d81bae0cmr34347195ad.59.1769792413761;
        Fri, 30 Jan 2026 09:00:13 -0800 (PST)
Received: from [192.168.1.7] ([49.204.111.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3db4sm84917295ad.50.2026.01.30.09.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 09:00:12 -0800 (PST)
Message-ID: <eaed2a51-2efe-44d7-9186-115dfd185a62@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 22:30:04 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] soc: qcom: geni-se: Introduce helper API for
 resource initialization
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
 <20260112104722.591521-4-praveen.talari@oss.qualcomm.com>
 <f3a47ca9-643a-4885-b8cf-0e32c6a1ea2f@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <f3a47ca9-643a-4885-b8cf-0e32c6a1ea2f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jVP5_ZGrsZ8qKqI420_D7_Mrkd0xBhRY
X-Proofpoint-GUID: jVP5_ZGrsZ8qKqI420_D7_Mrkd0xBhRY
X-Authority-Analysis: v=2.4 cv=VMTQXtPX c=1 sm=1 tr=0 ts=697ce3a1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=10aD+GSAjGS7IfLbEAHBKg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=lW4um1KOeupUEvrI7wgA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX34eVEe6W0s1w
 0P/h8cdXE6Q3PZk+LW6Q2gMiXvcKhPtE1GQMJf0j3Hw+Zh3GNoQFw5vaf6vpk9+1CDBDcxBbsBp
 uS2W7kNieAn8nWZ+FIAe0M1yhEE9d2a/JVeHzFnAjSefQtzRS94aAVcTVOVdZ2KMSqNsE0Qik/O
 tOAIa10w1fxdDyXKIztaLgiycDsFxy8SqCS52Vs4pYhjO7OCH0jDg1NgwKsbZ0MCw+QRrHy/Xsd
 EcEBH/EARbPbCXS/vkFqRGaMyFOXAKah4AapsL9nbx4NwJCSLW7RAyXOxQx74LQuOUEXKmsypbR
 TOtTIDGFIYXyv0shpjl44EiQPjNsOOloR0AjqvhdzphiBWKFo9n5hFvERbA4Bq/ERfXTFyK5PRu
 VvUFb6JK4iZNNECres6jByu0Hy8Zyc5fmhAuzdIDv3iZshq2yAE4HwOgXGJPLWI3qA9akDN0p/s
 fZmvYfvS6L+I15wGVCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300139

Hi Konrad

On 1/30/2026 5:40 PM, Konrad Dybcio wrote:
> On 1/12/26 11:47 AM, Praveen Talari wrote:
>> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently duplicate
>> code for initializing shared resources such as clocks and interconnect
>> paths.
>>
>> Introduce a new helper API, geni_se_resources_init(), to centralize this
>> initialization logic, improving modularity and simplifying the probe
>> function.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> v1 -> v2:
>>  From kernel test robot
>> - Updated proper return value for devm_pm_opp_set_clkname()
>> ---
>>   drivers/soc/qcom/qcom-geni-se.c  | 47 ++++++++++++++++++++++++++++++++
>>   include/linux/soc/qcom/geni-se.h |  6 ++++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
>> index b0542f836453..75e722cd1a94 100644
>> --- a/drivers/soc/qcom/qcom-geni-se.c
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/soc/qcom/geni-se.h>
>>   
>>   /**
>> @@ -1012,6 +1013,52 @@ int geni_icc_disable(struct geni_se *se)
>>   }
>>   EXPORT_SYMBOL_GPL(geni_icc_disable);
>>   
>> +/**
>> + * geni_se_resources_init() - Initialize resources for a GENI SE device.
>> + * @se: Pointer to the geni_se structure representing the GENI SE device.
>> + *
>> + * This function initializes various resources required by the GENI Serial Engine
>> + * (SE) device, including clock resources (core and SE clocks), interconnect
>> + * paths for communication.
>> + * It retrieves optional and mandatory clock resources, adds an OF-based
>> + * operating performance point (OPP) table, and sets up interconnect paths
>> + * with default bandwidths. The function also sets a flag (`has_opp`) to
>> + * indicate whether OPP support is available for the device.
>> + *
>> + * Return: 0 on success, or a negative errno on failure.
>> + */
>> +int geni_se_resources_init(struct geni_se *se)
>> +{
>> +	int ret;
>> +
>> +	se->core_clk = devm_clk_get_optional(se->dev, "core");
>> +	if (IS_ERR(se->core_clk))
>> +		return dev_err_probe(se->dev, PTR_ERR(se->core_clk),
>> +				     "Failed to get optional core clk\n");
>> +
>> +	se->clk = devm_clk_get(se->dev, "se");
>> +	if (IS_ERR(se->clk) && !has_acpi_companion(se->dev))
>> +		return dev_err_probe(se->dev, PTR_ERR(se->clk),
>> +				     "Failed to get SE clk\n");
>> +
>> +	ret = devm_pm_opp_set_clkname(se->dev, "se");
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_pm_opp_of_add_table(se->dev);
>> +	if (ret && ret != -ENODEV)
>> +		return dev_err_probe(se->dev, ret, "Failed to add OPP table\n");
>> +
>> +	se->has_opp = (ret == 0);
>> +
>> +	ret = geni_icc_get(se, "qup-memory");
> 
> The second argument is a NOP after patch 1.. originally I think I had a
> cross-subsys patch to get rid of that, neither solution is exactly pretty..

I will drop the second argument once these changes are ported across 
UART and SPI as well.

Thanks,
Praveen Talari

> 
> But otherwise, this looks good
> 
> Konrad

