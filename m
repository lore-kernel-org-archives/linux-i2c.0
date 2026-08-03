Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A6189F20
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724138; cv=none; b=QoA/zqXzklL7ahsQxmVTEOy2Nc5XnjgFEqBWhJWi2qG3LZm5vLrXmw5ZFjiLQlnSmvK1IzPf3ULKAa7O9T+QrUDlFgsuYRS1HDeFmkbIlI+azW4LT9Bgj3po9t9MPaxyvGtuLSuTZtUaAMqSad72CzslB4MmubNnvfY2PJBB6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724138; c=relaxed/simple;
	bh=tyH8YUCMtNCeB/pF3sQCmf8CUaRazOx9uuMVM0I7WEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7ilbRbDgBiEKZjDl6K4mAfKQ0R5zA8V2RNXD2TCI0gNB9vjoJX2LQ8/VpB1GPUQ+Z6G4DhEsQQ/PJXc0peCGLhkEmFzJMPPka/KpHDjy8ERTyhiJIRQ2QjlF0CfKsWJE4z7BhRb2VrGR4oXe96y6g7CcXY+i2T7doFwk5pgdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqvY8j4T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P7AaHnBB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqvY8j4T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7AaHnBB"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LVoH62626140
	for <linux-i2c@vger.kernel.org>; Mon, 3 Aug 2026 02:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UcnaAsmBAt8oBVPJlBM3vzfJrChEQ532xPOUjAvvays=; b=pqvY8j4TrvxZa3gL
	UUhMaUffXRZNMSzq24t2XXk3m4TSENUAhhoiGyPuE+YEFYS1M0winuivhCo26863
	W4yBJV1YV0aLwMqqmGCW+Ou2vhEFfU9D9fhBANJd8jPE8l8sm74jCsH8Jn5BwF0N
	bXGgu2ON7duf+q75IC0X+dK0b0eF+GZ98R925QyXSHm6MEGT4jvfPjeBoqYyoLbz
	Ci2z/135Eohptog8jJLz57NnbYbawhf2vXlB5sHwLM00HLIwVs2xPfkRaswF+jVD
	pJAmjB1NkAsYoGZxwmKvFjdGyXroRD7LoXAqh0W/ExwmCc3MIIKgxr/Frzjvvq9x
	U6FHVg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9jfuysc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 02:28:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ef18406878so27820496d6.2
        for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785724135; x=1786328935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UcnaAsmBAt8oBVPJlBM3vzfJrChEQ532xPOUjAvvays=;
        b=P7AaHnBBGZfiuvmLn96ltZn1FYlKqaSdBfVQlOaWmTWxPiS83RGAl1ER3kYsLXIonM
         E1Z/W9HbwFVrOlA0ySWuMB14UXQFQDn8CfFfnirsit7BxFoSchaLDiD52nFzC9YOB6+3
         WQaKRkHH2lt3ugC7MtMnxkxoiJ57CRT7Z83NqT+3oRf6CZGqh4yEMTrWvwzkfW2pvJY6
         s5zfQSi/WxAzElJGeQqPYXsu98UNdfg1xVB/1jajxhDJpHsK6y7oltIVgY0ziKZbL9Cv
         7qLv7wdqEVpZKk0LtB4qVKWKhlF/NMNN4OowuIazrX8eYKWLdsYwo8KqX81Au1MOp59m
         vaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785724135; x=1786328935;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UcnaAsmBAt8oBVPJlBM3vzfJrChEQ532xPOUjAvvays=;
        b=AcuZHFWerKgXBaNI1ZmGg7ATEL5orxBOHEKPQ5WhskjWi2ECd0324M/nINO4xLYnjf
         bx0HpzFFxky+dsOWCKHLFi5WE59wWblSmZdh8Aod2Ycx9Y+DcFlLzDr7GJIYXJXa1IgO
         4p+qphK20kQw4npx628ajW1rfOL9kveLikryg61apenNIHLuWhqdj8kXvHxpqlr0NlvC
         cKh9mK4l6XJSMBgpFxjk0/NS9Z/Ptelf+sctNJp2r2Vv51vVQaNltPGHPJx3SpB5x9+3
         T6Y/7WBIWWZ5XPwHtgYEs6aCrgZQstYvYKbDZ2JmlfFuLqWE86lheAqUwwzAYfgSaRCW
         D1xw==
X-Gm-Message-State: AOJu0YwfGhs3Xrtv1trkY+54qAQYSyUxbgJEzkvNzqZ7V1gAOUNU3daP
	iehN9bx7MIvBgn6VJFleEZeL+rDl+i4WMsFIu7ZfxfSEThaUdZLKSGE8q5+zo49Iw/oYcx8vxY5
	KybKZuj+1JYmjrQ3fYg7kaAgzprv1taBmfa7bdzRkH5psI7sIUJnJttCo/3/OakM=
X-Gm-Gg: AR+sD12e7n5KHMUW12b8rwXQRD6aJzLDwq8ik2mKaVxso+/p1U5UBOHbs+3xjPZx/xq
	6yvXZ2XWz/O20uOJm8BGmbm8e8BxSjVmbzMy01OC69RGdVuITHpkZQhNJX/CWSQ6X/uLGXYZnwB
	BlwTPn+/fizIb86zfGcxgMNpo94uFJ/K13s2pY1p+ChiDKhQTgm5bkvW8MRXpV81EtWdGUCnFnG
	ojx3nwKgCtjTLCeZchBCQuzHGKkjX/eoKykwmz8OtyQztEWVV+7vhxgmLRxq1qJm/J/BxPYp6Jd
	DU1PxAievZ8I3aiTYUpB0moHRmRa75OxYdYQDIpkQ+Ltz1UXIohflcNB+FHP8WouL0F6gdytLed
	HgnsNG86pOHtDEUrrvR9gvicH3nvCF1VoeT5eyLH6OCGyOG1bCAhNqh8RjCEqzhZS
X-Received: by 2002:a05:6214:1c82:b0:907:dd19:fcb3 with SMTP id 6a1803df08f44-9084966f7f0mr171113306d6.24.1785724134667;
        Sun, 02 Aug 2026 19:28:54 -0700 (PDT)
X-Received: by 2002:a05:6214:1c82:b0:907:dd19:fcb3 with SMTP id 6a1803df08f44-9084966f7f0mr171113046d6.24.1785724134282;
        Sun, 02 Aug 2026 19:28:54 -0700 (PDT)
Received: from [10.111.175.212] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90843606e04sm66132856d6.44.2026.08.02.19.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 19:28:52 -0700 (PDT)
Message-ID: <47c6a733-95e3-4ab8-bf25-dda778dca7a8@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 10:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org
References: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
 <20260729-cci-clk-fix-v3-1-f3c731d1596e@oss.qualcomm.com>
 <016603e6-8e87-47d7-96fb-5441ddbaeb28@oss.qualcomm.com>
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <016603e6-8e87-47d7-96fb-5441ddbaeb28@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4CZp8TG8L4ACkiPyatw2RvdeesYwUXvi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAxNyBTYWx0ZWRfX9mAVEHgI0pRI
 IPIqa/CRAYRm5PF96Xgj7Keh4qB2wiVncRrUvUOjU1wiPdOsNEuEoflNNJb8E/M5A5rWqKgJiAj
 eTt/j3FoCMPfL60U1ry6/gZwvWxRX0wIZKArzOMP9OmTAF4nFJAQvU7cQynSg5Kbd+qiU0oOzTP
 m0o39OwaE8uji7ShideYFe0Ah1SCEtBziahxRYnm6lj/OcnV5nNgsny2ZhbN1iJnYOJeUMLQhIy
 sD3tJqu/7dJx7nOmFGUn4e+iQkVL71v/BRWxGNmea/0i4ovr5Zjy3lWqpL6sMD3uHMrKlyYMlWj
 fGh2ThUye7sbPyBnEFAf6gSJUKFk2Ye0GtfbY3c7cCiYPrFVYKOsS1Am5Ea7BLvoO/DJIRWU6Me
 TwvIXC1KQwsF4DUKw+rAg+hAtHmUKMNmD1vhlD/nD/6+AiJO6bkRXYUeRK8knaHO4s7+yBSBQou
 oD0+lGr0hPtW8cFhHaA==
X-Authority-Analysis: v=2.4 cv=TYSmcxQh c=1 sm=1 tr=0 ts=6a6ffce7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fpQvG6xzPgmDaOYBn-UA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 4CZp8TG8L4ACkiPyatw2RvdeesYwUXvi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAxNyBTYWx0ZWRfX3WWih45cKDOQ
 dvBZE38GRec9Epof4aQuloLtNZGc8xSYItRxxeCK6zcMx4pR0HaZdM3eVL9kZSm8bQVP/6+kZzy
 PUIH3UEncePQ7FLzJQy5UqlVGcM2TLc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030017


Hi Konrad,

On 7/31/2026 10:06 PM, Konrad Dybcio wrote:
> On 7/29/26 2:25 PM, Loic Poulain wrote:
>> The msm8953 CCI timing table is internally inconsistent. Its Standard
>> and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
>> clock, but its Fast+ timings are essentially the v2 values, which are
>> calibrated for 37.5 MHz. Since all masters share a single CCI clock,
>> no single rate can satisfy all three modes with the current table, and
>> the DT assigns 19.2 MHz, so Fast+ timings are wrong.
>>
>> The msm8953 CCI is the same hardware version as msm8996/sdm630, which
>> already use the cci_v2_data config (37.5 MHz). 37.5 MHz is supported by
>> the msm8953 CCI RCG, so reuse cci_v2_data for msm8953 as well and drop
>> the redundant, inconsistent standalone table. This makes all three I2C
>> modes self-consistent under a single clock rate.
>>
>> Note this requires the CCI clock to run at 37.5 MHz, the driver selects
>> and enforces the proper rate in following patches.
>>
>> Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> 
> Wenmeng, have you actually tested this on MSM8953 device?

No, that's not the case. My testing was done on Hamoa & Koidak, which 
uses the common msm8996 compatible.

Thanks,
Wenmeng
