Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34C4E01F0
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981057; cv=none; b=E6uIywzaWIwNz5vmsYyU5r5kR3Ifi/FDbH/wJ/XZId4j9xVNn9C6LsQdgt4ZqQT9vfae9QSmw9RzL7S8yvX/fyByomrrrZjnOuOnvLZaxp7ozuONr0BRpfKIBAcSdwtClR1tVS3xqQgOIYu/56Z2cSAmoB2MaswQsxHF3iOgtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981057; c=relaxed/simple;
	bh=RJIg6DVyFl/JbgK4vyZA949yfWm7M6w93iBPf750RVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzwUZ6T+sFNySNxQR5uced4v50OIwIx3rmbmufpzsq5QHmqTZMHHXH+Ev0y0QZTayTGMlhrvLaTXAfKZZH6edcpwIaLRlyS74DYId1vghZPenASuKiuY7c4VNPoUH/jkWIE9UNJB2A2CokvHOWbaCoCjm/RyAjUl7TvyAS0VENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j8l4uNRM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JoAJ/ynx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j8l4uNRM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JoAJ/ynx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBWl533365336
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 12:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AWpozBC6RRpfvAz58EjgzoWVeN1iKmTtutWA3C0DjGU=; b=j8l4uNRMxMWBSJB9
	u0k86TnyMIuKD1gEV7Lj06vFiyQbzxbRF9IAA/vRUmv7VhcL2Hc0G8UrXvN3qg2O
	KJOXoyL4GOEyhX23sUwrtGbZ/Tta5mXwelAPFk3zPndSSofcAp9ipTfs/pVzyNoe
	lRNAQKKdBYK6MymPFmFsvt/WZZc2i0NQE5nl5O1oQZqlQeyM6ydqTvjElhL4MDIt
	gSiPtEBYktFbShC1ONTkOgo7DMtJyBBMBY+NXOdiKxlKbeH5O5f753Bcc//4KAo1
	SmB3ocTvfJOc6WHXkke8Zmy1yhc1s7NbzxvTIj2hV7+43ucEckp5afE4qdYOaRU4
	0ydDdQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4621ja8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 12:30:55 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5e95e7cc02fso65232e0c.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791981054; x=1792585854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AWpozBC6RRpfvAz58EjgzoWVeN1iKmTtutWA3C0DjGU=;
        b=JoAJ/ynxomw6RFuILZiO60Q8ra/3sA6qncd0Y6KAw8MUPxOWvtn3gZ05kWEO5kfsjo
         glB7x6DJ+m3ldaq/Ug1OVePv4ScqmcJcfn4GyhFu/pndPRyS0C7CkvkLJiLCCDBX8oeE
         og5aA8aCbZ4MhY+u5kMR+LyYsg2Vjp/nnSvFuw/o4wWYreBsc4WtgnjEZDAn8Sfwu8GI
         iYJuipOfI56e8GLvCVvaQACzYRBBDCzRhCbjdBDA7dXDc/D3z4WdI9QBpLG67NYFxRA8
         a0OS5xm/hQuu634WWLKyDTIgWZlyP0FfrTH03g5sMvA4c/PaAqqIPqc1YG7Th7hbmvbm
         ++Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981054; x=1792585854;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AWpozBC6RRpfvAz58EjgzoWVeN1iKmTtutWA3C0DjGU=;
        b=xrkvHxw/7oXAGeMUIFIsWekBRuUdeBk1c5YqXSa77/Hoy8HZdPkHiLoiav9dNtn3HI
         h2cFEHVLwlbIA2iJbAphishnY6Ho8/o3eRIgM6zjoCi6uvDZOj57gRyRQkf4NcQr0cE/
         V7uyXAHwtZtLLrhWF4uwMfDjhhefhaPilwRMHzMVHt6xeOK+n690r8DNduPU7aeU7sla
         QsJZDhMomzRwBMe0lBXikpHEIfYpmFJ87TMvJE0W3pY0i8LB9X53eLDwQ13r4firP/UX
         qBxfXRraEtkkWRSvEwo5iZscwYMJc8MpnT00zxMCaEM4i1y8R2a2JeBIAeNIwjU/6Bdo
         2DgA==
X-Forwarded-Encrypted: i=1; AKwUvBzf7w9v7ndMco1D1IVaaMizYLkT1VbW3ta/8Dxqey8028Z1ghiHRyLD22ZIgxyjy+bXuELli2mAgy0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrUEzxda4aKVUGBmoEtkRGRUgMmRHb/aMikBsQpyoNMn0/8ywQ
	k22bX1DhYkSv8jgDhsuyBBlau4MzZCEhSZjoTN0KFJ7j3RaZyB/sQxdHml6euhDF7qJlm0BeTT0
	2R0owQaXv/IvW/L/FAwKXb3G7ssTLPS19uMYmE2kSZOeRi5Ar4muXk8kflJ6pE/g=
X-Gm-Gg: AYBFou2xFvb5M1zHYeUW7Allu3so+h56hmA7t1TK0Y2e7qr4c4qAw0PEedt/5sma+S2
	VgvLcx46DobGF8bhbXvgfGSNw5gSlpWifUmfoOAif023nz9xfslpbildLMCe+xEqsZZBD5YvD+n
	Xv9YysIebZimowDY/IbYYxqPbUfdtPWYlJIiN3Cw5szvMBP95FVpKBegKgi5dBHd2y948+l4tqk
	ciTMl9ZBXG3o5wpNbrW2uE2Dzl1NRjPrqyJBg7y3S0tFYknX9hbDQAfvcRvrakFOrUyUvPxop4U
	xbNpABGJr/Z2EMroo1jm7oo3CsUL3id3mt57ljofVnnLZAb1BWiGccGEaKGnZNVJpWfmdTD2JH1
	0wZcBnuNYKlbawRyxRj6KRQ==
X-Received: by 2002:a05:6122:464f:20b0:5c9:91ba:5d7a with SMTP id 71dfb90a1353d-5e91f232dbbmr3342750e0c.1.1791981054357;
        Wed, 14 Oct 2026 05:30:54 -0700 (PDT)
X-Received: by 2002:a05:6122:464f:20b0:5c9:91ba:5d7a with SMTP id 71dfb90a1353d-5e91f232dbbmr3342717e0c.1.1791981053779;
        Wed, 14 Oct 2026 05:30:53 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a9fffbsm691074966b.49.2026.10.14.05.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 05:30:52 -0700 (PDT)
Message-ID: <ae03e7a3-75f1-42df-b0e6-0e64358be647@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 14:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Birk Skyum <birk.skyum@pm.me>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260929041444.9837-1-daniel@quora.org>
 <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
 <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
 <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
 <20261009145800.rc-reply-0004@kernel.org>
 <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
 <4acb0eee-f7ae-4817-9848-d72cf486bc06@oss.qualcomm.com>
 <e8f862fe-f86c-4522-9ef9-70fd754529af@leemhuis.info>
 <179197985641.52689.14222546983549320957@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179197985641.52689.14222546983549320957@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Yf-N6V8ilf9zUSkEXAzdlV08e2Gqyp1Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX1IUHBRfWr+0d
 ox0ZdBpPcs9nL2GbYcBF14wil78cjlU2pwD8SexGlGILkHmBvUIzARj8s3UG3u5/YebKME6CsQY
 WO0t4fU0Im27j39S7gYCU0fMrdUsdKzDuu36hm/7EQpvgV9lJ39H2U9E38UZKZBT6Pld62jP28D
 tZ4YCeD/2kAHDR+GlGe6keVtzjTz2ZI6vEPK6x5cN3x4CUoFBBz7qaqAzTBwh4L6GAr2R3bM/y/
 vLCvxSs5wXZ3L6QcJpPn4NRCHajIbEAnoSQq+JIG62IIP15JdJq5wHtfeZrSNANcfRGbCf3vb5d
 Lp51hN1Dflrl+IHlafUgz+NqgBz+SS2X6hfz3ntKSrJXEzfAEfUxgDOhF5GexsEDywWOv06mtt1
 qs3ieKXPe2Sqx9uUMxYCB+HuDQq5Tq/bF3OZiTydTqS/EGpEH1+2q+oVCT7GOFsVR21PjkTT89X
 Rku34IDOTi8ndJjU2iA==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf75ff cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=ISgNb0KN0Rerl7bivZwA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX/WWaQmagIF/B
 cvbkt0F9N5i6bDnhc7mvKxQBys5qLkf2ObiL4+uidUIs6faGrtfQ8Bxn/AKoumP/Rp1J98ukUNZ
 /p2mDyfaZdWkv/dHql9PBoIjhmjN+AY=
X-Proofpoint-GUID: Yf-N6V8ilf9zUSkEXAzdlV08e2Gqyp1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140049

On 10/14/26 2:11 PM, Birk Skyum wrote:
> On 10/14/26 07:08, Thorsten Leemhuis wrote:
>> That's how it is sometimes, but then it's likely best to go back to the
>> know old state by reverting the culprit -- or is that a bad idea for
>> some reason?
> 
> Hi Thorsten,
> 
> One correction first. My report was from 7.2.9, and I had not booted
> mainline when I sent it. I have now, on the Yoga Slim 7x with v7.3-rc7
> (a distribution config, no patches), and the keyboard and touchpad are
> dead at the disk passphrase prompt.
> 
>   geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -5
> 
> Same kernel with only i2c-qcom-geni.ko swapped, one boot each.
> 
>   v7.3-rc7                          keyboard dead
>   v7.3-rc7, cb97bf3d4f91 reverted   keyboard works
>   v7.3-rc7 with Daniel's patch      keyboard works
> 
> The touchpad binds whenever the keyboard does. The I2C serial engine
> clocks read 32 MHz on plain rc7 and with Daniel's patch, and 19.2 MHz
> with the revert. In all three boots the touchscreen and the three PS8830
> retimers on the other four buses work, and only b80000 fails.

Since the discussion still hasn't settled, please go ahead with a
last-minute revert for 7.3 so that we don't get an utterly broken
release.

Konrad
