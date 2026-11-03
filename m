Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683770;
	b=sEr7VNubXEA/ciBn1hTzu30z83oRJ9TGswgblDM2PneZOXXzGRVwzbaLiyUKmI1yp86s
	 OB8BGajqYqbqyuWYw/2mmcoGIttUmbFNRYj0EwJHE2eTbACHvFo2pPfZ7WNlrfhOXqijf
	 11Lm40Mjjl8rR9d62EL6O1TgIrsXiCEWfnhBnw/QIrw2RlMw/hoXEcgPWqRTSBAiKnOP5
	 W7/FHOc7iDhpS/gY+7kHJIS/83ojkMb1CWIgiV26bAAdcsRLpdYNMdw+xEnhLqIdZxskQ
	 aAmBlGDecEXJ1f+LXH9JHok/ZxgaFNv/pGepAeG9dFw0mjE0lOf3wVhp9MtNT+8s+iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683770;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nauR3Qpw4qDzU3M0MToUxdKJrlvc0tM2JwXipe2UNKk=;
	b=SLOVzrBUTKS6awWcP+Vb+5qTITscs7PD9L/nqJzCrVio44GzdH+FMFrQ3hOcKQrH+H/9
	 RYDI+yoBNGb8RGefN6Uu/htN/iMnkW72sBPO1YGV4/jHJNgA6FAeFbWWHW6y1TreLY2vD
	 DutsBjrWsVm5xOJeLyEicfbdE5ETq4ksTRr+AuSoszJEc27jVKOimaht9+tDOM+AQEkFM
	 x3oxM049y0K2MnsDI2ILr2aDqIbEcpIw2DPcmoRja20QBPOXeSr9FoaCV8n7j0qHy2SLW
	 4qD/urWXWeRWC/rrNwOhiELF+oRqiB9SUyCvTll/qybDK3fovHNapNKYbWUwxSjKy8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q9GBgtRQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bU69q46f;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEE606A32D
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 05:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CDEE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q9GBgtRQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bU69q46f
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31e1xG2402843
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 05:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nauR3Qpw4qDzU3M0MToUxdKJrlvc0tM2JwXipe2UNKk=; b=Q9GBgtRQxImJvKOY
	7Ikqd4ulqysMzq68hoqVh11FXvbQDDuyCDnJhAZ2zfD2nuYN2KY6K6pliIrhh4PX
	DKOArf8UsxsbNLt/6tpSl5R2q8T5oyx92eRidHrtxNrtf8ahgd867C2exppBMnDH
	iYfXrgI2xU4FXvnEa1tTw8UpF0wfmt9FprF7ggY+PwDBJULp+1gMnKD4V1a5qzSo
	oFk4JMSdS+xNthtrUmcfhG92Q/UW/EJhW1WNHUBflv07tTd19aGwbqvHWDIC0P+2
	bctHeDnl0BhYgvGQJjmF0zIHz+oaHGk9PZ9AK8FU6F1hQPfmS370Eick7uy6LN7a
	RZcB0w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy17dq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 05:29:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e954d87b48so56687065ad.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Nov 2026 21:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793683769; x=1794288569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nauR3Qpw4qDzU3M0MToUxdKJrlvc0tM2JwXipe2UNKk=;
        b=bU69q46f8fRtC3RVqsjaS351YsmeEbDx+xAlBg4trIRUyMFOGvfdFzFOD18ercfo6O
         i3+TTXypCp2P8AXm6loII9wgXgh0Y5Vb7kFN0xU6FEhE9EXmO+iSev/NhRa2EthmKWUV
         mJC/23eupq9SfKEiQGB+ZG6AdJHaYZxh9f6KfCnJnJze8WApcjb1RMdV9PQqdYWam8i9
         HrCVSY0k6vvsq05SwN+YMKIxRnMav1GVLR85Xjz/BXwH8V4Gg/E9274QevzSHA3ZsSgf
         mQmyYsmCmtzWlunpy0ngsuHV2g2YQuVMPLvdKgWTSaHVp+T863El2Iici1Zok/If/8uF
         t6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683769; x=1794288569;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nauR3Qpw4qDzU3M0MToUxdKJrlvc0tM2JwXipe2UNKk=;
        b=XWj6whVdpFedqLxNRjbLDu1LuLaKnoJV6r5I7BAxX4GRI0MDilb3LCuKOFaGe2uuUk
         0Qd/blt2jHiskl03nm0gzZM8lgZ3E44UjADYimveow72Vlf61kbYimx+cwKEfwlvBdA5
         L1Jxwu2nOzdkyfaYlaJyTzRK0Ll3Zu3bVSQLM+eAB+eHEln/Dox7ng5lDEjdj4ivWRgE
         4As3lrTt0tQV/5tsqqSbBYakS2C29zfV37NnM+iMLjLcoweuR4n3bgNkStpkAhv6L0yz
         BmwjhPHKS0NH8dwnRAtn+WsH+eiOH2hNyzWJ7jfRcKtmez8F9Jx26Jm4Hp6DwJ0dE5/y
         ZnBg==
X-Forwarded-Encrypted: i=1; AKwUvBwlYfPYnqFLA0MWUBrNevw7TX16d+l46Q7YA3H79/vLwUTmkPYGI224Unst+/YdbefOlfhsQlnoLH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z91YtpM0MtOMCeLx+v1/ef6nqUotYFPpOnsQjq7mY3ms5g4nDOO
	6NwdbCsOmETggWpjRYq2du8KunXXxD9Qy5FriQUueGny5KZnMU1MlFFfBeqvKo/UgV8m/ZqPk+l
	i1piEqR1TNxd5azQIab+gkA3ovlsbbjRWe+3fmmcLbxjygrAhmdWCW7cmYfKSk30=
X-Gm-Gg: AYBFou2MrXMDoL2wwlYNb0H453VzGoat/pq8UqlEQA+4b1OoEvynxsItmvGSDwc07Ez
	lOv9ud9EipQdFaJ10+cppeWrNHz5BUSENvncH2cRLwyKn/cAoN7GpIIxOQTy19Mgys3WVM1E7m4
	CVwmdK5gwgonGt2SjX8Zc4OEvRmvib/YUmxGHnQa0/R0mD8mlITxxQMydvdmsNvfnKivvckHwhQ
	ahMISUEl1/cAvqdDtbPsOUG41HwuHzQf9XALqbUvJnvQcIbgv7H34/5IaZbSzqrhpYtUpm3CbBP
	a0YrZRj3wnk5/N4Bu00/5ne/6PW75IUhso9SRmWNmnze3TCs4qezRjtS/+iNBsZHuamNY2LZQIm
	KE8A41E6gum9uOk7fPVIrQKZkm29GLOizfftPhJgEBfip9YBZuEbW+gTKi2CiXNb5z6DyD8/XmA
	BXOuJtlmX/5j9j8YFd5GOMUWAtglovhiWH
X-Received: by 2002:a17:902:f68f:b0:2e9:7dda:bfd1 with SMTP id d9443c01a7336-2eb364c45dbmr110155175ad.30.1793683768729;
        Mon, 02 Nov 2026 21:29:28 -0800 (PST)
X-Received: by 2002:a17:902:f68f:b0:2e9:7dda:bfd1 with SMTP id d9443c01a7336-2eb364c45dbmr110154855ad.30.1793683768154;
        Mon, 02 Nov 2026 21:29:28 -0800 (PST)
Received: from [10.239.96.176] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f56bsm35371005ad.16.2026.11.02.21.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 21:29:27 -0800 (PST)
Message-ID: <d92a8aaa-5cef-4416-b1c9-46ecfc6b2745@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 13:29:21 +0800
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
Subject: Re: [PATCH v3 5/5] media: qcom: camss: Add support for Hawi
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <fFfGGWaoXA-LdO6s8Xh_kQWQfncXe9YNdpcj2yNkphWHAR_V69LdLOcuhXPsbg8dEUSN4j4yygq4wPre5cz79w==@protonmail.internalid>
 <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
 <5817be6b-7180-407b-acb5-8c5fdef4edfb@kernel.org>
 <73b1f591-69cf-471b-9763-a0b719c74501@oss.qualcomm.com>
 <fac8cd6d-c3f7-4ed3-b0d4-7cb8a7a6f451@linaro.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <fac8cd6d-c3f7-4ed3-b0d4-7cb8a7a6f451@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Fsxq6ZFCf2DAvW-qHazOqbJ6r-1zLFrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfXwm+yR7Zy3frB
 4VXvK77BTXMfz6ZEpx60oHpfeOx9ixeSfjW1C+MI5nKKEaIiJ0yjJr4qRqc01XnCJtD1/F2bzcu
 5ETj6kKgGH1OJz+TOgaQtI6ksxaelw58P5IfBG3rs9xNlOrV4fECyq/QZYQfZDBTwBfYX3+mnEh
 qWT5tfipg9SS319QxryyF6iMSHaCzzQLkCAupFcE5dxCZzOSj70xn8d0VAZ8M7SERTee8nbuYQ3
 oXqy3k0aA1IIvoH9ZWXrcpE2Ux9YeZu2QFzWOxnTFLu4UcUGu/6nqjillkmFdwF0s9e1oGFhn8Q
 XpK0Vcjvyj8cbEa4HI3Y1gc1IcEbGr/5nd85Fvw9gpBHjEFSiSPyN9CUjRK77g8u/Utd/s8KRgL
 ABsl0PMnuNmXPPXPT/NJ7dqDOvyWOAgKUArwn3QUdh5+xFt078Vxd4Yv4SxkifWCkJXEJCYUZ71
 IvCn/XjR/DBBJL7ykiA==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6ae97139 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e403w2VLNo3D9SQJzk0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Fsxq6ZFCf2DAvW-qHazOqbJ6r-1zLFrr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMSBTYWx0ZWRfX0P08wkuxnYQ7
 uRQGrSf5ZcQgVpylTuAR9g/Mn6YxGbB/cy3alp2IG9afgNc1lNLA788ZJx+vLvkUAqbGn4j9yC1
 N+HUssuuP2hPBZZ83H0Ulvtfbj8s74Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030021

On 11/2/2026 8:58 PM, Bryan O'Donoghue wrote:
> On 30/10/2026 15:25, Hangxiang Ma wrote:
>>> On 30/10/2026 12:43, Nihal Kumar Gupta wrote:
>>>> +static const struct camss_subdev_resources csid_res_hawi[] = {
>>>> +    /* CSID0 */
>>>> +    {
>>>> +        .clock = { "csid", "csid_csiphy_rx" },
>>>> +        .clock_rate = { { 480000000 },
>>>> +                { 480000000 } },
>>>> +        .reg = { "csid0" },
>>>> +        .interrupt = { "csid0" },
>>>> +        .csid = {
>>>> +            .parent_dev_ops = &vfe_parent_dev_ops,
>>>> +            .hw_ops = &csid_ops_1190,
>>>> +            .formats = &csid_formats_gen2
>>>> +        }
>>>
>>> This looks strange, why is there only one clock rate ?
>>>
>>> ---
>>> bod
>> Hi Bryan, the current CAMSS CSID code always selects the first 
>> frequency listed for each clock in the CAMSS resource table.
>>
>> In camss-csid.c:
>>
>> [...]
>> } else if (clock->nfreqs) {
>>          clk_set_rate(clock->clk, clock->freq[0]);
>> }
>> [...]
>>
>> For the CSID and CSID_CSIPHY_RX clocks, the hardware supports three 
>> clock rates: 200 MHz, 300 MHz, and 480 MHz. If I remember correctly, 
>> 200MHz and 300 MHz is not sufficient for the sensor's output pixel 
>> rate, so we need to use the highest rate, 480 MHz, to meet the 
>> bandwidth requirement. Thanks a lot.
>>
>> ---
>> Best Regards,
>> Hangxiang
> 
> We have a series from Antans to address this though.
> 
> We should list the clocks the SoC supports not constrain that list for 
> one specific sensor on a test-case.
> 
> ---
> bod

Good to know that Antans has a series addressing this. I agree that we 
should list all the clock rates supported by the SoC rather than 
constraining them for a specific sensor.

One additional concern: if the clock selection logic still always picks 
freq[0], listing a lower rate first could leave CAMSS unable to work 
properly with sensors that need higher bandwidth.

Could you please share the link to the series? I'll rebase the next 
revision on top of it.

---
Best Regards,
Hangxiang
