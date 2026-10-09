Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F5C479884
	for <linux-i2c@vger.kernel.org>; Fri,  9 Oct 2026 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531159; cv=none; b=nmWVzjKuq6kLwYqMPjDcufRBUfXmowkNIoA4wEFhark4iGwDGD+iCOX1+62oOR2QlmAvGC5Cy0ybQmqMw1zx06uNDxqsrNAg1OuirUHWRwLivfIkBZjsOQ9P/sqWS64pkCWPmVbQMyezrHHTWNsNBnkA0W7W2/v2XnRXyTwf/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531159; c=relaxed/simple;
	bh=uG2fvXOs8Q8N146YBhJ9OV5ZwJMu4rQIyRcslPNQR1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqXPPa8n1JGrd2BB7LIcQ2/B6oVUDIlsHr+xFOhM0SbNyFHcSeAcySksbR4ciHok2o4Zm7I0kEktT9Tn6NiY5aYiPVTzS87xBuxUPCBQU0+Hzy/8skPOqsfNVHJFUED1ofzMeMiRjHWOYdB6vg13l7SwyJ8Jv6WOP08N3wLpepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNgIieMR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wpth8HUx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNgIieMR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wpth8HUx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HLLw3768939
	for <linux-i2c@vger.kernel.org>; Fri, 9 Oct 2026 07:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z6HnU0h/lQqsemsQrOUQLb2l3ikDGLSW9b4T05Vtskc=; b=bNgIieMR3fi4+lYi
	Zx5jKmnTvCcSO+VtGCiAvJeLaHv3Wesg5+QCK59mAi3P5jUdt5QZqqaypdKrdCcP
	FQzqIMsmc9qs/4x91JOCG+GxNn+pkIUh3EqZq7IZ6jGsFgUhhkiQDWGQz9dSnw9X
	a1nrnHBVaB6ZERt9g/Dixql6A2n9bbYxTJ/UrqFyD7DpL9ACzbuOlchbDsqKJ3Oe
	4avbPBaurH2bSxDrt+lcjIKi0kUvjKk6qAaQ64G2sPQfCb9J042iU2aAsE9UQ005
	nO5JP8U+AjOBJyPHR0Wd9W1GihBdJtA4SB61J1vXNoz5CgOYhk6TKRoGUvHAqV3V
	GN5yBg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu2f3b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 09 Oct 2026 07:32:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1eb205d31so6786111a12.2
        for <linux-i2c@vger.kernel.org>; Fri, 09 Oct 2026 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791531156; x=1792135956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z6HnU0h/lQqsemsQrOUQLb2l3ikDGLSW9b4T05Vtskc=;
        b=Wpth8HUx+9H6jxSoOOJ8+zzcHsUKDPyNElMu3+l8cuqCQ+fpuBI6dNsM5VOQ1zLKwY
         MsKm9fWjvvZUUf8X4j2dewrSsUwf6Edvhqhb22czagvYAxFmykoAueAT8NKzGkBw3yl2
         yhorK7BcaBVwQt034JWtJLhuOQ4SUnJu6RldoZ+1VeSFaBpmT+CCe/UrbwziMb1wS4zr
         +lnawecHE4rqwSQxEgcavzeFY5Q0NGaGBpKbE8mLL0czb2Mw+mlLaNfI+6x4zyJqUGir
         oDyFssSrIepEJfZdDFLLewPMCp5mVJLxdtU5WOGQShh34gPsR/sAVby0Ily2zOFEpCaF
         1Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531156; x=1792135956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z6HnU0h/lQqsemsQrOUQLb2l3ikDGLSW9b4T05Vtskc=;
        b=aBHrUVK90CAmw38w7N0BKRgl/J/lpTTwAuswKolmQNxMyh9wYxSbXWJIoE/cHvuImN
         KRZZIw8T47+zyib2vT5S6FektIZFM+KJIslY1wmFBGp/tnxP+XtRQXx/Qq8BU87nDEZ2
         kYOmFrj/10ZbVvnDRYKX4fzN7upjhK9teqv2Je6Gl0LT3vSRq3Cq5XD5oqqHAU+GVZhx
         aEv5Xi9CcCuSA3R7sjMw/J5jMLJFUE7Mhn1ZiMZ/FENcnUISRVDO1udqLaIRrV0TEJ8g
         ai3xJFwBhOW4j2j6LqA9P4McZdJP88r3vOVYhIiMVzYvoxqxsx1O+nHcuXDZcsOd1ewL
         NfQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcxclVXPtC2MNGH9GVZ1LZFpKCjagy2pReuzC7B/SMDYdeTw4Bz0QVfjoskt0KcheIQBNL/HrkBAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL1i2JciGX9sIm7Rty02tcUQBdScY3e2Yza847VSc3QiHZvRHzd
	bIeR9AyTIxRqA55bokf+TMuEyxQTJay3lM75GF1+O7x8oid55lfDqYCoCUH9POj4siRJyJLX6TK
	i56rAkfPyQ6fjjEcQr2j2bYueocBp7NEAi/r8bfEJ3p+afq+ZMHtVDCbWeStpQT0=
X-Gm-Gg: AYBFou2QvswSKp11Aic5MuPIHGuMSjCA3DY9RzLA9ZlTXN4QTJeyLyPGTj6GW62hrWe
	5M4d17UZzWp+T3dkz3GpcyFqkkZkJxwozR3BLwpkU5Pu8JHnsokhK5HlTDqEtQTzOAGV5Epm68j
	93sMiVRVl69niiP/LjQbdpfzxq3EjIURZFeGLMOQhcv1vjnAq8kcnCbqQ2K/krzRdi0isP6HAgU
	0lCs9je5JV9YzNWOeQiVPJkg747gZAIdJIBAb6n0MsAmXzTzD7SWmR1Y1tozLJQvLlWZ/hmu02n
	K074FuOkgK2cTcnfP1HHz/HfW0uOwHVZdm2EL5kCOo+hlWCSOHJQavO9w4wzObY7paRwDXuicVX
	uL5SRqdDsl/efVHIMyw62gW1ETgsGDsFq
X-Received: by 2002:a17:90b:268f:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3ab3a778a55mr1089549a91.32.1791531156178;
        Fri, 09 Oct 2026 00:32:36 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3ab3a778a55mr1089530a91.32.1791531155710;
        Fri, 09 Oct 2026 00:32:35 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32c0f59bsm1435629a91.0.2026.10.09.00.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 00:32:34 -0700 (PDT)
Message-ID: <778f15ef-5052-479a-9b45-bc3821b205ae@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 13:02:25 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] i2c: qcom-geni: Use common GENI resource
 initialization helper
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-8-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-8-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyOSBTYWx0ZWRfX/e8yTVHB82b4
 nh0wVSAAmXEsc3jAG25F7zjzakFyIQ06SROs0JuADZ8Inc8idbJni1blsFq+Unvejz/wry+AW2n
 TNls5ZxjnhmUVMy3YAqJnKvTPVRX/yaVGH08RHHCcwyiKNioMtE1w5/mYnAeIklL4jYFOz2QI0I
 vbtwIqvZVz0e2xu2mzP+/HrVQC2hDTV8fbQV65ku731IWWIbXRqtRmkH3nqZaOpKFtDfn/oz3jx
 WWGOk0nrYIfMkrte4/MJ1DDMdLv6MLkhxD0ngKt1AcucNyJ+UzAPdTic57hm92HmiigbgFHpZSj
 MqwdCDZXwBhQ/jiPkvbxPPzdLas9b5gk2wwDPvv4faI+dYBcEIvEX304LbfB9ROdgW44pTxLl8y
 UR+jXYMuZAYivtLesvIoSohVpaX9ruiNGc+A/xuLjsMPunEOk3+hlPb8HB2JgmVNQCyHaaQxFeG
 eqZq8qpkFAHsWFgXvOw==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac89895 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hk0YJ0Y5ifG0NBj8Rn8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: W9Hl1xHUuw6UNDXcHV2qxbAwx8TkKnkF
X-Proofpoint-ORIG-GUID: W9Hl1xHUuw6UNDXcHV2qxbAwx8TkKnkF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyOSBTYWx0ZWRfX2v6D3wSe68vG
 ig6lblGQb/eLGzfZrKNC+/Zv73HtqLMKowlV8tgBfJmXcIZUeeOcOQhRmwOBZZo6L0THJzlPKKV
 A221PKurt1TmFAS9k0LHxpic/1/MplQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090029



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> The driver implements a custom resources_init() callback for clock
> frequency validation and bandwidth vote programming. Neither operation is
> required for resource initialization itself.
> 
> Move clock frequency validation to probe and program the ICC bandwidth vote
> from qcom_geni_i2c_conf(), where the bus frequency is configured. This
> allows the driver to use geni_se_resources_init() directly and removes the
> I2C-specific resource initialization wrapper.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
