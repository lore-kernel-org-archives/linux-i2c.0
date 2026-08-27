Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41FC3F8251
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826338; cv=none; b=aRi0w77X55pznnSZPNb323jOmGBCx9C3URZ2gh0Sy36jahNNlAMFPCCNtUClTt2nlepTPShGz1MVZYsSwkO1G4E9TgK5/gmFrVWSjDpbyQpdJNauJ3vKoFMTfSjPX+9HSu3+y1T4lEiq6t4C46zHsUdvEKL0/E56ytjVgJ3BlYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826338; c=relaxed/simple;
	bh=zigP1wL7oxtYMtnDpQWIUrURkgMFBxyXiiIMf6C8Gf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7C7oLMl+ng11C6BcWgGyv9n+21zCcDVQdSUN3v+tN9MOXg4PbpH0VfHJAZQ/42qL5RoT3iBG5NocmIMO8g6fLOKp/NN08j/1bUOahAMNXWPTD7u3GevumqZvru7Y3d3Yyn454ucTIxfXgVdF8bMhHm2nAM/TtXpRL4u5bUbFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BSKlQgHk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XK73MsVT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BSKlQgHk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XK73MsVT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9H8Vb3654824
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 10:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/L23aaG3Wf43bePcqUlEH+4iKXPWuwiLJQUsss6YcTw=; b=BSKlQgHkoszJG9cE
	5ZAs6MfSXLW+mLZpCQ0ECzm93SOLDyHR+MxFGuAYROgQel9o9wpQ+DNhPecxg2iW
	s4hI9TqMF3J4xUEzIr+snu9oRswlhHDLSrFVhCYCAoVkA6aDv7wMg2nzz2MajScG
	Fk0X18Hr/wULS2eLES5F64CavCVWUv63ynaZB2sBaYq4KjlV14IyZk3OprMlUEHM
	WpyUn/JWY346qow6ui5NxiVn0JvZvCEMooRkLDG1xwYzEWSpDUm43+G5WxwnBRU0
	NFJTE9zGO3qPrJbvMGXEGVjl7lrivgDEAmo+3ycEtRuxfn6NOqTKdLAzqwogNqmc
	QHmDqA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga075cfej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 10:25:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d733799ebfso10141585ad.2
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787826331; x=1788431131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/L23aaG3Wf43bePcqUlEH+4iKXPWuwiLJQUsss6YcTw=;
        b=XK73MsVTmGc6ZyDYvD65rIgrF0gQhvgAgdopF4PCp4iD0PbpMTqIbaXdKEtO+Gc9Fm
         nefBgNnvji3mNsVKVAaWUGSktGVGL/3vl/Fhb8aFDx1271t0NCCcTWdEjBJqKAsm6lf6
         UFkiZ60rWx643sB46yoETg5A9TStBLc3w3jKK6ARzsKu519woAE6sKH1Gyf0SkRlo6F0
         UIjox/qD4H8vUF7QS4jN9A3zvPlk+jGz5fVxkKvBlfRi3DMFOsW325ceGosPsLhWH6mI
         PCI0+u9n5j5Zl0xNQwqNtHgH4LfeCryb0wy5Wd0mMZqirB/AkzljYS3HKVfhdwCgDWjL
         BS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787826331; x=1788431131;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/L23aaG3Wf43bePcqUlEH+4iKXPWuwiLJQUsss6YcTw=;
        b=UggTHm7/4QvN3kMMPAMFj5kPlBMSDhw3d7qUtdC5hrIhfBZra2/EeL4MZlfqr8kYMW
         L+xolkseAifaYD4Bg6k1+UjxxtuaNxiz/MEeahATUu1CjwK2Xf0ZWAxbWBATq0b8m3O3
         KT2JFCxKU2pMLdJaai0uFDmcMWag4kto1VY7qNZr5UyuqzmE5hsCqgjqxVlsonAVruxI
         l4n1HLXwHiXuayc/JWcMAnYQCdw8vk8xjpAttQIFFztRi2E3CbVFHMYL8nt+Z34mWgbM
         FPyE/PWl0Rp4dUWZgOXqTScyhHfsJZtsVldwQtwCQ8hUd0DxD2JKm7g7rPzgXm2N4PL1
         sGgw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/Re8NJypSBO9SFH9LXeLq2Nql/cLGnhCPFFFII8ehPwQ2uMjSqfo52qS18nXJ2WuDSz+nxP6fSZM=@vger.kernel.org
X-Gm-Message-State: AFuF++ly9Ry0kwT2U1zInJegl7z7SEDuFWURZNwwjEK4kIRmebmo9mkS
	WTi4Jd4UkPVxZhoFbTDIvo/xhim44pAnMlqRRY+5WNDlgQ0K8AyZa4UrpWN+GVWWQ6RqhJoijsG
	mVdhTyjF42RHxswpv+/89Jm8eaZZV0FKRTdn+WUW0PZSU0Bq3vsq91eibrAg8yCM=
X-Gm-Gg: AR+sD13c1Gv9YGuyelEs10QPX+rTtTV+umQVII460xPwK0BQw0yo81I/ijiKKaCoG4i
	JRoAeJBRuu8EayK0gQfNHBF1346FOd2kay/E38ZizC9NBW2u1WFQe+CQCOEWgwcDGW3Hrr4U1IZ
	n7e/6Q5pzl8ONjZ6EB2QiD3uhFOCYzQPdCOaWCNkDFHyDidcliaarzEG9NZjfBFfgRlCOPzFDTk
	ZQ1OyTjACOnqBVMaaLCERqQz9A/qwyTWUZ9jZJ56lF7tXAfdidrPlO1H4uaKNpvesrOS9dOw5xN
	I7OPWq6oNVwM28CPoFRAXCNlp2UENiwyY+7hiqU6wct1cbhpVAGz7cfRQUI2L5bU+dBVZaku+jg
	cKCSVl0Z3HbF5aVbJKurKMqv6zrDkxJtIL4s=
X-Received: by 2002:a17:903:1a45:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d707a9fecbmr260214485ad.7.1787826331154;
        Thu, 27 Aug 2026 03:25:31 -0700 (PDT)
X-Received: by 2002:a17:903:1a45:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2d707a9fecbmr260213295ad.7.1787826330516;
        Thu, 27 Aug 2026 03:25:30 -0700 (PDT)
Received: from [10.217.219.186] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704b9f73esm15212855ad.39.2026.08.27.03.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 03:25:29 -0700 (PDT)
Message-ID: <67d915ab-9206-4a93-9eb5-f8577e321252@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 15:55:25 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: busses: i2c-qcom-geni: Use resume and get pm runtime
 interface
To: Alex Tran <alex.tran@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260826-i2c-qcom-geni-pm-runtime-resume-get-v1-1-25ee55d1f0c8@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260826-i2c-qcom-geni-pm-runtime-resume-get-v1-1-25ee55d1f0c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8A3ozVP5xnApAuvVbK8tJGS9yW6b41d_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4NiBTYWx0ZWRfX9/20W/Zs7+17
 7TRCCjV5P1GM3LFRvyy1uHAmTNCOPo35xzHdFB8qceQ2RGWBOJuXXG4UbxRZebnCRHIvisAiTJv
 rBKiGPEcnmuqwkZbJ3FszkkPwacrchdgDOG1kHazcOfWITHZhQEoEp8hOS5PD04iP0Jp2USJUUW
 TS55dSu70EDD0T85W0RWcBQAAzTi9G0jpzU8pOKLLSW+bae/4pu2GLGbOzHDPfoRCksiTGOowsY
 YgmH9aXY7OR5G13iJVYZH/Q9X1mNbSVWy8EsqF7HEIVMW1lvG0ZxBg5iLEb1QM274JSpibqwmmB
 +P2xkJG/oL8GfVxNYL3wf5nIi59lxeRRQGHxePqYh6Y8jw9etJVgLBDyipj5lKspOD6ZxRGNY0B
 QHnFkGMBh6EhXz8aQZeqqAzyyK9+Osg1X+uuIYNFZBo6FRI2N01UUp0dZtQXaFj2HRLC/+x4T9W
 XLwLzPtzENYmdGBk16Q==
X-Proofpoint-GUID: 8A3ozVP5xnApAuvVbK8tJGS9yW6b41d_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4NiBTYWx0ZWRfX2q+0eEJmGotH
 6qCIhqZLsxX1KzQ7kE9Vq9QGYk9fM1TeNX9yDIrjFVgO3JwkP/Px7mdFCDSr/lCZ2YhnJUdVTWq
 CoZhQUNXQ9Lx+m+nUyAMWvkU/mC2qFY=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a90109c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yE5FkoPsXTdA6R0Zz_kA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270086



On 8/26/2026 10:49 PM, Alex Tran wrote:
> Utilize the provided pm_runtime_resume_and_get api
> to increase the usage count and call the rpm resume
> callback. Upon failure, the function takes care of
> calling pm_runtime_put_noidle. Remove the explicit
> call to put no idle.
> 

No functional change added.

> Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>



