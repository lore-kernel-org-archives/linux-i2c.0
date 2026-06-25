Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2383D091E
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382947; cv=none; b=n6YK/XB2sdxwZCzOdOHV8qLbXXH0hEgVep7wBlz26FDEKYtjiny5eBIiL5PikYItqErbBI5xiEmx51mflJK53PTsV1LVWALW0dwa/uPuqG1fthnKcC2vbettvVyD4WcQLf6vHVzXTdiEP8rSimm3YNdEg9Se6lP2zehZgz45+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382947; c=relaxed/simple;
	bh=PUd3wa1z9wVw46F6JNtqqyfzu6JtX0osRRT07M2mB0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFYusKbQBCpnSc0woF/NZpBGMOO+/7xUxisNCIT2K09R4t7EKquH1zrKh+3RwllAw/OXFHwXGtitlXvEoP+jfzvu9aTgX7aOTxXTC90s6QfBdztBz8TLiQo85zX7+7mO2Ka7ZleXDVHteTryp4spKUx+XuqQ7mEQ63rl8+ZeCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j6+gUzc5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WEAjm5QY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6+gUzc5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WEAjm5QY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9jvw1026140
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 10:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QKsIEUrVK0G2nIoOCPG0vvWvJmYCsY+ovNi5/n5tMP8=; b=j6+gUzc5lXVSNUD0
	kXlMVtHC3fQPq0lxjmNUrXWVdBZPIs0itBiyQKGlKjBDFlDUikU024C/H8o93ELN
	VU6p4ZAA7/Jinjj0EizNoSl8bwVUz1gxSt5oQjruMXn3Du2/jHc5wyXnlwx2Cww6
	rDmEvEygNI4jWAxY6ioh6CcVw/Ex3i31gHnixifCEwUfKvNQNF0eNBjztQMPpfpB
	35MhHxYzxZNnqPCfGFt75MFA8uVPmblxQKRWONU1+ycunVZ0gdwPhMUPVLLlkGa2
	eSSDN8RxAKTUI83o7awTdcnw7ihfjnlTfnN3mOli3d7UR6BlBwZ1gAPyAWGyAXKa
	5D0Ohw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0tspswu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 10:22:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8df26121c8aso4942886d6.3
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782382944; x=1782987744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QKsIEUrVK0G2nIoOCPG0vvWvJmYCsY+ovNi5/n5tMP8=;
        b=WEAjm5QYwAz2E2R6nX7AE5zq3nTqdpBFbpmUX9jmjyBmRb3JLKNGQBmovyWxgBHbgv
         RDmKcgITR91zQZPs+17TSF4G83SW4hEVPFXT9O531bOPx/pFWPFKDnusF56zrTlALLwi
         rNNMjtFcTTTCSNrNZ/KbAC9/Vu34TYCOIDGki7RG2+58X8mdjpWUAThSgoFL7Si1svUG
         upMt/0ujhMD5goO0F49nZ1FS7cJ/X4zhjVU7rEVc70Hvy25iZ/L2Mr4e1l4N7LhDEkSp
         VqSwG4dPof3QumgDE0974luqjusnjme/aNG6bNFxiOEz4g2t1dwES6eV7iYHB9XlWYxY
         TNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782382944; x=1782987744;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QKsIEUrVK0G2nIoOCPG0vvWvJmYCsY+ovNi5/n5tMP8=;
        b=scTBSmK8rFtMXox0PHi1Wr30HkNoB3a+TvgckCJEaRpuuLO7p7lkcoRv1gZKZ0/rno
         p0fBWyL8/5aeKP0JYbmoL6/e/gEtKbL+i0XMTpLPcg7iCupiwFVYqPwaf2LTHI/FgrTb
         bRUxcXtJNMEVK/FjCutwrkOsZmmF+uRAGs7uKZYcR8O/OfgfzzS21S8oFtckuxT8BggV
         zdnONdUFPgEL9a9qdb1MYOQ0ShPV1Pw3DFzXSLl0LIY/T8ACdAT/1UfvAiCGA7vkHp0v
         VZ5rBxLPiZa8oUTmGLqNcIXV0PRZKAXZeFV0y6Ux+X/G6kxl6wpEK221uByFMpBX090k
         k1gQ==
X-Gm-Message-State: AOJu0YxsrPMXEJFz4uPl3IAO86+BzluNyfdPvMHRDjqFquioGU296PRK
	uj8ClPrRIuIBNkY4A6U5qmoaIRsS2zhocW5JN61UgMRxEXRcjIY/dip6gdLgbUZQoInYLBlSELt
	pwEubHHESxcaKQPjYwSKSF/cE90NPfVxfa8fpUE+w+wHrO5wk5pnR5wIBK3SpEYq84y9ZhR4=
X-Gm-Gg: AfdE7cnKyR0sn5rnV2ICaEIRbiSHn/u6vzYB1iSe8PiJIMtdWQgoxfI2D/ZySXSrbiN
	EXBv/TIB1pvIIULAQeUqCu11qZP83l/w1z0geZDlGQj+PnfeK85wa74SyAZQQZSaOJfrxZj4ipv
	3ipkNcfLBn4PIjUq430AyYtKGsVZunz8x0cRa9RylKSii7Xgqa6OXl1JfAym8KvuHVHU60zHyu7
	VUEVjDbGsVvCYxAzBiXD2Ac8Cf19y/54W9RatzgbV1epU/jQLKsuo7Bimeify5SxTJm1vF1n+Yd
	zhkKOYqT47Mzn0W51nGeddmuqEw7vCni3KtUSAIxdIgsaMRxFqgUye7TmIyfCJW4L+3TuRENC47
	ijFArbvEr80pU94pg7xvFkEgoNchHm+S1QFI=
X-Received: by 2002:ac8:5f83:0:b0:50d:a92e:fead with SMTP id d75a77b69052e-51a728014a8mr13182691cf.3.1782382944044;
        Thu, 25 Jun 2026 03:22:24 -0700 (PDT)
X-Received: by 2002:ac8:5f83:0:b0:50d:a92e:fead with SMTP id d75a77b69052e-51a728014a8mr13182371cf.3.1782382943539;
        Thu, 25 Jun 2026 03:22:23 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fb8dc641sm152400166b.0.2026.06.25.03.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:22:22 -0700 (PDT)
Message-ID: <df35362a-aa97-4cea-a18f-2bb8b2a320d9@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 12:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OL8XGyaB c=1 sm=1 tr=0 ts=6a3d0161 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9YL1cksPtRnqhRk4DJMA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4OCBTYWx0ZWRfX+AAMAHJz1yfi
 B34rAPtohfLMybVwp2eOL1eCGzyPborhoYageiu7xQMQrXaI6qrcrYu1r3Yusa/3YnDlwFO+xrn
 pRBOZFirTdBAPFPQxoWDzhSYp0v/ZIQdgNF+H4eFGK4PBClIPEFPjlG/JE8tSMw9qaHrvvikTSD
 xV+wmLJrujMMadIkFgp1qLVqVxt7WpjnOeTxziChT0phqz+5DwexcH6FGSm9k1WHrPsyOEHgqLq
 aaGXdwywz037+KF/CQC7Ja8pshhoegss7sF+NLkUw8gJhrWZ+4jYJVZYwBs7cM2VItIiWnKCoFp
 MeitB2IQ/G6AKxvrX1wEp1Wo7222sbHEVb5s9Een9F04pXVOZDTLl2I2dnyCly7bistSW44pPOk
 09y1AvOGGNYPYotrF1QgNV95y+WPeLtXINjK+z/wLQlrV/0dJwPEBWGbyIB90V4k5IFGQgKwZi7
 NgyvFpOvO/OSoi5pXyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4OCBTYWx0ZWRfX802F1cTwpS8F
 4jV9uC5YkMPKYIR1lJzu5PAnvqtLfzzLy6d7gpfFBOhfvFSgEbNeY4kKtJmr9fbA9tKLrcLcv7f
 ja/E861QApXM9jAKO7wZHmo6mLJfloI=
X-Proofpoint-ORIG-GUID: DsIP1AZzxisp_cK_26dJbQDsDYeReUOw
X-Proofpoint-GUID: DsIP1AZzxisp_cK_26dJbQDsDYeReUOw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250088

On 6/25/26 11:42 AM, Wenmeng Liu wrote:
> cci_resume() unconditionally calls cci_resume_runtime() regardless of
> the runtime PM state.
> 
> If the device is already runtime-suspended before system suspend,
> the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
> As a result, pm_request_autosuspend() does not arm the timer,
> leaving the clock permanently enabled.
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
