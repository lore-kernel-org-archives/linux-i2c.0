Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579235;
	b=MuAX0LuumOJa+WZX56S/ca6M/C9Zgj4lAy9DxJ/DNYfALcEsnztZRAK4VD8CBFv2Ko6O
	 V55mpbsR2cUG0xe1+vRDkrkx035ZdZMBPC8b71smNd2TwscH7n0Fc8GVzCFl1CMMG8fjH
	 KkLC5lnnDA1alxVHGjiJGYQwoiivGV7GoIqbHRNUTMrsQWYivZ5lUeAdjw0Hqf/uRsf+z
	 GhMOeKNW0usT27DZpVA/jSgfE+LqNm/2KGF3vt1pL/1/7QaF8MHed42fc/dcJMPCtSyNm
	 Im6pGebcA2LSIGzzx+mrjOq7NOKOV/02un1Xvrol0WMs06BOMurgc5PJBox8rB4xxjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579235;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=P45yLE7bX2jg89Q5FDRZgtsOepeDMPIqgweCApG4q7U=;
	b=Bq2uc7BQBdfpcrl6t1J85JO4eevG09Q7+bqeyCOEk6r0ve9xxHTYFdNOOKvK2UWMtQYZ
	 eeOCJPqvCOZk08TeYw32NJK7w6Hy8igDEbAnusriWc2dXVq8V6u6CnK9fy00hAnm4l0Lw
	 9SUir6qpwU2QdJBpwuWNFmjFxW1uI0Y2ARka0MIV2fvRaDkTfPvtbgojRcN+BzfLtJ4wq
	 cwYHjT0oOx58DjbuE6l75GlyumXjJLVUKc5YY8cytFvhLa24ZIFbuscyCHqL5811zltZm
	 5U3sSubm4EfBU4T1DdbEs/UKcRHI/CHL5Fuj2ZeI9SD/0BVQF6Ar1cgqKeIufOx/bGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BE1da2Uq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QhVo1uNU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA4606A326
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BE1da2Uq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QhVo1uNU
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA5cHF335180
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P45yLE7bX2jg89Q5FDRZgtsOepeDMPIqgweCApG4q7U=; b=BE1da2UqOx1uy7es
	X2wfqDUEfsXMOZm6cNjYguPfMSk1Cvc7jvPEm7r5UCn9SFD+07zMh2zXOkMksZIT
	JTUBr3xX47T4zQ1Q3kXpvKGb4iz/i3Od8W/xRQBLxIKpM+4ENQhF/WowvLO+WB9a
	U+oFCYYaQ4HsM4rvdRP+wina0FtNf8ST7t1Y46WGQdpAvnhIl5wWUUB2OAdOO2Bg
	oYqFXJwl75HTdEHRPMFYC3lMRdtf8I9XlWxvllqlOg3p2LdVPgRaoDanUKb/I4eI
	QpTC95Nkq8aqg5Lk2fFUFhJeTha4ZwbbpvZXWFk6iyzx1GMefV3KQbWgxu0wc9d0
	Ct2DKA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj48amc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:40:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53568f05f8bso1560591cf.3
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792579234; x=1793184034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P45yLE7bX2jg89Q5FDRZgtsOepeDMPIqgweCApG4q7U=;
        b=QhVo1uNUfp/KvdqJexLKXP++Mne5887CFBbvAln7modiMjTPWhB33nzJz+lA6yxLqB
         VSEnTzdhgDZoUCNgptpAX+TjfxhKrD/6RgkcGMk6l9kRifgwo3+eUSykEN6xLJrrhbvk
         rFxnQjSATrdbfPOzsz7Cqn6gkYrdVAyIr8vl0MES8g9cVK+xA4id5rC+TXjiqzRmkoCQ
         iCMlkP1jAktfe8avJTmL5AmmXs9C2DQjReCmDSndRbRKeIaOAQR/KfHKULcTAqn8/TBj
         4Q59AU+i6+uID+5WR23ViO0oqTBxBkoA4jq9T+p3m2lo1ssZuXmQ0jvajj+wNbyxppAh
         aG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579234; x=1793184034;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P45yLE7bX2jg89Q5FDRZgtsOepeDMPIqgweCApG4q7U=;
        b=mUaPlEVm0ytaFTygRbhPdPrdelAEhsSlG/i7MVNINqo6Vr9qdtJDanWqNNFheD4fKG
         wwZTuhB8OTi/W7dJ5e06NJHUamcB01THy7iT5iMd3zEXvSYt3fm4YKfbsL76I+iqukLY
         sTpkESW4WlOXRNsIcSU+orDyreJ/SWNSkQITslbiAx70LF5XQuUqH5C6zp5071kORelw
         94zP4PC1zB8x8jZG4jIup7vRLjSQ+qQawgmmIXsC1/63gSrdHcKL4DospOWD0cTSms6R
         it6fro8XfPVXFoSufyX1un2UZy+P+qBqzu942X7AlOaPoEjWQ1sql063W3Z2dcOfl9QH
         ONFw==
X-Gm-Message-State: AFq9FYLf1gBNhkLngmogEvW0od8Nefo/mvAZaspd0RarN1KfHEbYWyuk
	n1VrVOIalsolYhfjYyiwZC7xahJ1P1qYr1g7jKLPSRj9Cv7+zzgKvB9ioLjVvRqGTmLHy8B5dtG
	+lExLXZUeM5MoXlt+Ckm/7nB+bbqOiB6k1OCOmgfM42K5oUffWgDOHCHf0+pxAeg=
X-Gm-Gg: AYBFou040/SK5Jw6qxI1KHRzoUB/z6TH/ZMZwhfEEr/EXz+Ho2eOlUpYN5lwBr/PcK5
	I6gVeqNxXrfMi0UFfz0HU9/RxF2wEaNNiOU+xDrYoFNP9HRBwqMiFslhmuFxsd27ELeBAqSQBCh
	o2wOalVPgWNv3Kkx/vqkAI6jb2XJnFnklOESqZyJdwJR2vTfLHjL5Dv+SJcX0YHgFlyguKKEmLa
	qH6yldmV5sysN72APjumb9OY2aJZOwM1MR65PwKDnzJFg/A2nQzUqrH1SI1S+sPEz4fCpBHUH+A
	4clA5k/iuYfzwFDU7FAk2Eas+AqrnEaUEeNr12HCQPKMafU5OLFq2uYzgKaHGvb4eHENHL33kiy
	fv5KC4kjLEPulLf/B8f4dbQ==
X-Received: by 2002:a05:622a:352:b0:535:fd16:4393 with SMTP id d75a77b69052e-5369b900b2emr27770871cf.5.1792579233647;
        Wed, 21 Oct 2026 03:40:33 -0700 (PDT)
X-Received: by 2002:a05:622a:352:b0:535:fd16:4393 with SMTP id d75a77b69052e-5369b900b2emr27770511cf.5.1792579233105;
        Wed, 21 Oct 2026 03:40:33 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678fd5edbsm62672566b.56.2026.10.21.03.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:40:32 -0700 (PDT)
Message-ID: <7e16a0f2-4372-4e8c-b0b2-e906eb5947f0@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:40:30 +0200
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
Subject: Re: [PATCH v3 2/7] i2c: qcom-cci: Handle and report queue
 overflow/underflow interrupts
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
 <20261016-cci-imp-v3-2-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-2-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cmQ2ekgCd3Dc2TGLL8Bd39AwtQYMqR1s
X-Proofpoint-GUID: cmQ2ekgCd3Dc2TGLL8Bd39AwtQYMqR1s
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad896a2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=onP3my_JgYVhs9eJtSYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfX6H1AaGXcqW5n
 Pszrn6q+sq3xTZeXSLwW9Neci/pw+ivfCNFTc+IO9lrjzm2yGgnc7q5rHtubEIA+RUptjpsQV5q
 FSQQGrS2AJqg2bydjltQxwS05kd9Qeo+9LXx0jlaYgw7cHNoV07fp3zYEAv1VGWMuz3XS9w5dEu
 JjmyyUVgkXlVhGAFx9QcUWd55FOo8/rytNyynqP+X2bwUd8/hH1RAdYAZiqVkxHxLuAbGbCeCyR
 mHfLTGvydTfJsRNVwy8Wxbe0DyyYLrMr3y5VX54IPgRBwmFPIpVs4C32UsobuzW59TfbAfwJXxj
 ZaT/MAEbTTo2ZBdMKgXnj/jRpHbAqO3AiAc0WvuKlE2rmFBAQ2Qj0km55IDQMLUSR2nLv8GF4eC
 FyZ6qj3hzcj14GcwXS3+7njERWZMmpWftZamK4xSASiI/WD80iv7pVQRHiiz0U/81W8HNqkYkDD
 9pboXGnd0HNYjg6VG5A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfX5ZYGf3UYDZX1
 f+LQd3jA7hw08NAw8zSRtMynkUsabHxLK24sqdkop5wMd99i6uJ1QZ3L3JIw673PeeEXrzCorKW
 mi0v+HpwAK7dXxzSDJGrnC23jBO3zRY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210042

On 10/16/26 10:00 AM, Loic Poulain wrote:
> CCI_IRQ_STATUS_0_I2C_Mx_ERROR aggregates the per-queue overflow and
> underflow bits together with NACK_ERR, and all of them were
> handled the same way: report -EIO and halt the queue. There was no
> way to tell a NACK apart from a FIFO overflow/underflow in the logs.
> 
> Decode the individual overflow/underflow bits for each queue and
> report them with dev_warn_ratelimited() as such errors are not
> expected in normal operation.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
