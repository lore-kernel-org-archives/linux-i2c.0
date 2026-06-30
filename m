Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53440261B91
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799387; cv=none; b=pLffXKN+Udy5cLDK3fFR0fOuSQI/PPV2bTEPa/6uRNj3phPH65SAaUm5VGWE6G2SeSSA+/Bpprz7V96oN3xYqD0ba2XyVDZAqYp7Vi2be4eEgwXjGnggT1C4NBAbwQ7H9+cUxPae24+WdEhYCx2KhZejxDIdHzZcbWFvGL46AvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799387; c=relaxed/simple;
	bh=a8t2wkRvLa1JchCqybi32unoLJ9yXcc54hmZVUkgubQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SxO3xgXav1boEoZTG2jl6uIPl/udsFvE27sBEs6dZs+hs7rL4dJ53RCPUvvuJIcgZ8bS/f3gKWBl7tHoQ7EBrJqmv3h3UYDldwajUkJ4sev9QEoSB/Aziu+pdXzpuaHSKlYgOxWU/fvr+N2zyikb6P865lDquH99RT20VKZFR/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0I5zEQe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MoQMELeG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0I5zEQe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MoQMELeG"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5c6wQ952601
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=shfeln5igxAy7CPuXN0OtP
	vgBHP3xlnyt4F/aOr5BIM=; b=m0I5zEQeMHAIqK22vcOV35YhmoYgMJidyrCpd0
	wrMDmSlAxNYQPZgT+DwtkOl/GmpNoRvOKldyvZigzAdzN4YMOKRoJVP9nEmcbeLs
	ZfWG6KIX421fmm8eUJjSwake60/8ETJVzSHJDWK5JVkg0a9LZ7/oafcVuwFExShB
	5bbUFSSCw3qgwwE5PLboa7VB83O1HwoxVLvXd5z778CrbLGE5Bdf5wNM2sywsaWe
	6Hxhcj+fEBt8frHUdwO0x7O1XvuJWpHPupE+7PgELQsM1DrSktDTGPeX8VDumsBc
	yZXcz4S/jZiICX0gZcpmovURYbOOLa4FyO2P7aPUZu5d/LUA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44wp0pj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:03:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84696ed3b24so1517176b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782799385; x=1783404185; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shfeln5igxAy7CPuXN0OtPvgBHP3xlnyt4F/aOr5BIM=;
        b=MoQMELeGUNPwcynq1XcW3e5QwShW2ZbO44tlvVBRNa5Ye2Vdys3H/LqJ+HR2xhPpVs
         lP8y0PcaQk+BWGGkGp/isC7hwcs9iS7WtclMMF2J8wx4wJsyX5QqkGXqIIi2+vjn2f6a
         lEZSHB+dEMuHPvp33AQrLJXyi7L+Cklt4k6gAhlRRsqD6SkE0Y5zdhtJBY7UO5jws1FY
         dKU2ybA5djt10eiM0SxuG5v0wliLA4sED3zSJUO9DMSWzWJdBc7IXIH6tftgiwLebws5
         s0fsranqDj6BebXmNHkoy8bBE0AG5qawtnSUAPBB3a4cgGAodXAKdij8Ax81uVMtbC61
         5QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782799385; x=1783404185;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shfeln5igxAy7CPuXN0OtPvgBHP3xlnyt4F/aOr5BIM=;
        b=NbglOIrBIt3RsDLsqMyFH/28g3+eir0xq8QwGPsr20h1d0oV13n6qs6TphrGVM60sk
         do2yGImEejnA3Xk7sVscH5++uC7lHLR9xniXI+NkJXSpYuffS3z8+21giUr7H+wRaeWo
         S7X7J4MNtRalAXLWwW2wg3ACKvz1PSK/qp67bPQbrHAjoeBTZCSdhDNHBzUJmCApK6j8
         HwuykM31aQGFz3smxVa/+yNJC+E4SYRKGqRCqvB2Iwbv3DDbUA+Y1y8Ph4pkHq/WTePC
         cemIwX9xEgGq/deao54WiqEuqB7L+BAAlXG7eln3ql+1qO4Z8sOK3ThlFwOgpkhdsUyN
         GUsA==
X-Forwarded-Encrypted: i=1; AHgh+RpM4HZws9KvOrE3m60sylXquMmPpfbl3BSQjbqHnEryAzwc8wCTjrHv9mgp/totdNvu9ZaZ0eQr8cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80fydTcuD4jwH7BNM8lQfmHETjPmeqxYPeuV9lr57eMcZjmeq
	Bwd1o4deNSP3AmnNQ52QSGfIIg5O4HzKpkZX4xM7uJQFM7RXVag4ISx8G/YtiI82DVMiGO4tT1G
	NEvnM8vaoahgHcelje9Tc4RKsINQuKyXAgdgMJbAmorIjls1AmVi/512aT5YXM7Q=
X-Gm-Gg: AfdE7cnUP3OitDHH9uRURPrU11TbPnIDEVAvAMLlCyYEi5MMpmqqqBV4f0rA+lDwYW7
	xHdmWhN2Mb9v4ROdPk6r8lko0CLuK6I6tB8OQ7sQdA0EYORaE4A8ta1WFfzjtg96/7C3gU++e5i
	/6+vFszhBUT+jKZcyMThrX6uY/vfTnEvVSevtnBl0BoroYCvdmMaVjqp6fZUD7f3dqFV1RgF9/8
	qIbVKnVkdj6W7J+VFiNPKrpAkAo5/CHJyL1xBlmUeg7aT/BFGwhRPu8ILsMcsRxKsuHslBnAT4d
	pcwqvivIAux4kdeGfTLT9+PLZfQVfzm9rQYPfKjuUTQ0JM7N4ZNr6tb2/1G7H1A6Sz6h3WCn3Wx
	zUuU1PP0OyeiaWRckI+gPmja/kI3zRBjcKXEX96zj+KbB
X-Received: by 2002:a05:6a00:1745:b0:847:8499:bd with SMTP id d2e1a72fcca58-8479eef1340mr1903076b3a.24.1782799384842;
        Mon, 29 Jun 2026 23:03:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:1745:b0:847:8499:bd with SMTP id d2e1a72fcca58-8479eef1340mr1903053b3a.24.1782799384278;
        Mon, 29 Jun 2026 23:03:04 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm1112600b3a.20.2026.06.29.23.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:03:03 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] Add trace events for Qualcomm GENI I2C drivers
Date: Tue, 30 Jun 2026 11:32:44 +0530
Message-Id: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAARcQ2oC/yXNwQ6CMAyA4VchPdsEChL0VQyH0RWsiRt205gQ3
 t2px+/y/xskMZUE52oDk5cmjaGgOVTAVxcWQfXFQDX1dU8ndN5jNseyRg054RwNHxzvuEhQVGJ
 sW990x6EjGiYondVk1vfvcRn/Ts/pJpy/Ydj3D1zQnkGFAAAA
X-Change-ID: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782799380; l=1510;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=a8t2wkRvLa1JchCqybi32unoLJ9yXcc54hmZVUkgubQ=;
 b=i8JM67rWtGlc2IhNVMUH3n/LFK4bOHB1dwBqzGMdDBS8wyLV3jiFFlUL8p4voEzKXFjmkg3Cb
 GhkFt0qrdL0AfYr5wPZn5JGzB/joe1LFWrbIIKLagtOa7N7Fk+DZcCQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: 7-ETmf2hZNSuewZ2P8ek9sMyi5iRgYB4
X-Authority-Analysis: v=2.4 cv=AtDeGu9P c=1 sm=1 tr=0 ts=6a435c19 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pfqdL_FptRF-L44MAtYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 7-ETmf2hZNSuewZ2P8ek9sMyi5iRgYB4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX3U5bkCTSHpmE
 VmqgLFiiRrWPBJDM4kxRbyPXchiPmP1Bbc7ZYO1ys89IA+dzukFoW37bU9gHhW/x6PvErHSynd6
 mVfQR9bpX5RdU+S7eF5uw6e/ZsePOg3MOeWNlG44taRUPEZF4LknQ/g+hCVYbbJuFJshzqwcqcY
 +MQSlTCQGpu87lx3/gWaW6dV7HGO27H1GqhwyBcEvHe3sQ36wv9+ujZm3npLkwgSyHsVUx/6DH2
 wM1IgbJaoG+Rp/pyc2Gucj2j4eC3yjPc7W3PMlYRp8H1Rzb17ZeWOZoKZ6ov/K9w8uIMZ4du8Eu
 adClUNAPf/sn/uiTv6JZYwiU7nphicGY+tZjqnPP5vgnQEhLLj6LOosBGNUHA+ZRgUe8uY17Bbh
 7jwTUHxDCCClwgqpB2hTp48ojhpID/OJ5c69aLm2ii2zK3Y1nP7rDuRPQJFGo2jYdHh7NozN0Zp
 +NBYAFg6Y1NqCcuKqcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX7SmNVF38jQJF
 t4r7vZVhgZzbohGZrva8XPxz+ttvJKo+QK+ILcQo0BvPMX30vHaxJDREh7m/cJmk50ZYEIPZ9A/
 dP0nkfY1TN0UjPi5FMlt2W7qPZb/onE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300049

Add a new trace event header providing tracepoints for the Qualcomm
GENI I2C controller.

The trace events cover controller bus setup, interrupt status and 
error reporting. These events enable structured debugging and performance
analysis using ftrace.

Usage examples:

Enable all I2C traces:
echo 1 > /sys/kernel/tracing/events/i2c/enable
echo 1 > /sys/kernel/tracing/events/qcom_geni_i2c/enable

cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:
79.737075: i2c_write: i2c-11 #0 a=057 f=0200 l=3 [00-00-3f]
79.737075: geni_i2c_bus_setup: a90000.i2c: clk_freq=400000 clk_div=2
   t_high=5 t_low=11 t_cycle=22
79.737084: geni_i2c_irq: a90000.i2c: m_stat=0x40000000 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737201: geni_i2c_irq: a90000.i2c: m_stat=0x00000001 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737211: i2c_result: i2c-11 n=1 ret=1

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      i2c: qcom-geni: trace: Add trace events for Qualcomm GENI I2C
      i2c: qcom-geni: Add trace events for Qualcomm GENI I2C driver

 drivers/i2c/busses/i2c-qcom-geni.c   | 15 +++++++
 include/trace/events/qcom_geni_i2c.h | 82 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

