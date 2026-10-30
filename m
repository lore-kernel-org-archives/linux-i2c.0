Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373951;
	b=DzxzmIzKpzQWOaCA6QOOyI+5x/gnZfjW/cuj4WiRc8r748p4AZFybxbhmUc/2fWGb4i6
	 EqU3OfTgdos73qrFf6Y95wqZhJoSxhUflaz4wBxyQg+o1MTEY02uRq9H1/Cu/pmWaVK/N
	 EQIgeczzQNHlGldpMA1NDtIoneziNwF5KyS9o0haHDQKaHQTh+FQeAflYE1wt4u8s+2Wd
	 YHb+VWwWkDx8fD+tjGNeTUsQ2oS7KBC22NOMOLAICAYBsJ816S0TAhSL1TR3j4TUvbdPm
	 Jbo3aXcbjXr5K0U56tz24YJ8le8fcE0lRqX2mIKHmyS87jK5+ir9azoAu+HcYBNBKFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373951;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HAanuw/65QLamv5I/BsAigacYne4PYbrmQQm09dQCp0=;
	b=XIld+J7LfeXkHui0ZAG4LtlJp/0nynA58AT5InOQYG8mslzYEFE2bsntOkuNVNZnhOdr
	 7VIQaJLD/LB5BaXVBWFLcgiRA1KXi8fcAbjo+RHISgsnhq/WgiTlvO7FYzm5qywRtiIEo
	 oGXsv8JMVTQN3AzonFSA4IJiECI1+rUPM9iFreO5oVgfbDLz2m52o3u5oBGtUJhifatqD
	 ocurxk8Nt4ThHK1yCAg+oiPcWwlcrz5PktkNzx+gDR3GpORaHEP4L4U5f5RIQYS7+Xp2R
	 x9CTUWdgUUaubntFTIchOYtjlDKgVwokA0p7aTDgX3RnnBf8SB66evNoQwVQUrf62yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="LtUJw8K/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YxKyyf5m;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19011606A320
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19011606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LtUJw8K/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YxKyyf5m
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UERBth2494580
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HAanuw/65QLamv5I/BsAigacYne4PYbrmQQm09dQCp0=; b=LtUJw8K/jVPibXL7
	Nm6X6MfGfw+jsqw0QHvh2SPqp7FITBDyU6dhveHHRWv4sDrLCiMXu7elwTdgxcv6
	Q3v8AS060Pha/MLTvN/d27jg8OzlGalrMTvDiPa6nz7k1ay8ai2sTBgzM4gQT5Ln
	P58OwN8NvpRQjWM4defAPMQ4BkxF/aWafIxZTjLzBXw21cqPCfsl4dNYSyun1uCg
	FcsITEjBEJGGtVM4bH4yu56IqmfgJB7U4LNJ2aO5u52hh6bPk1YqAP6/UTf06yWr
	aZWscMPIY5o0ShNuCabk/YQkhXFls5MXy89QqX4jA8/yoUx3lfFZFSjl9nYoT27x
	xp6Smw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3ss0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 15:25:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a05a4396d2so780629b3a.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 08:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793373949; x=1793978749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAanuw/65QLamv5I/BsAigacYne4PYbrmQQm09dQCp0=;
        b=YxKyyf5mwMosBl9MsKEIUJrBY/Lys6qbKF32l6aV6L2rInMpSLYYvLIauDL7z3tfIJ
         vc66hK5TS6Z2m69HUNfr/t3hmJg+PRVFWH7WBg7U7J5Muf/qvUWdeRtob2dz98N8VPKI
         C8MmW1I9VKP6JQ5BjQRHsy/dqiFPmWIbYBqBzA+N+PMs0jsM93cLUJbyvVcN1XCIRA82
         DM9W+P99WFUgAlkw7tC/O5wSB5K45/Wx56YgZOeND7952LvlYW0Da53a0r5k2d01o6k2
         516tsdFxfXgYvwgMdOSKhZSW8nOZsKDNMF7qNilFdRDmq+WKhJndJuXZX+5GHRbcPs0G
         UkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373949; x=1793978749;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAanuw/65QLamv5I/BsAigacYne4PYbrmQQm09dQCp0=;
        b=zNPSroorjT4ecwcF1lnZlzVkDWyL65dfJd/FrnyQL3Dp6j/dDXBuxR49G/iuC92OhK
         KUSyTS8Jc9d21YjwVKyP9sBDCZs3SaI0VdwIVCwuNLo/wDTxJEJ7TYSqeN8xWJ+fAr6g
         S4nj6OQoeRmxDAJbnQ/GPnPivsHB+cxdkiidQM6M+VUWI10+ApN5Kh4yiyAiBc/wjI5w
         xckZv8L0V144ObkOnNTB5MijtmRyR26iTPTeRMuX+HTBYlkypK3/OTk1n6t38ZeOKpUN
         lHYLxFbT7VGhlsjPaVAsdrph/NKPhIoDX2HuiNG4dzPV9a0CybqFksFce8yY8BQNwOt4
         8Umg==
X-Forwarded-Encrypted: i=1; AKwUvByTAVx4AxaEV6j7R6ZxvN3ACj3w42qtA9flKr02ArCY6KqwhkGECCN2r91Y+qEO9zycAavp1x63rvw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeiezn4Ap4QW3UiKoAWbYWX/ONTPnRoMosR2fLjMSE5R25lgX+
	YxZOjGzWh/GPejqib59J3plms5iJOBv5JHffIttaiSHFTWEKzEzPco7NLBpyh3wtZacuvQkc3o/
	aM5hBlZLD2pWrALSo6wL22RsVQ3JN4cnqKG4HeeFXVrfMQkii4biZdbu0a7Zx1K0=
X-Gm-Gg: AYBFou1goISrjjs60ZTIG9en/2EvPS55192VFyigkEo22JXVDAEjb+PohGntiWB0gwV
	Zfr2SoUkrP0rki4acpFj1YaQoooQskqZXR+gS3tYkGpXT8l5h923kJmd72qyG8qtz/ymBYic3ls
	uOLUcU+5DtMxSQ4Ds2sXmbQ7J5lwuIJi5sZL3OUGOLGH2R0Lk1GR2cHqW/n8FP0nRw8oE7vgngg
	FFNQv8gveFDzJnVK5Voh1TsJYSHI3eNX0WZCKnBL5GzDppaGwP554oTgC2CYlnPuqMyzGhU0p2L
	73F7+C7gHqFR/YkESZmewhSFIto9aJoA66WC9e8/J/+9wf72RpoWiYRdTB2+2aTNEpXGC3XZI6N
	l6M5g5ndZSC+VtbYMfrKa93gilP3oUjUV1UgHMWw/XDs6h5uaDXy1nQz7zDf4JoxfOixJMrkhDD
	IDyywZKPzwbkmnVTbZOhQicAGvozYBfPeigs3E
X-Received: by 2002:a05:6a00:12ce:b0:880:5fe5:a818 with SMTP id d2e1a72fcca58-8a9bef522b2mr2301173b3a.59.1793373948959;
        Fri, 30 Oct 2026 08:25:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:12ce:b0:880:5fe5:a818 with SMTP id d2e1a72fcca58-8a9bef522b2mr2301134b3a.59.1793373948472;
        Fri, 30 Oct 2026 08:25:48 -0700 (PDT)
Received: from [192.168.1.6] ([117.143.160.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada2dec47sm141926b3a.36.2026.10.30.08.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 08:25:47 -0700 (PDT)
Message-ID: <73b1f591-69cf-471b-9763-a0b719c74501@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 23:25:41 +0800
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
To: Bryan O'Donoghue <bod@kernel.org>,
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
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
 <fFfGGWaoXA-LdO6s8Xh_kQWQfncXe9YNdpcj2yNkphWHAR_V69LdLOcuhXPsbg8dEUSN4j4yygq4wPre5cz79w==@protonmail.internalid>
 <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
 <5817be6b-7180-407b-acb5-8c5fdef4edfb@kernel.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <5817be6b-7180-407b-acb5-8c5fdef4edfb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX1/ytIolGYuMa
 /9l0HDpNRGEZ6enK7tdbfK3yZ0UWQcqYnaJ3ljq4l0GVc6xsH0ncnxnz9lkMRP59JcigYmh5mxE
 zF0R4yq1wP45d2H1Sw3AgeXcHqjMvNTu8AvV2ltC+TOHt28foz9QjFGSj/NnP0fwYKIRVNnZkxX
 aJ6VIQW5HwibmeXqqyH4oPN9vwBt122aCIYke45M+VY8yVqQ5OJstQ2x6l4+8+RMPrtV0+4gAbU
 310FQ08wYdx5XWMNLft8Fr/fSe47KMadplPk80d9grE6VKhjn9tpKeIvYIzdJIMeqdVl+k2URic
 IKQHiyTuEYS5mOEJRb4ny0BSv8kIK4f3FiWm8ycNxnAAk7uHjRpaw+KGrkUrHCGugmz63DzeWKp
 8CzKL/LrROyWg88MBCnf1tAkAOt4ySdjsd+Di4RgGN5IRmC/aBgvgQBgGuYeUdn0LR4Wi70kOrp
 XH/fzY5kaEfxS/9SPmA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX5MAkVXhsv1gT
 lUJ50w8SuO/6Y60ZR92L+Rn6x4SbZbbutglYzabN9soVQwGIpHedS0kMuXVIRvyLi2mA+W/JTzz
 O23V5NbGup7GeRO1V5WzqYNFjKaaoZ8=
X-Proofpoint-ORIG-GUID: UM72qHO-Hwf0zGglscSKASfVlY3a7th3
X-Proofpoint-GUID: UM72qHO-Hwf0zGglscSKASfVlY3a7th3
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4b6fd cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6d0oVIyUxUng7TJeo7N4IA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=oDwHtdCdAfthrX0yCOUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300061

On 10/30/2026 11:04 PM, Bryan O'Donoghue wrote:
> On 30/10/2026 12:43, Nihal Kumar Gupta wrote:
>> +static const struct camss_subdev_resources csid_res_hawi[] = {
>> +    /* CSID0 */
>> +    {
>> +        .clock = { "csid", "csid_csiphy_rx" },
>> +        .clock_rate = { { 480000000 },
>> +                { 480000000 } },
>> +        .reg = { "csid0" },
>> +        .interrupt = { "csid0" },
>> +        .csid = {
>> +            .parent_dev_ops = &vfe_parent_dev_ops,
>> +            .hw_ops = &csid_ops_1190,
>> +            .formats = &csid_formats_gen2
>> +        }
> 
> This looks strange, why is there only one clock rate ?
> 
> ---
> bod
Hi Bryan, the current CAMSS CSID code always selects the first frequency 
listed for each clock in the CAMSS resource table.

In camss-csid.c:

[...]
} else if (clock->nfreqs) {
         clk_set_rate(clock->clk, clock->freq[0]);
}
[...]

For the CSID and CSID_CSIPHY_RX clocks, the hardware supports three 
clock rates: 200 MHz, 300 MHz, and 480 MHz. If I remember correctly, 
200MHz and 300 MHz is not sufficient for the sensor's output pixel rate, 
so we need to use the highest rate, 480 MHz, to meet the bandwidth 
requirement. Thanks a lot.

---
Best Regards,
Hangxiang
