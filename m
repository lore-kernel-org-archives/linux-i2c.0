Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F153ADBA7
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782657557; cv=none; b=lfLz1/5UA/3Sq0UgZvz1xBc9H9B1WKfaQ/Y3CwRwf7OGZvrlUSMoKwpP0dWbBeZLFXH7VUutGSErVXKdBtMd6u2jF7rFGyLpu8KD9cKphQyaRaEGeoaZgP1wxooPAb/DpADpnOXBE6Vos14YGj9Bn6G9JftkjSgdQXx5d48bVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782657557; c=relaxed/simple;
	bh=HSbebYat6XuRCbr0vOrV0jghMR95+d0H+S3AZ3+N258=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fL3r0aTpLhglgyaQz5wZ81rhrx7gAwyf+8hZBrXwGqYFTzwSYHR11bBCK0faPIyFBeaTe1W6XjLG3ns7kwmmB5SwBdFdsIldFbHxLGgTuwz3SxwJz0FRF7BAit7W5n1RjTQJk31as4RJe0hb1bh2TKEGy18ykjdHTONpxDXbMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPTfnK+H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JNigp6VA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPTfnK+H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JNigp6VA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65SESFYx010497
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 14:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lKQaKbw17lm33vAWyDAZhQ
	TOkgV8lWLpQgOvWkee3gw=; b=pPTfnK+HxeGMhD+BrkYSb8GaMtCTFbLtEIdYMY
	S5R/41WrxgeeNT2VRCfggj7HQ/8CdS4UP89eyA3vLJnl3ic3SSkI+p3TKXglyXHB
	+ftUkL+3wd5MfwlVvTUbS+8EgRLixyt1nrazm6LB9ZAowcvpYC/1WmiQgUME4hUg
	dPJ1OezcEymMBcgs3AJ/QtHFjp7rcd1M7F8k/ww9kzfzm6qnF42YSkmew6/r5Kr0
	LUAyaxe4o+90Cjy3O+WNwUaaR2hvogenVNaq4m4yFoSRYVsk5dTjAKt6qqppXzW4
	lsk+OxOjIHDwQBvYWRIbS1axkZtdyiIvtFYWaA5P+ztJ5cCA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26w6k2jw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 14:39:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so11757032eec.1
        for <linux-i2c@vger.kernel.org>; Sun, 28 Jun 2026 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782657554; x=1783262354; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKQaKbw17lm33vAWyDAZhQTOkgV8lWLpQgOvWkee3gw=;
        b=JNigp6VASP8qst+3N5U7ttOxHU7YG/El6SyZ6X7h+L7UsPbR9hdyBwuytq50MzVOIV
         4YF0INgHPV/e8oBRGtl7yX7A69HOFz12TWdgKl6Q/XG19YMwdUDgHiKAq3c5xxxry0xG
         LG/cMrG/riyyw/Jtuzk3YotVseWvRLj5XunuqUf1r7JZjfqtS71cz5jyIJhqUtjsVFg2
         LaVWE8HxdRGIyBUxftvwi4vxi29BbAVd04KB3MnhSxF+c0nVhJ4RxtOdNHul3dNZ6/K0
         sJAH+niw8cQA1E/5aQ3Y8SLPE2FWIFd8BkvCngDmqvAX/jlhk6gQ3pk/Y2iP9We8ZE03
         8qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782657554; x=1783262354;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKQaKbw17lm33vAWyDAZhQTOkgV8lWLpQgOvWkee3gw=;
        b=EHSc9dV1t/jduMU0TKszbWfR+z15ToUvZgW1dSIy/fXEfY1l2VybDQ7siV1BOsMFeC
         /hDe5Ghp84RHsfo1WBpvrVzAo4k2O2lgnV7GEZ5GOjctJsz8Wb8deDCOYf6xLRgGW54z
         YUdj/h2r8a17GH8aRxZ5C2wwCD+8NDihujzc0dvwdF7NLydYyYIgl9xwW9I2Hg81k/Zf
         iIJ86dKw/IYwC63f88byC8a9pV5OBro6ssVjTD+QQzjWrjcz5iI8GC8ycKLD5ySl+0U3
         HMVpnGZQkV8ckzb89IURvtD+aq7W7yhtVwEZODdf0BBO5vuABuiEZrz2LL3BfChF7MEY
         ve7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr32oKPLLDuOVBT5TBzShy+bkw66ucH6cFgkBQcHptEX3D+3FER3mIQw2KrqlUH2WkjnMzDr2jWYTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/UrvsGQCcg8TqLG1pSHzFxsg5TB4uOoA0wS1+lgpdHSUG0Ai
	0d2gKQvg3WoeExok/LGTAQP2NX8EzJYO9oci4xj2GH1o9+60ekrsh4AHhtBRr5zgxQd+nKLXXDc
	sQvQ0+Ln6g34ZV2Cow52wV2yCkaqTx4SH4tjOvQpEEWTx4Ok2yGUCr1G3prPInFA=
X-Gm-Gg: AfdE7cla5KPabwT3JQzisVAf+gtuKvx7FIvJCsvPbBcsxM/BeID+zi7qNINfzHRCA79
	PTzceC95r7Mk++nIRxvvToRyh2V2qkjoj99kEbI9kN8Elmo5YYYXmzaV71ARfZBOGNiiY7bACVg
	XWB80jxxlbILr4QDlL4FTOZdQG5VMqgjPmxed5x8caGIF5haNqXrvBKzIoXp+Iv28HN3Pkssb+a
	skejf0cSb85unIluhpj590roC93aOK/6EOw4o4FkI8C2CP7K+X6Sq36/WsMyZ8y/MqCw6Tm483S
	JB1eiL6CVE09WG65RepPNVMItE2C2uK900w8+plhCX7VLgisaF9Le9o1pN5+Ly7Pt35/PHFGlZP
	GGgRnb+wNfZb31yIXPtgYZ3X0G6p4vGYeAH/f3Tv7kur1qag=
X-Received: by 2002:a05:7300:6144:b0:30a:e531:3141 with SMTP id 5a478bee46e88-30c84d12a71mr12867373eec.17.1782657553829;
        Sun, 28 Jun 2026 07:39:13 -0700 (PDT)
X-Received: by 2002:a05:7300:6144:b0:30a:e531:3141 with SMTP id 5a478bee46e88-30c84d12a71mr12867355eec.17.1782657553223;
        Sun, 28 Jun 2026 07:39:13 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm39300591eec.4.2026.06.28.07.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 07:39:12 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH 0/3] Add Qualcomm I2C slave controller driver
Date: Sun, 28 Jun 2026 20:09:03 +0530
Message-Id: <20260628-i2c-qcom-slave-v1-0-8b0a5c01f9f6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcyQWoC/yWMywrCMBAAf6XsuQvNVkL0V6SHum50pQ/N1lAo/
 XejHmdgZgOTpGJwqjZIktV0ngq4ugK+99NNUK+FgRryjaeASowvnke0oc+C3AaK8SDBHx2U6Jk
 k6vobniE76P7O3peH8PI9wb5/AF/1dOF2AAAA
X-Change-ID: 20260628-i2c-qcom-slave-c382ff4e8691
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782657549; l=1481;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=HSbebYat6XuRCbr0vOrV0jghMR95+d0H+S3AZ3+N258=;
 b=UYAdQ0J6ieyuQJHepnUtfY37oNslgOwYB3/BCEKxgXTWYNSZvUoDtWpmmfag6kkhGUCfz5QCe
 QoQmS6H2W2qD6W9mBoTkRVH3RJCRfg6g0GEIEIDqZfddQ9TnGuPLUL0
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: tDhc-xXHAmyCp5IIznZ_qU9b4r9-4r6c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDEzMCBTYWx0ZWRfX/HcJVemPNt3w
 dgWYIYIYdo6WvJIuVd1NhDn5UICP/qUyONY0qZfde1SQRJ9M5TXSaQ3jJ8ro97bgtn9QhUssCUq
 1upbTHn+rNexQUzwahwOIEJNqcWVX8Y=
X-Proofpoint-GUID: tDhc-xXHAmyCp5IIznZ_qU9b4r9-4r6c
X-Authority-Analysis: v=2.4 cv=SuugLvO0 c=1 sm=1 tr=0 ts=6a413212 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=M9RsmfkhjSGwUMDLw84A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDEzMCBTYWx0ZWRfXzxIz3qxhMiJp
 Ei55+Qqp6MBcnXNc7K+XfdN1ZogCA2j0MG5t6X5bzqZ6SvLrUiI7mdO+ZugxCjG4KQtWHO8o/IK
 BqGBYoRZNhXYKpNuCmtWYDlgRmDHBtkFcQIqBA5F4O5eDtv1PCEFqWQwpy78NcmP5knyOB1US62
 hp1Hje1fGhWVVbj401BEKIoymTC65VXoXmSSKTTYZ5tEEiwocNwlI6BeyzlMLKPNQrs9alxNgS7
 JUIHed3kSfczJeMTCmnXu0DCRBjVJJozUWDfN9opiupsBozJS6YR6dNLeFeQ1D8J8fGaz9pbsFK
 l3CG3lUBuS4OBsBGcGADTr9mD/OHkUgthH3+Qyr8lsARJ4GMxzTKW2YfNW/Ag/UrqKC+B6f7mH5
 fMsZQe03Y5UX5/miQpv7aqW85zadwGTBcOWktGvUNY3sD63k1kEuqlT6VYm3GorsvUHqgZl30kE
 y31ythpoS0VJZH0OBLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280130

This series adds support for the Qualcomm I2C slave controller, a
dedicated hardware IP that operates exclusively as an I2C slave device
on the bus.

The controller supports FIFO (PIO) mode for data transfer and exposes
an SMBus interface to userspace via the standard I2C subsystem. It is
present on Qualcomm QDU1000 and related SoCs.

The series is structured as follows:

  Patch 1: Device Tree binding document for the controller
  Patch 2: Driver implementation including Kconfig and Makefile entries
  Patch 3: MAINTAINERS entry

The driver has been tested on QDU1000 hardware with byte, word, and
block SMBus transfers.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Viken Dadhaniya (3):
      dt-bindings: i2c: Add Qualcomm I2C slave controller
      i2c: qcom-slave: Add driver for Qualcomm I2C slave controller
      MAINTAINERS: Add entry for Qualcomm I2C slave controller

 .../devicetree/bindings/i2c/qcom,i2c-slave.yaml    |  94 +++
 MAINTAINERS                                        |   9 +
 drivers/i2c/busses/Kconfig                         |  14 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-qcom-slave.c                | 777 +++++++++++++++++++++
 5 files changed, 895 insertions(+)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260628-i2c-qcom-slave-c382ff4e8691

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

