Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7AE378D96
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776178; cv=none; b=GVl3yK18HFljRYmxgNuSL7kagb962l23K3QJo3giBU+uPLrauvAKiOlskQiy+iH3My8sL+oHZAvJvFU/eFS1f7xjc8j1zVZ24W1WQcHD45r1eKD0lqTrmhsiYlwCPvJ/APiv/DMzmfZQSkAFWxBlSX4a97HE4YSqzV1O6zWJ9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776178; c=relaxed/simple;
	bh=JkbyxrYkyRVm5anzYwPv6egnAPQl+91/SVNeXxzRxcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzdeDuXIb1oI++hwCSdgM+vpOJe/kS4jArkl0vZXGDCSSPuFj4+KkWvV4PHd1e8qkG5iZQbysrEfxsuE+u9xdD+ChcmGdtC5l0VgV6psGlkYxP5lHi6yv0dpWg2K0jzZ8AgeblpPce+SW05kmoxjJupYhU3E9xiBPtwYmjQ6DzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXAUIgRx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BCz6bPDS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZXAUIgRx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCz6bPDS"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U7GXww2415318
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RfwyPOvS+wpVPPTCUEOdDVk2QBN2pxqX7UqPeosiBA4=; b=ZXAUIgRx4hZ5i4Qt
	bNB3tII/6jRofBBL5JgziPOHw4JXzs7XTmR0lQflwyl4irTOXieYW9q6xMz+E5pM
	qb7foZk7TPJLZvoZYhCtp8I63Bjq7QU+may0LYLmXQzN1B3LJ2RCOEOJBUJe3Urr
	/1x25ALg+ZVQLLsIN0B2Orhljak6vp2owu8nA7VIkW3xzAOQPWYtViy15+mEVdME
	P+8PiltpygB6YBsHdWpVRh3I6aqbn9e6ZfJuk+uY8TvO4E/5V7E+FbgwktAVV4Rt
	SZIZDZjkM/WBcI3g1bALvJcWEQjXbjCBGr2ef5lorQ2R/KZyFGfCpjOkKxRZVtj9
	q9AulQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0r41gw1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:29:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c7177d4ab4so13248485a.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 04:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769776173; x=1770380973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfwyPOvS+wpVPPTCUEOdDVk2QBN2pxqX7UqPeosiBA4=;
        b=BCz6bPDSaJEWvj9qXaBlVRn/PCqNIK+8GutXDkjheAEEacnQEG17OPoB45Ks4MSpYT
         ETjftAmmZZ1jgAHgQv9helnH1PBd1ipbGfRB7161a5fGp321VKwnfhsRJOGheNntZuPk
         fxDoaNVag3VmGZTHY4HWk882tzQU375pIDgS3NUnwkG3Hh7Zsp+XcO93Hg3X0POec36y
         wfnFbEEwbrrgWsXyg2Qys8zZiHc7SANy1rxhPdF+nSNgaXKqlyGhyW3eXjnMICO9Xu02
         VlBX8slljzg8hJbbBt4wwaIFv2pC5R5JpKpLcZ9Kt+a8ST/zRWTv0S8lfnUBpKqc/s6O
         Texg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769776173; x=1770380973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfwyPOvS+wpVPPTCUEOdDVk2QBN2pxqX7UqPeosiBA4=;
        b=EfoqugCOLL/08pwjol/hWhzclECsOCHFQ8dA+n5NkQpByA6yjvWz8SCaz8MM6vnhP4
         a0vUneR7xqMBCG6w/0CPfCplkS7/51rQ5dNuvpHwh4thjzrku55Maay8zeAl0guSUBiB
         NfmnEgqwff6YXwbDFc2vc90k9Szw992dnsDtwz4SbK4f5JM/2OYq4sKpygNfOz9/yvdL
         aekpgGvVAqtPT2U4Xzfs/t1WuEGMrlEJWeGscyYy0wkGIW1/BFup3XszqFUYt7PMfd9l
         o9e2UWnLS0AAZH6WEqfVzEngkO0vtlCarilatrVowVXuMgnZcT7EQ8xApVrIOKgIRmi7
         5v2A==
X-Forwarded-Encrypted: i=1; AJvYcCXaowGaYi+fWzAZ4tyoRultKwtzwJ6moDvbsId5m6fJ2b4v+pz9SLb6S8hbLnTOFyGam9k0exyDkCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNOcwO4IzOga3Kt1jagUpNsq3Dd77r2ORKnsYpeZLXnMJk49v
	0o8USeta5VdWXl7ssAM5LEzgN3zFYiNWZ7PmpcFsgk/m7DwLbPK6lH0EIKTrXCKbglSad6nXfBg
	Q3nxGZRUIMnG9FQ/IqIRG01y1iGOcQLwBuXOHM73R2br2N+rNG70OTswxBp8QnEs=
X-Gm-Gg: AZuq6aJOsWRasp+FqtAr0vX+BGAzDhadZ9HcrxC0Z+18XprbqDvTjYDJxNY2WYT3YAt
	2PVCJTYAjljRaJKLEIrWQOQJRpcTqNljviEd4hBtEP5b1a7aZ3rMofnycw6ljdbBX30m8p7zcoJ
	M3pr+5q6XfH06LMzcPFchQyiaMPln/qLPG0MIchfaz8UDX6TVDKejpeYK6VC2MV5w6vvVg1k77B
	5yW7yfbGCAPXIWWipleHvdZXiwe0vQPMlewwunI7XixJYZF33jxyFD4xaL7ELZny0rLAMWWZDrb
	z1N4IzqXklzPMO2HgOTLzJOnbNgDtfA9qjfgEnL4xMpL1N2uhonjDZ4N51wlEk6vSZJe3dVFIbD
	PguArQGaxJaSLZZzz6KRPP/5BE9yCz7z3tIronJ6rf78mtRr1tSTRqAsqgjw/sPNTABk=
X-Received: by 2002:a05:620a:46a9:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c9eb369787mr271757185a.11.1769776173129;
        Fri, 30 Jan 2026 04:29:33 -0800 (PST)
X-Received: by 2002:a05:620a:46a9:b0:8a2:568c:a88b with SMTP id af79cd13be357-8c9eb369787mr271751985a.11.1769776172555;
        Fri, 30 Jan 2026 04:29:32 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc6995sm406280566b.24.2026.01.30.04.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 04:29:31 -0800 (PST)
Message-ID: <0b628651-79ea-4ae1-8898-125beac7a2b7@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 13:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] i2c: qcom-geni: Store of_device_id data in
 driver private struct
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-12-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-12-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: k_ra0FSTY2EvTFDEYN5NOp-9Z9MUZobQ
X-Authority-Analysis: v=2.4 cv=W541lBWk c=1 sm=1 tr=0 ts=697ca42e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GxAstmoraj778iUyJ78A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: k_ra0FSTY2EvTFDEYN5NOp-9Z9MUZobQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEwMiBTYWx0ZWRfXwfT8RiFVXtZ1
 hxbZhPNheVEvqaHBiGHXcUgjoKNVPOZW3tDKbYBQ98DVlT3w/qn1J8y+sZ+k/JZ4Fob7rwgjkoC
 ONXgAAl06QWA5xqdFjXXLhii8oFaVR7ykYiLyG4oXtYaVK1yDKP1AuiNRorSZoStzqfWZAoXJzo
 vgjsPjQPlY8dZHGtpXUQEBrKp0An+T+CePskIqKr0vPY0SVdswn6qxaSqJcWn0nDLZA6ZUf7jwf
 eVsqvXqI6/Bi/Zo2OVPVlnbv2hUNvcHYFQejqC0/ysJ9mcxVa+nDp6qcttnS9AtckETKZCiIl9Z
 5AXMRv2A+uKJU8luJUscmSqgCQj6dxd9LOYLt6rnlEA2canXEo287y3ZfPVk5rfsA0fPEMkZ/uo
 H3Y3G53uKkHCViWboSEoD9bDtDUZseykK3g3mV32y/5fXSUC2m/H5N0YMoJfi6/w1zV203CpUIq
 Y+PRmBmpBlgyGbRrdtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300102

On 1/12/26 11:47 AM, Praveen Talari wrote:
> To avoid repeatedly fetching and checking platform data across various
> functions, store the struct of_device_id data directly in the i2c
> private structure. This change enhances code maintainability and reduces
> redundancy.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 32 ++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index b0a18e3d57d9..1c9356e13b97 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -77,6 +77,13 @@ enum geni_i2c_err_code {
>  #define XFER_TIMEOUT		HZ
>  #define RST_TIMEOUT		HZ
>  
> +struct geni_i2c_desc {
> +	bool has_core_clk;
> +	char *icc_ddr;

Again, this should be a NOP after patch 1, that we can drop

Konrad
