Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA77513554
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797685; cv=none; b=Exl4iLeSzSZN6Icxpmnjj3p7RsovQGRtzMFR1Te+4HLz8W4Qd9DY9f7EhJ4Psn3jiPp2Ygca2q20CzIgB2bX7kOg1jlhtspNSV9q6J5a6w/X4l+/P8X8kaEsGHKsr6Z60udolQ6yQtBjtR6u8Seqqwr5FTtjEpG5r/x6zKzBJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797685; c=relaxed/simple;
	bh=R6zZ1GqdN8b2QI5b7GbD3I6ihYPn8pV1GBzdNaupzcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEKtsDCEilOG1RtXT4Rd5YC9cA1jdmq5PZWJE77DA2++SZIThCgO7oYeraDTUfBCrVPxmdP3DHJL7D4dF2n+jOuPJ3rVzCGqVW1NesCkvuhYIpL5SYkQnFBMGJhVPlPHH2XU52HVvsCHqiEEZhwrxMUAo8j3/bVRFtR55Ga1hN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+H8o/WK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hgFmU5BH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+H8o/WK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hgFmU5BH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Dd8j4851087
	for <linux-i2c@vger.kernel.org>; Mon, 7 Sep 2026 16:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6uLcqK5uULEGQ4WGjSoAqBJ6fj93DmpH8MQ+/pNb2Rg=; b=S+H8o/WKI0ZDTrks
	uCwh5gCR8qKWvZy3K/SC7bqaDGgSFOzMw62kUahciVWtVnFbrrXOYp7SY8DQ0m/S
	xs/7c4VMM9aM03CGR81f3e/H3uL0eGooz6h5I6RBnmXDSIbdFoBGj22XAsiHldyl
	IBD1LCyeGGdqebthjCCidf86ZAzza6Rftr5nz/jRnn4LPx+oSK0zS4tSR3R0BI49
	BggvmhI17P73ErED+0U2uRWselHr9VYmYuxCNqtcWEQUyMthSKby8njN5smT5bEg
	IX5raYVSXzECSRePXK765fH6L6ClHauKrYIeTiNqPHHjc3evzovQOGP84Da+nbb2
	DyiJUg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk9443-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 16:14:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f73d0f89so47645025ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788797683; x=1789402483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6uLcqK5uULEGQ4WGjSoAqBJ6fj93DmpH8MQ+/pNb2Rg=;
        b=hgFmU5BH+Ec9l1Q+Mzq3J71Pn8bBnrpZhUCyxg/t7NT3AeHyzHYsnaqDBF6/R86Mjo
         um5x6W005HVLD+iLm6BzPdGhWCXyfLv5alGRZxkKrfdH+AiQR2y23aQoYkjFNQqNl6o/
         tBrIV0z9Ibd70RFZLV29E3zWcyEjSiylmg+hs+DC9rOyvLcOe/5i5aRjHGwWyt12codk
         lC9SSjd62zuu5gQI4bujrcNTs98HRtkupNnHDw5UJBuI4m3oF1Ws37IYUnnndWWOtbyk
         J5EYWCA1IJ4WJ2dKiyi//nAuNENCRcNkaxD3grmV/emYC43ps1j/Ll80sNm+7as8OCQw
         /eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788797683; x=1789402483;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6uLcqK5uULEGQ4WGjSoAqBJ6fj93DmpH8MQ+/pNb2Rg=;
        b=Fbg36cs+3KN8LkhW/bguinz1xUpAsYMVV2nBAxdB66D93L8ssilBOgwbusGJibZ+6c
         /PDViPqxDDeuVqJGZ9SEF1IlQCCW8K/nsAf3kg6EEPlTQR1TM9pttmMNCvAFtaHxXG29
         sZuVUIBnSvmHxaHpqIzh2jX0KhP2XZUKalY+zAn8P5a2/2vLI2yTmLJCuHJIwQ0pbNJD
         TuQg+exe9h9tHPUYkjyoRoIyX6RJO8PESsMQh50ypiErsvL2QQ/84jdVVaDvlr9cAD3o
         us2mpj2bdNuUASDyVdzgBOpn/ydPSuXurxmMwRseeIiZgdt97JJkGqZ8hrITUxdGYLFM
         Muiw==
X-Forwarded-Encrypted: i=1; AKwUvBzK56tG/q8QSQSsse6htXjgULYFuvOMFifEVxLmFCjkV+uWKW9e0uS4E054sfaH+EIgy2aGvPbY5q8=@vger.kernel.org
X-Gm-Message-State: AFuF++kFva+j0lCTxOdQNRif1Bcdwz5Q695eifkJ269EnuDeGCClrRvn
	LJiQO7d60oAYq7SzbGL1uZ+W/xAQgUuXf59E4X6M+tG82XSGy2wokmHifsO17xV5eCkdoaSoNUz
	s2gk+G54c5YmfVlli4g77JGuuLPJ6rX25lqAbwX+0oLhVjl0/vCfBxnWKz+OV32c=
X-Gm-Gg: AYBFou0ntWMUaK62lNFhSHU0mKQaHJIdH8ywhJ/krwMbkgyGqIRs+tgF+i+ptmUZ9eo
	gwW17HLcHxk3NTYRzQEAksZKdtTQ1ssKPycOfTOwoet3dGuHsgEEtTL/AXB8ZUkI8R2BnbV0KAt
	xHeyXv7oS3si02UDIuxC7kSTvFbRIFCFW7AOd/cKy0cqrOFSWwulWrDj8rpN2gVsBzW6nXbGCZG
	cMwvWbl23ghSji12rJEZWpJsA10EwT/F97AVQXQSiwdYHHo8ZpYURPOaOcIorEYYlEpTCCAu3OQ
	Wrm1Sy4opRBbxtnRw1HSNA/txuIZsgB46Kr14SRri56BIwHNc74hVsNhtpoPmd0LuRgXX1D8pJz
	JBPm1wNLTph6e+14IS8Q6J6QYWsnkhqdmPBtFz+btCUnO
X-Received: by 2002:a17:903:1a28:b0:2db:31d5:1448 with SMTP id d9443c01a7336-2db31d514ebmr203964465ad.22.1788797682659;
        Mon, 07 Sep 2026 09:14:42 -0700 (PDT)
X-Received: by 2002:a17:903:1a28:b0:2db:31d5:1448 with SMTP id d9443c01a7336-2db31d514ebmr203963655ad.22.1788797682186;
        Mon, 07 Sep 2026 09:14:42 -0700 (PDT)
Received: from [192.168.1.66] ([103.172.5.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bbf1feesm29345580eec.26.2026.09.07.09.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 09:14:41 -0700 (PDT)
Message-ID: <dd66d593-2601-4749-a21c-5347a8f1b6eb@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 21:44:38 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i2c: Add I2C High-Speed mode support for qcom-geni
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260824-i2c-hs-v1-0-8dd94e5c6113@oss.qualcomm.com>
 <613960df-3d3d-445f-9533-57257eb5099b@oss.qualcomm.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <613960df-3d3d-445f-9533-57257eb5099b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE4MCBTYWx0ZWRfX1M50Z2zkCrNh
 yBP4Rjp8NbSf3wSmLbeMeuUeiyhrQksVYxoAZoT7ARE7V08EQmkiX5Qrs1MLIiIehfdHC5jpHUg
 hmJdBJ586JnILRAAtb51lS43zYWKQcI=
X-Proofpoint-GUID: 4Qi0lgozIbnaeNW36hocVFPrWKswaDmb
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9ee2f3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=tPI8lZtLbYv5uT6OEmdSlg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=PAEdTZexspgVwDamPmIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 4Qi0lgozIbnaeNW36hocVFPrWKswaDmb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE4MCBTYWx0ZWRfX/2llWTNeoYCG
 c4kvhmajj1JhhWHZgSGeF5NjYj4HmFZCMI2hwNFKbNMc6VVJvVLfYOp/VcCOYuFljwDuOMCCnN6
 LarZSgmnsuINHS7/vSjH60CitajnFUZVFvwVgPLBXIBaGqt3b574U6WshaQ1Lo761Ban5YKKkfa
 h79sSk9scAMUFh6bz4Tx/UWL+DcIKqeOSv+WJnlCcIyR+JO0OuZyLAgtgssXCt0aNYOJJDoEQYy
 Y1clvAp0o0CgsImNRGJkl4/1AYD7PFZwMZMRS23CuDJr4Q3JBEXhkYT9mpkBTjQiqEGC+zpX0GB
 v0PaDqa8KX2JHssYTYzNpsGrHrTUS1xnGADv4JhNi5B94Flj6+i8ZDJ3+UhCmLkcHQwzXpdrZ03
 1yk6V2pg/GPORGhprXMfDZimZ4MUPaCeYsgFzq2W18UXbIirEwqKK4QwmNKaP+PesYkLdWS/JYd
 SBGCE5OWz3CUfx6uTKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070180



On 8/28/2026 12:56 AM, Mukesh Savaliya wrote:
> 
> 
> On 8/24/2026 4:55 PM, Jyothi Kumar Seerapu wrote:
>> Add I2C High-Speed (HS) mode support for the Qualcomm GENI I2C
>> controller, detecting HS mode requests based on a 3.4 MHz bus
>> frequency.
> 
> what's the detecting here ? HS mode itself is 3.4 MHz freq.
> may be you be you can start with current support freq modes and not 
> supported.>
>> I2C HS mode is supported by the underlying QUP hardware starting with
>> QUPv3 core version 4.3 (per the GENI/QUP Hardware Programming Guide).
>> This series adds the driver support to detect that capability and
> is this detect things repeating ?> enable HS-mode transfers on SoCs 
> whose QUP core version meets that
>> requirement, rather than tying HS mode to any specific peripheral.
>>
>> Patch 1 (dmaengine: qcom-gpi) is for GPI DMA transfers and adds
>> a CONFIG1 TRE to the GPI DMA engine to convey HS-specific timing
>> parameters (tcycle_cnt/tlow_cnt) to the hardware.
>>
> Patch 1 is to convey config parameters for HS mode in GPI DMA tranfser.
> 
>> Patch 2 (i2c: qcom-geni) handles FIFO/SE-DMA transfers; It configures
>> the GENI controller's source clock and timing accordingly, and adds
>> the HS-specific FIFO/SE-DMA opcodes and master-code preamble needed
>> to switch the bus from Fast Mode Plus to HS speed.
>>
> 
> Like above just say high level in short, individual patch will add more 
> details in its commit log.
>
  Okay, i will add the below commit description.

The GENI I2C driver currently supports Standard (100 KHz), Fast
(400 KHz), and Fast Mode Plus (1 MHz) speeds, but not High-Speed
(HS) mode (3.4 MHz).

The underlying QUP hardware supports I2C HS mode starting with QUPv3
core version 4.3, per the GENI/QUP Hardware Programming Guide. Add
driver support to enable HS-mode transfers based on that QUP core
version.

Patch 1 (dmaengine: qcom-gpi) adds a CONFIG1 TRE to convey HS-mode
timing parameters (tcycle_cnt/tlow_cnt) for GPI DMA transfers.

Patch 2 (i2c: qcom-geni) adds HS-mode support for FIFO/SE-DMA
transfers, including the required clock/timing configuration and
master-code preamble.

>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>> ---
>> Jyothi Kumar Seerapu (2):
>>        dmaengine: qcom-gpi: Add I2C High-Speed mode configuration support
>>        i2c: qcom-geni: Add support for I2C High-Speed mode
>>
>>   drivers/dma/qcom/gpi.c             |  54 +++++++++++++--
>>   drivers/i2c/busses/i2c-qcom-geni.c | 133 +++++++++++++++++++++++++++ 
>> ++++++----
>>   include/linux/dma/qcom-gpi-dma.h   |  28 +++++++-
>>   3 files changed, 196 insertions(+), 19 deletions(-)
>> ---
>> base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
>> change-id: 20260821-i2c-hs-408768509865
>>
>> Best regards,
>> -- 
>> Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>
> 

