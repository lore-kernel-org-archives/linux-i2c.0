Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23B3E5A2B
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515798; cv=none; b=aIcsqhZepQbTVPj75LyuQNv68a7sSFm4mRQU2Iy9599MDlDoH6+nHfQ8wwZtfWqC1QAcnc+cqYUA9hoS6xmQZJ9BEjajmFzOxOM5jS7IS2vhhI3WFdVjE/JqsxprkfurISC5I0rSe0awnymIM+P2jp43WgzjBQ4ij4CVfETB7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515798; c=relaxed/simple;
	bh=CSXU+uGibWfyJfAVlk6Ie8rPbDeL9xwULj92S6z2pSk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tK7tz/i2IKuKp1vT15HqZkgPXdOAzo8LRAtdY8oIWBNq8KfA60F4gpNuPKWH7uzz3xRwhb2BFVB3zLf+ZvwT2qoVRlJ0HTgClvcGrfOdxHstQvAD27yOqI/og9glR/XOLJ1l79cUB83CEU+507wUoeNjNnMWkjNRZ4heJX+wvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XX26TeO3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHmHjSn1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XX26TeO3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHmHjSn1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RAC1kJ3506648
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TQFlpRLe6U7SwfWR6ZtQDf
	0jbMJGb6d6UWV3uD3alro=; b=XX26TeO31zf9K27bapuA4NRLfAYK04W2O1yZjA
	4UKGUSCiigYJZI8whtADSY5W0+LnAU0wP931TOcxourtrfO3oyXUDGHNU0OYwiIY
	uwrQbGk9bMx4lF3pQZuXk4lcOaE/l2/nD7J+SgR5ZC4aaLYldjRpZOjwwurFQBkh
	vu7pexqS582JrZJ4tXJVEPyLIOTa5fYu0ZBTXSPlJLbbEVU2l8WVlXGyK/uqgLuI
	Quivklsaf5NmR6SXJqZFFzMYUYKPxg9XLfmmJ4bYPEGKK8gq+Gc7buiPvkjj6P+q
	ltJP12meqrH4GVFEoT+cGFX6F6i5FbqrTGk3uJccR0XcKINg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfuark-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9106fce784dso46410396d6.2
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790515794; x=1791120594; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TQFlpRLe6U7SwfWR6ZtQDf0jbMJGb6d6UWV3uD3alro=;
        b=XHmHjSn1lPihpG2oDNF0IUcFe3b1k/cQaxjmK2iWFiyNlUOC7xpQrTMHU5lfNogjqH
         mPRuC9d8l+8n58qy+Zhv3mlDO3SqQdPMNJTfZdoAFR2C0dufmyHst6cLknpOwcCVPBYq
         zUwdnA95sZiwLJtPvff1x0vZV86aP1QUR8dZrIqHpNB9d8Yw4litSnepQj8zq3K1F1E6
         URcq8hoEW8flH5/Jy7cgt9pzetLYn93xgTgjlJHq8QQPUqDJBLHnvvdklc2/0FZFEoxy
         rec1ynvk4OSS5aB3R5zWXoSE6D/Bp2vTyRfVPRDsafg6WlFu/mSjEmGXNK3/8t93bfOn
         nVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515794; x=1791120594;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TQFlpRLe6U7SwfWR6ZtQDf0jbMJGb6d6UWV3uD3alro=;
        b=zMECr4/Qeg4Eg82AqpL8xrH6vA3x6Gcu9Xqu9REwgqX2/WN6VVPO/071AOF5sDraT/
         nz8XBWkTNQvRzXVwZDreqTSu3KXlgB8U2DP0PnDqci5u6VuIdb4bL4X3fSuOHyF56lHJ
         1d7LGP4CH1zgBrWkxqshAMp+NRY0Xp8/o8FsPjxRqZD5gYmHVUpg3WoWtrsKdfsgFgKZ
         us/OBTKUHGPPiKJ5MyB92/7Y0LxuxKAHQrZ9O4KNaFhGKra2TmHTeB8IVEqOQhevYt2l
         0LrqIX0dXC8uLjl1L9+XKYGuOaNyzYlfsrTLIsd0/ZZdY+ZmIBkhQ6aV0ZUEWQd9jQK1
         97Rw==
X-Gm-Message-State: AFuF++mUrcWXedQUWZR9pyC5G1nfdWoIqtEFNoikUAIEu0TJ4sqim/Fn
	3OUJ48gOR2WFh1+PfDLMG1uEKIZoD+iI9kCdgVepOSc9Ea+UrdItrs1vRdw9lR7Zyzn0K1vIVbd
	YEyBnYHx3pSYUldqM3V6WYrir8DX9utntQccaQzkN8oKq1bIgM9YH+AtXxoENxF9Ead68m3UFSA
	==
X-Gm-Gg: AYBFou1ESRC0TnatCDA/3yYWb8Ipo3T8dvl2NKlZ+zZBEPrc+ELaPI8aDYDXxVK6S7L
	dDSO0QWqfmCPH9ZICXm9fi9DrPWAaCyqVbbl3SUIVJ72y2hX/PlVa34zcEWGApPMPuG6zFXuzOd
	x4Pq1DnXlNrAorZopRtxiEqbf065Dy3HQ0oswcHDtqOnv0VGceHEAdh4FdCMqBDPnzKK6rgKwUr
	YsZSFOK/n9kodB0lg3sqa4d7hrLbIsDqauzS30w2dZaSFNLo/6VVSWJ4U4o1VvbBjNjSzoK5ts4
	sYdvgaEOkjfQ066US9PZFypk+x5K6ugdBSxByiThBa6pIMYGb4LwXBq3pFU5LZ5I9btLw/b/jts
	t7YuhpFM1yjSs6xqvJZKdkALwL61CjLXpLZdye7zlDeJJr9RnCu6reBN4FDQE+f+50FAFwxtIbJ
	l6IponeJL8wLX2sLsbUNCkR/cHFn71Sag7sm0OHK31P74JCsuSzII=
X-Received: by 2002:a05:620a:1b81:b0:93c:65e3:dfae with SMTP id af79cd13be357-93c65e3e490mr629249685a.50.1790515794091;
        Sun, 27 Sep 2026 06:29:54 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:93c:65e3:dfae with SMTP id af79cd13be357-93c65e3e490mr629245885a.50.1790515793577;
        Sun, 27 Sep 2026 06:29:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm94636745e9.15.2026.09.27.06.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:29:52 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v5 0/5] i2c: qcom-cci: Enforce the required CCI clock rate
Date: Sun, 27 Sep 2026 15:29:49 +0200
Message-Id: <20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4auWoC/3XPTQrCMBAF4KuUrI3k16SuvIe4iOnEBm2jjRZFe
 ndHN7ZSNwPvwXzwniRDFyGTdfEkHfQxx9Ri0IuC+Nq1B6CxwkwEEytmBKfeR+pPRxrinQbgSu+
 F88EZgh/nDrD+aNsd5jrma+oeH7zn73be6TllVIMDYw1jlbOblPPycnMnn5pmiYe8uV6MCTMlB
 BJeltoGYfdM6T+EHBPllJBIBOmN5BXX5Qr+EOpLWPYzRCEBvLI4QitgfIYYhuEFVPZV+HYBAAA
 =
X-Change-ID: 20260721-cci-clk-fix-fe145b2acfa7
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfX7b74PNLlV1hS
 qG2YDBs2kXA1+1BlomiyM8yuidsxcBbBJ7wt+YrilwPObw+w5wTP79evE13wX591jZshNiIj2CT
 /3Hh9AqKQQc8j26M5p6wcAaRhi5y9KM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfX+GnhwMRvKRoW
 Xam/MmuBfZMezL4Cby3w99bERe5+JhOIU2M7tq3aEAl6t+UU/aL++0KVhtpMs38DEVmwipBEKQJ
 kfxTcRqcJyuDQWwTeBQIG+xZW2zakKeX8OXYybkIrLCkgZGk1mcAKilGnjM5UyhHg/0W8pdnqNy
 6Z/sH2sK6463ZllO5dOZf5Cb7lQmYwXLSK0Ojli8I/OaQQXu4RhKlekcRzoyFK0DGN/W8yA9TI7
 CM2ZV8AvH9As2zOEpf5qQXDSrFf0hUQGw1BMRhmqfinWTKkPekLXnkyGOawYvI3gvvPKzoRCQOf
 oH8vyVX1+WsVdTp7Cq3J5JUcuBsve+WGyA+LKoR4gQqLlY4cQUSBNt8n5SXHF3+E3X0Vrnhxf6W
 Adwe2+MKDwwXMSuxNqPUZK3Z+O/FBdV4BJrEPm9x4pFTBMrb4MK4CKBVjf9qlXCQ9F4AsXGzw3t
 Fy5YemHQIPJCvz0aeGQ==
X-Proofpoint-GUID: Dy3bd5x_ouM-j2q2JxxKg6nPZn5Wj2xD
X-Proofpoint-ORIG-GUID: Dy3bd5x_ouM-j2q2JxxKg6nPZn5Wj2xD
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab91a53 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CakdkRaH-b5KpuXxX4YA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270053

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
Changes in v5:
- Check the rate returned by cci_get_required_rate() and pass it
  out via a pointer. Never call dev_pm_opp_set_rate(0) anymore,
  error out (-EOPNOTSUPP) when no rate fits all masters.
  (Konrad)
- Set the CCI rate once at probe, drop the set_rate from
  cci_resume_runtime() and the set_rate(0) from
  cci_suspend_runtime(). (Konrad)
- Declare the loop iterators in the for() headers. (Konrad)
- Crop the now-redundant hw_params[].thigh check in cci_get_hw_params(),
  cci_get_required_rate() already rejects rates lacking a valid timing
  set for an active master's mode. (Vladimir)
- 'v2' is an arbitrary name, not realy hw revision, mention it. (Konrad)
- Collect Reviewed-by tags on patches 1-4. (Konrad, Vladimir)
- Link to v4: https://lore.kernel.org/r/20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com

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
 drivers/i2c/busses/i2c-qcom-cci.c | 332 ++++++++++++++++++++++----------------
 2 files changed, 195 insertions(+), 138 deletions(-)
---
base-commit: 527dd7fb6209857f8ff4426055b3a418e60faa8b
change-id: 20260721-cci-clk-fix-fe145b2acfa7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

