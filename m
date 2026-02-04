Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E34B2E2F1F
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 05:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181849; cv=none; b=DPwWepmAFEO5bAw+Qh5xEm2e5h3Pgz1a6aXkPjKpIi3vj6U32k30/TFmhsrCeUEfIyB17nf/DhpL0UjIUq81zId0ZuIWIWdHx5nYCFCsggZ1dRdRscEin8I7vIyeYKz/V3M9HRXG/YLeC6Avf42qnjBUaWYB1XA0n36V64k+IpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181849; c=relaxed/simple;
	bh=Cl8nmQiPPZ3zMD2xLWnUAdj/4XyXZt4JU5y4x0hFQpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHH097Hv6vCXvmdhhwqCkm5j4NMLwX63Cn6iIKs7qacX1AjWcENKyeD922b3AzH3SstxFifbq+zQ/12N/RLSd5lLdaD8lqC7lPCs1HSgq5Onu/fkQlKDTxTJRvGNlWiBzp++O/BcCsYTqmj/aIqIJrvui/pgXPZ/yGRTUfrHwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTZtq4MM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGhj9VRL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PTZtq4MM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGhj9VRL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613LK4FO3515711
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 05:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b2yk1SXP0cSKoeq0NtffjWATsVhRHufpkROfd+0puu4=; b=PTZtq4MMpmAemyhd
	/KsLx2pZ9SnScDMJRJEY8rLfgsO6mhkzGvBZ0jo0L+op7ABudMvxKUHIkedclzlK
	Agb0W3vl8gG+gjU+dVN6TdZm3rNfFKQQPsyZHgAKuB2AbVk8m6phBD4+4g3vmpwB
	gxw28YvVGv86H9TgYCyT7cET5IfUtFptxkfL7TMJVs7eIZHJk7y/PA5U0EyIsadn
	DWfiivpnlCdxAIwu5vpqeGSmPBs9oh+d7fdRQK7wLOozWmOKBylTpZqldFd0IdUj
	/iOp8QhEjQ8VOCvh9WuEMBQRP7s/iuzT6lIb35OzQLqElbiTY0VQHbAMLuBrVFdz
	DlB0NQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ru996xt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 05:10:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a8c273332cso166889035ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 21:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770181848; x=1770786648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2yk1SXP0cSKoeq0NtffjWATsVhRHufpkROfd+0puu4=;
        b=XGhj9VRLhA2NL7K976NIgA5cttTZNFWCBaeAbz954OH52LHDhkAvuIfC5qLg7heoLc
         RsEIul/EcRcyskxmSgzJ5407JrmfFIoiUOt8Llt6pQTOhTm4Jztpu4R5Hcet4rjzMtZ6
         4TPGz7etF+QBw3lYuKz0GVOAYkBaIT2t8+BmrmbOPYveFzZOtYiol0CFTqp2YV7p5FM1
         aEcuSPNrNgYvStm6/itMiMGfL8sq7kwzrj0uiAKPWVFpT6ibSIkV+1wiym0hdZx/pWCR
         tqcCkBGWzNepDY0EG8X0CUDE62cy2vvEx+uI4ixIVyuWKj+244mTi9CR2f6JpRc4/TAD
         0Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770181848; x=1770786648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2yk1SXP0cSKoeq0NtffjWATsVhRHufpkROfd+0puu4=;
        b=HS6gnEiMUXTWZaRe97PqzedScloe66h/yb//e/nqyoMRvaiWr0NTcQ/W84CkKTeKVw
         yF/gTeT2Nr4nzVBIcpheoruZNBmUB77zsdHwl6FYAQLeYNZ5gZd4dcrRhMQQwOWKfH/y
         jprzuo18+MByptIrqfMWtZ8LbIs9bJlpgrt2hA+CnoU7mb4g2nRn12IazjbFMPF+xsDB
         3WigLzmS//M2uT1c9ninf+dR8PY+aO/OMcjL3m61aimT6jpkMfg98buZZcD54oBCzXNG
         Pid6YymOyE8BBTA7J1Man5B/Q3Tk0mfU+qGQhzBnfbWBtvSuGE6pijJaIc84SNJS8Naz
         3OKw==
X-Forwarded-Encrypted: i=1; AJvYcCXAv1N37ecWZvU6NWfgfQIT/Or4SsEiuJ0U//g3bFfmhqG3ajKm42/2S3OW0SsrJg7yC6yUaYWj6iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPs89KZoOYxfvkT004bLAUWEM7whD6UJsJKP9Xk5zTj1/noS30
	iBfS8c+tvi++1bbM2sTvLvmxLcoFB1VQ76HzXtieDW5yjU4hKMvxa8fSXVbQDNO20FgLpw8K8Ly
	B99GWv5NJLqyLJuh1324b/DizRxNl6S3PIXbiz6UcNzTT7a2pyW0PiuoaPLVbXNg=
X-Gm-Gg: AZuq6aJe0RY3aOo6Iyylxgb/1on+a/O8QDAdrCOTpa7/4lXDr4b5U6iGlgf/UGt6k7Y
	qoDehDlry8W56oUYwD0+D9AF/DbeLt0mcU1PNKHO7HX+xvaDt3iZ8wQfF2cZJBGuS66oGk1oKPd
	te2U3JiemYti6INNBN3DdcA+Ip68BCJ1E+Ls8aJ50PeciT7Eff4LE01r9GPsjrMzqdW5f1sEH7V
	bDVKMLpcQB+WLKeDeW5sqPiCzeAFXUM6/pvcaTOvisPhfCz44CsPRe0rMPor55dHQ/P2rn8Ng6A
	xCcGPJJLvl9PuzJ5SBQouSe5vXGOst5f/gZ6DR5TwOsArvyqJUR1tBAmFmxk+Clhajqkbw7wTjj
	0ctJZ5KBNLq0J7exieZQDksKw5UOR/Y7rxzqZ06Ikzw==
X-Received: by 2002:a17:903:2447:b0:2a0:b06d:1585 with SMTP id d9443c01a7336-2a933ea08d3mr17630845ad.34.1770181847573;
        Tue, 03 Feb 2026 21:10:47 -0800 (PST)
X-Received: by 2002:a17:903:2447:b0:2a0:b06d:1585 with SMTP id d9443c01a7336-2a933ea08d3mr17630495ad.34.1770181846953;
        Tue, 03 Feb 2026 21:10:46 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933888e8csm12620115ad.29.2026.02.03.21.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 21:10:46 -0800 (PST)
Message-ID: <d4a51e98-72ae-49c4-80ec-fe3784c3e8f1@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 10:40:39 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] soc: qcom: geni-se: Introduce helper API for
 attaching power domains
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
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-7-praveen.talari@oss.qualcomm.com>
 <2d2bc77b-715d-4484-86c4-4389ebb63856@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2d2bc77b-715d-4484-86c4-4389ebb63856@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAzNSBTYWx0ZWRfX2lMfHjWxZ9Hz
 3qF57Rcd97ZRxVFjZofl+kk7UQm5qXrd6uqoNC8vT+Js/1h4wnhTadafG569u2zZqbJBOK558Sz
 fx4/KHb3OREk9eTWW3neGJ70NzKfMan3IPwhsHm2AkhotDgx+PJIiT0DupBBeDbxqajT9h/UcEY
 LyMih0H38gAup2wjyfQ+9Q82HuVOCmQNzRTjpLlarxICv1Tm9u/UeLpVXk34l2gGVlW8dzGExJH
 b6z6dhtuwwaRePVuk2HrXSrkf8SJ8PAnnbc/kRL797vKbrOkwMieQc3NiaDX9d+w1zHeL0GISBc
 ajPqtScjBZSIO6zRfkw4uPamEUghxGP0KBtlfr2yBLYF5kfopjJqTDPrkKL+DhDyTTIOJx4qvRq
 8RukGm2Ikjj0u4CNkvcTwreYckUHlNYa9hZynuaPTvyT9xrDFexnfhtJ4SjBD9P9XO8fqhUP7+P
 rkkctKEqHrCQoDNjBcw==
X-Authority-Analysis: v=2.4 cv=IJoPywvG c=1 sm=1 tr=0 ts=6982d4d8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RFm3ULBN9CpRR-2xPD0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: zH0IMSthWzANfEgv2e5UokgR5U7DDotp
X-Proofpoint-ORIG-GUID: zH0IMSthWzANfEgv2e5UokgR5U7DDotp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040035



On 2/3/2026 5:53 PM, Konrad Dybcio wrote:
> On 2/2/26 7:09 PM, Praveen Talari wrote:
>> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
>> the attachment of power domains. This often leads to duplicated code
>> logic across different driver probe functions.
>>
>> Introduce a new helper API, geni_se_domain_attach(), to centralize
>> the logic for attaching "power" and "perf" domains to the GENI SE
>> device.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +int geni_se_domain_attach(struct geni_se *se)
>> +{
>> +	struct dev_pm_domain_attach_data pd_data = {
>> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
>> +		.pd_names = (const char*[]) { "power", "perf" },
>> +		.num_pd_names = 2,
>> +	};
>> +	int ret;
>> +
>> +	ret = dev_pm_domain_attach_list(se->dev,
>> +					&pd_data, &se->pd_list);
> 
> Let's use devm_pm_domain_attach_list() (notice the 'm'), as the list
> is never detached from at the moment

Sure, will add in next version.

Thanks,
Praveen Talari
> 
> otherwise lgtm
> 
> Konrad

