Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A753E1211
	for <linux-i2c@vger.kernel.org>; Wed,  1 Apr 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038773; cv=none; b=WqUG02aTaQN1ATsX1zjmrgcI/SvHM6IOo/U1A80HyMsggMbVxdlnj+MWIZjMWhRqZMtsxDh6ywS7iTAcd8iy4en5bh98TWlKUx16HiHQF2hYnKy1Z0253Lrpf5TvdgPnWlLteaXP7iY66ABUgzI0009ZVuKJyLiuY335EzhgOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038773; c=relaxed/simple;
	bh=Njs9tyb3D8m4OZGmINAbbtRppnbGqiI7vwhKUfDMq0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLcJEIIvb1O0b7YQpwIlB2nnDyE5QVr7ag9V1XIDLsYVpL2PBniP42ltsV3gxd0sej5peC0NaZeaQZgOIXPcSdTFUCp6fYitkG0+/6ESJXgfvuJyyjSTyuHQfGpwaJRnGgy3RW6bvGua7VPfrchvzCxhfid2ecVFCz7SwtjcGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PS4rqm3P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EjxLJli8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PS4rqm3P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EjxLJli8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319rAr61579394
	for <linux-i2c@vger.kernel.org>; Wed, 1 Apr 2026 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	icigY/o4erm1hQ6wPL4lotqSd1rhrSmpE3CjS8+amCc=; b=PS4rqm3PjWOKLUxC
	fZmZSUMfFQbAXkocGS4eg3LQmoZUuKRadt4L2LHY2ulxThZbr206u3pO9CW3UceI
	UqxuOqvR+PJFdbi+KZv5/EAiCXBXxZXZupFmQMuLK39B1ekkfHVpsE9vxzptH+Kr
	mRIHuGhY4/qc84EWpt65VFnnPwEzHmGQ8bkE7pFQFOmErjbLwg26rrByfwO4uulw
	bv5JeqhlwDj1TXq6Nl0j1mbzEGn0K8qDmhpd8teX08ypCtTRpEAAe/r11HsqeUri
	iZa8sy66H4eL/mukdq4REeOVhw9MpCBeZq6r2NQzub2RTBo+OWNGrfOY6ZrAugA+
	+k7tug==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2u0s1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 01 Apr 2026 10:19:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89f548d0872so12901216d6.3
        for <linux-i2c@vger.kernel.org>; Wed, 01 Apr 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775038764; x=1775643564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icigY/o4erm1hQ6wPL4lotqSd1rhrSmpE3CjS8+amCc=;
        b=EjxLJli8UVcbyrIh8P2L26RAsZaNbeigCRp65HilibDeJkAJLuqvDbgvA3yjEatPAU
         UI/HifMc9uMgNLUCeRy4ABllhcFN+//JBX1nER9JICTDu3BbhgTGMt1SAxxomly61hIQ
         LKbYVYnHfVVFyvNzCHNktmEllxzCi2K+GWt9jn27SjlfDSG5Y172/G0zYv0Gi3XXrd6U
         x1Zt0KLBnSGqdLch+fxV1GugzL5vRRJdRXtb4/2bQSKI5C0BRp12GDZGKDn+yZ6w+nTY
         Cgp8skyU5cMazc1v9yA0fq0DPAIyQYc/fCz6vKU8zI5TTW/guHHKyhY1b4AD9OYKtIMN
         8Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775038764; x=1775643564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icigY/o4erm1hQ6wPL4lotqSd1rhrSmpE3CjS8+amCc=;
        b=XonusKKIqKFKgC1/I0EL7lwEW8+NWwBeBIjApdyB9lqETo6z+tTPi6vmqKknIp7FOb
         gveEc6ES+cGmBJLY58cVESv5cnIxS70bxUTB4nxIYvSH9IvoMPsoOSQYB2gMNDPO6/Zr
         CW9jax9q+yVqoRipTv/WqBUq0DMNm8p5gxZ3YFaeWPXD0bOWF0CZrppI9SNnL1LWWlKS
         W20+aoeofJzgxdiNYxcCbVdbwwD3cBS7eVc8orWdcTCC7SCEtfItg7KklnbqBCWFVhUa
         NMQpTpOojbn0EQeqsIHGAOJ3S82HCCXFf5w2SL6omSQsKGRcdtFdsq3un7X46CEZhW05
         eBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmVslIws/3pzU9hUj0A2Fwo5dssn2NUKfJBz/SHq8gt4ZHUa5REHAY/clDFfwur31IhgQs6BwEdX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1VxqfeT0LTEuXZv39XNHCwiOERzEJs52jI6F9Qc1tagVdTCb
	u+clE53of+djvUpTW/qIguWy/58GJ0L2w4EZ15XVIbBYHQH0zWC7qI/cx4SMsKHkAiYrBlDKmst
	BbMnAG2kliGjhqKyI82bMOSAsiDLlEAeO5vElyoD4TtPXfuBVKStTGAY2BNDQNKk=
X-Gm-Gg: ATEYQzzqAU5XcTDtzmZd7tp7RaVx6x7p+ApExVRRxfB5MSum+Gx5NfHvIHvoVyDwh6Z
	H0MKK/V9VUYRJ9hvxRIq+vk7Z8P13lxBvDKriSBpeXDhFGejOpUr1EvJF2A2MyvDXl5Ss3s+ZJZ
	TI3EFMYb1RnWh+QzIQzR1qLMsxKjv36dTo0oUZbutOYkR4QSGayGeCKIOgn78EQCQWJ+mX2ytuA
	tag6NLXzaz3I7n971H0o8oLngKEUywqiw4KsI/V3MFpaKqhqog4eRXgmyTbmIgBw2Z5dhXsSrRQ
	XV+gCltCjcOCwB/ic9rIk2APbY6WbakMUtFU2/ufpaRXqPsJz/oG5lGPuj7TnorP5j+85aW0oAH
	NYftTDjoVRqzJ/18ER9AxNmdmQJk88Ay28wKJzbs5vtNpPJ5XU6pXLHzWJANMnVN7/gss3UqoCA
	fQdN4=
X-Received: by 2002:a05:6214:5184:b0:89c:5285:200e with SMTP id 6a1803df08f44-8a43a55cfe7mr30042656d6.4.1775038763820;
        Wed, 01 Apr 2026 03:19:23 -0700 (PDT)
X-Received: by 2002:a05:6214:5184:b0:89c:5285:200e with SMTP id 6a1803df08f44-8a43a55cfe7mr30042446d6.4.1775038763384;
        Wed, 01 Apr 2026 03:19:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c2c28d97fsm23326766b.20.2026.04.01.03.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 03:19:22 -0700 (PDT)
Message-ID: <ce5eb817-ce13-49c3-81f8-8e28c40632a1@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 12:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
 <20260331114742.2896317-4-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331114742.2896317-4-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccf12c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=z3Ex9-aFqVcHxkoEKGUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: iJnGIJVZ-2KKKnbq-ypMwA8A1d4WrfoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5MyBTYWx0ZWRfX+uzpqpTIplv3
 f9oGJ7k1jpiYx8h+qJdyStejh3kqf77FJlHlgh4ffUQbJv6aelSzyUxBBbf8CjhPVJdHj6SjoXT
 JKleWcszWCuGuEcPRErLlxFNugDYEU7np0OWINUhjI5ZV0OmdW7UAblGh64v2XgokBu4FG1m3t7
 NHHipxdjgvQfVTF4lMGV5FGAiM048PFylM7ohbXUxmsKY4jQLb6DErFYY2FNMX16G8l31xMzwz7
 xC2t//5O+9iG6PrQ9zRDokCz/sqBcrbVn3x8LAOeQx9VmySNC+PbFTfq0WS34VKeHzrIrVMhAyY
 bLrU24CijKo7rf8obVBB4g0iKkOO+CSKTIWt75YDi4mBXIV8Q3yraxRw1W4ySGRmSymQ9rL6mCY
 7WGCaTkUML53T44yphbmaYWSyNjZXZ7KIVCLZuXsf9HgrfIOQWN6uGeMR2FfrnTIg1IQehrAE1u
 C+VE2smJbcjKn+g1P7g==
X-Proofpoint-GUID: iJnGIJVZ-2KKKnbq-ypMwA8A1d4WrfoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010093

On 3/31/26 1:47 PM, Mukesh Kumar Savaliya wrote:
> On platforms where a GENI Serial Engine is shared with another system
> processor, selecting the "sleep" pinctrl state can disrupt ongoing
> transfers initiated by the other processor.
> 
> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
> when the Serial Engine is marked as shared, while still allowing the
> rest of the resource shutdown sequence to proceed.
> 
> This is required for multi-owner configurations (described via DeviceTree
> with qcom,qup-multi-owner on the protocol controller node).
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

[...]

> + * @multi_owner:	True if SE is shared between multiprocessors.

'between multiple owners'?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
