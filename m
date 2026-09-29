Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA55111AC
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684757; cv=none; b=UZ1y2NhtM0DPqQPu2ADIbKhj8lWzlbY605wOt8yJ0wlRY8HR4c1kvGKyCDp0C526pg5HP8ZWkTsKy6k1kawIJPEqvWwro2lPGvP0lQebnTy/ipNZ3lARqyEP2nNoGWRIVhnmLmsvlEEC1ZuMPdFAVwrFdvwzx9TD7n00S2tJNoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684757; c=relaxed/simple;
	bh=LlWU3yBVXRRJfr+LivnTiGZtuaci3yz8ELmy/Q9s3bI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AaWGHBqoasMz0yJwHtrz7qqc/o/Xyf+sseVuenQTknYbIZ8vTXNubCTkdxKVfqYc4fNP3b/pdbfl3jBX8fJ6DxvRELgsXW1KC8d3FxsPHGRheCtT+VboLJYCJWBe3pjPwdVB+RMdHx2EW5WT2EuaWAXuME9NNgirwcoAiOEro04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ug3b2INA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JQZvACYN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ug3b2INA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JQZvACYN"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCE6Y4931794
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l+1/gp30Pqhkzp+lEQxy2S
	DB3xgsxUhnhSlDGzy4Fbg=; b=Ug3b2INArsuIsQlsI9grN5HafqFBq0+w+ZRsf0
	FuZx5dxI6t8ODWG54sWEMjRxN7DkR6qWgERVYIqst2dPg8cwiIaW2xGaWcgZoqjB
	2OCBZxtquP/zOwG7icOi6y1W454Qe+c/9g7+jkdSA9b0t9ICkTXpFwxzkmRVuqrq
	vKIgxS8SXFm7N5i7BgIP9UgaAY0U0TLMcQv+peVa298GJLE5TJroWkvnODsaXq0a
	kJ+0m95cceq5GRh6ZJ+qrcKYw/oEi1ogzLBro92zw+5u30mLeQRpRbtLiFYF053M
	ur7YYAwFGod40yjJ56Xarv5OjU1TJCJmX0KihjfWTyAHH2kQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxhx0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9123c523d0cso47351736d6.0
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 05:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790684753; x=1791289553; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l+1/gp30Pqhkzp+lEQxy2SDB3xgsxUhnhSlDGzy4Fbg=;
        b=JQZvACYN8nowSeKolZYQUqwHntQDaMR8REQXjuGb24PeFa5Bmuhc5oGO4BXtVSRVj6
         JUkWf1k0w7mHkmSAkoEv0dIx6EfwWcPzf62vW+0kFNO8XHrvDZXwfqKkJIJa7Fj6P6x5
         QxyZcRe4Bqq95TBJIzE3e1lrvlPnGA83hG2Z3X/nDWox+OD1ECDX4PKi6j7AbkjawNBJ
         eh2Xwpan0Hqv9XWjZzp+2BTES/VkHGb5sBcCETSVvN8mQMgSr/cbKNMXeGOJkdqvpIiS
         1U+bPKG2MDDiFj78AJgJDo+m4ywWCFO0B5KXNKzA0SjfAQe8shhQe3wEucXtnH3eyoKJ
         svog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684753; x=1791289553;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l+1/gp30Pqhkzp+lEQxy2SDB3xgsxUhnhSlDGzy4Fbg=;
        b=TFqwcXxK4/q7qpAqE8iY34xb1XW7NzaILGnIAU7RHAdQAofDVuH/SCtCScDZS2WkO8
         pcIvaQmukjePNiyZ08NgZfxkeupMPTRs0qy5pn2EUZkAirj58wSVlK80TFhT9YyGibcA
         C5BiCfH76pWkOdxV9mEZVuxExFWBlq5VKBVYnAd/aLW6/IvXZSRqwP/qMb3drzJ7yQ12
         /DJA0LFP+XA6ePLURsjOetxp/Eg557eLQ7e+bFNkCMXM9m1q4CZT3Fgaa3ZQvJR89n+/
         AZ21rW8PJjMyEAYMerJ3LLku+GYkePy57sfGVR3IDTZDpMTdGVUeBzPuue4lifZDpIIq
         d7DQ==
X-Gm-Message-State: AFuF++lhLTlh+yGzVVUb+T5S4dklj/vJR3+Ep7t8PRYj8XTKD7VwhUzP
	Ut5XumNMY1CabXus1JI5w71zFdwnswSOEyc1I06+e5qKakgw5u5WLvXPK8TGuyfU8pevRxdxWy/
	+/29dSfkfk2U+DS3TCLPRworP6SO2Qso+fypODX4MHbCMphl5uIM5Dg879K6bvgQ=
X-Gm-Gg: AYBFou2YmMgiNhZ7nGnuYYTZ9gbFBq6QokK2JAcPGByHU4YHl6/6QTfmZ4apqx3O03v
	EdveXGhL8cBEI9RfohYfna/tOSqeGMVkx18hlzKoYjn5CaR0GcPEniFVm9flzHGWGQy54n1HwXP
	2VaNmGwMryDYR0ZSV3gZzNFUkBCouPvdk14p5JQRWaxvZJEnDzKr2uGDrxPC13lUYdF/8iACgZp
	bAoFE7ixrUBr1WCh1TmYTayp+n1TiS3nH7IxifKDA2/eYQxgyaP9vq15jr8quCUvV1Rbq2jUajF
	zBN2DszFDTrBaQ8wp31UXkF27648AzJ16ZqfynY7sa2YaBk9uARL4roelK23QqnczRBXWIfbm8x
	oBYtSGJQ7bx8UNqxVckNWGcNfwo+bfJGoYU1ql9fLvKvWf3KYgwCumU/39D/Y5qIhlsW9V14JZq
	U/rB8r88IOOzFOeprDFxePeY64BqxfjseC99W5Tm7Rprn6JPr3LDY=
X-Received: by 2002:a05:6214:5f09:b0:914:4e89:132e with SMTP id 6a1803df08f44-9144e8917cfmr188842896d6.26.1790684752611;
        Tue, 29 Sep 2026 05:25:52 -0700 (PDT)
X-Received: by 2002:a05:6214:5f09:b0:914:4e89:132e with SMTP id 6a1803df08f44-9144e8917cfmr188842066d6.26.1790684751847;
        Tue, 29 Sep 2026 05:25:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d302482sm9103956d6.12.2026.09.29.05.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:25:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v6 0/5] i2c: qcom-cci: Enforce the required CCI clock rate
Date: Tue, 29 Sep 2026 14:25:44 +0200
Message-Id: <20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEiuu2oC/3XPSWoDMRAF0KsYrS2jqVpSVrlHyEIulWzhoZNW0
 iSYvrvL3njAvSn4H+rBP4lGQ6Um3hYnMdBYW+2PHLrlQuA2HTcka+YsjDKd8kZLxCpxv5Ol/sl
 C2sHaJCzJC/74Gojrq/bxyXlb208//F/xUV/a186opZJAiXzwSuUU3vvWVt+/aY/94bDiIy7ca
 O4J/0gYJtBGCMWEtXIwQ9h7Ij4Sloli0VudNcSOZgh3I4J6GuKYIJ0DjwBHSs8QcCPi8xBgwmF
 2MQDERK+GTNN0BncaLyi5AQAA
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX/1YMR3eEdraK
 P97dMvXYBidfLrNq7A57CkOW77fm91JBgB0zSYinJfaTEGZnDr5cpzMeIEMCv1qKJU5Hoqi+mIN
 7gpX71nSZB894FL7E1I6pGeklQ9ZO5A=
X-Proofpoint-GUID: sIV0aj4j13moDsl3LeNT9oNvgRnJs6sc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX6qNXRm9izz9E
 W2wkPThMBWSuJ3RZ4xdxkO65RH/nT6IpJJ6kJHMt2YJiuSn+xctp2El6ETIsJM2OqvQtNpwGg0M
 2JCLvjRpXWvV+zzc2bztVAtd3SpQGpbp1XpDjuQwU1zoMQLyynxB7ECa0ukxI35SIc6buEL01aI
 TIKsM/1BvYKg5W5MrXTpIOphI0MnvZXq5cqjejiswT1dPm9SADYtbWF+EX7relzBUKxnoROvbBP
 8nnh9QxLACYpjDJQxvE9wG5kb50q/XPiAO8epECEkvRwWLH2qvJRmiRIK3dz+CwwhDyc7PmbuA1
 3K9mPykJrvOG+0llSAAXkz9XPrvRykEEhzbr6dXEGItPnou5AqsjPNu5KRUBVqVlewHzDxO9pLu
 TpMQhzUkCzFOWXhuEPPb2YqZqnR8frsuIFnIuPutPRPZwI24mTwMWN8jchwN1YTEvDB8ZcX5Lhq
 kZdW+sWl+9FD4Ag1mfg==
X-Proofpoint-ORIG-GUID: sIV0aj4j13moDsl3LeNT9oNvgRnJs6sc
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abbae51 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CakdkRaH-b5KpuXxX4YA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290049

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
Changes in v6:
- Fix error reporting in cci_set_core_rate, and prevent double
  reporting. (Andi)
- Link to v5: https://lore.kernel.org/r/20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com

Changes in v5:
- Check the rate returned by cci_get_required_rate() and pass it
  out via a pointer. Never call dev_pm_opp_set_rate(0) anymore,
  error out (-EOPNOTSUPP) when no rate fits all masters.
  (Konrad)
- Set the CCI rate once at probe, drop the set_rate from
  cci_resume_runtime() and the set_rate(0) from
  cci_suspend_runtime(). (Konrad)
- Declare the loop iterators in the for() headers. (Konrad)
- Drop the now-redundant hw_params[].thigh check in cci_get_hw_params(),
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

