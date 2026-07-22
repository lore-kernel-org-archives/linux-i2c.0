Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB12F4A05
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700411; cv=none; b=WFrdlTSlqcomM+pLdjMa50FlliatMGS0BGjWfOTJiKf+F8nCVzdRJic0SWjEuni38bF8L6cETCPKSuoH4QviN5nrdA3Gvn4bYFgM1b2WiJpeSX+qc1I79VpZMRGfG+z9B7jj8E3vrh47KmG4nL01T9vKfHqkYja7NvGfQm8zuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700411; c=relaxed/simple;
	bh=6AuOefY2WqeCgrJVgaDp9WOmbY0uDwx2zv6qPn4zFyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cztS7naJnhy1oyCrfoFCkq2nKICUJw1+q0yfgKyb66dCcWeb5pT5a5VqxYoWkBDBKjsCv2B6gWrLbAD1l686ayufKrayhsqcUT4i/5K+AJrbRqRo9IXoHiZkjf0/wPyGvXtcrifVsa67AWNHWeeEEZG43iMbne7hEvtXQQs7Kgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yop6PaeR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LD1KyFts; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yop6PaeR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LD1KyFts"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53hcv4168716
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 06:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zgUm8fE1uQJktgJk1o0IZjrYE3Gp1zhF5sfAYRNnsL0=; b=Yop6PaeRWYfUBvWa
	lnAvukiJbDSjPSYTljAzGTp7XPT1XAt6mOcQpNwuZki2KqlnM73zrrAjMi3HTW/b
	0RFcPPgHtTYaf+fwCOuKyf3jRHhFampnPywOrz1Bzmp1WcQFqn5f+6nUKa7yrxrV
	/HZFXer7l0Yh8RSbBou+wBeNa+Xo1F4ThSaP3e1IFkeHY9EwF0x5lXAaUADru/57
	ASMfnpjhhI3tz5eKhvcfuRMxpcTkO+9Ouaw/9UYDQq4xpCjwAlhlmciMYvXRLBGQ
	phkYoxSebJAmtyaQylDOjpPPDfAnEmq64fBRd1kRWxfv7DjAsd7/+y/NEzyeVfU8
	xNgC6g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3mk1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 06:06:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso150678165ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784700409; x=1785305209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zgUm8fE1uQJktgJk1o0IZjrYE3Gp1zhF5sfAYRNnsL0=;
        b=LD1KyFtsejsa+BMdVqCOh7iBBfZ7Ul6PVH5tXMJ8JrS0CF1x3yV9IW2x9DfkbJSHgA
         S7Sdk1ouxt3pC2Hb5NTRIB2Q6JRnpNGPcpUtamROdB9ixeU6ePCIjGa98pThMo6rh+dV
         YFrGzX+MryFDKKOcFUPzWc9Za3viDGp/E06OUM1aPrVe717QRJBiRZ6DEeE9l6X1XroE
         0M9L1HV36ORQhz/rnPIHHJrIXRBtGrNDtzqLdgv77I0OHk7vHGxy3MAhauUS1irBN9gY
         e19gdVm9IzIfNOAAUUtcezLBTMpJvFhL38cY1/Puxlk4qKBV0GV+3b03MIZUX4cDtw0O
         6xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784700409; x=1785305209;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zgUm8fE1uQJktgJk1o0IZjrYE3Gp1zhF5sfAYRNnsL0=;
        b=IrlZtdrVuqQsYF9p2Ro1vzIPCRCHGXIHXkkyYWqiAV3GbTslAAzMg2IRl5wf5Aa6yd
         sSo49i9Isty/mYX1vs0g2bs3f25pwpbKo8u6LUIDd6Pk5EXUOXZnrhupRO41yhznWvfV
         Ub0dXlVqsHRzxYA5lPomE21dzWSzt4UyS4bBILTzdOfj8vpns7ccDC2Xd89sMfY+QT05
         Eruapqot6txqGMju/bOe+sz88Vp8LjwsKZm57Bgl+5hwWTJhQ5hgFj4f37Vl+4xqgHa7
         kANpl4xbngjbJBs3tR+FABfKFEXLkqqyQ/zo8l/e1oZc1CqO4m4O7h8siRmD9z+YVvdx
         PKjA==
X-Gm-Message-State: AOJu0YwyzLBpH7jeI21p3e0CO+INNdaXrnkqX/vDHBF16BpYhqQxeExs
	6njjoeBXksvnLno9UCMTGWsD95CMwvVnAN+Y+sHCao9KFiRvyZ9GI5uqX2aeDHGH1w5gW2gGe1J
	CFvnQSB2qoeUAFySZ2uMRP+ZqF9ZxP/FOltXX8FPcI4iCucyIxym3tvyIX6bMZRE=
X-Gm-Gg: AR+sD11Ur3dySEITYDrL2k/gN5Wk+Jw0TdKB+n+DaDkXYAT1BJhZkSjk8ibM9u011/f
	ZgI6OXrC1dHuPiLGEZQ2lVZGOCOK9uqZbv52iGbHhrDF0gDI1ocHZHwgMpoLHe23rLAPBvQBYzM
	g15/K4jwI9drvPb2A60aNXsq8wh3UnQFY75fDM/Q+CAqe1mpB2jhQCybedQPa9dGrRkHcYqKDX5
	0mv61vZBshceeKUMt6dH7o4etKeXdjIoov/svsHu+wl70zjrTgPB8/fOb+RpWxZnirVUb7DLADB
	AGUFTtdPn8JuwbhNIhMOBkymVvpsePNOIW57WPR5TBOplaGlCO/JMZjqizpgYK3P/puA3ThufkS
	u5uuz8WCDn/Pfsn+pRwndqw2mnvjGLDN00wU=
X-Received: by 2002:a05:6a21:9206:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c3ad808bc9mr22488903637.34.1784700408602;
        Tue, 21 Jul 2026 23:06:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:9206:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c3ad808bc9mr22488881637.34.1784700408146;
        Tue, 21 Jul 2026 23:06:48 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1c4c3asm576384a12.31.2026.07.21.23.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 23:06:45 -0700 (PDT)
Message-ID: <67436ff9-e440-404a-a52f-e5b238256152@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 11:36:41 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vasantha Likitha T <vasanthalikitha.tandra@amd.com>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
        Aniket Randive <quic_arandive@quicinc.com>
Cc: linux-i2c@vger.kernel.org, jdelvare@suse.de, git@amd.com
References: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
 <al6c2VXwLFcNRLu7@shikoro>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <al6c2VXwLFcNRLu7@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX3TItAbqS0pIR
 cae6r+Op7P2RWDmAYe1yLPTCQOC3t/a2q3EvTvYeIbUQJM7qNNKJuzB/9aDoMgtdtR1BWRhlRGP
 u9ZIYEic0WM+akufXJrpdEPZrR3635XnD99Id3TB6HlHm2EsYIoqGcdgTP+iiie+RHJvnddaBW+
 vvmvphgFegTHFTJmn+BvulzIT85lEVmitFH/PN2iFt5j3qjORUOvEBhJSt97VjA5+Mh8i37Cw91
 EwwMDXA32OvHqeO9m5XrwlTlGwSqaJLQ7xzMlVq7VLPEm+kgb/wDnoeA8SWMy/uWlh4slPQvEyW
 TrB/tG3x44RvYn8wp/6LQUXSRZhrpI9uf3aUPlibcHOUJpMpF4aWGubPDjxtNTp3616lUFeccaf
 sXLw7Oa8nkrm8orPL3Ub07p/wPISzc1JukmCEAUrv0B2snZeUYovBkuiWT4VLAuJZTE0LXKPwvn
 QDbAJQq0YuO99tjN1gQ==
X-Proofpoint-ORIG-GUID: BuX3UkxyVR87gW6d5j5uYzz3dYrJ97Jw
X-Proofpoint-GUID: BuX3UkxyVR87gW6d5j5uYzz3dYrJ97Jw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX3S87ehnWISEm
 5q0BJPOXrXYeeCnNB7fcAfyd4lURqOtTLR3Hpga4UYva747Z2n7wFP/GTI7hQawBGKnyOsZJ4KA
 E0/JDluJtqHr0fnlxOCX2n13jujIehY=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a605df9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Uipuo8TcvNLK4lH2BHkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220054



On 7/21/2026 3:40 AM, Wolfram Sang wrote:
> Hi,
> 
> thank you for this patch!
> 
> On Mon, Jul 20, 2026 at 10:04:01PM +0530, Vasantha Likitha T wrote:
>> Add a -t TIMEOUT option that calls ioctl(I2C_TIMEOUT) before the
>> I2C_RDWR transfer. This allows the adapter timeout to be set from
>> user space at runtime, controlling how long the I2C core waits for
Why userspace need to decide and set the timeout values for adapter ?
Adapter knows the transfer frequency and transfer data length, it can be 
calculated by core layer itself and can set.

Retrials can be fixed and hard coded for everyone.

Is there any other purpose which is missing with the core layer deciding 
timeout ?

Review here @ 
https://lore.kernel.org/all/20260715101805.3615166-1-aniket.randive@oss.qualcomm.com/ 
discussion ongoing to add timeout by i2c-core-base.c

>> a transfer to complete before returning an error. Drivers that rely
>> on the adapter timeout will use the value set by this ioctl.
>>
>> The timeout value is specified in units of 10 ms, as this is the unit
>> the Linux kernel expects for the I2C_TIMEOUT ioctl: i2c-dev converts it
>> with adapter->timeout = msecs_to_jiffies(arg * 10). Omitting -t leaves
>> the driver default unchanged.
> 
> I agree that reading/setting TIMEOUT is missing in i2c-tools (same with
> RETRIES) and it would be nice to have.
> 
> I don't think 'i2ctransfer' is the right place for it, though. One might
> also want a different timeout with 'i2cget' or so.
> 
> My suggestion is to add it to 'i2cdetect'. It already has '-F' to list
> the features of an adapter. We could add '-T' to read the timeout value
> and '-R' to read the retries value. If '-T' or '-R' parameters also
> contain a value, then this value will be written to the adapter.
> 
> Was this undestandable? Do you agree?
> 
> Another option would be to write a dedicated tool ('i2cconfig'?) for
> handling extra parameters, but it feels a bit bloated IMHO.
> 
> Opinions?
> 
> All the best,
> 
>     Wolfram
> 

