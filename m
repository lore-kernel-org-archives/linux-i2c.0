Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31B273803
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049190; cv=none; b=SvTcDOBgapY8RTOHwtHVxyZ2SN4BrRAjpgHy91VFbTgJ7MPp9kQGmA8+vNfBx8+sccSlrtpvrwlR0qQ+x01q7BvkNByet1vcWheOoQnRzZZn8X/w7JlyKncjtrLhjBdz9nc1T7DqP1nevGRbmKreBHFKkN3ClwT+xO0N2a539vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049190; c=relaxed/simple;
	bh=UFH8ZvWyHSTba8xWUqCDIvROSjipa6gDdEYCeNskEv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thgzg8P4O1mQew6ecUEF1Usi5f3A3GLsfWILtpMNR2nGtpFDESewFSHj/uJgmX6OqgFe0N4qJD9ACuj/xzwk/Osq9EL1yHDZntRDPCIB39bb1K5ypFV2FcbiTGG9/PnEkMalV80frM2kbiE3h5QEtQ0wSxlywyHKrOpAqlpZDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TDcSJ/Nb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kBOpXLFJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TDcSJ/Nb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kBOpXLFJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AvnDN2261754
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 16:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tJlWcyQgA0RUZL60b1mwd+CQ0XW+iOLXGwHWwdBbB60=; b=TDcSJ/NbBSbbVQBY
	tTXLlJV4wDO+vOE+sQzJd68CBXWy2JFr8kPkgf8ik4pF6FSKopQahpajNe+Q7VxL
	0orjd/shEZ9exSn8vcRQPjnLxsQmY2RAXKXfiu/0EDuj56CIrc27+eUJPNVPAz3q
	z58hG6fgtR6MjjCU8W7ANGB5tk/pwWUbMvO6NUF7rUeic+ecjdf1BaaZWQHdnLk4
	1RuK5I/eX1qQaQrchmiJDwyX5oBJrTd5I9Vp25YxhWXfCcifVh7sL2DkXqTugASK
	GJjebjxqiPiOFxBc0yWo31pZdIJurDUsHDxWzIN4L7SqY9cpeU0M5NBrq1JFnEiN
	kFdAaQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tmtgwut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 16:19:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a07fa318fdso48019055ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 08:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770049187; x=1770653987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJlWcyQgA0RUZL60b1mwd+CQ0XW+iOLXGwHWwdBbB60=;
        b=kBOpXLFJvgEU9HwIu4sewowVPJJOStOcRScpzttdyLY9eQxL81xlGI3EYIE2mEu6FY
         UTdv2agIyNvbLYH7MDuaKeKuvPkPY1WjQgtcXTP8Kd8VxvguouOSpiw8bJXMI67SiuA6
         TwXtbsU55bgwwGKGu7lPKLIZfGQIOIzyCkPnasN8FlJBjd978tHFbnlBktPXl1zN4ivj
         PixiXAwqyqoUMOpa0VNYjWVhrAgE4D71wts1PlPZDrxsTwcNEbHCRI71k1SRO3/YI7AP
         1TNstO2hN1Q50H4ioLK6TTV/3ybQW4P83kNzGeJBpbWy7C3jeAhX5kEh0fVVoAvWrpqi
         7zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049187; x=1770653987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJlWcyQgA0RUZL60b1mwd+CQ0XW+iOLXGwHWwdBbB60=;
        b=hixE2cV3n3TuEpnQnlOFGf4PcY/JxnVkiOnZMS5tLq9y4jQ53L82ffHipanFOt3ult
         Q2onkChYusDX+r4QruY4Eo+ofjY6HUNdlBKD4ZAsQ76OMW1iDPT9Vagbt9idioRkQjj9
         vd/7AUvbK/q9852emNex7ZuMd0O/tx2aLQJtF24VkksZyEWCRUgtPtfT48tdyYlOsyQT
         UGalSHXSBc6qQi+uFYgQP1h6t+Iw093+bhMypzEDWXME6z5mOqVdAX5dhWQt4x+SpqBZ
         hI0qYTfyXKuwbHaMX75Zt995TRjo+vNkwE1pv+Va8p6qAZsGD5O0DlCQWzKYGU6++EPL
         QX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJJj+KHObQlqgkHOVG3hdif5bcFeRg7u9Rtl/9bMdKrIsb4z6o9rejmeGlT/sBtpeQriXmWq8E1DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvG1tugDyrHZn8dinsudayw1pGytm2X0BuxZOA+VtvzW7JuFe
	jUWIVbHkQnKAX/8dCcH4veVTYXdpDShLIqQP2eBYi8p29N309qri00cXuqNNavczv/dYoFgkOZv
	tAeF6tCstgvwAAoWjn7HR1oNxQ3VjFrsFXAKHoPtwrf+cCob3SpYHDAZIqao3+oA=
X-Gm-Gg: AZuq6aKZ/URf2BbqLYbvFbZxwaPoG7eEGyES4Ya59L2tZ3O0nl8vI/csn8cybVA4+h5
	uQnnVK6VTkhSOkGZHcmyYyTeo0Tv85O9IdB2QiNm5u3Eh1QRI3yWNra26BYyZiqvrA9Ox0zAKsd
	gxgtmrPekrtLTgkM6BEhKq+GSZx0DtkszJ8/oyqy2Xs0qt/vpTNWxi7LuIt5dxPQWC2h8i784GA
	2U6S5NQXttm0S4o8qz3wwVufmCIbVy2fE+QtTREti83BUpud0AwZaC4IB7AEQxYw1JBKiiP3q1R
	rAiC6eamo9CzwrSsDAQ4yFlJJOVZWLXgQob6xC4GwdFUIZGhRwxAIful68sYtf9dZFJR6PvvXc4
	VxkcHSjmz0TmfJJWb8C+LOef73BW6o25Z+BP+XuTn
X-Received: by 2002:a17:903:298d:b0:2a9:34:eb65 with SMTP id d9443c01a7336-2a90034f0c4mr58846435ad.26.1770049186518;
        Mon, 02 Feb 2026 08:19:46 -0800 (PST)
X-Received: by 2002:a17:903:298d:b0:2a9:34:eb65 with SMTP id d9443c01a7336-2a90034f0c4mr58845985ad.26.1770049185974;
        Mon, 02 Feb 2026 08:19:45 -0800 (PST)
Received: from [192.168.1.4] ([49.204.107.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eee4asm147472785ad.20.2026.02.02.08.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 08:19:45 -0800 (PST)
Message-ID: <61ef66ac-3919-48e3-a78e-eef54001ae6f@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 21:49:37 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] soc: qcom: geni-se: Introduce helper API for
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-6-praveen.talari@oss.qualcomm.com>
 <d13d1931-c6b2-4f4c-873e-efd45823fa89@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <d13d1931-c6b2-4f4c-873e-efd45823fa89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Xb6EDY55 c=1 sm=1 tr=0 ts=6980cea3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JMgISmeAsz0pT9/O8qDBbw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RFm3ULBN9CpRR-2xPD0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: jIP9tTmMYjheOQaY1otq3KyZJrM1RNtP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyOCBTYWx0ZWRfX1wodFFXvAEWa
 sgTbEypxQPbu76n6y9ZvusE0kpcJPUhDGzfXoTPMAYBH6QsTE8necOftzkSRBRbRPRuK/vaGXhS
 5b9WnsRUMKQAcEPUe4teQi4v75g6Al9R8l5QotUsV3BZxAz8EN3/WJ35XYgbB0kpMnvZ5ZrXZWX
 GbmzcpSzdjAMcO5ZPGZzqeDieQK+oGQqvmGKPrEQZygf/VAIt3qYU+rxydptQsgZ2n3/nfl3bZ3
 C2IWWJUxxeY9iczlXvOL70nKY4pSvBTiBCA+Ps6eowIc8J2QayhcancfrNn5roBwERY9ttBoGuq
 64b64XFzty+IC2BXvjyFKfkCTQ68ARTLBM0Ea+Lcd4s3ru8fWb+Pe0nvya3UrsS5bgg48z6T10n
 3DHClgYWh53M8ZnlMBTDGjmUP556s2fbPmc4C6hXY/OVGfDT1xzLBSvrjTJycVh6UHcb0XZ0Vs3
 YKn2LV7vJmL+7KZ7uFw==
X-Proofpoint-GUID: jIP9tTmMYjheOQaY1otq3KyZJrM1RNtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020128

Hi

On 1/30/2026 5:42 PM, Konrad Dybcio wrote:
> On 1/12/26 11:47 AM, Praveen Talari wrote:
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
>> +/**
>> + * geni_se_domain_attach() - Attach power domains to a GENI SE device.
>> + * @se: Pointer to the geni_se structure representing the GENI SE device.
>> + *
>> + * This function attaches the necessary power domains ("power" and "perf")
>> + * to the GENI Serial Engine device. It initializes `se->pd_list` with the
>> + * attached domains.
> 
> Please sprinkle somewhere into this kerneldoc that this is specifically
> for the SCMI-auto-VM setup, otherwise "the necessary power domains"
> is at best confusing to an external reader

Sure, will do in next patch.

Thanks,
Praveen
> 
> Konrad

