Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84F12777FC
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049159; cv=none; b=CiLTXjvAIUlSU3g/kLcLUHHmt3gr0nnNNre9SCX2G7ybKCTxJV2sUd+j7AMaEJtu7lSzGMHbL6Mv+XaJBSA2zKDxM7okp/UaNN1zQUGJimVzDlb4EEyKiqmddEqBTrZtcNWEzHU17LvDIuOsaTeuSVtr0xAZyQEPRq+hQQW4Jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049159; c=relaxed/simple;
	bh=C/Jx8VXY0VB9NHAnNRCA/W5f6GCni4C30x/Thr4jUS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjXxLKnSEGuigCCyJj46UTFfquMnSzSSUCuyqn9F5CCog8ehKUCv23B9sEiZWBJ+lFYa1hVmP5PvIWKfwbJ34ltJtD5+vYGx1E70CDq0PDKXg+uzJgZ+OAbtlUD8ytRUnpLDeGzQ5owxZl3klUHc1X0VJ3fMRN5yDANIotmHZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mZh47mdO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dIHNWExW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mZh47mdO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIHNWExW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CVUEt2357132
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 16:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VFoIZ5tK1KlcsQdHdIdlIU8x9jGXAWlRaQS5aGhZ/7E=; b=mZh47mdOYR7hn6V0
	TRoNRKR/iOSV91pKHNmrV1zmd0YP9qgENjMoYuQCtvaZ5981OWZpVFBhRXssahHU
	JvjzkntKmKSuB7f9+DYHe9uhArE1tiMCimYUqbXXn9TzklQ59LFam/8hijUa7UqI
	fdsOLhsHX9dXBYqBUL+TZtOwnYB9gwjqZ6w4d2UJGK41CRxbB5b2yWo6LKU2GHXn
	d3eQMuOnrV2hlEJmEbrgXYdI8gECsHOURD513A1pvOzQJoHKTwY1DP9pAskbSl9N
	lum1FhX3R8p4Wg1PhxJYh5Nt/IdUIorbIRUfmMVQliOOubu/wrIqxmeZk7YhuAZB
	FNjWRQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0m8pfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 16:19:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6366048135so3373168a12.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770049156; x=1770653956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFoIZ5tK1KlcsQdHdIdlIU8x9jGXAWlRaQS5aGhZ/7E=;
        b=dIHNWExWrbfqVKYvbJYhCM7Sf3qVbyAC7vRGn3ksERowQE8YsoaQrgy4Wo6NjvHOUh
         jbE80cgbfuq1yKbZbVdM+dNbKyxgcLue1zI8GgTVIvxuBKyMkNVXWiVvHkv2FxXyUU+H
         XgFyQLGsUnSo+2+++S6I4LqO7KNEX8aIi8DawPZSS0IqqOW9O58kU9DRk1b8MwwfhXpJ
         rZ2p45m1RvAKEQoePfXWM9VGqlD2devMC1FcYFx/ksD2Ueu0YvmRgXnvqhVG4t1hWArL
         bre2+iaTnBFNy2SybtiA/pkv0spU9DyMvc4JW7JD2EZSsKucuwzeMY3bR1BwDFe8d5Zi
         TPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049156; x=1770653956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFoIZ5tK1KlcsQdHdIdlIU8x9jGXAWlRaQS5aGhZ/7E=;
        b=Zkn6VmKr8FxpJElBVA+O2rPKd1RMokdZaw2lGuwHaQn7B9kzqsVNvFWSAsCEQZGKLT
         idiGzf/E9+O9PQi+R3TbFoS2pq97k0GDFiqaZBBdfS040MBQwtsL9MOMSXNynttPbTkr
         ht3OSsLP5zG23iI40cLxTbe5NdzQPZIo/85oyVYsBAdxc3w1KMO+k2LkBiBWx7JMT8AO
         kelrS+eqIVzVZXVsLfXqe4AcYdwZcV0eHYZ9p73IORqihlm6NCciKKaAwZ75aU5+q9aB
         YVRDeoTlx0DSu+8PfpeEnXKXi6/SBMngQw0dCp8E/q4o3XGqv6t75axe1t5DfMxonX3d
         Kj1w==
X-Forwarded-Encrypted: i=1; AJvYcCXW+KZig59JQRuKcHBTXvM9KEQocV3CPH45U+h9v3TdmK+hJPYfdG1+zz4s9LRiF5QuXydMFLpVgNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVv3H4y7jCZpejAeAErbVA+fzNf3M8PgLqh/VXin8ZzKRI4+/p
	Fr8pHhFlzyiBVL7E9j0UozRzO9PzqORu6F00sYf/w7ehXos9UOopLoQ+D4qqd9OqCupUkWFnZwI
	FiDj0gPpl5hrxoZyF0Z3HpKskJhg1xB7wO7kAzSpb6/Jweb4jbheDTZVE1PnAsq4=
X-Gm-Gg: AZuq6aIMjduonzgvf8QSDyuay+gxS0JLDeSnG2aI4YSqgOa0/BFwvZZnrFnZefVPw5n
	mUoubj4KFvwAeQd7PrWzptXgVsGPom2Nt2Gtk8taZT+90AgmB984LafdshMjGmKKzAZapFpU9qd
	7NE3QIAyMR6Mo659QuWFssnbYoKEd6IzBXarBZ1frTblbIBNKcOBZhEZnWAG83yCfvtfSWxhFUN
	9KJvwd1fu8g1uFj/RdIQ2TTQqgI/p5x2BjzYptr335rbzWd7VeAf7k6/Jyvh4GAnEJgb3/IyNeE
	qBQt40avDsgU17Yo8BH3msq+NuFJ4g7OjiciMFDc5NuZtYmNvgHnpp4ZOK823HB1LKnCVlHj3E5
	AxRgwLny94xePXUYH5c4zh0Q3U0r/INkbDcnPygDZ
X-Received: by 2002:a17:903:1905:b0:2a7:ca83:5b61 with SMTP id d9443c01a7336-2a8d98f1f02mr116208975ad.12.1770049155563;
        Mon, 02 Feb 2026 08:19:15 -0800 (PST)
X-Received: by 2002:a17:903:1905:b0:2a7:ca83:5b61 with SMTP id d9443c01a7336-2a8d98f1f02mr116208565ad.12.1770049154943;
        Mon, 02 Feb 2026 08:19:14 -0800 (PST)
Received: from [192.168.1.4] ([49.204.107.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3afdsm145202485ad.61.2026.02.02.08.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 08:19:14 -0800 (PST)
Message-ID: <c0e2a55d-d5d2-4c54-9bba-448443cbfc68@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 21:49:07 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] i2c: qcom-geni: Store of_device_id data in
 driver private struct
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
 <20260112104722.591521-12-praveen.talari@oss.qualcomm.com>
 <0b628651-79ea-4ae1-8898-125beac7a2b7@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <0b628651-79ea-4ae1-8898-125beac7a2b7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dceNHHXe c=1 sm=1 tr=0 ts=6980ce84 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JMgISmeAsz0pT9/O8qDBbw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bzct_qqClQXo_WY-SnsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: NFE2DT_5EDiwszsVm_QpDqcHbTPNyvhu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyOCBTYWx0ZWRfX6MyYYHSEtX9q
 fl2ySPlCMctMEpOPwJCQeSRHE7ggi60B/n6HRxFu4vht39P1cZ8q3cwJiFUe84f3kyNuo8odKAe
 igC+k7AQYbCUchxdEhwWLo9BsDy21RY7nWfQhnHAvhCV6d7pAzLQt8VrM3BzPZ7R7zue0nt8Mw3
 R1Lvq79uamFimlxEZk6fW4mUSJgH/hMe4BFKR4t2UNiF10OwxxG9gjYUKWP0MwQKiKtPBRZaBwi
 Hyak7f7B59aFjPkNV/Yykb9PAS3IqyGy5Tf+LLjSe+d/1CNWu9VnmTBFqBr/Scm4KAzfPsvCrOD
 3GXGeOLMJQnJj2sLSfe2a9cz2M/////GqUYPwj1CvhCwxwh044rk1GG0hdXEq4RCnttOCY3TuMs
 +YNJM24HJF2NriO2Jr/G8EcQaukj4aR2x/4HVRujYRqeJ9lcjD2hlqYHagwEFgiB1RtPFf2HLRx
 SJ40YQ8/aLbPpnF+F+Q==
X-Proofpoint-ORIG-GUID: NFE2DT_5EDiwszsVm_QpDqcHbTPNyvhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020128

Hi Konrad,

On 1/30/2026 5:59 PM, Konrad Dybcio wrote:
> On 1/12/26 11:47 AM, Praveen Talari wrote:
>> To avoid repeatedly fetching and checking platform data across various
>> functions, store the struct of_device_id data directly in the i2c
>> private structure. This change enhances code maintainability and reduces
>> redundancy.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 32 ++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index b0a18e3d57d9..1c9356e13b97 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -77,6 +77,13 @@ enum geni_i2c_err_code {
>>   #define XFER_TIMEOUT		HZ
>>   #define RST_TIMEOUT		HZ
>>   
>> +struct geni_i2c_desc {
>> +	bool has_core_clk;
>> +	char *icc_ddr;
> 
> Again, this should be a NOP after patch 1, that we can drop
Will do in next patch.

Thanks,
Praveen
> 
> Konrad

