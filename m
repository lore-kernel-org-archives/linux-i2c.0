Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC5310784
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464061; cv=none; b=iRoUSN+GNpORr0vRBNnDxa01JnyJ0/xRmPHt3fdLZoxfMl93MBpGlCKzCAsuHQmJMgXVtPImuLs1AucVsyTPz38ZCUiZM/K2aCaDFPWcSupBfBMRF6mWVvD+/BrZv96lPelpV7ra/F7TUMm2uIEnVvTrroEvhzA7UmFs8GxQ4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464061; c=relaxed/simple;
	bh=rehoQlsh2hRdZmW9Mrg12yyBqxDpPRFDZpXLr5wHsKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNEUtX0KSTRSpJhn1aZwVjCbr+TA+QXxGxRx5Op1CnzcKMuhbTO1aasH6cA4X89u2kK76zFhXR/lbfwmFqdC0CsKSbjusyGcywbiHfV0Mj0sKJ2wDi3crRdRYHB6sF10qeCY6Z52c4Fl6MMSXMYPHAe9K7DlB/aNSPi4oJ9wRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Za06XWNP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=glDpzaPx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Za06XWNP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="glDpzaPx"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWYlG809572
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 16:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yG1SSExP58/Ci06+3EQc/9E8137LeaN0Uv6qTDg7rm4=; b=Za06XWNPqZCopiIe
	F9sUW3/3yD2dBhRQQXwTymI3Fw+/6o5RCNDEEwn1Ypc6vxYmztIWrPccyxHIHWLa
	MjATD/NMWZBv9C+JfMtatjJpaQbMyGB+EeQVieWPq/Ep6t1dK4/UiazcTZCvpIUc
	l3H7Bnx9Mm8Dfw2NHkWT+YY25lJsrfzNwaijWO4rDfKbplAkbM27b53R6EsX9xjZ
	2smKlDL3tQijjST8fwp+LkGPdCBC7UnY0ZHFfKPkchXgUeI4F5bxSgS7ym9WfBom
	4b88U5R576oUZ3aLfKeTc+LszVpxdqrzEYdpGN8qXpxRB2dKyG7diU7/rQXROjzH
	BjO8Cw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049dgsfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 16:00:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso1462545ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786464059; x=1787068859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yG1SSExP58/Ci06+3EQc/9E8137LeaN0Uv6qTDg7rm4=;
        b=glDpzaPx9gO+7NOQ/3ntG+DS2vivY+kow0rKuufdRe81kw640wP22tLTXYVkRztGAp
         rDG/ISWTlt4l25qWT8pYar59Ff+T6wfFaU2eqOBmgzIx9yIdDEAy7lhCBbJcu3Wmh1z/
         IRO9BRf7HHmeYlZDKqssHh4Il0UG6YwgncQAqJop6LPBM5Sv27rbi9Gd9LNedaKdTOB7
         /rQDxhfBBOmzzOZLd4pXk3w8/0hHE/bLCuCQ0t1k0GQRdzOu3uDZqH9blNe7uvnkxUgf
         +aj2yVmlLd1ao7WWHk5UtM41ZVpLAPbxK8YvB1e0NflLgILyI2rvhUfIzcBxD07gLpCt
         4WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464059; x=1787068859;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yG1SSExP58/Ci06+3EQc/9E8137LeaN0Uv6qTDg7rm4=;
        b=UR9z6yj3VxI99fI26gdDrup5/g4L2Y5uzUfl0hAln1tp2DI8O28d8V/5Gx8mmeoB6B
         cd0r+pFaAi9cqT559ucco87p57NwPiVg52vaMwHOnfVeUulibpabDWa6z65LOwiwEAQt
         WrmWz8aBKsRiE9dvWtXQXY30Pyhrwcgvx18Z8gvhVccJeJnxY8TWbc4HtTyl+OuJrZsL
         UkcRkIXDlbJJCFeaOjY4uA3hPgMPCR2MMvTkZWAKk1HB6sJrov2K6s4IxmEbaKCD6aw0
         cMzX5g7apjN9PeaejR3eMGGVOMpznbyYJVVPLx0lapvLDjkRfujFO1pbnSpRHOInRXSM
         LX0w==
X-Forwarded-Encrypted: i=1; AHgh+RqrFWztlg8MqHyuMVp8EjoD5XzxkKl4dCRaFOeLuTXRz6iLr9IA57Zz0/tVe8hkB2lyDm1JUaahF2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgThZEyfnNjBSQcc72nA2YmCfpCjOUC/7y0em1kTVQx45jTYH
	aeK9HpFepfk/2GwH5s2QZH5v7VL0B7KjJj3hj3uNvyj4ulkM6j21dt0tn9D8uFl3ifZV5IuQLuy
	cjSC2nezzAQdfONuKBjxY3yXmGlUpZzAbSfNtWABGE/JORbsPp2ydxQd84+Mpbbk=
X-Gm-Gg: AR+sD1091zKQJixnYgkU//N8820tC7vjwvHiooJrnG+vP0UihrS4bWJjUwXiI6pKiCI
	WGKucXQHLlssBBfslETaVyKy+TRz4AGiHy+ZM3NsyfrQjSPCgEYvIoT/xTytdh31NV0mWuw9lyn
	gjOS38ezP3GdsTEhfW+2aRXgXgoLtwZZavNHwkU+9NifhciqJXYfSs3WDvu18U3bczowSke+CkZ
	OYV34SMPLMfBvrl/cgF1YnJwe444iUvJx0db1PougACQOXDkDLT2xWpKn1corxAVYhGbbFmus3B
	XaQ9FxTd2Tmad5djYyLabyJ4lcALkbTdRIXNDKn+ZnQ6518tEqF/FvqFQcqO7iGyMwJ26uoEOcz
	9+tIpB+/4qx2HItGgx/lFrONIRjfefnzNBUYSvlkPg1Zy
X-Received: by 2002:a17:903:32c9:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2d317789dfcmr45912015ad.3.1786464058691;
        Tue, 11 Aug 2026 09:00:58 -0700 (PDT)
X-Received: by 2002:a17:903:32c9:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2d317789dfcmr45910705ad.3.1786464057921;
        Tue, 11 Aug 2026 09:00:57 -0700 (PDT)
Received: from [192.168.1.9] ([122.164.84.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315ef0f42sm10409145ad.14.2026.08.11.09.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:00:56 -0700 (PDT)
Message-ID: <a6ceafd7-fb2d-4fcf-9a75-832c40affc2b@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 21:30:51 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] I2C SCL counter updates for Qualcomm IPQ5424 SoC
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260811-ipq5424_i2c_scl_updates-v1-0-bddcb2ceebda@oss.qualcomm.com>
 <148ca192-52bf-40d5-8ad2-9110600eba72@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <148ca192-52bf-40d5-8ad2-9110600eba72@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMyBTYWx0ZWRfX+kXOz7vYL9Gv
 hMiMWoHb+CuHigGMr8cP6AlRQxsxBx8Wp+tx9rdKxwIjNAE5+AGDEs+qG4x+1YWOnTT+L4/108F
 yljxxvb+367Kdr9iQU/TE87qPh2RzOQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMyBTYWx0ZWRfX/AmxoXbJICd5
 JubSJIcUu4xTjfi0VqeLX9Ya2m1lo5pL+wsfjGHHK4Lduo8mbgwyg4TZns7UI3wGwv4Ikx1KjN5
 wpOfqEcMcBWx/QCK8vhM1viHugE5IzU27zGbhnSkVCePVXDNjrfOnbN9tNqlkLwXBX7SVE9JXrq
 V/x6z5EGphkmq5D/iJlpko+Pvsw6XEfWYmRBPDmPYyHnJ1y2KUs8y4pk1HB11yVb3xjKYS4Fjwa
 zHC4Mc3fR5EWtpZsLEBiBc5pmLg8grYD9OLCTcckS53iWlUbfDdf1TeZtMENKSH+LTJmwRWSsq6
 4K+Dpo2dpddAWoQVn/juX1ruuX4bT8+MVpDu9Y8hMjywvUApowoLKeY4aGE5tRHV8NN8GskSGMS
 WSAJJHNTck6WqK4URMe1bd5/hhsv6mivOilkBYCN2tMywumNWDUcvj9btxg3Yzuc6GXJFbPnfLI
 XeDNwGEsrdcJeMLafjA==
X-Proofpoint-GUID: YdQRcny25EOZnlnxe4VWBzJQ2zUNC4uW
X-Authority-Analysis: v=2.4 cv=CbA4Irrl c=1 sm=1 tr=0 ts=6a7b473b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=0/lRlipvHLU+ZVN6ZkkSUA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RGlg5H6Z-dMNcyaZwW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: YdQRcny25EOZnlnxe4VWBzJQ2zUNC4uW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110133


On 8/11/2026 6:11 PM, Mukesh Savaliya wrote:
>
>
> On 8/11/2026 2:53 PM, Kathiravan Thirumoorthy wrote:
>> To meet the specification requirement in the standard-mode bus 
>> frequency,
>> update the SCL counters as recommended by the design team.
>>
> Patches shows that you are adding frequency table for standard and 
> fast, for patch#1, and all three modes for patch#2. Please, Correct 
> accordingly.

Nope. Only for standard freq in patch #1. For FAST mode, it is just a 
stray space removal.

>> Also, SCL counters for the FW based SEs are different. Identify if the
>> SE is mini-core or firmware based and chose the appropriate counter
>> values.
>>
> Little better, select frequency parameters based on SE is is RTL core 
> or FW based core.

Ack.

>
>> Signed-off-by: Kathiravan Thirumoorthy 
>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>> Kathiravan Thirumoorthy (2):
>>        i2c: qcom-geni: update frequency table to fix timing parameters
>>        i2c: qcom-geni: Add I2C frequency table for firmware-based SEs
>>
>>   drivers/i2c/busses/i2c-qcom-geni.c | 27 +++++++++++++++++++--------
>>   include/linux/soc/qcom/geni-se.h   |  1 +
>>   2 files changed, 20 insertions(+), 8 deletions(-)
>> ---
>> base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
>> change-id: 20260808-ipq5424_i2c_scl_updates-f1696a0590fc
>>
>> Best regards,
>> -- 
>> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>
>
