Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56A8635D
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044041; cv=none; b=sStyj6+i5+vaf/yhP3oAHMEfeiCYAEaQBiYhEgHyfbiAocGjancBW2sSRbOa+tddPuLw6gJ8HGzamkEkyM8Uh5GRy3PowbK2D7jwcYd9J12y7RSTU+zjQtsXmhD3yL+8g9/jHRRqm7cJXaJ8ZSRuExDMbf1VAyyP1fc/Pc2ddIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044041; c=relaxed/simple;
	bh=UqeDK4RsfAzKZ1rg6NnKveKlrERd9ILP3xgumZ/4wr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6cbBvwrm64r0cDcYT7WV9vA9Lsyie+hhnBEVxxz0X8tdR1C8haWSBY4zqiWjA4I1qls27VqjksHrDIUJXpjJhia3jb5El1uY03loKB9F+erkdf1xvuT3bXzViHTKrUtoXPUx2OdbSSciafNFMIQ2AgHM07wG3Rw0wQdgEQOsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VGzS2n3x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kQrdi8g5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGzS2n3x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQrdi8g5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612B0MG92899912
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 14:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsknitCYb9UiikAxJqZ9uv2e+Vzn8UiuNyv88IZxQ/Q=; b=VGzS2n3xh3AWYRCz
	74VKX9bgR8mA1WDUITCcmoc6e+RqAyg7PQ8OXOseItw0+WXB0vFhvSthIIRQ41O3
	V0hNtCcA5yVKvrfFmseiiWfFPGB6tKux5I4yL6d1ZMc9Uw9+KC2YRirSdQ7fdJg6
	Etc3uNPcnMXJ9K/lpN29LEjtAiuGXuBe1UWlWEJGmZLN9C8EKbgP3m5ZMbG7jzhl
	xx+AUZxM3UWj4eUyr60Nh/hYVP8Saq+HVmyCyZwcgRBESEpl/eG1DL9NywTppfS1
	ZDJJSuqd0+hntCaWiEvra55oST9NkkbpMYOcgxOtyx7JCzSCQagsgNqB6qfsHvV4
	I1ByIw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tp0rm6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 14:53:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88fd7ddba3fso14477216d6.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 06:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770044038; x=1770648838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsknitCYb9UiikAxJqZ9uv2e+Vzn8UiuNyv88IZxQ/Q=;
        b=kQrdi8g5mXF/FMODWzUXqMBradhW3wTezdIgwjakwgOXAJCdtonRRT8l4PuPJFU+BE
         79iU1u43HUUYD/Sadw21dWDCCF7pPI9USgDR5MZLjnY7zWLCTJeGvX2J212bo4zlM+S/
         /KP4wG5rl3BfPnbiiE7qGhrCbNZvTAUNgVzFiblP7QW9I6OEQOBu2vaYregIolITOyAs
         PZT4j8U/0g4vxdifzD7oVzbrV2soOEyGg4wnmwVQh/aXmEBexumlIClmcXh5la7mv8it
         tUyCQnD+bUFgNjTsYav7uXfHFQxDk/8O70GVQPxrPf2NtIAOxZWqBChBiZLASWkW9yiD
         WlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044038; x=1770648838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsknitCYb9UiikAxJqZ9uv2e+Vzn8UiuNyv88IZxQ/Q=;
        b=YannFdW6+9RTNaEMzBuDKbi2Z9vQt4EV4TocManQMXve5lOTbiEOf4MvCQErqCI1nW
         kP5dM+ya9KWxHT5Qilk3qVC3BmDQbb668dQH0sXw/WRZKp0bFT6UPkBxu3kBG9m4XPI0
         j3jEhArUauwXuGsnsW6EpWm+lQ+lLSs+BUR5Mts3KfkCciCBu/A5zA/14AIgoCXCihQz
         hnFO/xdJji4d64BSZghvgI7NDVdtu+CuJfsdOuNtTTnPJz5yieNWoPokadHTGsVp6424
         tqzSmc1dQLhLqcYJxU+W5BF3HCp2AoVGtHwopm0aSGAdVu9XPtpV9o6+cJLrESYDzYtu
         RRuA==
X-Forwarded-Encrypted: i=1; AJvYcCWt28NKOjqdm/Rz2SyvC3HViUfWziuvN52t9qI+KW3l9Kh7an1tgS63dxLiXpAbL57s6y/w9OACgIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzau3wEZuowvPO52kAIKnMoIqL0sUeKw8qJxo9F05gy2RIvHvs/
	ecOS/QJouQCmgyyTYi+bJtVaYyHjPDIP97dIz9h8eWJUjalkaR3iodGUUPnHtFltv19GLXSHsFs
	XufWa0uJdFzn8DyUPoZwZrw2+1Mea3d8b1w0FyoaN6DPH1ON7SCU2ONNWVNrbuQE=
X-Gm-Gg: AZuq6aJY03n1Tl8nan/fnsWyQoC7sWYi9rU4lec2NR73BH+lVxJmo89o4EmUPq7zuN1
	anoJ1Ohulrc65vRjRZx+CpRzyKFWWHRGZXHarX0bHoeaGWdTbUua+dix0LiPitEJkbYQWlE5IkO
	OEqPcv55aFnrssaJ5Lx3w3quZyqjD7XUHBniZq4lMiqLhESslqxmGj8xxO3D2ws0FyQLWS9TJsa
	+cY6gFsrlfxjcHdL061U5DchPIdg36nls5nCZzhkHmop0n04PFHT2Mm4e6OiQFVQcWq04Y8Vsu9
	HTmrQJ8KvxfjlH4x8J3cxBSxoHu6RcK1Ci26gmOslM/2Wjk+/uFo2ffXTRfOzPwzvAuaZY7keCP
	x7T1izGoROHeXzIl1QrAPteOzf/yiRlCU4iGRpnc9/RfoXdQAylP7nL18iAelwddboPQ=
X-Received: by 2002:ac8:5889:0:b0:501:4504:6f80 with SMTP id d75a77b69052e-505d2288f8bmr124104431cf.9.1770044038182;
        Mon, 02 Feb 2026 06:53:58 -0800 (PST)
X-Received: by 2002:ac8:5889:0:b0:501:4504:6f80 with SMTP id d75a77b69052e-505d2288f8bmr124104051cf.9.1770044037676;
        Mon, 02 Feb 2026 06:53:57 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e07481b5asm3638004e87.19.2026.02.02.06.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:53:56 -0800 (PST)
Message-ID: <6e5924f2-a9e0-45db-8a79-b328ebd12a0d@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 15:53:53 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
 platforms
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-13-praveen.talari@oss.qualcomm.com>
 <8e410852-37f2-452b-b851-19b7c4222727@oss.qualcomm.com>
 <e9d3c0b8-2abd-47a5-b594-83f0288d95ba@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e9d3c0b8-2abd-47a5-b594-83f0288d95ba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zGljS2rUgeQ_3RWNMfaL1TtGA6J2tREA
X-Authority-Analysis: v=2.4 cv=VJ/QXtPX c=1 sm=1 tr=0 ts=6980ba86 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Hn_5opO5PlqZgVx7yE0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNyBTYWx0ZWRfX3W0qx4NHpEkr
 ehc7TBI98XBWJF1XXa67lPUHTfv4FQ6GLKLqxNaZcFLCnDHslOSK53sJaoScotKdjd50/eYPSVJ
 HH3LJtWFP5YuAQNxlLzQhxqhZ6Keq6UZn2zkFVNLoQtBxwvjXbI4OrRwE6x4Bh+VPfS7UKVK7vh
 g/JRyeyy+sb+FuWZ3hRPw1vHx17ot1E0NndwCbgqZMaaQLpGc6KR/nNkhc5KiaBFjnyC2OQrtgL
 LMdXfJvzTFZttrSt86xIbG9YUDtW2xLJ9Um+cteWYJ07ccr+F4kTrS1kjJFX3bak4vqGvXnCvoo
 81gTBj1KQdP1r2y77WaUQalxKowv824xA+0STZxnDO6IdUo6Iwu3FaisMpnMbm6z1YJoZU/KDQ1
 ZWvdMjerqWFiI+FrGL30F0iWAz+NP/vp97Q2GCcL1uL3lRYxaGdpHaLAH0lIYVM8I0lJOjG0LFm
 Vme6z64aatycpGcqk6g==
X-Proofpoint-GUID: zGljS2rUgeQ_3RWNMfaL1TtGA6J2tREA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020117

On 1/30/26 5:44 PM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 1/30/2026 6:04 PM, Konrad Dybcio wrote:
>>> +static const struct geni_i2c_desc sa8255p_geni_i2c = {
>>> +    .resources_init = geni_se_domain_attach,
>>> +    .set_rate = geni_se_set_perf_opp,
>> This means, on SCMI devices you won't don't the vote on the POWER
>> domain (or PERF for that matter) and switch the GPIOs to a _suspend
>> state - is that by design?
> 
> With PD_FLAG_DEV_LINK_ON enabled, every pm_runtime_get_sync() or pm_runtime_put_sync() on the device triggers a corresponding genpd on/off transition. These transitions are translated into SCMI power‑domain commands, allowing the firmware (GearVM) to perform the actual enable/disable sequencing.

Does that handle the >1 pd case too? If so, then all good

Konrad
