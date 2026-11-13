Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580350;
	b=p2i2AE3/g2OUjsUHJ3C4mP06N9XsHHeVfnDx/B35Fjno1Ww0zkcx4l5mMRlJ1YbyzSdV
	 PASgHNB7IzsyN19jFGgCo+CP8fOX3dBCEY4jWlVTPNxT1tkEiuPCI2I8XPuLMgMTx3cVQ
	 hYG/jD1xNVfGcfsO5VDYs+EodPwD/L/0DhoisOIqF+r4cOUOmg7m1PhUtVmNsrZ2ONZat
	 Agdi06j47WEDO31x5Z9J6YJ7ViTdNyNLVlA6eYLxp3BzT4L88486t25+d/+mzS6mXtbnc
	 zILCBUBQwSyXSG7/mNtPBU/HXNYcsTyLo8/ES2eTSaCn8JJI98qv+sxRidN9kXxXKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580350;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Z+SrVEfWujQdhhBgBRMpmlO8l1VQW2jEUCd7U688UDQ=;
	b=AGQMexZlBFPaxluxeFZHyjofCKShkmj/KKxWTt7JMPPgNwYd5U+JB1JVCGpVyJ4tUjBA
	 I/lCHALywQeh7TQOWFS8ME7Ce4Ytj2wDm/Z4ueApWp6VAgx+X7Kbo3m6OE/kmn3VJt8sm
	 CEv5C7QezpTy2CHEuLI7THyRP49HHABAIV1H1/IZZSWaVClKWdUq28KOHUShYgxnJMCyn
	 vHTsoj+SQu10fQQzYCGlxM4aTxcpcpiu058wxS/S3XTyHhh//fGJuCVfFPfbdLmm/8R4I
	 cw8ob5+iAdLBsnB7Ds0SKq5rnXKyX8zPzH8qZRthvDaF3g5DSK32iIbUCWR6Iv876Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fE5qM7Ct;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=efrV3IaX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A852606A32E
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 14:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A852606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fE5qM7Ct;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=efrV3IaX
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCKRbo3126311
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 14:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z+SrVEfWujQdhhBgBRMpmlO8l1VQW2jEUCd7U688UDQ=; b=fE5qM7CtcmyqiJiA
	Bi5KbSEg50e8i+vpHccpKDHkmwYgcd9wGIeHyFEhrMW7w7/vfXw58WGeDwEywsn0
	jir8dmEISSeCO81quxCj8sQ2vikprln/ngnoqhO/TVT9ysHS35EPPGxNxQAM0NMv
	MSSL97TauJOdXmlAn9Q79YQ2vO0A3YeSOf8GTpHXoLMsl6A0IUF0QdKl/Nc5cer7
	tm/JqltEzSKgXscRYp4FO1NAmBP60WbwPsCpTnPKBk32AodS/frl5eyBWV0cFzj7
	gzJVDuCBXw5dfnRTWvF0e9ZcQc2YcKQ8OP16/wdpzEsk9bgJhZKmr8r+ikR/gFx1
	c+1QAA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bcebf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 14:32:29 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c9e0f047a6so16022e0c.3
        for <linux-i2c@vger.kernel.org>; Fri, 13 Nov 2026 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794580348; x=1795185148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z+SrVEfWujQdhhBgBRMpmlO8l1VQW2jEUCd7U688UDQ=;
        b=efrV3IaXJPD+Ey7S5C+RtctG/vN45dUQ7kVgs95H5I4ws/bMp5HxkTBRs281ppawEA
         Et/NRKh4mWGkn+bIIo34Jf8piyedn8gKZux3l8G4anfO/76JOPq3oQERX5W7AdwKkc2C
         IKRYAFFlXIObuMoJ5mEXe6ZHN0hmIdaVuwEUvV+nKu1LLxKJipnAUN1GKDQ/ZitMNsuT
         OjDMf+KKX0CCdWIe9JPzCTYcdHIzyVzwr6AgxuVqpDshFty5/y4NAjmIgy3j5CJh50oO
         89EHvF9rxTSC3jlJ/b3WFzgOSjxs4XaZ6NhSviaqvwkCvze1qRAG2SDUqSenEjdQyagN
         oHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794580348; x=1795185148;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z+SrVEfWujQdhhBgBRMpmlO8l1VQW2jEUCd7U688UDQ=;
        b=iPZH/rkURpvnlwjDjOR/e4rwncf7jh0sKiYvlMRMc5lmMxkWzdKguU8mOWubTG3wIB
         I+wXYWy1+o6pqEB7OPj31J53ZbT+jd5nea+Yxaw11DskA8LIZRML0yqV7l9Ahy/goxA/
         pVlWvvSxShBIS1BHeEvsIjIZZ3yldbfBAwFd9kHxOu6HM6fDpWrghWkOUyDhxK2wgi3p
         Kks53RJhgfzF4VfS3oK9EtbpKdmF3fnTRifx4RlRXT14h4gPtoB0RvyUhXBywyCBONEZ
         eoG6C7EWvRKVOtkUp5kVDTq2/a64ly5A+8V8z4EcWvIMXEBT//tcLSn89UMHfw/enPvP
         u1tA==
X-Forwarded-Encrypted: i=1; AL+hErFlnQ25XPoaICOI3sDN4nCbjrxysMakCT0rnTyx6JyH0aueJDRa3sI8Q8dDq1FGOY9/Gs5Ge+8Tx9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gbDnn35KehjkbqIyGtkn5QExb9FO8poQBKqEo+UxVeg6wNy4s
	0DHocbZQ51hjT825XabmFNQ3dX4Uwz+ePDbTX5aCVX8ZzM/FOJp/471H5DTvGRL7gIyPMZN8ist
	My438rmxjDZxuP/wxorpWQgJ+ySPMCVtWZ/5psttQgLaDtrV34N6EvmUAjU/R9cI=
X-Gm-Gg: AYBFou1scfidbeGXFcyunKfhFlXBZDIKgsCkuuSihn1y4hbmGF86riTzWKZ/n0MCvOK
	Gm7P9wgxWNf4KJlfaXAW6nIInYQ6FXL9UN4c4LljXo2AZEhYmc7uIhagbT3dC0rS1UIDfutv457
	WVz8Xpc5ZIOzuiEBDqRYouWEr5uJhEaWQhQTxFdSnL+EPQ4uMYdgQzv8kppUknZa/AzvN8LB22C
	A3w17ghelw1djlj++kcN2sC6L22R72586JSszYft88aeJPiAX1KUbRzs6kYviNZrnQOWGPCwyJ6
	27RtY3teSHzrYjWnQfnCl31/D8rNjVEKm3pT9/7JQhiVt6qTg0ztXFsPx8gSaVVFz8eGtinA3yP
	h/MGX/ZxY873HyiqYGpNJiPBWW0g2C2IjcvCiROw+ZplKLjzrlKAtNIwObKKcJsFa9HY97Qo=
X-Received: by 2002:ac5:ce07:0:b0:5ce:23fe:84d8 with SMTP id 71dfb90a1353d-5ee344f2ff4mr908955e0c.0.1794580348274;
        Fri, 13 Nov 2026 06:32:28 -0800 (PST)
X-Received: by 2002:ac5:ce07:0:b0:5ce:23fe:84d8 with SMTP id 71dfb90a1353d-5ee344f2ff4mr908885e0c.0.1794580347493;
        Fri, 13 Nov 2026 06:32:27 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23708sm106818866b.24.2026.11.13.06.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 06:32:26 -0800 (PST)
Message-ID: <de00bcf8-c09f-4250-831d-007bfbf17eaf@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 15:32:24 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Prefer asynchronous probing
To: Wenwen Fu <wenwfu@qti.qualcomm.com>, andi.shyti@kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261111090955.3378623-1-wenwfu@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261111090955.3378623-1-wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af71f7d cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=BP9H1aEygeDGrBmwyXcA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: z0Wwzt85DAKVZ7UAM_FsyoUohpM8DwA-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NyBTYWx0ZWRfX2Iaa8bmolBgz
 U8tmQHFLLRsVQ1vGstSxltTY10nBHWUCiRApD6W57krMwxp6LDOZqL8mnRtRIiIrepo0qFQ20CK
 hlCJdHcq6dQ0MNq9fXx4cKOjHvWWdVNqxrvzy/I7saA8TxA7Wa3sLJ5wLwaoxHnNm9m0mqBbqN6
 HmZEU/7efTfiYReQfzOQ95aKX92fLszUzBb91Nr/PnuVR4k9fGQPIHrxr0BNdcBqye0TZh8/vvY
 KvT1Bp1BzesLjxzl6gBfYF6GnE4TeqpExbHyLUTVgcDQpt6+U1v/jrHiQFU91sacSDpZp8JrPBR
 gaxLElLpAYzDVlxxBiZ9/R4FgO1WFubvkpLkJYjkJ6hI+0nnMAgk12DX5esLQCvYKrqsaGhitNl
 65Z4t5A7VqQ/O93nqjSVhqUTfXhYvKzV2M408ylCdPQkc6BwlSpLxhmEHJw3P9nVc0553EnXmQi
 O1unISBiYh1WorUMFNQ==
X-Proofpoint-ORIG-GUID: z0Wwzt85DAKVZ7UAM_FsyoUohpM8DwA-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NyBTYWx0ZWRfX9BzBcOQoFK0n
 Ci0xtp+9JQVU1RcBhL5iIgNDZUsdCeHfmNNEj+6c4wSzlwKjvzVWXySlZRDjgWKleynqIc4yaEc
 OqaRuCn+/4AD6TLA2ypGHKddU2vOo5E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130057

On 11/11/26 10:09 AM, Wenwen Fu wrote:
> When built in, GENI I2C can request serial-engine firmware during
> probe. If initramfs unpacking is still in progress, request_firmware()
> waits for it to complete, blocking subsequent driver initialization.
> 
> Prefer asynchronous probing so that other drivers can initialize in
> parallel while the firmware request waits for initramfs unpacking.
> 
> Assisted-by: Codex:GPT-6

This tag is considered obsolete, please drop it going forward

> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
