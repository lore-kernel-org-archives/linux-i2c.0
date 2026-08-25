Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312E3DB330
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646181; cv=none; b=tJ335mh5lMRYAyS7tJrDE8WF4KDnOBiQjVORPbIVr/S2/QA/926ZeKw1JS3FOfBY1/WFRZUnq9sWNwnCVqPlMDiZlG+ny97425ehlYnEbrGbFsCuzMq5s0qz6WJFb54P1SCL8wEGWDTo0Za7jVftDxuCT6tamoR/7FF3mxKIDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646181; c=relaxed/simple;
	bh=3k4yRXSRua7NYMqAmmhy33cZ3AnCSJOK1rbJA9IReO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M04STdcUGtXzMjjcJeNnQwFHpRyuYVu5nSFloVWYKyplGPK2Npufwak3oz1BI1Ro0IvqtCYo12u+3sYHF9nc1sCDFJMPoBjus5tyhmYJbkS6cGBXOs8pSa7uQRDt3xPuwlvHtPexSIC++ABDlhEaCCYAw3jXuA5rW+92O+GevRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJObNxZo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HyXWDdyD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJObNxZo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HyXWDdyD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88Drg1934796
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ywz9kH7gTln627j++0eOYkrz
	Mzb6+AiHqb1QNVbCm78=; b=cJObNxZoa+HbrFvBFQ1ru1TxDdBS/19QcmdXzbsS
	JezWSTJ/JX6BEnSx3McaDZcdeRb8zxcJzt9OBCsmpJ5TbONQYMbmEoQXrw64sQKf
	+knun4kxmL+UuXAoIeVu2eeJdoDwUxzlTFYHo5k8TCUSyPXow1jnxrU1VAZ8b0Ck
	3y9kD7g9xKnIqG9hMv9IkhKaTlNAipvMBpAHTYzMTRN81ghQAbFEpV91PvrV8tWc
	b1aWJoSxXSMbwAQEArCCERwR63DVMQeE1thTJO9Qc7WQ38z/vr45Z9pmttd65BWE
	sHIopSczy/pbsFYxJVJUHaCWDWBE28+IsSynzfO7mzXeBQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g92jqs56x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 08:22:58 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-977fa96a0a6so525901241.3
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787646177; x=1788250977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ywz9kH7gTln627j++0eOYkrzMzb6+AiHqb1QNVbCm78=;
        b=HyXWDdyD3OW2/m+QwPYkeAWHghMpqauY/tw6ep0hjnos0fjM/FRZK/NhHsOjHRkMld
         6HmWhlY2cvxgnjeJhekGMQVUgMt4F2ZZOO0lc6idx6fI2VzeyYZMC4jTHSu99IfX5pap
         ZoGwwP4eRi3QV4rtTgKWcGSyQbc18aLjLEKZBZRtBz9Yt4GgIoTMq8ukuSHoyQIQIlAw
         PscJ+3IfQB/N2+SbZTYz+k1+uL935bNCBD8mnRxuToDSTmX2wdEdC76ljCK2XnQcN1hw
         /VjNsQYV+Gq4qXxjGps9cCEr3NR5vLwtibDP/4cQeft+1D6nxFP+VIOWnPNarSjK7gJO
         VIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646177; x=1788250977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ywz9kH7gTln627j++0eOYkrzMzb6+AiHqb1QNVbCm78=;
        b=VAG4jR99PREwgkhC7HY5IPx05x3QkjidvJoHI+kSvNmEnmzUu5UoY9PC/2G16oRIy2
         K6scy0liQreUWO6Hyp5gtZySlYV/FhZ3untHXyxsNbjrgg6nlPjESXahVmkNWlDX9Bxa
         Eh1nUO32KichwzS3RF3esuYXg6bO7HTKQu6yI7VFIrDGAbe0nywjVrQs7XZPOYFI36PF
         E3QPojny6zGUUBX1WA9y0oxbL9V7Oaa627VbKosav7feuVHc6LBPKaFgJQBN2nhGcUAa
         AMV8PucgYEIqW93rXOdd52Uc3/fSGckY8aVU82oOCd+S8KLsQV3uafCJ/lkBRAGoQ9Pz
         OxRw==
X-Forwarded-Encrypted: i=1; AHgh+RosnJkTRNIjj2PS5ZUavUzfk54oo7INHlwnCLid+cwI465GFAkYhfjtZLu7qUbuuIa4IAow/EdGpsI=@vger.kernel.org
X-Gm-Message-State: AFuF++nFTKzS+HNbP4X70EyTlrfCMNtUizJP0oc04qLHtW70MyDzC5D/
	zPgHGEYyxhl785HIqyYM//MVG+gy/Rp+5MHpRRCechW6sVvrmbT1HeH/h9eFaByq2Z5TFNN8DZz
	tvsak5l0tzfKfyJfhBG54VVBTb3f72PEJLPgh8bx311tuzk7Oj0PFYw3dsgAEUmc=
X-Gm-Gg: AR+sD11AdXov2Yr/MxZ34eBMlWWpQXrMIO/0UlxdnYORy0e5BZYPq97UONTohwbzkmw
	rEoka8QRrMgnjHfFXM97vFLI20KYsybwT06+FIG7Rjr6YOtJIRB4MlJqtB0vESAF6RkY0PkmGzW
	F6aiPuTya6p48OezBtd+zI27sZ903iSSiQePN4hSeHo2WpHVbo4GP/gCaQq0a48MuYI6UxDJxSF
	w/IR0kx4KxTMf5JkfE5PR/nC2PLMp/9FLDghuV31vQp46z4BHquxLpnWPaPQjeDAgnPT+HdZQ/S
	P/oLSrYke5Tp8bvBhWXH+J8Ri2TnU3yNR3JkJmMJiGgcA8LMCIsuBAKFB6+U6hgFVNjDasoghIW
	iegM7c0MllBlyow==
X-Received: by 2002:a05:6102:6883:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-77fe635f317mr1644168137.1.1787646177510;
        Tue, 25 Aug 2026 01:22:57 -0700 (PDT)
X-Received: by 2002:a05:6102:6883:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-77fe635f317mr1644138137.1.1787646176998;
        Tue, 25 Aug 2026 01:22:56 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2da49bsm14366325a12.29.2026.08.25.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:22:55 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:22:53 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
Message-ID: <2ah2wpjrqixhnws6y33tlkuep3et36q6typfd7ausgaslykmrb@cn6usezfkae6>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
X-Proofpoint-GUID: 36gjAv_XV_NI0hBZmkOJxW37Kejdnmty
X-Proofpoint-ORIG-GUID: 36gjAv_XV_NI0hBZmkOJxW37Kejdnmty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXwMN/UbqdW64N
 vlSMxMhTbjWxZucb44XXUjC43xJvVzzQsedrg5cPRb28rqrHqrFEUylInbwqJOB14eoxVmAoozo
 nTx/rMBrSsA14MxlE6CIurBwIKB0koklwFj69HaJXkxBkh1LcYMyNk2SrXmLwidvqNajJjM7zib
 RClEzKNOYDYgCppT6WavPokEPnqvEKqflUrLN/eUZDkll/w61QyldYr2uTfO5Jfq5MnVpFFqOMB
 X7EcaIl/s4pp80PyAfN7KYoZnz+1kXb3n+8jlrDaGCRtxbps5JB/lot3GfOSZ5pvhPFojSsh7q1
 1kCPqEZqBNkX1ibeAjr5drp4klpkR3SKfPQSvBxJVIWu2b2C8xNNSJgPjKIr3XgDfQAaDDQWFOA
 dzqHUl7eCDhQpcdjcmxvGe8GU0z6J1VQ4RZEKkv2Iqdv5lnZzno5cbaMmZIfVRpsarcFLxwwEAA
 pTOyow2O4zU3U9g/gxg==
X-Authority-Analysis: v=2.4 cv=JJULdcKb c=1 sm=1 tr=0 ts=6a8d50e2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=dS1doENrTls30Ym8nGUA:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfXwFjpla8ThF/W
 gsMpeehSTV2pbYBBoc5Z8YUpVg/F/Nl1xQP5BOJbyLPPAa178qb3/ZkY9vQqcwRMdJuHc3ImJAX
 NZ3SR7RiFhexT7TPMXbyNq98B7aeo6Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250070

On 26-08-05 01:27:39, Praveen Talari wrote:
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
> 
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
> 
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
