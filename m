Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603801;
	b=xBa+Fm0U+nLNWVTYb5zGvyMPwHCZzDEeCa+VTzxJxZANQJKIaSbBcKVrOZ420ckVND3f
	 CFSqCQy+UA273bjDqNc1kickKkipQNQ9SlqCE3jOzyj/HbAFL3IfaVq0gQ5QPWMAlptVo
	 t2XIK5ZB7tNYK9zAQwJUkshGZtC911myBAAIp6AzFzi3btFxIrNwyO/wH7HMHBPSJ9Cgu
	 Sc3YlnFHKr5Nz2SjSCHElxbQ0APkMfmYT5WrKmBAq1bk04ULSnITlRmCs8PR9IwkUIiNv
	 YAta34jwWM5Q/aJsOAiIOisP0IMz6xPyed2uMZXDQM3nbsdtj1jybeKNNp1OTd16Kig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603801;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vAB4Gs4mUDK2JcpHA4TmhZZdgElajeLPnIQDOvFI1wQ=;
	b=kFssZG7S8kBoXDsGAh81B5dwsNMu8JQNtz1Ff6vNYW82k4hXkGRML/5nGr7OFc0TzZIe
	 p2UiGPlYjKzIEj6eTI5YnZFYSeoTaPoJNClnP9SG5/Oskcou1OlFey23Rn+RfVoULeBS1
	 XwcjjvvyeWo98JwuncIXOExDy1iY0yGAanYNuc5A7DaShJvtNe3AXWof/WQH0TnwO3X4V
	 G7M8wC75+7g1alLHJQqoPnbT7uM+4WpSCh+IGLle1COHtdho5IjMMlv2XAYMWikpM/IGu
	 8hNShO6APpxG0VXvPxz9AOogaL/EWmX/azM+771i8637dLkXzw1GLqppSIMkqRh7TeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KEQjnbvA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X5V23FVu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1A606A331
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB1A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KEQjnbvA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X5V23FVu
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mCZi4130803
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vAB4Gs4mUDK2JcpHA4TmhZZdgElajeLPnIQDOvFI1wQ=; b=KEQjnbvABhREXPEh
	rXePuuh91i1CzoZcCK8P5Er501LM4GTZngciauKOyTLoiss4blcUXUv3DzWSEWng
	MjuOebo430ASTwXXk/TfzPCFvnwU4eg8pICZ6Nv2k/fC6zvsJH57iWmjcu9thI/O
	erx0iVDCZZPEit+cuWqxw2bow2RNLjAEe9HCfnIgPy1Hns+heWWUaEOyyXeil6fp
	PojudJ9nHSLoNVw1CIBhzNxk/J267YoAZYr+g2jy4XSSNd8+Am1tmOc92IFBxzxc
	A/nO71CMxAZBkyavORK4AKm+Itq4LUDJfeznlriGK/ecvoOGwQ/TZVzAvLzcAZn6
	OJsQeA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhrf3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:50:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b647bbf8a9so5088218b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 02:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795603799; x=1796208599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vAB4Gs4mUDK2JcpHA4TmhZZdgElajeLPnIQDOvFI1wQ=;
        b=X5V23FVu9h+U0oYNf4Sp/IU7ykQtI7fw0LG/qbZ2Phq9yVy4adSivytELGBcXXkuZr
         GYZiyAkixQQU044tKr6achAmtHNq3CanNgQbOlQGMp4Wb7NCz1BL00tqam8yQX1/BIbu
         ZeTsEhV93jathC8hDN/dLcdwBgc+XmZPFGqs+uViIZF1PyurS8V06OcPhLvBh9vDBR5U
         oBXMp+4ZhgdjKxLl0JcGXQxzrrAK274vhlm+7PhrI5DuSGj1Qn6WKMTO4z407k3mQ+2N
         uZLYQN0M7LPVMkq3usBz844+lSHsBgQYSKknC/s2ul2eTY+w4Rqw3wdQN5I6fG4lydOB
         K6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603799; x=1796208599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vAB4Gs4mUDK2JcpHA4TmhZZdgElajeLPnIQDOvFI1wQ=;
        b=BL1Oh5KtQtnWa09QN+zIcB4/Ob1t9QoyoI9e6xAy+AoepeCuwwGZ1n3oPKe46udOAM
         O/8GwBsrD0GJRFQeavBj5Ev1YS0BhVN9ggzX1yJTd0z7sPEru7g24DyQ35YduZgOqnbN
         tmBK3Da05WlNUFSkccf0GQN3sxbeT0IbR6qmPWQ9Fwa60Jq5/Xk1luShoem2lNAOziN9
         Br7J1SVW26ftC6VCS43PxbO9U5aBkcTEZ12UihhkjiI8vSO/FQgsYSkZEOaRPug1MOqN
         MjZTW/svfiAbrO5fT8eVpc+jpnq4RTuMhZCn3nrLlZUfwooyDNVGtpCWVNXyj6Nqu+2A
         7GRA==
X-Forwarded-Encrypted: i=1; AL+hErGUSnRij732G/6WqQUsbgz350JO7UtG2KjqGCuTmcgVpo6EW5CRgXEM6hAcIGxnJozOEtt87kxzjNU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gjiHMJV6S5jWHeOaIMBLZS9htH6vA3OEFqwUmqY1ZgrqmB8ig
	4CfIoIpFIVQCM8t1ajmv1+/xkdSo18gUEnTABFr1INA7ooXwgOYyDIyGxpZQ+VZI3ETVkeuPqTF
	H4tX/xz6Khj0lMGlZLyUmwi14ty/s30yY5xg0ZoEwVGI1stZff1opVDbRfiI8aUk=
X-Gm-Gg: AZFdTZdFgMEXKlowyuicvQvMCNML9tDIAak1MwBYKuX1DlILdvsWdWyPTmW1cT8YUdn
	joZZt5Mel7Il8/hCv+w+N4T9vESLYLcKljPlid6LFVdVv4aT4jF2dr8OWFRZMCuwEYqtB3XAeiB
	CdGOiChZUg26Qz9K+QmBGYXTyT9cmjgWH46gHSCenC0Bh/uRHQsPXC/Py7ZcLPHaOLNysenm7nP
	+UbZyuECBLUUBcJLXFHcWgJ53qGlBbWWS4txVLpvZKNJYgRKulAbetuMQHCEMX4mZnXr+Vpc/ie
	oB3KD3XAUO5b06qwl2aAEs9HQJMQR8XudrmgCs5EyaQ0AKNlNT1o9KhErxaFtpDn66vHGM0X1Ih
	rf3oYDGKALVzxnJy0aj8/x1oJRYNjBHy0EAAuDHZUVM04K7BzoWy5jvOpyz6K+pkiAFBqYtz5Xh
	xGNw==
X-Received: by 2002:a05:6a00:22c8:b0:89e:43ee:6541 with SMTP id d2e1a72fcca58-8c87c38b606mr15448589b3a.34.1795603799170;
        Wed, 25 Nov 2026 02:49:59 -0800 (PST)
X-Received: by 2002:a05:6a00:22c8:b0:89e:43ee:6541 with SMTP id d2e1a72fcca58-8c87c38b606mr15448559b3a.34.1795603798657;
        Wed, 25 Nov 2026 02:49:58 -0800 (PST)
Received: from [10.206.111.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c228sm8621213b3a.10.2026.11.25.02.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:49:58 -0800 (PST)
Message-ID: <53376589-db38-4281-b6b6-f12dab891dd7@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:19:49 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] dt-bindings: phy: qcom,sm8150-csi2-phy: Add SM8150
 CSI2 PHY
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Andrew Gigena <mail@andrewgigena.dev>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-phy@lists.infradead.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-3-0103e8a0bbcd@andrewgigena.dev>
 <a9ab1add-5f04-4687-83bf-ca29a068ee33@linaro.org>
 <f127954b-2255-482b-aa3c-cedd2311f77e@andrewgigena.dev>
 <a519c2ff-7d0c-4aac-9a17-b9e76913d659@linaro.org>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <a519c2ff-7d0c-4aac-9a17-b9e76913d659@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b06bd58 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=RbXr6DfGU6KKkcIXwz8A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: BB6DgKyQUw8yJ1ALWHo76gN6BX9Cf18M
X-Proofpoint-ORIG-GUID: BB6DgKyQUw8yJ1ALWHo76gN6BX9Cf18M
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX4NTuFBmyX9T5
 SmuQycfmbF+xmwzTMe+54fpeFi21D3kdwqOAhfd5kEsLEWTvsGFe0ua/9LQRrpfwzGdqstXRxAT
 SOpuClZxKZ+5QPPZ629oNAkHcS+18Hk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfXx7vLlbZ1Xcil
 mehNb3au4hq5A+6pQiQ8b2kw4FM+Adw2IwfKFC8p6nRY8pINsbRWbPnbzS9rBwfuBp2Jpv93FXm
 Vo3ib2lkGGyehGwE4TY8F17+uZHKaLSXzdjPphSRh41EjLL+Q+QDYXBGfAySzaebmC655qeLOgc
 trL1xrdi4bkCsa9g81IUtCYtuQrX7kBQ6ymvKQAhWvrkn3L/nhUpyF7zalLtaWCl2n2NcqW5Iv9
 kUmLqyuUAbBGvOT8Fpo8UUnuh1FcwMUzorA/uvzW2+ESPneneH0n3Iw4i901vVkDEWFTIftuaHC
 XcP70sny4AsiH9WDClVivdC2xVgltMsZ+0DwUC18biNEtUL+17RhVBUywhYiqKayhUYG53Ym9SR
 U6YJCvQ112cXsjxPj+gtt0juAsqe/POpa+3xfWR9xfvWaL70kLTjHW3eORalFTRASKzwd7IkZiQ
 5X++S44OJKllCmQsWFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250042

Hi Vladimir, Andrew,

On 24-11-2026 15:45, Vladimir Zapolskiy wrote:
>> Hi Vladimir,
>>
>> Thanks for the review, replies below.
>>
>>> Please double check if SM8150 CSIPHY v1.1 is capable of C-PHY:
>>
>> The hardware can do combo mode, but the driver only implements D-PHY and
> 
> "The hardware can do ..." is necessary and sufficient, when you add
> a device tree binding description, anything else is irrelevant.
> 
>> returns -EOPNOTSUPP for C-PHY, so the binding stays D-PHY. Would you
>> like it documented as "not yet supported" anyway?
> 
> You may add a short note to a commit message, but definitely not to the
> hardware documentation. Hardware is not dependant on driver status.
> 
>>
>>> D-PHY combo mode is also supported on the SM8150 CSIPHY apparently,
>>> it shall be reflected in a way that two endpoints could be present.
>>
>> Split mode is described in the binding, but the driver rejects it, so it
> 
> Don't look at an incomplete driver at all, when you provide hardware
> description.
> 
>> cannot be used today. Is it fine to keep it out until the driver
>> supports it?
> 
> This change provides hardware description only, and anything related to
> one or another driver is irrelevant. However since downstream driver
> provides support of some hardware features, it tells about the hardware,
> and therefore this information should be represented in the dt bindings
> documentation.
> 
>>> In downstream camcc-sm8150.c, PLL0 is on MX, and PLL0 supplies CSIPHY
>>> clocks. I believe MX shall be added to the list of 'power-domains'.
>>
>> You are right that PLL0 uses the MX corner in camcc, but that corner is
>> internal to the clock controller, not a power domain of the CSIPHY. The
> 
> Formally yes, but probably CAMCC driver should not enable the MX power
> domain, if I'm not mistaken, there were arguments against it and to
> delegate such logic to a clock consumer, which is CSIPHY here.
> 
>> PHY only consumes the top GDSC; SM8150 uses legacy GDSCs, while on X1E
>> MX is a real power domain attached by the PHY driver.
> 
> Here someone from Qualcomm may help to get better understanding.
> 
I checked SM8150 in IPCAT. For the CAM_CC CSIPHY clocks, IPCAT shows
that the clocked CSIPHY path requires vdd_mx and vdd_mm.

TOP GDSC only controls the camera/Titan power island; it is not the
voltage rail that powers the PHY logic.

Therefore, the SM8150 CSIPHY node should also vote SM8150_MX and
SM8150_MMCX.

> If MX is truly not needed, you may add an exception for SM8150 CSIPHY
> dt binding description.
> 
>>> Still it would be preferred to get 'vdda-0p9-supply' and
>>> 'vdda-1p2-supply' properties.
>>
>> Renamed in the binding on v4, the driver and the DTS, matching the X1E naming.
>>
> 
> Good.
> 
>>> In general the change looks good, thank you, but likely it can be
>>> embedded into the scheme for X1E.
>>
>> Clocks, register offset, power domains, lane table and timer all differ,
>> so folding it in would need if/then blocks for almost every property.
>> Would you still prefer that, or is a separate schema acceptable?
>>
> 
> I believe it is good enough to embed SM8150 CSIPHY dt bindings into X1E
> CSIPHY dt bindings.
> 
> These two pieces of hardware are non-compatible, but they do belong to one
> class of devices and can be described by the same dt binding documentation.

-- 
Regards,
Nihal Kumar Gupta

