Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615634EF04
	for <linux-i2c@vger.kernel.org>; Mon,  5 Oct 2026 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791191212; cv=none; b=CHpOR5m7vO/8EIVaXdklBH78CE2IgwQF88XZV3NGUcza38iQZ7vT6XYRosQJDrRAEKqUUIYOchNuEXBUFrHaeQC7ZzTamtyBNAyV1RB/NWkBX0VTKo57/wEX11UkoaWMtTv9zjAcGqVjXvwKR7RUrb2WHc6CwA0v1MaanTGtxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791191212; c=relaxed/simple;
	bh=4h6kpbjLFRnTGCOP6FLTdm/2YUwHP5uJ7+u4N1dhcA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkTOTbLIidOKajzlVgRo0jtM7cO7C3qs04iLSuI597PH/EdoQeRTYgtoXq2YnJsjZv+Yfl+714dxANvUQ9PrHI8St5y2vDI/Jz7ZFVzHerNUfJq4pOMsuvFO1ng8ZhZTCwPbuBY+vXl5VW18Og/ch3yviGgJHOqVLjhfccW8oks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fGu82ZD/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnuMxzf0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fGu82ZD/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnuMxzf0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6958xZGm1503839
	for <linux-i2c@vger.kernel.org>; Mon, 5 Oct 2026 09:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kNA9wVjQ7WyzPMpGzB4L8YXM0jvLodaFmlvxSYaCxEc=; b=fGu82ZD/CUdFlJbd
	II6not+0F1l79vXmLvb3uqOIbMlvAftxdUhnIhGCihdyxiymy9PYqXoISG6MWNzR
	LXAb1R2FlT2r4XI800pITORzxwvbfrUcp//semwCyG20/Ob4mmrVCQyP01twsqvl
	2i8s/WlU4TfNs0rqMy0TQY0jK87TfVTUA3P/q/qBzHiw4NuJG1yR2fXQI52ej3QX
	Z8jLVJgjWIlSyB5apg5Erwr1mfcwHpOaamTFo3itjhobmSSjv3mOT8ygu6mde4KP
	VWuWdhtWAD+RC+ZzFDZQP2DBoxl8Pcit3yDMQhif+Jep2U+GXT3B4fRpW6HbkMHf
	gcgASw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgysecx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 09:06:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso1022481a12.0
        for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791191209; x=1791796009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kNA9wVjQ7WyzPMpGzB4L8YXM0jvLodaFmlvxSYaCxEc=;
        b=ZnuMxzf00o6TEN+gHlkStfg+joP/UXmk3zWIyegzp4zJJVJxOpGUbV88n1vhBS077p
         pNJudIHuRT9eNXIlpGzRt6lD9bqu8KpcLHOFZU+lUM12cLq9v+0Y4sewxs8Hz4ZQm/4g
         WNf1wi5tlJok1ZjlDgG6gZ6YRPsWOJsbhpoD68mNWM1israqFtLI+GKTPhADq/6FMIzw
         CgByYrEcyKGpb0Q61QLwaaKfLsLAAHPCJbkggXH4OyhOYWUb7Z3Wp5uj3k8rUg4SuJhM
         QrF5q+UstkVi8L37bEIFj9zBl8jQuFy7OIIYwDeLQnq1rTKPcYrwaxwHQtmC2e8qRwks
         z3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791191209; x=1791796009;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNA9wVjQ7WyzPMpGzB4L8YXM0jvLodaFmlvxSYaCxEc=;
        b=jaYTHyM22SNCDeslw8bonfNfu6FU6iPlZ2w4wIwWSIjFnmb9FbublNSA/WFn//zVO7
         d8tCG1ARteBplAejJc87T0Px5R/O4YqToURtVmqgrSGMprMjhmbqwFzgteL+W1Um9kNy
         f/ZsISFJwOnCwmGLDi6hFy/05Bf3p6NltJ8fjyf+7aMOWGl+Tn0Qs+cmgxiLkOSZCtm1
         a27lN1lTyJkdtZmrb8n503n5WP7qI6E6xHvd2z1Q69OaunCh7JWMX6bYJwJfbfoxuU6T
         rCKBVKqIvdq12S5FZbTStJFbEkeWYSkU23xPtltw/hZ99DECVje0v/p6XOilMqz3rItA
         +Vug==
X-Forwarded-Encrypted: i=1; AKwUvBz/aYZlCbKgHaF34MvO2d0q8CdDYn+Zd1scG0uIkvGNvD+K43iFoKl7svFA7EKfj1lgt95u1CBnIRI=@vger.kernel.org
X-Gm-Message-State: AFuF++kmFQEHnNJ5MAMwJmYMylyfBGdAF+N9DuQpxQ6LImcUquxGWwcv
	AOpcKvMnMxUpYI+8uN8KqQr4oVhVx+XDnVorLireB30OU/iexbo+0Gan11uDEgn0b34rR6/bPvL
	+BPjmkt2lK0mc60JS3WJIDh+TDDXRbvXcsMkohFpKIa0CM1oWQ/AZbdTzfmKfbrw=
X-Gm-Gg: AYBFou1d87OhHD2JGh172hkICM/5pPj/iRo0RUsOE82QQSxY1/741H1/YNTacQ3bKhE
	ypwiFzT+fvJavV3rCytoFv6m96sm3fiUBXVWSu4dHWiOALXbDEO1lbIr44wEWegyWmykP+t9hj1
	Rg3KJdJCUX3sWPOqbe4NBjtB2baMZfWY5LjGoyS8wh/6z2CNGfxP8Cy61gp9C081P4ehF29nvLv
	FHT46ybuGi9cdve1wvBNgxnX4o+yH/Qa2xyF00dC7No/U9CIqqMSUtpGfM/qWktJdXl070XGkhQ
	37Tb65bcUrjfHPZjZ0xL2daS6oGKweVLIExldUD9DaauXYpk3eZLcn7+wXB+Tbpenzzu6lCctzD
	eiy8AB8lU5uH14xdx4R7Kz5rbJB7uBgr1
X-Received: by 2002:a05:6a20:94c9:b0:3dd:a197:cf1b with SMTP id adf61e73a8af0-3e0bd44e649mr10349814637.63.1791191209203;
        Mon, 05 Oct 2026 02:06:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:94c9:b0:3dd:a197:cf1b with SMTP id adf61e73a8af0-3e0bd44e649mr10349777637.63.1791191208766;
        Mon, 05 Oct 2026 02:06:48 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6e5930a1sm481861a12.32.2026.10.05.02.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:06:48 -0700 (PDT)
Message-ID: <f274cae3-e7b2-4976-87c1-b4e5d7607487@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:36:44 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: release runtime PM reference when
 set_rate fails
To: Rahul Pon <theflyingrahul@gmail.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260930111641.1134-1-theflyingrahul@gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260930111641.1134-1-theflyingrahul@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2RROpiiWenNKyX5P92MoO_C8vY-f4o1u
X-Proofpoint-ORIG-GUID: 2RROpiiWenNKyX5P92MoO_C8vY-f4o1u
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac368a9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M1oNvLFnHOu12HvPULkA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfX7+lKo1yMO/yo
 NdyY25QwBGMljUNzn9+iBSkpz2f0S3zEWd4kiPMVvVg/ry8RiUWF29Gg2jc5TGf8Dr06VrQEEi6
 gE16jxPLdnqkieR3EwBR2zINsFNFKEFUEdpg0UXZX+0DiecrAgSb6EIQYQs6SF8Q0BGCddz+zs7
 t47liQFTlhTSFAh/rEyso0P51lebj31PQcMgVb1wuT70Mxqs/Sj5tVOL/zLq5WIRIzwJhGed0XP
 aOPH86ZyFxWqo284VnzHsi9fO8pM+y1dJoUBA7KRiOpoiIS1BSbGCiNzrI1xmPRprmJ01R1cOmy
 Vh43GraYoAn2owaay1I50KebKJSopPH8ySjQiSCjsSpenkdaSz0irKzJoTlRbg0/BF+K7qGWjZ6
 7HC1yqyyPZbaal1TSmjMRtRB+G4WXL12TX0Cx3OdggEj9lSZWoNMbX7ox923T6x3B32tcnDKT2p
 0pwo/K4/U+2pnXUG74Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNiBTYWx0ZWRfXw493kZ1l2j59
 HRzwgA6vpBJD186CcMZPJMGbYGNFsTBYqAXcLyBkuH5SrXULA1vgkNVLed3gbpHkI6cbMtamV+s
 TxXf+HbTEFGhE+cQd7TRmcGD+FqeVpI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050036



On 9/30/2026 4:46 PM, Rahul Pon wrote:
> geni_i2c_xfer() takes a runtime-PM reference with pm_runtime_get_sync()
> and then returns directly if the set_rate() callback fails, leaking the
> reference and keeping the controller resumed for good. Route that error
> through the existing cleanup path, which drops the reference and resets
> the transfer state.
> 
> Found by code review; compile-tested with arm64 defconfig plus ACPI and
> W=1.
> 
> Fixes: 10e74f4c5046 ("i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms")
> Assisted-by: LLM
> Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
