Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869012;
	b=0C5Bh68+A/kcd9qFhXmGRCAp8HjM4TEqhXdRvO7RH5eBCUxBPZENKGXNW7gIf+0f0dXU
	 dFCKwY8BdpI2SbocOlxfL/GINg0Wg+iKVNje2JjvdYKBfGrGPRGfnwq7t24NdEc6I/C84
	 GRTvG4HHGby8uQftue7yrJ0Ce+sR7xzp6VInMmptihnP1tH3a6APsNNhURP2gOQNoRFAx
	 eIv1JigfKzqwjfUw510OwqwFlxN1nTd5xf8h4t7TkT+4A84pQm1dHesmqj+Y9XgtJ5fyn
	 EYfvfMa7onJtHefHRXz/bx38nCoZRafbFbKPWuWxM5ZaUC230CbuZdfxJRwUVAJgT8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869012;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GvaLovDP0kjP+a6zwEBSJE/9wwmcK54B++vPoOwCeOI=;
	b=1cX5YWsi+MU5jmgWTznO5+fzTppRoLEZ56X6ZHcvstOzj1uD9ijQGz0QdcwJGNAr9g+t
	 NuGS+DDx/W901bgqTemgcvC5MRi/nQIu6/ebLxJ9XZrCGyDWwy3cBJrcEpl2hdg1VO5Sz
	 8ct2msdkGu4QQGy3He0X+9Gb7yLSEIuj6kX+EMVwaW6C9Z4Ak8znwzrMpUVCZSq6TXSwG
	 3ytmdEE0CToVtCfppTOSGiRkij5operBIb+lbtCz91/p0WO09+f1r7Tr1wpUgMixYwLgm
	 8e6cHxsfUKvtDClvT+nGQvhyvA+BMSJaqmcJVKSoqIzqAP2IRmYC39nK3lwc4YsPzmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GzdTrDpf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VhgmSa70;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B90606A330
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65B90606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GzdTrDpf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VhgmSa70
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UCPB4169780
	for <linux-i2c@vger.kernel.org>; Thu, 5 Nov 2026 08:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GvaLovDP0kjP+a6zwEBSJE/9wwmcK54B++vPoOwCeOI=; b=GzdTrDpfC1rAeoaM
	dgE10Er9mcQEQWnKg+GI7/lhjskwclnp8YGrecIamMYosbtSsUKL5iHfeTmM0kYZ
	3Kb3ZWAgPrwa1ys62FMsjO3O5dAwlv9pYlhMbHNBvI+i8cPld1N+v0cbqCHv0fkg
	OFmzGYr7ss+RNCjHbHfiJv7L5tKFwXEBRY4FiG8L6HEe0skaEFxr7ZeqBpCXYdz3
	znhWx815s48MxamSgNx4N5vF+UHgJHWlNM2AYYKHOgGmo8V76JTEDZpaHxJSXOyj
	kfYXPnkfrpai19PtS2i47nkKNWeW9yYVjsCt/Gnr3t65fzonWgWab/5fAthdNKSt
	1gc+tQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd8krh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 08:56:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1440e081so44389285a.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793869011; x=1794473811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvaLovDP0kjP+a6zwEBSJE/9wwmcK54B++vPoOwCeOI=;
        b=VhgmSa70xoMY5HPrjbSEN/gvpSwpQWce/kS8dhkYoElXa9TVnhQmfG88USDreAo2t4
         ElMZXj+O75+hUfV6Kpz8pG/G1oKbNb6tXBZcpRYkDL43yJIogqspiJLgadOTytcQ0mYO
         xt4DAqU4wYnVzMttUaVnd21a5jHrhrpt4IlT3R7EPEwW7PrGRqrHB7CRr9LLxt5+1wL1
         EilGaUJX+G+fguEcsGIvXfobbCJtM/atxx5vfgJGzG49R9C8jhtyC70zJh/y5A9n/RnX
         FGS2yF/R5rLy1FLhrQaqB5b+d3JCb8Ag6Nt2/DPHUoRaKuusKOK10hJ8QEJ17OvTJ9Ue
         gB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869011; x=1794473811;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GvaLovDP0kjP+a6zwEBSJE/9wwmcK54B++vPoOwCeOI=;
        b=QhWXJTi8s5MpHxzaof6muLvJ+4D26iEwurJArYH8gZiE1ayuUid5bYE1H+piejadvY
         0/wpbI/ZMWUvGq582nr9uHQjGF+6p0bzVp6vUhVKomA/pU78tP+9VOn5HEIYHr/msOuu
         OQRdurd5BJ0yAj1fgOtzF02N7mVyYmyWT+Qai/ZjlY0onrb9Ikunj6yWg6xqJVRoP3FK
         s+z+qOqJwdW0TD1SA/DCMOed4t6x2wEIYdLoiaOzZzav5zJZPXv6mv3V2+APzDo+o3o1
         lACh332DmMOlJGK0GXHLCm/EgqfC2etDa/Qf2KfFzpTywlOgR+lOeD3HUugZyrVprIYW
         0lGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJYvhsitFQmKtikw9RjWLmFRMfBwj1S2+GuTyJTesiE8FnCrNQ2rSdHWjhHp41b5Xk9m5PnYnlv4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8thuzvLsTOz+h/lCI/XERYXg0wQKqDttGbSQ2L7dBSf+HwR81n
	a8oz73vYLDybY6ux4fu7zDJrntV+99pSxjIari2KtzZU/ftGSDh2dCLccLLF+bOILMg+w3tLzzp
	0+P2kToTfEdU4eMjVqVMGtpBl0syOhNPDjs6FEQlS6nuloRFYo/8RvsuyjKTmErI=
X-Gm-Gg: AYBFou38HzBWjAs9vPM6tN3tbQc6pCb8mugd3oXJsk+F5Sosvp+AuOzLHK3w+pLjtu/
	n1BGEMWmgClsbHbbdJ2r3s6I5i/WeZq4gupyxY2obD68nAXgt9R09gnoj1tWN9W1aE4vF3NGbIp
	0KEEoGMlI2ErCIb9upK7npRNKo4qvu0fA7nIhEK2lSJpPXemCRjsvhveGoOHldAw1mxpnUJzZ+b
	q+IbZ1J/qGkq478ZtiobI3hmAObDVTQn4hQq7kmsI/0mBg0OR2ttMiWO7b/x3aPEOmg715x+v8D
	hdOLAYBUleXTy3GYTHz7My3Ed6BEywc+u6P7T+feGtduXLBxf/geRXemmN0bt7xYov/V6YWCByO
	duelJ9sc05pWk3wloZ0SS+9iIBnsXbiBP8pfvzmwjtpMceCEoygmq2D1nvMbU7MZ9WazI
X-Received: by 2002:a05:620a:8795:b0:93c:61e0:81ff with SMTP id af79cd13be357-9442155a11fmr2712714885a.1.1793869010585;
        Thu, 05 Nov 2026 00:56:50 -0800 (PST)
X-Received: by 2002:a05:620a:8795:b0:93c:61e0:81ff with SMTP id af79cd13be357-9442155a11fmr2712712185a.1.1793869010034;
        Thu, 05 Nov 2026 00:56:50 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e140005sm158643266b.5.2026.11.05.00.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:56:49 -0800 (PST)
Message-ID: <1e26a8e3-e626-4049-a2a3-cd3abd62b4ef@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:56:44 +0100
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
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8350: Add camera MCLK pinctrl
 states
To: Vladimir Zapolskiy <vz@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261104230529.3040285-1-vz@kernel.org>
 <20261104230529.3040285-4-vz@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104230529.3040285-4-vz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec44d3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jXeCVmtNkXa6rvJdNsEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: spo9Z3VjpWtEe-FF1h6uXwvAqMVpsHwr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfXx6FfaPAjGulS
 44fUhYmOrv4x8/qyAQRLzyEmxheeZgXHEUfrnOHJVDhCacH/tVD8e9lxRhKVq71ePBRXrdfNtmo
 9gu5cXdHSHPWPgd4xIJGZS+e1kKhFNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX4roCLk0w2HhC
 bOxNRoKURtHtwKP7844xf1NcLMVYBjkTFiu2ycAtKpgCLCJEFInx4jMGC0PyYEnkbtoKcal8ffq
 TIxaL4tt/tOQi7PN2euEMf4E3+UyoMM/D41vJ2gnc4pTiMIwcuPhaxLH7mNv+O+11V2R8m9EDi/
 lmx9Wlvp63j3WWD0imA1WyF5Jv0KoRCy6q1zQ3QSO/4rIZ5tXVamf/KVff8K2JrRra/d3KlG9x9
 R2CpleMg1xkVxTGg0rXf1NUyp10oBnr0pd+2KnHRlo7cAIbTHWkcXbt9JimB1XH2fU4tTpIjlhd
 cUAkT8wGTURF04J+j2aoY8OAbjpY10J2NRYGGaJCTFAOX38bn28M4mAwBmPce27yEuxU4g65lCY
 o3fYAi+/3wU3PiCceGUFnT6ohFMK9u8ak1KziaMTO4/5sVA6rkJmdkgghk6aNTcthTwIgfSESLf
 4iV8JDj1YHVf2MBv3Dg==
X-Proofpoint-ORIG-GUID: spo9Z3VjpWtEe-FF1h6uXwvAqMVpsHwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050035

On 11/5/26 12:05 AM, Vladimir Zapolskiy wrote:
> Add pinctrl states of six camera sensor MCLK output pins found on
> Qualcomm SM8350 SoC.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
