Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D93BBFD2
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997466; cv=none; b=LdTpkDgeSFMPirgpZc75OiG1yIZPbST5yVY6n7/WJlV+BT8JUmQmopG82J/g1zWNossH0sbITaGLtv8tVQI9DQIkuNeCHe57gJJ/UWSCzULmMqcxEp5o+pZ322vTafDgJyqBtcI61fQrRXRjblhZXWIjXkPqu4Mpk/6BqpAPYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997466; c=relaxed/simple;
	bh=gd8sCEyaTAI7eMdD2HXKVF5GZpAOb71YcgaX0M7X6ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tX1MufQ94RV80z5Ft/YHrWyScEP6Up2bnmHyC0aoXRceUuTZdH0aFtqgcmK6jETL+zR6yGcJPYhPstL04qyxrCjG2x1UcSxlBEdYxwDU+KR7/o8++YW3S2nbQZ3LGAxXkow+shBragwso2PRTf1F333MJyw1myvdK55IAIvPDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTgBK4FW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S4llPrdF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTgBK4FW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S4llPrdF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdxX31413969
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 13:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g3ORugXsYMCu8anseOiym52xhd2lPDBnueeArAPXAPk=; b=gTgBK4FWqTTyedEL
	RWOVjTGynMvHsZAkjh2Oo24HsGE/bMd0IP+2ZWf+bUr9VXeoz8UbrcpCKeLtwL1z
	PrymPnidCpPbhom8qP4tGhQ2cxElHCgH/x8Z8bXuw2bz4Zkldno80HiZypUtKJN5
	FIrLZPGpwd7kpPgk72kJWTKzWhBW44p1z3zZ7T3K+FGrtE9bKD1EoMU9JQEYzvvJ
	T9zEi0vFcEUCJ09Yn4WSKV3GQTa1x0JfWxrpFtGdGoU91ew0DiFR4c8XCdgras31
	2+F33bAYFBAzxbcxA/Dfk5qq8bRngKLsh3cEUJ7WTHpPgELdpycRKzoXsO+RIiVQ
	8NCNJg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d1f16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 13:31:03 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-451b3cca625so1148467fac.3
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789997463; x=1790602263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g3ORugXsYMCu8anseOiym52xhd2lPDBnueeArAPXAPk=;
        b=S4llPrdFBCDknJjZUY4lVuc1VBLvYJ9LetftWPhK0TefeKbcVxBJzYcaBHby+Zq47v
         +wvIsoVOXWz85cOMMUf7yfPRHP4WvzBNN7KIwVPPMSxLMDTSCrvmYBBReLTs6T0sxIlt
         ch75iXQ9oz3JcjAbw9g374RrwEQva9LXrSmcwtKf9giWEhpc6K3Z8bhuVWsx6fcm+NTo
         wrjjmigpkdZqBEyxoItiXTzDcZ4aX7ago0gJMTFMQsTkp1x84rfEEKdDFkWg3+hGwS8J
         eIcU0EdyP6GpJRJetJsJDzaBBbYHNvFTsUeEJZt8AMqtVNhB6lC20n58knxQX+25MUQr
         17GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997463; x=1790602263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g3ORugXsYMCu8anseOiym52xhd2lPDBnueeArAPXAPk=;
        b=I+mLCSwvbqwVGs/GdiU14YsRSHDY7Qv9Z9TPrWBLfSKt12sqKLrVdfalYXcWkirxEB
         grUguOA0QKjo6n3KiwP3pEJoGXdTaC3A1sekHzfFxm+LIwSEYres5h3QFLJdOosLWLm3
         0YNnJzn8UHzWe4/zM7MkF9nEbJqBAfPMenDYh/v7dWdrzCq58xCQvc9p8WW2nD7PUiRz
         ZSkzhOlo1u6WPZzDSUoCKIALpoWxZzHnNF4ipC650UZ6lXfFbWHToPIU9NiYmHJ17Vt/
         1zEtWBiYuvRju46DfqbtDxAm3mJU2xbxqby9EW9N3OmeIVFeU1otZ2VooEKuHv7opFh5
         fepA==
X-Gm-Message-State: AFuF++nJBCumSaXwt2ehWZ6ofMq5IUZWn1qXSofRfpCLBWbiF7l7LB3a
	QRPALxftpAam3kmY/ukicxXPEd4W9cPuOVX+lIqPpwicN4Cus1qvEtehftC6E/pd4QS4AInMVIS
	bzR3+6I7weSMCfd1zUsRyqWXPYVP2lqZcmDLuSNCw5Fzg8k2grRfrd8t5yA7w/VY=
X-Gm-Gg: AYBFou1yA/Kor86G9EeAd7CiJpspsPy9cB2jDd5+oAYQcFQ2rpS8EK7Uz/UklWmIZHB
	zDTAMaC0/0tS3ISbTkqNIUgsIvXTWsh5ZiEcI2XtXgtnNqLeKoO+luNq973SvycfN2KDonyJAma
	bfx4FXkOMybIJ2pcyVMqFrJLYEj9h0/3JTurasO+vMnN3uKME57iKp2ddFjGG4ZQd8NkcnvWAqf
	vcIXeuaCiBvVWuRFaMRfY6R3dEQYAdTov+o0Tuk0Vj9iWnsO8+WCoxtORLFbXxHt9xNEhZzOYXP
	RDFfbHiLwMQggQY37J6uSqjWtYvyFBPZISPJpmCWOfukvzOasxnwg1FU9jV+O1y9TH/q9QRPMPB
	YSeQbRc/KiyuHBLqxLNJEwQ==
X-Received: by 2002:a4a:d857:0:b0:6bc:dd88:2782 with SMTP id 006d021491bc7-6cb1f3eb6camr7294782eaf.0.1789997462920;
        Mon, 21 Sep 2026 06:31:02 -0700 (PDT)
X-Received: by 2002:a4a:d857:0:b0:6bc:dd88:2782 with SMTP id 006d021491bc7-6cb1f3eb6camr7294751eaf.0.1789997462507;
        Mon, 21 Sep 2026 06:31:02 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a837742bfsm69119166b.44.2026.09.21.06.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:31:01 -0700 (PDT)
Message-ID: <3b706a60-6903-4d75-bf60-8e2a95333dba@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:31:00 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend] i2c: qcom-geni: Use device_set_node() helper
To: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260919141434.22999-1-johannes.goede@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260919141434.22999-1-johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3z62L-MPqNx8r8KPqIH_gvYCohvXO3cB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE5NiBTYWx0ZWRfX5gLkHBMr4XrG
 WNqZttHNTfzqIx2VrOJZECmZkiykmb9Yu4QS44hyl7SZu9YfNu6nFy38AWPImb/QcPfuZkCvx3Q
 4tjwwPpHjOPomurbTpqjVJc5zka4gpQ=
X-Proofpoint-GUID: 3z62L-MPqNx8r8KPqIH_gvYCohvXO3cB
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab13197 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=sjX4YLzMi0i6tBz261wA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE5NiBTYWx0ZWRfX8Xia9vmVBNtS
 LlfxhNn4KuIwVCDHCJ0HLue0ylSrpA7SxFEnLIit/5rBElIJtEpYUZg/iuOu2ZPItSYApyK+7Te
 PMIXAjN8yyBvLMTpSXsHG8eftUdoM638AQpTRXP+6UG4kNexvWY8qNO5fUFiWIkJ8Mu9e8UZw6/
 gs0F77mJH9TCWpvlKzzAmuB3aRE/EBkzlLPJdjLR+1yMcDhu/OBDUOcYuo+O1cMFvUAb+QEY8rn
 prACYRD28Xb3BTZ9IyGlTWdXlfcEwpCHPhQIIfQ2X9oXJv0GV3Esx29w5fX9CvktrQ/LkSp72de
 XsA3s12tDuOdGH3DuFM1EXNVzpdy7i4jCXOfcv2sbzEp7ZdeVTRX7VR9PS01vkJqiL540Phsl/x
 GY5nUWO9c1zjOZ5KEjK0bHWQmnkaEbjdLEatpTmwhixelcnyBiL2rShKuAG+zAxXY0PU+MLsLq8
 bRgGkhQjSefKSB5vPdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210196

On 9/19/26 4:14 PM, Hans de Goede wrote:
> Use the device_set_node() helper instead of manually setting
> adap.dev.of_node, this:
> 
> 1. Ensures that in if he parent has an of_node adap.dev.fwnode also
> gets set to point to the parent of_node, rather then leaving it NULL.
> 
> 2. Removes the need the specially handle the parent having an ACPI
> fwnode, since the generic helpers take care of this too.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
