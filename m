Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A8497B80
	for <linux-i2c@vger.kernel.org>; Sun,  4 Oct 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791140999; cv=none; b=cgCYXjLqf/1Oa1dnLDGIsN7KZxMJBMBfOVtA+t8SOoG5btJfftQclNgcKj94iS5NzFbtWoV01z5P2H/VwJkjWu3O3ZFcEKSxa0P0X4irz9dHakM/zZrOAN8NsENhf5fkAuX3Jmo6sgmTyD2EwzklrfgIhR/qLfmYLGV8g4sAeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791140999; c=relaxed/simple;
	bh=OXoGNIvQVsYZOLft7tClkGz9jX50u0uKTsBlp9+t3BA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i72l/U9eJBH63NEPa4YnW0jMzc8ORt6O92yzEmsRXNsuaIctcO061mSrmBA24r41pZKxOTiXFf0apk4roEUKtZ9XScl+Yz38xvby+jCC9GR98pIlYtSGh0V3gca96L40Zf1/XePKoznwCAPJTFjEpf8ndPn8eYDN1gN7gudxYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EDp8euvp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tfo1d1Bi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EDp8euvp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tfo1d1Bi"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 694IHoYw119937
	for <linux-i2c@vger.kernel.org>; Sun, 4 Oct 2026 19:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6IW4WO3lEs3YpZu/aGlG8G
	nOw4F5Xm52MYkpfN/zSx8=; b=EDp8euvpPyxKUXhkXSAZYPNsw7FD3ZGjGk/cD9
	NfoOoUACy+rxgE3tRItDLybaeUC1EVwP/8Aju3n+jHzQWqRCwLVEPaAXKqqJcdbV
	nGU5N/w3fsjyXQYpxvZws0ygMMs4C+of3eP83lM1da1U+8YkLcLMJCuV+fuTXESx
	rX1D/zSItjbXdkDZd5+HnPnR4ULqeVstgIO8+lEnFMeYuhDCjM/ktPhcwROzAo7H
	pkMULV0DCNi1k4iIK/H6nBsIgP1zPuOpcONEebcQ0QohGqObAuOUPesWOXUwChCa
	J9swkFbqHBhshQtyTNz4/XJlJOYrN2+86dJxaCnGQWHJOZ2Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sq8umk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 19:09:56 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917870a9be3so33216906d6.0
        for <linux-i2c@vger.kernel.org>; Sun, 04 Oct 2026 12:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791140995; x=1791745795; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6IW4WO3lEs3YpZu/aGlG8GnOw4F5Xm52MYkpfN/zSx8=;
        b=Tfo1d1BisZwMb6VpzBUNpLM1d79FFRMejhihSKpDKKtrnAdJxuJr9iPUlGUrmRNYqO
         VNVi6OlseAmGtqeHxK4jJTozi8c7IhiA+F+AANn7YPwIS0uTwtbQAeE+Npal1rlSDMx/
         GKH4pH+UvOpZP14sERUaOToBfZ1KFjxqvh8G1zTYKSzyKsNos09KpMiRBj9yR+so+9Ji
         rntg27ZoFBvJd7y6xhkSpPbPmg+Xnf7KrBnToH2mv1kK1CFHkL7oLLJHb0g5F5pEabN4
         zf4mz/tu2d4v/nNVa94kK0qa2MdM4OajlM2DEIZWNNJm8G8TftKQfxF/4wiXlES0A1PY
         ZawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791140995; x=1791745795;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6IW4WO3lEs3YpZu/aGlG8GnOw4F5Xm52MYkpfN/zSx8=;
        b=L7ewgndmQGn798azL85wfdIOy+qnNbiDR0qkxwrv30KK3GBzeyOXN4v+fDBSWJWJWq
         sdf96yDfMJZsRwy7oyqYBvRQyRwaOQL1qjZbPXaBCFh2A8K+JTe+lq8f9uffArn4bC/b
         Oczz2kwSm2pbN3WQXJ0/HbvmTTuCPp2Ob9c/gh7mf4J3b/7TNo2Gkl5SosGX/TdAPMq7
         OUMQgGg6v+WGknTXInvaSGWY3XJFQJT6G9zZTvASCwxceu6S0b7sOKznREjzg/NO8nxS
         kRV6ZsTKdTL+lNKzT0dk3fq2X27urZMCWXmBMNyO/lJV522b7+QhRy757rgysNk3CHXg
         FrgQ==
X-Gm-Message-State: AFuF++kcexA3oOPNd0DK8hpYk5H4Uo+Q4Q8TEPKIS3rEAis3viKnAm5U
	83hsOGtgOaHmxyjMP79buxjmyDC9s7TD0BW/x1G5kHooLZ88Wd2fIFpFZfI6XCVwHL1F2t6yEzV
	ChFyXLBZ3o0QKMNIx0xw2tHnOacjjXW2nb2XOVYZsXYWcXycxWLp8SLEwnpcNo3g=
X-Gm-Gg: AYBFou0PCd/EwpyBRaimbFmdSuKzjGf5fTcJn6RU+hcFxM+9bdRZ87DCcmICsVUjyS7
	rzRxWwuxIZMApL7rc+bm19ScyWSVuV7EriySdVLjXPMyxLcyVCe9PjcQrgzrH/0RXgfOlhDTNes
	aASIvszZXvtDOppf8BhvK6E/0BcyWLEIt3GMCtn9e8SVh6gGyCAlKBSa0Ck3i9CALWqzlEwzmkb
	cY7FqBL4ndA05xjaph1OG+/ejjnZWgrSGzrYS9f5eJJZpRNNxNb8bUlcM686ojGj/EddDZrcrRx
	KhLlBHyGe7hqL6HjtwkjT6+UA1vMIDnVOKTBSq27GYjKFrdymOe2+YzheIV7rwlkucYUw7kl3XX
	S7XLLS9ocw8vuWnxlIa1EZpEdxmTW3osvpOYd6NrXisMEqJmBXvbpSOPIBdnQsyWs4ckCOe+Mzl
	8aGsQNPyZ2TU9ZkQNYkt15NROjiSnhDozIL4oTQXpWejyGlT8s3w==
X-Received: by 2002:a05:620a:318b:b0:939:b053:ce44 with SMTP id af79cd13be357-93cb5b42a84mr2242653285a.22.1791140995380;
        Sun, 04 Oct 2026 12:09:55 -0700 (PDT)
X-Received: by 2002:a05:620a:318b:b0:939:b053:ce44 with SMTP id af79cd13be357-93cb5b42a84mr2242649385a.22.1791140994925;
        Sun, 04 Oct 2026 12:09:54 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([37.169.59.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394ca0f0sm176318385e9.1.2026.10.04.12.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 12:09:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 0/5] i2c: qcom-cci: Runtime capability detection and
 improved read/write
Date: Sun, 04 Oct 2026 21:09:46 +0200
Message-Id: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHqkwmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNL3eTkTN3M3AJdi6REYwsTYwNLSxMjJaDqgqLUtMwKsEnRsRB+UWp
 hKdDAEqhgbS0AWdtP124AAAA=
X-Change-ID: 20260929-cci-imp-8ba384309942
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 4nxkfBwuxC6b0kfmKlD4S8t2tTspHD24
X-Proofpoint-ORIG-GUID: 4nxkfBwuxC6b0kfmKlD4S8t2tTspHD24
X-Authority-Analysis: v=2.4 cv=TKzQ2Fla c=1 sm=1 tr=0 ts=6ac2a484 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=1Gfya9YG+27Uq/30OuQ23A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hgtt4lyW0_XcBbbwjOcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfX/P9wSyfbQEWA
 S67tzobreG5kuZEzCADOZsaHt2u4a2gVCuzy20A9L83dmJlecQzQeCbX9wHZka/ODAm+crCfHbW
 RaWJsOI9phwFNwPctULlPTZB57SgFkOMn2n6/WYMyX9UdPz4b8BMx9A4G0RsSs3rAniR1xN5jiI
 vupBOcHQYAn1ukbKTNV0O0s70Hoj9Mn5+g46sE9LozlzKyd2kZ+O3/DsZcg44lFmmZpY5UpyrqN
 nLjjFtWuu+GhV/8d9m2tdmWRiTtTZeobHfp+qA8LbA33FYGN0T5Rfg2Nd/2fCQZ34rD0iqipwfv
 JXsLU9Z0p+GuAwvJ/O6oIxVe0Hs4bDc9oy4PMIshOjtNQSt7K2cYeu20I5dEkT7h2YG2KjP6XV5
 ChKd84lrKPtP532EyvtFVUnPlOaOtH+4WmrWbuRMfZeORA3ke8tPYCNpUJvESgLZjpR7GX07n5T
 RooPNEii8kqx2puyH0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDA3NiBTYWx0ZWRfXxRl/+OUgdpcq
 8Ah+qCyN3Mby/4U481GLQI5X1RYk6qEW8Z3gYsXTonswKkJ2DEjDLHDf8fP5Xh7PP2FjGTXAz/6
 nwvaBOpvqDNsR5FsGhQcFH8MqGqaOs8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610040076

Improves the Qualcomm CCI I2C driver in three related ways:

- Capabilities (queue sizes, max transfer lengths, supported I2C mode)
  are currently hardcoded per DT compatible string in a handful of
  cci_data instances. Patch 3 replaces the static per-compatible
  structs with a single version-sorted capability catalog resolved
  at runtime from CCI_HW_VERSION.

- The driver only supported single-command writes, capped at 11 bytes
  regardless of how much space the command queue actually has. Patches
  1 and 4 factor out the write-command queueing into a reusable helper
  and then add burst-write support, chunking longer writes
  across the whole queue instead of a single command's payload.

- The FIFO read path hardcoded a fixed 12-byte limit unrelated to the
  actual per-revision FIFO size, with a special-cased drain loop.
  Patch 5 simplify the FIFO read/drain-loop and derive the read-side
  limits from each revision's FIFO size

Also add overflow and underflow IRQ reporting, as queue limits are
now derived from the hardware capabilities and exercised more
aggressively.

Support for unbounded read and write transfers using the threshold
IRQ mechanism is planned as a follow-up. Such functionality is not
part of this series.

Depends on: https://lore.kernel.org/all/20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com/

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Loic Poulain (5):
      i2c: qcom-cci: Factor out write command queue programming
      i2c: qcom-cci: Handle and report queue overflow/underflow interrupts
      i2c: qcom-cci: Detect capabilities from CCI_HW_VERSION at runtime
      i2c: qcom-cci: Add burst write support
      i2c: qcom-cci: Extend i2c read limits based on CCI revision

 drivers/i2c/busses/i2c-qcom-cci.c | 286 ++++++++++++++++++++++++++------------
 1 file changed, 194 insertions(+), 92 deletions(-)
---
base-commit: eb271d18cdcee558095324dffaa53d9e6fe78882
change-id: 20260929-cci-imp-8ba384309942

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

