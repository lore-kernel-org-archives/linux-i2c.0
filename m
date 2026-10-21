Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590530;
	b=xmfKLxDNUq/8jzdEtYY3YhioKbF7Np7cyBCZLhiIS6QZ0uR+6cznuFkr+2Ik4P7Itxpf
	 bDotZjqqVVkRBh1kkNFHtnIxsAfZ4kvzBo/Uj3vo8VV8ByixHGb+NEquwLsDVubRtgPlk
	 vc4XKSHLSN25S2uYSplTrsRt6LUzeAqv+PvyzWFxSltQ9PEO3FH6gUZzb6fdmjCf+YxtZ
	 6sm0McMrbOv/OwQLkFKWX5hzKxU9T+3tS+5wgMemoKlfVaQUFoPq5Ks6Z5H/pUH1Zo9ZL
	 CxQE9vjHdQo+zNZ6fdHahFarcmbMcRED92UPzj6/q3xQCecl1zRe99rdLYyx9t83zSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590530;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8mNXDJzEPLAkTirj2phYmas51ZDGCneGM9OsyGulW/4=;
	b=ZO8b6LWxMyL3+cIjJlL0z4cDRLRQxUla/zl5Mb/nloSw3AcdyT0t3SCY1GnUxCFrbNf+
	 RtpuX5qU8zdiBofi0KojfuItteYLCLDGXA94F+fAI75lg00sejm1+18q+TeuE37qzV/wU
	 YMMgjMwafflFT2lW/i/jGE7PT1ktJfY6neoyXL/souGxzxVQDrBpl1PYcdf95YkWL0ozV
	 ilWxuaPSKZGF4rRscBdz+cu7we8RxIgqEGcLxbisnoRQ7A6+uvHuINF+ULYCGm3n7qi+e
	 /ZujrFdHeA62UBUa52XiISl07isrml96Eih9yjeei8jCUxYJGShYSzeFiddHx9/njiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eeHmZHwu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TyVawEib;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD58606A31A
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 13:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDD58606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eeHmZHwu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TyVawEib
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBinT84173125
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 13:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8mNXDJzEPLAkTirj2phYmas51ZDGCneGM9OsyGulW/4=; b=eeHmZHwuumefcCq+
	9Om0caRyw6TgR0Ueg2f0wP4Kw7z78dA7MDKTqPXxSJ8JeniikROzhDvSU8dphnsV
	BLBIUX2ZIA/DNy2XOaA5ZL3uZ7VtTZuEzKSbqG1RiVieqN1ZzZe6qo8E0YYQ81HQ
	CA7YqX9nz6OhWf8tGVi71IMxmxczDZqrApnf9uQR0ln+kR0rb+UDgV+A6rZ+/n0I
	bDs3l4KYF+3NtdunvfcNxhxaqZ8Kt5GJ1JjwYBZST14HQgqw4ULgtXmu6i+goyOQ
	DOf0N2VozTavvhu4e+0j0XKrbhIdgn1QhyOFiMXNbhBeQKqPbwwHem659865XvyA
	wSNbzA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0m786-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 13:48:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1f1f2ecfso20590685a.3
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590527; x=1793195327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mNXDJzEPLAkTirj2phYmas51ZDGCneGM9OsyGulW/4=;
        b=TyVawEibZ/vEiJ3s/jg2bHQr+/bUevZefvM5bi6ITSnuUJJfzqCEssQe9M4yoGYn0w
         GVg5phlm4egJhiV1O4PaXkWGdnArcvR5ithKWatLuVTUkIGv2PtyNjIEmsUZ8xsvVZUu
         ntak0XZlh3YXdpsrg0FueOnkxlFkHb1HyTcYmU6b+wStRgVUO5NkHgPdpdLP2liBbth3
         sSOcMp5VaneZrgrV4eLPwSkWxwFsj0yYz8mxYPjrY2HhFILOQydAjRts+UYi8/xzqtql
         1kjCezKuaaOZ2kiZ8wIBvzpjGH2r0Wfg/BqmkZ1xG8qSZHWloPuAACvoZPx/0d86PMxo
         qy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590527; x=1793195327;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8mNXDJzEPLAkTirj2phYmas51ZDGCneGM9OsyGulW/4=;
        b=QsAegegj407B+C+83/eO9FTQ4RcW97BCf8QlVmxOnwoFTXE8QWGuHd91IARjTg7Sk3
         T1UYxCthOg8ejqVLMzHUygI+kH4Mv5Bx+pMauz9sLCHBN0gPsvzV+f1yARIMezfacW+C
         lKUKM8ZIbEM/h9FdTyRxwjnJXiAaMpTUL5BW8YhVpzLgoVtaEKfyvgepw0izPs11KhIA
         e1NDoAnPxeSjxH/7DaRuEh0JI4dYuiHZdX/1DLo+5UPkSPZN0dHaDWTtWS/F/B8l2JTw
         pdgWTtd5nNsCZ81JLIOcGyRA1PhXtwCvmrTAuzjR5uGtw3lG3/HCcwPo6V+MsgVLYSua
         NhVw==
X-Gm-Message-State: AFq9FYJp8QV3NpBt71GYU2QGIRxoUNarwQ/pqaDwfJ4XY9NtwXQ9MC+X
	ZdYLbfAGw2EF2keACoSfoCjQ9/fR1yO6pqXkqQLUT6DizXud2zSespVbsminnxFBbzbfMej04TD
	oOOF1mDbUbUNa/ZLlY2H5S3TkdQCAQgfmDNU2pzqkk60nmMNoEhtOeQN9Osj+Gss=
X-Gm-Gg: AYBFou2p9tAa8kUB+TUc3mWe3rdQD63Yxz75mwCG39IoDpye4NuL9SqP/i1VLWPXigz
	Oy9Qx6Abaau2CVmnXUd6OyKo/GlHlbqF4I2/c20TATi+67NO/CHIix6A/3UwlHSxHPZ6jFJHql+
	FwNvu9VpF+nWXeT/O3wkD41sD5ouhgF2z/4F2fTn5uqc+DNAthLSmmIW5HX3ZFW9cUzaFvdJkyk
	zwC5BdUQXNJR/IMk/rnHMjbnZmrZTsVuMYgfVojwQSTI/phJjHqxhMOVRycUTrcVYO6Nkbb0YeO
	zkLufSfYDqKsWHTtUIEd2eO7nyea8sfIGi1jmMBBOnKN4cXOCyJ2THKwvZIYT598syMMRYVoXs5
	K/TN9ET6jsflod/vYh+iRkw==
X-Received: by 2002:a05:620a:2913:b0:93f:a34:d9fa with SMTP id af79cd13be357-93f57e5e2cdmr501591685a.1.1792590526847;
        Wed, 21 Oct 2026 06:48:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2913:b0:93f:a34:d9fa with SMTP id af79cd13be357-93f57e5e2cdmr501585485a.1.1792590526242;
        Wed, 21 Oct 2026 06:48:46 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a1f0526sm7553266b.1.2026.10.21.06.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:48:45 -0700 (PDT)
Message-ID: <c2b5f9de-d1f0-4131-82f4-396579520515@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 15:48:43 +0200
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
Subject: Re: [PATCH v3 1/7] i2c: qcom-cci: Factor out write command queue
 programming
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
 <20261016-cci-imp-v3-1-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-1-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX49K9fA23bERi
 AqenDw13Smu6KyW6whuYgorQ4fj4QN0++8AwBcmZJ2ktRGgcpv4FLtstccJvwoFFa+2BDH90l3x
 dCCiPwyV24Hj5gEhAiafFFbAJLGfkho7ASopFhHgNF8if+shF52fG+o8gej2WPYeqcEXL/DzBeS
 zJ1wYROwqv8ZycLX5FDA0FJtBPdnI92BsucBPZiadWxN0kDzD1oPZH94VrLj/pRfK+8tAoKi5Af
 sVpwzRx6Lwo3tz9kjewErrGF7HGbFMe8iWBKzJ/Krr2nxDWqmcZog+9UxcN/vZ4SauAxnxq8g+t
 DeOrdsCVNpsp7TFvuK7NQK0Ee8iohu6prkgjm8Ve8+OoqNj+OEtD3rCbai0dwlRApbvwpiDASL3
 cviaSqkMqrsSlEFQhaxUA6hVDMFiC/D5VsMr9yqqLc8+OLN1QXlxMHzu4G4WIVtMTNOPkaFvHhd
 0gfenyYPv9vtuO3gy9g==
X-Proofpoint-ORIG-GUID: UK3dZCIH8gZWzbrrm6PocEm1QjgYoRYV
X-Proofpoint-GUID: UK3dZCIH8gZWzbrrm6PocEm1QjgYoRYV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX9b4S8j4cYD/J
 LapYh66WJ6OJieSuJiDI/ol85x3+hh5gfp92TJwRqpiHXmRsxENmjxzWpzTJq0z7LdmyOQMtB37
 qNeZx/JnRoILwfpNgUtJlQI4Ma/ZikU=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad8c2bf cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=J2fI_2kDf8iagJYHrR0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210054

On 10/16/26 10:00 AM, Loic Poulain wrote:
> Factor out write-command queueing into a dedicated helper and replace
> the manual byte-to-word packing code with iowrite32_rep().
> 
> The resulting code is easier to follow and will be reused by
> upcoming burst-write support.
> 
> A command can only carry as many data bytes as fit in its words, so
> validate the length before building one, and do so where an error can
> still be returned. The I2C core already rejects a transfer longer than
> the limit advertised through the adapter quirks, so this is only a
> guard against building a command that would corrupt the queue.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---


> +static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
> +{
> +	u32 cmd[CCI_I2C_WRITE_WC] = { };
> +
> +	cmd[0] = CCI_I2C_WRITE | len << 4;
> +	memcpy((u8 *)cmd + 1, buf, len);

LLM says this is no longer big-endian friendly, but BE arm64
is going away anyway so I woouldn't really change it

> +	iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
> +}
> +
>  static int cci_i2c_write(struct cci *cci, u16 master,
>  			 u16 addr, u8 *buf, u16 len)
>  {
> -	u8 queue = QUEUE_0;
> -	u8 load[12] = { 0 };
> -	int i = 0, j, ret;
> +	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);
> +	int ret;
>  	u32 val;
>  
> +	dev_dbg(cci->dev, "master %d write: len=%u\n", master, len);
> +
> +	/* This condition should be guaranteed by the caller (i2c core) */
> +	if (WARN_ON(len > cci->data->quirks.max_write_len))
> +		return -EOPNOTSUPP;

Likewise LLM suggests this is an odd error to return and I agree EINVAL
could be better

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
