Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578A3CFF6A
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502446; cv=none; b=Sp0gVtgL139y2U6JvEsx9UGbra4UAkhVBbLvyGpN4K9MpgZ/MdHmXGZJU9NKYb6ummI/Q03aYWEPx/m0To5dLrt4fyWFZEvZcpv4Et9P6BpAecM/tzu4j+CK+TqEc8OVHu0rgsd+O25F3jHWsO1P+9/n2K7OgSZXqnF86tpoLf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502446; c=relaxed/simple;
	bh=F7yDLLjZBn9qTvN1qPfHQLR1zoSsRmwCTJhdtIi9nmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UOQQwIHLciBf8dKCs//NaaLu58oYHgA52Wf1mEsTg98koNBgAgNOSaH4QFTpqbM1e1VyTW11kDxFSE0SF3aGC/WUq4hENKc87E8d9hBF2WM5zoDpI0fX8WrctvMs7DpWkUm7jaJJuTL/zIQMXvvbXWslC/0q4eXWEsjxyprWxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N0L+urWE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MtISa/jW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0L+urWE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MtISa/jW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BBIRjG1344445
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZfpF2A+uxvitd/l3HalifYt5udh9syYv0uzc/zxlKZ4=; b=N0L+urWEiiZE5O+r
	2fd3SBaODNpaDDRlrwt79P8uBnJ1NqhJYUGHly5fdMgS7dKh99+9Tr1UUhYMTbsQ
	/5AQlz1hglkp4VbEC25yW0Nbx/HdGoneotm0nk/V72/AUlPSOu7xuVtY+xpJvwYs
	H/dy1L4tYg9LMChTYI45gZt5muNt0QYdT7Nt/dVB6irahNMZTF38pzIPsS/4Gem5
	hdRGPteStTxvMm5tA0N1CLDFXahW0nBMh71W/ZRNnU23qZOOeffcc+vPHtoxGvJA
	xA3uguEbXUOXqiqGSboiazy+OhDa2LY707kv+ohDkY3dKWpwV5txvFgVOG55ejoV
	KK2Dig==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3e4986y2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:27:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-514cbe73d00so1949941cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778502444; x=1779107244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfpF2A+uxvitd/l3HalifYt5udh9syYv0uzc/zxlKZ4=;
        b=MtISa/jWIf5Nn7NqX9ETfnQXKt5mWDZ/rp8UsegDhSnBZAQbAMqiA2Vk2BDyzTjYGU
         oq+/tWYifBSG40jScW4XWgLySafM7QnWFZmWh70535BJQKEC6SUNwJOpqdW42WKbE0sf
         Sa7VhHNDr8E6W6ZTBw0v01ItchECRQ/RrA5lvW0MQ8bC2bGoneJTa6f0APHgNkepgJSK
         mB4rUKe/CshCopVc53iv8EdXJcB9S89Bx2tehkbmIqnYXXFAcsuPjvpvSysExn2qa3gJ
         EY8eOmCuNnkvKon2OnJKEObfuLPvMG4+EwRsxLhM5OgHmJOdIGwaDqAq55qlL2LPitUU
         sl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778502444; x=1779107244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfpF2A+uxvitd/l3HalifYt5udh9syYv0uzc/zxlKZ4=;
        b=XB8prffofU+2BiP251yGIeAmaARSZ+rz9KbaZ1G6bEbDTYmAKjRv3gVsL0LFMqEKLA
         FH/tAaySTwlFFjDFVuD55GjuJ3QdxEORt7FhkWQwES4wbollikkNtTuoPfXvTjnYZoCh
         AOut9dD5HCUSurr/X2DCVwk8jyz9+rqNJnsgA8iGbq5GIBnQjlQ9saDzgqWTByUW62HF
         QizBLZSwaFAjS5pIH3UQ5MgyCaID8+VII1Tilc4JwIKhotdzhF0C2YNPoHTvAQTNsnxl
         VREpzthEhtfyt4GhQ+S+SyJx74emyKqNUHdA8Lv5dpBMLdpv2uDuZDkQUfdXfoCtfUdk
         fPeg==
X-Forwarded-Encrypted: i=1; AFNElJ9zlZymTNNX/thGQKOW1hY/lCHzXJ/cksEwqyOnlRYXM8fEns88bRxpAs6uJMh7j9eX+XujIt5pauA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9n9/GS0R0ioe+AmUid0aDmbAR9PhSt0SW2D7OcIcJ68GstCxz
	VcJ6dI3J3zbjL28WAz513S3pvZIxo5e4MvAiApKH6KiDg6fsPXk9K2qSeMYT3LWOSCr6kVwUFF0
	WQb9lywRVWSi0RaYKcAZ9jI5NtdiNWQSYJJNnccOuDvMRqwxj6CJFvgA1q1FLBSs=
X-Gm-Gg: Acq92OH2zZC0pjZWj2ZyirIODWPZ2fGM4kZFCJV7jhzubDeIuv9JNQhurzGS14FXshS
	dypKojBi5rHtfJO1JH/EVfh/lD/6cwdDhcUYBmWuyRckybo5PxoCVNF+fbBre1gKMvLElhTlhPy
	S2KZMNllhY9QNAaFWiJSMiwcXL7W+2uYK7s+BOcaOrv0wNZ2LnDI1KrpuyiAv11bcNdekRrrkJ0
	DujWzyhdfJ7swr/8Z/5K9hMP5q6o2EXKtK9Mgf+YS11/dFC3guh0XQ1TgWaixVvtBp9ZSEjIajg
	lfYkFUEXCWHENJDAI7OIdhT21uUtGWfFkrJBj2FKUy3FhDUVLPJCbbZ42iK0I8ch4+oICPjthxW
	TMFs+G0/1ynM2Xb56zYz4f3bD7aYm/vlkwLE0a9Ts/IGYPfj29A==
X-Received: by 2002:ac8:59d6:0:b0:50e:42ec:ca7f with SMTP id d75a77b69052e-5148e838479mr204535451cf.18.1778502443690;
        Mon, 11 May 2026 05:27:23 -0700 (PDT)
X-Received: by 2002:ac8:59d6:0:b0:50e:42ec:ca7f with SMTP id d75a77b69052e-5148e838479mr204534841cf.18.1778502443095;
        Mon, 11 May 2026 05:27:23 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6f9fc89asm193817745e9.0.2026.05.11.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:27:22 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Jie Li <lj29312931@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wolfram Sang <wsa@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>
Subject: Re: (subset) [PATCH v5 0/2] i2c: improve bus recovery for single-ended GPIOs
Date: Mon, 11 May 2026 14:27:19 +0200
Message-ID: <177850243044.63956.7149095798134345124.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511113726.49041-1-jie.i.li@nokia.com>
References: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com> <20260511113726.49041-1-jie.i.li@nokia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -vMsLrX7crCLiXj3Z7IZf2MSzfAVUg2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEzOCBTYWx0ZWRfX7Dq6Sslt8NFC
 BzHpueEDnoZZ8s2cizQoRPxZF86O8jdl0Nwsl62TnKZ5m6r7S5/BdFGXMZ8dpmbZaqEuLyX2ETn
 bUiUuGUWmfG9r6hZMB5UVdrk7eVfqtq2y5HCZEVReehPAZH03NYKJdfJnA7n4lQJbnMePesNe0+
 5wzWpWO3ZsD1+VjXE25ehDYZPo1S/SZo9Saqllmn2UoasNPlv/NOyqqRDgwglok3Hq0AeXNmSfk
 ho6M915tlCdmCeQYi3McXI7aKTYcIle7dFjRX7E9wyB/JIFlnvapZxABITuJoIlPoSOQpxbMZC0
 9alrRQip/YPSwMLpKnIsUlw8U586nb0EeoPdT8qqgKzpjpYEAuVUzqYKX/6SXZA6g4rZWhiJyBK
 rA1nJRckY79+MFRvm5xHvKDKwfEgCtEQm8WncC3ujMcSCSO0bUYq9PElbr/dkyMEwXNlDftEGlL
 urXM3xiotkb9rYAqoAg==
X-Proofpoint-ORIG-GUID: -vMsLrX7crCLiXj3Z7IZf2MSzfAVUg2S
X-Authority-Analysis: v=2.4 cv=Yr0/gYYX c=1 sm=1 tr=0 ts=6a01cb2c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tcrSvMvFkzysuFRZ2U8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110138


On Mon, 11 May 2026 13:37:24 +0200, Jie Li wrote:
> This is a respin of the series rebased on v7.1-rc1, as requested by
> Linus Walleij. No code changes versus v4; only the base has moved.
> 
> The series addresses a limitation in the I2C bus recovery mechanism
> where certain open-drain GPIOs are incorrectly identified as
> input-only, preventing the recovery logic from functioning.
> 
> [...]

Applied, thanks!

[1/2] gpiolib: add gpiod_is_single_ended() helper
      https://git.kernel.org/brgl/c/b5fafa01bdaade5253bd39317f5455d13e6efc7d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
