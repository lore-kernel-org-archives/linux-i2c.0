Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C23803E1
	for <linux-i2c@vger.kernel.org>; Fri,  7 Aug 2026 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091637; cv=none; b=VlJkhytxxRowCZdAaHHXw2U1oazB6+ffQyuc/tsYrIl/LjoVT64DwEnAjzSxXb5rJlU7Pm/v9zL6UwUJD9H1IgRli9N14wVow06G3I368poa/tAp0YdalqQVSGPpKAoWSRnvxlVQVu3Ws4dMfbw4TJyo4hpJQz4pejyTM7i9BlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091637; c=relaxed/simple;
	bh=x1vVKhvudq3tk61eX99pQTPKqzE1dzS9VLqLKXITMPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C+iA9sc3K68NpW1q3d4MVM6iEkTKYYhzgF4oBkA+pCiAFQ+Sae2vYZE6exvDP2gOjLzp4ZWJGKItzrg7LqKmE0bpQhn/0gmAxf8yJriEDjFtKCNx0PIgCrbcGk7CmuiURbHq5Nj0TFDTsipoAtZB3fMIoDKufKt4ObeAj8pM1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7axpo+s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZKNzoahm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7axpo+s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKNzoahm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777ltBM3822023
	for <linux-i2c@vger.kernel.org>; Fri, 7 Aug 2026 08:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L3wO87GXdMZGUsWi3XJQTeTTHtW11dI5D+jHGfKjZEU=; b=H7axpo+sdS1G5PPS
	ud7SqW8n1iTiZBW5B+oRtcscyfCrcuVUE3ZcTxKNTNBEE/HTK5LE0p6wLOnuPTfQ
	AsYRNoXudI5w1fKkCNSP9+aRhs35FfUEWl3DTkphXz0a+TZ+qaCmCxwhXeMm8aZf
	OwUHnqS7PQl4aHXHYoPPV+Zg4kTlwFBN4aqpScxyjVTvKU5c2SUi66KzHin9NPQN
	ChVByH73UJIBlyg/EcGFygITRq0sTQ9wO0vTshGm35KHBtsX+RI20k71trcCTg0s
	6sY0cvgufheIJvbLhaJIqyyXIRTqOTmGmLGFEPNyDlO5MSXAhWWbHpk2MMWEp1FC
	2VJAxg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gu2y9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 07 Aug 2026 08:33:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84870e7f498so3461324b3a.3
        for <linux-i2c@vger.kernel.org>; Fri, 07 Aug 2026 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786091634; x=1786696434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3wO87GXdMZGUsWi3XJQTeTTHtW11dI5D+jHGfKjZEU=;
        b=ZKNzoahm0II56mC5HubHshdaUqkXpYtDDEessXphn05jvYMLzGLDk/7t6ZEbDhifvZ
         hdqG0mhV7woMtPcQrtyonkL8Zr7y3Hi5UyNnrSqwloH6OaPtDP+gpOWQ2tHs70gIDU1Q
         GCnmqYQZSphGaHn3E9TDKBoVCP73t50WaOUHqo3obOdRMTh0vSyEL59gP3edpK/50wY9
         AXmK3iaL7hylPCgOf5FxdH4kFVUS7irc4ESwQU22b2+Xz3eHTXLW3PhzEa6UHmfyOBZU
         j2ns5cHBI4xRe49HSuGyZtSjjkTo3KYxS8SVgL1q/axQinIaW+tuRl6MGOTlBLl6Dv3t
         G9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091634; x=1786696434;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3wO87GXdMZGUsWi3XJQTeTTHtW11dI5D+jHGfKjZEU=;
        b=AL4UFs33F/k4HU+/abCn7zxDj4kWMUJjDpYe5oi6uglwZHKt7pa7Vhnu16ea2vj8mV
         pBMjvV8VO8cJLbjmuGaffbbwbn4Sur7NLlIOL4uyYo1R7vkgA2f0yQJsXuxjHpQgwtH+
         U8cnie3yokKtujz3FCV3X0GCjUS9WoR+3KvnCl84F38u7VfVrEuaax/ZsugiBExmXT0v
         f55+BMfd+389CztQXZTPMrFqh/wcgUR1ySkJQzVHNV7wD32gel6NfYF8cADnhsUTzj9M
         bvM6AAQvGgaB3Jwa23kNZ1REHxGaO65Hw1lG1m5ZuaTkR6EeTl1OXeCTecAX4OtS+NEL
         3pEw==
X-Forwarded-Encrypted: i=1; AHgh+Ro14eTrICCZXMXNXCB09eVmHSt1zd335ucBxGyWfLpxiFl2P5AhPa/tmsg9FuqxOxmytFWbUEh2tf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEiDIct7gzvs3NwM9DTgds1NBe2Px5t4I/nvNjwT6KQ+iJEs0t
	o8ZuC+HVxNEIqkuYTVAgPp3vkYJtYyFgJoxg7JeT7FjZA3PnajUtqhz6HtvjDDHNvE1yQWR908k
	g7eIYCK5siwcTMn+9tudHmjMFeoIp0QDXhFfWyBYhE+8s4B2z6rXBb3USOjFBXpdzDSoyYZ0=
X-Gm-Gg: AR+sD13j/uFvf/G+yHXYa/alFzNt5dhDyPoX746Vx6XfH4FST7O/0mRzO3D3/9KUDh+
	pfLanc5Lf7gK7Tac5n7n0vkzWDNPiYJ6w2F+L69xHNBGn/SLN2gbyxWws/mSMzXm0y9MtNeHoiz
	OCdA8NRtq1qdZX5DLO307I0vmONGdc0o028AvKx8v4iHmOLkiOPUmupiRM9sKDHru2Boh2S0/sz
	EhJ5yAUT2Sqazgn3yfQcoLyZuLElK9ZwXoQeyYzxEKKBmy8zRevbKmwO8NBv1f8lCBnigl43bVX
	W+7a2Lqw8lk48eq6U4aeRAxisOz4PbM4MtiSYahA/eLZV6l+rEfdgGan0X7F+mgjUREQtrcz2ED
	GKXVPRZm3+nsC9Dhaiz9z8H5aIRM1MHopgw==
X-Received: by 2002:a05:6a00:a116:b0:847:439b:ae30 with SMTP id d2e1a72fcca58-84f2e04b336mr22951206b3a.20.1786091633786;
        Fri, 07 Aug 2026 01:33:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:a116:b0:847:439b:ae30 with SMTP id d2e1a72fcca58-84f2e04b336mr22951163b3a.20.1786091633331;
        Fri, 07 Aug 2026 01:33:53 -0700 (PDT)
Received: from [10.217.219.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a2173sm649751b3a.1.2026.08.07.01.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 01:33:52 -0700 (PDT)
Message-ID: <d9c7934d-8b88-45fb-a3be-d1dde01d8eea@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 14:03:49 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Simplify PM resume error handling
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a759872 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6z8TwaGRFWoLiM2ZyNYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: PqtWhQpH1Lt6t1jgE0RIeOoo2t8pXn72
X-Proofpoint-GUID: PqtWhQpH1Lt6t1jgE0RIeOoo2t8pXn72
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2MyBTYWx0ZWRfX+51MVfQhe2P4
 l2EDE0LvE05whyEvOvTWKhB4EHaRUGhvj0BFgstBFGYBg2rKoAo3CN2Z3XApDtKRDAqLrPk6/hJ
 EMU5BRDHH808TX30wtTXqFDw1QXbr5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2MyBTYWx0ZWRfXxuvasPS2aUw6
 8GJ3k39TmVwiBOf3HHOAaRBVM1Fx4uA6gqD8L0ADDIL7kpaeVWwcx4+pG5RE7ZzvhdQxH+CkKlm
 woNhR/ozkdSmv+Dv7Oc9cPT7eGvFjPCzjBNRIU809Me77fZBMv3tAv29wu+eOA/zBwJNos0ZrSo
 YByc1SljBDH3+rDolX5QIMhOelr3yx0EolYY/HsUzQGRekrs8mGAsksuvyeWnESGUtXune6XchI
 cNbdJxyzZXCBn6ZTYo8M4IlEH6kuyg+3K2m/70c7OZOZi6YnunEIGiG8pf6WvYR4OJedahzAg7s
 cpbAeoT0ZRrktoqt9rQgpRe1Paa4UuLTO00nutK2fhvG5J0ZfYnDgCY5drYOA7O3CtUmEjx0+qZ
 DQE0Tqk9CQIimFIrguqsDtCWFgHO7cMRK70yRTCBHFAq6Q9ocUH/vyF6fUV3II8/zy+RN1Fr6ux
 2sHxx0/Tn/q/6GNPtmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070063



On 8/5/2026 12:30 PM, Mukesh Kumar Savaliya wrote:
> The driver currently logs pm_runtime_resume_and_get() failures with
> dev_err() and returns the error code separately.
> 
> Replace this with dev_err_probe(), which combines the dev_err() log
> message and the return value propagation into a single call, consistent
> with how all other error paths in this driver already report failures.
> 
> No functional change intended.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index d5c977e34994..96015e077b69 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -994,10 +994,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>  	int ret;
>  
>  	ret = pm_runtime_resume_and_get(gi2c->se.dev);
> -	if (ret < 0) {
> -		dev_err(gi2c->se.dev, "error turning on device :%d\n", ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(gi2c->se.dev, ret, "error turning on device\n");
>  
>  	proto = geni_se_read_proto(&gi2c->se);
>  	if (proto == GENI_SE_INVALID_PROTO) {

Reviewed-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
