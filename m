Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF640B38A
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765141; cv=none; b=pmw7DgsWcTlVSbue4jZKqoT5pBcOSdTqTX4pAJXBPafzDleDhJGDuXEKghZxVuxbitfoZtj9rLb0O/7msIE6o8Ay8o9Dh4nfUBKHS33oX86CrHiVw5N16PsyfrtqkTaRdmb9Np4uUva89Q6XcdBdXDBlNPq9yn2ysFa78FDOrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765141; c=relaxed/simple;
	bh=yglyORkEaECpaRPtBKgDRr/qQczgVUyAlkhYS5WasBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDA2UNwerbydfvePO+3TgXhZNyt6umUOA+kQUA9LZsvgaXjNsR/5k/nrpIkgIAL5dfvnG5HAUul7hAoXIgsYVmMbX+V8iVF5B7Gap2zjBRAoGDABAnBTp+WfC+0aYTAEi0vRdTl+je/qBaSR2cX8R1gRlwyAkfTRFaZ/T95HX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TV9/TOZ3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VMUpHSXj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TV9/TOZ3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VMUpHSXj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777Kks4161148
	for <linux-i2c@vger.kernel.org>; Mon, 7 Sep 2026 07:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZM3soZ3hznMEQjXbEQyzzQP5KyN6hV8ZHITcwWZ0G/o=; b=TV9/TOZ3sHi2ht0P
	24Y5RRt6lom2GVcTRLLWn+o1XtVqpt1aRIcyxJQWnnJJozSnpjfAkVQ5VE4FhVpS
	1uxroGkAhqWFxtejijfV+ItKtwinDTuEfkxVlvrtibi5l6f+VCAbsljhpIvPSIBR
	ipnpcrSTRaxOo+n9IPYCA8cddQZeB7fLSCFM4uXF7X+WqbPPlMENVNpv3mUJBWHr
	HQHjRtN6tIaj4I6XjnuOvvM3VpXXBW2b0sytgw72dL7ZNV9vQU6FlJGTATDq/JWN
	LLZU+TGJQ7uRPkDez9MK0bCle9EsyzvlNSs+Y9ysROL3dO6ch36ungDZnXF3+jyR
	we29lA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfwjhanm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 07:12:18 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6b1a3f01d2aso4419212eaf.1
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 00:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788765137; x=1789369937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZM3soZ3hznMEQjXbEQyzzQP5KyN6hV8ZHITcwWZ0G/o=;
        b=VMUpHSXjxxgr4ATsutLHFVi+hc2+VnT94G6gCcuOUEkfgN4DSEMzbOODlVH+kcdlCs
         QqbTRQSS3fVa0WZlSqAXxFHUlExV0pBSQqq65Psy6KihKQ+KDGx2pQnf4oNLZIPfLmG/
         nRliWuRqqbko9Br3N37Vt0kxyrKYaF6vSNXKqo+RVU9cgaoRcubjuPDBhle0k+wgzG32
         1FE8nyJFm/I9q01a1/xKNAolp/0PdywWcGw+J5Sk+p2OL39b0uI7MlEbJfpZdYp0Vr9h
         e0b1YeTton5wYl75xdKZ9Fg9KfQ+th2IU//MvpYkuMwsqNLwQmR7jxXlTf+yJnAPCaAR
         hLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765137; x=1789369937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZM3soZ3hznMEQjXbEQyzzQP5KyN6hV8ZHITcwWZ0G/o=;
        b=n7sfYtoVeyv85Ynug4KLHtxChF3H0KiMUU+DfsHI8EQ960dX1mXee8KV/peNOe7Yxg
         Vn6q7hJc74SDO1MKRUFdY3pLR6ZeXOyA6qq9mt59VNfAw6HRmQij1KKxq7e3Akm/B+F4
         amh3prlp/WXX6fzJCoS58hUqU2YHJthnHgyLI4dO90uvZdgIFv0C/TXlNOLjT6r7MR/F
         kN+lBXpY9YhqVoP10qbGtAXpDm1qikt2y8Jrs7UqfBp3QHbIbH6a+yKsSZJ5YA7n0wtN
         OwTSfqer7MnqmKMwhQIQKM3cVNDBLKVhDXsRmPlxHm96tqGn3ns1OKWp55BNaVnp65mC
         PVZg==
X-Forwarded-Encrypted: i=1; AKwUvBzPwr1cwF1SxeaaSN5gnrzopk9Re47MBpRkK4IFhZw70k30f39o72K50BtkgqYMgKbiripbH6qd7UY=@vger.kernel.org
X-Gm-Message-State: AFuF++klPMQpAn7NMsJ+JFNbyRpgk5Z3duZJJIfsrrn9HVDM1qqYo0dr
	Wqm/hKb9+L8G/STpIsVijCRZYDOpA5WmcxsTXFXWIaoD50PG3DGPPAPXG8FrXPLfIjZo3wbcRf5
	bv5E6OrJ+cM0HL/KeuZlia7AXrsSe+nHwAkEYPag0w4aLxFjywX+yTIaconDJqXw=
X-Gm-Gg: AYBFou22SR+qvMdiMW+Zpddt783WfaVQqcAoA0i8+iI5uChJenIQm0KU4ckqkAthbyn
	p+C5s3ukhGzEVx85ftowXS4ZDEfFrcKN7p/IPuS53RNuz5Pm8kjltzR9H/SjpLH+9FZy2YkLWw3
	zktC8+jWyvjVbyw57sNSVizHKEiyq8GeYRn8zIbJ196MJXGhj+q2gsb2Z5OebZ1Qq1qKBgs3o4n
	4hk8aNXRBeH9rnvweo225zcnX7ILtR+QdMymdOF1NJRpMcUk7Scfs07BZyKtO+0qAKyAdJ6324E
	CcvX1QysdyVChLI252OxIDXGmNrT/zWNPCeYQWVq2j6IGLCyX+/K/n2JI9LiQrqDEtEGfqk0Ldc
	1pluA6JcdcdpFrJ0B13+tiT1Ay1Gixn6CVQ==
X-Received: by 2002:a05:6820:2017:b0:6b7:46fc:1d7 with SMTP id 006d021491bc7-6b746fc0274mr12032597eaf.54.1788765137516;
        Mon, 07 Sep 2026 00:12:17 -0700 (PDT)
X-Received: by 2002:a05:6820:2017:b0:6b7:46fc:1d7 with SMTP id 006d021491bc7-6b746fc0274mr12032573eaf.54.1788765137088;
        Mon, 07 Sep 2026 00:12:17 -0700 (PDT)
Received: from [10.217.219.15] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1433171a97esm20894869c88.12.2026.09.07.00.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 00:12:16 -0700 (PDT)
Message-ID: <22988ce3-280b-4ab3-acfd-921e64e137ea@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 12:42:12 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] i2c: Add dynamic transfer timeout based on message
 length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3NSBTYWx0ZWRfX8RRjCgUARjOE
 Q97Q3tc/BSv13Y9/D/0C7wRuVhNyPMysU3puAYDtBXsQnvYExzFDgkzdlnww74KDDkXlY1n0yg9
 0ui7X0ycqA64kH4INUv8M3uBfSedV/o=
X-Authority-Analysis: v=2.4 cv=NanWEWD4 c=1 sm=1 tr=0 ts=6a9e63d2 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=JvO64EORAAAA:8 a=T5o-j7h658XeM3NHuZQA:9
 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=Qz6KxWHdQ2_aS5WpiCfK:22
X-Proofpoint-GUID: CL2RvDgcaXkZTNBLLGQvrIpOVkb3A8H5
X-Proofpoint-ORIG-GUID: CL2RvDgcaXkZTNBLLGQvrIpOVkb3A8H5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3NSBTYWx0ZWRfX3WosqilCfapO
 sUnzXCjs0zred0gFOJQcu8FU2bACE0wwDMb3SSfr7Wxs1AUBTLuMhx4vemGi0GhYbh+Rh5NS0P3
 A2n4SsxUs+MWIX816yGseBT4K0u5QAfac0D9SOz0KzPBsCm/a03Eq0OIS0Q/d/aB39T+Kjt7ocZ
 O2kwCw7zV83HbPaCNRQpVOqjra47T2Vg+VOG6WGlS4gOkezFNu1pRy+pQ7RXl61YswqiedriA6H
 6qIQ9J6KXDJT/oeg6K9K3zPCCoSlpNqsV3QjCpngh7BmiYGlCNI1YjceQjOdKPkfakACGhmSyWX
 C4cmfVyRavIuSS+Jxn0XtQ/UUj9JQ9B2j/FQGJH8nk73Ljbbc/oxj7DKfNBFMb1jwqmCFaOpiTn
 rLHkzo+OPDk7pNQn8vRiuNk3uV188zyL9kIn5thUXaBEuGq/ld1gFBzw7DngD0DKBdVIZsxQw7p
 gNO9LeRexypKZgSQ3DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070075



On 8/27/2026 5:57 PM, Aniket Randive wrote:
> The I2C core and many controller drivers currently rely on a fixed
> timeout value that does not account for transfer characteristics such as
> message length or bus frequency. This can make the timeout unnecessarily
> large for short transfers, while longer transfers at lower bus
> frequencies may require a timeout that better matches the expected
> transfer duration.
> 
> Introduce a generic helper API in the I2C core to calculate a
> transfer-specific timeout from the expected wire time of a transaction.
> Store the computed value in adap->timeout so that both the I2C core retry
> logic and controller drivers use a timeout value that reflects the
> current transfer.
> 
> Keep timeout policy decisions within individual controller drivers. Let
> drivers provide their own safety margins and minimum timeout floors, and
> avoid exposing those driver-specific policy values as part of the
> generic API.
> 
> Convert the Qualcomm GENI I2C driver to use the helper while preserving
> its existing timeout policy. Preserve the static timeout behaviour when
> CONFIG_I2C_DYNAMIC_TIMEOUT is disabled, and let a userspace-configured
> I2C_TIMEOUT value take precedence over the computed timeout.
> 
> Suggested-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
> 

Keep demarcation here ---

> Changes in v8:
> - Compute GPI multi-descriptor timeout using the total length of all
>    messages in the batch, since completion is reported only after the
>    entire batch finishes.
> - Guard against zero bus frequency in i2c_update_timeout() with
>    WARN_ON_ONCE() and retain the existing timeout as a safe fallback.
> - Link to v7: https://patch.msgid.link/20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com
> 
[...]
