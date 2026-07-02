Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72F3C0A04
	for <linux-i2c@vger.kernel.org>; Thu,  2 Jul 2026 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987763; cv=none; b=bmmeBa/Bfac0u1XTKhjG7cgobJrKDc1qO7njhrfH+u6LeSwsZO++u0+HWyZYCOdLMnhzw3VTbUm+4HjjnxT6ctc5UmIGe1pP+RvwH+SlJMuHjAnKpxBuEla66TLZemYE+zk8XnFnh+/c9xfvdkMo3jltB8/qeSwkfbhDEYYWrqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987763; c=relaxed/simple;
	bh=o9tFLmNsR/+FbAtqghIZ3r5O3LeY6k36CTWd36OTwh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caD8D2BHg5V3z+FhNo1pYPE9S4IhABIQOfhiPtia43rbVtK05o/HQAuh4VOpT1yB/fQ8GMjQ8wh3oTEOWIavLaoIquqXlq7Q+f9fqgSw5I4Il8T0OnpB8+wIPbAuW3jX2WlwC3111TH15wyyY6U29Z1Y+kmFPi/3p4o5k4l6xGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AWTF2z/I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YuXX1ZBE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AWTF2z/I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YuXX1ZBE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nsaY4140055
	for <linux-i2c@vger.kernel.org>; Thu, 2 Jul 2026 10:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ukcBbTjMthKe2GNqJ+5N6ofiA9OEHfabMRs+DdH7aw=; b=AWTF2z/IkMlVsj0I
	kaKuoJVOXInwToOv58Uv+dB9TxSgyw3vL94GBLBC2Mfp8LdEz+ZfA6X6dXVYYUUA
	NWCFR5c8S3t59chmihgNX3kdg1GI5qDH/+yE4mKuYfYrqS9zJuR65wH5zWxGVSfR
	j0s6ooJzh2mZZKdNufhWi3wlL0t/M8eqDzk8YpXFqj9CDM/Nd8PthpdX4bZThkUN
	LM8JIJCAxI0zimjPaER2vOc+bsg+NUs5tMyq8bQAl/KfHK2Ts4gH1tPJhua5sLkT
	64i1KEFm+BntBGuSsaxs1Jap0R7rplT/sTKF5JmYjDU+T2jDj18cl3bJopKhW1FW
	D8j//g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr8478-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 02 Jul 2026 10:22:41 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fccad2b01so3671187a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 02 Jul 2026 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782987761; x=1783592561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ukcBbTjMthKe2GNqJ+5N6ofiA9OEHfabMRs+DdH7aw=;
        b=YuXX1ZBEUsWVuZPbXegg5h8dgkp9aIbgZuiuETaeZWDUIHzO0DDP90FzhK4QlTy8K0
         0Kuzq9QUHoBph1HzS8X9SoOER2GsWwO8WDxaNa3Wg65frTl/6SV6HLg9HirJW7V0P9rL
         mEAQMpCFwXQtNr74dTvLxda1KZyjXc4ADHp6x9u1peWUXfnsLbwgT8L/5HMPOMaJAIeg
         whvwlGXT1OOAf5EpUSdfwe9et8W0eY9AJY1vpPvcknJkp8467QU52k5sdrNDVzchmQQ5
         xkcey7lWa8OqMchli5BFOenVwPValoP3jaqvWxdZB45MdfTE/Xs2mwm0/dllMWRfU+yZ
         0BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782987761; x=1783592561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ukcBbTjMthKe2GNqJ+5N6ofiA9OEHfabMRs+DdH7aw=;
        b=s2uUXYyeQhziKvzeno13Z9xA+EJGlZYXFypTmxSIHreUSSTN0TJ0dtfcI3gxUq2Y0w
         0WF7eZDfgcZBMa1X7r+GTjl9oS63+vRU/NACQRUC2KQ0tMXAzx5q/1ncPW2L2LIjoFV3
         y2xvx890eTE0sSKsqrnf/GJ1BCK7mhKZHZHuflpH/xuYFlEmBfuQ9UfGJ5Q76q+xhyGz
         +QHBFc0QLO9eAfnRDa7dmGXT4SU/Gn+UOMw0p1P/aKc5u0D/z01d3Yj6lrt8FYMJwNDx
         FoyASKSBw2gXh07wRyP5k6gur0IOwMQV1NLm2ylrSBCr854DacWaqRKuLXGkZ5BwsE1a
         bh2w==
X-Forwarded-Encrypted: i=1; AHgh+RpCnTN/1FUylI22U61QIPSn1DQ58vh2xaRjdVLqP2YgLclxg7x4Pby/My/nacQQ3BRDGcPEadInkuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBdXRF5W1979yWKLzSt7FEujaixUv3X3bHtJ2120CHiBitGZS
	USX8X1q3XS5e8KrvDfJu5FsxQwH4o7dh+1LeAv+Jeo0xDBJhbVsc3FzD++ja3eyk1TDUWu278VT
	cX4HFUBuYhRchXacQ+iTAaV5hK4s6IKRASGGF61qhRBdzQbWKRs5FNrD6JenOFvs=
X-Gm-Gg: AfdE7cnFiVUJD/4Om7gdwJ2N+thj1UMbaDwpZ+PRKGtklZ4F4WxZLja8F5NzEg7/EH3
	4OAKcaGttjhnjXTZ1TvH0r+jPYuL7Vo3BkSPlwijYY5aQLjxai9LvOSXn1LjLhlfHEbDLZ8QYgo
	fBK3Gmyvq7SpRZE+0BiREskRqzLUiy65jgcLcmFmPm8/UEjRlJkpc44dkMwzz1h5kkIQK4EADMb
	0YnsSKhSRluhSCeOkmTXerOWuyw/ijxzYJQP9zJFYeFlUz4FsfruU+O7Je51q1dOKvX9CHWOm5m
	7PC/8qzz+y7n5fX6J+8x/gs/66xTv9xWwehTFrA+1OWfExE78Uzq3ttKIX6XWEM6Bqa1rSHSg7v
	KyhkFcTW8Kk6SoJQE4gt5eOHwcqvOjalYwqtj1RKe9Sqo
X-Received: by 2002:a17:90a:ec85:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-380ba868183mr4639872a91.10.1782987760678;
        Thu, 02 Jul 2026 03:22:40 -0700 (PDT)
X-Received: by 2002:a17:90a:ec85:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-380ba868183mr4639854a91.10.1782987760158;
        Thu, 02 Jul 2026 03:22:40 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e160b4c7sm862810a91.11.2026.07.02.03.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:22:39 -0700 (PDT)
Message-ID: <65e9d52b-d747-40b2-a6d0-424ed03c9469@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 15:52:35 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: i2c: Add Qualcomm I2C slave
 controller
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com>
 <20260628-i2c-qcom-slave-v1-1-8b0a5c01f9f6@oss.qualcomm.com>
 <akIQFAX8LcZae29l@ninjato>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <akIQFAX8LcZae29l@ninjato>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tNmkOwAARviiaaJUybuc9k2MbtR5dtFR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwNyBTYWx0ZWRfX23FiUlx8pQFP
 XYLCALqFblT6HyRVvjO26iW33cy4VFP+dGagMWiasZGxflcJpzSXoBx6XaShFUE3CwPa+Cauyix
 UwsTNA+7n5AGj+FCj41a7TPvhksgP2I=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a463bf1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NyuSsmef85SJCTiwSksA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: tNmkOwAARviiaaJUybuc9k2MbtR5dtFR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwNyBTYWx0ZWRfX+BZOmRYiX7C0
 W6zcGVA6dXNgig9Aau1PYE/iwqVa511w15oG9HRJcx4lFkZwdnZwPZpo4d6RXJ9w2f2LFm5TwUa
 55So0yjv/8C12cjKxzo3vGZrOGOLiXmEMxhiGTiaxWrtT9Vj+/R1+XTkN2GwbtenTkXmsiMzuNx
 BScV+JDLacCq6sDc1EDOH4N9hVGtGAp1LGBdK6Qe8ilekqKCPKycXIDdfHNQAViW4VR2Q3dqyI3
 lHXAac6aoGurBZpW4gytV6u9TyBVPc2M0lEDyCXHVsguitg/vEEpl5zpDwSGviwp435lQy+FE6u
 wcUtmGjRyEsS5gt88cahdorynUUznTmITGBx9eD3+VhSYjWYpCMLFCFMsNrawEzq6+jFHMorVgp
 SwAkT7/avFnHyy5P8m1WpgXR27FWnetYiNkBzM3iiOg8Ruo8rjgiN7SKGQ0GzVNug5bUnWXmyoH
 QFeu+wOhpWWD5+uLX/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020107



On 6/29/2026 11:56 AM, Wolfram Sang wrote:
> Hi,
> 
> On Sun, Jun 28, 2026 at 08:09:04PM +0530, Viken Dadhaniya wrote:
>> Add a binding for the Qualcomm I2C slave controller found on QDU1000. The
>> block operates only as an I2C slave and supports FIFO/PIO transfers, so it
>> needs a binding separate from Qualcomm I2C master controllers.
> 
> The official naming in I2C is now 'target' instead of 'slave'. Do you
> think you can rename that? I know the Linux I2C core has still the old
> wording in a lot of places and needs to be converted. However, if
> possible, it would be nice if not more of the old terms would be added
> which need to be converted at some point anyhow.
> 
Agree, let's change to target naming.
>> Document the MMIO region, interrupt, XO and AHB clocks, interconnect path,
>> and the 7-bit slave address needed to describe the controller in device
>> tree.
>>
>> Use the 'qcom,slave-addr' property for the slave address because 'reg'
>> describes the controller MMIO range, and this slave-only controller has no
>> child node where an I2C address can be encoded.
> 
> This should not be needed because the backend defines which address is
> going to be used? Can you share how you tested this?
> 
> Happy hacking,
> 
>     Wolfram
> 

