Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FA4BD349
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887432; cv=none; b=AWrF97sju3XDzUJxj0YSX8rJ8Qo+Oh68aJCXddv0LbQoWzZgvyHaujwAXKBAqLhDNTFl/MSYHDmiwp4Ez3BjWgTHO00ckBI4efQLHeEcAMBFQ48adrDJhQzcWGlEYp1PPu31XUyWIlitMmYln5wLaWG11ZFLeDUmoZ8sO8nKNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887432; c=relaxed/simple;
	bh=llUSfK/j52895Up498qaYYkhoVfBtms/teGO4gw9de4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QuMMr9YKt8Bt6Kwf70RJe9m0tx677uHGsfBADrQyebGHl90666xFxF/f8YOpzNHeWG5U0IxA1WxycxjWJZr6WDSqvVc4CDs9LOlx00XcXxLUTVGP6JJ7A+c3uIM8NpwQRJCpauVTSFE40goPHZvT7DwhIq0wMJ5NBkzuNYxFCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UyBmbbDZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fEMfScuG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UyBmbbDZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEMfScuG"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D7OdkM015591
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=i8/Q4Tq+4DZuh8QWu6beqC
	0Jl3juQa3zTScBd6grHSw=; b=UyBmbbDZT32sylslpoJIJjCZWWne/CFTe7nuUN
	+0PkAsJIkRpr1xIuhlvUc0ekv1U2y/apFjgTmNoTRQgZyTICSZlZqysUfYC8gJqz
	YXEmg1pq3JJMOEuWAuEiqfySSZiarVcGRD6pTuym0VaGW7abJEeZvNQ/sje0BQxm
	qXm2leegsgzZLCxj58MxhjDUVHkvqVvNYJ0IJnHKO4gbVnUgNeAE4ib8R3MfhFN3
	czM+UAEqH5IKns8/25Eoi69nwxlldd/rgGzdyJOWzmtU/xT1FQIlhhmANnqvM+Uq
	2p4LUZGqijQ/pwZ8XTC57RNycTP6WACybKAAmiEK0rbv3G3Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9g7ugs6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 10:30:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ea9ea9d13so469872685a.0
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791887429; x=1792492229; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i8/Q4Tq+4DZuh8QWu6beqC0Jl3juQa3zTScBd6grHSw=;
        b=fEMfScuGkS6Au2LwbLgBu/EGRk088/exRNhNbRQxtNwFNKbOL1zS0AawCynt9fbvgU
         q046qwWG/NE7YeFhIN9gehpl6sK5+iY2511olbbCPKh3++QLUf9km12yPkYN1Em4TxiN
         uPHrD2XmZT94W23ZNgfhWlLt1C5C+L1i7Ap9KSckyLEZq02LszQQfziogRuGJtE+MoMl
         mf99o+ZHoArRIVDrxEoL7svWjNlzaZduH5OW4CCkw2sW/LN6wV7YwiX8Ak4r4rh05Twv
         ZPA3ExGJ40/SE93J8PgDieJH1saM9od5LvA+VyFq9AZuiBWOeihBlh95RSIjgK6+i4iz
         menA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887429; x=1792492229;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i8/Q4Tq+4DZuh8QWu6beqC0Jl3juQa3zTScBd6grHSw=;
        b=gFLGTTD6zUkKS3gq9ML0pix7a57UPcRVD7YKlLQDvfLQhJHi5RUs1EEqvWfuI3Emjp
         sucLXvEDzIsnfrwGtLGehCZH1G7jYupSpPvfrrMVdqyGxh3VpWZThHxhOEjIlpzgsgx1
         Q8/HQtOAVBLaN8tU4TdW5PjHzMBsASmZP2U71I2grIcNOPsKlNCcpaFzUUCP/VEB6CUo
         Xcl4zDECWJHKHd1xMMOIPZxvNFIxssc500bCMfn0Ulx+RdX3FLGg1Xeyt723Z+eI8noZ
         zd5XwzX1304fv1Q5m3NpZW2WbXlfUY3JgcsABqub7FPpQ4pylGmlRCEmpOG2YH3sEdzw
         hEUA==
X-Gm-Message-State: AFq9FYKD3on8x2jRrdd6ycnRncQBZ5EBIoc4bb8B5Z2X8SfOgcJjstx9
	MzDGHwk3uyyasOMGRmXMo/MyvN1KMxQKDGo6E1ZIeRzEsCcOZ9xXmEqm9kxMGZpc9Es0rWcOUlF
	Se3xycijTWLUcjsr48HV0YXwb8wFnnLAVwtoex0CAPAjlkR3aC+WiEhHtQTWBV+Y=
X-Gm-Gg: AYBFou2O4cQL5GOoSaEnYiPCuLdAhZge+AM0lsWyk/SBhFe0pO4DX85tgblqxyVzPJ8
	F2WoS2vfc1MmWzbrbK1yTDMuUT/U1uCDmaM6/iQ2nMjPsg2aZNKIGkGTm4o3lsz21pdFZnyX0vw
	v09mSyoaZRJzQ5qL+8wjwtzeeUIZacw1L01H9qlKtvesfl1kOacm0BBoW63PcmILPfr8e8X8D+U
	Xo1V65zGjUpXwUU1n0qVi+1HIN3C8izzP3TT0hLBy267gmhGN5N9VvD7XsMUV/J9dN8lOSbsX1y
	D2M+sGbLYgw07qcIVuDT+LK4kI4I9tSjVN1FDGWsuQ9LRU1SYroHPFlgnNXmEMyCW2UpDON46en
	7/mSicAIpbJb73gFKZijSBIwrqqZhbMFKUd1+zBpXCdRto6f5hnzc/ZtuS7ZbtLmaBPapTQSILy
	LWf/TzvttrkbpFEGqb4wAY0rB9ycIWr7hpQs2kqCaibf23oxDTpPE=
X-Received: by 2002:a05:620a:29c8:b0:93c:6450:9ceb with SMTP id af79cd13be357-93ebd0c3781mr1856371285a.1.1791887428920;
        Tue, 13 Oct 2026 03:30:28 -0700 (PDT)
X-Received: by 2002:a05:620a:29c8:b0:93c:6450:9ceb with SMTP id af79cd13be357-93ebd0c3781mr1856366785a.1.1791887428306;
        Tue, 13 Oct 2026 03:30:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d108:3895:812b:662a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be964dfsm349955115e9.7.2026.10.13.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:30:27 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v2 0/6] i2c: qcom-cci: Runtime capability detection and
 improved read/write
Date: Tue, 13 Oct 2026 12:30:24 +0200
Message-Id: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEAIzmoC/0WNQQ6CMBREr0L+2pL202jrynsYFlCq/MRSaKHRE
 O5uxUQ3k7zJ5M0K0QayEc7FCsEmiuSHDHgowPTNcLeMusyAHI9co2bGECM3MtU2lZIV11oi5PU
 Y7I2eu+lafznYacnC+V/2FGcfXvtbEp92FwvO5U+cBOMM8dQJNK1UqC8+xnJamofxzpU5oN627
 Q36A0cyugAAAA==
X-Change-ID: 20260929-cci-imp-8ba384309942
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX3OdtMiNl2wX2
 5UgagbqOE0TKTOkpA4Xq1P25SV/DKxdwPYmVRmBgcoapdevBBd0hkRNwTsjPGyHDOsqv2gUd3Ar
 Ce9fpwPsofLannXwbJ2TaSmsOYyMhnoI7B8xxc/25zMoaREcUYmwBozmDcmDyD+2wuyg1q7KXL2
 ZyIdTz89EkBGWrQPhSnClloVvmOoMchp3O8R3zR0Zhf0uVEzmgDY35czL6GuXaxlCUSLfgqaSuQ
 J8OJ2BV9RnvBpzrB5xg98K0h5ff4VocoIUoDID+xUkbKFn/pWP7hEXKqrO7/zGBvojUgmWxp2ze
 C2EisLOZhHgHIOMYQqbotmTKgdc45TTdcuWQQDzu3xPbVwW/VfxWW+gqA5gFGBUaBCkJjXnWyLr
 yQD+XZ89is1kkUfogMQdKZG5ZBE1vQdb/YuP9F1Je6seqQ667tPqV/WHfZ5gtocmfwteFq0xLH3
 0QyjzCI+wkkKsmdEu4A==
X-Authority-Analysis: v=2.4 cv=Z495j3RA c=1 sm=1 tr=0 ts=6ace0846 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=fqBssBKcfzBu9c0AyzoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 2j2Hl9ed-JNNzcGERFNBcwyl7qIhhpNR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXzxHg1ke/hKvq
 btdWuyyjzU78MbiwU9Sz0JAcw0zNhMVxEDICc2kr9fqb2ToujdX6Z2bLrUP6kFoWyZX/0pw6lot
 BSIzn+YahMh68nlu3n/EGNny7CiIff0=
X-Proofpoint-GUID: 2j2Hl9ed-JNNzcGERFNBcwyl7qIhhpNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041

Improves the Qualcomm CCI I2C driver read/write in different ways:

- Capabilities (queue sizes, max transfer lengths, supported I2C mode)
  are currently hardcoded per DT compatible string in a handful of
  cci_data instances. Patch 4 replaces the static per-compatible
  structs with a single version-sorted capability catalog resolved
  at runtime from CCI_HW_VERSION.

- The driver only supported single-command writes, capped at 11 bytes
  regardless of how much space the command queue actually has. Patches
  2 and 5 factor out the write-command queueing into a reusable helper
  and then add burst-write support, chunking longer writes
  across the whole queue instead of a single command's payload.

- The FIFO read path hardcoded a fixed 12-byte limit unrelated to the
  actual per-revision FIFO size, with a special-cased drain loop.
  Patch 6 simplify the FIFO read/drain-loop and derive the read-side
  limits from each revision's FIFO size

- Add burst-read support using threshold interrupts, allowing reads of
  arbitrary size by draining the FIFO incrementally during the transfer.

Also add overflow and underflow IRQ reporting, as queue/fifo limits are
now derived from the hardware capabilities and exercised more
aggressively.

Support for unbounded write transfers using the threshold IRQ
mechanism is planned as a follow-up and not part of this series.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v2:
- Split the HALT_ACK reset fix out into its own patch (Andi)
- Fix a typo in the "Detect capabilities from CCI_HW_VERSION" commit
  message (Andi)
- Use GENMASK()/FIELD_GET() to decode the CCI_HW_VERSION fields (Konrad)
- Derive the number of masters from the DT i2c-bus subnodes instead of
  encoding it per compatible string (Konrad)
- Add burst read support via RD_THRESHOLD/RD_PAUSE IRQs
- Link to v1: https://lore.kernel.org/r/20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com

---
Loic Poulain (6):
      i2c: qcom-cci: Factor out write command queue programming
      i2c: qcom-cci: Handle and report queue overflow/underflow interrupts
      i2c: qcom-cci: Detect capabilities from CCI_HW_VERSION at runtime
      i2c: qcom-cci: Add burst write support
      i2c: qcom-cci: Extend i2c read limits based on CCI revision
      i2c: qcom-cci: Add burst read support

 drivers/i2c/busses/i2c-qcom-cci.c | 429 +++++++++++++++++++++++++++++---------
 1 file changed, 325 insertions(+), 104 deletions(-)
---
base-commit: d6dc536a4c8bb99dd822bc349a9e801be7ea81c9
change-id: 20260929-cci-imp-8ba384309942

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

