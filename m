Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309933;
	b=vDTYEFl1Iy+sxAWD815Yg1GKIOn0ZKMwIXvSrrZVL9Z838NRMlIGRkohOL/bjgB+H5RQ
	 adcLEkeTL9TyFf3/BayczEnqExsEkseU21ElQMxLKK3uPCPCyVZziljBKZEOf4yS+QhVZ
	 89toSLmMJxs0TCmOH32+zMxY28WZ7MFXN/mYb67PxCfZDYy30G7NJoTpGcH7PMPbJEgwc
	 9X2uxdYAwkeNS+EUrR56a5qK8/gQrZfgLTW8YHHL9DoODqnFWMQyteLt4SIWUUjBV/BgO
	 EtTv0i7ponVAkxvkHQ800XuGEBGjfZ8RzcmRcOkNGYVdThFLw7/ssaHyxK2xE0sgwqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0rRn0vIVvyaA1qSueBAyNudw6eTRyVguZjtA8xYRe3w=;
	b=yvJX9RdX1Lfsi8bL0DW6i2xZ8pIj/1wbU1ntaCJk1UemoR707YzOS1NkP6UgavPepPM8
	 FcxkBdL4v1D17VAIb85kTCOgFF6VXo46rilszuF833V4FuEp43hYdjQwpb2zG9mu37rLI
	 pElX1F3UfeJzb3RUcbIP5x/0R7N5UEewdkD9Npekkb2xMGLANt3nQOKg1d976v8HVJOkA
	 NbOZBqGuwj18rV6yORrefJK3/vxw6+39EBSwIXSb2y8l3xNSTOgkioQUTJF10XqeOZr0F
	 wVOYqLovLG22PiXoCud7hmAk3+HnDUA2OKHTrv5zoRqEmKI22FOX+DVkDY6/eshQxOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SsVTADHc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWDHXQ7+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773B60A382D
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7773B60A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SsVTADHc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AWDHXQ7+
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9urB2253416
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0rRn0vIVvyaA1qSueBAyNudw6eTRyVguZjtA8xYRe3w=; b=SsVTADHcHBKzYavb
	nLGn+1vz37WypDtAQXwl9WLGZkVuoQ4m1NRqcSaxdHThnyYTnO0hVcmigznimkrC
	RBBSvTFukyiqAcq2iPekfLjEW47+v7j55zYxvWlTbjYTlnAmgH4RIsmrpCwOtz1E
	yg7YplOeUaClzVsIoGY4g6tPDU19Cavo4Wj+6RzgQXM6f/meoRHJEAefXIJUL0a8
	BSP7uwfY3ZX46ZIPVeAf1WN6DyxiQKxmUxe8SbjvUWDSs+RHPcX9rtLACiw4Q3bv
	lupQCnp2RpGoXvH7pMkjuX7GB6p6qAuKX6f1nHsa4rO3g/E3cz0tvqs5myKQ8cwi
	5nw72A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw48k64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 11:25:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375f0fd31f4so256832eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 03:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794309931; x=1794914731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rRn0vIVvyaA1qSueBAyNudw6eTRyVguZjtA8xYRe3w=;
        b=AWDHXQ7+lkQeHnXLSfs8jAiAlq9QzOGFG9K/KfEFyIZL9sbAxgjqymFR0SqlWk5QPw
         a2Ct0zfthtspI97wnZNxiQOig+ivpeUDpduHk20ZyXzdT17H3UnCQ/gbMvuvt5r23ImF
         GSSZ5JBHjHIPpT+yjzVIqd6HkJ4I64h5Id1L0GKobEzk5L4yWWhpZbP32TDisqlO8/35
         JpaC4bEniXPCptKwU0pvuxwyF6hGMmAx/Fn2cnyPUJ/io7RTzuvKOk5mJ4QqmMCjsM1+
         g7BGMi/CVzDv/l2eIu7j6AOpoxKl8VtP8vbbiEL9MBY65ZdodMespu2NLO7y/XpRzIfx
         wXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309931; x=1794914731;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rRn0vIVvyaA1qSueBAyNudw6eTRyVguZjtA8xYRe3w=;
        b=BDu+No6JdcrPUMNMKEnfD/8UqU3eKkzxddsJUmoWCFLp9sIkF134kq7QaTcZ5BkYwN
         pZL2D2O8udQ5kJY3C49Pa3uXP0Px3cjqZJqT0v/QLmvEBQBVv1C9cgfQOBVXy87++x7K
         ewDwRVsJrRGaVV8im6FwDBII922ACUWOq0OGoQZ4YXla2YlJ0Xsu7ghKFH78vpO4xl3Y
         wIDzHmSbK4NICiGINgs8M9KlDQPkMe6uI2pS1HQCId76/r6TyoCbMjvO0HU7dqBCXbJC
         NrbwSQ2ssOZ0N+MgOWl4Occy38HlVtLPguJ6M2jJPiO9BSIP5osllZVGWy3Z8wqQfnMe
         lzBQ==
X-Forwarded-Encrypted: i=1; AL+hErFwJgyrBW52gZOjbGRDRCARBUJ72MADvW+V/cgF3TCbF5GiP1P6UldL6zm6P/lOMq65qQGdQdbJ9pY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bnq9jFAkmpQs6Hc8619v9xGlxuNtta+gZ4EaBElPFBWOG+R4Y
	XwbhK/9AdG9MPdcBjxZn+7u4zwmFqX+Ie0tRL0MrrqYVyMYu7HyJ/L8fhsiBPcDiC6xO6GxVE/j
	h5Msfv45MCPoIj6z7xOSbXn58HR6acQnEyFlIgnatff1LygWfJMV8e4UvOFeJK7E=
X-Gm-Gg: AYBFou2LpRKsvVkPPjucON8UyYM9qKPW8aucBuFo+uiytg6VT3fucXIWJuIqBUTGZ/5
	1gHifJsxieDot+KQjjWFXxgvgZQYJ2BAJezwHDDkBsJW8KX/0SjOPtDN6vs1dVYeXKArdeVs9SR
	XFROmubv7/kh/4qj8/N41yiEv1zPWaTuvCnOXY2+mW8mI/tCzfz3KwPLsm6uQSW7tx2zbgHLYou
	OOKz9Aht0rieK+M/AXd3eEjE1mm8V95j+1sGXe9rtIekrJyR7CS1iuuqdGsNydPp8ZNusPKTd1u
	iTmM+xVHmVXDzbpcww+l0Z9Vp31AJ/44Ke6BFlUnZpq2ojujljxUK6sLgH9bkOKKhrUz/+SnmQ4
	maXnT1bPOOV6IYKkStueTmk9uq4oKRwAEDxpnMzqE30IlQspPygztFO2hE807VsgWwzb0SBMIBK
	fj
X-Received: by 2002:a05:693c:80cf:b0:36f:2677:fc09 with SMTP id 5a478bee46e88-37520217bddmr2806042eec.18.1794309930887;
        Tue, 10 Nov 2026 03:25:30 -0800 (PST)
X-Received: by 2002:a05:693c:80cf:b0:36f:2677:fc09 with SMTP id 5a478bee46e88-37520217bddmr2806016eec.18.1794309930393;
        Tue, 10 Nov 2026 03:25:30 -0800 (PST)
Received: from [10.206.111.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c7c50sm11890587eec.29.2026.11.10.03.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:25:30 -0800 (PST)
Message-ID: <6f94633d-b134-4b1d-885b-13fea6334767@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 16:55:22 +0530
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
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: i2c: qcom,i2c-cci: Add Hawi
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
 <20261106-hawi-maili-camss-v4-1-d528c7a797b4@oss.qualcomm.com>
 <20261110-friendly-chipmunk-of-variation-eef4cd@quoll>
Content-Language: en-US
In-Reply-To: <20261110-friendly-chipmunk-of-variation-eef4cd@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NSBTYWx0ZWRfX1XTkBVR7wgRI
 /GQst0lVmdXxK5prdPYodaU/LTp/2Uwln9LViv8pQd8nnBnKkqjDf0kZHU9HtvPUKtC+Vjmxrih
 LZCuvvfZQOEQchj/bzz7Mt45sn+p/v3h5WdjsbJ17Ogll7UGhJ8OwH9V1GJdznL0Dmnq1RQTTbr
 SZc6IphikpgNRPTFHtJiW5mX1DswCE1GP6KXhYummsFdUVOF6PwY2mIGq1lKcIdCC1LnaabPh5r
 Lhv5Kz7yo/zCFYWLG3WCBrEOB6aV/Vq9LJFxJoGVuGZXmK9k4D+y256RRB5yfVvQU/ZW9ti/D8K
 bgGEkUQHVBEfTOT40+HBwVcWfDkQO9Tx4g1Aa/2YUf4N29wKSolVh2BDS3mRbmFb/TJ/tXr2rCO
 66qGzkLvb2hFLYAhmekr2bzCSRGbzN4V9c2S+4JK5WxmxaVhb2+uuQ+kvXydb1PoYziHdM7atBP
 vbsFMg7Rn4pLyd6wluw==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af2ff2b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=FDn66hFibwGTVsjr8H0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NSBTYWx0ZWRfXz7lWF7IQSaov
 HnwBpHsubmKHEKQnkM8DjhF7fF/mCEEJ19wF947ukBWTOZN/2nNZI6fUW4nzW0zsW5v+igP6DAE
 ShoSzccXPuOwZ+Vtcj45yFeAfaQVjZQ=
X-Proofpoint-GUID: RhYVLJluP76sfoGKd2MosG-A9ZNB1mCA
X-Proofpoint-ORIG-GUID: RhYVLJluP76sfoGKd2MosG-A9ZNB1mCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100045



On 10-11-2026 14:53, Krzysztof Kozlowski wrote:
> How could my tag go back in time?
> 
>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Who received the tag and what was happening with this patchset in
> between?

You are right, the trailer ordering in v4 is wrong.

Your Reviewed-by was received on-list for v3 and carried forward to v4, but I
placed the collected trailers in the wrong order.

I will fix the tag history/order in the next version, and use b4 trailers -u
to collect trailers properly going forward.

Sorry for the confusion.

-- 
Regards,
Nihal Kumar Gupta

