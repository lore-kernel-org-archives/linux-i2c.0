Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43393F44EA
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496127; cv=none; b=oRh9zS8B64jCtlS7hVicfY9v0Q3+E9pJZguoGmOmC6L7NXvCNb6sTPMwJS+6B2sgtrzz58iBSWPdCSqLt0maigbXenrgEQxDzYMwNS4pi3eshHyIsDD8OG4jhuKPOiAL4SAB2hsilrMopUzGYRIerL5nueTPwWbk6s0yfHI0FHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496127; c=relaxed/simple;
	bh=bmyLypJ4CyJtELPnoR5vlTsV9uyh+3EsheliTLhID+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNH3Ykd0teLDZw2ejuAMiTNsGbKviekIZLLc1hCrnvFzlQiEtmLRFjGdCItTBpWPAVRGXz2HfL0FJuIiuw08xgk+qHd7qTqgiAROrQHMKM06MG+IYEYpoy8Z3NAGxpar9NqbnB9uivQeMBDZcIO08y11xs53tiG/fO508AAQByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGYc6HUI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KkRWLu2Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGYc6HUI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KkRWLu2Q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842UpH1638163
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 07:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oETM6ml01wzq58WtJgDwwWqT8UsCDrD5tXaExKvIQJA=; b=IGYc6HUI+AgTxMWR
	AJ3s9WTaE5GC1W/wcz5qD051LWqxXBxrceqIaPtpUWG0k5tWgIt/Qfkq7Ocbxc6D
	IeTGzPuHTEedKrXMgkVJHiWEqaFdITXnf4PmlLRSw8xp41cjpq+0AbNEgZW+z2n4
	HuQLCQkz8GLo0CvdQyg7pMWrDdpVh5TQ285ziqzgcybtucnmTvVajR3GrLBz3Chm
	NqIPPVR5YBS+ALWKUyj4J0BDXCgNPrBPuxxSftIRBfogLRIrQ/YsK9WSiEKDTdyl
	Qj2C2mGvaHkuCg+MegmNCwljLfJLmwucFvcDc+RPFCOXr47wJWC9/Wc7Az4RszMf
	7Tp3Wg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9c6a9dt3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 07:35:13 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso631638a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783496113; x=1784100913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oETM6ml01wzq58WtJgDwwWqT8UsCDrD5tXaExKvIQJA=;
        b=KkRWLu2QHYbqRKQUWpF6kjsnHSo2RGxFFQK8uiLX57RZOM2uZLsYlewtCNnsrQgJKw
         4/Mexl4NhvSiePmOXvNMNCXIDLgdLSZktqLrh9OSoNogNzBCd7f0X0slFWx0r+bW0dEr
         bc6uuPvHcBab8h980ua2pl4G3emnByjJcGk41vyr/LAhABrTkJ74K/EyPZGlsbTLaoFf
         iBLWL5blCtPGjkNgYc11zwwjnYNRtY2WPb2ApdlptQJopBJiSMeQHqJL6pXONrLd81FS
         gAcXA6TH/+pRs205crbqI/fVL9ayg2/2anjaFEPARY0v9aJFoPOUwSL+vEoE80W906wo
         4HOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496113; x=1784100913;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oETM6ml01wzq58WtJgDwwWqT8UsCDrD5tXaExKvIQJA=;
        b=kz37b1+dckyVVXo61ZSOpkwuduyS5faF8JZ5v2Tj09xH5gjM0HeOEIWwG0rBJpeqxT
         nyInasWsedFkJDygZUA9YF+XrP5tzPOrFbKEKw7N8J/ZH+ifQDiGz/zkHaKjNP7mP3Bq
         3AEbped2vDW/h2AwJGwe0KJsBjAfr/N7IVX5tS0Ewuw58L2UmPUFntxcvAarnjGOUyWM
         Vw6o8sbXmnOS/g5YE8sdKuXCTiSfiy6QXK0zQEsSRVYiAPZ+oBxXVoi1KtkAVSzbBGMr
         q3tAwPjLwiTpbxNfhy3nw5et/p1U84rov2gNWMS7I7MJZ7rGmt7KX3PueJ/lLujm7Az8
         TWPA==
X-Forwarded-Encrypted: i=1; AHgh+RrDo/6cmbi57gHWdbYw9msmvZ1BmkiG37M5fobbEVB5mOCXVk+PTm88cs12ZxYV28SzSOWVDAivBtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxom1LnnIDvf8DVCT+C/JLESRio7gm1WXzDQ//yvxEOnoa5Uqnl
	uRq7yHxBLoGrUQHW1meSrrATO6AD6PRBoiDApnxfgtG/AKbybt81N7Kl62VFXmSKEL3h9RAcLSZ
	igBsXae1M7G6CBQ7ZsfUDtDAFmcRk6bUdoPhg4PkIuY6KghQK1v+7VDBqxzLs/d0=
X-Gm-Gg: AfdE7cm/IlqaCYwjQDrYZ5AHvRV496uHJ4HD1lQD8Ny31fCl5FX8gc0SvyObwjMfMS+
	4k3sXDxEmVmsa7OVA8eQldX4uu9pR5OAPhPF4XoFRaO+VgN9iF9jQBhYqYK2D0xhkn0LFWkWWKT
	0JiPGm8+W5x6i+PTmBvr9LLxHvT9Jmiv58VWPF8BX0lEko6S9KrB5+rCytTV0FHRO+hwGbFmdyX
	5L4XAFirAXRQcr9k8jfoLRFem/tdDiTuF23QilwJ66nI2fFDhZF7tTawq0NHEN2RFThu/rpXiUs
	B2HHCdV++vY/En90v7fsHxHrxx12HtCt6DrziL0s+OFJNc5fXyLctiHqDq7jR4vIU3UJeAYp13F
	Rur0DwvUqKeFi7FHRc6qFn+d4SWl9BPm6CFbxdofZRaVz
X-Received: by 2002:a05:6a21:4902:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3c0bcbcadf5mr1714167637.35.1783496112795;
        Wed, 08 Jul 2026 00:35:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:4902:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3c0bcbcadf5mr1714136637.35.1783496112386;
        Wed, 08 Jul 2026 00:35:12 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643399sm2067251a12.22.2026.07.08.00.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 00:35:11 -0700 (PDT)
Message-ID: <5cf8bf42-8293-4672-b6b2-226ec1acdb56@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 13:05:03 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] i2c: qcom-geni: improve transfer error recovery and
 synchronization
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3MSBTYWx0ZWRfX3se3Ixsdjj8s
 CGWcD3LXSa39NVMtekWq18BrI/C7l08/KtJaYBaEkqNhsBYdTa1FRYBsGVKtz5q30BIgQL6bAGe
 AwR0ivILP1eEnKon2LtS6UK4Vyi0UZa6LkRxe+XerjI6SdxsQTJgsn5Nnd5roZNiixzs6++zEbp
 XEmMTszfmoNncgCWy7FC24wOeWOfoHgO3W+j7pvgybOCW8zvRaN2cVfwfgg8144ozNqLyIWZl3p
 kvoz912j9VSkb4BIKPiHH/x9Fagn3DC0ogBO+Nve9KAS6YYcDIy5pZ5Ty+nyki+I419Ug74w2bZ
 ubX5LYxjZ+vzp8MSAkV5JT63H326fFxNoYyqan28j/UIpPL/FXLsPHNmQFJa4MYzdpkG6qJsNTd
 1R/Ysv5BCkmXmDnrO+el1pbQsh6uFePn2Nqi+dLNrBoYjXahhwbjpBM6rzgIFwQ4BprGAnmlG4Y
 Ox8E2l62zXB1hIYfgNw==
X-Proofpoint-ORIG-GUID: -mRg67xa4aY1utHmXfbiJ_4IxP0MlTw6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3MSBTYWx0ZWRfX1JC8VC/4Kwfr
 ZLZtja1xDXeAgkYq8Wv92Hobg0K4ERDh34ENZXbfILFqljDRsf41RRS1bnn+u5lSTN6/Zc7K26r
 y+QfdtIK9N9lHMAda2G2Ck+FLtykYE0=
X-Authority-Analysis: v=2.4 cv=UehhjqSN c=1 sm=1 tr=0 ts=6a4dfdb1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6jiF5cv_vgskca90EcIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: -mRg67xa4aY1utHmXfbiJ_4IxP0MlTw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080071



On 7/8/2026 11:45 AM, Praveen Talari wrote:
> The GENI I2C driver currently has a few issues in its transfer recovery
has few issues
> and completion handling paths.
> 
> The timeout recovery flow directly aborts outstanding commands, while
> GENI hardware requires command cancellation to be attempted before
> issuing an abort. In addition, multiple operations share a common
> completion object, which can allow unrelated events to wake waiters
> prematurely and lead to incorrect synchronization.
> 
> Address NACK handling can also trigger unnecessary cancel and reset
cancellation and reset operations
> operations even though the transfer has already terminated during the
> address phase.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> Praveen Talari (3):
>        i2c: qcom-geni: use cancel command before abort on transfer timeout
>        i2c: qcom-geni: use dedicated completions for abort and reset events
>        i2c: qcom-geni: Avoid unnecessary transfer cancel on address NACK
> 
>   drivers/i2c/busses/i2c-qcom-geni.c | 100 ++++++++++++++++++++++++-------------
>   1 file changed, 66 insertions(+), 34 deletions(-)
> ---
> base-commit: 2b763db0c2763d6bf73d7d3e69665222d1f377cf
> change-id: 20260703-fix_cancel_sequence_on_failure_for_i2c-a868571f77e0
> 
> Best regards,
> --
> Praveen Talari <praveen.talari@oss.qualcomm.com>
> 

