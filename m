Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579524;
	b=ZD7fzVvC9CY3OzJZ7qjOv9e5hbmVz6a8XbI1cEHR+Tg9uKJ3TQPdbEtjAcyL2qWMEZ5h
	 C6aNe/vjvWkkcrsL6iDqZKAJjiYLL871dUg4hUW4ubDlCao2GxpkAPr1eYax5QSNbltSr
	 mdapFQ2MwK6qzTayddxsiwP1fT1H87+zhKXuSW7FIswpdI0s6z3sTmWWqXfimWTovSXOP
	 IZaHatXN56+99R3P/vx3w9qK5Mjq4x3eXfUZ6O7Lz9v7uqJ2ySngKl0FDR3KoFdoXsq0B
	 Ys2G3JDhGgEFSF1CNXi7B1NCYPNE788221gCSYMxCETHANMZqfbYnskO3d0rqewCUfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579524;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Nor4mYt9+XCqCaIC8FOVwGZ+YV4SqZ7jC36z4M6cRUI=;
	b=o+veu867l/tH90LV6eo/2m1bjXJIwToUOTG2HXNenELcGmOtR/8TblJ3/xuAIf8D2+8c
	 7CrNx94QUNFQAWLRK2BcXeC2HoHX5J3meIpm4mgRhXh4UudenpNJZJaZPEwT/etlTYR7E
	 cWOr21du9SD9vV28YesvyWWLpqvytKkGjCpfzp/VK1fFqqb0XrH2L4MQ5mBPJ1gw4+2ec
	 GkYIAb645WR7fo3y5Bb1LhIqhA4xlnyq+zRiYlbQ6csIf585MUVw5QAMqq/5alXtXbq4V
	 iBx7rxbK9itQp3M55dGSLvkx1XgGzw7nkSYi/Es89q0W54CdUx7ycFkK3W/8tpr2FnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pCwlGlQ7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PUXMuD0l;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BE606A327
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 907BE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pCwlGlQ7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PUXMuD0l
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA5lmP3449744
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nor4mYt9+XCqCaIC8FOVwGZ+YV4SqZ7jC36z4M6cRUI=; b=pCwlGlQ7TULyLQ0w
	VfK5z2loe6L1KPeaANBAJZ8pkaKWQ8R2PVuIb95CPFVTWpMnlgbuZFhAFcEayBzU
	8y6RRU4LkrO9yQ0jJUjgnqlL8lmmogBlfQxANiRSUvQjx8L/oGT/P6iB9nNCKoZO
	VDpL1BKr44Vm9cOpY2HIi4oRrjm0V3CU727M9m+lnwD0hzK8xRSEmGvXll6pk/JN
	+nf6mCGAG42up6rFCPGROMScRXJJFZX620NOavkNrr2feVs4zeWmnA6dNVLl0Fr5
	/c5sBpV7rozx+TGhL22/jvGviC/C0+yvupb+AwGCXlpeiswkjRYhus/B45mHJ8x/
	qjlBLQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9bb66-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 10:45:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e629c7b16so14708885a.1
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 03:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792579517; x=1793184317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nor4mYt9+XCqCaIC8FOVwGZ+YV4SqZ7jC36z4M6cRUI=;
        b=PUXMuD0l9QomEUJJvS72fqQWjQgAP5UUJwwj39WTRLDckeWSDk9MdYyuvxKJMDuO9R
         /hOABgkQSAeafB+2/lIV/SFVbyCgGfiiUzcMk7LuRpj4BnDmYrUwwrioy3Olz2eYfVTb
         aw54c9z7paUTEIqfghnTmrTPc1GbU9cH/9T3QRcDROuV1BAINtX0MDv7p5lqB0SsrTjy
         05hWs7d76hULtUFHVr+qlMdOxRwbU7vDHqJuzVenaRk9/slLAaQYXFgKKcbc9gxqlXpy
         s3nD4gHj4dJVftBY+qjzWPMmkDVScRDg5jsLlAR3Z8fMs+m08RJ1/qWc1tRw81FqvfLb
         7uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579517; x=1793184317;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nor4mYt9+XCqCaIC8FOVwGZ+YV4SqZ7jC36z4M6cRUI=;
        b=cNBddzriWgxmCoCsv7gGgiBfoPRl1vWBkBHe99YJ5/E3pAvYpGAT3/ZFmAMs+UJo8p
         nzRyU7MpOVEtFUl37tlwX/0h6jx/9fKf3w2o5CFOwYN6XDG4cmm5lNZ3uDOpk+cD36Mz
         bipi5bdTw2I6gyOnCKbdvLx17HrtuESwU3594ZNk7gtB3MwC9zVuCR4aA8dPa3Ag8RwH
         ZwZwVfiWY/3C0+4eMjhIK78TK4aC6v+Rd7vJRoMQ7Sc7y5ltv7HWT8ZLhPcyebw3x6vQ
         Eewg0lOzVBgkvVOWcHWVppQJq12E844pMEFZa/4fyvtKGmULLw24svgI6dXwZzc3qXnd
         fO6A==
X-Gm-Message-State: AFq9FYIo1ZpzC6hW+A9QkCelBfCX54DLm7l5qetRZ8g3n/wIJZeeed/a
	LNw4K1PFig/+EDRfDtUudP1ONqPV+vnV2j44og8o8gocBF1nSZvD/lzIroLsZYehj8HAsrM0RNf
	SX5aypYNzRcqTjnGbMk/yPy00sV4y0KgDRzNgX/oqd7dnBKLDab8ZqF6qndfaT94=
X-Gm-Gg: AYBFou0C66czf0CtEsy1eZN31/oAmnIEcCiulDDHLHmBlP7neK/oSsiY7F5CFyQYkA+
	aytzL+2pnWxq8mHWHeATJaNlCsX0fjflPkoqQP3CFf3h+m3Q24daAAF71svQr4su7RhFYHMSe+s
	C9KvNlz/OGWYbQm9VoVslpgIlybZoyhlNDZPlmmF+KhUD8Kjs/x2l7oyWp5HM3GE38fYwHOw1II
	p5PS2rNtSWG5YzboXzFYgEAm6IF66NdsRnSgHONrykRuhvuEBuCk6y2LM7mL/Dm3fTqza4+Gyow
	V4ZGoCL1+oATJnOjnJRNlgS/7NeCw+ZxYc7OpVNA6DaNfVxqCpOX5XElTpKtr9uujGWFE4Zdhz3
	5eEtDZ+yfAGC8nfJsAq7XBw==
X-Received: by 2002:a05:620a:4511:b0:93f:977:5d9 with SMTP id af79cd13be357-93f57dbe348mr398740385a.0.1792579516620;
        Wed, 21 Oct 2026 03:45:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:93f:977:5d9 with SMTP id af79cd13be357-93f57dbe348mr398737085a.0.1792579516230;
        Wed, 21 Oct 2026 03:45:16 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4030daedbsm741643a12.13.2026.10.21.03.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:45:15 -0700 (PDT)
Message-ID: <4c3f41c8-6974-491b-97dc-3557c0ba0c28@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:45:11 +0200
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
Subject: Re: [PATCH v3 4/7] i2c: qcom-cci: Add burst write support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
 <20261016-cci-imp-v3-4-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-4-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfXxKJB9dNngsH4
 vz5gR5zNpdlwXHFdGYV590OMSKI31CbMPx/79qRz9dHFmRSUfw+qZu7NpIlzyB82M2Cl8exOaQW
 2RKUiYL4IbAB8emipDFmwa+mQXNNRHM=
X-Proofpoint-GUID: gMJNqtaGkRuxDBUkg5TdHbueo0zMtHg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfX3vqCs60zar5S
 m78Hwstgt/E6bP1UIGbdvXtSwsL6Sn+LDuRYfoAuhlriX/401vhR5YED2vn1AQ4iW3URCEF66uw
 QOioEHclEPcFzwW0Eefh0Oyd7fNgkTD//2lJN3byWb3T0103cdbg9KyyCm3zQDbvzD4mSZg/Z/0
 FqYlZ+XIMZo0r0HgvgRd1LvMtCjQAkYeBAsQVxOBRnCyO/VqVionVLi7Vly/6qgBm3Vif7P8MAn
 WTTr3pB6WalM2m9Wc2Y/n8hQa972jGs1cONihUFEswmn9OXPGAyX3vTrs18hHoiG0lGTp1ZM7ld
 rNPjnL4dgz3NfmYmrlxmIC2ZMV/HatIEqsFtw58erF6eqqm3HQWWU50PGSp0oo3/p04slW0O74R
 q6voPGkOgrmCrecJE2QJ2J8Pnq+d8G8vCp4iMuUUHJ9X7EMgwu0aAE2w4X8ZBIBPOvEYW2N0QeL
 pMMo3jpYsYwJrul/r6Q==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad897c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: gMJNqtaGkRuxDBUkg5TdHbueo0zMtHg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210042

On 10/16/26 10:00 AM, Loic Poulain wrote:
> A single CCI_I2C_WRITE command can only carry up to 11 bytes,
> so every i2c write was capped at that size via i2c max_write
> quirk.
> 
> CCI v1.2 introduces burst mode support, where consecutive
> write commands (marked as burst) run back-to-back as a single
> transfer.
> 
> Use this in cci_i2c_write() to allow longer writes across the
> whole queue instead of a single command's payload, and raise
> max_write_len accordingly for every CCI revision that supports
> burst mode.
> 
> unlock/lock commands are required to ensure the commands for
> a given transfer are executed atomically.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
