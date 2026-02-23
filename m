Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5B34DB61
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837382; cv=none; b=N5d7kaJ8Y6BgcbRr+75XajlZfooEx6DLtXrOUacFp43tE4ejDFy6qq6JHwl/lkfrBuIVxJwuWmnVx64paqvc558YPOcJK8YPY+QHEOR9jPxNR0MpnrnzZVRMjn+WJ2hVqOHISCBhvopZuaQk72XvEvFNQby/UxIgYRMUByHf6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837382; c=relaxed/simple;
	bh=5BmXq8ls638A4UX48+WiGAJHmMf0MCmHxtmmGfyDjIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rzlM8LRgWwoM2TAnOBy5onDepNnCdYTf+OopBCc4UYIm7SVUgxDpTkpJyixkxBNh6ARMUgTDzeec/DRffBaJcY95rA4OUoyhf3ZijxwO0T41UQfR5f0y/vAlZxgvIOxw+tq7D5Tmtj3kSp7+Ol6Rhw/3JnW1qB21pp9mifUhPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JP1IKOLj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O2qOdIcx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JP1IKOLj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2qOdIcx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N17nBI2203676
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8SHYs5LFd7rnDOTm1Jv1ws
	TvILa3sMGiNbBQAWGePpo=; b=JP1IKOLjF6PeripFaRzBcdwUz902Y81sBQhss2
	UU2c8F1/MgCIocGNp1ijLGoJ2OjxlKmnu7v2ixqbouKCez7je8U2+rBuxS885p2/
	2fcEOVzebV/bgn2HGTOEw44cD+RYA+UdVubJTpd/97pxJyjpNBRWBNr3glmBYU3o
	QgKn6YBGyQrJcndBf0mZ8HYE62xfQZ8/1ILY7hBEb+0WgP8zVPvRIPIMVk52V0pR
	/Ypog9QOoN2XZ5orfR7km009DZS4R0T2iKB9aVh4NbF49iJ28LyNP33sSIWj59nq
	+20KdhmaL+ERbeh3MzsLp7nrVj5LR4SmOnGoGdB3P+u8IWFg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wbc29c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3a2eb984so1166148785a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837380; x=1772442180; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8SHYs5LFd7rnDOTm1Jv1wsTvILa3sMGiNbBQAWGePpo=;
        b=O2qOdIcx3KVPxLsvwRU7TMO2xZjY4uHAHQ5/okSP9TiVsCMzL66EpQKmWREVf5BdrB
         PZRLr4P77BOnbLKYIr5uv/bbhEhUfNVR2bdXg68fMGmYCavXPOvVV3hLIfRySLe6rWu2
         65en4FnmKZfTuqnuoXQC/g9V3WRvz3Pwwcqm1E9Ve87DhlCTJCOFRGrjfoNmBSpzjke/
         QgWqoYH2pxN5DeRuoowhDR+cUFZkwwecr1XjQe/vrIkTBw6iWhr/1mZbsdsiDYNaYnem
         bk60D2uCAlyl2f5wM7y6jKDTat02TJL8mC7ZB08aI8uPzaN3lYAGZpm7dj1tXkDJY4X4
         M1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837380; x=1772442180;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SHYs5LFd7rnDOTm1Jv1wsTvILa3sMGiNbBQAWGePpo=;
        b=fLFAQVSbZE4ps8qISuMf8EuQWAfxzoPBRLcLVB+ajqSsqWBEVlQ1g2EHkNIbyFF/b9
         4owsetaf++pV6eDexU03CFIagPmnQvaOvyyLBSWML64VJNzLYLde/qEfIevDneUeUJBH
         LaMur1XF8jiLdDYKAI6BbK5IX8pYgbEVZjzPhdwhkZJdNReIL0wSIv92THD/3Yt954r7
         SQvQcy7xk6nvuhvJT95Ag1TXPFYBLk5haWEwvuMe1tpa2EzE06yNPmEFvUqWqshk97AT
         uaoQj3F/97//JXdCpfpdo31teafW/07Zl0tGXnPWEG1bLgUgpjlnA7GOl1qecBdFlfWL
         a4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+YV0teu49pj7oRTozoOEX3dPomvrwMtVTe1yfM+hGQAnSWBDo9iE8aqjlaYamdn5/lVH2OyFlzmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI/jD+auWqkKZ14EAIwudhUwYxWgS/Frn8dnP0mx41M6BIAhmt
	khbzCqsDXaMK01aS00UjdoIOA8a7ai4uRmQUrMAw/fgg1rAXMJLpLhc/6JSGFdnY/8v32Ae03VB
	nOA5zzuC01///QpZ2PVv0126GZNKa/4mA1Z8ft10A1NXFE24G3wDjV+U6IG5DeK0=
X-Gm-Gg: AZuq6aKNR+sim7TGPduxoIvMB74LlVJbFjnYRyVBsKZwifaBXFBMAZre+4hWZ4kzYuP
	0+5mBW6GriflydggYhn+H8GBVw5Eqx5eeSzlkNCY7Ih4auVaZB1aSZCsWNOVCCnxgMI39x49Whw
	MeOODYN+w2mC5NEo0lZZr9BJ8NQpsyKrs+pKOJgcpZoVbN8aa8AXn67TLVp2BmSvGEEaBZk/qur
	dlFbJ4FoOdOFf6XDbf4AsW4fH02e7sBtIYiyi8P8mnKCd8Nsh2wUAEZL/86O1VKCqZAXv09Yst8
	t0x7BBzHz3pD1KPo4eqhARBccrjzH6MIS5+eeCeOnYYqVaoWNbvRaBThzcUQejU9jL2EK3uiGsJ
	g6qoA52NqoqolFd0Vy7GBVedrnCyAiIm4CCOAIs1O2oO5tcOWZr0=
X-Received: by 2002:a05:620a:f07:b0:8cb:50d6:18be with SMTP id af79cd13be357-8cb8c9ebbffmr981135385a.18.1771837379755;
        Mon, 23 Feb 2026 01:02:59 -0800 (PST)
X-Received: by 2002:a05:620a:f07:b0:8cb:50d6:18be with SMTP id af79cd13be357-8cb8c9ebbffmr981131185a.18.1771837379238;
        Mon, 23 Feb 2026 01:02:59 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f6csm19657169f8f.7.2026.02.23.01.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:02:58 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/4] i2c: provide and use i2c_adapter_dev()
Date: Mon, 23 Feb 2026 10:02:48 +0100
Message-Id: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALgXnGkC/3WNQQ6CMBBFr0JmbUk7KgFX3sOwGMsgkwitLVYN4
 e5WE5duJv/95L9ZIHIQjnAoFgicJIqbMuCmADvQdGElXWZAjXuDiErQKurIzxxUx0k9Anmfs61
 rrCptGk0Iee0D9/L8mk9t5kHi7MLr+yiZT/tzbv86k1FanW3fVJp2dU/N0cVY3u50tW4cy3ygX
 df1DWHGqKrFAAAA
X-Change-ID: 20251222-i2c-adapter-dev-wrapper-c882660190a2
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hans Hu <hanshu@zhaoxin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Jean Delvare <jdelvare@suse.de>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5BmXq8ls638A4UX48+WiGAJHmMf0MCmHxtmmGfyDjIU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBe75xtiM4tO6fl/+cumfqZU2dafuPou4bc06
 2xQzIhNAuOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXuwAKCRAFnS7L/zaE
 w+PwD/478ne95/nQh1MYeDPbPE2X3cENP5dJ/BeQ/KNbi03x7fGjaTrMhVxSv6mu2dhedPEWWWM
 JSDXKXJsawpPMJS36E2XvtthpBLKjnFe/btyslv7n0sGaEH48KI8jnL38ZIprT+8uMX5qG+PVcz
 f9wK6f2ciMk4f63I6sMWxQuiou9+s/z53CMbIcXcggRoRp19KFV0dDzUIy+edQUyT9tuinAoJc1
 /sr3mXj9cDzloDyDcV3Si+1wDhLlxJdkj7JkYnHWSaDbJAoz+F4sXtjj04SPbAtkkd6IgCYWhab
 I1B0jPzbZKWlf8thduAJtEbmA8PN1d4nAV+7vkd7fLufd15xCWEgMw9ugzcHvB9RbTkhi/odQtk
 PlYmII4nDUgRHldiS7nxe6vli8UZFggnYIZnCv2Mfz08OoMDqrCfz29ijSCseJlGGm5I3DR19yR
 3oCNahYYXMyxPRaC50AEWvl8tU6AU9VXUN8b7+i8M7eqnaBofk02CDQFXfRSPTv+1cFmCngsxkT
 TMRz3I3srttV/8Rz60MVK2AK/Du/H4OseFC0ex8bFSdtTYHUhlWN7sP+6JiAbtKvmUY+HlS3aEB
 jZyfY3sRNVXr29sh4gwDKjLO9ZHcznTJOwMet1/ud4evRgwStRP8yDNnSW0n8nMwk97j2qmyjdp
 uRN7RXkeHd1oe1g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: 8CbCYhELe1SNQIxOx2aJGB3nM7u1TW27
X-Authority-Analysis: v=2.4 cv=UZlciaSN c=1 sm=1 tr=0 ts=699c17c4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lUC9hMLxrJuMSK10UuYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 8CbCYhELe1SNQIxOx2aJGB3nM7u1TW27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX34/rSh5aMA9M
 xdLJ+PIfOH3ZIYERF6dNnz0DIjCmDGqUbe3yMVfjspOtX1JgkIjS/FA8Oa/+QH3mJiCUuBTo7eH
 gsMANPS6qsiIry3f8paagdvOeFtz9Egm3S9jNb8PWstrKT4IFm2nQD7gZiTknfu7PVvkqh47ILl
 uH09/WMnr6f+rIWf4mBSqiad7wGfzaPurQRV8uurefvoa5MhkMXfWVD7C5MtRTgvi0Srzi2/Oau
 RpNT/UpHYDjjyC0Wy8Z0hE6vG2hQJ+aVd+6U12P8DrLxEEHexx9GBRA0Pa3aHE9p+LRPLtg4BMV
 TbI+ezvGpgNOp+goov5vrQSmFYRSZd3S0fIuQwut21ToM36xeru2TssOrwdz77qF83wl1QUBltd
 aPr4chbfFv1wZpqyqAasslBkXpIQpjUVTpo6h26FiOSG72c4LT7u3BmbN8YZiygLiYepQ+Bl1Qo
 EUlGIlcNWxA3ctT8JuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230080

It's been another year of discussing the object life-time problems at
conferences. I2C is one of the offenders and its problems are more
complex than those of some other subsystems. It seems the revocable[1]
API may make its way into the kernel this year but even with it in
place, I2C won't be able to use it as there's currently nothing to
*revoke*. The struct device is embedded within the i2c_adapter struct
whose lifetime is tied to the provider device being bound to its driver.

Fixing this won't be fast and easy but nothing's going to happen if we
don't start chipping away at it. The ultimate goal in order to be able
to use an SRCU-based solution (revocable or otherwise) is to convert the
embedded struct device in struct i2c_adapter into an __rcu pointer that
can be *revoked*. To that end we need to hide all dereferences of
adap->dev in drivers.

Other series address more generic problems - like printk helpers and
parent/of_node setting - but there are still some more specific
use-cases of drivers dereferencing the internal struct device of
i2c_adapters. We need to hide the fact that the device is embedded in
i2c_adapter before we can move it out so provide a helper that provides
the address of struct device without showing how it's stored and use it
in some drivers.

Link: [1] https://lore.kernel.org/all/20251106152330.11733-1-tzungbi@kernel.org/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- drop two patches that can be addressed in a different series
- rebase on top of v7.0-rc1
- collect tags
- Link to v1: https://lore.kernel.org/r/20251223-i2c-adapter-dev-wrapper-v1-0-bcf960a48fa9@oss.qualcomm.com

---
Bartosz Golaszewski (4):
      i2c: provide i2c_adapter_dev()
      i2c: piix4: use i2c_adapter_dev()
      i2c: amd-asf-plat: use i2c_adapter_dev()
      i2c: mv64xxx: use i2c_adapter_dev()

 drivers/i2c/busses/i2c-amd-asf-plat.c | 4 ++--
 drivers/i2c/busses/i2c-mv64xxx.c      | 4 ++--
 drivers/i2c/busses/i2c-piix4.c        | 6 +++---
 include/linux/i2c.h                   | 5 +++++
 4 files changed, 12 insertions(+), 7 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251222-i2c-adapter-dev-wrapper-c882660190a2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

