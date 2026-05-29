Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BB3DE453
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065501; cv=none; b=cpag+JQJHhLnnOweliNiOhlb7KUGmixHT1J+kMpx6TfLDWyYOzNLz33euv20jC5ykvt6AD0aPTXViQN06vcZmBzyS60PX43GOUl44fgQ/MCWjRP+YhSHUESAOjB6mjTLePfm7/6pYlg/7ZtoWIJw40+rKK1CnQIcWXTtApq1ilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065501; c=relaxed/simple;
	bh=l+JS0/V7F9SxR762fsBrRDPKdNY4tt+gxYeFpW4yjjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lumv6R4G0+Zo+cIxi5nigwNtWJFMoTuHsX/ktyoCm6OAGaS7BNFnyYilWXnrAI5AXy5DCcRUsZj3Krfusplmjv+RdeG14GDxcvpqzm9vZLCNZyhMUPDTD940ZbVLIfE0OYNrbnNYDMp3WcXI7A969GtYOxHtS7bkAKolxkzMU38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TixSdWiy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Reujl5az; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TixSdWiy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Reujl5az"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDL0ia2334976
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QGMwQkPzipHzU4ZZrB3/jEiaaHrI0ZZ6zyUZVh7CpjI=; b=TixSdWiy3o/wKE2v
	p6AUpOtzKupLjKGR8vRKPS50KWtjjfgRdOdswXt+diKsR9EL4Cqo8ikZe4RdD630
	v7cdknBuRE/E6ReOklIuifLiWsE86vEFELXTi8puE4/SixKvAF7RvxKQPMvvd7N6
	uHM1TO6A/KQzUXnOPyWHmPA3zHyhGcl+qwxfKyWXRuczdMcCKtjEjEIBXLqZdcdu
	XDtqDNe8U8mI6r30N68alv4xUZtC+vRs8wlDwt46yM7hVzLfh3yAFH7W9+kjW40B
	WYI4GWaMVfYYw7eBILIvauPrUn/brREsjBPv79xiVMAqIesc3HIT0tzqTrPJMsrr
	VZyu2Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj277e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8531d89e59so4758292a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065498; x=1780670298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGMwQkPzipHzU4ZZrB3/jEiaaHrI0ZZ6zyUZVh7CpjI=;
        b=Reujl5azwNxsTexQRvOgQ02O8Edc+4nDOFJ0SEWmBWhJOPjZKGtlY22v8gb/FUxP+3
         Dm/2tYcQO0QAccQGr+cWd4sFzSm+YpmdVZYorSiTHdYI9ZG3pqmOJxRCMzcGnltU3cMP
         4DOysGgbZG167dobrTrZBo58e9RpA50/lTQNpnXMoJ37i3LBNLk3gePBpHOksmU8j4ZE
         pvYa/3BVRKG1OBou81I5KdRwPQw3KWZvkhIIGaS0413AKEEJ1e3L1Oncjkg5e05XjzJI
         eMWflXNpdmH6wI1xlcey+91cfGSdFnxJgqGAtOY2rTmeaNy0vFcjKvtRMppOlAarcs1C
         pHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065498; x=1780670298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QGMwQkPzipHzU4ZZrB3/jEiaaHrI0ZZ6zyUZVh7CpjI=;
        b=kqyWg70aEWVsTBwBThAoE+LtgwcGbw0wR2okyWzhdOCDNajf3EKVu04KGzrG67ZedB
         s76rq+J1j7dlHdLy4X0dfl/23WDhNwaoLy/NI72D7frtCxKX318aCWeds8onGyLcm5j9
         rdgoJhpmOBRvwdeL9Dx/ji4uI0uXcXH5CQBNGjCfrrKb6iwTcd4oi5A1bhUmC5NgHz5T
         wAW4/mkanOTGvGxqvBgW6aQW/EDL5cA+wV1PczvfWEPA6ESxU4N0LPVFU+lpftk11lD6
         YCmisSpf6glqc/k50Fna7t/AMwLYKDXNl7iUsYcDcdYTrIKviNfJMKtd8mDOzm8M2gOT
         DxCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bCizubq9gMTFx9D5Nv8YzKaxywE8sgHnVEYbrZAcIbNtepXkooNKGHjcUtYo6H/OsxAeESxyye1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRa8CVRQtgXfmwV/78eoa7rz06IAvBkse8EhqO4/pb9KYgRb7K
	+LgB7GuISbIKPH98/Zd1+LvLO2OlMRhAligIIe/zMANTOoLqH/1T5wDG7VMauMufxULj3hZU7UB
	EXeHriCYYuUdFyK3NDcONFUH0S0pPCZZifUeDT+02lm4c/pDgOgfUFNlZuF0jVvg=
X-Gm-Gg: Acq92OHbVQT2Yjt32wbq4tz0NdxygOBzh4IGo3ANZBcrxSc8qInMjGizejARMqlDcb/
	+3cesqaArBOK6Ri/jAgUq62BdRmz2XWkxGH3q20vS0d7pAyGmT64DgypTsfhmm1DYdRVADBGrQ8
	mnBsk9sjwvHhJLW18tvIBPp9A1P3Xv+j4grIb59fNp36xlMY9NvYYbweKGputAOgvREPsm6+BU9
	uvaCTvpW+KhT8Fln9D+7rcFYFfXrjngvJ+/SWmQGcuUryjHjyeRAyEkWfsOTRyMTiC9Jn4DFDE9
	tSaPcQJvHRpsT+OCNRki1DWyHxWpXaWcuWyx1yDanicvIBw3WW2c1dyFRXaPz0MScJ+I3mTTIcJ
	de4mFM8QxhS29ZuzcyImOPOtFxNWMgEbwfC11jx1ca7nD/kgKHoUiBxtpq5llsbk2zw==
X-Received: by 2002:a05:6a21:2d0a:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3b40fbb92f0mr3468700637.14.1780065498245;
        Fri, 29 May 2026 07:38:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d0a:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3b40fbb92f0mr3468650637.14.1780065497602;
        Fri, 29 May 2026 07:38:17 -0700 (PDT)
Received: from hu-vikramsa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772993c9sm2469394a12.15.2026.05.29.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:38:17 -0700 (PDT)
From: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Date: Fri, 29 May 2026 20:07:25 +0530
Subject: [PATCH 5/6] media: qcom: camss: enable vfe for Glymur
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-glymur_camss-v1-5-bee535396d22@oss.qualcomm.com>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
In-Reply-To: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780065463; l=1015;
 i=vikram.sharma@oss.qualcomm.com; s=20240628; h=from:subject:message-id;
 bh=jDLUm6YnxTB+dzZP+8UMYD68yqrSVqE+1xzRrHZApRA=;
 b=3JdWfJ/8WhoD5EddR3HWIOuJMUOz7cyD8v3M5qEtlaVzKk4JboEyAHP/LHW9GhtOVy7exZgVk
 IC7TYjbEqSnBY0J2sNyaiwvT02f78V426fiwMwDtDM0s6TrNHDwnPYJ
X-Developer-Key: i=vikram.sharma@oss.qualcomm.com; a=ed25519;
 pk=vQBkwZr1Hv+VXogAyTAu7AEx8/6bvkOmgrzYFbNGCDI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NCBTYWx0ZWRfXw/NMI7ocWYW3
 AF0wCa9fGxqO47pfSLbC412W9FadIP7Sl6hz+ItGh65YPhxLgCOcNADwdRaBAjsu/FxZNWga4uE
 sxSvFW8DzaoDKdv4g2cDP55JIVPJ3aElJTU3/3N2YV9eTlX6K2EDgU5NiismF+m+dz+dKRolgux
 /B/h20AAHMO6cEv+YDuEsPvSqSwhw3EaPSGXUwT9bjvZC7B+24DoP4mZ3c5J9/WqCU7q3Edr5xm
 ushWR6x56Smd1zEQwLbBZeboe42ToBkOmiLC4k7zuxt2arLwelvnH/GTS2Yi7x7ToZvU2inhrqb
 qThxAzGFrkL2JoWztDBP9jtH6AJNnE4Kym/UFKOXz5gV1TY0MyYgmdAa/PnuNwis4bmOgQh/qcC
 25nmEjtrfJ/Xky3zs2/qsOnsQ3+aMTLrfLCrbTawl7+UM724aoeMapw75uOC04pwUZAZrcR88oO
 ZrnEgpzS24Cm/omrXwA==
X-Proofpoint-ORIG-GUID: c17pO20_LTHP68T5RhJ_RAdc7SKru8l_
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a19a4db cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=yvjm76BnGd25jCJ5QS8A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: c17pO20_LTHP68T5RhJ_RAdc7SKru8l_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290144

From: Prashant Shrotriya <pshrotri@qti.qualcomm.com>

Extend vfe_src_pad_code() and vfe_bpl_align() for Glymur.

Signed-off-by: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 319d19158988..baaecc22a716 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -353,6 +353,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_8550:
 	case CAMSS_8650:
 	case CAMSS_8775P:
+	case CAMSS_GLYMUR:
 	case CAMSS_X1E80100:
 		switch (sink_code) {
 		case MEDIA_BUS_FMT_YUYV8_1X16:
@@ -2013,6 +2014,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
 	case CAMSS_8550:
 	case CAMSS_8650:
 	case CAMSS_8775P:
+	case CAMSS_GLYMUR:
 	case CAMSS_X1E80100:
 		ret = 16;
 		break;

-- 
2.43.0

