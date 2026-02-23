Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462B34D919
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837198; cv=none; b=H0ee3D7h5qKE/fi0wNNlntnqytMu2QCQitkOgYpJczw34t17HJT/aLyXouLPZbz/OWfvEVvOqZIajS1TIvHrw1SzDg1ofm8oAaX9cnSapHMMjZRx5rkkzNpLTU6gVwRTtRKgwBD4eUNI97Cz+EhB9MP1DGWUD9G9ptGs93vqeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837198; c=relaxed/simple;
	bh=VvG7vd7fZWSAXv6PdVUXds74cvD+b0T6Unx7PuBmRnc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=og5z6m/6hO3hGGuv0lGSEkh9fHSvUHL+Yxsir3FJttX5wImhjZBCh2GtSkT7YLEtibGuKZNC8PPYY2ouYHP1DbhOQEfCBBSH/ENXt8exE9cZA622w+Ql/QVV52M06uQ/0/T12V8fYRGCvivaROO3FCzJtuD6rRO2NS5xSY4Obys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUNbRl25; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RxVJrICs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUNbRl25";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RxVJrICs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MLETHx1750344
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 08:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Vu5+kJ2KRuf7XSsncM4pNa
	9NRUl8nXTqYbQMD7by2WA=; b=MUNbRl25lBIHci1Gq/e9uHk5NhTxlNl79mdEHB
	1cSDlPuuGnAnkHmC0IHYcUqv+QpAP6GXMi5LcVqoTpoVKq4QwHNHetp2B91OClcS
	zlcvILeVHzqnqdfGlHwT8h3RJKjPNqxArJNPkDmyScBEApiy2yExu4GULqaSjaXw
	Hr9SXir1O/GPsXkzaD1fjEij4E6DQAMibiBnHaH3B5ief0r2ln3o/gj7O0hCIQLX
	bQjClLu8SpDoHswJldsRNcdrxbKnXuOmOkcXgyNToXDEW9wI733h3eHYjgqloHjJ
	1Ax+P6g8Dhiq2A1Ehcf+DcyMqBLeGME2L6w2UT1TZtJhCEig==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wbc1ub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 08:59:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c711251ac5so3578876385a.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837196; x=1772441996; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu5+kJ2KRuf7XSsncM4pNa9NRUl8nXTqYbQMD7by2WA=;
        b=RxVJrICsNjRMbb8UbuQ0lMWTFRWatrjaiSMkGeUruBmkYwL8X/HM5pBOhU4R/sAng1
         PJYDhd6sfD64olPfJApm4zEHTHL4PNpTkNznXUumadqf6Wu9rsvrTER/kArDmCUr6CSx
         2+8qPhNP/MCADoJSoW03br6srNT0P4CJHsP1F/THCQAsQwyCrMwloYqrjSQ8YecOdwrx
         X9jeS7sV/csKsoJqaNY543sy2YhKcyk/giob8jjaCXg7z7rTf14y9enRnJlr2k3wYcIQ
         hfkpYoQtqME7Mo3UKd7Pv+rlBYd0PwVI9M+flJWw1XsJ+YoJIOMf9XNBF4Q4+eSboSOf
         iXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837196; x=1772441996;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu5+kJ2KRuf7XSsncM4pNa9NRUl8nXTqYbQMD7by2WA=;
        b=gG0RMpscdr+jH1Pk1ZkgR6/XWs1pY8Y6LHrgRxGpS+U1LtDafT4+gr9ed1WIa1sII+
         /i7HwfTYv/0jrwzNclfsPEcAKVw9cylFKOcBRHE6arSIL9xfOUO1RXBTPx0G9z2GUvx6
         CGhDInnRAe/QC8Ucu3n+VD4vSPUQTfytlAJaX+fmiYi5iMJBcAiNVp4f+R2A7p48Bxwr
         2ZGcfc8WNyRCPZ87mbIMMchYag3k3MX1ZBKe99Ca9gH5Ea3agOcyVsdGuosqHFTNmviO
         PjuRt8ahmATu8Fx2kaDkeIcM+ehW9U38r8LcLOxVuETTjjX0WQ2xkTlfbarM5pVweWfk
         mJaA==
X-Gm-Message-State: AOJu0YzW2zf66F87e1C9alGatipWdcuQVJkmworM1NXWrTYeVVMXwL0K
	oWBUjcYAAb95RFgAquahAWCngc+X62goDJ/p6b0bL3L2FwUpzgxmzgr9TiJ+Ye4dI92EK+v+uvr
	xXHThjzKHIl3WkAYqcAoKsN2XZlhXmz2e4Zh6o2y3MYkv+gAD5XIEp1R3dsPhdkI=
X-Gm-Gg: AZuq6aJ6CyLM+EWEz0IWzgM9hnOxecj5+7IAlP8ncLu3BHmt1tqga+0EroZ9ywVlbHT
	V8+gWaj9f9U3zlnERbfeB0ELX4Ty86+UfXeOFLaRn18IJ2sgs00ta4X3jYwUzdSocJc7efo9sGq
	LDqNHxCezT2NXlHd7tfVzB73PsVEMkgxFKEyKG6PudEGFIwTCXMWS765o4I/Y2nuO2uDbO9E+x8
	KxUr1oaM8ftk35X2QXvykmB0N6k4xlNYzguK7CsEXzUcHRCgEhl6rH5AcH2miCDApUhZMAidjK4
	tBUHU2Cp20gvy2v56A9MoQrvlvgHllFtpY7jFcV43epgkR9LCP42PZnrC8VbxRlYVBE3Qmcgf5r
	jswbAAfvZBggv2BZH0O/OxsVBxEavSueT5HURpmpaDHJEQTp5obZh
X-Received: by 2002:a05:620a:4416:b0:8b2:1ee9:dcfb with SMTP id af79cd13be357-8cb8c9cdeeemr899730285a.8.1771837195591;
        Mon, 23 Feb 2026 00:59:55 -0800 (PST)
X-Received: by 2002:a05:620a:4416:b0:8b2:1ee9:dcfb with SMTP id af79cd13be357-8cb8c9cdeeemr899726685a.8.1771837194998;
        Mon, 23 Feb 2026 00:59:54 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dfd3d6sm119000395e9.3.2026.02.23.00.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:59:54 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 00/13] i2c: add and start using i2c_adapter-specific
 printk helpers
Date: Mon, 23 Feb 2026 09:59:29 +0100
Message-Id: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIWnGkC/22NSw6CQBBEr0J6bZOhQfysvIdhMY6NdAQGp5FoC
 Hd3JHHnppJXSb2aQTkIKxyTGQJPouL7CLRJwDW2vzHKNTKQoW1GRCjkcAjSj3dsuB04KNryUBe
 FyZ3dGYjDIXAtr1V6riI3oqMP7/Vjyr7tT5f/000ZGixKa/a5KW19vZy8avp42tb5rktjQLUsy
 we7dqc7uwAAAA==
X-Change-ID: 20251222-i2c-printk-helpers-a69f4403ca70
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Khalil Blaiech <kblaiech@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-actions@lists.infradead.org,
        Bartosz Golaszewski <brgl@kernel.org>, linux-media@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3499;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VvG7vd7fZWSAXv6PdVUXds74cvD+b0T6Unx7PuBmRnc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBb3fG3CwNJ5M/hqqSYT43XI8trsoU1YEeWt3
 Kxjocc+Vx+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwW9wAKCRAFnS7L/zaE
 wxkpD/9RhvfJv3ttEDXAr5ioS+xTqbBT/5fiaxaSwFIZeJ2gZR91bPruhA+1jSyV0rb7iB3dp1x
 hnZGjJ9fxV1Fy4Vhf9la6j6kbkt2byhBaua8B1h27CzDQZxi9LLUHYTUH/AegRw5GVtSv8dmybn
 daYh1LYZItCUKjucKFGeNH3zJMeWpnpa9qhYjq6AWFWCf68SetWMt7/lFDnG10eh5NAcMjT2H3m
 EoAu/D7sLQ8ADCiFNVux65KSZZ2jMTuDOWQ2haWCJjWO+1bNrNtFn7Pb7aAivIWnLRfck9mmH6i
 EgXwBu+yuO0s3JIDAvdDr0iCt4J0xkXCidF15elPYth67L1H1GwbsMStuSvY4t/jryayd8jY/x0
 Ruab1IgXtRrRFwfIWjsjTXkTkXMKKE0IgtIquSB2KQMHQFpEF7HGCilnjRVAT19GvwLVaYHWMh6
 VG24DSSR+aen7xI/S23yArfiEaEBiIPn8s54a0BCIkKQdWQ177nIgKDDS20LekvqZFwQoZeqC00
 bJ/VAJrP6jOqL0pKu+2XLbv3Em2SMjZ8VXGMKj6Y4NKkmDmE9B+V00GpZM/S/nuwfStzjF1+nqj
 gGn8Hon0035YW5EZRHQvYVWhqQxv6ThLBvqaN2lA60105wjKRVxQ3cl5rvHVmwmTgCjqSjzhTIO
 KwabIv/iYhBFs+g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: oZg4eMWj7ccEHIQc2-vo8SxWPPa6bkWp
X-Authority-Analysis: v=2.4 cv=UZlciaSN c=1 sm=1 tr=0 ts=699c170c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=M7r7wYDzB2Ki_6CY1cMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: oZg4eMWj7ccEHIQc2-vo8SxWPPa6bkWp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX2LvZJOsjK315
 qNR3pc9Q/DmMdz/kUeeV6tabrlXIoRTxEv8I9bGqlpoMPYyHGXdHx6EAPJF8rc8d2xM3VsnDhoS
 Ch1mG8iWjUPXBS77L072XAcSpYyrV8KubhV2iLiwsbTj/RqoSb/40UbCqfHFd7oMxcs5UFYcegX
 tLqxLWEJOolrmPKWIoTQ+jVXwgxDLuAOOPUnis5fkSJllX4PIYSUXglqhHN3n+JMWbdQb5+fQV5
 SVg+TOezRGSeKkqzGV8VbxQt1C1NPQQJKfkH2ekdB7+5+i7VsYYmxtILEzDfBkbOSz2+ncYxsWm
 doelzYWdLBMs0jSyRMjXhAA+v7V2fRb5xnvVutCyekYar6BYU+8ikc60ux0EhOm8iY72Bt+1+AL
 I+3wkEmuuoLDECrxfdmfbjtkEBFVnWgVmbTLw5WbIYvR3pOn+udNlYB6CrAAWksqow7BJnokKqh
 PO28a2X+kBBlxPVyePg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
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

This series addresses the usage of adap->dev in device printk() helpers
(dev_err() et al). It introduces a set of i2c-specific helpers and
starts using them across bus drivers. For now just 12 patches but I'll
keep on doing it if these get accepted. Once these get upstream for
v6.20/7.0, we'll be able to also start converting i2c drivers outside of
drivers/i2c/.

Link: [1] https://lore.kernel.org/all/20251106152330.11733-1-tzungbi@kernel.org/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Add a patch renaming an existing i2c_dbg() macro in a media driver
- Link to v1: https://lore.kernel.org/r/20251223-i2c-printk-helpers-v1-0-46a08306afdb@oss.qualcomm.com

---
Bartosz Golaszewski (13):
      media: saa7134: rename i2c_dbg() to saa7134_i2c_dbg()
      i2c: add i2c_adapter-specific printk helpers
      i2c: sun6i-p2wi: use i2c_adapter-specific printk helpers
      i2c: mlxbf: use i2c_adapter-specific printk helpers
      i2c: isch: use i2c_adapter-specific printk helpers
      i2c: ali1535: use i2c_adapter-specific printk helpers
      i2c: scmi: use i2c_adapter-specific printk helpers
      i2c: ali15x3: use i2c_adapter-specific printk helpers
      i2c: powermac: use i2c_adapter-specific printk helpers
      i2c: owl: use i2c_adapter-specific printk helpers
      i2c: nforce2: use i2c_adapter-specific printk helpers
      i2c: amd756: use i2c_adapter-specific printk helpers
      i2c: piix4: use i2c_adapter-specific printk helpers

 drivers/i2c/busses/i2c-ali1535.c        | 20 ++++++++++----------
 drivers/i2c/busses/i2c-ali15x3.c        | 20 ++++++++++----------
 drivers/i2c/busses/i2c-amd756.c         | 24 ++++++++++++------------
 drivers/i2c/busses/i2c-isch.c           | 32 ++++++++++++++++----------------
 drivers/i2c/busses/i2c-mlxbf.c          | 19 +++++++++----------
 drivers/i2c/busses/i2c-nforce2.c        | 14 +++++++-------
 drivers/i2c/busses/i2c-owl.c            |  4 ++--
 drivers/i2c/busses/i2c-piix4.c          |  8 ++++----
 drivers/i2c/busses/i2c-powermac.c       | 26 +++++++++++++-------------
 drivers/i2c/busses/i2c-scmi.c           |  6 +++---
 drivers/i2c/busses/i2c-sun6i-p2wi.c     |  8 ++++----
 drivers/media/pci/saa7134/saa7134-i2c.c | 26 +++++++++++++-------------
 include/linux/i2c.h                     |  6 ++++++
 13 files changed, 109 insertions(+), 104 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251222-i2c-printk-helpers-a69f4403ca70

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

