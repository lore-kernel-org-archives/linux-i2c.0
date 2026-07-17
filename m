Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65C732B118
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281210; cv=none; b=Q3wRnArzuJv6zwzUSviOwBYPYr54gZW7o92px6lYTlMpcqEQKfWv67asVjvNyvkQMAmmniLQ3cb+lYqgh76u0Vp0va8pu7JWfx+YiGaQsrVybXNKh6GEfSdxDq/iCo6DMpDgXptcfuj1vylruaZt/6fmrCT/oVtzvwVtI6nChZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281210; c=relaxed/simple;
	bh=YQCwk4bp0PA+qHQsrjsOi3zVTZr/VEWJbRm3ea+juEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7UmcC9P/ev1Q0DO/HpReC9h4Kgji1RF7TeC4VAmamL4yCOKFevkiXiCNIAOQwKgO35vSYX266xK1r4sKJQVIraBNUYr9QNR5u5H81sa2lVH4qnoNqrEkTs/F5IT2W+MZ/s9BD5zzzGE+VUeho7vvc8z5+xIZbl30BiHSvWBRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WY113k/I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DiNRvAC8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WY113k/I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DiNRvAC8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6d54E821203
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 09:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dcpk07oZraCPhKGl/8f8pKfXbK+a2naoxCJPU/iKJq8=; b=WY113k/ION4MNi8W
	C0TvnMk2KuNiT67xrQD70k/4Fba1gqvN0HwqZOEvViG7Y5jKbLc2y8YwpMty6aJF
	xO1REocUs0tw/ppl4wtmEbckb1TIya6JOe7yrHmilCEP/N/ZSwQP+DRqzKYAMBoc
	WlUKywpMA47WrFYqiSVEqtS1l0scGI+vQ+OY4QQzGL+gHL7Rv3yswj2+bbxw8As9
	aSCjY3NIDpAcDFcAelEEizj/4+5vyXc22L7TVUufkQfTr6qxsMEDpFhE2bu///L9
	YKjvuQJaxhorOhLJwZQt9q3K8tAuI9llkx58pz1G4ezlZwJmC18PTb+hExtEG7Iv
	8IXPUw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffag8ne3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 09:40:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccafc5e82cso56233065ad.3
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 02:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784281207; x=1784886007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dcpk07oZraCPhKGl/8f8pKfXbK+a2naoxCJPU/iKJq8=;
        b=DiNRvAC85LvFoo2VurQZuZIhwFDgAf4Dm85Gsj8QhismYiGq33tACRpYE9ue2aroGI
         MQanPGAcdVO+9yBoWaHU/Zof7bo9b6j87S3JIuzPjmwYrYj4ux+a3SGqbXRmFkqMtIji
         Q0jSLqFRS9y7WZxYi/8+NZs5LucvIiClbZpC+COtNBLQKdLIIEGZO6Xc8ChTsMXnRgoX
         qZ4idfbTqnE8ObeShoh5fGGv4MJUonV4bsVjGmhmmb6z24KfRuVcyP0kS64ZRONOEDnP
         lipQdhPQIznTXnv4HaK7FqkSOUDj/fXgHQTs3hWzSdoWPeh2uMpI1BtFIVk6W1X/sLDM
         S3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281207; x=1784886007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dcpk07oZraCPhKGl/8f8pKfXbK+a2naoxCJPU/iKJq8=;
        b=tBSGFOk+k96h6lfuhcccD2ElVGJkbe5uDhTOZM2OpGFbIo5RRia4XILWGnEuuRC3TD
         6gBcasHhQR6wKcK1JvY+aZtdVC+8thdPRudnQ3poSunoCoF9mikX/w8EdtnLxZh9uVHJ
         Z97XwmmfSJzsMRaqf8+U+GfvG8zpj5k/X+HiherV2G3hpnvIM7NhowjjfBdR4a4lWXbD
         bZ4DqmBs5pPZaYstQiFM1qorXvfy8GHraqL7FgcalQ4dHBXt1Mf2xHdVjwAUAmm31AsH
         +FgFUgjmhda+qVmnAi1Txmj+t1MiSwIzbhcF3T4N7d9xgG4lY8cGHXrzE3QYmPxFoqxn
         9uIw==
X-Gm-Message-State: AOJu0YzXyD14E9JVUC2H3DqXQ4qqHekAKudS043H74WpPs9xKy33USvC
	JmSp6E9jK5D1SqwvH1GE0c54tTg/xSWxlAytJ6+p/fi5MAXCGS1CWmc/u50BEDBpIYSHb2iuYw7
	AH9rSbodU0HgA2jf114iDg2RdlPAroQyRQZGxfDKov1ykoSyiFRUFXdli9Fh8r/k=
X-Gm-Gg: AfdE7cnHxbH9Jelgq7wcRGMA8lELGe8gqOjaZPZmTjRqytSiqOaALuxatH3u/c7Rw3N
	nJx93LH15Bm1mEtKn0p4NyaYdLw5DuI+1R+Jy8butRKva5JrY3EQzDZjAGl+LslHWo1L0a3lY9Z
	K/7xjAf0NzctGbOJcTHohl4Y97f5ZFvJLCJUJwQj5Apx/yCEEX9PYokQbHayxKL+BN40W9zPJSe
	nmMi8oSDBjXKBZVqvUjfgKRhxgyMaZUqC/5E2fgEiAFdRowNJ3czw5tpjiDZCMdNcR1V5BzEuhj
	X9C+Dg/yBO0+YT0Pt+q3E/z0a8NogwLuvlCM5oMo7Qd8chbo8a4Zv/uV9m0Bsy8oCBQ/tY4VqHs
	dMjFZIdhwyyqdDN5GMGOK6WW+4ZMhrHczTrk=
X-Received: by 2002:a17:902:f70f:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2cf3485048cmr21452785ad.5.1784281207235;
        Fri, 17 Jul 2026 02:40:07 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2cf3485048cmr21452515ad.5.1784281206807;
        Fri, 17 Jul 2026 02:40:06 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f4481sm7545845ad.32.2026.07.17.02.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 02:40:06 -0700 (PDT)
Message-ID: <eba6d3b3-b5ee-4543-a437-4e7c16c5653e@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 15:10:01 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: iproc: reset bus after timeout if START_BUSY is
 stuck
To: Jonas Gorski <jonas.gorski@bisdn.de>, Andi Shyti <andi.shyti@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Kevin Cernekee <cernekee@chromium.org>, Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260717085507.34209-1-jonas.gorski@bisdn.de>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260717085507.34209-1-jonas.gorski@bisdn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5NiBTYWx0ZWRfXy4P+eDpdzwx5
 /HkoLQTtX70EK8K/HJ3FaL2sOAayIqxsMit4uK4kszkvRB7O3FUcOOIZd+u/qrKuBkKXVul4la4
 VFXpzlBNz2YkEIXcc/gQjy/XmJCE9ypKTphqVT9181lNrtwV5DjxuvPMvjHkP7XjPNaxrmiK+Ua
 v5aB2aX3mnWwZuswr+l5SBEnMtR3qZIrRKxghjxJmibU9M+lflpvqwjI03zkIZrVh44comPXqUP
 oUWbJE5ShMOlWFXdUvqUQJYAALVcUjuY+pHqniVNBr9RgDoHe4hPj1zGEYxMhjf4pBRXuyyTc5N
 pChNJSriCmpKcQYeJkwt3oUN6cbSOskMCSS8+/ciO//7Lb3BQBvEUCk3jtcNbDj1Ci4ZTnhuF3q
 URVSZzl4aXVZp6AfAnlkGdZXCrIQ897QAkI6mWTtflTq8rbzrSxQD9Qt+GuORk2PpLfMFOGKwpn
 fIpMIcPR/xojX4LAWyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5NiBTYWx0ZWRfXzokxl0IH5pLg
 6/EY/08/KsqEtr7qRXTiYGtSKj7SKrJDKVzyO5472QESf0YvFz6LDrUYklSfAaGjIf7kOp5mt1X
 N91gu0Glk6OwY11l95ftJobfpsU2PAY=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a59f877 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=vjGmwFoGhKkvse4UqjwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: x3rL2FbZIOoVfrsn3hTvuhKMZD3IT1CE
X-Proofpoint-ORIG-GUID: x3rL2FbZIOoVfrsn3hTvuhKMZD3IT1CE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170096



On 7/17/2026 2:25 PM, Jonas Gorski wrote:
> If a transaction times out, the START_BUSY signal can stay up, and
What's exactly START_BUSY signal
> subsequent transactaction attempts will fail as the bus is still
transactaction => transaction
> considered busy.
> 
> I can easily trigger this by attempting to read from an address with no
> device, e.g. when running i2cdetect. After the first read times out, all
> subsequent read attempts return busy.
> 
> To get to a working state again, the controller needs to be reset to
> clear the START_BUSY signal. So check for START_BUSY still asserted on a
> timeout, and do reset in case it is,
> 
what's here after it is, ? wanted to end the statement ?
> This is also done by the original non-upstream iproc-smbus driver
> implementation [1].
> 
> Works around situations like:
> 
>      bcm-iproc-2c 1803b000.i2c: transaction timed out
>      bcm-iproc-2c 1803b000.i2c: bus is busy
>      bcm-iproc-2c 1803b000.i2c: bus is busy
>      bcm-iproc-2c 1803b000.i2c: bus is busy
>      bcm-iproc-2c 1803b000.i2c: bus is busy
>      bcm-iproc-2c 1803b000.i2c: bus is busy
>      ...
> 
> where the bus never recovers after a timeout.
isn't there a max retry count ?
> 
[...]
>   	if (!time_left && !iproc_i2c->xfer_is_done) {
> +		/*
> +		 * The controller may fail to clear START_BUSY after a timeout,
> +		 * reset the controller to recover in that case.
> +		 */
Make it simple ?
Recover controller if START_BUSY signal is high after timeout
> +		if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
> +		       BIT(M_CMD_START_BUSY_SHIFT))) {
> +			bcm_iproc_i2c_enable_disable(iproc_i2c, false);
> +			bcm_iproc_i2c_init(iproc_i2c);
> +			bcm_iproc_i2c_enable_disable(iproc_i2c, true);
> +		}
> +
>   		/* flush both TX/RX FIFOs */
>   		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
>   		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);

