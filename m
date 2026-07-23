Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFB3E6397
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784791183; cv=none; b=dSEBYQeRfseQU0HPhR9SLC/1TJrCaLkpP4vV5ZMKzOJSjS8rawgqH5fJYYRLrWOTkZUQT7FWHg0PgdYfu2R9MOpOaSB472Oyn+kPscjbPfh5OwbZuLgn/U0MjQslkmd300A3PaDgx+669B5ro2QrbhxlJ+sWHY/S0JLmVNS9s2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784791183; c=relaxed/simple;
	bh=QisqLjDrbmjc3FZJh8QVw3zcsbOVQprmxITKzetHb0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ew8fRWUpFbvgwlU39AqkWdB5dfE5ZmM3t9osLotwJDyrlB06nhh4Da3pQj2S+JpNfFfDZ1j1anCjyXzldLfckOEZsOz/Eg0afbGAm/vdh2Qhh3pO/B1cBwMEXBaw4W3Uq1PUw48gigF3APRrc2Qp1nUIn+XLGaVR+bhVV95o/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdW+Z7/6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DINZ06nC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdW+Z7/6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DINZ06nC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N7Bc4E3416135
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 07:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	choFG8nmMcADyTy44/QaQNQOg3pHYiOQMljmBN7kaj0=; b=QdW+Z7/66wZ0vnEh
	7QRk8Qw0SmRTW8bGOTIitVu3GlFasRloV5wEml4hOsJAwAshK7eWCcVyME3+bXjY
	eNlgiVI6vgtGExXFdb95uvmYPVoAzVf6efBgKvhuy5MUpeIXANccVYgQeJr76WLw
	Diu9FFlOWYDE94I4dJDfsfZ4zX4vrrqDS91ovEB0Put1n2sjN4CHJLZ6nnKu25iH
	s+8B52yk7NTOtCGtl7gyp3KLkIHhs5sLitZVBbhvI6kIwmKwPOUtq8L+6i6zjB49
	gB0rM4bL2TQnRrOqiHasocRquL/PfW1CDuFGXFzexr6LNkPdMAIF2JjQO/oChcAc
	7c2qzQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk6c7hs14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 07:19:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so920844a91.0
        for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784791173; x=1785395973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=choFG8nmMcADyTy44/QaQNQOg3pHYiOQMljmBN7kaj0=;
        b=DINZ06nCv07zl7LNvJWrex+wNbZW51iAXBHOilbkH/88wTIOE1QZGSgCXHw0scY1Tr
         m0+0+gVxjccD4wRh9sAMx24Xiseqdol/ZksyRO5WC7rDiKD4LPM6REpDp39kM0PyJJMh
         cM9aCK2Kct/deeAO/7x8HNMxCNvM2JOINhX1d/n8Yups4E4iniVL/OXPzGtNS8EyJxMj
         j/ZKGiv9A8g9XY6KZAw4EMcqV8FeNB7HqeDY15M0IdseUzehsJoeSi+zuFfQ72E7RTNa
         MWSA6e59Deb+EkH0FjNp28/+TBYTSebRnS7Ni6KIDNyoTJ9WtAzWWnIxsJ4iuaXK8/fJ
         U4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784791173; x=1785395973;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=choFG8nmMcADyTy44/QaQNQOg3pHYiOQMljmBN7kaj0=;
        b=izLhfniG/iWJqQZXi0izUKR2ZEGx2m0FNBOsCCNwkeS34Gy6dL3mjdF7LkK/U1ortW
         dSobr9PVRYQ6PpkgVQy0d1aEBQKVXx5q0JngGDN2lSAoy1s8eRqtTzir3b7IWKTHiPE7
         Lf1F0V1wbmM6g5fbYrtqIEgYrQ7JDBX3MWUAmysp+4lDqS2RPJ8nqo5Tmd24GyA0mHLu
         /Zr8K6+QBz1YXaSk/5voyQrBzeP87HDZTVjO/KQF0+xUcPymt+XPh8LLXmEWM23M7v7q
         SNBLaxNTktYCPa2KhfB99/IL8Zc4qiwzCWI5l+jDyUObONz4QakzRuVeKslABf6XB8/7
         atRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rph2JUwGVbFE5xe3Yrx6bzFwvIviGwxGBo5SQbPk9gzSAgqqlhmnGbmFcj/BOtBfdkbpC/xD+JAfMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8oF/jYfyKYxApsru4nCBuRhDK4R0NE1TElIIQAKwin/JCNrxl
	8aZPiWMEcT0FrghO3UZXmtsKP5tqzpAPYCHLWxeaH7UhOZQAWqkQ9YCeLG47U+VX+FtYbWPH6XC
	AyNgifg4XocFTFaDzbUVpKSPePo8xUqK5i8zJAbStFKc8yQ0U73J2y/cdHLAFM5o=
X-Gm-Gg: AR+sD11nkTJAmTXYP/8XPvJOMt9JGRyrwbyCuZPuvWs9YHiwjVi1ulhmamS067iJa54
	V2LkyrgiDbgUzaYJsCUpiaspeT+GYyhUh4PT9R6iE7KTbamfMOomnTMvYGI5jpgtfSBG0zNWcmm
	vbwGpAtGFnV04Zz2t1/taYOgV4lOGkYe94lbFm75CdJ3pOPUkjjdi01K0fzAGl87IpjGGNyy7dB
	zkd48G3JU8VSLLOqfiR4k4PmFcwg/MLEJ3rVYK2HkWsziK8QHQYxA/dkQ9SHxVwaJOUAxHZ/8Lv
	A7r+MDOqH9MibksA7lWN235F5uEddOTVUFmfxTCBLR8VyTgKA5LeH0tTrK4CTNJohBCRn5Iw4Cg
	9HkpMDVkDecokszeGsrk+JfiKygYlveJDOnU=
X-Received: by 2002:a17:90a:c107:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38ec68b05demr1887936a91.40.1784791172614;
        Thu, 23 Jul 2026 00:19:32 -0700 (PDT)
X-Received: by 2002:a17:90a:c107:b0:387:e0db:3faf with SMTP id 98e67ed59e1d1-38ec68b05demr1887918a91.40.1784791172236;
        Thu, 23 Jul 2026 00:19:32 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ecaf6bf22sm506209a91.16.2026.07.23.00.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 00:19:31 -0700 (PDT)
Message-ID: <15242aef-0fba-4a21-a46a-0bec55000f1d@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 12:49:27 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Vasantha Likitha T <vasanthalikitha.tandra@amd.com>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
        Aniket Randive <quic_arandive@quicinc.com>, linux-i2c@vger.kernel.org,
        jdelvare@suse.de, git@amd.com
References: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
 <al6c2VXwLFcNRLu7@shikoro>
 <67436ff9-e440-404a-a52f-e5b238256152@oss.qualcomm.com>
 <amB3qFSwbeDZ5l7Q@shikoro>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <amB3qFSwbeDZ5l7Q@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QvHqpTtZTWm-6OzBw3rEvTbKVxyKAmxh
X-Proofpoint-ORIG-GUID: QvHqpTtZTWm-6OzBw3rEvTbKVxyKAmxh
X-Authority-Analysis: v=2.4 cv=baZbluPB c=1 sm=1 tr=0 ts=6a61c085 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ZBZGeUPNglwUcOJVBb4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA3MiBTYWx0ZWRfX547jy2giguRC
 SGOA/Zo7KrNksX0GAg9KwiNK9y154+HKpnttpp52OU0FA8gXMbrUIR/yGyDGxeCe9OxYocXtIX1
 0zfHp8v7A3uwSon8JM9M1Kb5vaOB2rQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA3MiBTYWx0ZWRfX6n6Tryk/Eeb/
 fswsAzh5qwwOomQtwI4bUwW8rq0J4hluHsTHwYWS511n0dF+jHARRxAU5aHIPqn4TGvzyUJwsgl
 Co3tiij08JalXieSOUTjf1Ig3bUACxHeLmDzfqCU3T3EvyC2u2Nf9EbJrOBsqqLqFsAhzVzgURc
 HvtQHVlW13RAEgqI+o13fRBMcgC18wBVXzf7BeX47LqP825rjg+Q5YXdN1BamJPHZH45kfNFwg2
 WmTcdHq5oanZQh27QYHhexhZyeLnZct7ENmrdKhml9YuKyyDXOXmk9SVOlbH/5f8jV/PugyIeCG
 RR4frdtx3m+/CgygXqTh5j0CwP+7whIgDVs/eBCJ09BDXkvSP7jz+Q+Ka77ThjOTBGgTpPRmUdb
 0SoB0qSP6sHAS+dpS6V3ovsldAnxrdsREJklQbMN1DcPPFoeoI6hga5UHyLUBVCFaA0ufqyH1Nv
 7kHy+wxgVV3u+iLB17g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230072

Thanks Wolfram !

On 7/22/2026 1:26 PM, Wolfram Sang wrote:
> 
>> Why userspace need to decide and set the timeout values for adapter ?
>> Adapter knows the transfer frequency and transfer data length, it can be
>> calculated by core layer itself and can set.
> 
> Freq and data length are not enough for timeout calculation. It is also
> board specific (e.g. capacitance) and environment specific (surrounding
> noise). It can be argued to modify it from userspace. Unclear how much
> that is used in practice, though.

For board specific, i suggest to keep offset or co-efficient which can 
be read from DTSI. Passing from userspace would like just trial and errors.

if the framework (i2c core) manage this then kernel space and user space 
both can be taken cared, right ? And as i mentioned, it also takes care 
of misc board parameters with cushion parameters.

> 
>> Retrials can be fixed and hard coded for everyone.
> 
> I don't think we can remove the interface because of the "don't break
> userspace" rule.
> 

I am thinking timeout handling should be fixed within the kernel 
framework regardless of any userspace configuration. If a userspace knob 
is still needed, it should only serve as an optional override for cases 
where the kernel-side logic proves insufficient. Once the timeout 
calculation and retry behavior are handled correctly in-kernel, the 
userspace interface becomes largely redundant and may eventually be 
considered obsolete. No need to remove existing one.
