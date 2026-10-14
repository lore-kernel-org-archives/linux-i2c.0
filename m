Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F256E059
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003831; cv=none; b=iAy2QHKgMwJqKMlE6n1Av24+W+GXr2eJsoGhw78TBi+Mp5NCKG+icQ4pW4U+7SwGawqi6Z+IzVJheIQ2XKFk5YhAneeGiH3nWghmhbtDhlnA7oG9WRFx3uWizmpqzUU9AdHDjLgL7EvcRP2PpMSe5NDCGpQ+2IfprAGrsBRSQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003831; c=relaxed/simple;
	bh=7ah7jUqQtUDrn4PSNymda/Iqm5p7zMRB4PxJ+OtxpWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XljxNE273XXxKS61SegY8EF1mHDNsd/Inn8v92GIpF5WxSkYbEfH782E2hIMJ64su+bCn7MSKDKJ6iMsQExciWRb/jXv0jX/WqKeJ1G50uHBMjKJtOOzcCjnkAKyVYLUpbZCPmbwmudSP+OipTm1e4Tn2QMHhxZ+yRZaRwlGrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLw7FgaY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CDlyxjpb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLw7FgaY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CDlyxjpb"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EFMi5M1682636
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 18:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QmKAgT+BMROb7bsj9FpwRJzAdtcudV6UZcveycRYTO8=; b=hLw7FgaYpyNo6zxN
	l8UvMhOCymTJmyoS3bWMjr5HzJVHGUDmM15PoeZw62rTAv7lAWVn+4w/Hn5g1+4X
	/m3XN9322dQYzH9LtDo5PYG58tsWg3pKe4CtmZEZalzj1aiYPrgalBB9KeuhcMVa
	BjmDS62vTj3Cuh3fTXBp0SJqfQjY8d1DAXX/AKNu1k1YrIaTOed3GbTA2OUWXI0b
	5Q0OHU11f0kfDr+XCUAoOHBPuYcu2vtzh4LNNBYJz1WtBvllA9e5EVxr1BQsDWjP
	ON1rFDnOcHjgSE319n24TVY1oL3h6wsAC8z3P7FyoemA7Qxus3vGzHqRDohxXyc1
	mVfA8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb00u4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 18:50:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-359b81ad4e8so1914202eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792003826; x=1792608626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmKAgT+BMROb7bsj9FpwRJzAdtcudV6UZcveycRYTO8=;
        b=CDlyxjpbo4zfV8DHanOTSiS05l5uhhmSw4x4HmEeO6jd7EnFjH6mgXE2HrctTZPbN/
         e8SsLNqVy5gBLbCh8DDpE2cV2mKYOfynhO9ia0RmoigQIVmBmzTeXl8VlHSrOUaL/Q8D
         +8A4zRPmQG8Pf4ld8OM53/7MlXZVp+4xyVDCOkP/KUtUGwneUTlao2Wmmhu3bIrqzHhj
         f0jsb3cOXldJbgracQEGeGqDTjoNaSXmIOoDu+vUVW2RsRVxtIMUL56l7CQkOdYBQx5R
         RMrNGxQh3iwFWy4o10BdUzuBQZ9l3OUV5h55liOhAjqM+6YQQ3WWyGTd9p35OQbEWn09
         werg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792003826; x=1792608626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmKAgT+BMROb7bsj9FpwRJzAdtcudV6UZcveycRYTO8=;
        b=N5NI/GbYShjeX8nyxlkPu+v1QkfOunnIfftwN+Zrfo3WAaV5bsLlXobVUafoX9KrzL
         kbfguofO+MgbYDEPM19WUFgEPTjvPWtDaByOzLEIY4WHxRVAipLV5ebbbvBRseqan26X
         S1K9iW7TDX2/GBl52ClxGYOShQvxmxAbLGhbzIclKa0Tl8RpP29xmGZ2ljDD7rH9nfFa
         Z8AhNx57JrYcOnSJS5Lnpuvk9WWC6Kukr5RN5YLT2W7+84yCWCB83cxYml56/T72pQ0B
         uR3kNazvaEQKv/R4zAdf3MnLCWJl4zuHg8Tk1LkiYxaY69XVR2sH5W6IXkADFXzo57l1
         Lylg==
X-Forwarded-Encrypted: i=1; AKwUvBy/2KXmP2awYRFXfRzB/Sg7BklSJ6Rgq7jyiGX6druOkV6rz1xpd7x0h9xB+SU7C97aBJzON9gtdTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5MphNGE9hW5odlNe7d6Gw2VsVEadyqEjaYTH/13z1d7xjb3up
	bFEFtSpnYMKIPVScEcYWlLC2jbj/Ybrlma3O116ddS0uEJ+Pif3SGGRurcXG+RozoYVVXLxUppu
	N9QWgyv5nmZA6PPDRx3AIXI5KAH4aIrSPkp6YPy7vrdDEVaHxWO0pJ+iUYNTJ8lk=
X-Gm-Gg: AYBFou03c5kiE+p74xryFVS6jGHljFg4VDv8n3JYmuRQNeUykOpqK7SVWUV7KPGHrfP
	JchMrPiV7bccN+3hEfjuyUB9Ka732TXTLcL70ysbk2ZqdALm9nG7QgdfX9+4T4eG4K+m6p4kKNA
	onmz/xEglCmQBSUiT7CgFCv1KFdXkVO9+jWtBnbnTnjK3Xk0kz7uq5WOLKGYwHFV2xUw4y33QVE
	qcsnRw1rCgPDR1Zw7fYoFuh7rMrArnk2vPoV5uYnURIRakvPjYKkpiWY5jd9cDs24cOmpeu8KS1
	nz42Cns14J+vYYF8OX5eud56GnbMiH1XSVUusy8RqLEg91msRKymK4I3US7edg6JWK7RaZ69VTc
	YbdBj61g0vnK6ZJVA2uL4m8Fu58017N1N
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id a92af1059eb24-16a63b2edc7mr32561325c88.47.1792003825796;
        Wed, 14 Oct 2026 11:50:25 -0700 (PDT)
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id a92af1059eb24-16a63b2edc7mr32561225c88.47.1792003824748;
        Wed, 14 Oct 2026 11:50:24 -0700 (PDT)
Received: from [192.168.1.2] ([106.222.235.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm62519780c88.16.2026.10.14.11.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 11:50:23 -0700 (PDT)
Message-ID: <16d94994-ff80-405c-ad98-ccefe4f951d6@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 00:20:14 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfcef2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=N5Y/PXOiYxOVLBGg3HvMCg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=UheTk5Niw0niUJ_rJrEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfXxMZVMm0+GLYY
 dKP9NH7YojsLjYM86xUz7nyPhBFCNLvlyLEe/YVy3w/NNQnL6L7AyTjaKwEkVBho/2k22ZmPTKe
 Gj1ErmQhV5YI7JML2OQlp4pS4UoijIE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfX1ZlzeGElHajp
 //nQE86luTIu2ADH3MsI90tbFIfU3WYTykJh/iBy8Fw7BQUSqoKl72Qm7oxwPC4AvT4EqV86H+J
 e5x1/rB8oFRiqIXzOwJINdTWqutYBdE46GyqwblL0k5T/fJ3ZqFjveTRhZ6gYtpQ/MQEttrSkin
 Gfxdza4aQ24MAF4VLAmQcYj0L13iaY3HtNvPFw2BZ+cwjaY65slUeo42nUhjiOY4a3FSp3PJAkT
 Wgcj46i8ero83NstXzLmHHTx9GtSuqlRxQC6Jwcr66ncuPqrD9+bAvyhPtW1QOxOjd5ib+CNY+9
 aKfG+cmhXqfd1aJAuRFagcr+BIJ7sH+PD1V72SUOsenHq4R8Pk+dAYhVGKl6SeT3BxDXNft9ijk
 DL3LDHIgC8qAuRlYsBhceQiLdZho7oqShu3UGeVCHdWWK5jufO0h1AAewF6SSBvh+8prBa5cF4l
 II7Ood/AUUHanwupomQ==
X-Proofpoint-ORIG-GUID: 9g9b3ZkM3ni5XtyM12exixVHcoenLq2T
X-Proofpoint-GUID: 9g9b3ZkM3ni5XtyM12exixVHcoenLq2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140075



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> GENI resource management may be handled either through the Linux clock
> framework or a firmware-managed performance domain. Source clock
> programming currently depends on platform-specific callbacks.
> 
> Use geni_se_set_rate() for source clock programming and perform the
> source clock configuration from qcom_geni_i2c_conf(), allowing the GENI
> core to abstract the underlying resource-management mechanism from the
> I2C driver. This removes the need for platform-specific rate-setting
> callbacks and enables a common code path across all GENI I2C platforms.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
