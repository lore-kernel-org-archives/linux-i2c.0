Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0563F44FB
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976951; cv=none; b=Zto0j3Lq8BqwfU4bLhGFRfpO6e1HpWqjzDha/uaWBWH7JAKXyXQIIAs7nxPXYI5FD6fkJgQfv+Ql/A1dlqGPPWCOQon7kT4BSSIt5SsCyDLf4hkUSekCHfQY5AWNwInIeqveLMYyYz5jTl1LRxKc+39w91y1FLGgiy2SGniCJwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976951; c=relaxed/simple;
	bh=nghA7EL28OfNEM4e9sWQAgadJqI6/vgmN/VOre/IdDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrXS7Gvuw6TrJi7vkdTOCQmOriFJZuUO1WxcPu+QW0Lzj28PFbrEEREX8U1DZ7X5TGVAvJxEN1iqb3nKxjiHzcgZ67/Ad692W+frvKOImajAdfG/yukOlnAfkYjbzKXp7EKHDSf+vXKqzD7bLyJ4V8Fwwsr6XVZZ4XVSES1a94g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SbwGiBWR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aPwWm3RS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SbwGiBWR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aPwWm3RS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8owpx3001160
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 11:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ULOvsH3n2tUueS7iXn80SHHQAfBQb3QoM4qM4FM0XpU=; b=SbwGiBWRRgrH+SNj
	luovR9GAANXHx7sK0CrljeCvKxSrqgYh3JPldEv1AFpQ72Hn/zQZg3ILsZkfAcb9
	7oI5bRMcHaBmckKiv4BQVh3//5udIgmeRUctlKHQJ16dMK11WNBNK3r56buYdXFz
	osmtovfZ19J/GrACiTI7Mv8Ux+d3J+GyJIAHWjyr4o/RZFdQ3umvq7bfDtv1uTwv
	uE+iaBxS9qN3z5OW7LUMQWhHRo33B4ek5zBqeBSW9u4tSye0D4FdgCIZLA/2mp7p
	mPc4CxFNIR1CxGe7bUZIKo2tCrTBEtZR00b/fmGYRAnt03genwEyJkVv3iDrBLre
	5lVvSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbeup53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 11:22:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dea15d721so45313685a.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791976945; x=1792581745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULOvsH3n2tUueS7iXn80SHHQAfBQb3QoM4qM4FM0XpU=;
        b=aPwWm3RSn2w5FNoKkmmfbbeygQziH5O3QSLhUAF6RGBXmKldOnD+zUzAAPa+gaVEMc
         qsDUgVx4nYD9+qf4+dcV0/KhvaO2IABlSWYAwCHLdHFRZN2Q5YkpRscegJOelReHv8HK
         5SY/153/w+mO7pG5Mod89vpkb8lDcIMbU8R99NGtRPqMDyJS2rsV6+A6z8smMvoZI+8Q
         TudzoaCkHNJdU9lz2FY+bWiAf0ecOyS84MgQSQqhXrPAtgPPjhZgNbTgPs/I4p/myfIG
         N6u+FQCTz2w+anD5fsj3s36GAQP2Q41eukQWmxrdUX45xkzij7ltG+4xxahy5uoNs+nF
         ldzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976945; x=1792581745;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULOvsH3n2tUueS7iXn80SHHQAfBQb3QoM4qM4FM0XpU=;
        b=WNlTHkbAG1SZw93W/n5ov0ODnAP8ieHglzOgQitStc6wL8NPLu6xZcT/ID/PtwJ3wV
         zdMvDVBXkdLIm4PvQSB3sVuv+VPhC8UFazOf9xng31OEok6kPYwcqYHuzfpejvgTFGbm
         7CSSCjw9g+Z+ubSc5HjHtQTfXqIr6JAmeONucOXBvbAqsk/vZEMeosfYh0xjyD9zwJAa
         Ev0UVr8DVHW46P5hV8AP6zLkn/7E+pUWltUoN9IXa/PHIJkFAIA+DBEZSs5Fc14oARN4
         I6aIoxeN2pAkxF95tsDBY9n1YsRHNJ2jSrQUmfBCOtAan61H69GNdWsDivq3l6dQEp0P
         liEg==
X-Gm-Message-State: AFq9FYLXG+i5id7YCtur1/UyyUWY22Tzb+gKZNSnYUbI2KWcfsJzkeS/
	EffF3aaNZWUhGn9kzy4tbAv9Mg4bbZMFtHPm+fCNIOOFP8BJHiirM1OLDm5b4XE/bSZuzQ9HGEp
	SLxt21nB+1gBY4wfPtAaUkFhUGEnIVBNfWxceRq0HDNCghsWW5pcUuVf2PgGSQ/2Ri7Nx0Ss=
X-Gm-Gg: AYBFou3H5yrJygw2KRwDjJreApLFTLfcYjgeMJU+mmrFQLIhautyp2H/XUqY7j2I8nT
	I7jawhAUtYnJouf3i2rtAZqCoOK8CGZgv8qBUDk9NwQGrlGBsVpwHxnKKN9YyiorRqg/tS30+7a
	av9u/Tz/yAPwa/Bqx8wy1TPn54dPE+MxV4lWsPpaQTZnLFKcWOd5QlQICXRLGIXkCdLJJpIpR7p
	iFTnorBLGtnkxlp280s2WgmXwkmGmvPThSYoDpwarzBWkl5f6eABF3xKBaGtGKNLWuORyGMJqau
	pM56dUr+M8wNuNMevEGMp3EIMo7JEn4um/eQUcTFEGh+MBqVoY6eJa6gbd5aHSblUdRmjEgbwcu
	YLzSc2A1mplt9ANNst5xoeQ==
X-Received: by 2002:a05:620a:2a09:b0:93e:6618:f4b0 with SMTP id af79cd13be357-93ebd228f49mr2901474985a.4.1791976945236;
        Wed, 14 Oct 2026 04:22:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:93e:6618:f4b0 with SMTP id af79cd13be357-93ebd228f49mr2901472885a.4.1791976944797;
        Wed, 14 Oct 2026 04:22:24 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9ae59f9sm689583166b.80.2026.10.14.04.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 04:22:23 -0700 (PDT)
Message-ID: <056e06ca-02cd-4bc1-883d-a92bc4dc675c@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:22:22 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] i2c: qcom-cci: Add burst write support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
 <20261013-cci-imp-v2-4-6873326b44a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261013-cci-imp-v2-4-6873326b44a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pMLTEl4cP10eqNfzBsudXwssZ1woaMPh
X-Proofpoint-GUID: pMLTEl4cP10eqNfzBsudXwssZ1woaMPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfX3Ooj2Lccv2bl
 rRwia87Pjr3qD/tMjnHFkUlSvVgWEjzhLt0cYwLDg27x4OwqSmyYU4ljd7CeqrhxB1yJk62pOjV
 U4Wt//+KzeqXTLUm6mHexWocPU8wWXbad1X1iw9hoJGzSE/fEGbaE3Zy22TeNtXp0X22U9wwfqn
 9b342XJOf432SahCX7mis+y3+hmd2p1P9TnPFGQT3xlsIhMFawIkCNumo0xDiM+X9MmkNlr75SC
 odIxhM7n+B1NaWhAZbNpCufH6GKf5aTeT61HcwBHzA4UMIIUaIEmHqUW52M2ut4iltUJGKGwQIn
 Ml8lHki3eEFev1Ztv2JGI7nFULgl41L1MTZzYwmE07CU6/dJg2wkMk8BomUbQD5rY+kMzaYlgSo
 9QNzVN+XHA3QaZB1lm4ugQ+x4r5QE6Weut+SjHz7FyapTmwYGM5zSJ8njunaKxfNHA5SwTp92RJ
 PpRUShxoeIFkbfJR8Kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NSBTYWx0ZWRfX2tDtvCAXRysY
 x1cuwnH0NUs/p8kB656X5g7C2Sx7pC4UG7byld83+jTky7gzPFvvKkRbQubCSE7l1eOnlliUHc/
 +jBkPmx5KQhTA3FkVnjnFAATUUb8KFo=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf65f5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=_CiVM9ECRzYkMLiNPFUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140045

On 10/13/26 12:30 PM, Loic Poulain wrote:
> A single CCI_I2C_WRITE command can only carry up to 11 bytes,
> so every i2c write was capped at that size via i2c max_write
> quirk.
> 
> CCI v1.2 introduces burst mode support, where consecutive
> write commands (marked as burst) run back-to-back as a single
> transfer.

[...]

> -static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
> +static void cci_i2c_load_write(void __iomem *loadq, u8 *buf, u16 len, bool burst)
>  {
>  	u32 cmd[CCI_I2C_WRITE_WC] = { };
>  
> -	if (WARN_ON(len >= CCI_I2C_WRITE_WC * sizeof(u32)))
> +	if (WARN_ON(len > CCI_I2C_WRITE_MAX_LEN ||
> +		    (burst && len != CCI_I2C_WRITE_MAX_LEN)))
>  		return;
>  
> -	cmd[0] = CCI_I2C_WRITE | len << 4;
> +	cmd[0] = CCI_I2C_WRITE | (burst ? CCI_I2C_WRITE_BURST : len) << 4;

I think this calls for FIELD_PREP(), but we can do that as follow-up
cleanup at the end of the series

Konrad
