Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61840B6D4
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599913; cv=none; b=Vd8IhBlm1eyIJrqNkElyMAoaZ2eoNThRDb5cN+lqSmihWj+UwHqWOf7CMW5oPeidDUOuKcF70eE4gayXZw+zBG0+3DUSM4lwM+T44GUPxv9zZjHOydG00gKHgHfnO7J0+UoeYeeYH/6p6ryGzobJQoz3Ugnai4ZY5V6nSkdXgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599913; c=relaxed/simple;
	bh=EIM+00GCuvTubxKkRRTAMcjkkX/fC1S8PtugeUfQNHk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rfbte46LBEVjSpFH6YyrKxVnff0J3u1zOQ7rhunuP4qg8L0WbdyRlnjqDCTtC1tPUy4XiLkVZwDzjnx9TRBRdjAns9xTNqIR8uoVyVMUKO9hvm9iuuLmhhfJ9D+tKm+AN8gxHNZwOv0jdFoOcobQOLybRUqQOwCAoUxtVTt3qQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=enYv7hXi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OrvyHOhv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="enYv7hXi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OrvyHOhv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D5fo192974533
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KHYyC+iAYlxol+c0pSnYJr
	gZM2/0AXJMpaGhwLaay8E=; b=enYv7hXig6UuQZZdxVn1DWDK8D9ibAjeMRlVhH
	eR0oI721K30CuyAYFkWJUfNgN6GfgwOUH38Lv5qLgErds48MKmX0VU1RaK+xvBta
	2XK/WWf/OTYTDSv8ZaHqUC/fhRJ274Kt8bpZ5UHF6syR42ek5BuJaumPk+1aiUa4
	x9MIRiw7VrqvfAa40o6clcgnW9QKyOy52y9vTlhWbwwyk6BISPUtHoW3dpKlmRgz
	5SbxuRjdtCeZJokOEt30bXXdFSZKg+5vQLr8/lfByAgLq1XI76gErDL2arPGypQb
	fnoFCiAbVN7Eob0HzEhHk6OR8gsFGYjji10qfqA9B/R1/gqw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g152m8ner-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84857446424so659023b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 22:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786599911; x=1787204711; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KHYyC+iAYlxol+c0pSnYJrgZM2/0AXJMpaGhwLaay8E=;
        b=OrvyHOhvaMiesun6HvzivWyA2rx8UvUfrlqnaRII+rsAonntf1v08wvYEVdmkALcqF
         CJMN9v14c/LtDHS0qZhNqOLHuSfZ77d1H3EKCg6Xwa6FKEBfgmK1McMR6cjWTgqzTx77
         NLJViiF5hfLT68yvJjfKzPbMlIMSGJg29IuwZDXLgszzz3JAltqrBeVlQ/vqdpisgr8l
         E2oyHYn0T8IoKamm1QqeyyJylAfOLEZ7ZRdAMgwhRVlrwOU/hlVmt/rk6THduK7vqcXl
         tnXxcbIMPfPMECNaXEYGLyU/D/pPoTmNEnSEprgyole0P2hL2OlN+q2dblXk1xiJCn6R
         QyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599911; x=1787204711;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KHYyC+iAYlxol+c0pSnYJrgZM2/0AXJMpaGhwLaay8E=;
        b=Ruf+MhDxCQLUx9VdHKOYhato0Q0nSjZ8GVCdSQRcjpGi1W7pjMiZwmHgooSxo9WOiO
         ySlcnzHlnozIEq3avwQgOp2CIxjKJPwGGzL8hddLSlNKWkCWHhEG4RGBmWuoSLRgBUpL
         5gR/lME/jS70+auNQvFEfS++iXHFLUEQPXX88AlpnUAfFBHoPbrZpIkiMVzuHF/JE0bP
         XayX98401KlDC/sa7uWN9uAGmoAXopjZkc5gtehZZWjhBwpCZG+AHZkozZOpxOwQKgBU
         ZNaB7s1dSNB0jHTz4deurnw+uV8wKAs+nQKGefHtIOvX0M4aKoSOIsXKyY8HrHXEKNhH
         lZwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0hII+vCrWepwX1MnvYR5SV0MpOzQvf5UqWl7m69Yvq5cTmvjauyNmYPtDQfP6t5Bhh75PkJNmICw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXeWQb6iGOZf6i8Q9HmmsPOCj+aOSS3kNQ9GyO1+8ek0I43cNX
	UEl2VAhrxprna26NPVfNb/fowfeUtYJY+VTV+FQPa8Lu85YEodNoZzpr0aQVQdyhOhrjbo3BAl/
	yDBhbq6QjiKgaEgdDNYiIDqSGz3opEd4+E5vM12kOtKio5SLt6qpmEFaHUU9eUOU=
X-Gm-Gg: AR+sD12QO09Bs1fxjkdpVyiCsllDYEyMFNHVfDJd3rLpMreuRWAgpYdMSclqaTnaI3P
	EMhIYanesSexJZsXdlB4rW0k7UQ0QXcYA6trDtuYxaql8SCvheaGWrJ2drkbekPrXz6o8viZfiK
	PDvoGnrLtB25NHDfwZoAf+TXJ6JX/Qy/ahsjUdn0So3iaBfc3Xq4iSoTvN6vpaN1j60XeyGXAcq
	SSJ98omjs5UmtacfN3G/pEFdy76MagmLSW28wkBZuYTDMX0j8anBGZxlMlnjey9CXLSdD04Qr4v
	2r17Dk8LXWCD34wFFkSOkULAIO1tw0d12/NKFX523dY64VmeM10wNPnc/YWa1x9Kq+QHkmUE78M
	+yOdFvxOUZFu8P8agYS9Q8ffwvH3hWbOq0IU=
X-Received: by 2002:a05:6a00:6c9f:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84fc6e6395dmr3631578b3a.25.1786599910481;
        Wed, 12 Aug 2026 22:45:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c9f:b0:842:2a81:4c63 with SMTP id d2e1a72fcca58-84fc6e6395dmr3631492b3a.25.1786599909921;
        Wed, 12 Aug 2026 22:45:09 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc477e53esm381500b3a.14.2026.08.12.22.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:45:09 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH v7 0/2] i2c: Add dynamic transfer timeout based on message
 length and frequency
Date: Thu, 13 Aug 2026 11:15:01 +0530
Message-Id: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1ZfWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Mz3dzE4pLUIt0085REU/Nkc1Mjy0QloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AVFUKJGoAAAA=
X-Change-ID: 20260716-master-f7da57c7529a
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786599906; l=3190;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=EIM+00GCuvTubxKkRRTAMcjkkX/fC1S8PtugeUfQNHk=;
 b=wBGBpHnk7H/P66diXYZ2LehJESfWX0a+M/xJGhYJjTu080bBVsrRmC0/f0QhZVurNcLfwIHw0
 yFWB/PJ7jx/BUSHUS0CO/Wikd0vNkZUnc1i/uf9sloSYr/niTwwRFmi
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX56nBVHuAE8fn
 Sqx87M1vOzvTVlXA3n9U2WZX3B3Ct/lEjs5ezjnn9Si2leGlgQYv+vHrJjSGMc63fOBJhjaXzST
 7ADH+fqYDc6fJkFDinpAnzvCMIH+AmI=
X-Proofpoint-GUID: oE6D7TARtq8bLrQO84qjUex124kr7TMw
X-Authority-Analysis: v=2.4 cv=D8R37PRj c=1 sm=1 tr=0 ts=6a7d59e7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JvO64EORAAAA:8 a=m8JL0bDcoiRC_ExNt2kA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=Qz6KxWHdQ2_aS5WpiCfK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfXz2HVrHknqEIm
 /L+9JZ25VG9q5aGRu6gWGt80vTzCkUH5t5kZcwY4X40AaW7RZB2UIvEnnDBhiVYHC6y7ouzpPHG
 0+7VSr6AVcxQvVKi/42c8/3acM8tpaLYzNmu4lesvHy+gW1adlsyo3v9Bgkzt7+9VnogW5vXNFG
 8Zb9D8+kEhWC6ksnkKWyja+Pl2B/BQgdCdixaQcjz+yw5byQCAC/q844TbFlxCwpZXybMWK0b/U
 shcC4iL7yHjpr/aGeNXtxFGY/O8ICwzxzmYXOU3nHiZRHF1PK5A25Z5mkzlV7RXTsgXNFt6fIds
 /uAsanz2xZnJvSJN43k4CEoybpIPB17HOCfHHbuz0zkWnm+eBhmTwamE49A8pOwPAOGvv2LW03h
 jOCMBh0tl2s2yNqKQ7vXdGee/P4Y/050P5NPIL9MYXx2kKjfn7NQGiOzryTt+F6nSM4yc4VX0U5
 rPgLzk8CFkmX1aXPBAw==
X-Proofpoint-ORIG-GUID: oE6D7TARtq8bLrQO84qjUex124kr7TMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130037

The I2C core and many controller drivers currently rely on a fixed
timeout value that does not account for transfer characteristics such as
message length or bus frequency. This can make the timeout unnecessarily
large for short transfers, while longer transfers at lower bus
frequencies may require a timeout that better matches the expected
transfer duration.

Introduce a generic helper API in the I2C core to calculate a
transfer-specific timeout from the expected wire time of a transaction.
Store the computed value in adap->timeout so that both the I2C core retry
logic and controller drivers use a timeout value that reflects the
current transfer.

Keep timeout policy decisions within individual controller drivers. Let
drivers provide their own safety margins and minimum timeout floors, and
avoid exposing those driver-specific policy values as part of the
generic API.

Convert the Qualcomm GENI I2C driver to use the helper while preserving
its existing timeout policy. Preserve the static timeout behaviour when
CONFIG_I2C_DYNAMIC_TIMEOUT is disabled, and let a userspace-configured
I2C_TIMEOUT value take precedence over the computed timeout.

Suggested-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Changes in v7:
- Add CONFIG_I2C_DYNAMIC_TIMEOUT to gate i2c_update_timeout(); no-op
  stub when config is disabled preserving existing static behaviour
- Store userspace I2C_TIMEOUT ioctl value in a new adap->user_timeout
  field; userspace-configured timeout always takes precedence over the
  kernel-computed value
- Fix geni_i2c_gpi_multi_xfer_timeout_handler() parameter type u32 ->
  unsigned long to match wait_for_completion_timeout() expectation

Changes in v6:
- Split into two patches: core helper + driver consumer
- Moved timeout calculation to i2c-core as i2c_update_timeout(), which
  writes directly into adap->timeout so all consumers of that field
  (including the __i2c_transfer() retry loop) benefit automatically
- Driver supplies safety coefficient and minimum floor as parameters,
  keeping I2C_TIMEOUT_SAFETY_COEFFICIENT and I2C_TIMEOUT_MIN_USEC
  internal to i2c-qcom-geni.c
- Compute timeout once per batch in geni_i2c_xfer() using max message
  length, all internal wait sites read adap->timeout directly

Link: https://lore.kernel.org/r/20260715101805.3615166-1-aniket.randive@oss.qualcomm.com

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
Aniket Randive (2):
      i2c: core: Add i2c_update_timeout() helper for dynamic transfer timeouts
      i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency

 drivers/i2c/Kconfig                | 13 +++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c | 44 ++++++++++++++++++++++++++++++--------
 drivers/i2c/i2c-core-base.c        | 40 ++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c              |  4 ++++
 include/linux/i2c.h                | 12 +++++++++++
 5 files changed, 104 insertions(+), 9 deletions(-)
---
base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
change-id: 20260716-master-f7da57c7529a

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

