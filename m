Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA4395AE4
	for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287244; cv=none; b=avrbUimqMX1m3OtkRh2o33uGwneHZRbFdaPGb/Yzb5jDx8IMYGP6zbV6BWu+pnZg0p+ajvAznb6kSbSweJAZnTo/4KBHHF8dYuxiqwUEAZqNWk5l7l+0qSRaHMGoqzKKdOnw3p5XgC9QMR+C/kKtIukbeUZXB93i35MJfgeBybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287244; c=relaxed/simple;
	bh=SubK8zh8375/xh1JLgTbSXAfRTQrObsHSJUFoEOOZOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5pNQOvR7z4vKx+zyBtJcI5c8t4KCYbwUCXn+bawX5Zif5Pq5nmzfAxTHTzo3d+DefXu1358UwW2oRR2zOjIoVhHAscL3P9myhdBhgwnFBmkib4x9LuRqlduVqEle9Z1myR/YQJYqI5YZTOD0xsEHkXeaBPys+c4HtrdBVJNTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMGb4dDH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3qN80LE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMGb4dDH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3qN80LE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5tpPd1971921
	for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 07:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/g4fRALXysleQymhzTRyHSwPBhUJqCQ0cZjYYVP6ilc=; b=BMGb4dDHJyH/0WEN
	v8/5eV9pYq5LZDPtvFoG8vxESxJYIDq7nrMFWDwlW98oXAUncUy3amdI4f7Zal7s
	ABE7HLm8xtm3iW3pyaoOUyfYERJhUpxIjtduP0bSyNtqHTLGFE7B38+KnLkTk48r
	N4H1pb8BfiU89LfCVNL5XdFk1S5rs4vHPp8BsCEnbXggr54e41fLs58v0NGKj+Ww
	Veavpn/+RBGPde6sv2G0oqjCpULKNFUut+OzkqKrGnzstWsx33tzVALLzpyKTtGG
	o6wdwwYSObBylDHYWHDjedLHHFfxHqqCwh+qUhb1KgGxUyAwN0ABJYMFk/azSm4q
	FJXG/A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f00eva0kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 07:47:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9156dc90fdaso14523385a.0
        for <linux-i2c@vger.kernel.org>; Wed, 24 Jun 2026 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782287241; x=1782892041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/g4fRALXysleQymhzTRyHSwPBhUJqCQ0cZjYYVP6ilc=;
        b=C3qN80LE3PZ0Ab4yqxa/eObUcZQgRCZBXoYOyyyaCjmu0zk2GcZrV2qIHzlI4OFsu2
         QWJ7kxDQNHg+jp2kyMt6Gc1SrOB+dqHsvfLVnt919U/qC+tPtgXL91d6NH9tp0ll+Ttt
         Ijxs7sVbDv6Hlil5DrHJqFxE4bT279QSnKf+svEhp5/hdymoOpHhlP7+HHdl5zoasKxd
         Cvoqg843McSHJCi7Jxl6mMK/hkbyiQyVIuZH4lG1BDzfJCG7jJltcUmX4+OABqFWZ6v5
         xeoMrJsMI6z820e5Hq/XNbSevJkSpxdu5I74iOWp6P4S+KAueY6LS/CCvl9xXST9sIoq
         E5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782287241; x=1782892041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g4fRALXysleQymhzTRyHSwPBhUJqCQ0cZjYYVP6ilc=;
        b=ZguoG8kKBu3sX5mn2GKY0Alfpkui1yIzaqxRBwyiqk/2FS+aH01lTW3o5ojiWEfuFQ
         LS35MQa9v5CZCyjrdwlXAnk3EbEkOlsO8SWcvINoKlGMfuuccVIDaqgWUSelk9KRaMJJ
         wrDuBXAZWBOg4Kr/xekTgyVKwGk8aq0kd+OTHeliJO7M28AJ//jnsYyeoJRNZkS4bpwO
         Qpeo8ydgJr0o0I8gUPRcYuUwsTp5Mv/12npVrz2A1ujrSMcobqEJvu2HXmIiogdDvRRt
         IljwtIthCI90QMI2iXnlmIZGHppIUg0Ix6bAeaMOCwV1FMzCJPAmmbmYenSw5KeOI+h/
         T/zg==
X-Forwarded-Encrypted: i=1; AFNElJ8VSEW2+5hxPRLoMNTJWYuhfnKGelX3UwCwfikbJdcRREn0F8sHwXAV3VesPn3wCMqrQqevYSzTqpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOO7k2cXyWBiwcaP2c24OcMbcn5GhmfoZxWG3gIEtvzXfEJRyn
	Ww5fSTTgULSFBzX5kAhpMsdt4h1/ysekFnZXZmGmSPkMmuXpGdrqHSOgRDZV/2ePe3z9Z3woLjS
	nHjNi3sglNZqY6nWmHsjAV9KbJl2iv3LpPBU6TdDjAe61utuIqw6ivR5ht1mnRpEj5XvNoHc=
X-Gm-Gg: AfdE7clKlICpoXicsMBfQWJ44YZMZ8SywsF5ltjIlIoRE8ZRHFn/lTTFOdgKdEPMjz7
	REkAgbiPVXZErLnCPHlzpghM+gJgU5l9XShgvI0JFD4MMBiR1eI59hAL8uba2HC1Dxc/SsWljaF
	i+er5UaI1uGTnGCmBLf//Ylp8LGNY/fm2LH1kieCndiAXOEJZ8uYeOgH2UsqProHP4s3zXLMMyH
	3i/1gg+P5XuZsREEZyxE6IFvsYrNFpGEaCx251tJafv6FJu3RUCdUhBt/BQx22dX3UPPvQW+agJ
	CEmdbMu/2WOCpX9G6or65Az+4aYJ2sQFexRNe96coTNr4T6FhPam6ZFh0qBgLyUZYEcwG/56Uuc
	DxECYsT3LDAnVTnRIXU5a4jLfccq0uuGTaVc=
X-Received: by 2002:a05:622a:b:b0:50e:487a:bfef with SMTP id d75a77b69052e-51a60d5ecfamr25152981cf.2.1782287240964;
        Wed, 24 Jun 2026 00:47:20 -0700 (PDT)
X-Received: by 2002:a05:622a:b:b0:50e:487a:bfef with SMTP id d75a77b69052e-51a60d5ecfamr25152801cf.2.1782287240551;
        Wed, 24 Jun 2026 00:47:20 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e498cf8sm603381966b.13.2026.06.24.00.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 00:47:19 -0700 (PDT)
Message-ID: <4fe3e01e-93f7-4832-b93e-d006c644b3ce@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 09:47:18 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qup: Propagate clock enable failures
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260624055237.29977-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260624055237.29977-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX1TCkHJJGvsL/
 v2XfivINq2B/BCWXJwozAEuX20mu24xIDSNsSFvPxgL4s3NKFoQjWUXTXqY1CW9ycPTWpBCQ5+K
 xs3UZdSmnyaOIvkEktYQjACY+ClQ1t0=
X-Authority-Analysis: v=2.4 cv=JbaMa0KV c=1 sm=1 tr=0 ts=6a3b8b8a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=_6zfsGPuifU0wGZyNaAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX7Qunqi9/88oW
 ZDlhhn9I3NLm0mSiu/lc/pwNkoBuRV+VXSNOd/Rw6Q6E0RPrHQ//iNKXNN2vWcj+FUpPqIIwhmM
 tB08uYdj4UYlueYdciBnTNIV6EEAA6i8XF2zaVzocXaexCuRt+GAhRlqFilBpLt0JbKhA5SH+X2
 2oA5g0gUaJ9rrgcvCl+MqY4doqZd0l00XSwt2f5mcpL4B75k+1Gnf0QFi4pWwkTE3wQT5v62X0E
 WCKjOg4+5p5XVuKfefWDZwC9BYZ0G9pgGYuommY22ChU+bwJO9FH1R7+eWX417xDXTJ+KslZL3K
 c1AjvCJoNBINhadGGlIChkVL2yiKJctdjKCR8gY99cw2ryAhpX5GzfE2r03XgyCASLv5Gae0r52
 uDbkS06WkLeHfV2staHPYpuE4NOBdA==
X-Proofpoint-ORIG-GUID: YI5OSMjQbMtGkosnaDtOIRDbT2z_reeQ
X-Proofpoint-GUID: YI5OSMjQbMtGkosnaDtOIRDbT2z_reeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240063

On 6/24/26 7:52 AM, Pengpeng Hou wrote:
> The QUP I2C driver treats the core and iface clocks as required
> resources, but qup_i2c_enable_clocks() ignores clk_prepare_enable()
> failures.  Probe can then continue to register the I2C adapter, and
> runtime/system resume can return success, even when a required clock
> transition failed.
> 
> Make the helper return an error, unwind a partially enabled clock, and
> propagate failures from probe and resume paths.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
