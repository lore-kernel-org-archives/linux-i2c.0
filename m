Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61900272E6D
	for <linux-i2c@vger.kernel.org>; Fri,  7 Aug 2026 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070067; cv=none; b=q6FClr/nYOkPdWGeAsf3PLmGsvJVP5fCEbtd2vzMIH96U5m2zL66a4jc/l/A1E1vkpghgBDpNHh5jYAnSGbxI2a9i9rgJPIaen/vfVrDjtd1NkClZCSss/1S8zIlMct6j6r1avPCXfcQw27CHHOLP+/Mhr/jDgYDJRtLU6C+Fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070067; c=relaxed/simple;
	bh=F3sahIc5F9H37XPLmF3ypq3puhEsMkLGGOfvBF+VKNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMwLDvT3F/yZq7TXavbh7LabEkXRIggHbDJ9EmaRuptpZJ0glm1q0SFLzkXsXqUoGhifEE3EtgH2gV3yjbZNBjVv6jTbN2/V8yvCODZykDU59ZaERAc/wUJo4KXyElUKKWSj3xQxP3ERJG+UM4p/nc/U47KXKkYK9kznU8kDtcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AoVUPr/K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FRubIIj2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AoVUPr/K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FRubIIj2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770GlAs3822004
	for <linux-i2c@vger.kernel.org>; Fri, 7 Aug 2026 02:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndFmLvtglCbgUdpFBjfySPC0n0eZtwY946Lp1MLj3Lo=; b=AoVUPr/KMBCJWVge
	qjJSDEs1VQYikwckSmo7dfD9rW9exsurvTREmlIY/goqwA3EpvD6QjXkEEbNFLf+
	IVCkf62Zcl6gCQGgLwbivuGOQ6g+tUElaqeAt9H3ihgavJ8m1eu5eguyJTOyGBPC
	RIE7H2c8mDtuceV+a/Bqv26NgznSEsxSmsC5ngZwBZ92keCGplQfZwvXsL6k1ZBd
	gQ7KnvSjvFetFxuB7ulCTyFVfvFX8x/wyTgzT0J8zer/hWV3+VRxSmQM9RuuU1M9
	mSBWDF6Rjq9NsadiuAtO61EjskxftmFLDPBict7DeqZJb3OGRuwd2RTvPAXw2lkx
	hQILAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gsv2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 07 Aug 2026 02:34:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c01ff996dso32589761cf.2
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 19:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786070065; x=1786674865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ndFmLvtglCbgUdpFBjfySPC0n0eZtwY946Lp1MLj3Lo=;
        b=FRubIIj2YCRh24dc8EZtVpZzO+ga2QY6daaHrOKy2HHHqJTVjA63QC18M3QPy0GVUj
         ZGq1CKc6o9Zc+Lzrdf3rmYVN7ojlgZTD71M6Mpj/LkkIldtEBHaYJWhyc5yIfMPpFZR+
         GRpnaxD7ZcrrGz3CKdGipSzgQV4mcWJv4HchLPfJUB5xGoqDnr1cCvYJi/i4e8AsK6ML
         bLnLTKw+SGboGl2tb4lZIeJLWA6Zv+eilpY47lBudGwadlUtIzUDoEhUtU0dAb/H2MX+
         I2r7vWRYIH9H5SU4bssEadrF1c+mqD9yRQFQ2Tnw1PBaXA92O0uQE0MreyhCBOvBapyb
         PHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070065; x=1786674865;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndFmLvtglCbgUdpFBjfySPC0n0eZtwY946Lp1MLj3Lo=;
        b=Ln8CZO/Ka858EG9u7OOgpHQCynj/GHXbwmFEZDc6LQSMefDttdgVby9t6K24ojLuSK
         iY74UVlCESGW5OPdPoWK2Tl+Cdc75r7KP3bR61RTR2gi7XKgYwcVaoEx2HFSzlhQHxWw
         hCTrkGOWkmc75q1dKoU7xWSVIVRH6mcUxEKFfcM1EZdD8hYUxUcXxucK/mW463t54a12
         Vop45cDs/iVdKBYC+3yMK26dvdA9JkXZE4ssj6q5HYKFbXNQdUfEgqfXRP5q7MHlNUNL
         BqEaBbH5dV3e2NgT0hCd+DEWF/NmQBZoBlHbv/aLBgzP2gnWCc4CI+Z8nJ0hIto9ooDb
         2a5g==
X-Forwarded-Encrypted: i=1; AHgh+RoCpvX5dO8L9A6f5mHQsoWjLwf84BdqIe6+rdTuPMKUsl+6qEynLXX4O17ad+3trjOKAXcSUZ2hB5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv/Wn/b898Ao4OtONtL2EztGZSk+7o5cLDYMwrwutvwJK62v5s
	GXKOVDbeQmlBCaD2RGDzJDGtWSqWX9V1DzcWiN7rCURppjsfB099ti5R1oO6NqNzrwF42smiXXw
	fcJ64mlNT7Yb9A8vufaHgh7dNVlBqV2hfdPbjApsk6KqOalk84osVnq+SO+9AKsQ=
X-Gm-Gg: AR+sD13kFtlExw0aHFR6nFyH/QbD5c4l1QrW7gT8gCQYclnABfrHczNy4Q3ryjcgjaZ
	bl7ORf6IRi1dka25qiTRdSd6hT/aUzVqQnEBN6tFKSemI95vTyi3Ifl2pyfMB5PCiV0JVoLIq2D
	9hljUnCC5d4arEGlcAmCXmq0jCvvMQXS0J0wf49g5dHw3aEH5l2qjR89oDaWaiVu/eL5vhLXRN3
	wVA6O+Ecka7l2idO/abmSeflxaLwPqTGxaFYz2L7XX6LiIWKcT8eiUyHi8SbY4zuqjs+NCsEh4a
	//lcdW9vhYFadYrkicPbbFDbENqEdFkxsYWfNir2mgdrtHgMevuaTF4gLvsGD/w1dH4HcpVUe1M
	9KySOHEFRTOEz15m7WFZUDdjoNTkFUPN7wFo1c48AuuAJpg==
X-Received: by 2002:ac8:5c8b:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52d18e1a675mr1913591cf.3.1786070064612;
        Thu, 06 Aug 2026 19:34:24 -0700 (PDT)
X-Received: by 2002:ac8:5c8b:0:b0:51c:1f97:e860 with SMTP id d75a77b69052e-52d18e1a675mr1913241cf.3.1786070064134;
        Thu, 06 Aug 2026 19:34:24 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a4dcsm113421675e9.11.2026.08.06.19.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 19:34:21 -0700 (PDT)
Message-ID: <64e146aa-4907-495d-b394-7cecb1727816@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 04:34:11 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mfd@lists.linux.dev
References: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
 <20260805-add-mcu-fan-khadas-vim4-v9-4-75df78710b9e@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260805-add-mcu-fan-khadas-vim4-v9-4-75df78710b9e@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a754431 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=YaFGZCiNkOP6CsGDcAoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DaNDUuJlYaLCCor_pmEMfAdP234DDNI1
X-Proofpoint-GUID: DaNDUuJlYaLCCor_pmEMfAdP234DDNI1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDAxNSBTYWx0ZWRfXyy6LTbHpU3Ap
 z8LhKUZ0wq8jkG66hpONza+hdFQ/7QytEOMZgny160fLjKWl83cVkIsyKynp7Lico0YbWQzYzLf
 Zrvzbt7+05LszGgwnGQW2J4YeZ5CklY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDAxNSBTYWx0ZWRfX5mFPrKPPVp6G
 afoEY8D8dnLPHMUykxQmw2ZF9lzxtaHpJYqud4wmGXnYYk72T8bB54ByCH0LpUOpTL1CVE0y93D
 B7Tyvf0zGWt5K4LImoEPWgAckX4izQBC2PkNgswrZw93jcumie0GH3wBd+cTill1FI6uu8L4qiv
 bH/cca6Htpiqv+yrkXTQJw6ytaygvlFHJiw8nnwgbdx5enwmU+dwbncJDUysXugL7Cu3/F7uCe0
 YxrIHKRYBLgsql+Y+5C+WsxBHG/4brEpoaFuCDtgNhFHGxBEN6s85B8Y2HgN04UJPR8jaQaxLnt
 tUTJkOtlC1TdNLr+bTEw8MVpCpLdmukQLXlK+c0+d0/XlakEo1FhMinsum2udMILeUnw7F7aSUo
 gRUMAcoiTuGoDsx5QxshwET+n0WL4jIqCy33ObLD16EkkiJZvWltEbEgk6D2+mgbC/3eWHRLZfh
 jPiqrnC1BXYEFARfAlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070015

On 8/5/26 10:06, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Replace the hardcoded MAX_LEVEL constant and fan register
> with values read from platform_data (fan_reg, levels[] and nlevels),
> as new MCUs need different values.
> 
> The cooling device's state is stored as an index into levels[],
> and khadas_mcu_fan_set_level() writes levels[state] to fan_reg,
> rather than writing the raw state value as before.
> 
> Optionally acquire and enable a "fan" regulator supply
> at probe time and on resume,
> so boards that gate fan power through a regulator are handled.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---

  * Through which tree this patch should go ? (assuming there is a 
dependency on other patches)

  * How this will behave with 100 levels with the step wise governor ? 
For a 100ms passive delay and 100 states, it will take 10s before 
reaching the full speed
