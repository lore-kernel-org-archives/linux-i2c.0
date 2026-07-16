Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E440A933
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198150; cv=none; b=nanH3ApKtWx/H8ldv19HbMfyyL8jtOz4EIHzUib36Wh/LPnW6nfa89AhzXR3JkKB9PSzFFzCDt3WBKuTOzgJMPBkrTIZt1Y8qTynymLv01jAYkptJO3SwoDmUTLiUJO0S4dx3vfSNRBqXTeLgB678ybpKk+LBLShX2i99s1E0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198150; c=relaxed/simple;
	bh=HgdOOrOpZHUf9I5DdxRuN2BDK3XTvOH3rwzizwiwkeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL/ciw60g/tOuXo61DqPf5ZFs0Pao8s3wDLR/DBsTQTko3DzJR5CZF6/xsaLVi3RC7xkiM9tgxMgMrLnxBA0VIv3XFFGbb56rv3ENApOt7RbMKBseM/5ddxlGTffmTyhYmoE99SdMaTgyyUyPBQuDH2e9QRmTmKVcyXLt65nYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jOqnLRI3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VXylxRGN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jOqnLRI3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXylxRGN"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G9rGoo2562429
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 10:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QZEMWTTDzBw1siRNZFr5rbXMLMu/6PJE/Oangtk0zN4=; b=jOqnLRI3+pvh+OMp
	YR1mZgI+iueJxL3ZggF1wCQIcYt/EOlaVl8PyAU8DGL93048+BGsju7UiHxtoiro
	2q+sNZIop+YqnnYESCxnFQltPNNZUePmsQlhx1dUFDscMTcBx9SxRg2eCc9F87vb
	x4tUHRQnasxhdL5D/UtX5PHk1iMQgRExIbMGvNo+PYeUMrjkVsg7WnMnsrGaxeIG
	V4BIE6TevPgu4+o+F8obdFm52BpGXXeBPWUnEiURQNsO3qenxBwGHTEYrnEspOzl
	Zs/+LggTqKG+rBdW9TYILXgMQlhcZaAJv/PGUCyBvZ/ejN7Ylj6N6nhQ1ZdwckOM
	5wftlQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf0wj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 10:35:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a4d8fd6deso4330879b3a.3
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 03:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784198147; x=1784802947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QZEMWTTDzBw1siRNZFr5rbXMLMu/6PJE/Oangtk0zN4=;
        b=VXylxRGNnl2oNTGyy/x3zfJ9jFDj7IVxLXlB54Lgm6geBMZATPlI2JrtuKrku7gGBl
         AlPxK+WJrnrTt1lS/dhSD1zkenJzQRmI7GGlgHPLpwgg/nHk/9msHenoRWfGfg3Uj0bz
         0n8uo1QvGC6qWRCsPu+za+nhJpSORmRsWF9v56OK4xnwto7LIA9S009xI7NXapDEXUMx
         ZfOEx/aj+Ni7OkqkWKibK3prfuaBlzD7ae7NyyLOZ/zXvb7B7ki23FVPnoaf2u1k8S4q
         9CAb5X/CGa3Qt4Ruj0gnD5zrODz6Lz+kqQ+azZBUBaVXvU0AtO8X+VHa2gU9eVpbqJvz
         RcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198147; x=1784802947;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZEMWTTDzBw1siRNZFr5rbXMLMu/6PJE/Oangtk0zN4=;
        b=iDS7P/qKdgTgAE13p9kK4B4Z6FduFfbHIrxJHJj89mLB3+pHBKyoLWTVgkBx4Vr+E5
         siBLDufJF+Qn2ukPfo3r4KT+D3FNmY3GDnVBqO/17rw0g5YW42dZD4al6b64HpEKtPmP
         4X+DmTqe+1d94CX9FS29IppEcVWoDVF8ZV4MFZFcXEUNTE8wtv2nAy5+TtxoLqPCnX12
         fya2rnsqdB6N+ZB5qRvtpteN3663VjqZr1jOLEfdXz2gU9zFGZJLGAsVtpIGosSVnoHM
         XzvmVnrUVj1zFDquE3OqPLLBNQud37fTtOi3b+No71gMP6Ewv50N7kNUoqHkfRccwMa2
         BoqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz9u+FfkIV+af9Ep/V5KeQ26v6bJGjKuy7UXZKtoFMnZhTtaOJvEcZkElzFDr9S5mSlWNX1JtD2fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJj8eWsvwmrKDqapzyMkJLFR1OflbBwoDzzl51FkNCVk2+qnQK
	4KQVuHT3mqpSlWEW+PSSgZfYIruofiFcEZUNNHXzYmuwZNWl2f0KPZO88RTyKEYspydWPPXbADG
	pmg3qbq9lD3YSltOIUP9wEbGpfEOTJNB6jTox1Kq1bq7UIQLQbp1XCbvUgbZZdVY=
X-Gm-Gg: AfdE7cl86/rajD/gMyXqwGwo7lEdL8xd14Jd1/cbObjgBRxIjKUhNzKXtClrkBbUZAg
	uqDjytKORMMcnW2KA5906rGhkvEcdf2u4M8OKJIixjV0YZ5VGsNvGSJ71EeS4CnA3gCU3Jw6OCp
	7ByNWg0iGXFRKXuqa+DO13w7o0JD9wkWHur/a9BygSTvurtM5sISAKKn0TS/FBLv329M2onwBpp
	m/YUY+xdkEbavGL2rspqO2uTwOHRsPkBYEz+kjf7k7ELXojVDOC0jrd30dajU/smw2B7x1kKtMW
	Gi9I1+p06fO6dr6J93vKKeJMEvCva5Sdsfv/jt1F+6p8bSQqL8IjLcfF/GnzzDFMwNPWvYOMR0/
	wG0row4aL15q/cSUEZBFTOwQPh+50Nfh80b8=
X-Received: by 2002:a05:6a20:728a:b0:3c3:8d4c:6679 with SMTP id adf61e73a8af0-3c38d4c6cc3mr2120168637.20.1784198147047;
        Thu, 16 Jul 2026 03:35:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:728a:b0:3c3:8d4c:6679 with SMTP id adf61e73a8af0-3c38d4c6cc3mr2120134637.20.1784198146565;
        Thu, 16 Jul 2026 03:35:46 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb259011ad5sm1593042a12.29.2026.07.16.03.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 03:35:46 -0700 (PDT)
Message-ID: <02231fbf-1f8d-4a80-89b5-20c05c09787f@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 16:05:42 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] i2c: qcom-geni: distinguish address-phase and
 data-phase NACK
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-0-9091315a33a0@oss.qualcomm.com>
 <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-3-9091315a33a0@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-3-9091315a33a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TsmoNNC4Mdaa9NIOqRFit632f6pf08wU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEwOCBTYWx0ZWRfXzp5pfJbhGGjF
 Bsf24KE/nla9mQWX5Re7vt5iiwA/L5gwbdiqoxpgKD1isW5VLab6h/8fwegs5dL7ayABVEZ8NTN
 E81Z7uiVtFUrAwB1gT8li1f8E8IjI7ySTKugklIhelz9YxtmogH6CsU7wJUon7jad6sPeEScZOA
 nZ1ZHclkeT9GHS3c1swYeX+GK7pdaLWTHt4p2oGb/0IudpQUOnuT82riooUZvY6iPvSfQGNzdS+
 yUXY0b2lvXXTQ/5fE53rrXtpzcJGiaEWJ6rb5Moi1F2I6E1Hn0iWoA1Q2lgDSebK7agLOSV1ZfM
 5Q/FdQnLC0pyzzbogYAsw+51TXmsu8vUgD3hAH+d3u8W+uqUKFVrQbvM2lNMgxXDh3y6HDV0x6Y
 o37efRYE/TMewecjwoH5BYWPboIbV0ajwmh6xlJDR2HrbScj5M1F5sbZ7bO3nkbRDwEN4HIdTOY
 K0bTYppJlEoqAUXgKDg==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a58b403 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QTIInl-oKmcOnA4cS_cA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: TsmoNNC4Mdaa9NIOqRFit632f6pf08wU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEwOCBTYWx0ZWRfX9z0JtbN1/Pag
 E/xdKfTOTloxW+aVbob1pXB22dfrHBMV+eBiIgtjFIi+dG3qwSZBhyVbmqD8XLrAFEnXLarD7Fp
 LbPb2fbzZ/pnH3dk870oyp9NCUFLdhU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160108



On 7/16/2026 12:08 PM, Praveen Talari wrote:
> The M_GP_IRQ_1 interrupt signals a NACK condition, but does not
> distinguish whether it occurred during the address phase or the data
> phase.  The driver always attempted cancel and DMA FSM reset on any
> NACK, which is incorrect for an address NACK since the DMA engine was
> never armed and the hardware requires no recovery.
> 
> Add geni_i2c_check_addr_data_nack() to distinguish the two cases by
> reading SE_GENI_M_GP_LENGTH after the NACK event.  A zero value means
> the address phase was NACKed (ADDR_NACK) and no DMA recovery is needed.
> A non-zero value on a write transfer means a data byte was NACKed
> (DATA_NACK) and the normal cancel and DMA FSM reset path must run.
> 
> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
