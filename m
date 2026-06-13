Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B521CC71
	for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 04:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781326021; cv=none; b=boD16Au6ZfOxHzHQlsE5kBAEz1mQQoJ2omAESoc88P3TC0ThH5ASkSxGYdNCakDjUfZ4HbUrbiS4gpa3w58QsaSsvSA/N1Nlb5BKgcrUI6aT4x6ttfS8HP48iaS8u/tZP5llPy2CD1TRaLzDQU4t6pTwOODCmBIp5OMJdtEu+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781326021; c=relaxed/simple;
	bh=Va3NT1tqZbe5IMgKWr3GK0oOwzn3cWko4YKcItDxgYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlAVXOL/woy+GGDIcbKRGEGuJDS7qUCncQaxUUzMrZXYmdOdxC8QlNT1MswM+V4k/sSeO7N7kqkOG2zzStoXQLaNMHGRbjwNgtRvu4uiZ+boFL7ahV3KysD8wxD0rH1vGOQaUfUsSWTC9eXNpnFCst4PvY8Mwrm6eOE2ro1+f3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FbdGHNk0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eij5fCpI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FbdGHNk0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eij5fCpI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65D4dgu81519975
	for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 04:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WltrxbE+VrzBAeQAuOOkNg0JVKgr8R9KzViSn7S/z0g=; b=FbdGHNk0J3dmTF7E
	VbQOfepA/30dcFFN0K2Pz+a7TZTVL22LrVnCHKwb5WTNq6hXW+woyk+osv4XI4+i
	nf/o2NnppS+JkMLl1xOrxMjvVHirBcdYkmMu9YI7Len5y2pRp2v19aHRZlR6Ph5f
	gkyfvYO7LzTNC23um3t0QNvDuDuJIr3qYRSP7HgkkjlMmt+628mNI71JcF3HEpye
	dUEu5ltfJnQVrSU4oC3RAgda7qx20KjVjQ0J6zKbZ2k8puErNnYYn9n3fA+SuHNj
	YT7FLed7i+PdajDeJ4/Q+9lp+rb/mzEqwWx1RxjgG9p5/X9mDhwYgDxt0lL+Ddce
	5mjpRw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgg0fa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 13 Jun 2026 04:46:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf3636d6c0so16252955ad.2
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781326019; x=1781930819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WltrxbE+VrzBAeQAuOOkNg0JVKgr8R9KzViSn7S/z0g=;
        b=Eij5fCpIzO465x1E3lLBbbV9idvsDJncQyn6otR1fiwEVxKD6v6pZGs1IKrKVg7Ckc
         SM/UdhcGpUaOKXZKYzaxRrIrSJ2NErefj4G8NAa9IwUoa56FnGgMfu9IpFbxCb8rvn89
         82XwnJx8a7/urAFZl/a8FIcWn9ThiJBMUBzwUFrfbe2kr+fCaoXdnjxwHJdm0aRXdvDn
         3PUf6Ep+biWpv1iHa9DBbsgwyAIu9PP11/EjaVEnOi4iySxUbwGIepGf9Dz35F4Vr7bM
         4KpcqG8LVBp9YLpoVh06hwSN/l4PKYCNJjbjCz4ChOS0wneoeAToNCWonJUOa6d+x+ss
         fDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781326019; x=1781930819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WltrxbE+VrzBAeQAuOOkNg0JVKgr8R9KzViSn7S/z0g=;
        b=jrH1POR6KIIjRNOGg4is/PRQSMofWbvgW2dEM7LKkUKUrkUQyIhKvjIPIvLNsRMpRS
         W7tRJoIVArAnFeypqFdN5aaqGUG6CX5M9gInD8jeTDMILKLWE/i4bAAkpAURNP7IRiQQ
         bKPc6oh34n+IeBSGXYwF0cFBu06dRfSdlAM+TadHyH5tStNEujjUsV4ptQBTIXPpVMvr
         CLt/vEPalBcGpybGfckKnzyXA2PApomawI1JyEEhTbMClJpMS7Oa6a+8ALEB2+99VdyC
         5V7gXLKl1xTRhC5EsyVidJaCCXVrSgayRVFQLuSjq8O8KL10VmUMgdX0JW+ioOcplPA9
         ssIw==
X-Forwarded-Encrypted: i=1; AFNElJ++fAfC0ax/Um9fIdW1Ywkjwx4vd3TebLfNFTSrhRowlcf6Gi0Uztv14dAdNhtMbnrz6oislQDLbFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJv+9kY5DyKtehjwJPe5ilHlbyY24X7/6OXe17rsYkFxfnLu9I
	rDbVIR2095y9EHJDKiGmHwequPq2s9a9fvj0umlG9nF0cFfExojA/b0kj48a3N4TXYA0wyVVYRa
	rRxomDYyqetSyuEWOlB+iP//WO8lsawBVpR/vBZ5tElfMSQ50ll+5bc4/WdxY2QI=
X-Gm-Gg: Acq92OHWMVyFrz+YhG/i/dCu0iLkcemXxr+5bmZpz3s/5sL50Z/JMLMd7wvrgs61V16
	ENdkuoj79157mI9gz6ynx9WlPhrRQNJho2e7YeRYiBDVeuz4b1nE3W0ejVYoRECqCnQLgyUIueU
	FwDqdLTbH8WwpcdWc4J6KUuKl23C7pc/1Gx8PDB4IPf1Qfj+Y9g2BVtGFQgshVpP27BoDYcyZzc
	xNUsc3r34PIjb9kgCGH+cyu8c+cUVNG9THRdc66y+e6o5fq4nrRvsYG9BjHoglcaV24Ir6hycR/
	J/O99YQNU+TZQvgBWDhs71FHQvi1mGDPB6oxhB52PWRVFkE3YHVEOR9H6ZWglRAihMxCBolCyPG
	JY38qAlmbHxkmV2Gb2i48CYSbqncyTsfIXquCkpQpnlFbPzcBXuo=
X-Received: by 2002:a17:903:3d0e:b0:2c2:bd0d:3cfa with SMTP id d9443c01a7336-2c4110b38d6mr61050665ad.11.1781326018939;
        Fri, 12 Jun 2026 21:46:58 -0700 (PDT)
X-Received: by 2002:a17:903:3d0e:b0:2c2:bd0d:3cfa with SMTP id d9443c01a7336-2c4110b38d6mr61050515ad.11.1781326018461;
        Fri, 12 Jun 2026 21:46:58 -0700 (PDT)
Received: from [192.168.1.11] ([103.211.19.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8becesm37162965ad.56.2026.06.12.21.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 21:46:58 -0700 (PDT)
Message-ID: <83594a83-64ea-4c52-b0b7-fd0070f03f04@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 10:16:49 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom:
 shikra-cqm-cqs-evk-imx577-camera: Add DT overlay
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-6-ca1936bf1219@oss.qualcomm.com>
 <b10ecb42-0d4f-4037-b786-cc52bcd1bdd6@linaro.org>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <b10ecb42-0d4f-4037-b786-cc52bcd1bdd6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qsoOAk10P-WYdFKtvQGRv_gFyfKqFkvx
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2ce0c3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=RuEr1PiGI7RNW/QBahnYvg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=iljdq1zszXl5pgKHGr8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: qsoOAk10P-WYdFKtvQGRv_gFyfKqFkvx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDA0MiBTYWx0ZWRfXweDDJbxqCqTL
 MZiZEaVCgVZ8pkysICkomPrx3M3XeWRKZYyEW14nftoeXCxyDqlkIxsxIdxrWEYGNSmxz6Xch2+
 QnukVRRNoKbCeiH0QJ1grqnrhrnHx+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDA0MiBTYWx0ZWRfX3Xv4fjdTZDVY
 e2HxnlPUIyBpmbVcEfzqr4+WWzi0oPOExLSnq0vCGJ6YLvneOPoPJn4CqRxsI00G6WM7zGT+ns4
 jbkMNqcnrouXj9Fce+dHPDjr1jyTTKJrmQs7GGd/FTs/VFEpT0GGXCeHlMXND5we9Yp+/oYRTTw
 Z64oZ6QCcFyfcC6uhUm9PW3u5PfxG0hb+ZThSCcOH5DMzD1OKQOJCOfuIkX8094PHZDK8JMPhhA
 mXW6gQNKtPKQ48d9h3wfm9MCA/6mHJn7qhF7gqWEB4mwtpfoNocFHxQfaypYcNdKJ0RKzxchYxX
 w7a88llyeHUA0XfEvlGWFnkNlAKffxsxKjMFuVCZ2QGxunfKtpqeGgYAfakz+pCG2Ut6uSGclMs
 y9OoUHr8v6F4/Y0QstMNfIe6GZgEzBfzO7DSZjqXPxRCU3OlKfsW0Lfz73K/4ZSqcghir1XrJ0m
 o23gQSRJcZ7cUz3J5fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130042



On 12-06-2026 13:40, Vladimir Zapolskiy wrote:
>> +            imx577_ep1: endpoint {
>> +                link-frequencies = /bits/ 64 <600000000>;
>> +                data-lanes = <0 1 2 3>;
> 
> The numeration of data-lanes shall be started from 1, this has to be fixed.
> 
Thanks for pointing it.

Will fix in v3. On MIPI D-PHY, lane 0 is the clock lane, so data lanes
must start from 1 as per video-interfaces.yaml binding spec.
>> +                remote-endpoint = <&csiphy1_ep>;
>> +            };
>> +        };
>> +    }; 
>> +&tlmm {
>> +    cam1_reset_default: cam1-reset-default-state {
>> +        pins = "gpio33";
>> +        function = "gpio";
>> +        drive-strength = <2>;
>> +        bias-disable;
>> +    };
>> +};
> 
> Since it's a mezzanine specific pinctl assignment, it shall go to the
> correspondent .dtso file.
> 
> It's a concidence that one .dtso file is good enough for describing the
> mezzanine for two diffferent boards, but let's exploit it by keeping one
> dt overlay file as it is now.

Agreed, will move it to the .dtso in v3.

This also eliminates the identical cam1_reset_default block duplicated across 
CQM and CQS board files.

Will incorporate this for the IQS dtso file.
--
Regards,
Nihal Kumar Gupta
