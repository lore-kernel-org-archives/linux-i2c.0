Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A53101D8
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686598; cv=none; b=M+mAbEBczkisSkmMO3Pd0Xe14LhT0uu5JydTRJern+F+a6ZnIr4TtRDBdp+ry0wYcz4bF3A2rWEUrFET0+P5G6TC7sFonaHa5DIWmQaq8F4RSVesrnADu3ZbAUF55AugKE5jURInplKKSBGrDoP5nJAh0jbg9ewUy3V6FYqJiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686598; c=relaxed/simple;
	bh=3wIAzKPMdoyp8yj43soqVeH7UyxqeDxDnqA2PLVj8eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l9ePlY623IJTdP39vYGSHNvXaty6nvtCOLsO8tETjoUYN1j3snTSYdYe7TC1GiQpEk3wNiMQRJ4Xl8JeOhYlbcJxqaSHL9vD9JLvDJoW94VcIfUuCva1x80iKpFlkWISBp7Stea8+VosCFjlsslsFnLm9aTfY+a7WQfMmbKCll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nfXRXo/m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U2ilHJBS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nfXRXo/m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U2ilHJBS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAnCLu619625
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 12:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lLbBU18I1z3GJHSsjo3r+iJpKtCAH2oQJdTEa9dJr3w=; b=nfXRXo/mLW6vi3x8
	lV4pLLDzbEg0xot5NhaqIyUgyXZIa0GhbHXIPMpxjBTo+5/fJv/1s6dt/pHO9u7b
	DaKZEmX9i7FxxJfTKvTpu2jBAo6GmaZXE6TDUl+JkFSMoFiDzNqFEhs2xzfDylRO
	t3dCoKdjjmFtS3M4emjBz7UzlPviErCheumAoIz3T0rVpNeQxTyUqc5BiDE+UzdX
	QxelfaUq1n9d/Qod6I/hba9pYAkTsvFt+rfwmn7TTr+Sm519Y+UqWUkNx4DPX9h4
	vOWCOdW7K+LdfvcEs94YxMrzE5kXv8rNhcP0o2YJ9gqEbQACCSwpz+MDirg/qBQ/
	sov0jA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fay3e0bx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 12:29:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c9d953b71so1609961cf.0
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783686596; x=1784291396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lLbBU18I1z3GJHSsjo3r+iJpKtCAH2oQJdTEa9dJr3w=;
        b=U2ilHJBSPCNEflwXdnbrstyOvREgrVRgx7imU5X5000gBC39F40OozQ99Dd4MoeUlg
         hWS4OIHWqxXVb1KIA2ZNhOxGunJ5Cz+zW3gr0eBGE9eLOySE5K/pg3+8+MLzjFZerN8x
         VAEbWCZuDejcA3paQ4gd3hMYeVhg5B80kybzKwwW6uNV7V/6pPKVk1eLwEtPpUpk72et
         kzjIFwWfCGNeBavydhbhDb9nvR0qpN0n8LXDJtTrzEt+VRuWB9xB964OnPRbqtKQ08OE
         m7IvizBALcKz80qz0x2BuqhHmjJXHqHKet98qPrdJO+2zkSjoLrEgexRaaF9GNkBrd8q
         vtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783686596; x=1784291396;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lLbBU18I1z3GJHSsjo3r+iJpKtCAH2oQJdTEa9dJr3w=;
        b=tWsqbMQWT1bE4AGWsazNJheN52pPlWtxS8yB2K7eJf6kuDjR8h6oXsYRLazM8m2w7O
         R+E3qb5GSj8XmlnUlpflxMyiW4misclEPPt3y2peipE9Xe4z8WbnQVtmMx+Du2ZQNy0g
         4agBkpS7d9Z7sMo7w2/K+DCsMjkTwxYv2CKJDr7JhxPK3hV2yJyXkbzdMNcdzoqF2sbG
         VWGH1q/T168kMOy/LFlAXTtMBGzbzs+Qs/94CCL5vIq3XDBfwiL+msZvlKFrZNfngBOU
         HaSut7UMEfnsc+Wmllu4l0nMzFX0VbvHcYaC50dmhDiouijj6Mh04cE+/xw4V9tlylwR
         mSyA==
X-Forwarded-Encrypted: i=1; AHgh+Rp06YLysmTedaqbAHA/QlEVa58SpCYykOxKrmix/2Sa7TfAxXxJjFP7THnGVzawVEr4Fgpb7aHF5sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLtOD0jGNV8mWzKw4OFqur4blBdW0fg08XIaz/f2cbO5gQtZ5s
	WvxDxPJdnginjT3WT/sZW9QqFCTqWtmFL4cXL4r6W0dLLqHq68fL6LHQleyZ+l4IpUM+jrJRcrR
	GUpWpa3Izp/7C/aO29bO8SaMj8nQVvGssJWW0YV0fsG9ZQzcUxtRpLx4jibgCkcE=
X-Gm-Gg: AfdE7cmtn4dAV2WHsSKVbS/tPjCqg7KHMuOjGu9jSU2CFOBeLvCq8Yyg5qfOtB+uHi5
	uHAvLqYDAABa0WyUGZFb7IU+ldTJZaUekarkq3RiH6xLtdcxxp/RH4MTvR45vBXuTOpyMn05qzq
	M6lkN4oC9maPmKFhtZLAP9ppKuJuhEnwvSgVcS2bgva4eRIGrYXvq6tTeTXNXPt6w9XysmVziwy
	KcvOXHVwRfBVOhwvSplTwTzivg1w52uQohaCDLU5HJ/7ZCFUPQDL8Q4t7xdN+vm3uPQViCT4MUX
	4krf/izL2ipLrKAmIF2pYKI7cQiX3QVpZ7deA4Tto4Ne8Ev7hR12VMFw76HTyIIjQLBNkxygXOE
	GDQdoMAxAye9d0pMGr2cyxlGH9A1iVUtkGl8=
X-Received: by 2002:ac8:5f13:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-51c96629826mr70336961cf.2.1783686595906;
        Fri, 10 Jul 2026 05:29:55 -0700 (PDT)
X-Received: by 2002:ac8:5f13:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-51c96629826mr70336821cf.2.1783686595553;
        Fri, 10 Jul 2026 05:29:55 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm10916055a12.6.2026.07.10.05.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 05:29:54 -0700 (PDT)
Message-ID: <cf80fc3e-2cfb-4bf0-bc20-dffecd347817@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 14:29:51 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Use devm_pm_runtime_enable() for PM
 management
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260710121356.4054600-1-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260710121356.4054600-1-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEyNCBTYWx0ZWRfX6LV14sdnkaf+
 RSxuEIcUCUmgL8E8JfheEQMF/hT4cXbu3uj0A6S81753e4JDa+USnntJDzRvQi4eIoLzeQ6xatc
 wWcIe6UaG+neT1KtlqRXPwdKoZg53HM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEyNCBTYWx0ZWRfX5iyLuBcqSG6V
 vKv+BztWNVGwxAYOYw+jyO2mBoL3FrolQT0ZMRlA0aR6TpRXjYDAuqYnnOyxHFT9IJVQBpGz7lP
 EzEgvEaaRLJU70Y2qgaFVrP/8IWC6nxWIv8D4RTzlEuSrHb31r/Are1LIWcsV1OBFUiqr+PPFuN
 zU7vgJiAyjnNSUeDXNk1p7lKb5bbU+YhQ9QHooYXyH+go9JlBaoaNB9YGKS6/9olRWFVhFralDc
 JGNJHZBs4rrqDAB+CM1fZyOHyoEaaQcDazTAdlUTqqikb9Qz096aEAgyioVekJN2t/3dTk21WCr
 nvW9hP3ggJa4a3DCFFt5jaBfIc9kc1n983J56y3K1n5gr1x7xjMac0kolVoMCjyjKq8lSEPXan/
 e3huUu5bRw6mtHDqmNM1WsMfTAszVXO9Y/eu5bp6OOLBAkSz9oxJHsfIeBt1+rrtkNmX4D/nT8m
 uofweOEVHHC1rW/Sqnw==
X-Proofpoint-GUID: Oms0anUabdfWHl96I2OXiVM7n2pPODM1
X-Authority-Analysis: v=2.4 cv=HqpG3UTS c=1 sm=1 tr=0 ts=6a50e5c4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=VQGEhXhxWgW9jRnbskYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Oms0anUabdfWHl96I2OXiVM7n2pPODM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100124

On 7/10/26 2:13 PM, Mukesh Kumar Savaliya wrote:
> The current implementation manually calls pm_runtime_enable() in probe()
> and pm_runtime_disable() in remove() and error paths. This pattern is
> error-prone and requires careful cleanup in all failure paths. Using the
> devres-managed variant eliminates this complexity.
> 
> Migrate from manual pm_runtime_enable()/pm_runtime_disable() calls to
> the devres-managed devm_pm_runtime_enable() API. This simplifies the
> driver by automatically handling runtime PM cleanup when the device is
> removed or probe fails. This helps  with Simplified error handling and
> Automatic cleanup.
> 
> Changes:
> - Replace pm_runtime_enable() with devm_pm_runtime_enable() in probe()
> - Remove pm_runtime_disable() from remove() function
> - Remove pm_runtime_disable() from probe() error paths after
>   geni_i2c_init() and i2c_add_adapter()
> - Use 'dev' pointer consistently instead of 'gi2c->se.dev' for PM APIs

Drop this paragraph, describing changes like is unnecessary since
we can just infer this from the diff

> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 96dbf04138be..6d6c2fa287ca 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1126,27 +1126,25 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	gi2c->adap.dev.of_node = dev->of_node;
>  	strscpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
>  
> -	pm_runtime_set_suspended(gi2c->se.dev);
> -	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
> -	pm_runtime_use_autosuspend(gi2c->se.dev);
> -	pm_runtime_enable(gi2c->se.dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;

This shifts the enabling of runpm> +
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_set_autosuspend_delay(dev, I2C_AUTO_SUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(dev);


..which is wrong since:

/**
 * pm_runtime_set_suspended - Set runtime PM status to "suspended".
 * @dev: Target device.
 *
 * Set the runtime PM status of @dev to %RPM_SUSPENDED and ensure that
 * dependencies of it will be taken into account.
 *
 * It is not valid to call this function for devices with runtime PM enabled.
 */


Konrad
