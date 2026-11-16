Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794811193;
	b=ybATWR7w+WeB9fV1yJbArtmjqQ2F8kWs3UZYFrTQ9p1QmkwpzeJNNNoMMgh4fwJyXfNI
	 20c1DZSQAebPLX9K8MkUHhTvJF8sTKPBc/0LtOUmeyQB8W0c1mHSijiIXIVMcVY9cfnHM
	 H++pugOsHW5JEdWjE5Sdi1IJVV7yC1GPe4hyUUfH7vfPG0/T0ugYkEVebyV8pH9SdJr5V
	 cMGwdy9G29OPftJkX/uv8lQwnL+nSpxfun5GoLjrT29Zlq5IelCIBVVgKeCeY+2vuflin
	 z1uEXzcglVUTbGrgegmnhldrrnsCAiqhFOozAMx93oO1w43aCP3RBKu+k+VHU8xFEHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811193;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Uwe1KYw1P29e1DCVb9MjyF+MXhbVXhW/CrTXu68G5dk=;
	b=3ReIKrfKIGLLL3Dq2VYEuOVi/DWFIhwMyj7vzQPoe8hueOChnhrTaZdoIYmzsbO+brbC
	 Ci7TVsGp2ZbchjiDFW/ijLkFNvKA3SluS2DGxahYgEFdjYnk9jTrqN6bPm2zlNsso6AqU
	 pr3PJlsXhMjdyOu0LZmiLbgsuQeSpewaMy4C59a5LDAPUJ3WMD1BiU6MI8noDT2Y69i0I
	 Qr1XuZqZlqCfcAKNuIwAxsJ0RaZxgu0iMZXTaauH6YD1FIdHzAJpWMDX4R1j5iVxNjxp0
	 +RSO8RY6vxI+Fan5ZBfankdFZktipijVpOAHF3n5w+6q0SUreIh2NksXBFsheWNtQog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KccI8a23;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X91ZcNno;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A267606A330
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 06:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A267606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KccI8a23;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X91ZcNno
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG5LbKd1321057
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 06:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Uwe1KYw1P29e1DCVb9MjyF+M
	XhbVXhW/CrTXu68G5dk=; b=KccI8a23szTMbu2QuoBOEIyxSw8xRhiQsWZt+YWM
	gJr6Q+7cDA0uZRq301gg1OcPsNktR35+u+olq64jhgCdcbhDhkUIM5q/1w3HSSzt
	mPN0wgGtpP7EvRPwgnpjAOcchvltQ5N9la0u+G4CBF6cb1eyAHkRX5gh5sZ2KbnC
	QUH75P9/8S+AXIv31PqwTDyQGYEVvAcasvcj68WpyMItV+kWSXiciVxGLg9h/ncE
	tat7c/WacjwGk+qYkFb+wyi+u3m/+q7o9V1yiaYpvYrhIsByvJtNKW1VvHe7hqic
	ViY+VwHU8wXZao42aj7krdea4owxpl6DVTuvXhZFMkn5hg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhman3qx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 06:39:51 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7d2d60dcf2aso2731001137.1
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 22:39:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794811188; cv=none;
        d=google.com; s=arc-20260327;
        b=XYT60mgc99ERXaabSQESz/PiCsrhJYD/NLmdh7Vd9r87ajjxUlzEUxXrzNJGqUKAt6
         s3RodCIuiIK3+EV5D9ZO+4zarmuz44Utmr0io8MM0Z+6ofixDiAgEFZ8ui1m+tCx09QW
         FQrZJFflPhv4PY70av5J13gQ32r13r2kCWMhguqYSvUxJ8Z0Tz94fJP3+CyubMPlnCTt
         WuLZxgJvhcrq7sFkAEp0tXE3seO51aXiHcJvsyKiPn32lZZvVbYLO/3YtYJ5hktwUAUu
         yuImG9eFysvqeT+FhNbFvggtYyUClLatxpIev7HLesdt8efIOmh9duft6TWizyaW5msK
         1XpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uwe1KYw1P29e1DCVb9MjyF+MXhbVXhW/CrTXu68G5dk=;
        fh=ZeiSdL32eJ7e42XydABw0/EzQsujtwP2eLV4R+W1LI0=;
        b=FT9mkd/VUocrJQHYFpTRHjeiR6CGYJYeY1AXCOIv/H9dDDLEnf7G1UI9o6LkBXGEzF
         CR3Up0jKcfIHvhyny8GTWaFyQZ5YIqfO3d2j5KHjpNOygXWugFcXfQSbJyNvvU2/km0+
         1lCjiw0H86nySkhaWhsBnYBtxqk3FxBrQFPH685EVetiSSwcdWOnFPHZmFb2CAorHAZa
         ENxji1dxfLh0UuiEnuOclSD5fHUHN8ijnEYboC2GV/ZBRqBgFMwRmo6YHbOj1PMBoOBP
         8gW7kkZFFaqTtYOQ786WX7qcEN++iFzogXHXJjwV5Eas4juiUL0dE2Up3E2dOYk9XwWj
         ovOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794811188; x=1795415988; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uwe1KYw1P29e1DCVb9MjyF+MXhbVXhW/CrTXu68G5dk=;
        b=X91ZcNnoqmYRaR9fw5AcAwuOTqOGF6u/nl4tfg7dMwf3ZOTioiNhtxpCfRSeYxxyXY
         NnqzdlC9fN0gDzml5e3FYrBKura426jYCnkYrtAmiBb7mR9ImRgf5kvi1qcgaYSTsNkn
         Ac3wZ9A1tYBfTj1hOgM03MUlro94ojHr7FeYTXJYlGoaFaaVc3Sz9Obb35VS5y+DWv2S
         O6cG7xuEbwlQt06LD3X+mmcWP9/UVqT/NOiwX8X8futD/Gewr4fIQSDM0Q4BxcbZnBVy
         voE63Rev9JBkIvQ5sANjv9+baXxXj7ggjTZgG/8jfNAdqtYBRY+uv1exOms8JsZ1JW/+
         UL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794811188; x=1795415988;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Uwe1KYw1P29e1DCVb9MjyF+MXhbVXhW/CrTXu68G5dk=;
        b=l7LOk/rx1MiZIc/e/BsKc8hIBSAXu0YsBUMsLa95FTQuNGykFhs8GyD1mcy1vHRyvj
         2NK70NHJKtrG6CPSSOhF96k7xxyRzuHGwPP6wLKmeRNIyz1rMk/ihZ63ttpaR4cL5//K
         FPPUvLngMiA7zJSz2O21yT9igFfESa0upjmcWRh0e2u3elymGiD/YxLxp1hsedhecBRN
         zZ8zIbkNSGdT8HNe5mrlITvRoZ8Q0qXYIcCTNEQUHKWmEMKg0BlwGi4w2Z1fXpnfar/p
         kurYpPcH9LNEteCOGxcxEtxH72GN6TRrON5Vw+tdQPDT4rnuCdaSXDZj4RRS0RCqQ6ev
         EBnA==
X-Forwarded-Encrypted: i=1; AL+hErEtPZlNwCRVGlx7Ghl+NF95FE+lcUGVwcH24ENqWZSQeyHGfVyStKhBWl6j+2DdG+BsCtPgIY26aUQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/l3lb5eOUt9V8wYNj75WGM5BMwnNGbOUEUr98SwuzlnoGVTfIC
	ioSfAabyrZGVCM/ud3/9/kiWivoNTLf1rmMPb9nXkHpJaJPxyis6l5NecmlNYDdtAzG/A605joe
	0T0/QJ9nqN83Rtmb7P3zGuu4FbEEXN0evZcOPu63ylZs0M3Bpao+bLDISN4D3wD5atssvcB0BqA
	gb2YpNT/11kpm9DnK6TTFnT5ckO3ApG5lLDbIGEA==
X-Gm-Gg: AYBFou1JmXbB7eiFtz9b5fyvVkEh6wpytFhTN5SzJwn1hLC5DTHl+Vp28IXO93dBTeA
	tei95HgB1/P5hNtMLdNxC7/4iEU1pCXpFFo4myKllAX9cmCp2ehdSq7Lei7z1HJTB6ooYG8c4tk
	Y1+d/nGU4fXpd/wOE+lWU3XmDbOig2nKJcEV5MWfWtChPYTs+PPcRuG0MUMLOBfh0jkSX5YRzEG
	sp7B6OLp1DPmWPtgQ==
X-Received: by 2002:a05:6102:c86:b0:7cc:2fd1:7122 with SMTP id ada2fe7eead31-7d64d76c2d5mr3162554137.18.1794811187976;
        Sun, 15 Nov 2026 22:39:47 -0800 (PST)
X-Received: by 2002:a05:6102:c86:b0:7cc:2fd1:7122 with SMTP id
 ada2fe7eead31-7d64d76c2d5mr3162538137.18.1794811187555; Sun, 15 Nov 2026
 22:39:47 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-10-8ff2a11835f6@oss.qualcomm.com>
 <130fecb6-5372-44d9-8261-c3ac88248631@linaro.org> <ea2dea8f-e696-4e86-be9f-248cb6ec86b9@linaro.org>
In-Reply-To: <ea2dea8f-e696-4e86-be9f-248cb6ec86b9@linaro.org>
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 14:39:36 +0800
X-Gm-Features: Aa3M54oy1Hdi3jJI0vYcKhvRYWOd_gLd_nvmiZaADn1RpRApqiz9QprVKg54Urc
Message-ID: <CACbMrhqnjEhFzu+Y4OUoNVv-XhZce=cjsuFnUJNQD6FMN_ikRA@mail.gmail.com>
Subject: Re: [PATCH v7 10/23] media: qcom: camss: csid: Add support for CSID 980
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: LAf_pb7P7DMAgOzWb4IV9DlJwaKjoFAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyNiBTYWx0ZWRfXwu31WLN+VexD
 GJn47+A1Cva2aKhHZIc20dEjDKtIuZsRffPyxkWS+UhWVNJqJZux+6pejkZxGrGZvdmElN3IKrY
 Ng6cUY3opS5lH/zhTlsSfDtY3lD3yfsERUzFwEc+T9UpV60OWQ93xShV8bHupB2cyHUr20nn8dR
 73f7piFvgxvG827BMvpAVviAYE1zz2orFWtoELSyQG4glqOut/Pt5kTKB37h7804RzrvCNbbR59
 YcX7UBWMG/UaTVJLA8uX4WIRAg5Hti9n6QvAaxxrGT35v+lmwGy5+QMq5DrzgKEYFQVTTCTuJF6
 dfzsc1Cp4pavKcbUewvc3MAiWRb4lEAeX9TPb2YG8BtmaeZuJfZVkciAhUOVihhKAkkmrBReBX5
 geWVXbAKl86ERGFELFE+H16G2Ed5OWo+iWgNXFpYk4lmk7fS10to8vDHrDJPCn9iCIDfMMxNHfO
 QFaV3uRpmviLHbI55sQ==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6afaa537 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=f4uaJoA6WFbKVHIvzf4A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: LAf_pb7P7DMAgOzWb4IV9DlJwaKjoFAr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyNiBTYWx0ZWRfX9/a65FphnAla
 N3K55IZHEqt2+wYXzP9seihbiNIxeBkbr5Ad+4aNpL3VVEIY5PUvz7TJu78huYWnFvfLkuCcBxV
 oznbLkFFPEomYAwK4JKYzHJIpaxGpBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160026

On 11/15/2026 8:16 PM, Bryan O'Donoghue wrote:
> On 15/11/2026 12:14, Bryan O'Donoghue wrote:
>> On 14/11/2026 11:29, Wenmeng Liu wrote:
>>> +            for (k = 0; k < CAMSS_INIT_BUF_COUNT; k++) {
>>> +                __csid_addr_update(csid, i);
>>> +                __csid_reg_update(csid, i);
>>> +            }
>>
>> Why does this run twice for the same index ?
>>
>> ---
>> bod
>
> "run CAMSS_INIT_BUF_COUNT" for the same index ?
>
> You don't increment a buffer index. How can this be logical ?
>
> ---
> bod
Hi Bryan, CAMSS_INIT_BUF_COUNT is used in vfe_enable_output_v2() to
queue buffer addresses into the AUP FIFO.

Based on the hardware documentation and our local testing, each AUP FIFO
write needs a corresponding address update to take effect. Therefore, we
issue __csid_addr_update() twice for the same port.

You're right about __csid_reg_update(). It only needs to be called once
after the loop. Will fix that in the next revision.

---
Best regards,
Hangxiang
