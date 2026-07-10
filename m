Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0443EF0AC
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675686; cv=none; b=YrbPZJ4zh2EIUFRpMH7jsumEf6gD2GPoM4qYVHqK23jbsr8smd+VhIi4m0P/EYofKr/kZRmca4rgjaOzBbzE+BdeBV50lbetRx3f1XUDIQnTQx2lIA9hl20QFhx9NiyiWeisX4ShDovEMNlFks4WSisQxurupLW3VV6d6W2PPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675686; c=relaxed/simple;
	bh=3W9St2a+jKGkGj0S5oGaRQjvJtDzomLECmfwJ3GV3XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XY5x/Zm0cUQSs2SGXdPvkWbxeLiMOnXKIaOgQgT9gf+R9V0VRi7k8V792SD8tRkvbbeplL93d9ttrG2giL1+SKfqI3m3SvMw0oVtiNHxJRkQgsQpcZ5jJiEN3gDowyX9hqcCFwYqlrfzK2at4TfHzCDJtTDF+TPA4bnNx0LVems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bEQZwyc8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F6IO4rya; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEQZwyc8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F6IO4rya"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dMgP182265
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 09:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ea0QguoYL7HAG5QOZUHhNnUFaa6FuT9iaUs3b0VOK4E=; b=bEQZwyc8XDMXAW5T
	oEMWxvv0TPUNE+xjii/lGQs/yn9jua4T4pq8gYMXFaVqqv3cUCllqk9RRr0FtlZs
	FW6ncGBWWy53MmpI7kIlvuWR6NXQUazvB06l2jzszG69JXWFEvdVuY3fgJ6eTA4G
	kdh9ZpYO0R2TKghzi+ltSI7N1ljdtrWw+J8S9jvXkmApG9tpzHh/L7TMc7hPjw1X
	TIAWCIOdl2RbUMUEMI4jHB5vGnw7hkUeKicM/4bxTvqg0FZHIg59pjpn+27e0m0v
	sg+BieWuHrm/sC0Y8Rz+0LwssX/yp8NpboriYdS06O3QH1fTG5W26EU1MIvGL5Zz
	Pz25Zg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte2dr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 09:28:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c9e97b626so2356811cf.1
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783675680; x=1784280480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ea0QguoYL7HAG5QOZUHhNnUFaa6FuT9iaUs3b0VOK4E=;
        b=F6IO4ryaLWtGoxWuuRSr1Khcgk3XEP+a0s/k4WOPCBGahPDcTnjM3XX9dc2FqI8188
         dwZbsp6sP087f8Q3EnEhhl8zrtW/QDMk0i63h4HTRvYi9wbEFy93ujqL2Ld+dsB4lc95
         RPOtFJdu3LwXQWW9gUjAJrE/DgLPXarfkDrWWX83PZjZRkW4R1/5lEhGyTgYff9xpl/+
         V+631fh9W4762qRZtY4y5qRlXBKO9lM/ecwTWhqvqgkfUlJ6SyVUsdEsVh3TZY3nGHHQ
         n15xg2Y1gBVPkd/De2E903IpnQD1fDCammJwTRcO+rfA0Iaeg3RNLGAWHdu9sLpHbkXe
         oIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783675680; x=1784280480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ea0QguoYL7HAG5QOZUHhNnUFaa6FuT9iaUs3b0VOK4E=;
        b=FDB3YvBQNsryYCBaRRRYcGYYf6TNQME+ejt7L9EXXb8fUhuGsjE+3fh5sqp850fp2r
         QWiwVePdzK4eV2Hc+RH/B7qfdAXbTp0T/ztCAYof7icHYpMQMq8Rp9HxHHW8VK7VaSm+
         ay77f9wRaYG4IcmCOu3aVf7gL6qGCFAWQXdVywPQkOkZdAm0EArH3gl71AvGB9b9dTdJ
         ykue2+QSW3Ej1bPD5MXvXPRq/XDarIrVEoPQCu7cg4PukSshMbJq93oODPchD0rFu761
         uAkJmfWck4Uus8dF+VHfRV5WEklN/F4fBemxMH1782An8UQ5sEx3tDz+Lx8Uogngw8DQ
         F+pQ==
X-Gm-Message-State: AOJu0YxvnVe0hsXXLEGDcbtNsxzUaBAuoqb4X5q6CZMYX1NdKKB0dCXr
	GCnNH7hW9ZtnNx/DnTI+FSZXtPLHhn+uip3bM2lX69vDwHkRTdu8tCzj2rW2l9kgW0sPGo+9TF8
	aj0bCWns8Vl8zLP7/u82CHCUqd9P19ID0bb2yWkMt5aknqjDTFSse+nqHUeccPRE=
X-Gm-Gg: AfdE7cluG3FpuZUq5xx4Sk2hRXeSSEFYL82U4yy9o+m7FYqo8Qpmpw9qhMB03lUGG5f
	UQtJn7B6vaQPJLE6K8RQJlLf5/Z9KVuMjSYimTxxH7xiwng6vpsYZ8mGIvR2kTeDDrPq4mhgZE1
	GFBDKHvWESO69M80lUQxR1ePnLjYtb5ZjWUQwWqrkEZD1IKsUVctVTQ0B/eumjEXipyzz34Sumz
	Cl9OTtu8CTIYuFqy8YzzE1U6lzyizNgrH3eghKxmQJrw1NRF5BdpaK+zQ+H0W0XmVvINRAkMStg
	dHr7B6fiYOAECNYeQJL9PuYmS8wWJWMoCcihM/hvY/MlayfrEStmlE43BBTmqOsNs1MDbKlpKbm
	9pkNJGB1t4JvR1yep9PaZBihMk8+VBU1CG3Y=
X-Received: by 2002:ac8:5acd:0:b0:51a:8c9c:7de1 with SMTP id d75a77b69052e-51c9684058emr68768691cf.11.1783675679870;
        Fri, 10 Jul 2026 02:27:59 -0700 (PDT)
X-Received: by 2002:ac8:5acd:0:b0:51a:8c9c:7de1 with SMTP id d75a77b69052e-51c9684058emr68768501cf.11.1783675679321;
        Fri, 10 Jul 2026 02:27:59 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15cfac0f76sm402966166b.33.2026.07.10.02.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:27:58 -0700 (PDT)
Message-ID: <82326bd4-59f0-45b6-8f06-38896cf9f9bb@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>,
        mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
 <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EsucpWZ6KWjn_Z6DxkPCDe5NJqVszEa1
X-Proofpoint-ORIG-GUID: EsucpWZ6KWjn_Z6DxkPCDe5NJqVszEa1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX70vXPkBHAUm+
 ZQGFnKJt2eTDPBN93j2AsmSjiymi8zXNhmY+w8kUTWvCazEyEQ6x8GyPjp93lMYSB7boeAbdY9r
 eqwerwganxGtrgc9TASGSloVpvICDyOJOf/rpoSK8i6fdD4PmeDgdeeZxJVrVlwirgQwlVceigl
 oiAgfApMlVOP0TWhh8N4R4wEKo6UXI72UbKQPmbW5LVqRyypZxyzuL+gJz2ou7m1N1cUGCtcsMa
 H3oQaWMpLi+/26fLAS3wR8TFL1HF9aXtByLj5ROgM5WJC3mHeBtVTwGw+xfkYnUGcKfH01GHc7C
 rvawHjD3Y4PDFB4YXG0mI1vFh27IyUkW9ea1ge3Y3LITBf1EU2fwUnvfBqJrk+oDoGajKvi6sG8
 1emoPANtvEOJBU1VoHheXS5teSP9bKbLMDGvhrhP6Mx7foEI7urNXmkG2dJl3PxySMU877lEh5r
 fqneETlL8m3zFHMGtMQ==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50bb20 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7-yhJlWS37sO_0-qT9EA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5MSBTYWx0ZWRfX3/JBgARL3f7t
 d4h3ucJIi9iEOqujLywouLYJwQsydzPC9q3U8rS22sx2AJZfoeX/60Rw2OhUAnXK5AhpT7HaFz0
 8fkxGQvUfA+jumeyK0MEUt9y/M646bs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100091

On 7/9/26 8:28 AM, Aniket RANDIVE wrote:
> Thanks Konrad for the review.
> 
> Sorry, I missed your comments on the v2 patch and ended up posting v3. I'm happy to post a v4 incorporating your feedback once the discussion concludes.
> 
> On 7/6/2026 5:11 PM, Konrad Dybcio wrote:
>> On 7/5/26 3:57 PM, Aniket Randive wrote:
>>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>>> regardless of message length or bus frequency, causing unnecessary
>>> delays on error paths.
>>>
>>> Compute the timeout dynamically from message length and bus frequency
>>> with a 10x safety margin over the theoretical wire time and a 300ms
>>> floor. For GPI multi-descriptor transfers, use the maximum message
>>> length across all queued messages as the per-completion timeout.
>>
>> What's the reason for a 0.3 s floor?
> 
> The floor accounts for I2C clock stretching. The spec allows slaves to hold SCL low indefinitely during internal processing. A dynamically computed xfer time alone gives no time for that.
> 300ms value covers worst-case stretching while still detecting real hangs 3x faster than the old 1s static timeout.

Please put that in the commit message and possibly in the code as a comment

> 
> Thanks,
> Aniket
> 
>>
>> Why a 10x safety margin specifically?
>>
>> [...]
> 
> The multiplier covers the gap between theoretical xfer time and actual completion time (DMA descriptor setup, interrupt latency, and scheduling jitter on a loaded system)
> Without it, short transfers would have almost no extra time before a spurious timeout.

Likewise

(Should there be a constant safety margin added to account for all
that? Keep in mind this driver will run on a turbofast Glymur and on
a notsofast Agatti so any numbers that depend on the processor's
speed must be reasonable for both)

Konrad
