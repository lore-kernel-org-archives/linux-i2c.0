Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDD3CA4A8
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556766; cv=none; b=SI/VT1+xAGZ50C0UHd4SmB8NLtYh0ReuwSYO63xMvF6L2YL6Od20ZjAkYgvLgmuNIpuJIMtoGu/HYzieftB7EmUD/RrhO+Y1tgpRV5eD1YcUp1XReDpxT3vJF226NWa7ESYlNpGGy2Ig8CEaIxbfpWTdeD74mZAkXvEDjZ1GHgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556766; c=relaxed/simple;
	bh=nk1Fl85AwLsyujcFprh5cdau31/9RiURmNkcfy4b2Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8PbJwQrYRximaXNXLj0jDFbJo1s8GJE1yge6NN35UjleqrwMZ6KvLgYP4OrbfO7rvTJ6Z0xnGImM90UylrSJfXS4ktDioXKqoCN/Maz+p7fFvrqKMfMHtpjKqZWocMPVix1HQE1wHoFpk7SMYLInchSNiQ3lxVg761rE3ZWexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fICjw5Fq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JY7dH+vt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fICjw5Fq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JY7dH+vt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CGqBFX3164983
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 17:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahKXfZ2L770e/Q//+DHZRZ33E/ISorZ8vk4O7I/xg/4=; b=fICjw5Fq00vBYH4W
	JrS/qUZTzH/X32ppo5i4WDq2vS6JekO+X/ppz4ABtdKnKVfPTEc4wuolfRxSZJt+
	CGBJelw6oJ5/ws8qDI8k/KJV8j/EBq6F0z7JYpTGxpIV+sShx7IStRDf9kg+dryo
	Nx1eqCu6KPZpk0/JhIdDcLXQX+T5Jo1NuVJ0WpbBLMBQdKqXGvdcnYpBidpdKCLW
	kDAy/jVnrtcAJ2NU78D+GR0qUEd7PzGVq0DZtjUkDklsHJm0adepZat4Cooqr7rO
	sCJPSmGSREt5lBqGVEFQ83GIDMV54AllJW5Ut1ZjIY6LPPKhpxkBZ+uABJr1DNHy
	uSNDTQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw3can-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 17:46:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc6dd43737so24641595ad.2
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786556763; x=1787161563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ahKXfZ2L770e/Q//+DHZRZ33E/ISorZ8vk4O7I/xg/4=;
        b=JY7dH+vtge7IyvRIo10iGDLuaEusEgXeXfq30CHJsSrUSXeq/8AnZ9yGMuRtg5OE0k
         Z2I0Q4TVteAZbLQ3REFRuCPH3Nkz7yFIt83aL+RC2k8KsrGUb8ZFPRTwGkcEO+miFYqE
         +Jx3F2P855uy4L8olChFdotLGBP7gsp3nxX95EQBlUYk5Ltr76Au/Q0sTnb/CngcXSuA
         mISLuOuBhAgOC0A7+xKQlmWovsafYdBrGrn6OA7HzKgQyE3LgkPtQnhY5/3Wy7FZ6ccg
         3oz+hthDTfxzOinZ4EbUlDgmByy1NwpTluHb/1n3kH8QYGVdBZs4Mfs/nLLIHrUt4GOH
         N8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786556763; x=1787161563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ahKXfZ2L770e/Q//+DHZRZ33E/ISorZ8vk4O7I/xg/4=;
        b=N2rKRq+oQcYl4xmkji8Hf2PsxtwSEoHv9Sx24CW5Hbk4hG3XM7XWgGVJKjFEaDt3fM
         rwCbvrrfr61FHux/ir5wRwWC2+CG8Eaj8aL1ktp1gZKRJ5zr+jPYLPufLojFzo1K/SlJ
         SVHuem7kBKzBQam5nqXzJA3JKPhADky8yMgI/ui3hfJ4rboVukE+wCjyvypNke61Ubq+
         bI4+7GF09dZmGbgHghfY9idaUycBiZnCrkSHJg89Ohytyeh4qKa3rRTzYLq+3BW0SFob
         BEjjrYfF/2Q6+uNuy1m05EwxAZt5ECZfuOUm/I5QtqxwhL60GrsGVSNUtbK6NTxxcKyk
         0ZHw==
X-Forwarded-Encrypted: i=1; AHgh+Rqy5Ztlu7b7iBpZxuHwtJ10up81cxDOSvzyiFouse4d08ux52bVBdVMWjeeSyoVal+5NgYF7lHJAHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BVP+48E9gBSzTgND8LDWEXmA+KKi0oBDfLe5GsevfLpcWRe6
	b6xLXN/VCWiJOSPRmVB0aSSYO8skxJj9c+VqcsHEhzozO5Ghoa6u5OhHMkKF4/OdNxc4j18YayM
	9zrTyI3nF9ZEPGVE5p0qqVk1V2otV+p4a5L86m/s+cSTsXDAFKS/8hwvokexPad8=
X-Gm-Gg: AR+sD134jCoXxuatPEv2c7lrpzowGVpUs8pDow8y/YwBIY/IbJXrMQJfwYjNUCqkary
	tNrn+tW0pcn0EO8H7p8A6GNOaWHY4CpORr4I03bchDCnR7kmVVUcVrq4+8mvYwL6U84d7jo9fbc
	ujeoN5WNeL85JKkHxuK3OOpHJBOTSMkIdXtUmiyxgfWAY38Q8pFSGD3jgdCE5AxWyF4ZAYfIPng
	RJbTrbjUzgulN+XN7E00tZ/zmVp/X8QIG3RCpcPykN2cwvZthOyOLYSTFpSBCgjO8xgyuZ3iNNt
	mWbaUnjbeB/zCP7SHg/+wH3bHX9gNMbtA775KGvZA/xhuONk8lxsF7NCSiemxYAp/4R3bhMSo3u
	w5D8gvmbGOT0daupJkiZ/ycbs/Dk3qFVuwF0=
X-Received: by 2002:a17:903:292:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2d3456637e3mr88725245ad.20.1786556763187;
        Wed, 12 Aug 2026 10:46:03 -0700 (PDT)
X-Received: by 2002:a17:903:292:b0:2ca:ecfa:1308 with SMTP id d9443c01a7336-2d3456637e3mr88724295ad.20.1786556762588;
        Wed, 12 Aug 2026 10:46:02 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.230.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d37c49ce11sm79005ad.67.2026.08.12.10.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 10:46:02 -0700 (PDT)
Message-ID: <eef12701-e916-4c4a-9dc2-2b6836e7cf59@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 23:15:54 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] i2c: qcom-geni: update frequency table to fix
 timing parameters
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfX4zq3jmiL09cj
 iNDLAJiUYsum4kXvVkqTAjmry9567Yx3NlotEXskK2TeBPulE0Qh+jYEHcHWGJHfjfdYXHzQQWt
 93UwFzWq1x8WuJxpB9STS8Wc/OsYEJE=
X-Proofpoint-GUID: Qhcuu8nExQMYC71TJ-azoW9f3b1dO9CW
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7cb15c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=hsRoOqe6K9Dtf6G3Ghy1+w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EdN727LykUWWqtJ7AlwA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: Qhcuu8nExQMYC71TJ-azoW9f3b1dO9CW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0MiBTYWx0ZWRfXxGombfkQRfjK
 axaAq84NmziwUUETIEz2LtBxd4sKSM8BMkWJ9GaE6gSXZdQxhiN4IV7BO+ioYx9H99VpJhkBLuX
 U7XgWWdDqXEuDSv3WilHEnDI9VNsWnb4pastiaAbVD1cQk8lFIIGrfmS6hgpAnrOIIBbGGz9ILp
 W4ZrbDCdqj3n4cs4PXGGw6N3bW5yCX5Tsz15G+YkiyV7P/cBkJ4fOLkKX2BymPiUroDaoN2+gny
 14dZImIglVpFqZo40v8PQE9PrekvBPbGQCdS/NBjLXi6dA3GqPY8Tfr8tmajmKz25ZA0gZJu8Fg
 O1s5/sRXnOILqZlj+Y1LnlzHoyID56iIQAwcZsQ+ack5QCZ4yTyYzA69j6aEsW/YscpLze6uA1B
 4oRRTwiNzUyMGkhAy4j4/Q/VKXzkv3Y3bwNGKdYB5tpZOJTvKa96yGumWn+5arbd/mD5q0PLHtO
 KQfr0T8yzZetr4GCJIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120142



On 8/12/2026 2:00 PM, Kathiravan Thirumoorthy wrote:
> In IPQ5424, to meet the setup and hold timing requirements in the
> standard mode, update the frequency table with the values recommended by
> HW design team.
> 
> Also remove the stray space in the I2C_MAX_FAST_MODE_FREQ entry.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 85c34532849d ("i2c: qcom-geni: fix I2C frequency table to achieve accurate bus rates")
> Fixes: 506bb2ab0075 ("i2c: qcom-geni: Support systems with 32MHz serial engine clock")
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
