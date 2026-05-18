Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434CB376BE0
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092243; cv=none; b=Pxgv1cYzM92nDcph5eG9rnNZA2+ioMlFoNgBAzjlLHKGi9NBPFS1MUuv/TnBzrs8VapUjGqH/sZEK27tAygq0zNeRSrHlwe9IlpTnbfik236bxFZnUEieCA6aKu1kSSF51mB9kP5aMDU+VAWK7h7xPK8tJ1yx75QztQilY+3mB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092243; c=relaxed/simple;
	bh=hnHnOVBpSZeFkIWLNG9w0ldAaeesmrJh03Ccok8WI7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sX9SYSMAhXfRkoS8UK//qwUFABugRFGPeTutlsEtg0WF00efUz/qjV6bN7zfJ0lucvUaF5NmOOQbtUM9AqgPJs5dWROZjk3yEZsOdVtAlxVA5kL2bJCRB9Y/XOcsvGMnQYQ9eOhxphHHwU15UTMAX0mo2yC0sY4kiA1Q5/QPnx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0JFrmFM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KEWzpCke; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0JFrmFM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEWzpCke"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I5bIIr1696561
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TeC1sum79htyY5/MRpV/MwGyiDGW2vSHpi60YrA7AQ4=; b=X0JFrmFMptg7TygH
	4uReMr5XF9a2SItuVxjCHMc5Uji9KvkbP40payCzn5PtvwYB4HgOpuUzZ58igkTL
	lPrjNusZxV7Rw+mfTS7GWAJpM9NhpzQO+G/NwkQtvs1qSgMFCi28lILqgvkOr8d6
	KkQeANuo2fNTtY6193hTmECpGSih7OcxagSTlpf5gwAANJ0eT8mX0qvzEYy2Wctl
	S4kS3CTTPeh3sh6zGTMOHEywLmKvJ2QtVtkbd1St4fA0PKBghXdSYh/m409//caw
	Ucnyyv6MQBZgmPWNUEKDWUZlbRxdqe/5eVxZDjCRgFfAIbvPJavfTq0gibuDmH+X
	K/SJYw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vsk0pe4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 08:17:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fb98b09d3so7441021cf.2
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 01:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779092240; x=1779697040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeC1sum79htyY5/MRpV/MwGyiDGW2vSHpi60YrA7AQ4=;
        b=KEWzpCke2VAz9QvtiGn6bH811pkm2KbAWfxMfMdN+xCeRXmQvCtmet14vZqVc4P5QC
         Q8p+8pSDaCIox3HRasNVSsJe+KbN0tHj//fekjbn0ltDB+bOzDh6wgoL/ArCKW/QCQdB
         3V6vukRH/NrLURUUzi4PGlKN2czso0/zbRQf60AYOrRtiQtdMlBQKpE8nOGDEAIzloI3
         YqntgDwXfRqqHYINAdY0s1EOaf80CtFNF06xnnsFFWMqFkMc4VQD114kLWHgK0fxhOLV
         2/ofsRAycMOQSjBzwPGUhqy2YdxBF5LzD8VlUzjwP4dUHvR9yYq0wFKcUN4Il5irTg6C
         EBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092240; x=1779697040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeC1sum79htyY5/MRpV/MwGyiDGW2vSHpi60YrA7AQ4=;
        b=haZsOUchMLOCIB1Vl7qWHrb8n9MAsJg09jwNzEuepR3p8rHGhZ6INZbwvyRQpHLSsX
         0yU4v+vviXiI//ssFF/0Fm5fpiJC+1uvVxpaQqxXsvexaoluE/Mc7c7PmykmTdhU11Fz
         gFaXOzmKP0g++w9K3t/OaAZWkgmotKyKnvboqQYY9VV+31p+R2JcP8T6uSHgQLdYBLr4
         8vovJ2hjzKq5Xq89aaxSFHhFvaJKnlPcSl7O2wnqenixW5Lpu3xfK5tiVkXc/LMp/kyv
         oECcnER9WNhwIEo2vqSztaO+ondgHLyMOKpXqWNktbYZORDu8hysQmwaIcIuwie10l2S
         LuAg==
X-Forwarded-Encrypted: i=1; AFNElJ+iWBXxeJdan7Bg352LS0rQeEtmks7sIbJDG/MijH4bPMXPYZrg5NDn4/gc5hG4zKChYqMTecO15GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQ5vu68oFGLCHgTox4PTeczhzWfN/R6XacdtAJj0uKuzgk/KJ
	fA87Jv1n+rh9loGQLxaV+Z4IJ4Xm89sE+Alp26P3aqMEg9fHuYML6prGMKvjrP7b7BWKfpEGRlm
	ow+hpMD5VZ4u8WrlbGV5GPvk22D5v9hN1/vgX5wa5/idy2R2nkSx5tg0JwNAQLRWqR7UehjM=
X-Gm-Gg: Acq92OE6G2o5XYfzSlVr6Z05rlbwRcvnwABTj/gJjSvaA8gN8l71uznQRY+dewWBZsp
	IEQiqJl+6TgeCClaV/AQE/GFmljMXmGhasObYcsOm5OJhH7T6VtkhTbg5t6RmhKu4lOBDNw/NI8
	ITBLzFsBBPOF4qQbj4KiLY0U4fIW32A+E5FVk80OdLtvxZBTfL+IQmUk3eAkViA33hNqYZPr6yv
	04Id/p8Bw6Gex3TRQvlP1XweB4vJKY638yt9/lhNz9YAvyGUYL/OcwlXrurDjknJFa2OyWp1Nfd
	m9WA60GWGSBcdWK0DTM3ajjiZ1gc8b3G/CjdPJpl/Qphbq35GQVlQXH3JJZH0B1LtQs5x4C0y1/
	CR9XRsjnBis68MkqZA5Ms9dZSEoi0pJkb5Q92nC3vXueiAxAPZx2BhkQC6iRo4wU4z5Zec2aB3p
	P/KO+UXRo4eSFLMQ==
X-Received: by 2002:a05:622a:648:b0:50e:5e6a:c7d5 with SMTP id d75a77b69052e-5165a004137mr125819211cf.1.1779092240543;
        Mon, 18 May 2026 01:17:20 -0700 (PDT)
X-Received: by 2002:a05:622a:648:b0:50e:5e6a:c7d5 with SMTP id d75a77b69052e-5165a004137mr125819021cf.1.1779092240072;
        Mon, 18 May 2026 01:17:20 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm534494766b.59.2026.05.18.01.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 01:17:19 -0700 (PDT)
Message-ID: <915bc9d8-e5be-41a3-80a4-c883ba77ba00@oss.qualcomm.com>
Date: Mon, 18 May 2026 10:17:17 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] i2c: qcom-cci: Move cci_init() under cci_reset()
 function
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
 <20260515234121.1607425-4-vladimir.zapolskiy@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515234121.1607425-4-vladimir.zapolskiy@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA3OSBTYWx0ZWRfX1Y1Ka6MAhNtP
 s5QJm6jQbMtvwb+61w5d96HxWZFyvUpPNjl0CvGuBf2amTQmjo+Zqdq+klSlMz4F+s8KLcVG+Ia
 RYvmbq1hSBGVs5fSbwRVM3v4oTr3SVRCkjHYYsv5zegzT9NMpPgafhfSF0ReRm1HhGJZHf4r/YZ
 ylc2/qrF80jSVxb5WMxdwwf5gFCQZpDvgM+AJ0azi/QHDh1TjbeuQM6A7MYtOFQYGxoeIkKt6SX
 MQoPxa2UcVcZFpiCR9PSTJhuE+b58h33gGZexY815bxHoKB0E9nS+iEmA7hSJ/JnjiLtGUTsUYm
 DO419ywFYaWfPWclOWYipz9UNSmanEtqpIHzrkXzU+ePROu7/YsJeIe38Lcj5bc4menyery8jrh
 Za4iKaWKIQqABzskUvmnmTzMDim3nyKK5rIFYzhor0MbwJtw8HoxkINrMHS8X1bAKgJTFa5d/27
 pRYaoYLt8CoYsVSVL+Q==
X-Authority-Analysis: v=2.4 cv=Bq+tB4X5 c=1 sm=1 tr=0 ts=6a0acb11 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=qpnuY2EOznYSXkWEZdUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hYeBnLHrnI3653ueQiP6FRy8ViqK4bKW
X-Proofpoint-ORIG-GUID: hYeBnLHrnI3653ueQiP6FRy8ViqK4bKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180079

On 5/16/26 1:41 AM, Vladimir Zapolskiy wrote:
> On probe or runtime errors cci_reset() is called and it should be coupled
> with cci_init(), instead of doing this on caller's side, embed cci_init()
> directly into the cci_reset() function.
> 
> This is a non-functional change, cci_reset() and cci_init() function
> bodies are reordered.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
