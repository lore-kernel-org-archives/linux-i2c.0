Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01846D091
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054386; cv=none; b=VbQ05nn4aVVe10oE9+ojwf7RMoynI5YmZ4qKHCKM114NYxADwwEfqmnIvwufJxZrEVB8SEJjt8PYQccWcP9pCFeKiUq8GFCmqoFHc6rd4mqsB7Xb99fkCGAYB6IlNxKMfiFM98o/1UNaqQtplCcogXPwJ1JP+iCasJJ6jptxsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054386; c=relaxed/simple;
	bh=qNHziLb57Bey3x9iNOwGfk8XQT2SYeQO1O0R4qYBQ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlNk/rLh7q1/Z2zKgZNvcD7pGLDRMfLlfvBECLgTqlEc2EUMRpy9pukg5r8pItLw49Ji7Zt2NK6W+O8adGfjTBE9ZRS9O337ibVQAshwxhWa37mWMnWh+bSARIX0UVcaZ5VgSnCXdQ+1KERClfCHoYRLN4xuTeEkUFTrhLI3G+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kWCt78pz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cSAf1Iyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kWCt78pz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cSAf1Iyt"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABfaG820133
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OppMlgDZ2oFz73F6XSfRcoFpxG34E2g2la3nu5hF/kk=; b=kWCt78pz9fmtZShQ
	OC7Xu00E9soxM2umLaV9T6PutwQvtNXktN8/4a95ao7m9X0YHUQQ+eowSeydXW7S
	uhZunvVrKZzhJtwEdaeONdj1OtDGjWMMpH+F8ZwM2La7gt0xTWsLAVVMHBgaP92q
	nld6CGfwu7gcMMjFo4JPGga5mINmZFQv/eSqM0qvWNyXBOw4axebvWCmMZoC7Tjl
	PX9SsdxhmPWpvGMXP0M8QN5yd/QDDbBEPq9NBOyTMuWO8tN/gf0ze9wBx9Do36iO
	NAma1E/H0WXtM7N0g0LsV0sqaI+ZLE/09zLShnWjwv8I5Haf0ym3eQH0G/EgFS15
	3SSPkw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p1vdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:59:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfa45b280so1058881cf.3
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 04:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787054383; x=1787659183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OppMlgDZ2oFz73F6XSfRcoFpxG34E2g2la3nu5hF/kk=;
        b=cSAf1IytSZIG1VWhiBrOVaw5hlGH0nkdh8AIvcdKuqHVg3hzfAsdT+u4h+EM2I+bgL
         AV2K/9HsEvyycQhhpGD4DbYjE946kUwVOq3isaoy93w3il+4F1f1GFDbbDOduv2hVH6O
         KyGroaiYlvjA/leSsnvCoALF2PfUqVr6AFbgF/HlxkEjjfp5A7T6ydR4cWOyW8y+km5Z
         3hkiO6peR87k/vD0xF6/UIYlmYTEsTyKrWHpJzbKp/LK5nliDSQiii2glSprinA7gJBC
         IZJhql2nOnCK0WCakLuoyHpgKmE5PWLv4Ym8BA4cinAlhZoiLTRGIyrJlqGqg+D/Zn5D
         0bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054383; x=1787659183;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OppMlgDZ2oFz73F6XSfRcoFpxG34E2g2la3nu5hF/kk=;
        b=VVbj5BmkXFdwUNtkXriW77moCc6n2O2026MOVYxoNDIi+0kK8a/iwjHK7jRKriA0u/
         0sqNRx5U89VTFfN8liGCm3G8Godv8MeXjIf6I/PJ99WCvjd+WUTiw0KBTqBnAggyE1K+
         nO+w89tc9KhHbbn/YcoDriQFsuUYgG+u1jOYW15r7T1GHHIty36dz2X9Ikx5En5sIYNi
         xHnpHwGzczdG487DL/mzYpybR7YPm1qW5Z4df8Z6GmE795P/cizgFD0zBQstuV1ZxjAV
         Dy2B4tjnPFm56wTs1ylYHxlcmfEOpprp9u/sSikMQjc/rFujl+45RcGb2htibF0tExDr
         GeEA==
X-Gm-Message-State: AOJu0Ywt6LNoGgDCSggwWweZtWJkXGlWF3DwICc9GKgRI6qFjokekEYz
	qdRtLPAFYXDW6rQ3oz4vUZyFTisFwXLJ+ByuOuQ37k5VAFLzJn8DKp8hkmVVIEygAR0iqzhGsWg
	f6OT3JfjLgVYlb4netXcWd951XdRVDXfOfr2tQY6lw5/6eRD6JEQF9XpjFWInD2I=
X-Gm-Gg: AR+sD11fJDiqe1UzmU6zu5aJBXA8xJqBReOUTCsBzCHJc6+zSDXfYqlJFLDx92WZ15W
	oEAa3PKJV/2Dr3dF71V5VfwI5plT9sPoApt02sXokPSEhc2ZpY7A2l2BL3lEMUZLsPc8hS05Yk3
	k0JAFVMb5iSgrlRiHKP3KcHEMbDyIWzfJDahbHR1AF5NvXDQfoFZ1CIjK4fujl5zGSsbWYhMwxQ
	ZSoNbRNefo/NHJg0GyowCWy67R+GvnnLMhZjbWOSI0BoEKqzQJX7S4dypaqKUuNgiCqIpM6SErM
	C1bTQ9KTwMpX/FINDIUiVDl4g9ShqSwNJNb6SBMtEGDq+8xbL1MAjhowqD6xBqVb+huVD7Lbb7O
	/nXfzpOtYwzxs81thdh9OiIJv
X-Received: by 2002:a05:622a:118f:b0:528:1ea6:eaee with SMTP id d75a77b69052e-52d852b4f2bmr219968941cf.1.1787054382751;
        Tue, 18 Aug 2026 04:59:42 -0700 (PDT)
X-Received: by 2002:a05:622a:118f:b0:528:1ea6:eaee with SMTP id d75a77b69052e-52d852b4f2bmr219968691cf.1.1787054382179;
        Tue, 18 Aug 2026 04:59:42 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d859b274sm1656312a12.25.2026.08.18.04.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:59:41 -0700 (PDT)
Message-ID: <eeef2c57-872a-4b8c-b781-54fb8d1db9a4@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:59:38 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] i2c: qcom-cci: Support per-mode CCI clock rates
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-2-e1d80da54e01@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-2-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RR88Kc-Wc4igE9vEqr9IjJrbahIuDsr-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfX0gn9Yr0YnKa6
 g3xyDBy30xSKm4xdh9zXBiLs1cdkyukuPVqdHMIVMbZgrp+5BDJWgGPthrHRiqKmxtpF7uc/wYp
 J4Ml9RVK6sX7ssKDaeTWa0z6mqZ3ppY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OCBTYWx0ZWRfXz07+tSV1+xvP
 xM7JWrqv7BU8/2tLbCc4KtNqfbWFwoq3vgvKzfwYRYyH02qu5phgiq8nyZHxLt6P2bQekH0z5h4
 y3hRkqa5SC8oTRCUoPe0Rk3MbiDhG/Un2s6kHne86GbMnmaxzJOtF2rSgz8wXNTMmRCtf+439pt
 jd6QNFzSbEHUQAB0GUQHqXo/08B04co/WWglwkSUqV82Te8wHrOPcrhWZDUsVFFhVRFMZEui+LG
 8O1p6Q0dJDJ9CTwfQB9ZIIk0Eoj8E3Th7vBGD3/Dkao4eqeT24yoJ+luGHhKi6XNMEhgpfbGqtT
 bWc5zxYmb3HCFGlwTtAfkuVr7ECq2mxmjLXwgQcNaGAim3uyH/k0DBi6DPLEQ4aSBAZzLq8ugur
 tKBXx/2VqY18iUZneKOcb9PQgtkcpXZyC2J4idl8JUYjkyCRQ6ps4640uF0X8g8nCMpIYpu4XXl
 nfVl+vwrw4uFDfCHepw==
X-Proofpoint-ORIG-GUID: RR88Kc-Wc4igE9vEqr9IjJrbahIuDsr-
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a84492f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fb-0gDls0OKrqtmrxo0A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180088

On 8/1/26 10:10 PM, Loic Poulain wrote:
> The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
> clock ticks and are only valid at the specific CCI clock rate they were
> calibrated for. Different I2C modes may be calibrated for different
> rates, and the single CCI clock is shared by all masters.
> 
> Turn the timing table into a two-dimensional [rate][mode] matrix so a
> given rate can carry timing sets for each mode, and select the entry
> matching the currently running clock rate at init time. The existing
> per-variant values are moved under their calibrated rate (19.2 MHz for
> v1/v1.5, 37.5 MHz for v2), no timing values are changed.
> 
> At this stage the driver only validates the running rate against the
> table, the timings are only valid at the exact rate they were calibrated
> for, so if the current rate has no matching entry for a master's mode,
> fail initialization rather than program incorrect timings. A following
> patch actively enforces the required rate so this becomes a safety net.
> 
> Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
