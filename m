Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0563EDAA7
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289872; cv=none; b=PxuRPpw1yrRZkfFB41MQFR4lDSxb/rwm55LCWEN01vL3YqC+cypQHaNynb0SWO08tk+/K/OU57DOdcSK8Uv5fEgrvVTI3nIHuJG0nsMeHiQ4bzAhH9sEq7JmL5NXCVgv//B9UVPDpY0rr1ocIO1vfRkZiqlIk7yhuEmHgKn/hBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289872; c=relaxed/simple;
	bh=KE3CHmrYxxhMDpXDg81JQhxR0KHJxaDYh4BcsSY52kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L12VnRIm5XrROV42RFj9B1QSlHsQXL7SXyUv0IZBA/nmJAIO3JIsT4mXcHEP8FjfUpxl1dP66G/k31Ka2y4hktyqakv2/uWjLCKYuGVB5XJ7rIzo4J7d+6oXneY6lL0PCUHSLsVMV1jzGoMIIlD6nOPoyPmeELGMlBkPI2jxNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRWj+cJL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ax56K57R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRWj+cJL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ax56K57R"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9nYao446952
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 15:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8YB+er3HPXr9IfgtIGIN38Uy32FGHAfWDhk/nmWZvz0=; b=lRWj+cJLTJ3jEhip
	tgWxw4onHUic9MSwn1Q40BtJlx1QPeE45ADG3pbER5slzoVoZUz9TI+dSe+hPwrG
	U/hsM1cr//gQovw6lJ1CzkTNUMLQodeH4RsitT5gG/pLaKGXYYx4PdB31Sux/3Ld
	f8BS+5LyYtr6PWpTjrNNzwzBDUFqrFrufZErI+Ke+oODChXrqKNOPv1jgMGZkXW5
	3HFgmOU5NDVw4oMHJr31DQlczSiF8mCwFgjaTvJsuDDBYCT8fp8Y9ip44Yjwv74R
	v+Ef78tLk9VlAu7pcLEscOR+JoB32lIQFRUXX01b00wTjvABeRiVD2ztdu+KwkUG
	EbnOMg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrh7ud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 15:11:10 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-696133ef271so13615334eaf.2
        for <linux-i2c@vger.kernel.org>; Wed, 20 May 2026 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779289870; x=1779894670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YB+er3HPXr9IfgtIGIN38Uy32FGHAfWDhk/nmWZvz0=;
        b=Ax56K57RBuvLd4IsDEDxPKvaoTIBon1TcIhH4QKtlR/S1L4CIcgWj9vC1mFB/WHW0k
         slVm8TZ9LzG7EWZ8Flj9UEtioUB8WUnFmW777HYdc3QJ/l8aWnTCkDAC/KqUy/sC87YH
         nFT002Y5QyjR1F8debuiIZVz/L4zP8chGD5D4aWLLL+Xu7RPyUd37F253jDpzGhq7JxV
         se7V4UnGqeDtL8gLRsZLvwtN7++zJkT9lod6TYe6V2VlG9PlglVHIN4JDm5sp1beaNN4
         BZ9SQtiZXA/ix3hn19QvCQYWL8FFmMVGasbZU1CsQUVp5qMhB70KdLonuorqncKTjQLE
         RGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779289870; x=1779894670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YB+er3HPXr9IfgtIGIN38Uy32FGHAfWDhk/nmWZvz0=;
        b=lc1K/wqYkEdZWvYU+z//EddS+Tp+rG3fMF11AUtdXQCBvoHtMQs9Z9vmy22WN0bNgj
         MOJjelAXuMlI/eyd6iAekHsZqAYEFkLEJl8XjCFu91pbEVpnC+UGAq83Kwnipv5aGF5M
         0VApgOBDVRw4FsNuZAoIhmjaCF0nlyNNtgUdTg6xCQrHreooWfkHFh2iMZIvl4ihwbjV
         blZCbYfDoPRXGhrBX23LbKOD3HNmfuXVpw1Ex8ZdZ9u9QORwX4k7FIeAya5EZVpmyxFR
         UZbytuyVca9ZRMO7qArgHSBvwqc8WWDTvi83hu1e4ZzTSzACE86i01my3pu/5ki9IVqt
         9qrg==
X-Forwarded-Encrypted: i=1; AFNElJ+P5fkszS+xqe+t5KTLCYeEzUTt/smriq6L9O87TMr/R4d5cA9s4QFMcOlyWMzm/OMwAJV4NV7n4pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpy90szt+QYDzbhJC29sh1e0O+3JQsscHcuf7D0BvJPmLBmASO
	sIx7neBo9ztU2XCd/B24em+nDJYRqazIXcdqQvjvFLOCCNBSgljs58gnp5BNmaBnS1lZIn8l189
	4+pE9g7THKs9cyZAGggEjwSX35UmEEimem289RUaI4zq74lWUfC7nqM/NqExSrnQ=
X-Gm-Gg: Acq92OExIiJKUhbeIWpEV3HO+Vz3sP3CAl/yMam5aj22xOObhTMcEJMCb6xuWmkfXry
	OOru/7sQFrGIxmjo7zXWNapLr0D65yj+QYP/f+0lzI4C00B4zXNeh2/q6/u/zbOfDJkD4+aHUtx
	fUFpJqSnmgNc6incVK/NkeiyBFFLpPsXCH05vHzqCdFOKJ856YUyiIYS2QfNE4JaT93LJTUKaIQ
	Fr9LjqoT6hZeOaTf8rQUKHEv705qdUtkHs/IB+RwXc1bjAV/gUoi0rUbByFDZ/wI1O6SWgmuhML
	Q9fLbKG576YjEAprhqs7P6HPGT8oH5yonPDbk/dnsaPe1xC/xWiadbkJjQvO3V/hee7qFrMBU3x
	CX9Ld8RDdFgFnTp/+ol2xwoPbYySh9dJf/dmcwgJZO8k8QAKWlw==
X-Received: by 2002:a05:6820:4c16:b0:694:9764:a6b3 with SMTP id 006d021491bc7-69c942936admr16112709eaf.10.1779289869934;
        Wed, 20 May 2026 08:11:09 -0700 (PDT)
X-Received: by 2002:a05:6820:4c16:b0:694:9764:a6b3 with SMTP id 006d021491bc7-69c942936admr16112674eaf.10.1779289869478;
        Wed, 20 May 2026 08:11:09 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:9ec3:885a:6d78:48d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm57874930f8f.18.2026.05.20.08.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:11:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: at24: Use named initializers for arrays of i2c_device_data
Date: Wed, 20 May 2026 17:11:07 +0200
Message-ID: <177928986469.69031.15446150701253816730.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519093806.1567914-2-u.kleine-koenig@baylibre.com>
References: <20260519093806.1567914-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g3vobiViq1Pcq1-w1Er5m5nTQ94iztOI
X-Proofpoint-ORIG-GUID: g3vobiViq1Pcq1-w1Er5m5nTQ94iztOI
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0dcf0e cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_zlTGdml_0R7UvO8ur8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NyBTYWx0ZWRfX2DwpzXQQ0nzF
 dX6/h8GxlTa/hDRjndF2ApzC8MQ3/fdaeaaV6H7/CSgFRDkN6xh/jnFpwJ+rpYWOVeXFNzbWhaW
 aO2LbxMzFm4gR2IjYWPnVZ4txac0Q80HtOWTiw9DJiWX+b9nF4DzDZZZsGdIi5gEq+L6PdO0jPL
 QzsNNuq0kpIV69LV/Kn6gijG1C7z/MrgUYq5Sha136Vz0A4N3dP2uT+4YSfXXSeiXdSbmd+aBfE
 Uood/j9a2DFbH1Fmg/OMhB4xHwHuPISaeeivy/0G9J8Z86NpT9lHg+sUAcSf82e7D/9iGFRFoCC
 dGR7Ccn08YqNYJSfwMtfkDp4vBqI3AhcLZDQQzyVlSwRFKTcqli3qXbGCdZkJfPQ9QsjinUVTY3
 eFEK05rKjYDF+QuMw854YXkARuToP1CTxMCVhzlr1xFSsep0t51spVf+sXAa4XgZR9w6cgjfWSr
 64vwgJUyfA3rMm2H8Tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200147


On Tue, 19 May 2026 11:38:05 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> [...]

Applied, thanks!

[1/1] eeprom: at24: Use named initializers for arrays of i2c_device_data
      https://git.kernel.org/brgl/c/b4c01497688528fc04c717842f8f310569f52629

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
