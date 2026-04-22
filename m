Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF73C7E16
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860987; cv=none; b=qT7GCEH7VwN0jkAtOMHtVrut5DxA0G6iNL5c9yAD0WcHR4CBOwPmdEM6cCXYTJtBbDye2nW4F/QFv4gydJzxKtrUgtlXO7NAiEa0RlIEhbSsPX349Q6bhrjZ3TlvmilQgO1JA6Y8wCG4pMp4jc2zlElWIckkd1y5Fsm4IziYRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860987; c=relaxed/simple;
	bh=HE/L6J58Kw/Um32nCqXMSP3+6Ed7LZDOAX0T3RjwuPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XM89lTMuE3uQUrndM1fZlx3/MDTS1iUDwB/Ja5ZvuJP0V2nxii5pt+qq0+vG5E+S7RlpTAuICze8dkyavkmkcZnzKjMoSf9spHNzYQSRFKnqJrwYhQKjCYSoBTCoTeLk23yEoHKoYnFSk82ESvScyEHpJwpm9fbpEGwxRTO6s5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gazFE/Ax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VwfcEZtK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gazFE/Ax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VwfcEZtK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MAqJV22209073
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 12:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/EUnaQmzyJXclg74EbLwevF4NYo7MxnDkmFbb66H9ZQ=; b=gazFE/Ax7ZwhxYWN
	GwCnQh6tjbpgKQZ4CoGkv1RC16zfJBfoG5/cb9qrE7ih1XzGUUFJeWWkeReTgXlM
	nDKKIO5c78r9a2mVqUYv74SWtOXzUC0aY7wyqL8faOBH7+1BfBzvlNYNRT8TJj4d
	7KmX9CfevABVKK9rIAu8opyOiWkRD9YklCnxazx7+MUZ3Q5z5fX8lRCrMaH1DTZH
	FYqODssQkoQIAaBuVQvq9RugcGv6MGfV++VFzTIKvq2/T8yYcWyjN8o/gMeMhQ6s
	bYHKs5YP5CejI4q2ARMezNFgOCPPQEKTzSirRM6pwZF9Bm3t0vvNW239YZyWKPrs
	0Jvs2g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpengbap6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 12:29:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c797e31a9b7so5743941a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776860984; x=1777465784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EUnaQmzyJXclg74EbLwevF4NYo7MxnDkmFbb66H9ZQ=;
        b=VwfcEZtKIaOB6gUT39wyeFmknTR+5RwlxUV8uvvC5GdPs7rLIG9XwVfnkXHnBjFK2o
         Iw9/SdGce2oqok0BtIPjXkNaBySTAdH1NM8xPefZmyuILQ9BV96KLLtkcjbYrlTU3vEH
         QnXEzp5DE9PP6+lu041ybhdTEyQguiz5EK2xeCBA/SBKWpwiDNc1yJaZ8iBTKi36Z1Y2
         jZVm/bnOGz4WI/O9I2sqPhZFI/6kDl/b6unEi/8IAYegK0QbPQZPeZ1bvK5TqgrVlYUI
         eqgTp41asXmkbVvZxfNxp6JsWJfbMXLB9MOq7s9jMTCX04qS1h/DkJeVHK46m6e6tc8s
         CH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860984; x=1777465784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EUnaQmzyJXclg74EbLwevF4NYo7MxnDkmFbb66H9ZQ=;
        b=OcP8kIfGQTo2Mo9K69vwhwB3nq8gmDehAACToBSBC8oPun1c/f1ah80IX8H5WcCfXJ
         DKafTmoZQ1aEKiKSMeR6DGFuwfct37SLozWRZpAeJH2FgverwCRh2+6P5JBi17PxfF6q
         ZqeoVIDWiYmiQgM93rBPoG9ogt6V9ffXLZr3q6WMFJ4fzYtDs0sgcPygvZUb6k7GH7Re
         hpW7tbxzyHvkQXnNVOpJv3zc7a3Sxhglz0jawp4takpJr8LD3W5WfWVow7VhUKWvWIYk
         J0AA4sDLdbDk2oMz//OsLxNxBK8+W2vP5zAiCCkv/RAkFLl01J0OJB90cGqy3iunLlcp
         Fg9w==
X-Gm-Message-State: AOJu0YwTMju1g+YtwD3Av8gtkFzwDXOfFUU8ag98NIXAxS/eqowCTdLs
	+0hTkmqN4UI3hu0IYEciTCD2r9lum+jKJaLGR4Cmob3kFJPey+HuawOBb09kAz2fGT5XhRVkds8
	joJgR91+vLOvZLQ8fSwwSbBRjXoXD7f7YGie5mKx7sqy9nuZJ7B43qD42tke/d+8=
X-Gm-Gg: AeBDietBcC7NdAPGByq5ToNxnVFC32w0mcUzUzHtB3Yg85m+WxQdLlDeDrEP4uVIQcQ
	++73BjrK4+Qot5Ep9hqSt6Qypt1OnRFZeZj7v+v4bT73P0esFIR4B3dYY57Ds2WbylmOzZBIO7l
	VMaxialFOUqyIIxacYXQKVjQq5lskJ8+yxXUPswVs8XLE1a0nEkKxSjdjvi1B5du6xjD4rotRwj
	ccpi/yepm+vOTS75FzGm2ASR3iCoZIaRXP3Wz/VDvjsYYfkJXs+DpvxmBX4TnbI4eEGF0iKyDWX
	QEL6fG0FONOVsr4jPQaDQm1EZXvghYErMBJ9yXSC1rYT37+dViDzwfO9A6utVnPDNhRSJ/XdGxr
	Z2pqjegrL/dmZxnKj58Rsp7mkwPSISlTGeEBWEdbPjxIU3+X0XHqHzBEM0sTypBCZ3tg=
X-Received: by 2002:a05:6a20:2591:b0:39f:3ca8:a331 with SMTP id adf61e73a8af0-3a08d7372b4mr25458999637.16.1776860984156;
        Wed, 22 Apr 2026 05:29:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:2591:b0:39f:3ca8:a331 with SMTP id adf61e73a8af0-3a08d7372b4mr25458964637.16.1776860983653;
        Wed, 22 Apr 2026 05:29:43 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cabfsm14406916a12.9.2026.04.22.05.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 05:29:43 -0700 (PDT)
Message-ID: <3aecc765-7576-4f2c-9588-534569936438@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 17:59:40 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] i2c: change return type to bool for
 i2c_check_functionality
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260421161607.61314-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260421161607.61314-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyMCBTYWx0ZWRfX9OTveqeJuv3h
 vQnJH5/D8f9qqvp7BibW2mFeS+7Oseo5+cKruVnm41jPh1aKy1zWer0zrrzaikhcb5iUePvKxVB
 l8QDl5pDa4A4bPoTV6CMYPs56uCJskmcW8E/5KBUsUD6lJ2uwWiTp91EYgw7ksLEohI01F/yD6p
 RFVQUDv8sRTvB3mV+OYoDaha2kCTiwMXttB4DxzbdGL1mvlHzZtOJaeEKil42+W9PtL7ypYKsJ6
 kL3uM82LTBSAlwKLEr9OkG8YgbNi8PVAzHaS4hMGTAhzX7OC8umZ5vMVUsFTCR/slQKLDfSTd99
 wvmOHfpYgneWW4yH51YUOb17Ux4+JgpGVRrx32SXUjnDOBj00UQt0iPIHF7ZvlhD9UPSdQU3dcd
 stX9MNtp3w9UeAeJYHD0uTjc4gR/5UrBALzfztHp6nVPdecQzvtQ6GZf0MLN1EuAx96C+cSC2WD
 y9MJM8g+FCdlHd/kciw==
X-Proofpoint-ORIG-GUID: AdL2V_o5IW0wfqzpOVo88RiiqypnCxsx
X-Authority-Analysis: v=2.4 cv=RYygzVtv c=1 sm=1 tr=0 ts=69e8bf39 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=UNYCHEIbOCCRWFwfwnMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: AdL2V_o5IW0wfqzpOVo88RiiqypnCxsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220120



On 4/21/2026 9:46 PM, Thorsten Blum wrote:
> i2c_check_functionality() returns a bool - change the return type from
> int to bool and update the comment accordingly.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   include/linux/i2c.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 20fd41b51d5c..6737bcbc5d7a 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -919,8 +919,8 @@ static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
>   	return adap->algo->functionality(adap);
>   }
>   
> -/* Return 1 if adapter supports everything we need, 0 if not. */
> -static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
> +/* Return true if adapter supports everything we need, false if not. */
> +static inline bool i2c_check_functionality(struct i2c_adapter *adap, u32 func)
>   {
>   	return (func & i2c_get_functionality(adap)) == func;
>   }
> 

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
