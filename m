Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696211;
	b=o2bDvzsIpdFkKJis6n5crjg1YijmeXnum9OVgJYPX11a4juwAB/kjNqfWl0NVIeOhw0O
	 jyGNSmHfH7XlbhCO93jzU9KQTfk0FDAAle5e/Zs8qkx27S3HztOl7JyJEePcS13Bq0bqm
	 juXxIaUhrJI4ZOw5xSIVTDf3ygnWWtzpFDkRpk76OLBHNGDuHy0NCnEgL+uFWgruN3Jc0
	 g9KODbsU7DE9keKouHklAGSXzyH4+rgv3BlMMZR8kdePRFarPlnOVb98j6Ld7ODYinv1b
	 vYZkm6uFJKad2aYpzTXb1D4hidF8+CS4ArHxCTY+EHP9xYurqzHNyDNdYYvVrBbHZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696211;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/2XqUpzEZxP6DjASKfwlo2XiGaEyGtmb07VuZYaRpFM=;
	b=2KpVjgasg9N5DnE2DvSGEKXR1j7+vKjbBa11UNM7RS9VL1joJsnUEZ9qIgytZa8D5Xeo
	 VOvxkivb03E5dQFG+gQ+c/Yq9zunxJlq45YWSNE3iqWDMBevSZt16ZenZh7n5UiUehncI
	 mLsg6XXaBDq1zuJFQ7MHlTrh4Bk+p5U/McYuy1JvnaopXuLwVNn4dPlCM/vnBD0yHt5Jt
	 7cUs6lVC/vR1JqsxuiplZFfckgB2ZwTp0vhac4p52OXb20jJblT+DZhTDF/yFkab//Vsb
	 jV5U4pQcCsUtKiU79tyoUb0KdejS6emcl6Rz9dECz4l2xqqsGqY+mEZsy4nbnhu4ouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mtqz9JOi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="N9i/ZpXZ";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4276606A329
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 08:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4276606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mtqz9JOi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N9i/ZpXZ
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3812VH1082264
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 08:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/2XqUpzEZxP6DjASKfwlo2
	XiGaEyGtmb07VuZYaRpFM=; b=Mtqz9JOiOulxvyV/ROh7QdqLdCAUPpi49zCVvb
	XGSQU/lQ3RE86Y/hIiHHpbnVV2MNBCPGrV2wOr6rmKXSOFdOynp2QjJdeWkOta1I
	cOrtsbcYT7Z7lHHDcuEveSRSYWSdeTIzjRYQ3ZE1ZMzsDypji6s9WODPS0MsiMaV
	avPjM4usyRUGwaESNIwoN7jxWP8t9KY/cz0WQ0yKuBGMjuy1YkEnWfr2bOXjIvDt
	EUXnXQ4wCp8wmMV6fhsPO8hTLlfyTuA6+BCwfDU85SVwcfG3/rWEHQo7r62M4ozT
	dIJ9rgkIX7A/X9hXYUd+YUJxAu8lmJw+dXVFZc/Fy9fI2kaQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r2vmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 08:56:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd633da24f8so4157823a12.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 00:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793696209; x=1794301009; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/2XqUpzEZxP6DjASKfwlo2XiGaEyGtmb07VuZYaRpFM=;
        b=N9i/ZpXZeYC6eEJNSj00AJ5+I3vu+6RXsU+dOjYvEmkP0IjYggDc2GLR7D/Ylz4eba
         P8I4C1qclcNAe6UOWz6LFAuWu6YQCPjE9vo54KaMUGTwbk357STLPfr8myF+BZW3gyB+
         5fOFOSrCjSUSUHtCkW7NIFdicAILGIJjKm5D9mvNNXMr3jnSndRXTM8TxhO9EO7mQqHB
         P33YamhT2yOXsObj7XWydRCLiuzQhcjsEZTsCIJC5UpWHHLoVAEEtzSb7Lf7HYBCrsoF
         zd0KVYDJgZx8voD09YESf3caKaK2FWJmD7VBRp76NSVMvgwKLQ9pUxemwXw5Um+GTffD
         L28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696209; x=1794301009;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/2XqUpzEZxP6DjASKfwlo2XiGaEyGtmb07VuZYaRpFM=;
        b=ecL84yl1hmNqqiO17xu0Sfn4nVGmBJy8mV/S+yD6M0Jm7w/lqL/aHdm2JueWdEH8x4
         hkfTu9wU73b4hzcjQgf1DM3J9hbBxtoczDG2TZUFZA0HCnwT5qzYzdqy4YwmZC1ni2b9
         uhU8sPHcMLjQS5RkpZzHqCPkNVcwH/czgPM4NJjtdKuAtIbJerrwSbP2YnGtEskyrBvD
         kkvpxv7Jn+yej7D3+AVfqXwcHaF+6aC9wDet7K4v64aeydiIV59BjbYgZr0HA8Oe79M+
         dhBWkaI6cP1dxhVxBjVcKEZOlizw7sOtxXuAJ99bAVsfHm1KTXT0F/nyc1B0IAl2L19Z
         s6lA==
X-Forwarded-Encrypted: i=1; AKwUvBykLX4QyiLexWMJ8qrKD5QDipBaR9septlNWpBXizAGiCE/B76mYErln56N1WMC5uaoo+J1q0jLzCg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VwbianqFoG1Ic89FfKty4azdAFFlSNo0wXQWR6c/3OTC3cKDk
	WVRjWgQLsGcEhbEVgiftonRbiCZB03rPD9AQGgc7fISIf3lY2trhwXaXv1Wy3PyXq59A1r2u1T9
	njIvTO4SgwDZMageu6cyTacpkLFP77YpPPMWO5qS0ZP4CskcWLiFdLriOTvkLYvI=
X-Gm-Gg: AYBFou29ARWyqoTFlRtoxWVD0+GRtBhfwYVqkE6HzTkmL5Kga89j8/Pgvsbo58dUCON
	l2Lk20oVBBbIddoNjgu8wuRQY9Efho5ix5mr1gvKvbxNNFO0XTyTsGcnKmMkpxZ/7OrBR6n5Vwh
	oDkVeJtkKt2SB3y7dXSiBUuX+W/+YdiMoz/vb53/ClQVkGgptYGQK/Ske7bwb7rdpvJ2wJPom4b
	pZOcV1Ymp9uwAbqcwGbEFxo5Rd0uqiTmza3UZT/KLT6i2IYBNY5V1vE2U2tOmJusMgbJZvY1sqx
	qteKm1bqGBkX5V3L+eIO6NXShF9a27Wr2ZGLNjIuAis2ELD1Rcv7o7vIY7eH3vPVlSeIuZ8tuJ0
	aazqyotcZldC4U7FFx3WGDe4671uE9h3E+ZN0FSr9zxfz9zGtIvdE9BWzcmTHTo8RFBRr6wsv11
	XXfyL2zNk=
X-Received: by 2002:a05:6a20:2d10:b0:3dd:a197:ede6 with SMTP id adf61e73a8af0-3e928dad9acmr10946979637.53.1793696208693;
        Tue, 03 Nov 2026 00:56:48 -0800 (PST)
X-Received: by 2002:a05:6a20:2d10:b0:3dd:a197:ede6 with SMTP id adf61e73a8af0-3e928dad9acmr10946957637.53.1793696208145;
        Tue, 03 Nov 2026 00:56:48 -0800 (PST)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963cfe7sm3017471b3a.19.2026.11.03.00.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:56:47 -0800 (PST)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH v4 0/3] i2c: qcom-geni: Add I2C bus recovery support
Date: Tue, 03 Nov 2026 14:26:39 +0530
Message-Id: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMeh6WoC/5WOQU7DMBBFr1J5jStnnDgpK+5RIcuxx9RAY2onF
 lWVuzMuKmIBEmxG86Wv99+FZUwBM7vfXFjCEnKIE4X2bsPswUxPyIOjzECAaoQYeH3EAEqbKbz
 grJOZXCioY876tJhXG49HTYcPre98J5UU4Bjh3hL68H6d2j9+5ryMz2jnyq+NQ8hzTOerS2lqj
 93WeACrxyXrhDYWTGdeGi5IRnqBtld+aB/IYHsz2NJhdaXAF6cRIP+uX4D4O9n1MLaddMr/wpf
 f+f0/+JL4vQejkDYc7n7gr+v6AcLmo6WhAQAA
X-Change-ID: 20261008-20260826_aniket_randive_oss_qualcomm_com-84f5f536302d
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793696204; l=2932;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=Z4+KTPxeraVIy1Vic4c7QiMWNojxv7I5mkhSN4OnDes=;
 b=T9S1IYYdEjoZm1y5PKIic6mGMftZVpJ7cnxdaWemjFPtL79LPvXCI9QvZcEAMGR19XHVAQzM+
 0g4CgzYzK17A0og/M1O4K7MzpXwPb+jnfNAvnASocR+I/0eg7kdB27u
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-ORIG-GUID: ov29xvDgHHZPWPF1xn1YH6T7i40ksmsN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX4px2jq67n4zT
 CFzl5XV5PfeZxDotNc5MjPoa1pg7JeXarMMfgklX0zQcyCb4c2XI6VLMCbAk7CB22NtmskHoLaN
 CPRCXtBIDlYZg7NUT0QUmzioh849EbV2RQH+Latrin+PSu4THp7pjb0svYagJYLJn3rPr0U1kTB
 fTR8qHbjnoVpwwkIF5dhCo1xTWqGEMlyUA7zRA52jqho6zJSef8FFf47bN1Buzj38e4S8D4fpjl
 xjHK/jAJUNQwiq7yYOQLRNV5eM2JPuDRe9jN69Ty/H7oxHP6x6i5IzNdzdyegXQgdC+0fjlsVOH
 H9TmiJEPBgjr8mnLCz60myPbNkMjhW2U1CYe/ivdilOwl10Lylug9mcK+HGXuh1wbQlfkFm43Ls
 O8MxyDreylgKi75xkTvvBfoj8r/ofvd4g+Vn/g1P5DR8iKOJpsbR/+Yc3OSxo0bshupQOl7Pfvv
 1NwhicxmKLrbq5WBqGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfXy4Uc0zoIjLUH
 3B5poWUvLM3QkDXSa4aKg+P9D676sABnlpwNA6It8N9aniiiQgv+d3h8+vfeRhrZdW8R1dpeY//
 FpX8qAG+77TOiAF9PlwjE/ZgbD/LDwY=
X-Proofpoint-GUID: ov29xvDgHHZPWPF1xn1YH6T7i40ksmsN
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9a1d1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=tvANDUIg-hJFOwLBRUEA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030035

An interrupted I2C transaction can leave a target holding SDA low and
prevent subsequent transfers. Add recovery using the GENI I2C_BUS_CLEAR
and I2C_STOP_ON_BUS opcodes in both FIFO and GPI DMA modes, without
requiring GPIO-based recovery.

The first patch adds zero-payload recovery opcode support to the GPI DMA
driver. The second registers the I2C bus recovery callback and implements
FIFO recovery. The third extends recovery to GPI DMA mode.

Recovery checks both SDA and SCL, skips an idle bus, and rejects recovery
when SCL is held low. It is available through i2c_recover_bus() and runs
automatically after relevant transfer errors, preserving the original
transfer error. GPI recovery stops after a DMA command timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
Changes in v4:
- Clarify that gpi_prep_slave_sg() is common to all protocols.
- Consolidate runtime-PM cleanup at out_pm.
- Use a ternary expression for the recovery result.
- Preserve DMA submission errors.
- Move reinit_completion() before dmaengine_submit().
- Link to v3: https://patch.msgid.link/20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com

Changes in v3:
- Use the adapter timeout from the FIFO recovery patch onward.
- Configure clocks and timing before recovery, with PM cleanup on failure.
- Remove unreachable GPI error checks.
- Log DMA termination failures during GPI recovery.
- Preserve GPI timeouts and stop further recovery commands.
- Link to v2: https://patch.msgid.link/20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com

Changes in v2:
- Rebase onto next-20261006.
- Move the recovery opcode macro removal into the DMA opcode patch.
- Check both SDA and SCL for bus idle and reject recovery with SCL low.
- Share the bus-state and recovery-trigger checks between both modes.
- Guard the current message pointer when checking data NACK status.
- Reuse the FIFO transfer abort helper for recovery command timeouts.
- Use the adapter timeout for FIFO and GPI recovery commands.
- Preserve the DMA configuration error code in GPI recovery.
- Link to v1: https://lore.kernel.org/r/20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com

---
Aniket Randive (3):
      dmaengine: qcom: gpi: Add I2C bus recovery opcode support
      i2c: qcom-geni: Add bus recovery support for FIFO mode
      i2c: qcom-geni: Add bus recovery support for GPI DMA mode

 drivers/dma/qcom/gpi.c             |  30 ++++++
 drivers/i2c/busses/i2c-qcom-geni.c | 207 ++++++++++++++++++++++++++++++++++++-
 include/linux/dma/qcom-gpi-dma.h   |   2 +
 3 files changed, 236 insertions(+), 3 deletions(-)
---
base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
change-id: 20261008-20260826_aniket_randive_oss_qualcomm_com-84f5f536302d

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

