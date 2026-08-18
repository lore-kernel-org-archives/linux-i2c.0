Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551B45D1BF
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050689; cv=none; b=f4NpfXRO6REurvPJkN9B0cx+OtLhIUz9ISoDDAM9+TA0u3Bvde+lOCeeCr9E+asAqdLtPKDbfqFvkwPlIVnmNlAAy63vn+7elVk3iZZMbJR2ehVhYzuDF7VE1wRy0+m0i7brbhqwUke4H1T29poohezBsVSQsiDQeM0rvAuTbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050689; c=relaxed/simple;
	bh=fc8mtRICqk1A+tEuhO6tZjfCs0T8tmhcsm8XXWFHrQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kf3P4eUzLZB381gQ6yzZOGXXaj154VE5giSyGjfFFVs+AYxRhSpIZE9z4bC1G8pZ9uw918Snx0Lrw3ObiUS5QVZyYwUopnOOXo22iUBbZzqyU5cnB/wcKNgYwWWKjjIkvLayobMtw56i3oF7uDSZz3P3yQTZhjwaI6OSRPKpfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JikEe784; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LXaLup8M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JikEe784";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXaLup8M"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABQVO995804
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 10:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ZmljmY2VxRttGL9utUzM/xk6qkrXqCsOpJERDJDfAg=; b=JikEe7840zBZkKn4
	iDGgS/MQKyskVpjvmi27NBHPqgfbXETGLyGhK+VOIK5EDqOGKsZWQs1nv0HctEjj
	7NR9lvDjQfWcvfQMTQlXQ7JllKyJaSk1wdtUSjT26tCoebNDfR2m0MjvXFsR5mc6
	KBvae2FuarPuLlsVKm4BAdXY1rPvkXWtynDYwgT47sOcBJukiDY/BnOXABvVLoit
	kN8rqpItxj5kZmrv/0nB63pOg8ZNOeaGlxWY0O25J9CluxZF3gL6e4UDEnry2SeX
	GCoU79HoZeasZtWEObW10LpMONetvq9lqoQMbO+wUAV3JJrRCaMksVH1npmaGkFw
	n2k7fw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615m141-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 10:58:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc6dd43737so94897065ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787050687; x=1787655487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZmljmY2VxRttGL9utUzM/xk6qkrXqCsOpJERDJDfAg=;
        b=LXaLup8MBreV3XH700APQLpBDM6DuK9H5Ml7rkNXYoqK/JbS/SnAolQsctv1bQptoQ
         v6KweM5WOPa3Wmuadr1gPSR5HxIeks595a9pzWMM1+qdYFFvB88IXcGhhPIpNdg7srIt
         bsvhxPI1NJHpyIn81NOkos029NyELkQzImK4pk9kCE8G2lZyUAPGrDIscRrt18HA4ps6
         Z8lMCZB9eZGOXqld7rU9Fx38U01zfo3yFfYtZX46JiTygbxvJAGtBd0HmMTWRC/GOOm8
         DWK5Ro+SlvTvwlf+0WWhQXaeUimW0PuIbnN594W1QkcNrBA6KRHtVSrrErMnitH10oyi
         aKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787050687; x=1787655487;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZmljmY2VxRttGL9utUzM/xk6qkrXqCsOpJERDJDfAg=;
        b=gW+oz7wYk8y2Z0xk6avDEFv+AVtuLgThAkeQ/7Qx7f1Y3Gc4wib/a0NO2cJeqYJIn8
         t/wkAheB97QlBOmdcDRvQs6hTYXlSrdaCf16yrVawWh1kjEFiBNuMyCBvgac8PiqBGhe
         8Vjt1leAtqiZ3wl3u8sqhVih7mkYrcUWKgW1T0iyUCITfDZhDQ/NrWRg1nD98olHFT90
         k0Ag8gaw7a0NKa1c+fkffhyiJRNTU2eSRgDBV70Hg47dFRDbKsfjIKOiTzxwTjL7Kg16
         HF5MVnXpbsuabdgkh6Kan/neydVZGURE7vG4YpPAaTetxRfzrZO6v9D+7nDaBEl++aVe
         9wXA==
X-Forwarded-Encrypted: i=1; AHgh+Rrt3Sx1tEeSBNsYbycFnpmcZUhzdPHlEfSZRLixWte7teuXwD6xABBO/iyA8DiX1PyJkI2PsILl7tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0H0FgOj0TNFHJEhurheOcBeEG7vsivi7gPuK0EdXId9sbamo
	LJ2xFELh7CBuJngU133XFNyvZCeFwx1VMB9X3VPa/90krkEaXEBXReItADkMkzL0ZmgYbNgia1j
	0p/wCajvNR995DVCFk+yoi6eTYm7uQbEcLvTc0V2sqst/2plpg8g7JugjMgyjRKY=
X-Gm-Gg: AR+sD12HRpkLtfwChomJLW518ZE6lblw8xvfjwTa7pfs8norcBE1nQvnl5rLPvocxml
	3CDDjexaB2tCFiMxq3KqCTd/YO05o2WkR/cVDFSFidIuvu/NhQjlbpUHg6dp2uC4ZnkW603fbI2
	8vfTi7QUzl/2NNjsSDtx0uWYX2p+DjiTWCMRSpDcXXc8X4x4PIUuXrgLdPCW1x/BS1iHtHN0pB0
	9NgRbbCVotfjRWi1a1bff7rgHV845tQQwexC4LQJHXoX9aOJkLQ0FItvD50LgYZXli3cmUvYmwC
	F23Bvu6ave9dCIkbb11NNrggjTI6vCiRa6K+rvNaSFxYUE+4veJZyOA3MM1SZvX1WfPWQZXmfrO
	75KUGnsbEMHfS+875h6u1Q4IvIyurdAk0Z+u1VZbOO0VJ
X-Received: by 2002:a17:903:320b:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2d5c4f4f1e3mr107661485ad.7.1787050686802;
        Tue, 18 Aug 2026 03:58:06 -0700 (PDT)
X-Received: by 2002:a17:903:320b:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2d5c4f4f1e3mr107660645ad.7.1787050686386;
        Tue, 18 Aug 2026 03:58:06 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e5293asm13226915ad.52.2026.08.18.03.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 03:58:05 -0700 (PDT)
Message-ID: <62eedb1a-1da7-4e65-99db-7c510844bd99@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 16:28:00 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] i2c: qcom-geni: update frequency table to fix
 timing parameters
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
 <e3b06684-496c-4efe-9bc4-65d29583cb7a@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <e3b06684-496c-4efe-9bc4-65d29583cb7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MTWzD-K8UcssTA1TCdqlEcTLOVxxweFU
X-Proofpoint-ORIG-GUID: MTWzD-K8UcssTA1TCdqlEcTLOVxxweFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4MCBTYWx0ZWRfXy6JLDDADUt1W
 Qx9hccoNrg3gmbGfKjS+USLc40y3pE1pGbBgTlv9qfge4ULGbjV3WL6F5XXv3upEM5tkDdKstzb
 Zdv+3c/SdbudM6BGiVnxvFwTpvxcaFMHuTwnAGpS9XIJsacCVmIMxc9hQvs+bLIDXqLJCSN1lPw
 Q02GXs4NkSmC8VUhOqNZDtAg7gogS+64KDOMSE5tUO4wI9vBIiOIGCgYTdRYkF4vRvJlq3Se0iP
 zesXDI16LdjAUQ5XcoI0Ray3ej/WuJFpBJxbL6CsOAURa3B4P18QoNVJ81VKDE+0JerB0SS2spm
 UV0Ew6pE+KyAw+LytqzFIAu6GLlnevmr0jzGeTPF580+NRkmDIQJYPqHVxCRWtHdIPpKRTUHZq8
 h2ZLmS2uMM73WDTX5J++4SudwoVXCqWrNtvuN4N28E/7veNxL5BVpxtSuRUqZmtIJsi5hiM+Yjm
 AIbTmVx9ESgcsQPxOAw==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a843abf cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Z6pnqv7nqnB1rS6GRUoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4MCBTYWx0ZWRfX0XJWRg3C5CPC
 MHiPVoSt8u4nFsflluN2EIF/HA7XgtBaomPDO1NPUBsogkxZX9OojwmwqaBbGWXvAvQaqFAvVco
 g3QL6kouGa5JYy4SzAFzauStPEWIOF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180080


On 8/17/2026 7:25 PM, Konrad Dybcio wrote:
> On 8/12/26 10:30 AM, Kathiravan Thirumoorthy wrote:
>> In IPQ5424, to meet the setup and hold timing requirements in the
>> standard mode, update the frequency table with the values recommended by
>> HW design team.
> Does this have any ipq5424 specifics, or are these just adjusted for
> the generic case of srcclk=32mhz?

As far as I know, IPQ5424 is the first SoC which uses srcclk as 32MHz. 
IPQ5210 and IPQ9650 also uses srcclk as 32MHz which leverages the same 
SCL configuration.

>
> Konrad
