Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C63C13EF
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578519; cv=none; b=Hsg5gDond5XcG/mgLKTga7LomWi9NHHD+Ey3cVtApGEXPcirAhckfhr8RkAXpr2pA02Ai8WC4dLiVN83rRjR8k5kGz7/r+NLoWrxXAzmi/ejQ3fy745ljQr6J6gOPLnknHh6wYvy0AjF6mCb5J56/ekrB2Fqfp/5aq/f2iKq6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578519; c=relaxed/simple;
	bh=+0CEjRtd8bo9SHhAj4g/+Z0J7Evd2+QTcAvW77dM0AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p41qRskctY5P/oZ/SE3JTjELt2q8cpyPBigmkV1/97xrsuL7aNCc8KCHHBxmzwY1u8j0MxZaaNgYGU/lMxjjHY+iiXVyPljQNOaPpjZVRMz6r6Gu1DQ4zQ5cyNZKjYGjxwtJHWuG9mmlmRjTU4nAut7vw2UZhVeBYxNnNjMqFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iuGkr4Jb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E+IWx6Z/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iuGkr4Jb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+IWx6Z/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960QaT784681
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 06:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P6rkqMfXLK638vUXHiaFMs9sT739rEtUIMeGGDeaRaw=; b=iuGkr4JbT9ADw3uA
	mXUmcOFWX7uDjojELZtVMUO/2WVsuu82pzhw3sTMP59spjvrcKITavLMQ/+vFzUx
	iMKsNPhdUREk3Hi9w8tbS22d9T2NTteWo3xXTRQBLn7pnHVTlffOnWnBmKm7rQ37
	HU5Binf8tdkKyTdEqzUed+9e+h2kyeTK7fWrevbIp0BCKulC1EDXIi63e7UuwzsB
	2UIx7wJ1DButXX6eTtfmaPbO+YvTjS3eHYE9UZbwO+y06mIHjPRE0QZq2ze5CSkq
	sgY8ZOLVKRj6lUUNKJ51RDQM5+k+DLPCY2YJ0V/fNAIOJ0k5wi5ZoloNMyqae+zV
	CTgzaw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u26ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 06:28:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so667407b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 23:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578514; x=1784183314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6rkqMfXLK638vUXHiaFMs9sT739rEtUIMeGGDeaRaw=;
        b=E+IWx6Z/T4gR+TFNyeMn67qfy06F6JMNDJ3W9Hpl8NKOZF/sZtZ9IuDMj1Ld60HfoG
         L1vY5SEfDQ/dIFXyGFboz8fXODSA0gZYmdm7CjDs0l7oSTdRQxYyPvYqDACQgpypSXIF
         aEOCZxq2d8FZKr/uppynVidj47EdjOcVRvWDgB2SOnLXL4jUPicXNSR46T7Z+N2luf4f
         2xNkYDWc1y4gAeRaxiMKrs/cwy4Hg2R1xUalMI6U64NMZCc5QjoOSt/86lRIlxeFsA8u
         xWrYpMdETSXkVXQp8ORvPVsFZdNCT7dRtfNhE+4gkV7++IMCP9APi+ZZaE0pD3MKkcJP
         bTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578514; x=1784183314;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6rkqMfXLK638vUXHiaFMs9sT739rEtUIMeGGDeaRaw=;
        b=ouo8R+MZqsZj/7f+3IpiFq3Fy6D4LHhJSvZiMl9R4LSahXXBns+yvTleCYvsYRmeZh
         lX2rcQsJ8G+SHQt6HX/nyyzx/JSLyh9tC6qlqUfPvutVXmD9iRaRsRghHOB43d04nyik
         YnxdzNVL9cqPgxanDlAbIU/LtZ3BdDnvmwLr5Leek7/gR+rNQQJ6MXDJijxKz1qb7dEc
         sIapDC62+ncA0D8dE5WGbNRH6LUuxEvHH44z8aKX2kFmfgZJMrBGrfTTdJh8Hh9fHH8j
         2I3lTrrLkKCm469X4nZy12oEusTo1yY7orokkHtpnnuUwsWDxMijG5O1CTelBl33Oqrw
         93JQ==
X-Gm-Message-State: AOJu0YxtW4Z6WQ1DkcXmEBpNLlxcp5h2sMVrVCMbl99j1kKHluqqcXzQ
	sl8wegLYNb4+EUDeFfse/BWYIfhVwZ+T1ol2/ttEr3C8Oil+YP7C/wXHqiXyH13yysyC9yG6d/7
	xWOcT1O2RPRo8v4X13tUdzeSsGm7BlZSFBP2Irj4Jo6f+5h0lQfH/n5MJCC3Fd0w=
X-Gm-Gg: AfdE7ck7TDgnPTw84UkGjDg0Mor79nTQSc+0QRd3Yxbu9nYgNdVKXhZ+aSlQH0mzqD1
	fCy6rQHadTwwBXn3cwFE1YzCDGXQusH3oAd9t4+PeFW8aMCiXN7jstxQjbb+SZW9CBJaJgUucct
	VZi8p1nSGffcrkR9yWjChggi2Q8uxf3kMdEENcIKI7B57YSVo3LSvaXeB+SZzJS51TQrVIHGwa9
	VWVZzcw73uBlFncHSLS4O49S3axK4Jab4w+pAPqY++68JPwIooWwiYaYV5fgKupEELWQgU5aJ+t
	BS/R+/gETVX5qWrAwmACuZiKOd5mNwFGj6kzZUSjpkBpDFrg8LULXT2JNk+eXL+56dKpswnsQ2I
	Day2uY63DhFyMBZRXQp3EOhEL3PDjr8DaIz0GjRC1dPNJDHZUiw==
X-Received: by 2002:a05:6a00:cd6:b0:848:30c3:45d6 with SMTP id d2e1a72fcca58-84842ef886amr5946289b3a.14.1783578514265;
        Wed, 08 Jul 2026 23:28:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:cd6:b0:848:30c3:45d6 with SMTP id d2e1a72fcca58-84842ef886amr5946271b3a.14.1783578513823;
        Wed, 08 Jul 2026 23:28:33 -0700 (PDT)
Received: from [192.168.31.103] ([152.58.31.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9a832sm8089294b3a.18.2026.07.08.23.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 23:28:33 -0700 (PDT)
Message-ID: <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 11:58:27 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfX0RL9Oukd98pL
 C/oDGZA0PQ2WHxwZBxCkSXvnnQ9e5XwImWHA10b5DuKEYmub0zW720KkcWYRcmheebnn4vqG67X
 Lvq2LfLUZsr3Niap7i6z2KBPT040pEs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfXyy1xEcJg/54Z
 9LvgzXAH4q7Jtq1PiUEISNhum/SdZbVd9WBfWfGaCI2zBXX/QaZviQ/XYDHTg1CQy1x0BHNQn8A
 oQcC73GKaSr+fpftL9hqZUZ62+XRzKd3vLl0zfD0oCXMTKah6Bk0FkApm7o6wqGC1kTLg8cR9f0
 4rklFDCuYPqbncKgP/u/i++aO4hF6f9Xv+HyBQ2EzaK3emRBGgTaFyRVIkVOngyDO0Kn1KWjxm8
 1RZiil/V5sR6A0evuroXCVjENVQT9pDtxAPA2VNgQKO27kkTJOcMBnmn3Szs7twhgcw5hlYIwtY
 8z+u77LikR0Etx6uGv1goOJgqAQVI7Dxp6fwd4qjGXcorMf1H+Ponpmajic/h8BL0CPxXzR/y+B
 mx/62XDVnEwxjSfzBtvKaamM/fR1xZhmvAUL/5DzsC1WGe71+h5Mvt2SnhsvdK/OXMrbELP1dfT
 NeW/Ky9NMOGoAjXDSDA==
X-Proofpoint-GUID: N3QlFPE0bsMtiQxo-fTCTn1ytMORGms2
X-Proofpoint-ORIG-GUID: N3QlFPE0bsMtiQxo-fTCTn1ytMORGms2
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f3f93 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9AXozQ6IwN0d4JI31gUtBA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5GfgTEDUgWdp11RPFvgA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090059

Thanks Konrad for the review.

Sorry, I missed your comments on the v2 patch and ended up posting v3. 
I'm happy to post a v4 incorporating your feedback once the discussion 
concludes.

On 7/6/2026 5:11 PM, Konrad Dybcio wrote:
> On 7/5/26 3:57 PM, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time and a 300ms
>> floor. For GPI multi-descriptor transfers, use the maximum message
>> length across all queued messages as the per-completion timeout.
> 
> What's the reason for a 0.3 s floor?

The floor accounts for I2C clock stretching. The spec allows slaves to 
hold SCL low indefinitely during internal processing. A dynamically 
computed xfer time alone gives no time for that.
300ms value covers worst-case stretching while still detecting real 
hangs 3x faster than the old 1s static timeout.

Thanks,
Aniket

> 
> Why a 10x safety margin specifically?
> 
> [...]

The multiplier covers the gap between theoretical xfer time and actual 
completion time (DMA descriptor setup, interrupt latency, and scheduling 
jitter on a loaded system)
Without it, short transfers would have almost no extra time before a 
spurious timeout.

Thanks,
Aniket

> 
>> +static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
>> +{
>> +	size_t bit_cnt = len * 9;
>> +	size_t bit_usec = (bit_cnt * USEC_PER_SEC) / gi2c->clk_freq_out;
> 
> mult_frac()
> 
> Konrad

Good catch. I'll switch the calculation to mult_frac() as suggested in 
the next v4 patch.

Thanks,
Aniket
