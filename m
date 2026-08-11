Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51892750E6
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452185; cv=none; b=IMiHleS1E+6qV4CXMlbJySvtk+4b6iOLVIu+xrtDxEGdUafbiygPWsEvEr2MQ5v1nQ2mFBmq4VwjNHWgzWHWChOrQD9WObSGJtNo9bpdSZd0sXD1F6xx1l9KcNa12+mKv1/UkrJvMMQpwglAyVU8GP61x1ZLkMNkOL3NMyKniTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452185; c=relaxed/simple;
	bh=607fsFnHeMxAOGrNAF2iXSXzkDFDrhSLkNg5imN0llw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ushCDBcucoUUzDXhm40Jm5v5n6z2Z0srbo99ubgEh+V6EKw5OftDvK6ocGX20b+HvZz8WFUW6RR4DvaTjDjpKJ6FkfgT6Ct6NfTo3FqxKvPxK0IvS17fzlBAIeWQx0pvXMgxa2176T1LK33nb2fDAnAT6ymPlGAefblorMdgMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvI20t8W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hdoRHHkP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvI20t8W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdoRHHkP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCRQwT664132
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EdNNX4o1+f/fl3ybaHbSJyRw8FBKGT34Noiqeikd6gg=; b=PvI20t8W815Ld19Z
	V8qu4hMi/QjMWMXGavHZl200X2OMqKKQcyw25fxjAGg3ZCGZ4AAHJmPbeEes5iPH
	ZMqFVvq/xIuoCrxa/yiL10A1f0HPRJNbdxRI8ou/u3XeEvxkVFPEENuimMYc37Fu
	jgVuluO6AVa/4AYVDYCO3zy4yDFp/8UKqLlSb/cGZafMPeyhW0JoIW8KJfuZSRob
	0oVecqzP6gM0KVZAdtPjmcLWjVGdM1pTpWMVVMyQJAh1Z2H+cyKp+Oj197V4hD36
	K2k7Y09f4PLwR4+KPl+OtT3LKOqz+qA9ViDnLGb8sTTS8xoeW28oJ2i4ZYS1b/kN
	N7RviQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjk2460u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:43:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so65102685ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786452182; x=1787056982; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdNNX4o1+f/fl3ybaHbSJyRw8FBKGT34Noiqeikd6gg=;
        b=hdoRHHkPdM3DoxEXR/ImvgUdyz4Hh59x/zgnT9zVwskhd8oTq0eKVgSbnlmZUqAcHW
         9HBsZx6eInP261MfaUoIiO+53HpeaDQMMHXcvTSrejO+p+pJwrpB0PWNI2MD0POAX7nx
         W06A4/L20ZvHVsPKs4QmUb3iXUdnvBVYSmLHMCaWDD1OVJEHp6R+uhqVyH06Kog8yqLP
         kXlZykUa3GqcCle8Rfc/gFc3pv06oTpWDUvJJViDg+6ulNBXcnS42B+nko4+pD1Wbrap
         7X9B8O5Mi86nvnjZW7K/1/eY4DfJTyOPW6Z3blsT2Kyw9Wr5OJTet/cjVF3PQ1KZoHzj
         dINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452182; x=1787056982;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdNNX4o1+f/fl3ybaHbSJyRw8FBKGT34Noiqeikd6gg=;
        b=s3VjwjK9W2bkju/Ezs3RQgtNPAN/Lw4egczKgnw5hnyVu00UqCDVov60aHzxroYAUB
         +IfPuFya4gRZsKtaeX8FXl/tbqXKSUkP+j782mw0/VPNHYvNpzJOXTPnrwYgO1j7V7vY
         4UBfwaKwBwrTn11T/jS/zRd7rOMP7e+VwWv4rmusUVoyJEyMGPBlFdsM2rWiC7zctTDV
         Pub9fTVMBEP2PVEbHQO1PzqQuwAKYTVL1aMtNsAUnrhJL+EOw+sbTfq3xJYm3Jmo/pGc
         gGlSmt5N3jVNYXk+Y8Fk2Pqq080LgDjGeHGoODDZDfgGqayAHB7ERijTFGP9fvN2bdtX
         hqoA==
X-Forwarded-Encrypted: i=1; AHgh+RoPn8akAfEGFuyFflbil2AjVE+D61WYGYmznabhyWglqwAHSxz0eg8tRCPikuPS8qHJguGtH+UsQI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ruVYYzoV2V1ObCMRb/0fX9FBQ4WzWrKHyoNHh+BePpM/yhY2
	xdu8hdvDXDnCWHrGhU39BxM24zZcLFx/oqhYJdN9upp71UasiTR84jq0vLIFEgq8q8W0g4/pC93
	zb5fsS6N9wid8ofg0jNwvjOx5KsxOOofnTFZltYHFZULNo95f3Vomb/oHGNoIoF0=
X-Gm-Gg: AR+sD11qNFvWkrhKMwbgpsIuolBLQ4bUcvo35K8LroTD0BTdHwkewK6Kpum4RIzkyvi
	X2r3rosaIVAU1YygqlOks0BT48WB/nDUb0uSxPEb5vAf5g7F/xh8pn/EzRJzql+oFf2PWOFRE7P
	/qRgIE/jEcUk0SySthd3uxeCo/bFRw2s3ENBM29r2ghIq2YZ3wwwBEm81v0nfngvcWU8BjR3rE8
	wjAQVmZiH04fzrWz2k1tpvMEtfqUTbL8UasoBtU8JtCkWrlJxk310Rgx2+AiMHDv24B6SA08wtf
	78ezFB62otYERhfH6uvuC6e3/NaebpAIFmY1FAeZ5D+0bvNePgUbOYHcX02unGmWyXKk+VlCsOh
	JjoSnjLPohUnuKKj8GXjcjYG1ECBjiZRO+97AUTG31ZMOUizVqDP5d12yVeLWZWjr6i8vyxt5
X-Received: by 2002:a17:902:d2cd:b0:2d0:4021:bb62 with SMTP id d9443c01a7336-2d3178d358fmr33259495ad.16.1786452182249;
        Tue, 11 Aug 2026 05:43:02 -0700 (PDT)
X-Received: by 2002:a17:902:d2cd:b0:2d0:4021:bb62 with SMTP id d9443c01a7336-2d3178d358fmr33258695ad.16.1786452181677;
        Tue, 11 Aug 2026 05:43:01 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:973e:782a:16ef:897c:10dd? ([2401:4900:1cb5:973e:782a:16ef:897c:10dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef0ab2sm7377085ad.13.2026.08.11.05.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:43:01 -0700 (PDT)
Message-ID: <962122da-47cd-4325-9ced-ecbee2281580@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 18:12:55 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i2c: qcom-geni: Add I2C frequency table for
 firmware-based SEs
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
 <20260811-ipq5424_i2c_scl_updates-v1-2-bddcb2ceebda@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260811-ipq5424_i2c_scl_updates-v1-2-bddcb2ceebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfXz2Dj6HRqAEPF
 R/dY0i8/Hb05jR+NFBfy53e9b+Nyd02Fj0nRrz9UPqViCAw30ZhzoosNE6nFA7QRilnwO0ZBVR4
 73D9QmacO+gN2lSzIfr+0XwtNkdMLn8=
X-Proofpoint-GUID: LIbpJxmOGzmMoCVdxcCkE1b9kwJJ_use
X-Proofpoint-ORIG-GUID: LIbpJxmOGzmMoCVdxcCkE1b9kwJJ_use
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfXySekvu75tt5X
 /evJ1yOhg9DrUplszvT/9myiwYliDC+ml9gf/18XBcUbjebnP3UaQ+bKmHrrd1Epr6s5vPZ4O+I
 kV1zpV3ahj8MHQqZ+/qZ62/7EURwdmzF0Xn/9pfjBKJj9ZyxYTEkLHXMKC4M07drb6YyOFIZSTd
 O5U9gZcBx0cRAtM2UDU4p/Lkd++FEESDfnjncf9afKSHYEptnTnXMEOUPVj3PTKLzza98Lniv8r
 egGnBjzMg+umSskPV2e1MVL7uzYgPXBmvthNCmGOsCwODk27g1pVHXEnwJu+Jlud8MU3v7ntTRB
 bXb7xD/4OROE7xpRNd7KcYUSmudh1yLcJz574fQJjqSqBmfewblkNw6NdOVdqKAjlmqSMI8u0/z
 IyIB7wA0vwoygPlyKGhVNgpzwy5yVmw7hfmwomvCx0rOqPGhxAfD8riBy6LjuQ3XyQPtz2ry/7F
 f3+igR/43CyYzZ3W0eg==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=6a7b18d6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=GgOkKcAal0c4t4REf8wA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110106



On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
> On IPQ5424, RTL-based I2C can be supported by both minicore and firmware
> based SEs. For firmware-based SEs, use different SCL settings as
> recommended by the design team. Introduce a separate table for the same.
> 
> Identify whether the SE is minicore or firmware-based and select the
what is minicore ? Please Make it upstream specific, RTL hardened or 
define minicore first.
> appropriate frequency table to achieve the desired bus frequencies.
> 
> Move geni_i2c_clk_map_idx() from geni_i2c_resources_init() to
> geni_i2c_init() to ensure SE_HW_PARAM_2 is accessed only after the
Reasoning required - why only for 32 MHz ? OR better reasoning for 32Mhz 
support related changes.
> required clocks have been enabled.
> 

I suggest to add 32Mhz support as this is already having 19.2MHz 
support. Subject shows generic frequency support sounding like no 
support present.

> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 23 +++++++++++++++++------
>   include/linux/soc/qcom/geni-se.h   |  1 +
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 00013b41a6f5..2f3026602c0c 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -194,12 +194,21 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
rename to _minicore ?
>   	{}
>   };
>   
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz_fwcore[] = {
> +	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 25 },
> +	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 18 },
> +	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 6, 15, 29 },
> +	{}
> +};
> +
>   static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>   {
>   	const struct geni_i2c_clk_fld *itr;
> +	bool is_minicore = FIELD_GET(GEN_USE_MINICORES,
> +				     readl_relaxed(gi2c->se.base + SE_HW_PARAM_2));
>   
>   	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
> -		itr = geni_i2c_clk_map_32mhz;
> +		itr = is_minicore ? geni_i2c_clk_map_32mhz : geni_i2c_clk_map_32mhz_fwcore;
_minicore with above table renamed.
>   	else
>   		itr = geni_i2c_clk_map_19p2mhz;
>   
> @@ -1046,6 +1055,13 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
[...]
