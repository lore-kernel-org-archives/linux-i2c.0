Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B763ACEFB
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615054; cv=none; b=uh3JO/wX4Rg5HXVITjseQYBZQa+1U91wPNEHZ+lghNNHBk9cFgysZgwF3T/mt/e3F9/8Ga+pS9zp9GQ7jONRGMYrS4Fxo2cN7gidAOUm2hKvGFyxWN8aZSvxTQA5t30/WBarinVOKfxCyUHFo7mzMRvIMKxyN2zQA15WedbvdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615054; c=relaxed/simple;
	bh=22+zTcgK8gKfK8bb+q6OFUiVpOFTKsJSlPJvbRHYQGk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XtRJodPKKxZWKU2b1+r/WKZd7CoAabzRYxaIQ4cnTobUvWx1le+CTvoupErXS6QaByB+j0pn4+XEm7ctfF9otMuZdC+6nqbUBLOgS1y+viXXRZd1t28unfHAQqjllglHPsBq/ZBoEHjwBbcMGWSkA0Ajds/XHmletAlitg7EvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoP6Rlu6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WMaJpwU7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoP6Rlu6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WMaJpwU7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671J01IF4014109
	for <linux-i2c@vger.kernel.org>; Sat, 1 Aug 2026 20:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jKyjyTHl2oXoRPvQdXSPBF
	szW+NcfRowoAcS6ytu1Zo=; b=UoP6Rlu6RMnOeDBwCOzo7/DVabATILOEY8WDcF
	BwMBg/a0epxyReD18GJy2zrSLxEGqFys3uQujiikBC7NasQgVPXoHGP1CE2eiKf8
	O7P9WC0ww1R2yJ25DxJPdt5y9Fu6tLzb29TOmLISTKYq0jSPeG36ZFEdmFppwVVJ
	s/dlwNidNe9H0OQ8lik/SEsMgbO3hutdqArKTJduTGa2IDZmYXEn/M0bzzLdYzfG
	pPa7QPeE1XQZLBFfxsjaL4/7/Juu0zRMArTK8+Q87Ri/+xY19w4ZX6PIBqx7J3VD
	tCzIG25EqsrOYL5bKBOWe9j6OJ1lPg13TKkXMxeW1QHGbf2A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8tx1n2f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 20:10:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ea75996387so43573366d6.1
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785615050; x=1786219850; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jKyjyTHl2oXoRPvQdXSPBFszW+NcfRowoAcS6ytu1Zo=;
        b=WMaJpwU7dRb/j9CMOcsthIheHhicVXK9OFrMuWVurfB58zsbOoEQNWUtsi2MY5BGVX
         86H/Ntig0dtKoXQhZIqxBOCPsP1DDRcvt/AgjppQ0Dx57yTEFy+H/k6WcOOEhXO+pewN
         Bm0OjMNl7ie+CYWFcdwENkP8N2FhJlySFgjCPtjZXvRyMOIDP50g/vRbzWZ3nVC2ShQj
         9Boq8JE6iCEcLA1zjTl4uDFUrrBjz9wVVqA94wyMS983ED7JpsdU6A+/V86f01W4dvSH
         7xZWuMHmPdqoZUd1lRet4I97eeSuSFPC41axlj8KwbqW0NRGrpTeLNvoybbFTL57EZ3a
         lVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785615050; x=1786219850;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jKyjyTHl2oXoRPvQdXSPBFszW+NcfRowoAcS6ytu1Zo=;
        b=G56soNVjgrDiMle+cPb+0HWwYTTY7MOlEnoRg/2pban6I9nVe3VyPAQGcd/ilmR7t+
         mVoupFB09c4lzRqWbWSOrqcv62fHEh5skjc3tJQa7jUckDVJ+DS9QyZoWzpsmgabQ3mb
         HN3NBy/6Lo1MxBrNzEbuNJZ5MMg6i9uOlzJujSnECrGv2GNvee1R8lyBNSEP6UEhzn7r
         IQsRy9Oyycs6HuhFzyMPBt4w5zGbRO/USnkIEyGZbNoahHyYEjU6CZ+vrfe9iWdPkZPN
         1PrcychwBg0XgXWzGD0wIpdpRM+CZPFWw1G3HB9HM0UB2jqvgEqK54+8S4/O2YgbvMpt
         85xQ==
X-Gm-Message-State: AOJu0Yw59iQg7fOFBOvFeOO44brID3qohM0gRgs3qRXpXzajLQulC2Ts
	jct4JIQt/gANznqHdtUaPbzEXUVKQlvfI71QIsslgTOKL9tLD3SUqxfHuXzL7AZ+OMQtFjGNtfp
	iWlE+jZ1EHBz+M4UpAoaxkKbyXTw2vBawEZF9fj0sRQhwQDOrYaGAlIBw0AwoOvg=
X-Gm-Gg: AR+sD13jcULqbUY/wBH7On0CDjybyDEeutbusq0VDkeYE3LEgTAPZflVfwNETNU0G5y
	5jTCWjAMc3Wog2WC0cOSEORUC/3Y4XZfs4prn/FxOKFus0z9MwWTSAi950cL2T6jnlKwLh9w4vV
	3OSEOElxpaHfHVfOwMz9UYyyAV25VdSB+c6XTdvqLUBYkFeJqWAsw900XMBKoQhHcTwyB1EhQB4
	m8Z0ld0+fAipoprnK/PXkeTa3XRcJqrS9G9Q+by19RxbOiqufpk/EM+VcMFDQEN8oUq245oX4cL
	098lsvYj5BEHREVf8WiC24P9osS/c5pRwOFc3tlbDMEP/dUq6H6U2ZgT4EfcPooldnCGkyNKU9J
	iQywicRAnl1a2xEnvGpG0wIsJXDVYWKxKSfv0IBsEIKHG1Cz8hVa4LQy4hfGd8zvte2ob2UxDjq
	rkoGAL20qyVrYfY0FQm2OBuhZVrOimqSG+3TccLpt/E66HmeRmtErr
X-Received: by 2002:a05:622b:89:10b0:52b:6543:d8a with SMTP id d75a77b69052e-52b654316e8mr27140791cf.26.1785615050422;
        Sat, 01 Aug 2026 13:10:50 -0700 (PDT)
X-Received: by 2002:a05:622b:89:10b0:52b:6543:d8a with SMTP id d75a77b69052e-52b654316e8mr27140481cf.26.1785615050027;
        Sat, 01 Aug 2026 13:10:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537755sm358499066b.54.2026.08.01.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:10:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v4 0/5] i2c: qcom-cci: Enforce the required CCI clock rate
Date: Sat, 01 Aug 2026 22:10:42 +0200
Message-Id: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJSbmoC/3XMTQ6CMBCG4auYri3pD6XgynsYF6VMpRGottpoC
 He3sIIEN5O8XzLPiAJ4CwGdDiPyEG2wbkiRHw9It2q4AbZNasQIK4hkFGttse7u2NgPNkBzUTO
 ljZIofTw8pHnRLtfUrQ0v578LHum87juRYoIFKJClJKRR5dmFkD3fqtOu77N00MxFtibklmCJ0
 LwSpWFlTXLxh+BrotoSPBGGa8lpQ0VVwA4xTdMPDuMTFzMBAAA=
X-Change-ID: 20260721-cci-clk-fix-fe145b2acfa7
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfXwhMJxBfHcEaT
 w/sZmoM/E0TYb/oRfN5BcCFXDf5IZiBS/DIiapAI4byhIWFiJ1pNDIrTCExQaQwEdYpwftSRkVn
 rXI1i8/jSCirtOBx8fjYmjEXZHvcJskLEeqmNhhtYr38OIOsBSvNeP1OkPhDt7pRJ8ZcxRlWzH6
 cd5pgteiIE5qOGTDKFn8tntl4+HoNspE/JnM1IJR56uRNdfk1RG2lXNB1Xpv+qOQtKsrkIcmXFM
 xQu4iy2sVYGd8YtrRWwn1ZxT8pnZWuyencNDvhuJGLNCEnI57tet353Wqn2DarztPEY1h1m6rw9
 lRVOJM5s4vhe0waZN+6P6ocO0RF4SjQd2RwkOPTSiqU+ZTqAJ5YnY1DR/Gyj+oXK7vQxDQLSu6z
 xeBNzW7klLLZa3H/don6uj+jsUwkuYaiaxRtc3P3H/CIBfxoYbOja5JyiXKaf7hpjD5pvgi89VD
 BHwbgsc5WybxCeqm9dw==
X-Proofpoint-GUID: xEr8fNCu2rh_-0e0njr1SguA8qcCCnTG
X-Authority-Analysis: v=2.4 cv=T9C8ifKQ c=1 sm=1 tr=0 ts=6a6e52cb cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=BDIs8drXFFqd0dwbxQcA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfX7rV/x8kEiNvR
 SHNbQF25IUj2AgYhRxI7NoEipjRnygiogPupAsoexxKnrfyxhaVokA7I8czf5gUiS07twvNkVDh
 yAtaSjPsDUP3cP1MVppOyLHstg2yXNk=
X-Proofpoint-ORIG-GUID: xEr8fNCu2rh_-0e0njr1SguA8qcCCnTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010162

The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
clock ticks and are only valid at the specific CCI clock rate they were
calibrated for. Running at the wrong rate causes incorrect I2C timings
that may violate the I2C specification. Today the rate is left to the DT
(assigned-clock-rates) or the bootloader, which is fragile: the driver
owns the hw_params and should own the clock rate too.

- Move the msm8953 to reusing the common v2 config.
- Turn the timing table into a two-dimensional [mode][rate]
- Add the 19.2 MHz Standard/Fast timing sets for the v2 CCI
- Promote v2 to the generic common table for all revisions
- Actively enforce the required rate.

This ordering also addresses Vladimir's point that the clock rate is a
property of the mode/timing settings rather than of the CCI revision.
the per-mode [mode][rate] table lands first, and rate enforcement is
built on top of it.

Patches 2/5 and 4/5 are the result of discussions with Vladimir and
some code sharing. I would expect him to add a Co-developed-by and
corresponding Signed-off-by tag if he agrees that the submitted
implementation still matches his original intent.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v4:
- Rebase on andy/i2c/i2-next (527dd7fb6209) (Andy)
- Add 'select PM_OPP' to i2c qcom cci Kconfig (Andy)
- Link to v3: https://lore.kernel.org/r/20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com

Changes in v3:
- Reorder the series so per-mode clock support comes before rate
  enforcement. Introduce a [rate][mode] timing table and select the row
  matching the running clock rate. (Vladimir)
- The per-mode patch only validates the running rate (error out on a
  missing entry), the following patches enforce it.
- Split the addition of the v2 19.2 MHz Standard/Fast timings into its
  own patch, keeping the [rate][mode] conversion a pure refactor.
- Drop the "Revert ... Remove unused struct member cci_clk_rate" patch:
  the per-mode [mode][rate] table replaces cci_clk_rate entirely.
- Introduce a common params table (revision agnostic) (Vladimir)
- Link to v2: https://lore.kernel.org/r/20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com

Changes in v2:
- Instead of adding a 19.2 MHz cci_clk_rate for msm8953, switch it to
  the v2 config (37.5 MHz). The msm8953 table was internally
  inconsistent (Standard/Fast for 19.2 MHz, Fast+ for 37.5 MHz), so a
  single rate could not satisfy all modes. msm8953 is the same HW
  version as msm8996/sdm630, which already use v2. (Vladimir)
- Remove the msm8953 fix tag (Vladimir)
- Apply the rate via the OPP framework instead of a bare clk_set_rate(),
  managing the vote across runtime PM. (Konrad)
- Link to v1: https://lore.kernel.org/r/20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com

---
Loic Poulain (5):
      i2c: qcom-cci: Switch msm8953 to the CCI v2 timing/rate config
      i2c: qcom-cci: Support per-mode CCI clock rates
      i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
      i2c: qcom-cci: Share the timing table across CCI revisions
      i2c: qcom-cci: Enforce the required CCI clock rate

 drivers/i2c/busses/Kconfig        |   1 +
 drivers/i2c/busses/i2c-qcom-cci.c | 333 ++++++++++++++++++++++----------------
 2 files changed, 196 insertions(+), 138 deletions(-)
---
base-commit: 527dd7fb6209857f8ff4426055b3a418e60faa8b
change-id: 20260721-cci-clk-fix-fe145b2acfa7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

