Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED345A295
	for <linux-i2c@vger.kernel.org>; Wed,  7 Oct 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363102; cv=none; b=d0ONH7PHvzoe0totxjmrEqHMnXdPyn2yNargdZOM4TTRvDsLWCwkRauCvWPxtb3WyJnQ8K7MstMgjIuaGycMDplwsHsZCjAh5+TEyyoRsI82f5nepFsG8XxEqfOJ7/OM4yPDPDlWiO/rzrTQoGucLCbZ6hhp3qnRE5NDtOVxW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363102; c=relaxed/simple;
	bh=CiCPHoKbA7QwOLstlzHIyTwZHiWB29u57jr15U2ffdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7Y7dI346tYCS8yvDzTijmhNcDa1xnEneD10Z92daZ7HUc+S5d7Fg+pmxZHNwtDCFu1JTo7QUm034m9idO7fKq1NWhpyJFm6RaXIDH6ySLN9TmQrUHyROfH5ikrLAMwNHyOEwRPLxamHrpf90ov/Hu8s3nGiQyOmVK6nwpClV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4OpEcQk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YfPNoujj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4OpEcQk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YfPNoujj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jedw119490
	for <linux-i2c@vger.kernel.org>; Wed, 7 Oct 2026 08:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=; b=U4OpEcQkQIQ4z5ej
	X4PJJ8RUbYDn3oovYkwGFkhHWi6r5CyCyPlzQ/d05CTJCrQ6IKSAfCgYAA6rW5Jz
	giHiRMXWfsdCljgvOd4zpvdcxeU8JHTfljCgbK1WD0kNzZ+4giroSrHf6q3uXj3g
	yEApDeVOHzVf42ENaGHa1nIdV2GZ7zWB2FcQNdVi+BVEhhk/Yeu+bhE2chvvWspc
	k/uqDJtOeQTeQP7fqxW1foOGAbfVOCN6Con/wxoYOxxKrz0zs/dYC6gSwQKknrJW
	y33M3sgngOmOpox9KbL8Gv3+7NiE171C7tRE/1PSxnEDdT6ErsD/Y2oD/VtIo6YY
	94AQGQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc58pv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 07 Oct 2026 08:51:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so3009875a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 07 Oct 2026 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791363100; x=1791967900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=;
        b=YfPNoujjzYkqOobFz5aB1TDTBYPTrnIW8H+psjxkZreV/LyLZOl0EX31al7GwGCDFs
         UHS8YIYn3ag5ONpgmIrGWMvsSt5I7JB6Zws1QcWujpmRqaHVagdTuT0wuem3xf+Ak7/m
         OLo93p9xxWGOEfPa2g9F+7ehJq6NXNBltyhnYe4FzgsHFRek0xRHO3BIiFnmVawg2Xxb
         3CdRHlJdLUiYbmHqoShxwZ9ZIrglrH3ZfDMcRmkanc4rPwf2sXiNbNuStlDBsLEMlozd
         T+M25qsOCJ0YWpIe6TMCaQgCnMMqU4AhDDrKJ2So0kz5QhKtXXY5S+rOzUeGUALOZvYN
         plLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363100; x=1791967900;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRMO/BIFTS6t5KCadnTGwzkaBkcMRT2kVp1MYvn8vlI=;
        b=xbGU8XMt4NUvSXy5H36C1n2XrOQ3AdutnYtG+eh3hC/ceFVehpoLXIVMtt1et7L3q1
         oWfQgSe6Lb8KOHqbwHifGZizuqkreBqfFkvMzSP+oLgVJNCJQg6LBApk9g9jvU7gcFxa
         5vER1LhIhgGjKQjCdfyK17Jki9hzAQIHB0w5UOWyMkXzo6XR2ElRuc+WN/EY4l01asNb
         DFhOuFPNo34HlHqQIa5LcCorgTutqIf59Os+yTQMLIeQrlZuQb4mldwYLurpVEyTmRXU
         /ZZ9UKWL2Rcks0MfwBTmSJbVfzJzK/ZDtoCydj5Ll7Bfbr2KZuJHaFboa1rP2hdUUj8u
         XbdA==
X-Forwarded-Encrypted: i=1; AKwUvBwwB4wqNZFpkaBUokuCBpHuzFosukBk1eI902p2PrtRLW1TCgzf5A4qIQ7FPSr0z4Sh8F8oGzGd4LI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYthSqO2Pq60otE4y3zjdG5k4pgHpxNhMGEJGuULpA6tAI1vjH
	45bN1PDbJI5Iw90P2Gb2tu3g7/pJE6S4PyjDu5MHYo8qN4Vi9dUw+5kIKbysajKTKW6dZw9dV4P
	WXQIsUw0nZfuVRqAQPVyWR7cKBF2zLsLdDlXZ+m1tOrl7xchqNUfPGqpZ625qJWs=
X-Gm-Gg: AYBFou0Xw03DTdeJRXiWn4pGmAYx/mnHhrcgS6xGHhkvE0NFsJ85C/aE6N4s/S+p18N
	d9qpV4Zr2BHco0BZiYitRyZIn6/BMiLogdgamlyvzbR4YogVHnlci80/vqfnONsXDp7pLFcuSeK
	n2ksUF/JtW72VPIIw1FSBsO0wqJ2cLRRTYF0cO2n/OvpJx7w9Sdo5A8svI7G13HrXzrq967hSkj
	aWUq5T/IynKx2IDoRam0wI1z6kEpFEFfWLpwLdd2sva4/Ybd62nVJjwEy1ulKnSP2ktOUz0c2+X
	t2Inuh4QbAIhqYBdwZfGxebzA1IbMQM7aXlwqIVAfNd25xqJHLh0O/WQpDkqgYXPDV44u3ySSZL
	dUyLfEUeLFOYWHOrHSXxqHc9hVYHAOHw/
X-Received: by 2002:a17:90a:c883:b0:3a0:bf0a:c9da with SMTP id 98e67ed59e1d1-3a8a1bbf160mr1409068a91.47.1791363099928;
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
X-Received: by 2002:a17:90a:c883:b0:3a0:bf0a:c9da with SMTP id 98e67ed59e1d1-3a8a1bbf160mr1409044a91.47.1791363099481;
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm6760885ad.50.2026.10.07.01.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 01:51:39 -0700 (PDT)
Message-ID: <57f068a0-41fa-4986-8702-8fd3d6dc0976@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 14:21:31 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] soc: qcom: geni-se: Remove OPP rate reset from
 resource deactivation
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-4-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX+5mTwjh0F5SR
 P9QHEK/6eLV2AoLGwlGE420xROm6j7BDGzIrVmQN69ngWV49E4Z7lDzF1yRUCF6o/dsa8+jEIW3
 NccgMQGGqCPaKB1NHVWUtetJ80hluOo=
X-Proofpoint-GUID: 5fQ3EFUiNNj9GdXxIl124s_I1Cy3k3Pd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX6uvKaq+B8F3q
 AM6AWofrYAQlSFKJEWaR+Gh0UGA6GnkNfvwmTiN7qxDEs5Ic/XLsh0xNphJdypWbDN0jEc1tFku
 1g9Nb9aSqhuV4Cru7G2GXWpR/29em09kelT1SzHhe/ZMjjtTokVZtherSXlgkALn5zfTYe0afz5
 nHb30p9ez2BjuGR4UMCbM5DoZTQm5lRI2SIeCchq53gF8+aUGCh8vLYaN1qKAGCzxxqL9F4JpXl
 PdBBUW/GsqKncuKTqFSLTcTfUE2CZNumRPTnAFpGk7UzBwI4qsRlIWKD0sARhYqaBMtgk0MNhx6
 AQQQDqtSxXeZApyqbjMd8f6BL8v8IRKzzTnRWatvWWznn8Kuzlr9b+Hn7UluIu6+WLVGli1/dXy
 q/710SV2EtZKEaxqT5SO9VB5yoq7nWcw3Z9I/l7VBXEcHC+IpodMVTDAqQdPvMXvyaXsbWLXE5u
 PdIVaZH+jgetc5AvRMQ==
X-Proofpoint-ORIG-GUID: 5fQ3EFUiNNj9GdXxIl124s_I1Cy3k3Pd
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac6081c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9QLVM3U_lBk_t3napV8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070035



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> Remove the dev_pm_opp_set_rate(se->dev, 0) call from
> geni_se_resources_deactivate().
> 
> OPP resource management should be controlled by the consumer driver.
> Additionally, clocks are already disabled by geni_se_clks_off(), making
> the OPP rate reset unnecessary during resource deactivation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
