Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580610;
	b=pcPQ4Pjt+FhDRJqySWivPJW3ekP/bd10ICmXbMUusRoi51JwWLY+isNEfbBhVVIWwk3s
	 E9TtllDIDvNURFD+v3/OzU8sHIwUKstmKdrwXgqMhYOkDCbFGnQxt98T2y4OYNyJp2CRV
	 8/VQbfnAx9bSzNCFrkmiUiTQ5xd0t8AzjfamyJ5l6+V1IPQjVt/miVZQp8Z5rUUowSZ6k
	 S7zeX9+xtZLQ66XSU5KIXTiEYJXoBGbB2/7U7OZXxT9Hh+CrVuGwWgaVfHczvuRfd2RB7
	 sL+P1Vc3EP5yD0sb1gNDtjKokip8sYZJ48E2exus1inVT91XnhuC2FMHxpurvBx7Oew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580610;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Uxja2CBhb1mW7NZElmgfeGuVVftU5XvBGnIy3eg6OFg=;
	b=om3DkGVcrM0EFWnNa1gziNokWGu5BbfxS+cLUrilsBH7KaOHqLImqODc6qxHIL4npLpf
	 9F8neiPPCgyfBY1AjM81JvSdlrDOHr3TxuSTOHQbEv/uESN13fJMdZLzp/Kq0Dq0c4M5I
	 mtGufn8hFK3TZj16GKNqcEIQIDGWTlLScZ5LMEZM1ZWC3KLSTMGuOAaq12c4Pj557mYtQ
	 DK0D1dZdYtCycHeqMzKtQEzAqThgiUp8zjJc3N2qSirbRMsYWrS12jGG7+zfsgtQHGobi
	 zUcCcCuy1h777aNEI4elu/ci2s5cVhE0ZAsc05bjoRMxe8uAXKDT6a5D4X84dEt7weg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jtZ1u0Me;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIF3rYd7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50192606A31B
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 11:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50192606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jtZ1u0Me;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kIF3rYd7
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA5e9Z1356947
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 11:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uxja2CBhb1mW7NZElmgfeGuVVftU5XvBGnIy3eg6OFg=; b=jtZ1u0MeTrjqFU8c
	IzBl+Y+eSRCLuajfmBB0P8Ae1BXi0OKaPZjAcTxYqMPTya75nAk/x1yJVvCJQeog
	f7OHeSSuqJHol2BUalk53HaZWPOT7b7RwbGUA4G8BCdfMlmvA+RMgAeOG9fCCN4/
	KxbCbu1C5QWJrKQYFDFmso7AF4pm7fR+MOGlBl/mPD2UsfOMriOAWsWa+hNvgSrq
	6c+DZpk+GcPZou9bnH5cnyxInjnM8mg6RA51jPs137BuiagQ07d0mdddZ/kTf+D0
	7lpR8bnqqQkfWX1Eaqf5QRa+Pgt4YmXkaRjrqKlR04EMm4hAOdwX4XhzBF7n/4Eq
	h2SMGg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4ujt7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 11:03:29 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eabe7151daso14751e0c.2
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 04:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792580603; x=1793185403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uxja2CBhb1mW7NZElmgfeGuVVftU5XvBGnIy3eg6OFg=;
        b=kIF3rYd7X2vaNTSo6aH1LWwTeHK3ZIMtr+cNOHG2iGyZ4R+6yqsdcMYL1IseBfLCTG
         9u28SsLYgRRDXeF9NtVdF7gn/zYH9TnMtKQ036C9/qTMVkH2ph+3Hg3/FLVtSWom3hRy
         FRuSt1NTrI7MALlGEoT1nfagPh+ogrpLF20Z8bezrCoIXSf4Mx64SNYzJlvu3R9vhM/o
         1+NUE1f8bss4dyoh501+B9pTQmOYJrVjpLl/8bvk01UFAUTbSuW6SRiZgnEZjMKo5yoF
         JTI/17NyYaWc8smB05fAy6WBxSSgzjqy/VheYBca6O96I896f1jQTGfUOs6u9Sr2z/1k
         VxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580603; x=1793185403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uxja2CBhb1mW7NZElmgfeGuVVftU5XvBGnIy3eg6OFg=;
        b=nfZt45Sjw0FqLSqD26yYIASXcBbgvR67SNMfvGx4lhkQGr2Z0/iT+GZmlJhfaSDTDR
         bBmbe6DNYNaS7kGpmRt9W0t1RclL9sn7eo3sYYvLHJf57BExJ/jVd83YBXpLwdFdvW+T
         RAxNEgk3puUNqx/xLzPyuoCzJtvZGfWI3VSdrESnweZCXbEAobgAuh3wS5A+7PO440og
         zAObpWx/Sze9/TH0l7S6shvTJSUS6ZLYLEM5toKYjtnzBPkomWYz77zlIRAec1kGcmtr
         Ml+nHiTtrTrsfzZ9HizvvpGre85joA6UHfVfidXF8JCyVUHBzijVC7l9Od3x+oz0DVvb
         rEkw==
X-Gm-Message-State: AFq9FYIDChkjXX3g6ubNI0lDsyTdNmpIGHra9leBfR6bXgCz0Yjo+ygH
	FRq73KIEVveb2eaZrxAxifgYu1sZrRAiLTsrvLjNkXtZvNuIw6H2eqW1ER7Dp8qgX12vC9qPSSv
	bl7f4EVWxYpiBTehZwit0JGxk6pbuo9+BwOGZ3U/y/5iEOO7k2wY8f2sUwhlu3SU=
X-Gm-Gg: AYBFou2vjnVOxIFNXhFsEdbJTpu5v3yinMmMyRxWeAk4RJCnPNVXIIqYiKn+utEVPeX
	yi6g2TVATt2laRvAdWhdTpeX3fpK7CcwC9oUeI8GbiSCRgN1wEBgDB4AT/dYmTq4848LaVLUtM8
	tOgIVQSGzMxyVxJvYnsX0Nj22mwHkzHz5QscGvszYavLaqO1yy1JaHx1x/AVtUZucsdj2LuNWoI
	qdeiKnbnf5YkLgi/5IalIQC5+lcKCoTLZt10yF/xOteV2/+7VHTrQN6yC+WWIXFqrnP6ttjSXxj
	B9904DGADXoKRJfaX8wJICUkvju/CZcxMI7Vb9a4vVWS2qUHH1mbM86YGEPvYoHy+dWh6t1NQfy
	8Om+KJHdZc7mAMAWDG8CX5A==
X-Received: by 2002:a05:6102:3c92:b0:7cc:174b:f7b7 with SMTP id ada2fe7eead31-7cc922532e5mr441386137.0.1792580603044;
        Wed, 21 Oct 2026 04:03:23 -0700 (PDT)
X-Received: by 2002:a05:6102:3c92:b0:7cc:174b:f7b7 with SMTP id ada2fe7eead31-7cc922532e5mr441345137.0.1792580602582;
        Wed, 21 Oct 2026 04:03:22 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678f78660sm65165466b.17.2026.10.21.04.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 04:03:21 -0700 (PDT)
Message-ID: <42b2b13f-5d56-4668-bb26-c4623617f4bc@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 13:03:19 +0200
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
Subject: Re: [PATCH v3 7/7] i2c: qcom-cci: Build command words with
 FIELD_PREP()
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
 <20261016-cci-imp-v3-7-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-7-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nD3vkbF_ztkLx8DFq7DI-68M1qCsRU7b
X-Proofpoint-GUID: nD3vkbF_ztkLx8DFq7DI-68M1qCsRU7b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MyBTYWx0ZWRfX2AcrbPHY+t8t
 DUdcQMFBWpAFexqN8uYCTbwZJEPN6yZAOzXUsEf4fZb1h/HAb2whCh3WHWoAue2mwoopRLwImX5
 wDVJ+HzfzaCrN7EY0TEAaUsvcbG0QvI=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad89c01 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MyBTYWx0ZWRfX/1qkL8ngQy/q
 5iDt0sbGskF3124c4bRFQC3ZjaVmqFNxG5ueNvnW4Maz5+JzCzekTeU+LEkh9JzA/ZrlEsqeotx
 jV5xZaI5N3YT1LJ9QJTy8GMkw/2ErC0Kbvd7q0hKV0Dxn71tZZA9snmGg/rIr757nUKZMfQMrRf
 TfTADhfA4hJpU1iFf8UANjX8OsKAsDDr4gXxhymjU0XITHC3JVPY7qdooxnfjeF1nmJBkT/0otq
 UiVy2DFQJpM5dhtZrGpxS2GwuYW73lB2LuWqtqXcrNZ1H7EV6pMkypqfUDV48HWGOfeDy6riIsj
 BcNSeJgF/2rPWbiFsTj3BsvG10y3/RVTIDcKXXG2nHlvdsoUPZrqwSsRM0YGTWz5clOz71ydxYU
 GcvEpOFpoPuwCDIYh6is+K7s+D6HRWQCNody780feJerOeBWIQZGwiT99SyXk4PtuR3z+3bF51U
 KGcMc5marEczrrBSqLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210043

On 10/16/26 10:00 AM, Loic Poulain wrote:
> Every command loaded into the CCI command queue has the same shape: a
> 4-bit opcode in the low nibble followed by an opcode specific payload.
> That payload was open-coded as a bare shift at each site, which hides
> how wide the fields actually are.
> 
> Describe the fields and use FIELD_PREP() instead. No functional change.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
