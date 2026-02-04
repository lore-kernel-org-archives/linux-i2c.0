Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280873ACEF6
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212674; cv=none; b=oQg8ayyqCkUrVXp1MJ/dYn+VyXZmjMbmkj12NunWW5uZ9C2BH/aWRRdVvUcUYnYjb0nOLrUyHfanTX1VREaCgq0rwVz4mfQglAvP4XrQG2ltbDEHphVuyL8ymHoP+6fqpn/A1SId9huEv04GFHskK2CKSYW26DVjh0OmcrHOul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212674; c=relaxed/simple;
	bh=MQGHHPzVdGGY8D/fSv4Dv983HDVo+MObBMQyIa/vXbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDqeb7cCwH2XwLFaYj8iLoUEn0NBeApzDdjCdm/VB98KQvpscAhT4onkZwIxgCCQzFFmDiDW0YnInUdriUkwhrMkULRVKYwcO9jlVVGNToTaX80DusnYXF4Yyk5uLnySl6Ti5U3zOJvj3FMbcYC+j06faUbKDX2Wl9TCmdLIp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwVGMDkA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UYMISuU/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwVGMDkA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UYMISuU/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIUXr1401862
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 13:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dezn0ig7nH8Z2dFhym2GV0P5g5RLh6rh8CVm6EDr3Is=; b=XwVGMDkAK0hnFY49
	ebDTS87FkRshlxWg75t6qHsl288iWXSYNSYdUGX+UwdPZK1cIaCa3Svc8VzgLbyh
	SmGdwobdS60SFhsVLdt+kamwLbBfd2sFZu9juvWnTji1g3yHk/pvFc67FsnWDyZ2
	S6OnBcwNneYxl81TR7Mcdy36mTyiLElJsyM2sH29Ta0Gqo+xRfUN79Rt76X40Cqr
	QTw4yLzU76x4juBSVvKgPKkccWEFjc+pM9w3QCmcSBXL2sBfzHGicyVXySCSrdi7
	e+MqVyVrQK8uoIYs0wmDTGLpfgcs8+hbg5v8E0F+9yN+uvsUUROmY+CbCYdCkLSz
	W5mupQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43dh0pwb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 13:44:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8ca3952cbb9so19899885a.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 05:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770212672; x=1770817472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dezn0ig7nH8Z2dFhym2GV0P5g5RLh6rh8CVm6EDr3Is=;
        b=UYMISuU/PNStnOaizRwNZVJingxfFnsKnybSQ8KcbFlZx/pgGlGDqwi29RAIYgB/pA
         40Ms+UtwR2BrjoIdHbtUaPJPXf/Jvc3rVkX2pgaVX6gSb0SIS/ffiXQHoAA5CnTp7P0F
         /XZzSS3L+KZaszcTkjXBjllV+NRQbWPlJIwkQdxQ+6gmUMmd23LGSOteUXu4hwQahsUM
         xtgBhhWr4nXETc9Yr67/FJe0Y4QnjRKCtJnwVsOIZDlS7rCvu0xOHaxgKUEPvs5aZNiw
         FJ/LftkSuUiNjuZTuH/Gg248ALy4a0vRtPvgbggnpqvQruxLC6FxjiFugfc9SnFB3BE1
         RmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212672; x=1770817472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dezn0ig7nH8Z2dFhym2GV0P5g5RLh6rh8CVm6EDr3Is=;
        b=mf/aVwJETnoP+8HFWiD5ePIlLgVBcqQBu8Pg/Hz24YTEIvx8lELu68RpM5JSn1ggEP
         RMg6Q0ypyrYoDTuZLxp4FpCFhnb3ZBRkk6UYeG7hi7e/amXptuAKnUPj9SY5GUWGUqY/
         ZIgG9kBS+tLWzch+bhglEfDk+afBWIcR4Kzuft06zgVjn49JKE3s7otqVZJ9b2wMzRHg
         YayzIdZCWFPv2F/GHVTlxKFScxEV1EV9HNzYwlccpAuCBWmtbXTFdvMCtW8dPTHC982o
         s2d8TT3rsw4grtfW0Dc7NlKtmzK4oLD8jHyGHyvLwj/YePdhbaEXCUhX19QFwlhWYj46
         /Gng==
X-Forwarded-Encrypted: i=1; AJvYcCW/Aa8fXl8Qd+wOG9pMqQX0O0ZmLkxZMQOGiCwAcPdtZkPK4xXKdTQtvGWsg7oH6Tf7Fow9CHQbcS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLs78yT96ahISIo/xXoMbnhm/3DbkInnH2XRTco+LLwFWhg2N
	+Ntfdy9OhFI09Jaxvs29vCzQ6BntHKXy/S4OPr3LM+Ew0S2ShsDbEj96EmIovILN31fRczINg3u
	JnQjiKx2/fCC+3ad5vyWdbCDm1vmYLImTrhWIj0P+m7HCyAwV7hbxrPUYIf2K9V8=
X-Gm-Gg: AZuq6aIawrThlMcuCpQnslirdvJdXo8GDwIGNlTiFi7lpd3RQXA38SrwBv9ERnzcSgf
	Y/2nqdICZgnKtMIZjAlbfcN9ggYxaXN4VgDdh1t6TPzbuWDCizl7VKTTp7SYwOab9prgT0OymFe
	iRBEAzhk6TkFAsYSsOuQxaXHRMCGTrjRS3JDhv7Du5jrvqO0noIpI+fO5/Oozz3h/YJ8As1VPXO
	PBNaNbfYoBI6IPGpkYn/9qY0b0HVTuwCPtyi1AgwGYcpoDrN3o4KSzfOU/BaMDH6vX5+CpNYbWR
	SpsCmd6vVSHOoEGDJwxkiNv93JROUcuhJPEokii4LViIKNjhk7KGMRM0Yg/lPxT3xfqQy+JgvW1
	Ebi03U1IQvYqJ8aEvvqU3dLFhmMSAtXyqdn6nUpgaJScSBm3VHxxULsl4k/XTUCPj81o=
X-Received: by 2002:a05:620a:1a06:b0:8b2:6eba:c45d with SMTP id af79cd13be357-8ca2f826d11mr299991185a.2.1770212672478;
        Wed, 04 Feb 2026 05:44:32 -0800 (PST)
X-Received: by 2002:a05:620a:1a06:b0:8b2:6eba:c45d with SMTP id af79cd13be357-8ca2f826d11mr299988785a.2.1770212671987;
        Wed, 04 Feb 2026 05:44:31 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9feeff94sm122877666b.35.2026.02.04.05.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 05:44:31 -0800 (PST)
Message-ID: <34ecaa11-0d2c-4981-ba5d-4d3d46e41dbc@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 14:44:28 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] i2c: qcom-geni: Use resources helper APIs in
 runtime PM functions
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
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-12-praveen.talari@oss.qualcomm.com>
 <7733eac7-8158-40f8-8887-44e458d33e9b@oss.qualcomm.com>
 <3466212b-802c-4ea3-8661-794da34c6c3e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3466212b-802c-4ea3-8661-794da34c6c3e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bMgb4f+Z c=1 sm=1 tr=0 ts=69834d41 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KysUWGufpr5dDgJzMcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: FYt9lqi3U_Z27iMzw6zZ2zm87IExqojZ
X-Proofpoint-GUID: FYt9lqi3U_Z27iMzw6zZ2zm87IExqojZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEwNCBTYWx0ZWRfX/O0GinWIl+z4
 DQsbKL3oHWcixkrgIsY/6g6W78kVC5NpVJEYVKYUSoo1UtKHd/wqK473wKmFn79P54PSivXa+Ml
 h5Z2jbdqQ5BcFiPV5WFo6SmXt3kmSUOQJ9XpqgLyOcp+DI9yEDnMaOI16IUNDMy8voLK5LClTlr
 0v4oUi3wq0EOQLjGF4e/BaeEDxk64Kg39cL7KmpvwuiouVi+wjTrFNKa8CH6OtyqWTWFMSFTn3w
 +WcCHbG7TqMGdbGx3n0x7pMHZIpYBozQoIKcwgkcap4KF1lBJGsown1GW3qnsP7L/n/NMnE2bbb
 vpGLCSVQWxz8nHmYrUxM7twSUZJlr773Jqa6QZNHtecUnCDhkP4ov+ZjgSAhWgEu/6mAmRSC/dQ
 yZTm/atsTBqKVrmZorE9ILVDz+OeOYieI0iND69Is2DzrlWcBiYjrrf+arwkX0M6G4FIyJgXml+
 wd9yRkheBurrhYb26hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040104

On 2/4/26 6:06 AM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 2/3/2026 6:18 PM, Konrad Dybcio wrote:
>> On 2/2/26 7:09 PM, Praveen Talari wrote:
>>> To manage GENI serial engine resources during runtime power management,
>>> drivers currently need to call functions for ICC, clock, and
>>> SE resource operations in both suspend and resume paths, resulting in
>>> code duplication across drivers.
>>>
>>> The new geni_se_resources_activate() and geni_se_resources_deactivate()
>>> helper APIs addresses this issue by providing a streamlined method to
>>> enable or disable all resources based, thereby eliminating redundancy
>>> across drivers.
>>>
>>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>
>>>       disable_irq(gi2c->irq);
>>> -    ret = geni_se_resources_off(&gi2c->se);
>>> +
>>> +    ret = geni_se_resources_deactivate(&gi2c->se);
>>>       if (ret) {
>>>           enable_irq(gi2c->irq);
>>>           return ret;
>>> -
>>> -    } else {
>>> -        gi2c->suspended = 1;
>>>       }
>>>   -    clk_disable_unprepare(gi2c->core_clk);
>>
>> I believe you can give gi2c->core_clk and desc->has_core_clk the boot
>> with this patch since they're no longer referenced anywhere
> 
> Sorry i didn't get you. Please share more on this.

I think you can remove these fields from i2c-qcom-geni.c as they seem
unused now

Konrad
