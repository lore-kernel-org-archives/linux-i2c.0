Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED801A3160
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452117; cv=none; b=ZFHGvP3oIn5XOcaF0ts6hgfgncKuVHD85+fn893kry5xV61cPuHdVCt+Ij5WoFR0M1Cjv6I7HBQ3/g3ik6+MyMjRZepf+Z2HtuO7CjPOIdFw6AhLSTlx7zzGQ8ZiTawH4w6oZkbXO/hErboxJxj1fhbdHFBITQU4JAlZ6sAxlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452117; c=relaxed/simple;
	bh=VPIKZN43hVd/gv75GOW2hcsf58m/SGcocwt5Q6C6e7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVhHyiAYx1CW1/0xfzpSaSUfY6aGvieGoUHDW+2kpu4SgmBbM3UyKs082/5AZ/Tce6YCjgHT/FJEHOKamFScsKNcr6ihX+3XwsYZH0WxGLYbU7QYT0hgNc2RuZc7lIuwYCoM6danhqGGJnGiWoATFUr8t691gJmVOY6hALzTRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Op1qx4ll; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BWYDdUtF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Op1qx4ll";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BWYDdUtF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BCRCg8306877
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/F1QdQ5yJlfEpKwu40CWgAdnMbdNMa5TKXAj/fxbeTk=; b=Op1qx4llBGa4qUTT
	M9Z4GksSKWD37UY4QWfNrhuEAjkZY8aDHipoDv1aB+oY25XrERohsznQyyV6r9Km
	n023hD3c9EAgrE2dsC8P5DYlNhRAyTwARy8oRPOlJBMsH5nc9Jfdcf90GstNM1bU
	er9DgtroyorWSGpx6143oglDlI7w/ZGlf+dY+4r62lE/nL0UDHPaKFe8o2t1eKr8
	jkt39jNVbFjSxOnJynyQEBwbqEl0qwh+69p0c5vxplB+6ijKt6yyZX0gF7N/hj4c
	lcCmNXFe+CwDEH3OPgBny57QhtpWjVWCEIw2HP5ahhHh34htr6HuJWdfNXLSIKmu
	dWNDOA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjsm58d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 12:41:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d004f13426so43248875ad.3
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786452114; x=1787056914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/F1QdQ5yJlfEpKwu40CWgAdnMbdNMa5TKXAj/fxbeTk=;
        b=BWYDdUtFpGvDOF3m8GTSGT2D0J6rg+imbOiG90bi/FLdpgbEkCoUdzgvo3qClpbhOM
         ikOLHFo6ICoT9DgCR/UCu9RH6H4Bc9ZRaOLZ6OV+OWDYgnBluNaGD/DAjPMf7/g0bnin
         hRGds6dAn3Ts2LvEfQQdOo6gIFMUHFAEbF09X5570qLjpCcE019rHvZsTwftOaRPK5aY
         tgxvN9cpZJX7e47M5Jxq1EM2gJ8k0Z1g+ZIaO6UPDTSFBAEF3YKRkSSKUNB2oPldyL6u
         DTe+UVbcoV64scQryx8o7b2xQoGxvbilEXtKCkMOUhBCcnxKxq79hi7bWD4JaZ6eD7dw
         iEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786452114; x=1787056914;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/F1QdQ5yJlfEpKwu40CWgAdnMbdNMa5TKXAj/fxbeTk=;
        b=pctoP+VQCu8WX7y7bOj91zrtQg6BZS7XeTC447QnTq2kNWsn/W5NvwQaw6p6J+k0IF
         6tLdByEclt1N69aaY86n6oddzUSUgrb8MbyhupWfo7tOnE/hKJFLEn2gqg7cMmihTXsB
         OS+28G6DQ+VkCTxmZr8FeyKGsqi0+yvAu/iewrxkbFA/SILu+t8aZX7WRj4Il/pq/wB1
         8c6Z6M8gR08xSHtRz+ksqHCSmuYGz9slhxp5QMC7jGcsLQip6zHl9tvQRdBXDYj3Sh+s
         XNNGD+gkt0AZPI4Zx3iBW+x/YhUP/NRD4YTX9NohXetSflYOa/v4uioyB8WRbGpuGEwB
         Ex1g==
X-Forwarded-Encrypted: i=1; AHgh+Rqor6Bl52Zz7oeaE1KDNhE3M3quoLuSxgIAq9+DqxHsTQptrQuhaRz+cswWZaMXkg3nhquU6oGKjmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0yT2udwyJ5D5wgQ7Sq3jtW1//zNAweXJ/SvEIufFG+GlTIKC
	mGjzxt6Y5KRZUlVHL+d20UJinzZyy3/Xdj+LwonIBfhITrkRbhtZRVSgSkZSY++HUL9kHSVdgIG
	OMS6U9DJpesXBAQqnp+rhw6Hs08+lUVHv+83x3Q+Z8z4Im+pwC7hV0ri5AeVSd+E=
X-Gm-Gg: AR+sD12HSK0Zl14+pH68T+H6DKTuBi2S+nrpYrO7Xyv6dato4ISE5SPh+R3uVTyAPms
	RF1p2znxa0Pj3i6inA1qh4DHEbc4H/nrEuAuZWhmyah5HAbbsTwt2dHWRODjtbSJkrIQHNBNUvV
	41AIKiT5BUa+F4JJJT911a7V1Q7uWCjyeBW5WDBqkJyHOsDuDghKrfCYvUXq3DvhcHaQhZffLuq
	/g4A1kHJUYNxHtChQnSRUImdyX1HJ0i63bg+UShjIYrHxvpb6EO4It6Q8BzOLvXVngI6iR5F5wP
	jVDdkvFsVnbFykZDBboMMGObVNWLKgK+Sjkkp0tvCB/mSsA2YZISqDTy1NUgABCKatws0cRvW+l
	HpiTq0DDJI/xaARkKEME0UgCY7mmYh4KqGj/4HpcKztBFL0Qj84pe3CqK+fdpY4wF/joqmNQ7
X-Received: by 2002:a17:90b:5483:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-392ec3a9001mr3689016a91.8.1786452114397;
        Tue, 11 Aug 2026 05:41:54 -0700 (PDT)
X-Received: by 2002:a17:90b:5483:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-392ec3a9001mr3688945a91.8.1786452113801;
        Tue, 11 Aug 2026 05:41:53 -0700 (PDT)
Received: from ?IPV6:2401:4900:1cb5:973e:782a:16ef:897c:10dd? ([2401:4900:1cb5:973e:782a:16ef:897c:10dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5381dd3sm4097263a91.16.2026.08.11.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:41:53 -0700 (PDT)
Message-ID: <148ca192-52bf-40d5-8ad2-9110600eba72@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 18:11:44 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] I2C SCL counter updates for Qualcomm IPQ5424 SoC
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfXzrtJE7Xz8skN
 UACwNRPC8NhDhSVo28unkZ65wQeXQIWALkn7H24yoXzTJNZ9Pw01YfRsyWK/WIgS63emF0tSchZ
 SOtyJoHteMllXp+gD4tNfkrIkmz/n68=
X-Proofpoint-GUID: aQSmaqiQC4panB6iN04YdrlzBNpUHlws
X-Proofpoint-ORIG-GUID: aQSmaqiQC4panB6iN04YdrlzBNpUHlws
X-Authority-Analysis: v=2.4 cv=cfDiaHDM c=1 sm=1 tr=0 ts=6a7b1893 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=NFv0j6h37eyNFR9rI2wA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwNiBTYWx0ZWRfX6CXLr4c28Z5z
 N5GgIGICe3JPFPMFaMYmZ3xAntCsWHJo8yJUwjPw7+GOHMAplQp4llSklCOh/aBldSO0XMdL1MD
 sY6eBt52xZZpIBjc0/BmvNk2mo4SyMQy16JwnaKO7kkCvMc21LVw1vd+9BWprok9CY34r8YArWW
 muBodQGgPNFv9NUporTmzVoseg92Mo7Le3AYUjW/Z7PusvpNVtOddZDMe9rHN2dPxmLfAT5+h9m
 8WbhalW3FWZGc3yExjnNomxhKvCv5ApfwAtxGU6UsmbJ4ZaC7bJG0hIflU7A7DX4TG7SwOfe1yH
 oksrG5fxAZp+vTPkNm0yU3NO9qqJlHpWFX2WIZqfD7I8g1PemNiN8BPZorIdipVDnY/SQkEezAO
 sfsr+ZUmkC0SPAQZynrZIA6CU1IxJl3pcs/9HXbbjrXQDFaszp+BmJOIuS8kr6oyn85OrKPBUNn
 1fPXZMTS3j+Bu4+5frA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110106



On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
> To meet the specification requirement in the standard-mode bus frequency,
> update the SCL counters as recommended by the design team.
> 
Patches shows that you are adding frequency table for standard and fast, 
for patch#1, and all three modes for patch#2. Please, Correct accordingly.
> Also, SCL counters for the FW based SEs are different. Identify if the
> SE is mini-core or firmware based and chose the appropriate counter
> values.
> 
Little better, select frequency parameters based on SE is is RTL core or 
FW based core.

> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Kathiravan Thirumoorthy (2):
>        i2c: qcom-geni: update frequency table to fix timing parameters
>        i2c: qcom-geni: Add I2C frequency table for firmware-based SEs
> 
>   drivers/i2c/busses/i2c-qcom-geni.c | 27 +++++++++++++++++++--------
>   include/linux/soc/qcom/geni-se.h   |  1 +
>   2 files changed, 20 insertions(+), 8 deletions(-)
> ---
> base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
> change-id: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc
> 
> Best regards,
> --
> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> 

