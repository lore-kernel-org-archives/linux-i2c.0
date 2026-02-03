Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDCC331213
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117261; cv=none; b=snDGtyOXtEVa2VpUW2b4PeuCcWVt8PkWpT/kbgpj1/NlPEd2F+pZFBK024yaFju9pLtnoKzK0lUbQh0dTEuAayVIu6P4LfO7YGmIbCCF6nMmJMv/X4Dd//dAxrvgDvt2/hQm5w/5iyzNBWo1GTyGEZfk0tQRzAv5GzbtOcGE9C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117261; c=relaxed/simple;
	bh=hE5YmGG7iH5u2PUUIDZLVoAsmcZUgfitPft6rYLloVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrA/7hRxw8ZPH0T3m61vtVF2Wv1EPB4U43m/5NpyWfvvc0uhyksg/iJJV+wqEOmaxRCWHlUPTolFdMbnbriakRywXUM3DvQv3pH33+EDyaoniqtaTPQQecMrvwdkCD0Gm+1Qgnbd6cf9J8w6ff8ZkPE2dEMpg+1a0CB/uCAJXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aE/IbWj4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GU5SXhUi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aE/IbWj4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GU5SXhUi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6139wLhP3388283
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 11:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fqIWeb7+wQWH9tXZxxrOSv9gW7UU4Zw0dIiw7RLktA0=; b=aE/IbWj48X8SyCA8
	WCwZ2VvncBD6CbBGSeaveEEj3h1pNjT5j6eEemFBDbtSMqyCbkkRW9AC92O8Wmp+
	O6Wk+S3v4gTSctcTfRIHNjMFEcJYBRlFhx++dMFL57LJT4+WwvvnQglwT0Bfh3nc
	qIx3K31w7mO3fm3aZD/Qjxy6OubSDz71wslVYJNStERCOL5eWIm2jg5HqqvVGkA6
	eS0DQpvjCGN8hqJQQHeDva8p3THLyBW6Js19Y2mTeJoKnKo5KFyOjER8Vcu7YjcP
	P6kHfoXRSdt/iJz2iJWt5PtnCLsaJe5T7rBtEgR7Bt8JOnemSWk3LtPgbvwjc6Ts
	M2SnwQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2xvbu817-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 11:14:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c7177d4ab4so130950885a.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 03:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770117257; x=1770722057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqIWeb7+wQWH9tXZxxrOSv9gW7UU4Zw0dIiw7RLktA0=;
        b=GU5SXhUiK65Dx1lZis/3lFYl20euEwqLmqBOAadcthmmWt0JNLy42MkOIzNTmsVy8O
         BTKye/mdf+KQQzwqq0pBJvWU9riTYGiq6+8Tx/SPpe4kYnyYtVyUW5PbvTVMRSLUtbiZ
         Pae3UVJ8Q8yVjtyk7keAcLeXLAfMhWuXgkA/d0sIT5nRKUco00KFIuCizJaVBU8YeGzE
         Ote61qnKnGOlk/HLrZVa+UXV0Uw7Bn4wzxuzeJOuj4oB1AH8TJAAZf1Gd+CABICVvtzk
         jrsUL/DdkrWuxqe7kqeB0/FnWFOMdXb416LQamDJwFNIsjVTVpOviH9iMEyzbBMF6xl+
         39GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117258; x=1770722058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqIWeb7+wQWH9tXZxxrOSv9gW7UU4Zw0dIiw7RLktA0=;
        b=OUEKO4sZDaFzWxTYIhgxwTm+OGSzlyH9bDbJR2kzxO9raRNYj1YiQ61e/+RoBdMXJb
         x+pbfmrQRyvfF1hnqH3gkVjxI3eLe2zHyKiaYeMvzERi1Squ3ySL0wk0p68seBc3j8lu
         r3ywxnwJmTDNPAsyShHYj9q0Vo/yKKgR6JVAl0df/k6rQsvgk/fPse/rBj7YnF9djMEu
         mTpBmttu5288O47sL1gpBBbJ01Qm4EghCwIGkg+W4YQlO0q909gia1wiS8eGjhG7BVTi
         43JPK8N6cIIi5O4YnqEPW4ivgLvlxZLeEr5f5QUs62lpojkWlryknVchC30wt/4zIS7F
         xEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjDx6wD2RcW8bx+D3PVJKI3Blh3E/A3IyNYS+yGhBeMqWB8nbi6auS/PcZ0VuXErI1bfubi9XFdLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrMhsKTEfA84Cx6e4EAQufYQyXr+zfmRYG8QDnFeLJDHtgNZa
	AgJNKXjJ9i2yEH5ASdxi/nJZpk8cptKxUqJkzoX0YfN7kHknDZcza1fy6rKKLSaUxQ19WpVBTc4
	bNKQ8ACqGerxfAEYRVI9N4xWHYbPLEsRSTDevxJ79WAqFvL9bdN/a1g3N5SOetro=
X-Gm-Gg: AZuq6aJCDGh52/V+VVu1IVhxIvWHN1XJV1N0+WNVDlIDgLxc7Q7Sj3Ho3sbBSBJKNz+
	4SO1kEaeLmUgC5ljFFFExYITUxWH3bx9Z/NtXZaj3hqrtLtBviikJwtavZZOPpDdXxsdyqgvSaJ
	tuA2kMWalRkxzrmRFajt28JCM5n69Pz2ftm3X8lNE7lk1Fm6ZAAATkEFobBVMb3+NKHqn9JAoO6
	Bn8hiC6bS8bTHCeVoXcJChwf7XhKLDc+KVBTV0WimcFtKm2szdOCwwj1/Wh8Nv1auzVq/dnm+bk
	xw1X7SEhtrvxop0Io6JYRvONOBdb4F+ZpBNbaN/8yDtgz34VqyXwSaCBE4crx/St74tHdziyck+
	dRjA4jBsrgqx+gLvDF0t05eHuT5C1FLfdvptCZZz47AsMkpmf39Bt8DXKrf4+h2spaXE=
X-Received: by 2002:a05:620a:19a7:b0:8be:6733:92b1 with SMTP id af79cd13be357-8c9eb139c25mr1519171685a.0.1770117257541;
        Tue, 03 Feb 2026 03:14:17 -0800 (PST)
X-Received: by 2002:a05:620a:19a7:b0:8be:6733:92b1 with SMTP id af79cd13be357-8c9eb139c25mr1519168185a.0.1770117257008;
        Tue, 03 Feb 2026 03:14:17 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefca54fsm1023572666b.23.2026.02.03.03.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:14:16 -0800 (PST)
Message-ID: <24f967b5-0f15-4aed-a81f-ad54f8e541fa@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 12:14:12 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b918cfa9-1f40-4aee-ad91-d6425798bd07@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: apPhhY8PeiOnL0m34gnNipnWYfRqfMFN
X-Proofpoint-ORIG-GUID: apPhhY8PeiOnL0m34gnNipnWYfRqfMFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4OSBTYWx0ZWRfX59nqJsVrlnkB
 y5zH/k4y36L08SwPK9bPWLm6j+Sl20cG2XBacQvxr3BZLJuBPOqTb2V5ZsYdSBL9ca6nRyb/TPv
 QHFYpDLCvclpMag7XpbHmMEavnVB3pexMoKUPl/en3yDfXR20zx4XXF10+F8GIcgI+KIlvPWDwk
 qkqHaPfJumR3SZNIoRGv0PnBGrcXNCj2J2M4DTC0betRDJfVR5InF/xV86LwU3fK/JgCOQPZnQG
 Nwvf8YzyF/nVxf5ySrTj1XZvQSZMFmB3dwL70jz6m9cRQuLGBhcqvEZcA1OlC08pU0SuEhTun77
 xYV4dVeOg6GJ6aX8cN1WyRWSd86FqPkO55SQm9RKPAq7xHDS5wWDE8EutYvSZKd6f1w4x2ckz75
 4pyOtZWOgjdiiITloEKzRMerkWOJtsXYvahRBsqQYJdZJyUuD730vw65zGO8OLJyL9urE+E/zct
 eLQZsda5eJa6TnecqSA==
X-Authority-Analysis: v=2.4 cv=AurjHe9P c=1 sm=1 tr=0 ts=6981d88a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=OO4x0hjL3wxKXcLKrYEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030089

On 1/30/26 5:54 PM, Praveen Talari wrote:
> Hi Konrad
> 
> On 1/30/2026 5:53 PM, Konrad Dybcio wrote:
>> On 1/12/26 11:47 AM, Praveen Talari wrote:
>>> The GENI Serial Engine (SE) drivers (I2C, SPI, and SERIAL) currently
>>> manage performance levels and operating points directly. This resulting
>>> in code duplication across drivers. such as configuring a specific level
>>> or find and apply an OPP based on a clock frequency.
>>>
>>> Introduce two new helper APIs, geni_se_set_perf_level() and
>>> geni_se_set_perf_opp(), addresses this issue by providing a streamlined
>>> method for the GENI Serial Engine (SE) drivers to find and set the OPP
>>> based on the desired performance level, thereby eliminating redundancy.
>>>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +/**
>>> + * geni_se_set_perf_level() - Set performance level for GENI SE.
>>> + * @se: Pointer to the struct geni_se instance.
>>> + * @level: The desired performance level.
>>> + *
>>> + * Sets the performance level by directly calling dev_pm_opp_set_level
>>> + * on the performance device associated with the SE.
>>> + *
>>> + * Return: 0 on success, or a negative error code on failure.
>>> + */
>>> +int geni_se_set_perf_level(struct geni_se *se, unsigned long level)
>>> +{
>>> +    return dev_pm_opp_set_level(se->pd_list->pd_devs[DOMAIN_IDX_PERF], level);
>>> +}
>>> +EXPORT_SYMBOL_GPL(geni_se_set_perf_level);
>>
>> This function is never used
> 
> it will be used by UART driver, not for I2C/SPI.

Adding unused exported symbols is "eeeh"..

>>
>>> +
>>> +/**
>>> + * geni_se_set_perf_opp() - Set performance OPP for GENI SE by frequency.
>>> + * @se: Pointer to the struct geni_se instance.
>>> + * @clk_freq: The requested clock frequency.
>>> + *
>>> + * Finds the nearest operating performance point (OPP) for the given
>>> + * clock frequency and applies it to the SE's performance device.
>>> + *
>>> + * Return: 0 on success, or a negative error code on failure.
>>> + */
>>> +int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)
>>
>> I think with the SPI driver in mind (which seems to do a simple rateset
> 
> APIs were added as generic interfaces shared across I²C/SPI which is specific to firmware control, not Linux control.
> 
>> for both backends) we could do:
>>
>>> +{
>>> +    struct device *perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
>>
>> Then, we can do struct device * perf_dev = se->dev;
> I don't think, it is needed since this is specific to firmware control, not Linux control.

My point is that it doesn't have to be specific to the auto usecase,
further commonizing the code..

Konrad
