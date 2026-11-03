Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700020;
	b=JG0xVahIZNd+WSi1BBEVM3W4XiDOyS21VYbhcryLd+fEP0IS27W4/x5+2PKhporj7nZE
	 B2XHxg2zNhvELLm7UIbR0aP452NroEfJozBLbLYz0vMIZqWWVUkJrYbSqWtEQiLavhw5V
	 ZrIIQeuSCqQYDsdVUMZzJG8PIGwSneOUo4Gq6u9xc7QrWssIIHSC6AWdEpS/tY9bCNi5O
	 2EqNvPLHwpL8KID1CaIZPepA+921tghfdreH77Mm7kh97VrBrfUZOYKIt1tQ++zkL9pf8
	 tQ4iR3pgWCumEjuOTc7f0uiC75eKonIAfQL7SxQITnTgsUpHUd215LnAD4M5ASVavpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700020;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Q5oZvAe4yZHBD19Azg/eQm0Ntd5kMepBMsrszjKcomw=;
	b=eRUIl783YFf/ZvobEtkUfX/ZaIxhIj8Z4vSFszZtmEeYCu5F1ACQT5y8iqFvMLj5qYBd
	 LlLYoMvnlYlOvWNDvPbxZPVbXMv6A04HzTab2Hd04MFyzvCdoKhqbfNOaYSQYEw/p2hpe
	 vhZ2eIWNYRL0QZDisjxbGhhSwD3dSinybxggGy6yyMqIHDeBPZZ/dN0VpQMoY8XxQR8T0
	 303nVbARhat9TCp/R+swcNJ36fvCKLTGtjaCKs8iEAbEDSaiTf33AQLlKiirBbBDRl83g
	 gWVlaF3OQv+yKgR6v+KmyXAYHiwLOlJ3eAL5kQJI1z93iLcCQcBtB0dMwg34dOVRvXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Yf0zCZx/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MyWAlCnp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D4606A803
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 10:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05D4606A803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yf0zCZx/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MyWAlCnp
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3812jQ1082264
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 10:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q5oZvAe4yZHBD19Azg/eQm0Ntd5kMepBMsrszjKcomw=; b=Yf0zCZx/Ypb+hlgh
	oaZfNlIE0bWMGtX/K+RLPUHTz0Wwg/Buyj+nq/CiMKiOLobuqXVPSEKKkgjppctY
	qFvHKLboD8JqKHbUSFywllFzuktxr2yAn2aJ1LS6H0cg5g+JACskUXKgyPeMiwbW
	y1dL2Fleg7n+ikBv7AhgY7haz0RQEBiqkkaURO1CsTS7IWCm/VTgGK9MS1RqAX17
	QcM6/373sgRPWF1I41CQNHKa3K+qK7JbxIMjOr9Plw26WNmDbuqZzc5nxO5jQzw/
	mPygQQVxCxqT1WSHg7xvxIuMUJ2HABq+05dLyER6M9qfGA+sq7Dv7uEL1hDaIKTG
	WQuVzA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r35k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 10:00:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e8e16d22d8so58928485ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 02:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793700017; x=1794304817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5oZvAe4yZHBD19Azg/eQm0Ntd5kMepBMsrszjKcomw=;
        b=MyWAlCnpYAw9UqcQD/MQI3CSOzwgC3scIGGIbE+2mRAV7BoHBkYGuqTfa+i1sA3KHU
         TZMR/n6td6gQKiuWKRare0rWjv19b7ipMxb121SH8JtxdEYgeArR3fYj3WtE6Ce9EKE8
         t+7sq5HtkHrBQfjT3gK2PtIq1YsZUzuxCkqcFSNLeAJHr/kMfhPHLTSKd/XeLjpoD6jF
         Wx1zbdy4jm4PWiYWhx1tOFgn6EfccypdaJ2inOmMQmuDAE/WCMHtXKtCCtXFH8mHdmqi
         aKCOwSi6y4cE+3xAKEhxfZB7FSYLx83BLvyKeZm+jyJqotrJV0OMee7435pyFd3Iy+/R
         /VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793700017; x=1794304817;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5oZvAe4yZHBD19Azg/eQm0Ntd5kMepBMsrszjKcomw=;
        b=nwuKjnk/pyj0Av8/ZSwoVCoLtTawINmroezwo1n4jKABk2R/urio8qwM2QFtEejwIs
         QD4sSzw4jQlRLBHTmJbUiE8EUIkg3SN1bV32bTC/pKN3JPEajjHH6Kt9rmfq72kR93N+
         a8wRKC/8JEOEipEcnWBOhbytcFA5xxJJrZn+8HC21sSLVstjsagouJ2ohPIErDisklkX
         TxceVkvoJcrJg1IkxLYG9hG/TYAr5AZKGaLDfiHHWK0z8NX6n2Mx6iNQLFRiGMRonVmq
         5134GsUQ44AqhuoQHQdOBWrPN5+uWWZg72UuZLZfLpxUe7E7dvOw2Du6NSFsilgm3MWd
         ddrw==
X-Forwarded-Encrypted: i=1; AKwUvBx5UO0+/B4yyLkhNaKy70S1KHxikenMPl26pV/MLbE5qdiVR3NjeIJT8UtbKHWaMKuC02mgDWEUD9s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tIxkvQFhQ29GynIJ0aBcXspwbiino2OqWaUIz0qctWC1epQhF
	xQ08zSm6BVHvGddMFI4Pxgvqjwx3AMRfPwgt3Xv3TvKbMueNAC+Z+4U1URcaAnZgMT8oO8Up1NR
	vUnwZYsN9wYQjPUxXkpCzoWKB1vnyhWcRs12gg8/Pr2SnuMkaonuOboDt///Y+9g=
X-Gm-Gg: AYBFou2PJANT9WEjschiF0ppMxR8B26p2ZOe3WYUtv/80qtfZbXh/HF91uczeI1Ah3L
	pB6mj8JtE2EQT0Db+Y/6YnGQ9UEekYVHsTb0ke0vWDQgsCmL31mXCJLZbdm7HNTcsCK2S2+WezE
	zFiykYvJfVfGigrwCXKT34TNHv63gjh2YdSOcJszoT5OmSkU3+6976yMJ4yCAXiUChLw4zAe4Ak
	MWcVNnZQAd79BovyUQXajwqxZU/qgaZoRrvAtbK+S1fF4wE7PSstmAmL8NVa+8Du50WihioLoR2
	4BslYEONdXM47ik+u16qcaeASZnXWhzuGAxOnJaetg3lKmdp9ZuGSL2C87iGRCWcUkBvux8tm9p
	GstPDb+q66f23wVpAKy5+CJE5/6Yis8cpmJxAN+5Um7AxMT2qRf2nTDsWY6TDpnPGqVC3Gi4EPv
	Th0ag5
X-Received: by 2002:a17:903:190:b0:2e9:460e:ca4e with SMTP id d9443c01a7336-2eb36401dcemr127984745ad.1.1793700017377;
        Tue, 03 Nov 2026 02:00:17 -0800 (PST)
X-Received: by 2002:a17:903:190:b0:2e9:460e:ca4e with SMTP id d9443c01a7336-2eb36401dcemr127984395ad.1.1793700016823;
        Tue, 03 Nov 2026 02:00:16 -0800 (PST)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eced9d14c5sm7467525ad.74.2026.11.03.02.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 02:00:16 -0800 (PST)
Message-ID: <08bb4de0-dc94-4c4f-8d1a-ad3a4fce86bb@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 15:30:12 +0530
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
Subject: Re: [PATCH v4 1/3] dmaengine: qcom: gpi: Add I2C bus recovery opcode
 support
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
 <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-1-59b3ce96dc4b@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-1-59b3ce96dc4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aej11QEOgRH2ToNEgjczKQeH41q4LXiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfXxkVogu7rxuh7
 +3XJXgaD9CkIKMN6g9C53psVPLQDyC2gDKMGwraneSwYy5Wo7EqpWNMREMH9jesjt5S8o/1HlL5
 kgHfcUGxyf09BFGWqY6hkxvew8Fbde6vfI3mQbw7kO/8Qki3DuuP3gnYDNEejcIfcUNZkJRA2hU
 NRCQ74pqttEwkfYjnnK04MAkgM9cvq6M60jof+0cava+DoCSa5C1e4bX+FROlXuT45t9ksnO2VU
 WpJdu/Gf7e5t/Efl6YlfjateVRtz+GpqAKi7EKKDx8inoN9WtELd4zFFdu70VBZnLUfmHEe+ilu
 1YvslxnfIdIS1L9V1BUoF8bBUgTWoAaKZLgV3L53hUXkZll2lOkWAe0YsBelPCFgmB3eUjBHRxg
 ZzmfLIhEfRT3Nynlql9Ze45G+WEcEkPL8bIVO+bC/lRADHSie82hfvNrAH24vkdARoN6Vm0piEY
 kerzPVyBbPObRXmLiHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzOSBTYWx0ZWRfX3xeLKloKKJuG
 6YohYaNIEadDctLoP4z42kgAjtor2ATxgbMvXA1O+ymuuUJjrR2FFcayytxSW1Iq7OZ0oZHZyKh
 jK8FP7rwkBs0jcsCBVTzq7GSBPqiM6Q=
X-Proofpoint-GUID: aej11QEOgRH2ToNEgjczKQeH41q4LXiE
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9b0b2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ue_Pd434T0zeNjF84AEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030039



On 11/3/2026 2:26 PM, Aniket Randive wrote:
> The I2C_BUS_CLEAR and I2C_STOP_ON_BUS GENI sequencer opcodes release a
> stuck I2C bus, but the GPI DMA driver has no way to emit these
> zero-payload control commands, so an I2C controller using GPI DMA
> cannot recover the bus.
> 
> Add I2C_BUS_CLEAR and I2C_STOP_ON_BUS to enum i2c_op so I2C drivers can
> request them through gpi_i2c_config.op. Handle them in
> gpi_create_i2c_tre() by emitting a CONFIG TRE (when set_config is set)
> followed by a GO TRE with IEOT set and no DMA TRE, and reserve the
> matching number of ring entries in gpi_prep_slave_sg().
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
