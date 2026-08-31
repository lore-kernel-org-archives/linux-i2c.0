Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA53C3F5B
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160825; cv=none; b=Bps6UiyYF02+i/01vM7kD52mYRAPN96LOPt3/+SQ7LSRu8kKJ2/q9BdF5iu10LaIsFH3MupVKjNAaX9DHHYXJlY03M98xJmSnQhrqQC0c6jLnKErT6BFY6pqqKZ+M8j3dBbRUl5+pmqG9Ky+CJ4TU7MabhBiAYROpUNTJQAmF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160825; c=relaxed/simple;
	bh=h8J2NrchB0Z1iFN/dkUbMfkCPgIc00ZPMgcFXxFod04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jD786JwuzLSzp9+wZQ6mfrS7SOxkdCIR7Jt7lPveV653VCIsVKB6ksgwW5+vAPm1hcnRIoDxfw/KmY6io2OjcRrIADRaf31Sl8cfounA2ntbXJ2y9L9vazz9VV+p5Cowu51nymKr+2dF/+4QAuEJMwMi4zTsD3c6XFKZp1D1wRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+KK612L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LJ4PD64M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+KK612L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJ4PD64M"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52V8i2423213
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 07:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jp+hqQqMNpfps3DxX8HzIVZ5L4ni0RL7VXbNl/0NSJ8=; b=T+KK612LWjZUANeB
	VkFdsMWkr9eyhS/Q15o16qwql0zjmx3zVqavLU23rgjw75IUZUoeAw5IHkblRKn+
	7YzUSSJgv8+lF+kOZ2W6XWW5bum1I9EQ+RpOKDfct9vO11Ph6msTMLpc/ic9AYgw
	9O8Aw8paGd/LlJnIuE4ETOoGVuwYXXhZ+vb77bRI3rZ8QAVyFbCKjs8vRFOOVwqN
	jYcwONoZ8zLm1TjLaKsiTZz3e2FqBM4bH5hcaHomWo0mCaNv/8Iyq9WKBXXmSWeT
	sCT2wFUOep/7F5Lk8R53LQ532oQlxD+K1hDs2Mlg9Gl+3TG7dDe49k7ZK1lSrFtj
	9mSIhA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2d5fy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 07:20:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21be5bb4so6993451cf.0
        for <linux-i2c@vger.kernel.org>; Mon, 31 Aug 2026 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788160822; x=1788765622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jp+hqQqMNpfps3DxX8HzIVZ5L4ni0RL7VXbNl/0NSJ8=;
        b=LJ4PD64MOjmIEBA3fr50V0IqgyoR6uLn2ocu1W9O/3M1Iodo6bwa3hm6UXpsA7gsyi
         S2zXqygAYdWRbpJtEuo0U2J6ZK9qMwIRzsdNQCQk9AMhxB78DrE8a2lFx8idGT2XTK+w
         LuidQwE4w7TaTd4MZdCbO6yX72KR7kyrs3xZgH3DHDGlZmD+NV3HnzeQ7qO4ISajqaBc
         3B8u/zFpFBju7sX4Z0+yOOtXlqISofBouNbLQy3LOq550AzmketCWlH8puDokj5BuLzI
         XZtv+n+8fRqv3aq2i/1Z20gQTFBoNVrHeKyoyV43pewPgcmKhhA3dLEuvXK3pmiXm5Ev
         i0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788160822; x=1788765622;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jp+hqQqMNpfps3DxX8HzIVZ5L4ni0RL7VXbNl/0NSJ8=;
        b=BtvNEEW4KGRQCvuw5JW7z+/dAhYxC1GclQcCD+Y2xVwS3vq7ywklHwtJAkzzotWxer
         0alGzs+EtJ/ViqA9JduwAR6sBep3qWuc2VNJJXeU/ot2Qwbge7isRU9ZBdX41qy8Pv+/
         kZkbkRjNPjrNH18WmY9jp2OskbPc73bTZZJstq3JxqaR/JVoz1vO2zc82ECb8p8L0gWo
         34rGzDNH4cVPoHVYD8LSRbyQP6uejBcyv6N79MToHHCEQOJOGiMtlglRg/QWgAlIE+kl
         EsVQaoBIFLnjLYne++t9VJDbV3YRoeXy/4ZRg+vt285H4QwjxK0twoA5/rHnWfp0EXLm
         nxJg==
X-Gm-Message-State: AFuF++njvjTKjvX5dwx3YAy0xzK6+6Z0oAZdeWYUmTMjgl2jSPCEJqTf
	PjUT18szj9W4K1CEzc7oPm4LsmRyv4hP6SANJRFHfLqeMOOjUt/cdOe+NlclbjyCxbj4H8G9Wbk
	eePU0I4AdPrx/nbOObxgtEFY+apO6Om2qePeXyrZKUflysTTSZymFqJuCG6EWVCI=
X-Gm-Gg: AR+sD12s8t78CwOUhX89325Ts7iZkTE5/dhE0ZqFYuUWQBwaHfX5gMbt1sXRmmhHPec
	9s1ya4RD+RAPWkEdf6WCAgexnqSA2e5Osn9KQWcwI/MjjXwKVIJ7IvNEBUyYtOcxkoW4zMRpWxO
	RDgj9Qxejk0gzkFXEjE4kiBpOX1oddl42W0MWxo/L1ZW3OdZdZ64pupNmVTsR+NEqfhoZ6gpEHj
	cOo2Ee2PWcQqLLu2l4HtRkm6ifY4XNfH5v/UTHDLF6XhyPkIit+YmuhfuPuIjia54YHY4wPt076
	fzCPqGykSSRJ4e8xo2MeayvC2VYGh7wrvdSyhaLToP7I600KIcp4EvDt2yw46g79xkF3QHroae6
	5AcbOUz87r5xjbV/CHYDfSQ==
X-Received: by 2002:a05:620a:1b9a:b0:92b:7420:bd58 with SMTP id af79cd13be357-939285432f8mr771690685a.0.1788160822428;
        Mon, 31 Aug 2026 00:20:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9a:b0:92b:7420:bd58 with SMTP id af79cd13be357-939285432f8mr771687685a.0.1788160821970;
        Mon, 31 Aug 2026 00:20:21 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2049sm405315466b.36.2026.08.31.00.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 00:20:21 -0700 (PDT)
Message-ID: <655e39a2-88d7-4522-a27d-767dc9578aa2@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:20:17 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: qcom-geni: release DMA channels on probe error
To: Shengzhuo Wei <me@cherr.cc>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Wolfram Sang <wsa@kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Yao Yuan <yao.yuan@freescale.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
 <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a952b36 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FqpsaMCCsM1CaQCKzz8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 6KLECKB6zLamjiFgmvALSZTVk4OIRaVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfXzbjv/9mlu/GA
 G+B8Dvq1fzNyTNlz2CdGzmmFXJOPBX/8+taOFn7le8kxqAKdynsab8oYGz/Mjp6c/BF4RGRTy8/
 iu7IxYUdG75KoofPVxamEIkADsldti+Uw3gp/rFvL+zcbVxysvMcdRi0Z8L+FKoxQcTxsqCrN9f
 awsZRnznBgjnZJspIE1rDXDFM07/aC7OMTTijY9ikeJNPVhsiLqsGIQgQSjJ5zRqRdXgwC7IydM
 yMrlpvpWMYUANP9/QgdSUckNoaTrzD6GADbUAOelV344lkEvzhvPNWs2XicGEepYnAVlXlU+VC3
 WPSuJrwJiI6+9UgZAI4+MotPByVtX66IgzY8MYn3PAL5tLdIXa0Yihi3jgeZSJcwBMJo1YtE2Yf
 JAwjWRnsJrv7a/WnF7K0ufeAf+DT+NiyHiUK7ub1mgfpEELCZE2ro0jYbg6BAxquZVJ7AZDTuoh
 YSMpVQDorbBFn+wIhyw==
X-Proofpoint-ORIG-GUID: 6KLECKB6zLamjiFgmvALSZTVk4OIRaVI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfX4GsdSW608Sd+
 GOiEe6NXDujOJgjmZDED0rRMfG2V6nCa0LOf0dKiLJu3f6Jj8BSJoz+b/PVpebQeNaHCb7OnXUs
 vv96L20szrQBcOe7PF1lZskLHz+nVic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310061

On 8/27/26 5:43 PM, Shengzhuo Wei wrote:
> geni_i2c_init() grabs exclusive GPI tx/rx DMA channels when the serial
> engine runs in GPI mode. If i2c_add_adapter() subsequently fails, probe
> returns without releasing the channels, because the remove callback is
> not invoked after a failed probe.
> 
> The adapter-registration failure path used to release the channels via
> its err_dma label; that release was dropped when the probe tail was
> restructured into geni_i2c_init().
> 
> Release the channels on the adapter-registration failure path, mirroring
> geni_i2c_remove().
> 
> Fixes: d8d3bb127ad1 ("i2c: qcom-geni: Isolate serial engine setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
