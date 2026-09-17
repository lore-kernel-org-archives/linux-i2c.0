Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847194DDB20
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658781; cv=none; b=ESwl75jQWH4zea81Ss+NH3bv2VEDtYu25fOWnihSaXcUsEINAtZnAatQ6A1nVub7/x8orrDLGfEFuaCV/Dxriy/kh7/wVjInXqJixBwwLVuEbRoL6te4XJmQ5bT0WNiOfUlLvbUxPIhwnOU99NAigRY7eBMvb/qqCadcCHOcQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658781; c=relaxed/simple;
	bh=3qmlskWMzY85Oikfhb/KXg46Z6tfOC9OdCPH+ZehnJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzRNsVxCW/jA8YSuio/TcAWGiArF5zxfwXgcx85GyPHNa0UYtefqmzm/c+qev3do7cxERyqS2A5kCUj8KNnMgRAaCZlytdvawL7UNIYT8zld6DJTDzyXQ0IyiT5E5HwZbqrcaEs9GIGOEZ3SaRHXGsYJVvwI5cDK3WHawRN79Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/r+rU3n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aoJeDqDd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/r+rU3n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aoJeDqDd"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDkQtN1956155
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ln57oQHyBkL7V+ZLstDX/rR8
	u1lfqU3aYXYeyOqWe4E=; b=U/r+rU3nLB+dvF0TXAM7NKyQDeLKUjbIyQ8IyH8q
	zHYKb7kGN7xu4WIAEOq4K9kOAyIvvKrJ3us66pLC62z5kP/9cEDYX7xB1ohEIOA5
	CcJTkZL8NVU8CFt8i9qCv73hftU1mjLTZUcXG8tftC1nrPH8qsMPuMowLxI4OKd9
	Bo1VMNr4MCVaX3OCEqqHHZ9Ygln1anRO/2vULSoIgjpp/5mHU+H7D2RwLYK7FlhP
	4vGTGMXKRXE0/az1woszeD7DVx1bvtnoq5gLTuxthBZxOpU+oqwhTYgG13Urn0B3
	lbJS+5dTNrKq5DB5mVH2xqhGre5Go7S74NzJPqWtTyeXjw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grgu5gq65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:26:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e7de22fddso18486596d6.3
        for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789658767; x=1790263567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ln57oQHyBkL7V+ZLstDX/rR8u1lfqU3aYXYeyOqWe4E=;
        b=aoJeDqDdLdHkj7EXitk/82HUu9mbJSvyeBgFtNUSQbdXMfSzryWzMPD8ouC2zfsKp9
         br7eh3Ax6LQ4xRyvZJHWyzxPMfRjoch93WJNlQn6cM8qoE3tyo8lkO7RHC33tO5onHGV
         APdT0Oa3th1kN5h6MWcEXwkhBDIG8Q7/tQPUv7YTlzJm+V8MuqERfClalmnB8C8kfyPn
         k4Nl4UIl42zdOa0ntCXfa9gt64Ejh2TAwScF3oJHTVAniVgh3uhY+Eckh/MX4cDs7HCn
         ckAoRa80E6CM7qUnYrqt4zCTmKZlxIj0Evdk9RQTPh1pZIIZ3hSsK00dweW+wKkarLtW
         ymnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658767; x=1790263567;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ln57oQHyBkL7V+ZLstDX/rR8u1lfqU3aYXYeyOqWe4E=;
        b=opafClZ3RAVOWYGGGv9rNF7vdbyZHhE9Zcq8fILv4N40FMmGlLuVpHD6GnegrqL8VJ
         vfvgD3X1wOCOOLKeXpaVjFt6XkPXx9Th8SF1Qx8oN8UcVuhXL7kOAehcEH8vl3QovxU/
         4Cn6KNatBZbYRImqsNuzrFvf2mCKzxGQFsm+3XuLTxnIeEmlyB+FICvConJjhllqP+kK
         /B1ZU3UU/FviLp3yl5Li7WwSfuXXYlt3JXcF+eRGbnbsNNowSUKjuKJCgLatu+ohGyZW
         dSYBgKhbVSVy+jyhAGCvXvr5YmbTrUpxfdEholpcH5Vnpw1uTMe523+9HBkM2qzJn0EA
         ekQQ==
X-Forwarded-Encrypted: i=1; AKwUvByMOaGwYhqKGySH5hgRnhjv/40DhVRbhRGQ959usAYzytE96D8KLFXqHvX8Ni88xmTod7F9AY22EvY=@vger.kernel.org
X-Gm-Message-State: AFuF++lU5SwDuCCUGb8kt4BTJ4LoMDZIwzk/L8i0BIuYTK3mHvLsen7K
	q7ZfjVimQwnd78cuT/TQ8dqk9kj+Xvf53q1KLoYMtKviCSvCOaTI6J02C+uE2/WHqshkKXjjmcd
	cmWCQ2tN/thIbvyYSisyZbYHkCh4sQKIj80EXsr8P51T24A5y5thB9tUr/F15blA=
X-Gm-Gg: AYBFou3VF8I1SFN720mK1Ae/+GUS8G425A2gBLwG9P+pKMBp+9DNC1c2KF8gmsUwKfA
	ApR5CvBWJgHYHNCPxW9BSmt1EXA3af0CY52WaWoPz0SIw3q18W//4SbUxhHuRg0D3Mjt8XvG3qW
	U75XnTh1sYN3EHobGlKmCMoAw2keGnu5mI3NcVibYnwvuJ7mW68NAbHmMQyR0GvTpUBfRSYWiMn
	5NtoU8pf0MQSzR/Li8FvALSng+60DLiTroaFbpY/eJ7+x8mS9in8rIUOPgERKdqEprAIWvpkYX9
	FbAEQw/f0Jsl6podxWy3rif6AnvJRKJTlpFrkCld5hf7u4e60usm7mZydEAGKrwwd46qxi4knKf
	+EIttClh7LR+dMlU=
X-Received: by 2002:a05:6214:5b86:b0:912:264a:874b with SMTP id 6a1803df08f44-9123d70d4a8mr129826006d6.8.1789658766451;
        Thu, 17 Sep 2026 08:26:06 -0700 (PDT)
X-Received: by 2002:a05:6214:5b86:b0:912:264a:874b with SMTP id 6a1803df08f44-9123d70d4a8mr129825146d6.8.1789658765936;
        Thu, 17 Sep 2026 08:26:05 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd232d5bsm82102005e9.12.2026.09.17.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:26:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:26:02 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Subject: Re: [PATCH v8 1/5] arm64: dts: qcom: shikra: Add CAMSS node for
 Shikra
Message-ID: <2zraylrv7h25qgkxbqpq7rg7nodw7hsajshsdxxf5gsgtrigxy@3keepqqao3eb>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-1-9b9596221cfa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-shikra-camss-review-v8-1-9b9596221cfa@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfXy4SW470Lvm2m
 vGi4qFOFlUSusqQKdDuizD5xjn8PKVa2B+q48Mki5sVjWGDZewGWiHZ4b51CWsMfKRgrEUtYncH
 iZgOKx+R3f/GGmjzFhRMfEGDjNEG2Us=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIxOCBTYWx0ZWRfX1blTZkqAjtV7
 i7cXmK04/MyWAzbXIOiFunFyvg0scJLnexP9KBMB4K/QRDKpPJrYvxkY98p9nV6ZI+xrSTYWrk3
 i6P11SxjIzhY2RWVRcKVhVVSAzm/H5U3lk92MIEiSvsY/tXzBLNIITdL5F5w4Tj6Jhpzvd9QqwX
 IhIi2UfPRlpoGKuEs6rgBV1BQ4qpbCYySOGsXz+G8yQzy+7w0BeberFEuL3d7NjIl6+dnj5Q8YF
 aniRRI3/dYg0se6wuIIZbTC2CxL5nLWJjK3eqXOByARDn0l6gCu+gk6zAUGVKdYxJ3XrKMpI4Yw
 sbGSM+u3UMHs+xIjcRLPd/pE0tBMxx9ZRZ9UUBfx+c5qihE2aQ8Q/0PuXhdY09zgg/EZol0UtDI
 crx6N0qh+OztItygMl//SeZ+QQ0iQq46EjMNOtQi+aunu0xl+P5p8nNgBXPAV/bRpfW/HGmEBji
 PaN079RgZuZd4YfssRQ==
X-Proofpoint-GUID: nMph-okhwa9Lo27s9nDw9aSck95NbNOZ
X-Authority-Analysis: v=2.4 cv=GvbXaU1C c=1 sm=1 tr=0 ts=6aac068f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XE-wypd_VeY0GsksmEIA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nMph-okhwa9Lo27s9nDw9aSck95NbNOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170218

On 26-09-17 17:11:00, Nihal Kumar Gupta wrote:
> Add the Camera Subsystem node. Shikra shares the same IP as QCM2290
> with two CSIPHYs, two CSIDs and two VFEs, but does not include CDM
> and OPE blocks, so only a single IOMMU context bank is needed.
> 
> Co-developed-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
