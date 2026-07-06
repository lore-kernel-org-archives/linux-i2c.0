Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE638AC75
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326165; cv=none; b=sj/7QkZrWcrAni1+VDkWaYh7Drva0cRHLf0Qlw3mMRxejzc7k2EbIPvna5anuoF877LXmv8nDdT3eTvi9qGSUtQObDEk3i1uFPWIBRUbwzszMJplobPuxkkkQAbtWhNc9jjc06/pWSDKaKNEvayFjGc1P0TGoCOMMlWnRMmz1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326165; c=relaxed/simple;
	bh=NlLZ81o1w9dv0DLwq3X7CQmJrz4mrvnag1JZDa93YYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeDqT+PJXT6JN2R5wRyfjXI3dJ0D10WwsNlTkoa1F51Cqq/fFRA7maMpPO5hQke3IC46ZQxXmzfh/fIyW3S8EhOMnxcW0Ssf4OMqLh6q6LGwB8jB6jbNBnK0jl/Ba3QDNbUqyFmF+ezcSjRffaXCN3b3JTZQACYgINgkw1t/MMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HhXwqs2Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S4v0qkPJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HhXwqs2Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S4v0qkPJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641UOr3613963
	for <linux-i2c@vger.kernel.org>; Mon, 6 Jul 2026 08:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H7kgDUzxypUi9Hv5ERYiztltz8pc1iThxnESL38uqQ0=; b=HhXwqs2Y0ZsHrIij
	AaX2/c5hNOoJABzdK+vgCCvIRziXAvqlKp+HfEApATvvzOlO9sVSrJzcIZ0gLubE
	xqBeUJ0Ot4r44/oeqRtbFiGUFOsXcI+24UltpPC8iakeix4jwSEjHg8KAnEkv6q0
	ozKG0icp+Jc/2I2XUZE/dzB6e16ku1SYwiAYd0gXoUToBKhts5fkNiuRxdirmiz/
	QNZRC3Kl0sJ3Flfz8XAYdQzqc7irlqPYhDO69z5CHlRaOpMjJSVOtugLSl1SguJC
	JU+WCl1umXijhDcuJFyUpO3C8cubO1nyzL1Mk/Ng7Vsc/y6irFVChjR2wthlmyKx
	O74cjA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvnagv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 08:22:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8952346bb9so2281702a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783326150; x=1783930950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7kgDUzxypUi9Hv5ERYiztltz8pc1iThxnESL38uqQ0=;
        b=S4v0qkPJBvklHLwp9GIc4KT25zH4GYhCikE2Henu5E/d3GRCKSU6Jm6iktgcn9TIRi
         Rid1pjWDYW+L3/qbeNC2Re9i2SrDhfAUDJljfOlM70EBOBZfar8zPkheBbmtBj3aQ4en
         9eVC2XcweGzwF104CTWorJbWqH0YggVPQfKFw0GgUUPUC+FwaRm9Zvgy2Mb+jPIdK9Fq
         QKascuYfus6H8wJ83KLkx6kJNgW5tWeDsNw6PUBFVSUYO7Lpw7gWKv0q0ZJXA0liuQXp
         phj73c0ry+5IVdB9iORtqbVspjLdj96knjz1gUjU5YQeTGKjc8e9WSBRM25MEUDLuogR
         8MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326150; x=1783930950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7kgDUzxypUi9Hv5ERYiztltz8pc1iThxnESL38uqQ0=;
        b=LpEQTKjEET3PBFRwwBTWT8KtXYZ8/qKCgsZvlG0wpEMAEl0lsxSFpHv5QQWH2aNOPA
         h/3pHsgtlATlj4c156NGXTYE9y2dZoSxnXYr/a7KZvUE4fLDG/qz85J3jcsmjQMRQz0I
         Z6VAgpBO43t3Knyllq0vYViMTk++tCA3we5y/OdWFn5h3nMdvJe9YWFG1JYB2jZJdcw5
         8kkUoVfg3bJmKDKLXx0Qhl3tnVl3vHXZsMWnWBNl3H3aFrZJt/whtSkVxt9M/5ytmZHi
         f97454JMMjRzWRqHCxiM751dXpZA4RXdJzd5eIwy/2H1bqa81x8JP+vT7aJF3L6/gvC7
         bz9g==
X-Gm-Message-State: AOJu0YzpSPQfmQANvjKtHyzrlrKlv8MpPu0sikl+dWFjZWXvplnVkGG7
	Y+cCTP24mhvCOtGHFyugIX3qwwYi6pZWzPqfGH04INhJT6s3wrqlyJt8tuIRoQEbcvbWIW87ZCj
	o7PKeatiPXbTjZr13AQGDkRqnp8+iRZI0gOR3nMeBLfqn5sR97dE28Fz/6SRcgow=
X-Gm-Gg: AfdE7clpH3Ku1M/JathAfdk6KTvjqi6j4Qofgv+e5/UQAqtcv4pA3sqvxhCg1lNMRO3
	fInt9eBf70HzbEcGTa4DaojcZ5EeRvFlFS+aZlEzJfQR7Rw/xkjsEpMrehyPqHlNzQTXwA5zSnj
	GxneqjzY0SBsyGMSwcmq+aY6jAvIdHl6NE/fEenpLQnMQI03NBiCwveKkFlJVs6ro6yi2GSsBA7
	Ix3ua9Q3G0vH+PxvedgWYLehDaJL5yrEKX3BqxIxzaE0T8EphMutg59oVWtvSgpA2tL8/fdMHeK
	3EQ+1/PbbcpQnrqkuF+fya2VswoqPmUvYk8Y3QpheakwjWWm70OEo9NZuNwQsgGO6C0gxcSIDPB
	olciCVp2T8gkgZAu2Wf/oRDdh3W1iZ76hzg4c54K10724c3i3iA==
X-Received: by 2002:a05:6a00:1254:b0:847:833c:6451 with SMTP id d2e1a72fcca58-847f6fda4f9mr8656717b3a.57.1783326150371;
        Mon, 06 Jul 2026 01:22:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1254:b0:847:833c:6451 with SMTP id d2e1a72fcca58-847f6fda4f9mr8656641b3a.57.1783326148965;
        Mon, 06 Jul 2026 01:22:28 -0700 (PDT)
Received: from [192.168.31.103] ([152.56.16.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4986bsm3304973b3a.29.2026.07.06.01.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:22:28 -0700 (PDT)
Message-ID: <b1299875-9fda-4477-b533-f491f19e8a2a@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:52:19 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Krzysztof Kozlowski <krzk@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260705134619.4030745-1-aniket.randive@oss.qualcomm.com>
 <1edb643c-1d09-4ad8-97df-66c86e6123c5@kernel.org>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <1edb643c-1d09-4ad8-97df-66c86e6123c5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4b65c7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=hhhz2GjkF5S+8y/bMxhNDA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=CKx7tiaC2mrULMmJUrMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: BMzRWU3WtHOFAVJL4sOWA2N9HrWOEQS-
X-Proofpoint-GUID: BMzRWU3WtHOFAVJL4sOWA2N9HrWOEQS-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX+yxt56L6Kb1a
 s+4mT3GaTA8HvmLP3AXnguSk6+jKItTsuYJD9Rp3ruhCpURriH5ytUGeGTcO8kBKtAy+7x3QTCk
 dJ57J5bWeKV90/28M9sJwuJYOVuQpthTw50WPvxpU/FkKwyJ6gfR2cz3fznw5XBSBw1ixHWFqL6
 ew0e3fiJ5kjmm9I5S5PU/kCJdvnmcztvJMiE7Lt8EqFsFMsV6KgNdwnmCH0AET0nSb+ElLKV95R
 j+u1vPOqOBr8TvBOVwu9RadIg5nGt/9mYx2Y16CFMuWSiL++cab83Q3hbFZzDDIjLaS6uEvA1PL
 GmpGjTkkrHDrJsf5dI6YXi8sdJ87lBcg5jNJZdBjQYpgE5qAz+8CmVOwvhbBMCJSwn88k0DaK5D
 6KJ71eG5xUCEixX0DpSFVXXXCqCmbY5U2anK7XTPrIo3kED3F1PfFqHB5owmNAjjH5uSpsKeYp7
 Wja1gxSE5QzAQfX5BYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MiBTYWx0ZWRfX//dOIM2mMfx1
 ZE0VTe40aVu6E2saIqPne60ET9QQEHuTMB5qni0sLz/sv2SoGe6RH/nGC+LZWfzDuaeP5rGD8Uh
 8WTdM1pmBTQieJyoeEBnUqu3BEEOhDw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060082



On 7/6/2026 11:28 AM, Krzysztof Kozlowski wrote:
> On 05/07/2026 15:46, Aniket Randive wrote:
>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>> regardless of message length or bus frequency, causing unnecessary
>> delays on error paths.
>>
>> Compute the timeout dynamically from message length and bus frequency
>> with a 10x safety margin over the theoretical wire time and a 300ms
>> floor. For GPI multi-descriptor transfers, use the maximum message
>> length across all queued messages as the per-completion timeout.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>>   arch/arm64/configs/defconfig       | 54 +++---------------------------
>>   drivers/i2c/busses/i2c-qcom-geni.c | 37 +++++++++++++++-----
>>   2 files changed, 33 insertions(+), 58 deletions(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index faf146441f97..841108ae2d01 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -32,7 +32,6 @@ CONFIG_KALLSYMS_ALL=y
>>   CONFIG_PROFILING=y
>>   CONFIG_KEXEC=y
>>   CONFIG_KEXEC_FILE=y
>> -CONFIG_CRASH_DUMP=y
> 
> 
> Irrelevant patch change. And not really correct - you base this on some
> old tree.
> 
> Best regards,
> Krzysztof

Please check latest [PATCH v2] i2c: qcom-geni: Add dynamic transfer 
timeout based on transfer length and frequency.
- Aniket

