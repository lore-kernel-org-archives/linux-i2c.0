Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DA37BE83
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074888; cv=none; b=TCPtJSwo8rso7MbVCGObPTrS//+98zVZelLbHmDaY4uQTF/fwUgkzchrepKicQk4MBw5Sxiqp63N264oETxuIKjmJLj32U7PccFBXFqHf+iXxJjjU+gsUp8DlpBCqg2+bTEd1xvIoFshCUxYwOdrO2Zog3K5+spLTJlCl59Ou2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074888; c=relaxed/simple;
	bh=LUSbYKf76os8+Vz1iMCld3ZOXFGhpgSvvxaDbU0zMnY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qMpReNpUHz7Hfj/GmvWnxBvT8gU1q274pBdhi2f5cn8s9L8tLKkcyD1WdSjiWbT8AgRyJZnKzLo48+gicbhhEZ04iQwed2ymK5jmyjvHTVKWSIzJiQtZbVMY3OAXB3fM0MvXJXbhRehL00TheCGnLaz05q1Tq5GrIkCj0WpXRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AxVbb1jm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CIwytRNy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AxVbb1jm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIwytRNy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TH8abX3771683
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 17:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lJmWWWcIH+ma7IFx18m2vogfRXpnULCsTEE4DquBRew=; b=AxVbb1jmWn6aHqAD
	3m3DsXClFjd7myjwZOnFRTWa4dNFI+MtDEYGk3juTtH/ltD88vc4NnXJWWjpJF6o
	k37lYBJ+Uqh6frAhHx994cLmGJe7MZb0S8j8FM4Fho1eLwEIE7LAtDSoCDk6V5Sn
	/3JoIRcRouFWvm+Adc+2QgEU3TTUVt45Htxs1deRlYLVsmWJDSlB+yBE1d8EMTis
	hsRw2ENtbsQ/aEOcsThOIBlCz3YTIsd60NKhmQLW/LrtqeRsqxxyDHI6DZyiuuFh
	bnFDOA/pZl0u9j+1POMi9IFPkSUJtXFIb2ALMoTSXIR7XePNV9S0FLNs5JGQ9cmf
	XJnjtw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef015c24k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 17:14:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf004bf8beso29721185ad.3
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780074886; x=1780679686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lJmWWWcIH+ma7IFx18m2vogfRXpnULCsTEE4DquBRew=;
        b=CIwytRNy7sV51zrWWBgPLj4q3LLPFlbG5wXMh2v36jW5qcm3MMskSegCzZyRMH/xm+
         X99JcQ+VCx5EFaspsoLAMTw5IpM+anh5sXK6WB7GnHNQMj2y1KFGSdO49PRnRojPqhHx
         58hXkaDkzR1RfKqFqzZbw1FewmNldlkE2J3f7qnomzDsGiP4y82b7K6KBE3DVrf2eZRF
         lbX8T6yiPk3HbKZ0Z+5jF1MVFuBUdITXwdYh+PYXwdK3OIqLFZwAw4NAfHsOjAZYEBJK
         CR8NkfAR3PHAolI3XNC3Ih3R5E9YilyQ5EZp8HoRusF0V1ldTurjNB5eyaq49Slhwjaq
         ct3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074886; x=1780679686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJmWWWcIH+ma7IFx18m2vogfRXpnULCsTEE4DquBRew=;
        b=b2iA2PGG9bJigWLm/rpis41tK8NwqkZs2W8Jt+0GoAtO1RVvg+yFvxSyhNd8K4Nrbr
         ZEQ2jgDy6EVlrpga76wtl51/QS/CgVBBmEH8U7pSjB/t5mgMeMqA80CEVVvLRvFsjpug
         OJ2NcPObIfIGN6xCdsiXTlxKHvznS/yiNWC77nfjwxSsjtAmfgbb/kpgyq8ntEFRPNGA
         wLQ38XzI6Hi9RmXyCsPfceEXCnnQnHt92h3rDSaFVNQgKYR6phzAC5JUU9ZLJA9Eykj5
         +Y5TFpd4B4oO90tLPCmBMozTbpPoAfLo72rbXOUkNcLXUI/AHWEYNW7W65ukKbWatA45
         JpBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cHh7aOAqZIsxiX7sDqfAL6A5PUzvg4J1gdrXvkmyFViZhmdR+oWTJzeoQFbYKmnBdpvS+/EcbRmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaAM9mrBg3TnOZN06B0QlIe9Z92n0eA34jyHYhjNtxVXHIVle
	gWE58rladJbiJptWiPKjsK32QnpXUd9cY4LfAAY85uO6UXHl1T1abdawjkh3AwwQEqbJ04g0VsF
	KGDWeA0WQnX/t6GobAIRrgDNbufmxeZTbvq37dCuX8dZSJz0cM+LDms2sypMCHLw=
X-Gm-Gg: Acq92OEbph3eUUwzj3zCDzByrA21q5Ut4lefvJuVGPFE+HmmtE6tGrCtThl+ZtLVD54
	jV3Rj4689p30Q8C2UIaDjc4JprAQvJ1/2cm0MV5R6ofTw2FQqpVbucu3siQytIA1Bc434GpP3V9
	sBgup5rrpHRiRQOjX36WrYwLV854KABqZr9Dd9IrYjMwegYP3P0sqGvgkohMdvgIGgU+U/YanIk
	Lt3Gyzy9eSVst62nVoO727lyOYhM5QNuLuwaTRjf+qyFkwrFUJZEUq/Qq93mhreD/C/YAwMYGE3
	imNfJyd1Mrg2rCje/TrQmMe0c6+fT5PXIvbZA2UuDFW+y6hc3iWKnvRwfx6FUZGSpzGD+LxuOp/
	zwaj/tk5ZQyVeZfgqIFOXi7kUtI9sIxsMmhFhC1GYGAnnim1nqQa//o100OVu0z0=
X-Received: by 2002:a17:903:2450:b0:2bc:a577:70c2 with SMTP id d9443c01a7336-2bf368383aamr8594005ad.31.1780074886242;
        Fri, 29 May 2026 10:14:46 -0700 (PDT)
X-Received: by 2002:a17:903:2450:b0:2bc:a577:70c2 with SMTP id d9443c01a7336-2bf368383aamr8592825ad.31.1780074885113;
        Fri, 29 May 2026 10:14:45 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.224.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a00a53sm35627145ad.27.2026.05.29.10.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 10:14:44 -0700 (PDT)
Message-ID: <051b9597-873c-44ca-b7a5-29efa795406f@oss.qualcomm.com>
Date: Fri, 29 May 2026 22:44:35 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH 8/8] arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add
 DT overlay
To: bod@kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
 <20260526-shikra-camss-review-v1-8-645d2c8c75a7@qti.qualcomm.com>
 <178000744162.4557.14613962845288279527.b4-reply@b4>
Content-Language: en-US
In-Reply-To: <178000744162.4557.14613962845288279527.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xHXz9bK-iwGl6LO7kZEsCV4WfNuxFSFb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE3MSBTYWx0ZWRfX6TqlXZ2jzAi1
 qXpUb3F67UXR229ke5AtJw9J/i2Gyz/OVKadMNHWMaYXflyo9nJuNHYFzs57Apbe53XiIXVTiJv
 kIDsJ3VZt2g04NR7O6w3sDOPl/SdUifSPfJuwFP4hfrxxmiwce+6zYTfz8ehRNcmFZhOW+25iVq
 ++saQjU3g1o/4d2JJxLz5OOMht5TiwhtBH+uOpO8Ub8MUx0sRx5NBpmcqsX+az1GXKbN4N9rn0o
 mb/moAxymXAq8tHjBO8SZ4VRGPtn4udKC7SHTt+4keXIT1HLh/ykZlCIVKS2phAYDsF2XSeVfpi
 54nBJhDcdjxWWfnusZ9IQ6Dlb1V2EU46DDpgLWaprwA/Sd2beUx+JOW9ul7Cp/Dy9nur6Spit25
 FIBKPlfZVYbSblZJc0cbBNQD8m31BwaED4FMY2U8+frsux8RFS0UlxLR7d9siDViweaG82Xhuvx
 f2XI3BpYfK5cuW8n4yQ==
X-Authority-Analysis: v=2.4 cv=DIG/JSNb c=1 sm=1 tr=0 ts=6a19c986 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=tDSAgCU/rryVExTQDfsVjg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=nnX9c2Y5NtHo51HYM2EA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: xHXz9bK-iwGl6LO7kZEsCV4WfNuxFSFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290171



On 29-05-2026 04:00, bod@kernel.org wrote:
>> +		dovdd-supply = <&pm8150_l15>;
> I don't have your schematic BUT where are the rest of the regulators.
> 
> If they are absent or powered by the daughter board, a comment in the patch
> would be warranted.
> 
> Same comment for previous patch.

/*
 * avdd and dvdd are supplied by on-board regulators on the IMX577
 * module from the connector's 3.3 V rail; they are not SoC-controlled.
 * dovdd is the only supply sourced from the SoC PMIC.
 */

Sure, I'll add this comment in v2.
