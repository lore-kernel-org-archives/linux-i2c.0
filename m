Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579812;
	b=Ekd0MJV1g7OZjFuqA2oKMWpkJXRO0QXka45UW9hhH7i7NEPUrl5PR0qIuADjdCKVrDId
	 r1ogWCkYu3sQB44tucOd4V5uQWKmSTz/uvuq6m/fI/bbyr1SXpMWCxQ6hx2ushVDqYE0r
	 H96ZlOFIlw9I607uu++Rbs+ozYgD/LZIaQYZJCCsfY3sxgHX6SSWJRxIkFQin+/tHXxcx
	 CVTtVw0d+jNgQaFUdGc69h5AzpLqrozhAoivxMkfwG29y2XG5wNxxyVniclYNT2Va5cF9
	 99PfPb1amkEy5kH0s2095OmimbopEEhogP/XNWgAVsjtOmPivN/T00+B0cOB03dl+9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579812;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WZtrC5nd7BZCveHlYloTin8bDZimwFGqn4L+Odkt4EU=;
	b=rhRhiDdTgPY39BccQSRnDiOpFmsgiuOlDQ4qTx9XGG6aARTuy/yAea1BCoc3JqH+8kzc
	 ERxyj53B6mDZmkenm6748r4sIjVTydX4aol334/t6uIPhaRnt655zCduF4mJHlEL1DAHU
	 3fSTMoiX+O5Phux0WKSck4nRh6mD2jbKO6kl+QXTH9VmLsXOp9fA8wD3fnb8ZJ0VTkGAg
	 pti96h5r4hvvO9BkujmyFES3hKmXz9SorXNSKvuzkNf8U+qlZ/3UUMtz+LES7ZVHkTr5s
	 sDNc0oeP0XJa9mB2dv3NUKqXZi8bddnFoZKgmKYjooBbK9ocWEEW2YmoYFFropk2jAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gOvB7Cz+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=djoZ8q4a;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92627606A31D
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92627606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gOvB7Cz+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=djoZ8q4a
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA6Dge848832
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WZtrC5nd7BZCveHlYloTin8bDZimwFGqn4L+Odkt4EU=; b=gOvB7Cz+BSjlKchn
	+/DMyddnSv/zRS+MZoIq+be5fOe9LrmjkfxKGqTPQf/DTg3Jo9augIWMf1UspFbE
	YDWhW4WhBvi5nhMqosfj/1EHpgWMv73UEtJ6VAXrp5BRS3Y9FU0GrZkyY4E1DFn6
	06mTUFggqB1K3y9AcXzyhnF2jdMkWn09Ks9frBrCAkCp1pCWC568LgzAcVbjp1IF
	PL/kJpOyU7GWDoQHRB7z806270lY2krZ6FV7FVRowxWORIzRGdQA4qngt8lMTxrU
	4jcKiv+ypULQEBwFTcW4GLnv8rINRRYkcymkgMS+Zr2K+eTo9ObyecxxSgyDrFoz
	OZ1P/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajkhmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:50:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1f1f2ecfso17051485a.3
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792579810; x=1793184610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZtrC5nd7BZCveHlYloTin8bDZimwFGqn4L+Odkt4EU=;
        b=djoZ8q4aZ2Fuvobh8SIlW3ExonrwDMlsYpvwbkZAshytj1nQh5IoeDewmPsPB77lHU
         s/3iZzovP1hujUzpOr0KDZV6sNr5z5mdZC3Fqa2T4J2HbUgUXpgWkp1SeeXLEJHA0Rcf
         bVvEONJEV1Ewu4Je2y8IjNwGChgFIbLAOZ102cLiKL+MkNxZXC5AgjG8ud8rQ9gVZcRh
         KqGMGEM4+3C5Wv21TE6WliOlzhjWHduvL7nUUW18Hb/cVn1TnAZEFbU5PNq1HhPbs8Yd
         zp8lJNmo8W5jeqh8nIvz0Ieha5qitmQUa+ZSFwpGMR+zfFcJ7J13U7vCLV1ENvYpwk9C
         Ks9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579810; x=1793184610;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZtrC5nd7BZCveHlYloTin8bDZimwFGqn4L+Odkt4EU=;
        b=Bdp8f2syGw7zDCm+1ggDiH1FSFSY0pIeJgjPd3JG9XBxv0MONWAgr0fAkQOpERxaUT
         EU1hG9Idb//rO+ugqU/tkaHxTgM7vTNGZoAMMs31HcKV/gPNOHVvcMIDJr/UOXMyTcHm
         xr8jEEmYlrX3uXIIQpOczpXWQy6xWa1l3K/q05ECSTH1CqLinYY8VQtfWJ1pYqLXVwht
         mI0ja3N7h2LMtLP/wcqHWivuFRBsp8S4ZQrbm9i8/aUzeF1KP9i2Q8FWm8h7nL00+d45
         H40qnNRQ6QTjdDKaUCDpV3Wl4+gdxY/kW8qBzbH0U7+43TTWqTlz7HSgHRIvVvrDTjk7
         u7Gg==
X-Gm-Message-State: AFq9FYKx0hFK8xYlgm69hcFGSNURv8gq+caMLadOvnuhago1V1o1mdIz
	l/kIBBl3Pb9FjVZGfvIhIEDSrL2FfNxAQ/YDiQdlIzZd6qa5YH8cducxb+E/qoTBkiVFBImGwXE
	C8f88t+tbg0KiHLjjMjRgqsRjxihKPPdrjPLVoafIZhf2a7d6HK04Rx9I9WGsaxY=
X-Gm-Gg: AYBFou392+JYZVIptCGbaYEj1rsxaV8W7DeRc1Q+cFE/uHTl0wIIQBbnMSs/tWrj24G
	aRp+YZeqhZF31AFeIgyz9n1BCd2UM5Wz4BZ9PYzs2tttcWqxp9snu7QvWfly0Sgg1AND4/27ECm
	piTzkzRMIR4EchoE7djWoLFS+ouTUPhnP4/pADa1F0UuP5fvyJV9FkLBEQK9NnZ+8ISbLwJQm9z
	mufLA+KgcMa2/LrfeO3NTFS1mMprt8Ye4mGYx+yRNE2/AyDSLZv126XzwTTtNr8ev1O4zSI7xvF
	itlZIGE6T4/4bUlMbkGhbP1bOMIlQeJpOy1ymYBBepz2fVGNzGBRMf065PQsyXeuyqz5QG0lfA6
	BSdVrYBSI9kgoDsz14FAUYw==
X-Received: by 2002:a05:620a:480a:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-93f57f87853mr411696985a.6.1792579809713;
        Wed, 21 Oct 2026 03:50:09 -0700 (PDT)
X-Received: by 2002:a05:620a:480a:b0:93a:ec4:e5f2 with SMTP id af79cd13be357-93f57f87853mr411693285a.6.1792579809294;
        Wed, 21 Oct 2026 03:50:09 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b403155331sm740891a12.31.2026.10.21.03.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:50:08 -0700 (PDT)
Message-ID: <56569e6c-bb8a-40cf-87e0-bcdee5fdc969@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:50:06 +0200
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
Subject: Re: [PATCH v3 5/7] i2c: qcom-cci: Extend i2c read limits based on CCI
 revision
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
 <20261016-cci-imp-v3-5-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-5-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MyBTYWx0ZWRfX7/9N+wfolqY0
 KUj1QxjS9Lmy8jx5qXNrVQFhsIVICEIfqhiC8I2xKxyBp39Tg12Np2jWmBEkUOaraTulArhYHpK
 bbPukOxxqbi2nj4ZHXripW4nwDkWylz+fU9iQUyZfFb9FXCJkvmf5tdWsOniCL75kgHB8hEkoKN
 jX2pm0qRkYlQ+mNl/qx9UqaUxy5TR4yRWZ9fDAx3pTFDne17yfIaLhjKhUytti1qlNSf1AlD+y/
 hPesMhy3jSyQAtFWpsDVVLCn45Qy0ER+xbIGdza8pEx2mE3lq7njPnXOPCaJ3TlaMR+V/E4maf3
 35Q6Vg594rkswtbFU8pG38a9bWpDv+89Jo8aqgLojjMtvaiSnpLPQh224LcG7v+IkzQoVKQd58D
 V82EW/vnZoNNh3afs+7i3HjqG5KI3X20T1VpN6Q5fDdvJpE7O4VOLD9aRGNz3ZpQ2cNy7KJI3xt
 S+pgdamJa3l54VnU17A==
X-Proofpoint-GUID: 1pxgr979w20Wo7p_dUL3ZSKoX2tQoKir
X-Proofpoint-ORIG-GUID: 1pxgr979w20Wo7p_dUL3ZSKoX2tQoKir
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MyBTYWx0ZWRfXyCp/q+rSMa7Z
 rEUNIZvlPqH3M3NxyKdl9aljVPgzehZQWbveA5ld8FXqreh6t2MspH+zVW0b+bKI1o5Lso8IqYS
 ry4zxDETnHtf/7TNyCgqTvEnuzeryLM=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad898e2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vrbjsZuTOpLc0F945_kA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210043

On 10/16/26 10:00 AM, Loic Poulain wrote:
> max_read_len was hardcoded to 12 bytes for all CCI revisions, but
> this does not reflect the actual hardware limits. Depending on the
> CCI version, the maximum read size is either 14 bytes (16 - 2) or
> 254 bytes (256 - 2), corresponding to FIFO_SIZE - 2. Two FIFO
> bytes are reserved by the hardware, with the first and last bytes
> used for metadata such as slave ID/address reporting.
> 
> Add CCI_I2C_READ_MAX_LEN macro to derive max_read_len from each
> revision's FIFO size instead of hardcoding it and adjust the
> values according the hardware revisions.
> 
> Improve the FIFO read procedure, read the first word, discard
> its ID-echo byte, then drain the remaining words in a plain loop.
> Switch to readl_relaxed() for the FIFO reads, since the preceding
> wait_for_completion_timeout() already orders them against the
> hardware's completion interrupt.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
