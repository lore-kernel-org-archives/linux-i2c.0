Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975367;
	b=Ion8lT6gNbDg9FjaLvmByj4q3ow+XVozwQKYI7bAUyRtPBSZOfw6cYgrCRP847eDwLK0
	 yZJdXi0Bn3sctpgU6IVXfUsGG8QKHe1WobJDi7WJoG2Jteph9NfDK2NODJ3y0arwAiTEG
	 aMXswiM0Pzldxsa/H7h36nKdeIR/FeLlNtYPMKJSPD/Oywq3SoAObEHeVx3t0VzgNnpxq
	 5oV/cTJ4KBiPaaxdFEU3NpypyfHZIc9TSQDzq15nXzs+t+SW+V9GlEnA1EIuJCsmqr+ax
	 mhnG0FIK5dnrTVS6c1dFLDFxvqBcc11XGAp5NgKncyuuCCWtq5eUcNM47+ZfdCR05Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975367;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gT8k/UqrXcceVrd65LBPRzbdDHfe+aeDILXl24N3ino=;
	b=rNAYIEz6JjPyffRctDLPnGXWMSYmjr5rc8Ed7xiRmjks9AQv5MT/Sbt1XzudfpjezAA0
	 dECsctSXIdt81CE7VJoNaklhic32Z+UVPh+QDPU2jLIptJu0jbwsllq3Px/pjQs0iWuYy
	 +hKQee32zYwumZTyzj6LQ2Dd4dSZfm8My5/3DhPl0eYAWHra3S9PS2eBwwiqPFa0wx1re
	 5DsVOzSf4MFpLx2ylhlQXfxfBDNMQ236lHr602TgIPvnz1DvQ84Ho285Wf0i26+ep4cyZ
	 lE7pekBb6mTK++W+sESLPbHRDIXnR9YDEbb0S3rzepS0uETEoIRznB/OxOb9j1wNAaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeR9nlih;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jbgbw0HJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667A606D802
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 14:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4667A606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LeR9nlih;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jbgbw0HJ
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6EQVp2613519
	for <linux-i2c@vger.kernel.org>; Fri, 6 Nov 2026 14:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gT8k/UqrXcceVrd65LBPRz
	bdDHfe+aeDILXl24N3ino=; b=LeR9nlih/O6bd9Pof1XTFMZQsfDvQ0pjgpcyZR
	GuvROnJOl4nDeQ2henoBCF3Gb39vXv7jr53x5E3NHRJMrVsrUPaD7i7MwY+6VWSE
	aKh1Vc+v6HpLblcXNnI8I5be7XPKz0EhrhvAyTiHFy8P/ef8UmjG/iT1evqmRc3u
	01Phy9aqBARSsabcjivqQGnghVaMgtoSNNcmCIYgdsLwCkTkdQ/lF869lKy3qMwd
	d68JxymGoeBJ56dxiAxIIvtq9s9zdqpgFzri8ysuYfkHMgAartqCv55QLx0FsWvq
	V1cJryZph/OP+t9G05/IVczq7JXMp7zGXuu/kul+rVIPWGfQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb34mf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 14:29:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89e05d31e54so512358b3a.1
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793975364; x=1794580164; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gT8k/UqrXcceVrd65LBPRzbdDHfe+aeDILXl24N3ino=;
        b=Jbgbw0HJA6CpNAozK7ruLE/T/xlmr9LtgLSeVMWNzMK80yRREQ172Pdk1pVp31euHO
         8jMVfc+RyEve/5wlwtlL2+m3+xQ82myMe3uT19X6SeBhgeJYq3mkXl5fzzjPzQvcoXkQ
         Eza8FacbNjApHYzSV/v6knFO0n4lJGiNaXely1Zw2uX8u+eYXO4+CPYD3o1J+CCFo6ta
         bx1u7ObT3f5pKLJY+OJlcj/K3MLyzjUycuH3G9OhDyiVF/LBbIhNfEB+hFeln2f5as5u
         0LHz372rfJ/DRBxdWHd9w8SzfRKXQk1i+/Qdii+S11SMrJ60ciuv3VDLaQuavrzqR8FR
         ruGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975364; x=1794580164;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gT8k/UqrXcceVrd65LBPRzbdDHfe+aeDILXl24N3ino=;
        b=gMdAyvuvWNN1eOYkAkxrn2XRA8QGGcuhvu6sRQvov4tgVP9onmTZ0eftxLFB0jBjf2
         WhJR5xdJS7PbpUfJi7PXxwr9tf7cSbKF4YDI0a6LVcYNaBHP898IgjKeNNE7Plu2UeS4
         pkimYE4oWmE463enomVxHwiBhj4BFt3aCstOkroXEReNJcKlt0GuUwKjC4Jmy7RHeorm
         JsJ68Ei9qFysI2u7sOI3qnRC8KkAwxsqVfEfwS1xQ8rGho0s6XJEyi6AYJf0E2l7AjDi
         TcmgGcdacqnrbjZ4x4XU0j+YilMzWjgMdaYOgGG6iJSOkAQ+aMED/GJyeXp7GuYTb9LD
         CBeQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9ZnPaVmTweJG56+ZTCPdRE0nYvAA/w3l3kK1L4tE0TCLVhTXjH5dxaxxeQDekxK6R9uRnb5k+nkY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aRRm3twroQ7cwKvABMjsC5jcSgvohb+BJJbQFHt1v4yhT1Dxr
	hUnscsAAp8t+AZCg/PVj8RY6qO7rNVVOgEu8q8qZ8r7NvrZNaZ+2fAhLjTsyh9HVwYvWO9a5nli
	zyIsi0uwnQJVluAl7a0amAActICSVSLSi7cc5nGmy50huoXFTZUBHahZQb8z+rzs=
X-Gm-Gg: AYBFou1lCqaDsd9r1NVAylNH3V42kelQTfAmBjRgrbZWL8C3TxmmjtQzCsQHkJ4YOAf
	O7AJ9gUtw3x3lnMQxtu6tvMK9CtlAvp1gelrVTnjsZM78YsqfArx4+eMY6lZdXDO1rtmaojSAvn
	YvlRAt9maIRG5RqBFSWa7xXD0JQaIeDscJxeL+PjTaOE41ueLIys9tgdbqcYx00Kb3ZdORDM4cX
	CW3JKpemjyMmAxvCjMrf/4JsJblfGIYcWwFENkQPLIpPXmgWIU5SmeSu4VD261i326R2onwry0c
	1Rnmt88k/TU576o1JJ3fSwIPA1+aeXNBO5nmQD6Me7A5SAEW7qBHODu2/dTduqdlaW9KiUBpkG0
	aEejXe5ruYPXPgbG0T7DxgibOLwF0md52rCwMGV+DT8QzVtVzKN2I/gZchW5QJO+IUsPVur8HSp
	yO8CL48A==
X-Received: by 2002:a05:6a00:a02:b0:898:f575:7bec with SMTP id d2e1a72fcca58-8b37ac9efe2mr2503143b3a.17.1793975364000;
        Fri, 06 Nov 2026 06:29:24 -0800 (PST)
X-Received: by 2002:a05:6a00:a02:b0:898:f575:7bec with SMTP id d2e1a72fcca58-8b37ac9efe2mr2503111b3a.17.1793975363386;
        Fri, 06 Nov 2026 06:29:23 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597f0161sm690244b3a.26.2026.11.06.06.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:29:23 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] i2c: qcom-geni: Quiesce hardware on shutdown and
 panic
Date: Fri, 06 Nov 2026 19:59:15 +0530
Message-Id: <20261106-add-shutdown-and-panic-notifier-for-i2c-v2-0-d3011344fee8@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvk7WoC/42OQQ6CMBREr0K69hNaUkBX3sOwKO2vfCMttoAaw
 t0FjHs3k7xkMm9mFjEQRnZKZhZwokjerSAOCdOtclcEMiszkYkiq3gJyhiI7TgY/3SgnIFeOdL
 g/ECWMID1AUhoKEqRW51ZKUtk61of0NJrN13qL8exuaEetvmt0VIcfHjvVya+9X7W6m/rxCGDo
 815I61CaYuzjzF9jOqufdela7B6WZYPZjGvhPcAAAA=
X-Change-ID: 20260817-add-shutdown-and-panic-notifier-for-i2c-6723fc0f557e
To: konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793975360; l=1840;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=64FEtBBjlH7O3UHiksty7i2Aaty9sIEf/YcPqDv1UyI=;
 b=Cw1HQQGcaCrsB8h7/fK1gkS71C/QX4vG2RCtxkK3GL5S5DEKkAupH5OBPRQLdKB5Vu4rHcFOY
 pmJFLMd0CVFDj6w7EmczWHeyw2qTmVgFkGAPrCBIevPnt880KeJ//O6
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: 9nC7E6bZq3jMNt6iliWagOUYMWRdy_wU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX8GtSy8JHfStG
 tECXXYpqZnR6awjAOuVscdbql4/tKMNZpsHMsgI/BGRJq+lVmpbdhtLNMm02RQB2rWzXQx25aLQ
 6bn8q8toJyeZyc52vTUsYPQmxJdZJeY=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aede444 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=zZcfVseh7FeFBNu0234A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 9nC7E6bZq3jMNt6iliWagOUYMWRdy_wU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NyBTYWx0ZWRfX1pxAvYY8ggcU
 OTziT+0mP/WrO9nYSu724JZauSF1ErlSK1Gy9PgWV8/qVlq3940QheV99VAtnx/OYT+OlxEcAWE
 LjeuZ6q9KdXU6RtG8n2sVajVZff3garZ8ww2VA14cFRj9AO1Y2A56JM0NeqXGN3DyrR1UZmTaQ7
 sEckH9PJgLKyPJ5711Z2Mir0w5/VrJLVikpS5Z3D7lvmFd92cqh8tanUKSnyLR2gVPy7Pszce3E
 Dv1MpHLwoIROu8iQ3gg9/5X6guHgUpW8NLSLP1zKAY57NtcOHUq8J1+Ydlnxbmap6oRhfsEHGWB
 IKwt/EyqD43fKgrYoyTz71+cyoD0BtQCxbSRB841XqFQoA/UfFdzV31m32K0laTdP858qgDMQ8/
 qlz+juCwPeehWwj+Fg/ZnDCNSa1ZqjZdT5LXdyDlYVaPToqoQ86rxXzlL7Q0cBiX52lVC6kSbKT
 Q0U44lat/HUMWR+BIrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060057

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
Changes in v2:
- Log an error if the TX/RX DMA FSM reset times out in geni_i2c_quiesce()
  instead of silently ignoring the readl_poll_timeout_atomic() result
- Drop the duplicate i2c_mark_adapter_suspended() call from the panic
  notifier, geni_i2c_quiesce() already marks the adapter suspended
- Link to v1: https://patch.msgid.link/20260818-add-shutdown-and-panic-notifier-for-i2c-v1-0-9f31b5fae5f6@oss.qualcomm.com

---
Praveen Talari (2):
      i2c: qcom-geni: Add shutdown callback to quiesce hardware on reboot
      i2c: qcom-geni: Add panic notifier to prevent transfers during panic

 drivers/i2c/busses/i2c-qcom-geni.c | 79 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)
---
base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
change-id: 20260817-add-shutdown-and-panic-notifier-for-i2c-6723fc0f557e

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

