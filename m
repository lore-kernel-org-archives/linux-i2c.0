Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601680;
	b=pFD5A3Rab9cDv2x3cvco2hN4muOwi7U1hM47zuIFqbYiDtulrjW/guq/KEVdNkk2mNP1
	 wWtj7Hsd4YV1ISP/yiflE5D4B3jVT/zZrRD4R3EyzZrFHlIoC/Zc72gJzWPKq9/GwzDSb
	 rsn25VpXkwb5ngmQHMJX2EPyjSPxbOUDps6OdGEgIjfV1jVjm4g73xF5C+ZyaZFuDQpJZ
	 /QePg6Djnkw/0lAv9G+2nkCrqqagjrcg0lyVdvIraEOGiehIsK9C29KEL+xn31ThEoZoI
	 2ml7r19ws8Efcm8elvsIZxmYz4MXMnIofVqlgXzmVvig3dd8YtT9y87mcVFcMtICg5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601680;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HVdsA47aDoI4CMQ+bLdyYMuFiKteKzxJMFZ8slEZfaw=;
	b=tNPpt8Ct2lT4Lwp5fjqC8Ps73aeWF7KaVUGR9KqLEZcZaWrQmePXGx0AN8VYqDQeR4Da
	 n0uH6U5KYuz24zfduAUOpwhJ3KsrwTKNABeFvsRF8ZF1xUQW7r6Xkhys8mcExhf0jfsCk
	 DvQHX8gPH4dm1HoUhNWa6WiCaGF9R9YJnR2pEHDYO1njKBp+JIYfyMP32mcBQsKfUu+mn
	 INkObGFdRDRtso5A/hxmJ2QQhDqbJTem491hhSErVrprvekFOZpFPX+tB/95y5PYgNDLI
	 W77W1GrfhCiMEjh+4T75/owc2EJ4ChVBahbyKJQ3iNRdukN7wD21Wi07hrEvOGToT7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nhJEjgl2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HMbRbE26;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1F606A329
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C1F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nhJEjgl2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HMbRbE26
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mihT3642223
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HVdsA47aDoI
	4CMQ+bLdyYMuFiKteKzxJMFZ8slEZfaw=; b=nhJEjgl2y/o4dWRJQXhb3irWSqo
	3v08ifC5n1ZKlNSSPCfwWU+klZNlvPKSwLl3L3JyaKgFOBltKsOtsOEgSiVIR29F
	c5qrDL2tN+hRucvwk2TnDvorH1m5ecFjscYULfMJV1C5UC7JqJ46//eqqWnkGCJu
	RkGxW2goq2gE78THjTotQI9Jo//44rK7UdxYAd1Eoi4PRY9aq/Af0ThJLaYCo5+P
	4jr53dQ2KYTobcNl3hh6DxIZEEiJowrvDIbWmh4vd+UZtZHZpz3PIQ8Y0+VjrpPu
	Zzq+8FoT2olOsXUO2cvosGToCx+njYSPj7Dfi6inZXlIxKW3fr+KJVBgr/w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc2aaf8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:14:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ee04c49451so67941005ad.2
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 02:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795601678; x=1796206478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HVdsA47aDoI4CMQ+bLdyYMuFiKteKzxJMFZ8slEZfaw=;
        b=HMbRbE264zxJQf3kKhzRFUOphLByXq9E/IV3nzUYCeOV2LDqgQyMR+JvpjmXVTZG6e
         nfXnyYzFINYj6rbw52bytqs9MXXPl97mGlAxJFJw82/wjllp8TFX6xaHjXIp1lwaHw/8
         0OzhitHy78ReD6YCRUWCvK7lzw/mQW+PoZX2FPDA9OlLI/xAz+2+YU5LktVk9gkRykl4
         R3K3ObdjNdq5prRRXSDt8TwRh7Rx4D3ujATDHUi5MRJ5gSTtEmUc3AfVcT9tYoG8Dke2
         Npqp8Rh+iJWmaCAV0YAW3eE+3oVl9/wi7yiwJE24DVic6Oqj6Kye8saMNoZYMrwVJleE
         qA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601678; x=1796206478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HVdsA47aDoI4CMQ+bLdyYMuFiKteKzxJMFZ8slEZfaw=;
        b=t/hwN0GafFa1X/MKtmN4CEO0dIhFH0TKIBcS3w7AEQbLeRzxoFRev8Esn0qn/BaFz1
         PEOQb5ILDPnyM3wWECNUY0oWP7CXOaXuVtNjqFi5wwV4HzkfM5Udh0/wpRznbJ/KY6kX
         WBaCgtDISVoCfB8RwL2+O6VS4E7Xt8ZLtBdSnG1Qdng2XZI78laOMzep2IFdl7lOHDQl
         3dp+AT2GWuGkM6fR57xpEKvfoKCNuPFlGrmMEHwzz7CIc9pSP0euzatcE8eWxFM863pY
         EbiIQ9y7ydTFbFI9m9vfYrDM9T5CaH3PC5MRsJ+18kAbhIoCMDpDGVCNnWUY/LUz6ZjU
         S5TA==
X-Forwarded-Encrypted: i=1; AL+hErGehZRkxZfDmVXzId2ICODquWhUB/ER7w7sB+Lo0fgcpsGGkXuaV0rN8E3ERdRAki7aoMFmoLX7jOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YlmNBzfMgjZMuGUPkWijyJRRqrc85vys/eKF46lsCIBLrGp6x
	UB6pcxwcJlIunpenxRyOTwJ/F6NlIOMVAufUTE/V2tFtcYl+1lFy4jyB5vL+1etWVfgWzmyfir+
	aA5ICOwP/7FXVgUIF6SpH/HLpxPVgvkNt8q4yt8TmPCar1R+z7lp2L12n0YSajfY=
X-Gm-Gg: AZFdTZd1SxggnsuDFW8pi+YN6FYDgfd4AF1tn3S1TXvPrMcbgMYvuKY0Fo5aYCi6rQX
	Ezk+Xnm6kJupnTk+X4KFwNeYNhZEOVwRDF3MxFmDDYngIEBXohy4MOt6K8VyBpHIMuCXvBhUp5V
	St/IHBoONoYbx0E0SWzsm0sM8/GZ+XFHLKqxodBHKKvaudvJ9EWUVXH4qIkbmLWpF7EftYDIkXb
	uuMuDVZwB+dyVn1Onx1ZDqnWk+7fB9QpTN4MeDg9W8kzm6IXv/MkctAimgV5+dVNuJCkv509m2y
	P3c3ElEUAkLBvDfYvrrmEfnAyfZw5k82gcJ55cR0UUQ5FRJBvP449SD0CU8kLsBL8oPgA6CHkTe
	hDgZc2C5xr1TeLwl6UCKiH0wam5GJ+/bjHCpyZOnY8YOT97EO+x0JBApJxghYMUmi76AuePQzOS
	aAC6WJ8/BMJoNtmW2sjkn5gTU1EwfMEq+CFGnx4M2o6TU+JuggK4vF0H8M
X-Received: by 2002:a17:902:ef45:b0:2ef:ee1b:8e50 with SMTP id d9443c01a7336-2f03f0fc314mr164139745ad.18.1795601677855;
        Wed, 25 Nov 2026 02:14:37 -0800 (PST)
X-Received: by 2002:a17:902:ef45:b0:2ef:ee1b:8e50 with SMTP id d9443c01a7336-2f03f0fc314mr164139575ad.18.1795601677447;
        Wed, 25 Nov 2026 02:14:37 -0800 (PST)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm84036135ad.50.2026.11.25.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:14:37 -0800 (PST)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: Add compatible for Seca SoC
Date: Wed, 25 Nov 2026 15:44:30 +0530
Message-ID: <20261125101430.231766-1-yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6835fb3e-5f05-4f32-bf5e-85c5c5803459@kernel.org>
References: <0439e03884c02c9edbec89132b526aaf8f54ae23.1795517696.git.yadu.mg@oss.qualcomm.com> <6835fb3e-5f05-4f32-bf5e-85c5c5803459@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b06b50e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=nsDU7YxpfX31B6LV5i4A:9
 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: XzqTg1i5Zgm0JG3AQLUBd6yYqKQcjFy4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX5ATxGlbpw8CW
 D6Ui5lAC7/XrT3ZOdGoaNupXMBuaTsmvd082QVXEhbFP1VCbDhwwcY3cRBGb3gzdF7E3tdkh0s5
 MBa5IXZTr0OQ4Ov5gZBtSeLYGKP8Bfs9umcVEqwnl83Pt8JI5bIHLapxmX3Ieiad5qXdohTlPB+
 LcMHy0VZHoi45CZA6vHShz4Brp1iJPq3p6IkWmjz5TGCmPaxsOqfL7dAVvJeuNJ5rofDZ7ZZe9h
 mS58aLacXJ1Z5ngePG5I5Qg6+tMaTHE2vXe8Lo7j1Np3AGUG+UdoGif8XUkM0fQX37SbS1RaD6N
 a4EyOWm7yvnpRC88lvbQyPBDrh9wzmVg7zSZJu0xJedU0opD2qvFdkgSVNY1Ege3o89Tr3Pga8g
 bXlZ47jXuE+cevGTASnEByDf0bS8DOoO+TYsb1/bgpnoznOyVmfF7rorpyyZ5OSq+hLi//YvMHM
 vcM0cyBdJICrCmJKDPQ==
X-Proofpoint-ORIG-GUID: XzqTg1i5Zgm0JG3AQLUBd6yYqKQcjFy4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX9uHZ1itBfA9O
 OkPyOGjYK3rxvIgYqUMsbZ2af/nzXYfR+dfEhLvTMjgdGuC3TkM26vPn1XOuyYHL6OhVJz42Ngs
 jLUQODXbzwCZ5939kOVzGWhRcQhiD7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250040

On 24/11/2026 16:46, Krzysztof Kozlowski wrote:
> That's enum with previous entry. I am dropping all your patches from DT
> patchwork, to avoid repeated feedback.

Ack. v2 folds the new compatible into an enum with the SA8797P entry,
here and in the SPI, UART, UFS and QUP wrapper bindings, and will be
sent as fresh, regrouped postings.

Yadu
