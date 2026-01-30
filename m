Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE632ECEBB
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792124; cv=none; b=Z2UL41IG/vWG4anc4NaBpFjW2PSygPrArav40s2qLWtLdzXDWsFeVt0EqaKTociixQHd/x2CbawOk5qaNvaZayjFXFM6ZuMQxMUuRkSp0POtSUye6d5MjNk56V1I3Z8mK+U2LWDyfNJjvA9SfLx0H3mkXkoAMYz73EHHMizL/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792124; c=relaxed/simple;
	bh=K8KGKz1oQPK/wCJ0R0Gp5OqZAoDdJ5/8NN1U5mXOVRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpXrFwYCnFaZjnbuawTtFqhm8SzsGfz5S5saKxoMgIAgJkJWcdRiIcYBibh1aPIX0PF8F2aMqrfpvgyq6xHiZrjZS8rVwpSfy37S2DzO7DjT4ePGZPYJcpK22f9pogHzZcuj8AprULoN/SCwagtBbuZpoGbYB1Tu98Kf4iDBaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UByHh4W6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V+f3jyK9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UByHh4W6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V+f3jyK9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAnMC22992828
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+Kvb7mmvIX4FEq8N1wkyDPpvMu56Ue4ogb1H+w4qZg=; b=UByHh4W6673GOkVz
	8+Vn7jdvQqz1wbXUu0VMt01xBt0STHDcjIQd7FpHhn0B3KyaDx/I0XCkyhj3VBqZ
	wjmhEek4PAspjPFl3fvj/IVuhZBdGSyLtvQd8sIVOJ9qhrZOA0cybZLdMjJP5SGg
	IMjGeNzoIP0xb0BzAZqENy4tuObdS0RdfsCoE/GoOrZqdh5/LntIwVRrVbC8YZSa
	v8iHhq6beXLKZMikuiLPsgMi2c2fsjvsBLlzTojMBnP5pKY+vB8pZ8SL+pGPEsSa
	GlbxZKWMn+LAupVlk3fQ+xdNwZNRjg1TZ8iYkDObuEvN6srPOl0/IclJ9Fw0EfNl
	QoHvsQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0db1kjyy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:55:22 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82343404fa0so1091320b3a.3
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769792122; x=1770396922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+Kvb7mmvIX4FEq8N1wkyDPpvMu56Ue4ogb1H+w4qZg=;
        b=V+f3jyK9CGAHqVKJlhHrRydoo5w6DkaD6gTrO/tIgMoU3kyEbDbNdxcTzpqg3dRPAC
         OQp39+0TX4mH3D9L+h7gF/w4DMuOLbL3xGjaPbhjfzt6aPWbNX8AINexIbkhKA3V4HB+
         Jro1yR8iC38QhEVMuHlOJVbcgCIYZQqnAfFBitFUvfcQey1euoIEDOysFU9W7xZZKNIs
         Ni/MTZjTkx3Dm/PufeFrLw42cbCXJmDCPzfM8YrSlrbqdZki1htsqijujMQI31BxQS1K
         T8AErPJ8HQEqy+wn9VP60xH2nyh3WG0uSrwRYEIG5eZlfTyZQNGn6gEBYIa28A8nQooX
         DPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792122; x=1770396922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+Kvb7mmvIX4FEq8N1wkyDPpvMu56Ue4ogb1H+w4qZg=;
        b=xE3oaPZPPNa0lsI3bEiUoNLLm1wt+lZthn0GydlYJZbOxJnJPVHQVcMoFyvuES2jxB
         tlotGkZqhzhtQO7SkEdpjOvOhc1gdz7uWgfSRtdOUfA3tKl4x6f2xAint9vdWT3sr6NO
         /Kfy7DUl1PsT9x+gqsy3MbUSZ/qmtiE0NCNiD8mduPb5aQ687tB/F6vv/fk69yF7bfT1
         9mKcJei5xkz7b7BZaz8Z64L2vorKfhNq0bc3tJFXDAgtsEt18ytcpEfc1YvFX7AI+lka
         NpPSfqZu4d+I5aTC/g/3hgF+HD8oEDDtjvxYs3c9b/byb6KJJaH/jd7AG3SzDZH4x6aE
         uyTw==
X-Forwarded-Encrypted: i=1; AJvYcCVX8/VuB9/ceG6MfGtZsb0A1QztOfI2pfvt7PSKwS4ieHg9DUTdHgR6yGB52IatqAQTWK0gNa2T3OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1TDRHA1KrhnRZjddeaDSWRMBNpjCC/ENdn13ETyiz8IAsYMv
	rHGJbzJ8CiDpi1JzSF2v3e8w8M0GhItdlDfy5+5doG04e+FMxhz1iiuDMo8Hjh30E5a9mXJvXMS
	20Ui4svYquvIovhXasomvCB+mOn61qiEbEvIxiueHfcRDTSiKspYBOy6Z6LIWxd0=
X-Gm-Gg: AZuq6aInQ/rdUIdprIIhUj1t+RIO7lkkWxovq339wWPNFmt18wFMdb5Xdbp8RwHvmdl
	A9UMX3rFu6uTTlGFuGnYilTutWZUTSQvt976xsiCoWnaLaeRqr1Oys+37BmiXmPx4aL7DAZSB7r
	TKUaH//WMPFUD/SBoZVDZqVfxVbgsU5Lj/4pyEPAqkLRKESb6wA4JJBIVr7nHpMRjWO/0rMXZN1
	r7Ww0oN/vrxNidmwKPdRRvWNFzNhcShWsPlEO6/BMW9eOXLi8+GnKrVBp97FDiFbpkEMP7jF5CW
	PptQOQahV+3AHqPXjz7vtNMe96zWcCDVdpKXuCTUka6nplk4+pagarz8UFySTcw7jEj0Yu/578+
	/h6JE+YNfBi37V/0H1/DpqSrzVFkRIRFUrJTGHJ3U
X-Received: by 2002:a05:6a00:21d0:b0:823:3078:f684 with SMTP id d2e1a72fcca58-823aaa4ed08mr3672788b3a.32.1769792121997;
        Fri, 30 Jan 2026 08:55:21 -0800 (PST)
X-Received: by 2002:a05:6a00:21d0:b0:823:3078:f684 with SMTP id d2e1a72fcca58-823aaa4ed08mr3672763b3a.32.1769792121409;
        Fri, 30 Jan 2026 08:55:21 -0800 (PST)
Received: from [192.168.1.7] ([49.204.111.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b19a9esm10857706b3a.11.2026.01.30.08.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 08:55:20 -0800 (PST)
Message-ID: <7007e802-f7d9-42a8-b7ed-25572c451f58@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 22:25:12 +0530
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
X-Proofpoint-ORIG-GUID: vhnzAnOzQWfgI5MNcdW8ShgM5LYf1K5y
X-Proofpoint-GUID: vhnzAnOzQWfgI5MNcdW8ShgM5LYf1K5y
X-Authority-Analysis: v=2.4 cv=VMTQXtPX c=1 sm=1 tr=0 ts=697ce27a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=10aD+GSAjGS7IfLbEAHBKg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RFm3ULBN9CpRR-2xPD0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX7NmsIeGYYJIq
 kcl+Nl3cgPe9nnrUpWFhHRcV2Djd5mXYWBxpv1nSuq9NUJ8CxDY4bxhuB5YZ9jNOemVu6EJAnWN
 pzWyFzWFXwqkG7n6O/Uukh2N1kKY7x37qM+GQalVFLGWO+nb0bXgN6lxUfTrc/CoSeFdAUtOsmn
 DPCm3Vyxlfv4aJ9XQqjnM/IoYYhpqcpLPVmnKasFwfkDhfhVfoOLR5yl8KYkLQuv4oVznhHXud/
 wCa8vKvrhBqoi6+L0YDHqsDKIUvNVI+ioWkIiz0gBVr0pKiX2IDGyVWdLWSBfHF+NZr6fK8Gdhg
 Qa8XQEH9d9pyT4dgJP9/45Gz5rG2cosRRDNJn7DQ3eZg+HkdywjaRh9F8hB28WhIsry+CPzH5Fu
 jw9rccXo47PoWYBZxI2kI9xPYXU25ybUYMI+uiPyfuLVgvhTp92spUE5R0qdQ4qpdCYm4m2+J1m
 aiXsd2se8AGf8GBSurA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300139



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

will update in next patch.

Thanks.
Praveen Talari
> 
> Konrad

