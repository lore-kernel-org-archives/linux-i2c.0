Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655ED34251F
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513687; cv=none; b=cZa+KT4yKuE0WctSMlkXZsfyfrxZzJqiii7C01pr9eYwTIgtO3Y0gz8qguUacvHZEz3/Pj6/gvSnPDkCIzW9gfQOLY6CsqRR02WqBO/JKJjPgvpTyLihB2/nAS278pyNghRSGL7V78+Nc1Q6TrfM6eRBof+vlIH8hrKEHjB50lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513687; c=relaxed/simple;
	bh=EVoihKojuEBgZvFeCFVGBiCKXa/yYEOx+jT8RfWk3xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8uUSqzc08S557pgjJo+Ic5AuG2rwehF4rHSgF8MSLsUyGj6PB1GNv1swMdZxfWHQB26quon2/9G7uFGeZrvpa+Ex2zR0Cp9O7RCk1AMBgV18mTpw8ziFqEpl7TAgxq9v4T84OqvrX131iH5XA8Sj+iUsL1NA/FlFJkDt3vuUjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N9rVdHli; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QNGXRedF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N9rVdHli";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QNGXRedF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JBNOhA3566862
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 15:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T7C6zI9G/gF88X8eI0AyLZyqP690jcfAito++UcfSEc=; b=N9rVdHli2mD/kbKi
	cpFSX/VWgXg4+hiKZ5Ch8jmeBwELz5PtH3cglBYmBoOe+oxL4O1GyEpV/YboWXKO
	sAAgaN2i5gNWAmFcf+s48n20WGopMCETeTMds5D/TLmPem98uXvLaQNnCdsAes/3
	pDEGU56gGZUmQbu85jeimLkV0G0j2h5R+8ly8xy4JLPT50gerzo/teBq5nQfS7HW
	3EnrQ0pZxCpga0MWmRrN3odA2eH/9BQ2Dz/ofmTFSKMk8yJTeFab7RFmylOOOeVU
	8Xocul1/mDj/UvM9ndef1n9+/8Zgt2WwwL+EJl9vv4j28dvTszPqLRWsAzUw7UaS
	pxSKug==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce1k80mxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 15:08:05 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5fc58a4122eso120130137.3
        for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 07:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771513685; x=1772118485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7C6zI9G/gF88X8eI0AyLZyqP690jcfAito++UcfSEc=;
        b=QNGXRedF5H6aRb7irHyylJWsMWjvpShIM+iiJ/HuHosmIyurLq3hqzlR+3suPiUj5s
         jOOUTtNGG+AV3TpA0KKItrgbKGV+ayLfOZKOTPivS/gfaJsvJys9ckkX8e7hUzQrCs/U
         /qDEMGYbPUzj3W1Fg4Luy3s+6TKE7PiIDmPLU4QqlQKr1OP9QbeC9u+q9CAIwvL2OOx8
         Fnd5XT1C5iFIVHR/L3pf/h7A7DK1opjlDgLx07Y9cllhijj0U8LycMtTqwcAfsU50MMw
         iJqnlv47wpbINwFtlYhJmBQcQ9y+5BrRnCUxMSyOHSOjxjQP5tvzozqLne5l72cHTtQI
         JtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513685; x=1772118485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7C6zI9G/gF88X8eI0AyLZyqP690jcfAito++UcfSEc=;
        b=W/pVrkDwT/PUSlwryD4mfHKoTKSEJ8mNjXZKtY+WAce2uYbVykvDv3jH9dn8YmJbMa
         mg/OtgLg5ik5Z0pWT98KEmRo3aWxUau0BFl9KyMBGP5VgmThEsPAad6cES5WeW/zYDRC
         1mrqUVWKziYnHCD9/mjw3TXTGx+w2LBmIhGeJAt/diRfYUtBI+3MoGiRVr1ZIshotqaW
         9GkFju0yz4HDS+hbd/1ZoqcJpS4/oPsZnTbJ6cb1rDZepioobiO20Z7F8RwhoBaalDUF
         LzlfFWTFaHEgaer0gCl7VFGY94zdLCq0kuGe6yHm4G3d8mdp+Y565OPQuxFqGWxbifqA
         PGcA==
X-Forwarded-Encrypted: i=1; AJvYcCUJEwBINVDZKUlZrwUqfzKo9NgHhz3GEaUZHE2wSk9OtrCfuNm7GtwQdWc01kvwpGnH0dv2Ef4VsEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Uof1pYH6z1IuibHVwT0FU7mSeLaZM1iLsdLebbVfYBePVYyh
	Bc0j/buUO9T+frxfqH4TnA68JAXixzZEWmNFKcIbOz9oLCL890eBQe3RhxgdTH0A7zxTQLbZpLB
	pXozoIUkojP3qTET5G/miEMlVkNvpsCeU0b4D6QyA4ntYmHO0kb/j/Wet52qFGzI=
X-Gm-Gg: AZuq6aIh0IT25w9IGdo7EIvT1X9seX179AS/UM6MMy7mivjDnjw0CH6MCKosfPgGZLe
	gRw27RZlSFG2eoyIx9YT1p870Ld5QAMHMACWNOii21tTyj+GB2MCcWcwp2gs0IYU47zafuzU2Yv
	j7Qr+LV7rErB/3JqswOkzQiDIjMLhn8sRWwIGqpGovgRNVEhxwObTPuUuO703Hj4LvfuG0wiJK+
	ttEhxbr/OFAJCEF5ImVRJELWSmSo3sXjGl8OS88HVhVfbyVyd2CPLHmDwK9W9ANiTWMCJoRMiRF
	1uoFk9/6+WITJO7AF0VZXGltFDl3KY/Ac5CF3Ly5Q4JrbxlWJHyC2QPmG+JDPYakliRZi/4nS/P
	Nly6KfI96bP4FJcLpcBuKfHtvXULQmG1q286VOAN/HmElNIVMLh4gTTQf1IaER/9GHcKRNllJJ5
	oU5MM=
X-Received: by 2002:a05:6102:d8e:b0:5fd:a537:a776 with SMTP id ada2fe7eead31-5fe16f8883amr4495391137.8.1771513684630;
        Thu, 19 Feb 2026 07:08:04 -0800 (PST)
X-Received: by 2002:a05:6102:d8e:b0:5fd:a537:a776 with SMTP id ada2fe7eead31-5fe16f8883amr4495354137.8.1771513684041;
        Thu, 19 Feb 2026 07:08:04 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc73f7c24sm587514366b.30.2026.02.19.07.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 07:08:03 -0800 (PST)
Message-ID: <17440856-79c1-4ded-a48a-701e66dfb3a6@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 16:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/13] soc: qcom: geni-se: Introduce helper API for
 attaching power domains
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
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-7-praveen.talari@oss.qualcomm.com>
 <119f619e-9f3d-4c21-8cf1-a8b4e1024ed2@oss.qualcomm.com>
 <6acfbc33-cdeb-44ce-8f80-90dc18573464@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6acfbc33-cdeb-44ce-8f80-90dc18573464@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SY7ZgNAojsgFWKqpf7pIsrpgFtipqa91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEzOCBTYWx0ZWRfX9NHX97I4q2mb
 pXEHgRja5qZ6ntmMt5EpeIL6WwTyjyMdliKy56JHOkus01rz7wOa70BxncleVZYSDYzzczU8kFf
 5joX3rAprG/1bYEIM1z8wc1xRd9y+j1QhNonwyAGXkmQKIbt5YgbD38e51dilP4EA40Rw5VssQ6
 RP99+QoIWMQAa46flmQHLJbYpOaBl07/zL/yvbF5nwgWZEcomckdAjPrrgX1PWmcsjIueptSzni
 mA4IVrxGB+pRiceMgrdG01DAt92tGcF2R5I+sMXgtJ6dIOGrDV3ZR/PUOa9h0EKhVXTgNkHqyQe
 /wwzvLfUX9LgTp7bhEkFY6538mnyQtpdBKfppu0zbQ7Nt4TRWkE09xtNcLHq4ZMs8iaGtYi8Ln/
 ehvEE0fDWcwcQ63/m8X03IHgKY6GqxsjEkd3EvdxdO2xdWslepnxIxkSpnZZwoVWNu5TdTMZjoo
 W1MJONh20EcYdYZN9GA==
X-Authority-Analysis: v=2.4 cv=cdrfb3DM c=1 sm=1 tr=0 ts=69972755 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=aPOBDM_AZRC3x_6TR8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: SY7ZgNAojsgFWKqpf7pIsrpgFtipqa91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190138

On 2/19/26 3:58 PM, Praveen Talari wrote:
> Hi
> 
> On 2/17/2026 5:09 PM, Konrad Dybcio wrote:
>> On 2/6/26 6:41 PM, Praveen Talari wrote:
>>> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
>>> the attachment of power domains. This often leads to duplicated code
>>> logic across different driver probe functions.
>>>
>>> Introduce a new helper API, geni_se_domain_attach(), to centralize
>>> the logic for attaching "power" and "perf" domains to the GENI SE
>>> device.
>>>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +int geni_se_domain_attach(struct geni_se *se)
>>> +{
>>> +    struct dev_pm_domain_attach_data pd_data = {
>>> +        .pd_flags = PD_FLAG_DEV_LINK_ON,
>>> +        .pd_names = (const char*[]) { "power", "perf" },
>>> +        .num_pd_names = 2,
>>> +    };
>>> +    int ret;
>>> +
>>> +    ret = devm_pm_domain_attach_list(se->dev,
>>> +                     &pd_data, &se->pd_list);
>>> +    if (ret <= 0)
>>> +        return -EINVAL;
>>
>> I think we should preserve the original retval for the < 0 cases
>>
>> For == 0, this can mean a number of different things.. but in this
>> specific case (where we always set pd_data.num_pd_names == 2) it seems
>> that it would only be an issue if dev->of_node == NULL, at which point
>> this function would have never been called
> 
> I hope the below is acceptable.
> 
> +int geni_se_domain_attach(struct geni_se *se)
> +{
> +       struct dev_pm_domain_attach_data pd_data = {
> +               .pd_flags = PD_FLAG_DEV_LINK_ON,
> +               .pd_names = (const char*[]) { "power", "perf" },
> +               .num_pd_names = 2,
> +       };
> +       int ret;
> +
> +       ret = devm_pm_domain_attach_list(se->dev,
> +                                        &pd_data, &se->pd_list);
> +       if (ret == 0)
> +               return -ENODEV;
> +       else if (ret < 0)
> +               return ret;

Yeah, thanks!

Konrad
