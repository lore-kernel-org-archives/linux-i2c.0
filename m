Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400D457E71
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990450; cv=none; b=e0vkX2xUipKHsUsprq+cLRqxEZy5JuvN1tROs9AIBwgGBhfr9McitWaqSdyOlpMfR1Wgn3MzaKusbYQMjhra0gFwwcXt2p1f3361J9x3XrALvFnqp2Xo+IiePrLLhmGnJlYeIFojMhds/TOVdGFTEMx+bvM9PpFFOY/qAQl67Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990450; c=relaxed/simple;
	bh=rhyik7ozJLF/QxQjmQQs4UQBfumoUTwGzzLHwdymBb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eYZKObVs/sqWH2QRqR/as/Nu2h9uw5s5YwrmGtBJQqz8CKxrta3e+/fnEYQAlH0LUET8Y/67AzjW2BLeGS1LnxdB5BoSfY8ogUZ57DnLu0XxVtc4VyBLmJQWJ3otmikFP62xCfF/aP4v1NyniyMnZdFs9DCeGTgV7PM9Q/aPBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QAXvOqag; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fqC5XCtg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QAXvOqag";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fqC5XCtg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdiHv227709
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 11:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RPLVkzLU2SuROynD8TUPuOv/tuzIzLuttIBJIsnEFG8=; b=QAXvOqagnGQh68q9
	W0r+t+uE5oZTaAiX8wcbDPKrllhUEqVQ8RPgaVsHN8FBBqhCq8aelA9SPyQcg2FR
	LXLnEdDJKgMd6Q/28zslS93stIaW5MRQLXSwRCPLJGFZqZht9to3eFnV4o12txNC
	b0H1eZVOTM2hUrMlavyPVuIQkwF3D24TQXNMfgEMIWljeFkwNlNDbIB8+nH2gk7p
	VkJ61KhF4c3zBP3y+Yjuw7hi9bpDDAvlbzzWsBMNwnI81LkgTHZFrVO97CO499iM
	+p8jFBOlShdP6ITtXGtHql7IPITsj0C4iwnR+X/zOniUd4ocYMWHex2bCXH7/7YO
	zquZxw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17grpxw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 11:34:07 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7d204b40aso71425e0c.1
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789990446; x=1790595246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPLVkzLU2SuROynD8TUPuOv/tuzIzLuttIBJIsnEFG8=;
        b=fqC5XCtgFQ4lDmpI27YcAuRvXIg+IANmSqNhMCOOgSqUyZ/Ng5xA1bxDJdJyO3B2Ig
         Krvk2X6jBtYyHFECI9lPu0dfS9Wy6E1GBsdoAnqPId6Lw+huAyqnCEsC7de4gl76wtKZ
         k3vnSFF1zjfZLXeLAjiGqLEVd0cqZikekorqTusCvtqVGKQBhx9IJnB6uIivIC2G9Ccl
         yZlRqalh1k7QF6irWSEEGiltFLod1BptYRK4XBWfENw7fGwsCEtrOThZsCLT5nhzqfg/
         i1l6/2Gpi+dRt6bRpCrCMVnTHOiMARKFTih90bp7UM8rBvPkvx4YUmy8PtNKNdEUhlAF
         +3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990446; x=1790595246;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPLVkzLU2SuROynD8TUPuOv/tuzIzLuttIBJIsnEFG8=;
        b=taLrHSqYJ0ZQnZFEKMc21TxgKom49qCpyre1nhescuG4RXyJoQ8ZeHppe4aL0huM9q
         iBMtCEdfs+kHGvU7rIXYjY96gD7Xj46cwYXXgQ+e/WlS4LrKOQOTzDoy/gdl3yV3f5Z8
         sTWBQ9mK0yxbAeyWz4tcWrOu/5LJRmCONrt1zbEXOnkfCc4aobVW12HWc7de21VuB1xL
         Y3BDSWLSuFRgH7rvCtpSVVJcjPtnYL6pzj9ilUgzTPEK2dDpYPxVjOLrgp8KKlC8HcjB
         JC24WXFn8IX4+vFy0tUPhogjxTH7gOkfGTMuhrdnq2Z+3vzhblz186Lhh5favjqF1alK
         n2sQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbQg2efziTXnmVz06BMndzIC1dBHMEI4hpe0MSp31vYT8IYY8+8ey6m1Kgxx+JqFOE86mkUURohf4=@vger.kernel.org
X-Gm-Message-State: AFuF++nGzGL3uuMSCmUalm/QH58Sn5PuW3McpjTLAdFLjI+09noJdAnV
	cS1xbwnTpLmzArw4GBs9Wl0dQko7HZ+k8siCHH0AKAtWg6SghfkrqGMmv7rh+J2Fwo4N+U1ZSBz
	00QTc3QbgruLh6VlU4lXa1+ldFJJ7ol8aJ3f2aT7JVTmO5FeLA96cjaZtp3efXug=
X-Gm-Gg: AYBFou35XHJYkrTlFq5JL+Z4K7OFpzLcCJgKJNYDL4cJF01MX/Sulhu32b/7+uboPRv
	fi2w/hC8JW4Z74+tlyrxz3slShI/eNp0MpHqUZ4QW1TnpAxNDIfuGI5f4X5/dE705FbhdCX6pVD
	qhkLD8YbtuyyjFgnK8RFkWhtx8BOc0HkYUY01ryZJa1WYv7/k2wcjunqsuDKJmaACRkvcvszU5W
	FWW/OEcR16VxrtWxgHv7iDeqOGfx3TUKWgLYgSlTMLye5ZGHcoTurjGcc9RTVreFLJAmFPK5Rj6
	9bILptF9ehlpxE+CfqU7fVgunAYiYpePZ6d8UXfngdeP461Rgnx6hUpVen6Oz3lVktZXGEPrjBF
	G54EPPGxj0MaYh2quvUWZRw==
X-Received: by 2002:a05:6122:4a03:20b0:5c8:39c7:ba55 with SMTP id 71dfb90a1353d-5c9b5735dc3mr3751959e0c.0.1789990446450;
        Mon, 21 Sep 2026 04:34:06 -0700 (PDT)
X-Received: by 2002:a05:6122:4a03:20b0:5c8:39c7:ba55 with SMTP id 71dfb90a1353d-5c9b5735dc3mr3751944e0c.0.1789990446070;
        Mon, 21 Sep 2026 04:34:06 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67dafe8csm4051196a12.13.2026.09.21.04.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:34:05 -0700 (PDT)
Message-ID: <c73b2ae0-e138-4472-8acd-b0ae3dcd742d@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:34:00 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-cci: enable SCL clock stretching in standard
 mode on CCI v2
To: Hitesh Patel <hitesh@ebytelogic.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ravi@ebytelogic.com
References: <20260914132328.976902-1-hitesh@ebytelogic.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260914132328.976902-1-hitesh@ebytelogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7XMssa7PxJHb9TF9-dGrhYRrKmZwLJTV
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab1162f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=ZovgdgjKAAAA:8 a=JPJhF2pIthm_ftW-UWcA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=VOxKbm1zgHvARWIDjr3b:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2NyBTYWx0ZWRfX7RTUrjy/YaDB
 E5Ek7Fy7/oUJdkzG/d92kSt0iWLMO/ISq7Ni2V/Ud2ljDGFK3Pme6Plzmt+mgecWhKGRTR4ATn+
 /AIlknRbsFCrZbI7UyKVxc6RtT3D8a1/n14I2DWhysvIF3im3bVU2qCFHEkFx3myoF5YMWPi0UM
 8yJCsK0mlce+L4YcuKjKzELgVIMBwQrsCb+A7k3FSo1UdKKQRjKkgGzYfySS/J5085SMXQ1tPgV
 wKjXGqlmBddyOuCFdnYXFML4gMH6MqNsCHKpLLzpH27boxw45jCzy0EypgF8IEBXqspXz3ELwS7
 +gWUCWhwzNHf2n8Nb+Yn+OWrR3E/d1YvRXB759bMkSFs2p95DH+O3pdhQue5SrtRKYUmqvCkd0o
 4mF0tHBH01mYlzZpiIj2bwW2HVLOOrMUW6wrzpLo6pJkAeiaG3nV0kaiywX1siFMrlU5GLd5SxU
 1dOnASMYgr61+/PQDYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2NyBTYWx0ZWRfX0fKo1kNdeT/z
 O3s8g1BP1gJwNDDH6OPQlNB7B3x+6Xs+CJWtwfw8UsjPRLWw8L2PH8zqWbzxXJ//QLuZzFz+Vv/
 HydIjoKM6h0vqAnZjlJ8kaA6QRa52mw=
X-Proofpoint-ORIG-GUID: 7XMssa7PxJHb9TF9-dGrhYRrKmZwLJTV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210167

On 9/14/26 3:23 PM, Hitesh Patel wrote:
> The CCI v2 standard-mode (100 kHz) timing table leaves SCL clock
> stretching disabled, unlike the fast-plus table for the same block.
> A slave that holds SCL low is then not waited for: the master keeps
> its own clock timing and the transfer fails with a NACK or returns
> corrupt data.
> 
> This is hit with a camera reached through a GMSL serializer/
> deserializer I2C tunnel (MAX9296A/MAX96717 on the RB3 Gen2 vision
> mezzanine). The deserializer acknowledges the address locally, but
> forwards the transaction over the coax link and stretches SCL until
> the remote side has completed it, which takes well over one clock
> period at 100 kHz. Without stretching the register reads of the
> sensor behind the link intermittently return garbage and writes are
> dropped, which shows up as random sensor init failures.
> 
> Clock stretching is part of the I2C specification for every speed
> mode and a device that does not stretch is unaffected by enabling it,
> so enable it for standard mode as it already is for fast-plus.
> 
> Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 25b6e4e9e..327efa86f 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -723,7 +723,7 @@ static const struct cci_data cci_v2_data = {
>  		.thd_dat = 22,
>  		.thd_sta = 162,
>  		.tbuf = 227,
> -		.scl_stretch_en = 0,
> +		.scl_stretch_en = 1,

Would it make sense to keep it enabled unconditionally then?

Konrad
