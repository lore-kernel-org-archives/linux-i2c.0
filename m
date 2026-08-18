Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D713769F8
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029286; cv=none; b=Uviasi8U6dQVfrRlHWZv0DDyuqiDhlxhC55ZR6qOVPgrEC7a0UfqdQHM1UU8VDhNMMI10kMsPG3CXw07QmEUlYHpL/Oflvuf3ppiSV0Sy1Xqwzqqshr2BaJZ9Ai6q1as9Kny6+herWwJ6pwPFdZ4tiLd4l9F8qh4uLLLOtgt3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029286; c=relaxed/simple;
	bh=5+/rVK4wnZ037uSj0EoBdgps1sOwApbn+u5IgAoimJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ukvL/WYDSdM/O2FzElSTCj6RI8lBju+TK2B8uHSJtLwYxhmkNe4dE7S1NMaRD38yB0HCzheP0GCASoZMhPtpF/OuC3ODUAFttxf72petVyiXqU1W53826pXAr1edl2pQZ/PuO210e9TnzEfyljv34/ajEKs+HnZX8rdWKja+i/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nO+2UmxH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Se0mYvE1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nO+2UmxH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Se0mYvE1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I469f44187370
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hGwHD9TRT7bPHVmF4l9+1v
	rF3qVlcOZhVjsQPFRrVhk=; b=nO+2UmxHfmgj4JLJ2JsDLR6jwEfKZvcGBcykts
	u7rNxRE9/6Wa3xF1GcwTmL8a+IJhxumJZUtWk57vTTRZ7ZhozkgyxELPvQ2jkbQf
	ckUtqaEp/wtz0k2r8qXcZzdnJTLDAs+HJHNlSLo6KIaaKGN09ua9nizsjA8nGMFM
	RX6+cyBGjkyqgY/G4VV8vgH7FFRkR4JGHm3Kr32TGKZuEWEKnJNhyWzlteigUkft
	LaVcCH6Wg9UXILv3f3N7HpijkpZaQMrfVEe9avfWjIGLoXUNfqVkcdZeJywr4B80
	6b3IilfhRGAhTuJOxKBxHd8eMCM7GzY2QxBWBNPxVYN0tLsw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p0751-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:01:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848474825ffso633309b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 22:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787029283; x=1787634083; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hGwHD9TRT7bPHVmF4l9+1vrF3qVlcOZhVjsQPFRrVhk=;
        b=Se0mYvE1XVH4EiPF6eWZG0yHXgGfChnv27VND7s2yqvihd2fUInmcj+TPYSkmf/xQp
         LuIp/U463lQA1chTpGw61xKulzOtax2UaWnmw0c5ZEL6p07OxHOqUvVES1WMHI/iAGGm
         ZrcSzgRu9lJCEkal+tgTK+vBHUEjtDkd7shmlYN8c12e6bCQCQos7ytLEqbOyrKgKVLS
         MFAQoaIMgOc5wv9/iSG2ScUy6Tu1owTTtim5+eTsRJoyjLQFjf7+DDIANFWuHhmFNius
         do6oSpNPMHtKZnkpVEpcSRilWZbFYPnjrylMCPOZnyhl/5qeyVRYmyEMl6qA1aSTzdFX
         tBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787029283; x=1787634083;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hGwHD9TRT7bPHVmF4l9+1vrF3qVlcOZhVjsQPFRrVhk=;
        b=FaiYksbeyFXsguWrtgvaTJQ9GkLabjrLRHLtKplZTfODxf5/mYrweMbScbgG7OXPCT
         tal8oYJg4aQp6uI02YrtP4UVSZYAPL8dkdDQvz1D+PQMf2Y/zHUKl8s+cRtcNFKfsX56
         fjVaENpI6CxV4taEJ3Hm62UJ5bYqHddChdVXRaxtTHfax5oyxh+YkwP0gedInTJZsERo
         c4u6+taukXliAh4GispMSghLHaTYFlwJiRTR1k4h23gcMIhYUG2Vb7QUCZpPdLcL/jYt
         crAgoyt7OsG+x+qVpwz2ZrpoVIm7Y5GapDdYwHvUC271RglLU6SJRCa+cYbhzzXzpGUw
         /V+A==
X-Forwarded-Encrypted: i=1; AHgh+Rp6tJ1zp4zzstfhcFGlNIHfcZ258/rGu0SysnoJrTC0lJwRTsjNE86hizQaNUe27aR+Y7fWHqBRbJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfY4G06wSdaiEO03ROXk4iIcpai/y23B7m/xH2AiCYQYz2wjZL
	1B1qLjHxIowumD5jBbFPQX0sFS/dGbpForG9wLN2Xyfd+0CXSLMabQNOqDTDpGrrdwzRWD0wkR6
	IpFvXCItZzYPqydNstvvK5n01/vd3v8Q+HjvVEE+g9+m/QrcYqmhQ+XmiXsY6rRA=
X-Gm-Gg: AR+sD137V0uSLTCZNIqAnRF3W4dQ02hN8JIVabxzNQrQ9jRmhb/LTzpKex0CMNmeZyc
	Tv7kxMJnhNe6ayrrmFGp8/ftqFE93lx045xFGgK4x6FUmPKolUQgbfpSkVEuueun54ww0PzLtdu
	QWIlU9s2+i6yuMdNvb48eGH6wZs+6LT2ZGotkNnmPXawcjy3DkT7v5N7Pwbg2Qu/9r9wDzfC/en
	lMxtkKqelMuL1KKyfkp23w+5/Eh23leqM6JHdFass77gwOgYoEjfwfbzK82aWXsHJ15bdDogEAD
	dIz6460ICMMaLIcdNiskSBH6T+yhoFtcCIbF1ijXRyswhtHg4WKUZ5vc4+ntQ9ZRsQxKlpyJSSm
	5ILNy0Ol8JkPjcd1AHvDqQxh30Xh/U9anfQ==
X-Received: by 2002:a05:6a00:3699:b0:84a:32ba:a262 with SMTP id d2e1a72fcca58-851bc2d1495mr3841537b3a.7.1787029282601;
        Mon, 17 Aug 2026 22:01:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3699:b0:84a:32ba:a262 with SMTP id d2e1a72fcca58-851bc2d1495mr3841445b3a.7.1787029281886;
        Mon, 17 Aug 2026 22:01:21 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fc0158sm1028876b3a.40.2026.08.17.22.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:01:21 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] i2c: qcom-geni: Quiesce hardware on shutdown and panic
Date: Tue, 18 Aug 2026 10:31:16 +0530
Message-Id: <20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzng2oC/yXNMQ7CMAxA0atUnrGUpmqDuApiCIlNzeBUSQpIV
 e/eAONb/t+gUBYqcOk2yPSSIkkb+lMHYfb6IJTYDNbYyZx7hz5GLPNaY3oreo24eJWAmqqwUEZ
 OGcUGnJwdOBgeR0fQaksmls/vdL39Xdb7k0L95mHfD/1JB92LAAAA
X-Change-ID: 20260817-add-shutdown-and-panic-notifier-for-i2c-6723fc0f557e
To: konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029278; l=1408;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=5+/rVK4wnZ037uSj0EoBdgps1sOwApbn+u5IgAoimJQ=;
 b=wDAf1DvZhw4poVGKxbrtsK5fRUuXpeQthL08XNif33eIMecAN3UEqJG5iyzilkZrwnzK8CcQt
 RAeO9xiX8h6BnwX5rIX66qLfgo7BNXXLxxrV7OCKP/ZZXdFvavCqrrZ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: wIJw8iJswpyudxHrtzm8u5bk7UqCEDoE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfX/x6Y4MOjw2tV
 O04P6FNkY1pfAIb15eKDeOWk8w4ShpB8W+s4CeNlPUkCRgSZaQT87VkE7XiHsrVo52hAPV1R3SZ
 oXrTgUZTKo4ZZyhuc/D1QxBg+naOuJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNSBTYWx0ZWRfXyrYlhIO1tkeA
 rW7N37XhtMyyKkCxXJ9Svj7hjrS6t1VtONxcn8gExnanWS55D4gE8wxvSRfUnCt/Ut6d2gdWhjv
 /0WVjFI4q/oYAKeztLMUHzgQUL6XqNx76vTQrWqrS0NbPvofJc7z80lNSjwV3WdfUvjmFimL4+/
 3u/3OGXHn12374keIgMdRCm1FpeVfkYWvNt2i04IqxuqNgIPYJjY6IV9AgnwEhEcOgJ3DtB2MhS
 YXvRZxRn16fZyz7CdramdIING9AZI93y5Jt5CU+D/DKUh2LIrH5iSnoNee3EHhJoRH1eStTCoB6
 mW8X98k6gYJUlu/y7S7IbCUV9mC0TLW+v4e/JeOp8MWm5PiU71DhUWYMcDuVq4UkdBJeIrXVT8o
 i/0OrpQKXkVXTD6/LARiCgbTiVc+tfr2mu/vwg9Ou9RW5wbm9YneOIazaqUGnIPPBtvysl0gNZ3
 Jv09BmmEO0chZdPfWRA==
X-Proofpoint-ORIG-GUID: wIJw8iJswpyudxHrtzm8u5bk7UqCEDoE
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a83e723 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Sqj1g0o03WAgfG43YeEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180035

This series hardens the GENI I2C driver against two related VM-teardown
scenarios where an in-flight I2C DMA transfer can trigger SMMU context
faults after the VM's memory context has already been invalidated.

Patch 1 adds a shutdown callback that cancels/aborts any in-progress
GENI or GPI DMA transfer and resets the TX/RX FSMs before a normal
reboot proceeds, so the hardware is left idle rather than mid-transfer.

Patch 2 adds a panic notifier that marks the I2C adapter suspended and
performs the same cancel/abort/DMA-reset cleanup as the shutdown path,
using atomic-context-safe DMA termination since panic notifiers cannot
sleep.

Together these prevent both hardware state corruption on reboot and
SMMU faults (which can affect other VMs sharing the same SMMU instance)
during VM shutdown/crash.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      i2c: qcom-geni: Add shutdown callback to quiesce hardware on reboot
      i2c: qcom-geni: Add panic notifier to prevent transfers during panic

 drivers/i2c/busses/i2c-qcom-geni.c | 77 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)
---
base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
change-id: 20260817-add-shutdown-and-panic-notifier-for-i2c-6723fc0f557e

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

