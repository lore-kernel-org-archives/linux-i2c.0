Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E04339861
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791466; cv=none; b=iVjrda24eOTVkEIhckU34PCdXqDGk1SrgKmYBZKV0YxlVw2YNl9jFpOAkQ6oGEzYwkO4LtMSAP8V8WQR9DYPNWdchElV6rlaBhey9rHqJaCFqBCW5BdVQe5UGfzVTD0zCSNvhTfjvx+/sBtz7Xf/GI8J6jh+T5vc3diVAaIDYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791466; c=relaxed/simple;
	bh=yez3OppoYEvzvHqgPP8Op7queq7voD/wLWYBFRMWLBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHZ6uauukOh6AICChgtpdpFfwCd9ZS9BzAEpLbfrFV/2h55GDTaT9JQpDCmCKT/GDkT6s7HgfapQ6sQkcEwxuprnOvg767Ni0TM20qVKTHaJkZq6NipZbrpx2lX21mMZ6il4uf/bAtseQ9m01k1ngLM92P40EIhWfxXON6s9Yfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2qblr0o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LiJNUhhN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2qblr0o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LiJNUhhN"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAwCm11489610
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pb5P25J2+yJr3aAp+kbXRtjGFi3YnmIjvMmocPYH8eU=; b=m2qblr0oNwVVtmR9
	TodGEmHOfngaCo4QwGnQUdtX5YvzULPmU4WsunCr/24aceVWQxm95tJvp1V1omT6
	PHyirxWgYzuRNogwJq8DnyEE2g72PknMs4u5YsAZDjnoarplAjtAn/Uz4s2/uVxN
	6TrhMZ1/MRm+nZkl0VX4UkfCv1TkM1IEc1h+To9kc1O4pJGyfk2YxlW3J3koeCwd
	6fjm+zEBwPWaMdKDdSv8Y69BcuWKzuC6R3xdK3QjVIpUAZuupIHTq/QwT6Dj/WOk
	SREFlBjjd1sx2j7EOUgJMpYZOtWysykIeW/u4ZA4K5e5A5cRH3FSvjDSOkTs2aCF
	RrDa8g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3uxxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:44:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a79164b686so24536705ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769791463; x=1770396263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pb5P25J2+yJr3aAp+kbXRtjGFi3YnmIjvMmocPYH8eU=;
        b=LiJNUhhNAN2F8A1n3E/Nnmska7DDhGOooQssq0++qeR9LbjFve5dwP+t0ee9vPWBw8
         Je9w1L/X2m2gZRdfbf9yfGe6JuGe4ATwwSk5UZY0woJv+sco/F+idHDTVX9FrF3wEzdK
         h1EEq2nWU6imAOqre4Nvu3ugcSx5ZdBysCiwzf6raUpluYaAHumaBd38FMcXMYV8UNJu
         Exdk3FfVS9sBzD7O/869WcmJT22bQT7OXC0hvEBV1/MmE0bZof8rk3UKm6oOAWhxdU57
         kSlosPswWptDIdgsZFpJbOnP5/DWBHHdZGYiLkYGYZZNDUc0qKLWeTgq14+Ns59W/1Do
         /w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769791463; x=1770396263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pb5P25J2+yJr3aAp+kbXRtjGFi3YnmIjvMmocPYH8eU=;
        b=Y4nbaGo3skpx+F8Rr+qoAalsQOgF3BuypbhVkXHQ49kkGyLBJJb8mvhDlAUWuEYJ4Q
         KAxRAPkzno7ZEwDheiDL6X7BCDT22jV+sjDFfOMsPvx3HIozYsV8BZPo2bSN7EYcRv/K
         1BZTMQMTa15sihcA+1KDSWNwTw6VadGHAmWu/gWnKn9bLLAw/j1lYaahS6PclJodbZj3
         UttYlbVQ1WfwESjYqo3tDWhXn3TaRT6gHQHWid9JpvSn0MZFWtp6b2WaWNYLa7137301
         ifoATkAb2OcJ2c1OzG+JgTAe9B5iP7gZjOZrgUCh2YPT5X8/FtmXd8/gkkqjNekGJS6y
         WowQ==
X-Forwarded-Encrypted: i=1; AJvYcCU72OJPpZXXoqcYgbOONEMgoXzDFYy76CiMSkImLhb5CiotJvlOalmna+sL1J3BLa7dUu8QrA2XOmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdzUDQF2jMyzPd4abjEe8acxbOwdpSj2byPtSfCoHcF6Gi+KUW
	SfL1sRVpvphlqYHL/Z/FL/t9p4ckqua3wTsb/2NXZjkuzexvAGM7+KA3pTi/BRaahKa05WCkX4A
	xkZLWI56Xy4+TQozx2SI/PBZTZCwCsjAkkIZiJfPU//TfaQe3mg0PM0xd7uuX86U=
X-Gm-Gg: AZuq6aIts3miAUhv0jyhg2MkjqprL/0Sc2UfknE8i4p6NhqUAHDY+2FOQInV1ojFhMY
	NfoiiUqWM79lPBVVJMsCs0brN4RFgpE0cAtvCRUg0K63ksSIjErH0Kg2TkFxrlCnk/KsNO2TB7h
	epLcwHK7Qw5i7aMrXLfHwNqPIO05U9YtPTh2qD2/j7VJFWaXNsIsnrC+/QmO/5SQj0QH3nbqktP
	byR5sx5G6GDgiOD6qITydpPebCu4E31cVTFm6qosp1It3Yelkyx5ZNpPV2uNsS2GOCdxCEgjwjT
	fpJ62vcy034D2Nc0EcNIVYaxVOKB3zvfzYcRhh5EO5Xaqlw8lwbAvVluFg9Auas8cgVsdOr29wI
	jkdzugEWr4I0z7MUiNGorz3jgA4brCua1cNK8tmKX
X-Received: by 2002:a17:902:ef43:b0:296:2b7a:90cd with SMTP id d9443c01a7336-2a8d990aaebmr36989185ad.32.1769791463350;
        Fri, 30 Jan 2026 08:44:23 -0800 (PST)
X-Received: by 2002:a17:902:ef43:b0:296:2b7a:90cd with SMTP id d9443c01a7336-2a8d990aaebmr36988745ad.32.1769791462739;
        Fri, 30 Jan 2026 08:44:22 -0800 (PST)
Received: from [192.168.1.7] ([49.204.111.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9e25sm83063825ad.80.2026.01.30.08.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 08:44:22 -0800 (PST)
Message-ID: <e9d3c0b8-2abd-47a5-b594-83f0288d95ba@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 22:14:12 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
 platforms
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
 <20260112104722.591521-13-praveen.talari@oss.qualcomm.com>
 <8e410852-37f2-452b-b851-19b7c4222727@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <8e410852-37f2-452b-b851-19b7c4222727@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tXxLqRE8f927F-qtcPPIiSWADlaVVSxA
X-Proofpoint-ORIG-GUID: tXxLqRE8f927F-qtcPPIiSWADlaVVSxA
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697cdfe8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=10aD+GSAjGS7IfLbEAHBKg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=hbV_D0MF1U8yBtKqu6sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzNyBTYWx0ZWRfXwtFWlms2p9Ky
 e/36o66Bz8P5ITilFjyL3UDnYXGajMHQjAy0N5rx2pYvng3vGZ491Sta5g1qg42i9KbNXpg70Rh
 /2uqW3OPii6hm3H4rnHeUEHHzcU4aRTHqr5qmHpZGfO1Xc6/q5WEdOYW8sog/C+yhshSPuFNYS2
 jD+GnMsdf20IpYDq7WIbb2QZE88Jjn8k+RwCvCJAGf1Updz7nVO0WUMJXkj/VAtxbbYyLjizUdq
 b8kxOdnC1RV6TSbk8YvqA4spAe2cH2kA8jYEjlpUEVJwl0uuFkEXNCTegWo50U+lNOuKQZXNuEN
 ibqsXm/0LVpeRYozWeKEQBX2KlavkSsshS/mA6RWHMXpOGK3vfAOVK4wJMf531VOZOah06Y6bIU
 ak8ESaKEeNd23bL7a30GgV+9v7NTiQLbqqclH+MX/klndew4licFjzsHe+Tngsv/Wffu0afGHiK
 xerUkSu97tbhxWoVqdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300137

Hi Konrad,

On 1/30/2026 6:04 PM, Konrad Dybcio wrote:
>> +static const struct geni_i2c_desc sa8255p_geni_i2c = {
>> +	.resources_init = geni_se_domain_attach,
>> +	.set_rate = geni_se_set_perf_opp,
> This means, on SCMI devices you won't don't the vote on the POWER
> domain (or PERF for that matter) and switch the GPIOs to a _suspend
> state - is that by design?

With PD_FLAG_DEV_LINK_ON enabled, every pm_runtime_get_sync() or 
pm_runtime_put_sync() on the device triggers a corresponding genpd 
on/off transition. These transitions are translated into SCMI 
power‑domain commands, allowing the firmware (GearVM) to perform the 
actual enable/disable sequencing.

Thanks,
Praveen.

