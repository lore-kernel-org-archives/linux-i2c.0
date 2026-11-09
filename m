Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232921;
	b=qlaicACB7sMm3QFVWR6M1vcXLr42v3V3C/Sv9RgoN4Epq2UcFH3NwO2MRm7p+bPoUUK2
	 2aDCrRoq8UvJSFNiW3OY3z+Ab8JHA7n2d0rc+Iwf35nrua8U0wUjt+Lmk55iojdnH3aG7
	 JADozjW+Jj3Mp42JWb4R/18GKB+kjpU3yFRte5pjTJAZXTs9t/8VIs4C1vx8jrRPByZg8
	 Q3PJ9rQu4Oh9lpy9liOvQn2qK+wf7O/DlDF/wWVJBS+O+oOC4cZpfU0fxE0Yj0scv+aOy
	 9LTUgd87vzgGFQ+OHDmpzaA6CeGUo1LBvPBs+rYwtxuNuzyRF2b2fnR1bDoIJbOqrqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232921;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VpqRFbE4DcbPh1FZMQv14KawzXTklyFyVf0uyoyfOC8=;
	b=l0DI7h3NBUBGxVdOy/hRHME8+YWAGKNY93oFUf1b4GWzqprpvOntby6SYBi5CQzFJbWQ
	 QKjs/LPkBuGX5i3saSpo/stgeahcMtbZgWeAkEf/yIBEtM/R0nXkrQJig4hWFnz6h/FZk
	 h0KoboSCaZpkdyUkuSNYh68pTgZPcna0Mz/Tc4lPfWJ1X4Vz7P+RhiDRVxtYppEFfqLlv
	 cizrBt5t5vif49/CyYJTiYWFHsM2/Rj8ISTvv3ji8vnvpU3crY1sMs7mMlhp97ThbgGYO
	 SKro+R48moQjq+nEJnCf2/TlJZ5yn31d2EhYIX+WRVj7QU0bGsj84v2DOKconZG0C3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JITHVDHj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESiFVH19;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B4606A31C
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 14:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JITHVDHj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ESiFVH19
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFZJ83461660
	for <linux-i2c@vger.kernel.org>; Mon, 9 Nov 2026 14:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VpqRFbE4DcbPh1FZMQv14K
	awzXTklyFyVf0uyoyfOC8=; b=JITHVDHjqUsoBqo9OHAoaXL3mxeZS846p7F3wy
	mbqaeMYBH08TBD0/WJdUDvbPFdbPjV2xZIAcr5MjaVUwUf1nhsj/t72uVd2WX0sw
	ZYL+n2+z6mSNzNYFsNIyERchTMZ+oVXv5gxOXHZGhymKvOnrykv2ivR4AKu6/Nrj
	nSpltjBgBUzaPuoODCtifQMHImHlyijYxEoNn28eqGhqxmh3+CrAsNvZPgcVoT+r
	0tS4h/xZjWR5XUhgtf0j+3JNbLhcSHMtLERDLnAaCyO4AVaKYL6rfGf20plWi4Sb
	ne8/hi2IJhKKU+l3jIWCzkvW+1+dQrIBJ59yCVc0sTnCamXQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0rrbx3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 14:01:59 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5c82cf2652dso326251e0c.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794232919; x=1794837719; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VpqRFbE4DcbPh1FZMQv14KawzXTklyFyVf0uyoyfOC8=;
        b=ESiFVH19Uo6Xyx4Xwnlo1jvAiAsVHY0miRlvuAOe1Ft7KSrUSumTXj13rScVakTIy1
         SBBxCTaz1b7875C5mGa16CJk6XKJ193e71m5oXEvFRUNw/Ueyf1jF1tuMuBLls8l0DHT
         hGGgqlnYmYgkJ+slTKrZre6PXOInbtvDBhdYdnt1Abx1LGG+W/+rbuI/z6b7aBtM4nJx
         VPAh05yvTkSVopZrk5/8cQpSEQmaGajDc/pLD30fMLU0HWaks6JAwepK6g/p4LzD+4QT
         XJ3vA9D6+kPmtoGDUV4Nd0qCtNNfzJJFxxk1WyIb0I3fdRwb1FlbAlvv50eBCrF2k2oO
         kDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232919; x=1794837719;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VpqRFbE4DcbPh1FZMQv14KawzXTklyFyVf0uyoyfOC8=;
        b=vUUhMQIJOAm1QsjJrK8yCiJDv0D3W/r9T7pc3m9XYdYP0ywuQROJuJnsbFWSC+YJQF
         b3eM6d15UhhmErnVxyagucBBttro17KKbH1pnU331gVrah0tbBSQO0KMnEjd8DH1K/5O
         cBVLyyumxPhsOFS1Pb3BQD0ErxDIvYhBEujmRd4l2/FOJOMyuqNm8YPfhJ/mYHJxboA7
         HYKw/Tiv968L4CUM4aIPrJ+EujC+3OpyzsIX/XLHySCSK/PdYrq1/6O+sZK5KzrkNW0B
         qOu7hNjCmEuf7fpfXrJJtFaLNUdJjPjjM/fjk98VhUN7mOqqLcMRqvNHsAbYn2K3JAEb
         TA3Q==
X-Gm-Message-State: APuU4Z8hirJ9+KzZHECbCgjq5LVG1nHbEiXqYWeC6sUBOX0CsJDGp/KF
	ewJ+m47Fu4vLINBW5QsClJjROJ5/oyDQuBkqYp3pb8lK2CI9kvA8Cic8NUx1uvJeD/H4HuHJPdd
	DCR5hW/VgPX97XChDRUT6IvINtU3fTTQx/gqb3N1/TPwgeWf4foJ8kih4m8+ozzs=
X-Gm-Gg: AYBFou3avj4QIlX6Z1tknAXJY0OhlH2DJk+PoV2G+RXoK7lDlzjfE6YM/t48hNF4bq7
	w+NQSuxYYA5HkGrmsdAvoUTyb76wquiX+thkSsrhHx6rCp0YEeyjj4daKDx92KzTgtkAfFXjrCZ
	CKGKXqBvH+Yy0HmPL83FNvCM600XY1azycDyXzibUs13ZaHn1cDKgf2ZsNSVFSXDDPBpwiiiBni
	neUwaBW9L0XnoMXP02WW8bKEEilNivODjPBM9sJ4gWDiGkGURHElhWr/GGLGb4ioDdGwJim+UaG
	swYAHHgVZuW2aBn+tzrj8ha2WGY1Phd3nzlQxYxeNungUVKpZoG9vtbjdTh8EvrWYhZdEtpelTl
	3MzH9uTO/9PjUOZWqqcsQgsdYonrXtFgf5iHlsWz9ECzahd4h2xUzbXcPsvL7EYKxP0ao+I8/jG
	U+uHTgXAAGFYivdEKnmKgO5ePl9sFMwYdc1rWKr1A3v3xQsn2LYOmazUU+UUxkSqDo/foC2KvX7
	fUxOAlR5lVgzE2yjQ01xeVrFMvW
X-Received: by 2002:a05:6123:64:b0:5c9:a60b:e5c0 with SMTP id 71dfb90a1353d-5ece724fbd5mr1250212e0c.16.1794232918746;
        Mon, 09 Nov 2026 06:01:58 -0800 (PST)
X-Received: by 2002:a05:6123:64:b0:5c9:a60b:e5c0 with SMTP id 71dfb90a1353d-5ece724fbd5mr1250098e0c.16.1794232917994;
        Mon, 09 Nov 2026 06:01:57 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f9b5:154f:6aa3:35d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm161515845e9.4.2026.11.09.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:01:57 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v4 0/7] i2c: qcom-cci: Runtime capability detection and
 improved read/write
Date: Mon, 09 Nov 2026 15:01:53 +0100
Message-Id: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAFHS8WoC/3WNyw6CMBBFf4V0bUk7rUBd+R/GRSmjNJFXC0RD+
 HcLJsJCN5Pcm3vOTMSjs+jJKZqIw9F629QhyENETKnrO1JbhEyAQcIUKGqMpbZqaZZrkUnBlJJ
 Awrp1eLPP1XS5frLDbgjCfitL6/vGvdZvI1/aVcwZk1/xyCmjAGnBweQyA3VuvI+7QT9MU1VxO
 GRRjbDDudhwCHiSpUJAkkupxR9c7PFkw0XAj4gpGo6aa/4Dn+f5Da+ggVo4AQAA
X-Change-ID: 20260929-cci-imp-8ba384309942
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: GkK4qtXNKmtC0wtF17JjebwaOZ_OV_8v
X-Authority-Analysis: v=2.4 cv=MpfHeGae c=1 sm=1 tr=0 ts=6af1d257 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Pm5qjrwcTqiPDamcvu8A:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX7oqKGixHoKs1
 jS8EghgrAhVYKbJ4JM3q5IuCL96DfZMkKw3Vr3dzU36+Z2ZQQUbcihW+139w5pzwmole/whSAeG
 BF9nZIoqKEGuG1qyjCt3duvkTs1Jabbdn3FRxrZ9AkbXSmTDH3uQBJmrJgeg7rgEG73/mMt+xKE
 DGO9JiF47KFgNqBvKJRq4YCUstJ2Yv/6lXJgPaDorxmkmB8b8Ir1G7gHO3H0UKcHAHgpHLkEFuS
 HGAd+E9e+yRjwvzvv2Y+0KE+mOIINxc9/3ljg8gvCO4pqa9t5lfH1eKWkluJPBzjIHzVx4o/8W4
 nJjb+E4Jj3T6yDDgMS0bUCGiJdPdPkgYSCyL9SNecEtt+2d95h3OoNC/8+ZRnjI+pkJEkY/XIr+
 FPfcLNFZeEi8R0kI1YL8urMz6FKip8HAfazVV4riApnIAZgv5nRKoTREDtvPulBbqtKbnFlbCEX
 +NdLgi+eWrg6no1++fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX5dVLKKWLbgbM
 N7vDfsaY9JayMUBiAhGsEMtP7MS8ZdE5ADOGlijt73O0UXyvvDZ47QWH2cLqrNsWaCEr8yM/3Gu
 h+TNJna0nYweCg9FKompHNkyuR0XTfA=
X-Proofpoint-ORIG-GUID: GkK4qtXNKmtC0wtF17JjebwaOZ_OV_8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090055

Improves the Qualcomm CCI I2C driver read/write in different ways:

- Capabilities (queue sizes, max transfer lengths, supported I2C mode)
  are currently hardcoded per DT compatible string in a handful of
  cci_data instances. Replace the static per-compatible structs with a
  single version-sorted capability catalog resolved at runtime from
  CCI_HW_VERSION.

- The driver only supported single-command writes, capped at 11 bytes
  regardless of how much space the command queue actually has. Factor
  out the write-command queueing into a reusable helper and then add
  burst-write support, chunking longer writes across the whole queue
  instead of a single command's payload.

- The FIFO read path hardcoded a fixed 12-byte limit unrelated to the
  actual per-revision FIFO size, with a special-cased drain loop.
  Simplify the FIFO read/drain loop and derive the read-side limits
  from each revision's FIFO size.

- Add burst-read support using threshold interrupts, allowing reads of
  arbitrary size by draining the FIFO incrementally during the transfer.

Also add overflow and underflow IRQ reporting, as queue/fifo limits are
now derived from the hardware capabilities and exercised more
aggressively.

Unbounded writes, which refill the command queue while the transfer is
still in flight and so lift the queue-depth limit on the write side,
build on this series and will be posted separately.

Reads up to 4 KiB and writes up to the full command queue depth (451
bytes on this part) were exercised on an imx219 behind CCI v1.8
(128-word queue, 400 kHz).

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v4:
- Reject an oversized write with -EINVAL instead of -EOPNOTSUPP (Konrad)
- Burst read: terminate the drain loop on RD_DONE instead of on the
  expected byte count, so the transfer is never left in flight when the
  last bytes arrive on a threshold interrupt (Konrad)
- Burst read: restore the short-read sanity check that was dropped,
  now comparing bytes read against bytes expected so it covers the
  threshold and the legacy path alike (Konrad)
- Burst read: disable the RD_THRESHOLD interrupt on the error exits as
  well, not only on completion (Konrad)
- Burst read: bound the fifo drain loop by the expected word count, so
  a bogus hardware fifo level cannot turn it into an unbounded loop
- Link to v3: https://lore.kernel.org/r/20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com

Changes in v3:
- Reject a write longer than the advertised limit with an error rather
  than ignoring it. (Bryan)
- Build the command words with FIELD_PREP() instead of open-coded
  shifts, which also documents the per-opcode field widths (Konrad)
- Actually program CCI_IRQ_MASK_1, the RD_PAUSE bits were being ORed
  into the value written to CCI_IRQ_MASK_0 and so never took effect
- Clear the per-transfer status on entry and stop reinitialising the
  completion in the read drain loop, as RD_DONE can fire while the
  fifo is being drained
- Link to v2: https://lore.kernel.org/r/20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com

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
Loic Poulain (7):
      i2c: qcom-cci: Factor out write command queue programming
      i2c: qcom-cci: Handle and report queue overflow/underflow interrupts
      i2c: qcom-cci: Detect capabilities from CCI_HW_VERSION at runtime
      i2c: qcom-cci: Add burst write support
      i2c: qcom-cci: Extend i2c read limits based on CCI revision
      i2c: qcom-cci: Add burst read support
      i2c: qcom-cci: Build command words with FIELD_PREP()

 drivers/i2c/busses/i2c-qcom-cci.c | 495 +++++++++++++++++++++++++++++---------
 1 file changed, 386 insertions(+), 109 deletions(-)
---
base-commit: 00fb8097ca5a4fcf0e0cc1550075aa7313bbd32a
change-id: 20260929-cci-imp-8ba384309942

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

