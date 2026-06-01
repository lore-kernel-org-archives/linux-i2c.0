Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50739D6EE
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312162; cv=none; b=gFYpN4PGXKcO1O8k+JPOUjlFmKhHrMNnNhaiUmvvd9O2YMKk/HFsE3oYzBnr2mUPDl6q3OyuLzESTFcAIhBpjzL+SUc9+xJ2RSkokWpshZiiQtUSEUidzXooNXYtm4Cl0qQ9IBif+w75xnezRq74DZPhziEtzNyvFVkMy6d4ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312162; c=relaxed/simple;
	bh=3alUzHGu1q1rZwyrAelJu/jmfwWJ8k4Cvig7EsHZoFw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xbov44FVtC+dcqveJuz9VyrHMKcl+GsKP3vFzWzdjW+6qzaDQvnIlTZHwxdH+Zi026u67kuB++682UFaMxKOVjFKEus6pk395FwiWrpE+897v4qC2m7/ti8LbgKgQ/ENK7lXJ88ckLQcCvTCEzw+uIgzyG8kZ4j25GfKUarXOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXtx2Dex; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FNISk4BE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXtx2Dex";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FNISk4BE"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fQd21258152
	for <linux-i2c@vger.kernel.org>; Mon, 1 Jun 2026 11:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w9QEMurAKXE9J6ybxszdY5PU9AaBvmWmuoM7SgFN+a8=; b=iXtx2DexuH/iRCc9
	CdcMNyuvlKZO6CRDVnxcdqrrgBVrUSFfuZCo7NhPUadDNuKWBEQsvBgrFRfLiCp7
	5VgxULzkLrO+h56lSjBpZl1u1jIkmBURaafSWpPndyMEbQulcZIw0t2c0Uc/6i8W
	sPqDT6YztMuh9CN8M3s1C3kpZqu02Zsie0XhioKJ0R7XqWLWtyDQE6yMDtS9W+Ka
	CoWntX0X971J89iW0RuaOTdByUy54yqtEl/qBTeAaR0RDR9rbQFJQTVvVm5uBjqa
	DPbESJvokHE2kG3WgrftxkO++i9pt/aTfJaEPfWclqM0Ar42YnS7YMsX0M7CkOSv
	mSNNqA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6ssrkd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 11:09:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c331eda3so15821675ad.2
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780312160; x=1780916960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w9QEMurAKXE9J6ybxszdY5PU9AaBvmWmuoM7SgFN+a8=;
        b=FNISk4BEqvnPs4JOhnHbg7rZvJzqkIIanf/Ta7fjeFHwM8dUO0me1nfbU5hwoqoce7
         wOL8YJmOQbWBSqHHojTnzRzAIR0JNfEITsmqesXKI4ckSdMl6kUOPpsvFEpY8uT1xBRo
         Du4EjKLDKEs9pPaQtN4LZkCtoDRidVvoQVmq5eDsQNwpWBrUHRMeBxoEYKiySvNhumff
         F3rgm64OT7DAH5VKak02z+RKt88HRiuaJR98f45AIxmIPvg5ZPnJGpHWrXwkaLGtO3Ye
         cWSGH9zcnrjOPZHuPx7iQEv11rtfHKvtI2IMMB/hQWzIqMtLWVRi7euo1twuIf59kAUB
         sTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312160; x=1780916960;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9QEMurAKXE9J6ybxszdY5PU9AaBvmWmuoM7SgFN+a8=;
        b=CtfihHarkLVPduCERvCuDsN6ggXLictUV7eCK8DVI5Q3skVgYnp1IbTiYyhVhDst9z
         Ljxj8Va2yQNjpmux+3hI3pnjRsy/9VTKXqhYRbn0S7uQ/cIV04eIW2uJB/K9pKMhwwJk
         a8z5LpVc9UFjkkVUWoStPeGbnbb6vwouDoYCwJXKkpenUBjjdNGFCjydrZXIQqEsCYif
         fAN9jGbbTNZXXyMv6RZdyEtdjxDV7oAwEsW4yw8sy6H7NFX1sVpcUtcELSIP90Fp/nAU
         KohMUUYZXokvjM5rWsOrVp25znaZQVfbYNIDc1N2Ecg2Bexse6Mpn/3I7xrVehH1bH78
         3aRw==
X-Forwarded-Encrypted: i=1; AFNElJ9PFybG+WhEqGvucvy7OjWo6Es5wsfLRw8XuNJIKU1ZtTwgdaMWxjlcWvSVvv/TlWmDd399VhyXkQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2q2tHu+byE4SElSst//xgQF1Ab3o28mxm+dKL9X9l6qogHRn0
	WUZxnPYNjZY+cTMcRlOCrGbQKbIB26DJqD8WdTQ+Ayf0R+CvPrsF9o+8VpcliHy5ZwxoTaCj2u/
	JYT9GDs7L6o7YtWxf2RIMDyV5N3dW2RnrrHHei43Zvj81OCHtbuyvA5gDppVNIXs=
X-Gm-Gg: Acq92OHHK+JG9YXEAAtJqQZcHXb/iBaMqH49qq5N8tsanZr9AAk4xKLke5uPwbFBRwY
	TS1u/cojwMW76KLRiDCTD59qzynBQbys4JwlP3S5ARROttMQqvYQW4WEdTiCw4SQqZtBbOsb/lM
	qVbygKTOzmD3NQ7x8CVzPf95bARj8068U8Qk0K37d/xKb95G2UzxxFEy3o6Xic2OyQPdmZMCjtS
	gaBYGX9Ke7yLbn+EYXLo1YHsXlVsOudHRHV7bVlE/HTsfPkZvc2AWYSEhUMkE0LHxmzFKKb4MId
	EUOL23YLjix4Yy70Ops0w3RfQkp8mlNXAYxQyhAGzKmjnyrU/KqnpWvvDtIrhoh4plion80EFH0
	yZW6tQBQPp8Mtzy/7Vr49FGFZ9t7BlNlocNyExjNHzgnqqvDZ5zrKYP/tf0nhKQ==
X-Received: by 2002:a17:903:41cb:b0:2c0:f807:56b2 with SMTP id d9443c01a7336-2c0f8075731mr14858605ad.34.1780312159492;
        Mon, 01 Jun 2026 04:09:19 -0700 (PDT)
X-Received: by 2002:a17:903:41cb:b0:2c0:f807:56b2 with SMTP id d9443c01a7336-2c0f8075731mr14858115ad.34.1780312158973;
        Mon, 01 Jun 2026 04:09:18 -0700 (PDT)
Received: from [10.206.103.106] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1e095sm107010925ad.32.2026.06.01.04.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 04:09:18 -0700 (PDT)
Message-ID: <ad3e885a-c04d-4e78-a037-63ddfb0b9c52@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 16:39:12 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] media: qcom: camss: enable vfe for Glymur
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>
 <449651a8-18a5-40d2-bc68-59223dc8b69a@linaro.org>
Content-Language: en-US
In-Reply-To: <449651a8-18a5-40d2-bc68-59223dc8b69a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fJDd7MVDxNZm0V2iLQonJQmRh2GQHJef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExMiBTYWx0ZWRfX0/fm/cw3MRzm
 GuKJxKUnYYcjgO8dEojD3ZmN42YyxZJZk9uhfUJxWNdfKCoZIWL1ImgUqC0Fj38RCfTiBAbrsxt
 QMGj0uP54Gpzc6Ug77/Gg5BVIInQWjgWiFSbaMqfbuZp0cGQ5TRELMnNLU/bz7c/xPwRj75jfxD
 Mzj67/nnm6odG3TrW1cAJ4erWeEK+/kd7a4cGUVMVU0amj4tqcVACh7rodMGOv6LYmn4+Lx6mrY
 +ZgW1Ij99utvPYNEzI/Xq0IfZi9Kl/cAXrnZlihP78qoIVu3kGYznt6uG6ZSV5iWphc99EZo5jj
 NJoW0yGaLbXVpadbMU4A20FLfRjXkrO1Shk+iJh4F/7GAdXgsYEV4fCTF0ZBUvpkJgQDvopxyRW
 m0amzTOwINQWm+vkPKk44BbXxf0Vj5afgmhLGiW6AtXp6+49ZVWjkjfIgHLLSF/hpEk/E5woN4w
 qwyCsHNRr+Ynq9UrA4A==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1d6860 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Xj-fFaYqki_RdGdrlmAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: fJDd7MVDxNZm0V2iLQonJQmRh2GQHJef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010112



On 29-05-2026 20:20, Bryan O'Donoghue wrote:
>>           ret = 16;
>>           break;
>>
> 
> This is a pointless enum add.
> 
> NAK.

You're right. Since Glymur reuses vfe_res_x1e80100 directly, CAMSS_X1E80100
already covers it. Will drop the redundant CAMSS_GLYMUR enum in v2.

---
Regards,
Nihal
