Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A92AD03
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078862; cv=none; b=jAHoN5IkFLek2LqyErFykxylymcWs3yTkriHC04rHXtwNPv0NXvaPp+Fy0l95i9QWTRc74dGdUcTunDZxTiRoMHinjTtjc8kp6F82wbsag+622UKJ5yUCEbsLKGLcn1rugirpikyL5Z9AHcUs6Wfcgs5p9bRq3WI9/0Of5q1xow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078862; c=relaxed/simple;
	bh=I8Vgu2r5M8y2he7cvzYIotPPGMHAHXOfqg87h9oOn/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5/wrPeFOmoMVWI7rpCCGEc+Gt12SsCCvYPJcbXkKVBXoaY62lmShCYonpxr5Qi06MYGKdHGQnPwjl1Ed4/jMxtNJwuARy36SC1iBty94CCtNnMyeGCZiB7bztVWh4SnAqTuEpQJ9jPWrB0Q0501JdyKizW1ymugbFya/l6i0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9GFPg6K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fT4hqLsV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9GFPg6K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fT4hqLsV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7SBqv2277806
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fn2DLbllwBRWCyP89p4f6qJZOYmaYmMa0wM3w2CVQPo=; b=P9GFPg6K+o4NQaJT
	sz7Uh1WmDz6hOXq43d+1iZ/omCGeppt6pV+gsaCvkkJp//2T3LeabmA8/1cw5RVQ
	oNCaZjNLl0vOPxtgtVz4zv9DhuJ/DJkzbiAm9ciCsxe81oE+qgwxpC9F5fm9M2Lq
	axnDugCqa5CzJjcI3hsI2MzX+Du2R27fQKYuX9Jdxf7wXtYeXfIR0g4Efc7rMGB7
	wMa8AIP7a+G4OFK65Ff2ql+iFRhieN2+jVv7CQyY6k0CSPIsxMgy5+wC26pJ5KkT
	opmnBSfu+7FRkmK/XQydkK8mPHdzJfs33cJS9MGGGtoIuJOGk2Gqv7PvfT9mJqjc
	NpYiyg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu7fat0hw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:47:39 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89475e062b0so24281336d6.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769078858; x=1769683658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fn2DLbllwBRWCyP89p4f6qJZOYmaYmMa0wM3w2CVQPo=;
        b=fT4hqLsVDofsfKmyjmnTW5qbrILPLU0rjvOJhIeyg6KmkgwKztS1g+gK2DbLbp4MDW
         Ugo6mKt5/GZYXMPF8HFf2HBSR5rBHs66U5m31KIUe1GZbw63Ap2j0H1nJr0eZQN2IG+1
         /Os9T1t6djScJoems+BoSv9eVLoIao4PBaJgwzVkrAGNm4BrssIrFrnuQlSgrsxGjACK
         LbRKvLiI2tG0MK+MRVfyzaMY57RRTnwSxN821oAGYnL8dwLFb6uXM00CI8G6A9BEtCMD
         qhpwXVp2zw9G4GMKP/syk9n886edHd636aGnE6tUgFBhsaeK8o8CcOxVtcijMY359Q2l
         autA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078858; x=1769683658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn2DLbllwBRWCyP89p4f6qJZOYmaYmMa0wM3w2CVQPo=;
        b=uz/xHGjbb/qMth/WgytfVLvImNH4Zb6hT5JOICMBIcbaDqBg0GHwUEaaY0UL7Ry2zw
         vHHdiJgwr4C+3wPq93Al0lxcxxy7qrmPIuYHcWmzzDyPgiNDlqw9bIsGrIILx+o0AYBz
         9PCSbM9nnxA8/TDTRx0CB1j4Uoh2NyjutxgDWUxUl7WHeR9p7uq+fGgbGoBhO4nuUbg+
         YxRqUyFbmv/oZ0ibuhFYmsJYM0n95bPW9ODZNKt5viTwIl43FJJ3q3688TvRXzgXHuV5
         /5mpV7Mix6krZLvRR29YaaLTvRa2RTxl5q08w8jpiZrlReQw3LhBzKAKq4n0GuHU93Aq
         TMDw==
X-Gm-Message-State: AOJu0YzvWrSeDZl5NJ+TfJeluim0VeJiIBxEymz7A2Se/U3uMPCxfXEY
	JGXaS3oORBuru+fLz166xyjuHaIG+Bjy+iQMs0sScq/S0oOG6RgdMrRxJkmdDza79I4I3cYbeFS
	SCAo2oFOQPf0kgGkEoW7H4eY7NoLQnGsLTs5pviOiPV4MClLKCmhN4a93xlP6kx0=
X-Gm-Gg: AZuq6aLPMZVk/vIZckZzR5Ii6SWFCdmjdHXNRjq1V5H/68UiHY94GQmIQANAWtnFjX+
	yawuk5J83BHDYeycy3N5BR2thlafFfQWLn/w/l8rxt9uEnxTjT++wHt6HLPa5IoZ2pzKjuLlAR5
	+MjifFtZ1mIiQeoSFMMipcgwfTJBKP/R9ho9hq/PBFx2zJf1/NhxG41BV+kvIIT+E7/XKZ5AoJk
	rReopuFKh4nLcdIL9BhfPuPEYOgMcYoQgVK7lwgPFAl8VeXnI0KvQ8I+SiJ3qfWWro9ScAWL5xm
	N9KdXZaCA4DLzNI5C6z+t2oITmGYs9/K0pqj/CnfZNx0/aC3m2H0poYmvC9xGsRN3uq5h/DUtkO
	c0N3msO3SZ+CQmFff6XMiw+Lgul/M4w3KnoHMPPs40N5ppkkzH4Wn5/hr9hwKM3ookKj9e0ROfg
	==
X-Received: by 2002:a05:6214:495:b0:880:5883:4d23 with SMTP id 6a1803df08f44-8942e2c8ca5mr306938716d6.16.1769078858024;
        Thu, 22 Jan 2026 02:47:38 -0800 (PST)
X-Received: by 2002:a05:6214:495:b0:880:5883:4d23 with SMTP id 6a1803df08f44-8942e2c8ca5mr306938546d6.16.1769078857539;
        Thu, 22 Jan 2026 02:47:37 -0800 (PST)
Received: from [10.111.168.218] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89468d65eebsm47770826d6.30.2026.01.22.02.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 02:47:36 -0800 (PST)
Message-ID: <613d77cd-1ccc-4a5a-9090-ee4d65d3e4c5@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:47:27 +0800
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add CCI and imx577 sensor support for Talos evk
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
Content-Language: en-US
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrx72kTS c=1 sm=1 tr=0 ts=6972004b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=BqitQj2KRPiQZ0QKAcwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NyBTYWx0ZWRfX7LffRG/6v3ZI
 SzJL8VS6kW5vlXSSWrbLzQRon+D/tqD77dif5U3kz0ki0Wv9ZP66uDlnfP7syzYopktA02qdhgq
 XQNLv2CihrBsKXMw6Y4MtoTxlmwuWfyftLnvAnm6IwBihZZWPuaDZ0SbhAedlw6Buys2NVzPSxL
 YGJJzj5ZJzWeaIv3+stoW9wG+hcSHJmGfPB6zz+KuV1vPNGeGASg7OKGOT0A4LLjsDwlAogQe5G
 xlT34aTp5vun6HSd6VN9L8L7EC3kFo5LRVOii19AsnEyIK+SYbJcdVWrI58Sa53/bh5qJrMUIr/
 IlkAd4qhbFuDqhfm7bqjlGMPEBH5oOR6nJn3SWrWkfojnLTHx/wMC+5f5UHxABQRXLgwt5hoQcB
 L7JQa8CO6dogKAWVAu9yBfF32OAqHDw6e2lvaOIjFZ1XHLLO53RgOBguToxfcc05t4JqA7Z0qd+
 K5ci3iZAtq/5yWideAw==
X-Proofpoint-ORIG-GUID: eNCiYWp41PiCNwrhrRTnieNqpSZWs9-d
X-Proofpoint-GUID: eNCiYWp41PiCNwrhrRTnieNqpSZWs9-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220077



On 1/22/2026 6:40 PM, Wenmeng Liu wrote:
> Talos EVK is  based on the Qualcomm SM6150 SoC.
> It lacks a camera sensor in its default configuration.
> This series adds CCI support and enables the IMX577 sensor via CSIPHY1
> through device tree overlay.
> 
> We have tested IMX577 Sensor on CCI1 with following commands:
> - media-ctl -d /dev/media0 --reset
> - media-ctl -d /dev/media0 -V '"imx577 1-001a":0[fmt:SRGGB10/4056x3040 field:none]'
> - media-ctl -d /dev/media0 -V '"msm_csiphy1":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> - media-ctl -d /dev/media0 -l '"msm_csiphy1":1->"msm_csid0":0[1]'
> - media-ctl -d /dev/media0 -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> - yavta -B capture-mplane -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0 --capture=5
> 
> This patch series depends on patch series:
> https://lore.kernel.org/lkml/20260114100043.1310164-1-tessolveupstream@gmail.com/
> 
> Changes in v4:
> - Add CCI properties to the existing portfolio. -- Loic, Krzysztof
> - Modify the incorrect dtb install configuration. -- Vladimir
> - Link to v3: https://lore.kernel.org/r/20260115-sm6150_evk-v3-0-81526dd15543@oss.qualcomm.com
> 
> Changes in v3:
> - Add generic names for the CCI clock. -- Loic, Krzysztof
> - Split cci node, removed double space. -- Dmitry
> - Rename camera dtso name, add detailed description. -- Dmitry,
>    Vladimir, Bryan
> - Add dtbo-y for dtso. -- Rob
> - Interrupts cell change adaptation.
> - Delete cci sleep pinctrl state.
> - Link to v2: https://lore.kernel.org/r/20260106-sm6150_evk-v2-0-bb112cb83d74@oss.qualcomm.com
> 
> Changes in v2:
> - Modify the CCI dts style and commit msg. - Konrad
> - Split mclk change as a separate patch. - Vladimir
> - Remove clock-lanes. - Vladimir
> - Add mclk3(GPIO31). - Vladimir
> - Link to v1:
>    https://lore.kernel.org/all/20251222-sm6150_evk-v1-0-4d260a31c00d@oss.qualcomm.com/
> 
> ---
> Wenmeng Liu (5):
>        arm64: dts: qcom: talos: Add camss node
>        dt-bindings: i2c: qcom-cci: Document sm6150 compatible
>        arm64: dts: qcom: talos: Add CCI definitions
>        arm64: dts: qcom: talos: Add camera MCLK pinctrl
>        arm64: dts: qcom: talos-evk-camera: Add DT overlay
> 
>   .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
>   arch/arm64/boot/dts/qcom/Makefile                  |   3 +
>   .../boot/dts/qcom/talos-evk-camera-imx577.dtso     |  63 +++++
>   arch/arm64/boot/dts/qcom/talos.dtsi                | 279 +++++++++++++++++++++
>   4 files changed, 347 insertions(+)
> ---
> base-commit: c8a4a774a9b0d2c86593492625874e27e9cbc9a9
> change-id: 20251222-sm6150_evk-8ebed9e9f3bc
> prerequisite-message-id:20260114100043.1310164-1-tessolveupstream@gmail.com
> prerequisite-patch-id: 065fda916d7faca61113e1230fcc0ce3916442fe
> prerequisite-patch-id: eddd1b1714715707d386608e4f9b24396f51cd44
> prerequisite-patch-id: ae777d7e17e32afc36fd1f741bb57ff0d3556841
> 
> Best regards,

Post the version5, abandon the version4.

Thanks,
Wenmeng
