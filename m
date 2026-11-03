Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705739;
	b=sp+pQj/9xQCny8rcFwyYWcfoAu0IrJSCpFtoxP/P8G9s0SSDhbUdFz9nBDstGWkh/eYn
	 jgQDLst7bOWbd7LN/PYxobeBjSIku/3pR5FUJt3atHSjx7z67VF713rSnVei9aPjr9fg9
	 uGZ/jln2Q4pltZ1JF+G8vaY32Wz2u4Q/fBWUzvyvP/tHgAf1CPgPr7E3zsEDcwFfN0EOF
	 tZtofPpLBbwDv5YirlU9QKnQiXT9wbwOn55JznbuV1Orrchk1We9KkLZUcICFpN3ArFMI
	 qaRLDVoD3eOFcevGy6Ea1HiIj3k1Tv2GJLzXHrx1Cs6o2OlE7CWteVKRd80ZxV9TkFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705739;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MXZ6fbiVHEQv+ZeV6SOfsEnJ7187/w3LJyV+urF+JOU=;
	b=y4Nl/A0vlRFYtjjAtPBydmSOpa9+RjYdc6Cl+UuPtOX/r0m9CJgeTnP5fgCk8xwcpUBE
	 XWr2CVmW/BskAGE7Z851JO9hkMZylcvJ3PsGZeqf7BMEALo6AJpIx3sQyRAFSJHWzVrlQ
	 YDB5/GnZpo6wRkbB+LG67HGXQECvup4PLUyx10g7yym7z0Cm2zc2Q2lhNvNYAtDjp/GN5
	 aze/uy83ReV1JNb3aPod3WFlMxbzxwGXEUpRoHoJFaxHNjwHpkzOAlP3CZM6MtLDk3TFs
	 TfNeXO7GkBJ7p0VQadl8cmxKaGjQXPqFeyBtypiU08Z9l6ksEoU9H7aLkQg0ObTJ/Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aKc8s69D;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TSb1gsKM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F5606A338
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 11:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 117F5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aKc8s69D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TSb1gsKM
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAFwC2522010
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 11:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MXZ6fbiVHEQv+ZeV6SOfsEnJ7187/w3LJyV+urF+JOU=; b=aKc8s69DSW5Ycs5j
	jJHnaaQA1Qm/BO2HMQYM3VS1zS8PUbT0qlYLBaeucsZiCvGRqHwzTzR1CyNKDltY
	5Px0zMSxKzmT86JCJe5e9vte6ketF6TkfuHzwjY+n8ELYKE3hgIQ5/kQq4u/jvaC
	F4c5g48M+PVW7YF+9j1O5MGFH1SaC1Oyh/zt9F0i4URDmPD+sw3qWjjFh8MGp2Zu
	Csz4URuqDwbTmDyu2Bf6frVEiVhdq0EYxHwcZbe6RdvB4qUHyrXRMX12cE73yBvQ
	WofBam+1jS3XpiHaeSJao+Z9G8tDPjUJAxeOSKKNvzKtNJStvwIW/P+/l5H0igAo
	k18SZQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5jem7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 11:35:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e832c03576so59877685ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 03:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793705737; x=1794310537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXZ6fbiVHEQv+ZeV6SOfsEnJ7187/w3LJyV+urF+JOU=;
        b=TSb1gsKMn5AElqC6j7qZNL7HmDnLzXTh6SX9nG+dHPuccp1mFP7tAjCIPvCvEBMTGM
         7BnBkgk9sJ59d8oeKKP3YdiYBd9OUDUeWMkUPyCWyb2CwCweQVLou9CODzb50t8UJJAx
         +iTdV5xYYtmRCu4Osc/hGtNqjbWZEnvm019W0Xt5qx+1GNdkV5Jo6H2czh2Bt0fmahQq
         EufO1LKQQwIU/KWO+w/lkTIQa5YgKFSw+G161rtcjCbPeEGXmbwY+6xPrl9QseiT8Tvk
         AI7Ufricn4l3kMgcKdC4AsLAGJIu03yjBAj8OUOFkuTznowGQ+bDmnfk7OXl75yVENQk
         zbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705737; x=1794310537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXZ6fbiVHEQv+ZeV6SOfsEnJ7187/w3LJyV+urF+JOU=;
        b=fgzX2eRJ9D/5ErVkLqA+ZKiAJtonfoPxAKYBWtNJCWjv7llTsox8Ac0pxK6KxardWj
         4IfTTbVtZ4M1V70xeChM382s1XFOW2cerAZil8mJC51c33+pOfjK8A8g00EE+UqJJNUW
         zJeJ3Ma1I+T7Jw12/KkM6evchWMk4POVPyXm8Km5g3pKh/AkRvpExO1hJ+mhOT5M3QvK
         lkyK9klGUbon/c8GblqUgKky8iIkvK+ykw7B2hnWONtnjAgiB3xQzSfZYRqibRCIzAJt
         Cl8DUJ0Hxhj7CAh6n8bsJbcgonAXgPBGNkbasUEF8c8T/leZvPgjN+sE4BBqEYyPLn4A
         zwdg==
X-Forwarded-Encrypted: i=1; AKwUvBzkW88fAxIeacBxN1cenmSDwS3rs72Th4H9nlN2ZbTzcZgIzkEBBE5AyRd5TD0j1jiC9gnQbmQ2MJc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+lW9rUKW1zAN26wkBtPhWiw6+wzkxid49jzD4d9QyEQuey/FP
	lqWVWoh+QreyN0H1QdeIdtXDxe2DDbwoKnnILx+xvCNOlsAexdmXcTqOd8R+ifV3F1F6uQYv9DL
	OcAtSNXH1mTkaOfyrHp14kl4jgWchu5VABlxe1LeK7NKWMKTyDa8YVcfYmJ67/O0=
X-Gm-Gg: AYBFou2M+yF1yV7LC2Of3bdo7JeRlWihZpSRgfU6agLbJX51sQZgOUELpgWUoDFB/Sg
	e2voStmeDRJirHi+salIUODs0VgDJKjAFBMh0BylYev9pyd+I1S6oQL3io9MmDuqndu2okrNz8T
	zReI7axuF9gVlG8FFY3GoTcdhJMv+MP+9iGGqkBxJIj+3eVAvux1csHEkLIe45/sU4GjPHrBj82
	me8TE7AxnZeZ9w1Dkthm9aLZ8pyBx59QirNyBw9ivC8K9JW0G1amXG8D2HRNcMalLAkJs50IgdY
	3Cl7FJNTnTRQ/sX4iog0rbf89TQ8XrQqTESxEM6hJmJP75BBtl/mpf2nT/I+np/pvPRUYcboYS8
	MQPv1gWn6A6rSZ5X7VWpOBZkVz1vtKTus8Kj9DLhOF50xmwp5yhB0uMzcqMSrgDXAmSrgZ6CXU0
	1l+Pl6Vw==
X-Received: by 2002:a17:902:f645:b0:2e9:734c:501d with SMTP id d9443c01a7336-2eb3649bc22mr127001825ad.16.1793705737412;
        Tue, 03 Nov 2026 03:35:37 -0800 (PST)
X-Received: by 2002:a17:902:f645:b0:2e9:734c:501d with SMTP id d9443c01a7336-2eb3649bc22mr127001495ad.16.1793705736865;
        Tue, 03 Nov 2026 03:35:36 -0800 (PST)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052effsm39802075ad.3.2026.11.03.03.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:35:35 -0800 (PST)
Message-ID: <0b80b85a-5a56-475d-9dde-0d554f8ec8aa@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 17:05:31 +0530
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
Subject: Re: [PATCH v4 2/3] i2c: qcom-geni: Add bus recovery support for FIFO
 mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
 <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-2-59b3ce96dc4b@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-2-59b3ce96dc4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xunecMZkUzhpS79XYwSaw0XZiM3LnrkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfXzhkCQr4YGwX5
 BJTCFvHVpB/BTGPHSKJDBhRSGdFuRcZMkmcry5oj/YfXXH7GvQLXRCW+uB6yWKHUyP1zpmVf44V
 L6sWaYSF0Mt6zMX89vAnuDIEzV5JHCi8K8S/FC1IASMSYObn3qD/N2YVZmxNZaYJPDxBcVLwpTL
 VbzkQVZ0HM8oPopkZ21cAPMf3s0WkDXHyuAG+I2L32J+sKZ+6G+DSPUZYDlqpBMtrAKpOGrJRNk
 Jr8ddKLh3K4SCFBOqRTLKlikmOKAs2uXhUdAplHUHn0cvUjxZyDt4oCJ9cjYKLNRjoaJk1AkGFT
 NOLOPcs9Lg4YBzhIlWIEFsl1PbEnYH49V8ZKrBYoF/l54rfatEJd3y/TUo/uAUIn3CX+LSGetxN
 VEEIVeFgJPtm1VuNIC+VElFrWpVEgQDmRY9SVUW3KX9hIBuv6l0oGh8TK4F/CYvcFRIKgIg98e4
 ekZJESqzQYLLslv1oUg==
X-Proofpoint-GUID: xunecMZkUzhpS79XYwSaw0XZiM3LnrkU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NiBTYWx0ZWRfX7CCOfFKk9j3M
 ROlLkVnmEh1PxaBAnKKKMYHz7WgDIxRfvIwE72Qc0RlaKwN1PAI5guSAugJw6fXdkYSilNt/+X2
 FhOn/x/B8XgvL6yWWRAY+GjKfB3+Ya8=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9c70a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=kinZEuG-tb8UP0AvViIA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030046



On 11/3/2026 2:26 PM, Aniket Randive wrote:
> I2C transfers in FIFO mode can fail with -EPROTO, -ETIMEDOUT or
> -EAGAIN when a target holds SDA low, leaving the bus stuck and
> preventing subsequent transactions.
> 
> Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
> hardware opcodes to restore the bus to an idle state. Check the SDA
> line state through SE_GENI_IOS.RX_DATA_IN and skip recovery when the
> bus is already free. Trigger recovery automatically from
> geni_i2c_xfer() on -EPROTO, -ETIMEDOUT and -EAGAIN (arbitration-lost)
> errors, and register the recovery callback through i2c_bus_recovery_info
> to allow recovery via i2c_recover_bus().
> 
> Use the adapter timeout for recovery commands. Configure the serial clock
> and bus timing after runtime resume so direct calls to i2c_recover_bus()
> do not depend on an earlier transfer having configured them.
> 
> This adds bus recovery support for FIFO mode only.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
