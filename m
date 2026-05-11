Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010439E19C
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502653; cv=none; b=a0MQLbL/xua6wBt8/LmMig0P+QYgOWVvX6LnGyfHtyqvPuazomDeo/s/jB93kDZjCFRQtK0zeQxaQvOd5KGcUXdLNiceDEoDG/mQ0Molbj0YtViOgEQla8WqCGpaerYU7CylSskM52j7PyNZHJZfhJ14noxDpYE6LYQ2kERUifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502653; c=relaxed/simple;
	bh=ZU8k76SOmjPQN6IuuuVJtleEyvAGjPwFGN9jFLmwTAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZpgj2x3x9otbX9Dv4a735VlCABnSP2lSnNmtxCUon995Vds5uveSW/EA8OSPxfhaQu9723X7fJQBCDbR7rk05to2CRs3FIjFFAsifgTUJTqsp8nAoLO1JaVY+Vb6P6Au2TLR14CpZ7Y1v+O6dobWZtQuHKBBUsFYiP9Pq19PcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WmTNnOty; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S3sdty/b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WmTNnOty";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3sdty/b"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7FJdK3332677
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Q9pnr+nVGzHyjymLS863osq0vY/78544Lb3
	MAq1Azl4=; b=WmTNnOtybyxsxT0hCkc/jzr8V2Q/klt2yFXqbaXO5SRWSJzVrSz
	+M/4QY6l9UnivHIpz0GYaIyKtHgNm4Ha/9Q4R75lkUvY2Z6T+rD8QETDtHlU6hzw
	Lehixav1pHgToZJK1GrR2CWcSQqabYYTd7081HYcv1lEd46bhHUo3iX87+DXTHa+
	xBiW6pAMiAnGjiOQRXH2897YnZ1YV2RT4ooExPTrYe2ZvZiD5T8YC4cl6NBLapGw
	FHp9XKgfQjCKX0FVhK265xhW+paMXh/GkiCveJH/v2f4UldABHASbKMq1wPb6I08
	pxx5dJF7ZxTt0rTfKB1fxh5I+AkkTqUTdjQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ajgs499-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:30:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51494d74d4bso43741631cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 05:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778502650; x=1779107450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9pnr+nVGzHyjymLS863osq0vY/78544Lb3MAq1Azl4=;
        b=S3sdty/bYUtUVWEw9dXlVCN8XKk51X1hYjKlLfZRhNzVURsjGUGXUrjoefkKvkMC3C
         cyevBwHiRdedA+WiQqeCTcIFzMmDCY6GqDFMUbMhMJlETD/ajuFtIILaOODQ5ySmWVwg
         sDqZ68WFmvvWJ2t9sk8HGXp6WxQ+Stgal/qUeU7QxtiM6iw07HSoLUcBw7obHvR5qK+f
         tw/Pjk94DcRjKp3x+Pu0dKBAmfwbpdMGe866zEHQa5236Jbys4EZ6rtbrIAAu3HjTX9l
         8qZqCCGZdmU3DFQBNseoND0Lc+sF+8AsPAwRbf7FxCvIgnlUjZ0WFaaC65fHvnzcyM9s
         0oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778502650; x=1779107450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9pnr+nVGzHyjymLS863osq0vY/78544Lb3MAq1Azl4=;
        b=P/UOE6/Q2v0SeDGy1StdWL7fInukLThSvQPoYckndwJySUTNEs+i65psGY6FChbtFX
         bGoAZLOyOWcHKtYZjXncTDbIqMJlBArB3U/B0HquVbGsFgAO4ANEK9LKWy0sqXfWl89o
         4sKHke/wRzfy0NO8iwnsSStJm1yd4b8UXK00JocaFmlXWDQH/lr6Xwo2fkgI843jV11o
         RSSa0VvrtPu5CuP7eYS1e00jVjLAhQlQpw09QEVbF7Hsm4GgcYb4r7YO2BNOlSzoClTE
         9mS6oY4Nf1l2GvCjUtTkObORUHK+jBwZeIKeqviKSCz2O/WOsLdaYMMVLJQHrICP15CB
         d2zg==
X-Forwarded-Encrypted: i=1; AFNElJ9xq0aVjnvs311XFp+TvgSgDaK4vuHKQCVt94M4wTQQ1Gi2S92leFmj1JDHCzvNGPNpsjVzhxLuels=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qf1XFxOg8aK/VUvMd2eT9TDCuTg41cMfKz4ihUZB3v9MuNGy
	13clHjuFwHBI3JvGJnaVIreuqQua9aErP+Lxw0xDuBiWXiUnpwIkx5CBm2yO7dujnbDJY7ml0NI
	WuA1tQHciu2a9Bt50SMlcWBRgb4oDH6PTPUYg+W1vAXnwEJGRvbsrRBT1EXbEssc=
X-Gm-Gg: Acq92OHTiY+g4ew9RsloTbvT2MsvdzVy5v+FfZvWvCWibT1diO+91Kt+XO7DaN/28AL
	D3DeDt3kCwMw6e83yf3MdKp3LZGfcjIj18mGeA1t6rzHzU8DyS6OxtHgY+RQBSRzmKi72wyUxPV
	VdA3ManMLZRNTnEgrhQ/vPWy6dKB6NPTiCHacnbqYJntJMd5QCqUklMxvdBPERI225C5h9uPSZh
	XOJEEVyHOuyFXp0ozGEbSYkZwVM2mDQpBKYtxUGKJkPa2eYOuDEECOYIE8eyeOYqGlUcvBZLOvd
	I3phrVD4agIl7WYJ3YVw1mfNw0BG5aLwErOdffQy70iedcdgMjjGFPjcORxWnEKz8+/cirgXKwh
	H02gQ0XDAd5tGXVnxeFOQ0LgwyWR8ZFuQGAvR41B+yEOF2pLmJA==
X-Received: by 2002:ac8:7158:0:b0:514:c499:c5ed with SMTP id d75a77b69052e-514cb9824famr3278291cf.18.1778502650303;
        Mon, 11 May 2026 05:30:50 -0700 (PDT)
X-Received: by 2002:ac8:7158:0:b0:514:c499:c5ed with SMTP id d75a77b69052e-514cb9824famr3277811cf.18.1778502649764;
        Mon, 11 May 2026 05:30:49 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm26219261f8f.25.2026.05.11.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:30:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] Immutable branch between the GPIO and I2C trees for v7.2-rc1
Date: Mon, 11 May 2026 14:30:42 +0200
Message-ID: <20260511123042.64315-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GfgnWwXL c=1 sm=1 tr=0 ts=6a01cbfb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=M-WlpKoQUZIhws24ORwA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: sR14KZBPPyjzWrZlqrSgITV5qrwZftyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEzOCBTYWx0ZWRfX8P7lqiX2g4b8
 gtSNi7BnG0tNLdATLxa2vARGvVa+gNJxfC0ffTwSV6CxOT70EsoQc/jYmnPPbshbkiqyQNHofy3
 UfrfWoLAQ0Xo/IVGoZG0LiciMWZXKcpsAaT05q80QurfjWoyShaeD5jV0DqO0oB7wPXtO4F1EYi
 7VISyhjpUtod2V3zEzXzum3o288Wwc3ZU6WQYSV9fzY18KUfGV1onvKIbIciXYTDtzDUjqZhk7A
 biWxE1+GUIz8hQD04NA46tz+1ifKi4fYks4WeIL8VlKq+mZEWdBE2LSxXIqj2sEQAlmK7D9tdnd
 dMKguNpR+xfNG7AtTNewMLmVHQENWJ6UQz3sBcXeLmvtDSI4CTpDXaEEPFitRUnHnljc9nTM4AZ
 2vwCw+VP9n3i1zYJYHyoRiNXKVfO9hzMCIDMc9Y0bLYZnTezIlcVs6/BpwyN9lX4ECGZUk8xJrE
 Zup1LrYS6mgDGZebYFg==
X-Proofpoint-ORIG-GUID: sR14KZBPPyjzWrZlqrSgITV5qrwZftyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110138

Wolfram,

Please pull the following changes adding the gpiod_is_single_ended() helper
for v7.2-rc1.

Thanks,
Bartosz

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/ib-gpio-add-gpiod-is-single-ended-for-v7.2

for you to fetch changes up to b5fafa01bdaade5253bd39317f5455d13e6efc7d:

  gpiolib: add gpiod_is_single_ended() helper (2026-05-11 14:25:25 +0200)

----------------------------------------------------------------
Immutable branch betweeb the GPIO and I2C trees for v7.2-rc1

- add the gpiod_is_single_ended() helper function

----------------------------------------------------------------
Jie Li (1):
      gpiolib: add gpiod_is_single_ended() helper

 drivers/gpio/gpiolib.c        | 22 ++++++++++++++++++++++
 include/linux/gpio/consumer.h |  5 +++++
 2 files changed, 27 insertions(+)
