Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FB480979
	for <linux-i2c@vger.kernel.org>; Tue, 15 Sep 2026 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480107; cv=none; b=ZOStyCDUD6cO1pHioVokEmVndAP2odYE50RTRH2KwujBefZjKhyVm0Ceb3uzzhyXiLh0Sce4b2NLQYSEU0kh5DXQLuRrPu85xc3ke6M5dMjtGMCBjJh35hC3/KMq5BuUJ3RrYOCXIStxeIMRLH6KgYimnnDUkWA3jDRrPb6kNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480107; c=relaxed/simple;
	bh=4eKyhswm/4t8PNCpNSn58PMTddZyn+n13tIZCaGth5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPbsU7lVhLBtbP0lERE3rx7jWe4N1mjg/BE7Sfi/dCXMgHcI60VRWtLm6Z+E4tGXjgGmLaI3cbFhzqMmPp3RIsz/HEg+a1y5w1nV3IDpV3WxTqxGEaDey9/gP44wU3OxDYpBOZItlmh8YSweHcPLCX8mhbkisZFj150asSEn4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p5L1smna; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dNEVifBv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5L1smna";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dNEVifBv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD00XY711959
	for <linux-i2c@vger.kernel.org>; Tue, 15 Sep 2026 13:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JrIpxB6rXC4YQU5JBuOmbKCLgyAWZtcf2l6ITQl/W9s=; b=p5L1smnachr/d1NE
	L4RZXm5Cxn2WnlTelhvrx2hRVfzVugygvCHD+L8ogsbD9J1cgB6gvUabDTlmrCUT
	04RUkkA7KNZs3okqum9FAKrnA9r7JAwTcMvAj7agTWnjsWpR2ZRpvS5shX++slIs
	FOjLU5NPqXh8H7c+eOkBAdiLX9uEvs4jcoIM40G7p4Kg12cfkRWQNXRwe3uApKqJ
	rEjcXcCIlOfPMUmDD9Rn4Xq1SbF85cgH2NqnycaeFqokasYN3pV8wQp4wilOKj40
	xK9rQ8SQFxG9DgRdCmvYpk7OgkbC2k+PBeKBnSqWDZi+SP/jV2jh9XQKE4LMYLnj
	NZ+Abw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyea24yv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 15 Sep 2026 13:48:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d9057fab9eso71649035ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 15 Sep 2026 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789480105; x=1790084905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrIpxB6rXC4YQU5JBuOmbKCLgyAWZtcf2l6ITQl/W9s=;
        b=dNEVifBvjDd6nLYi+Ra4CEf18O+ueHJSVRH3Ne6+2D0JZWycYkQ9iUEr7xdSHfGTn7
         bras7IIyke/fEj/1nirPv1NrZf0IvNjJFanUnHWFGS2woXRvF+jc4sqIllaBIlw38n3S
         nZwBdYJsMH1TDShD8CxUNZcu6GTaMKQhwSUdH+bGjUlK78JBS36WN/U+Rw8WFofRnAcx
         /T1W0K27Qqi0yOWCEPV7w+yxgoPegJUJPWexL5haUPNrv8Mof3A7B2/0i5E8OlAX+2JH
         L5q+29/O3BDRBH2MaBygc7SCPZiAIOFWQbkC1E1n8dIju71XNtRMuWQE6aZ/5V1Hvigm
         b+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789480105; x=1790084905;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JrIpxB6rXC4YQU5JBuOmbKCLgyAWZtcf2l6ITQl/W9s=;
        b=k61lUJl0DsfjGMWWnNW13H2nZMZ4i1a4ic1T5O2cYHjrVLvutfW0uzIpkTri4DhtUi
         UUHFGCtQ8GW5zjpr2Tzu2PXxPPR2bIjoQEuoil1DDIC5Fl5lEzLg+rf4lmUewuw53uzd
         mZV/bXDCZUJFULAySnKw6PrH8CaykFExKZ4pRILhO/qMBoXWwwW+MZGVenD3OTWt9RB5
         S4BazXi3zoY4kuAGvL0piNyy62GmR3umL/kYG1ryn+65lmpcW4YkGOWaq4bcbdKoeoaI
         OqKU+FW5yM4CgjZz5Vra726VssjNl/JtZdXEXA8gXqedqiquPl4bnqc2oJTiGSxWwpGo
         9ysw==
X-Forwarded-Encrypted: i=1; AKwUvByhU0DBc/lbIGETx02aZwx+dYihhLbGs2OCB9WgHfk+LLU14ziWQr0mN/BHeAr5TEDfX0kjM1yTZ3w=@vger.kernel.org
X-Gm-Message-State: AFuF++n2zG6FL3LsM0c+zrTJ8RwmJ/h8VeuwEndgl0PLdyf0nqGeymsy
	oe80hlQSRymP2JZLJJDwUt3BnS+JUf7C84uqRAgHy2AO7R6B0yCe+aX3ZhWZjXFsxsJbWYoxnp5
	Cs8vmInYYMa6BS0MN5C80MRHQR8xs1Gd/luRIa9r8RYMakH8x4dEUBvcC4KsO2bc=
X-Gm-Gg: AYBFou0AGLRHrtzs1/PZmTfYKj2Lx2L8MfMQyp8bYXh2LfDoLDoDji0UT+sR8ufB8Uh
	gasczgulQBj0u5wj8+aR1V5V2h6uBs/EIDXY6Glz2LJ/RhA9eolAwyt6OITVZVzdEVTC0vyz5jb
	vB8GBk3iiUXcKB3YlwFQPzeZ5kKnIbDubC+mnY18EjuTQKj4cuDw38L3zBea8jS1t2Cq6ZM4JS5
	UtnKbMW3bl21cTqZ6C2MlRmX0wr2iUg76u5RjcMw8auKbdBtUWZi2pBpjwH29YKHja8j8xFuWg4
	OdiBv2km4+N9RGoTij2g7hGR0lOtisZfcww2txd5gBtlIynTSqwp7Tm5g44K5mLplkCzEff4FCY
	Y4lz2NJnityC/IQVbOFKYTapyGqJ3+FW7
X-Received: by 2002:a17:902:ccd1:b0:2dd:40cb:a04c with SMTP id d9443c01a7336-2dd8386925cmr21452775ad.19.1789480104494;
        Tue, 15 Sep 2026 06:48:24 -0700 (PDT)
X-Received: by 2002:a17:902:ccd1:b0:2dd:40cb:a04c with SMTP id d9443c01a7336-2dd8386925cmr21452295ad.19.1789480104152;
        Tue, 15 Sep 2026 06:48:24 -0700 (PDT)
Received: from [10.218.4.101] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ce92e99sm67934895ad.25.2026.09.15.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 06:48:23 -0700 (PDT)
Message-ID: <467c19e0-a4f8-4e67-a750-be695db34c05@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 19:18:18 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
 <ao7vB8cDufnJZKAI@zenone.zhora.eu>
 <5c6b120d-f791-424b-a41a-6c82de73000f@oss.qualcomm.com>
 <apDPu_uJBTT9GPmZ@zenone.zhora.eu>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <apDPu_uJBTT9GPmZ@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sBI-LdzJGAIgB2f9UIb0yQGD2YrNrDBE
X-Authority-Analysis: v=2.4 cv=cehHPXDM c=1 sm=1 tr=0 ts=6aa94ca9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=5oCPkDSuF8hkarQvZ6UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: sBI-LdzJGAIgB2f9UIb0yQGD2YrNrDBE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIwMCBTYWx0ZWRfX2GDRBL+3W2oG
 fq/oYAZp23deh61YUp5BfNedtIhv/13T+0jX3LmlwBQmBo1psf0ci/ju7Un4Wfkd0lFB4W3krpr
 gYJVSAPyeVClWHTwShw/y6TIwnBSBks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIwMCBTYWx0ZWRfX7Xt9DylkQkc2
 rKwTvvG4B/Ca0fNG0uk1ZH3USAFmDS9qNGOTmzsIsp4mKHGbzLh5GE0itoG44JXwMljT+K6LWfp
 UhZAEuY7fjZ5goYdag+5bRwn55wMFjUNj6Phu/4OrRumaI6HYVXo72dVR0sCjTjFZfLYKuUyEyU
 /V/1OoYMrpHAhruEnE57R7I5t194/1r1G8IBnCjoKRypr8zcl6osz8sws5ZPYuL+bvELxqBkkGD
 wDDcHhURgS18xiq49tNFqlfo365OdwVv7jVEyhzGJ8V/YHW9mA8jmyT1TRNVNlIexIWoaERJh2q
 CWzV16yoBc/EPYyXFzpk0zxnG9YuG/t2jshcgXOnQon0OMasqENFUPIBS9MfZYE/nh6vnQHEOiQ
 gpTtLsj1CPtn1mjlXgM6QtH3M9k5rewdjEy7QSOV5z8qmoOf76Iau7d+fibQ2bZutJz6r7Af8VV
 CkTAmguizzvw/e8HpCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150200



On 8/28/2026 5:32 AM, Andi Shyti wrote:
> Hi Viken,
> 
> On Thu, Aug 27, 2026 at 06:44:21PM +0530, Viken Dadhaniya wrote:
>> On 8/26/2026 7:27 PM, Andi Shyti wrote:
>>> ...
>>>
>>>> +static void qcom_i2c_target_hw_reset(struct qcom_i2c_target *target)
>>>> +{
>>>> +	/* Clear error bits before SW_RESET; the reset may not be instantaneous */
>>>> +	writel(BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT),
>>>> +	       target->base + I2C_S_IRQ_CLR);
>>>> +	writel(SW_RESET, target->base + I2C_S_SW_RESET_REG);
>>>> +	/*
>>>> +	 * I2C_S_SW_RESET_REG is write-only so completion cannot be polled.
>>>> +	 * Use a conservative delay to allow the reset to finish before
>>>> +	 * reconfiguring the controller.
>>>> +	 */
>>>> +	usleep_range(10, 20);
>>>
>>> This is also called in atomic context from the irq handler.
>>> Please avoid using usleep_range(), perhaps you can put this in a
>>> thread.
>>>
>>
>> Thanks for the review. The delay is only 20 µs, so we were
>> thinking of replacing usleep_range() with udelay() instead of
>> converting to a threaded IRQ, to avoid the added complexity on
>> all the normal fast paths.
> 
> perhaps before sleeping you could check the context you are
> executing (with an explaining comment).

This helper is reached from the hard IRQ error handler, so it must remain
atomic-safe regardless of the current context. Since the reset wait is
only 20 µs, I will replace usleep_range() with udelay() and add a comment
explaining why a non-sleeping delay is required.

> 
> Thanks,
> Andi

