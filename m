Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248B481A9E
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327968; cv=none; b=TzGmWy8YQXVShz23i5V1Mfl+3gYJcqKapaSI8OLXzUGO7tXT4iY9PLXC52CVLyM6gV8Zmr27zRMbG7daSv9LAlyCQm/G3WGaZmcSa3Nn8s0tWqxxI+CHjVgGkO6oTbEO0Vks63UfiSwfxwuOki1cDklS1YOuFuHaRBAFIPU+A6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327968; c=relaxed/simple;
	bh=whU8ZnVdHQc3EGbDV+hpIHILwAmmD9P1LQUwX+C2Yj0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uhwwQtLR/KCygi9Qtf4PAWcbfJtPHvHbqFB0U7G640A0Oh0D+aTxAaq03lCkcvLqjFYK7ViP+ZWat/3FJxubGx3wAxs1eR6AAEr+34EtsdLLA0GkAyLhLJsWFkdTCVbfP7z6ApF8hem85L2hdivIOjKw/SqfsK6/xfPfVqQrgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VYcJdh7+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XW2QjX//; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VYcJdh7+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XW2QjX//"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TCO8b81814510
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2eZkTxudWXqdBm++2Ln9mU
	EL1m4DSKmpFCXqEzBZSV8=; b=VYcJdh7+SiSnl4tpfSvWqFZiFpuqsSEoztJZqP
	EN6MEbNmQ0WZy1//q7IUn21itvgdd10gS354Ikjov+pfn5SxTleoRNOUWGFUk4Ho
	mXHF1DUXEw1W8XnpB46DSLLJ4ZoPz3eDAu8WuvhOxrycHd1l/7pJi75pyodFt8cM
	gWH1kWnDifoiAUYzvtmXlmFkWCisdndncp000XFTzS0rCTveXmYaW3eYpyLKK5cK
	HNgk9tg81SHRLWD+T2rYu9asom/Ku62e5mlNh59BqU+AUDuNQVjUlTFn78C8DBgf
	D203x4NFDgGin3MfrneBAYgZLsbdLrvKT24C9/62AG1OV8yw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhg8r07k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0408254aso3204661cf.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785327964; x=1785932764; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2eZkTxudWXqdBm++2Ln9mUEL1m4DSKmpFCXqEzBZSV8=;
        b=XW2QjX//x4BQMcJn6xbopGS8LIvinf3BgEAQeCOiooICp9q/Yj8KKXkMAkVEwakdoJ
         khZ8hLKFJKJ1AOC+eozaRK+xx/oA9ZJmB3r2KXLbuaGOCSYCXxOJhQ4aZsT/johWnJiY
         IFEEZqb4t0G1ChFikF92oAR93b/OS4uIwJc6Czu5+Bvwr6hRESbvGSHMo7rdHQY9Fzxm
         UT8S2OrYsvuwXQuzqWCEinpKlkQOLd7e5WPdo3K3UkLIPrbOSxPB+RVMPAeqrumPhEbj
         5FBKyiAYd+Wg6NdJRobHMIfvaX2hlNjZmIvKOrOILAfJoVFJK8dEByf+DztNRemjGenS
         s0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327964; x=1785932764;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2eZkTxudWXqdBm++2Ln9mUEL1m4DSKmpFCXqEzBZSV8=;
        b=pq+tiXYL00XhbTvXPQRwNuZDeYnxwf+JZFsId9z3YLIAGwnRK1Ne3svNZwXoSJkEsG
         utZSRY41EB2G9YO4Xp4IU0vS9uiZxM/izwyppXwA87i9/eKWiJpfwRhfPhoZskmGKoaq
         PFDQkFmj4tmVTtGbjr8cdlWIgYAX0yccPQhX8KNux2EFVJeCRxoYevDlxeTNJdVv+RN4
         i3I91cyQ8Ono6gaMj5yiIJP4Lswd5KlHMuKCJ7kvFfv8Bs7c3UNp0uM6NEMun25NWO3S
         zWuwWX6RJZsxCwI5vi8uyXVySqvvXU6WTTBeF7d1nc9VXqAa3V8LKIMxdqdmkNJpwSDK
         g1og==
X-Gm-Message-State: AOJu0Yx8Is2YfnEVFJfvK3Ufwrw5VvbhYJ+G41tecFSZ3tvVjialYRYd
	3yaMFazIAqh1SsWFAT8DJt4GD9Bz4B/wr73okt2SaSeQXcuYZf1R8K7fAkJyAxpltFqU9yCEKih
	7lOh2tVcNsuDo4uFJyXVrg/+PSAOZxqwNvmYnO4RH80WZv1Z78xu3YjakpZfdmKw=
X-Gm-Gg: AR+sD13iMC+dYEmnBxVkh7bGPfKTSnZB0yCcpVYk0Vo6OE1PUmsqoqSit3gkCmpUFJR
	9n/UgTtooMWXMkTPcLZPRYvWAJO5z6cQVmoildSpKu8ifEavWVN9D2GxCJVJc533A/NvNCj8IBV
	0fA6jKUv1ptT3a3DRrcRCiiYawa7Bk6DgBrPm70qwVfj12abBENS+mv/3bnNRE3VhsGbywNvF9Y
	ZqalB8sXkYAxlTUF6z4rDGDIIwtbpPpfPvABOOdrSmqdeirC7LRfZYwDJSz7aXY6yndgy0bwfcB
	2odoLaQflstzThwzN79kAsZU7ZJE94JxIVvHlaRcDrFUvGBOe2aSHAbDHGf3FtdJc7DqIyW2Rs3
	JQxwcKmMRUwbChNXQz1XBa2XJlge5bN3DTgrw7G2l1qbLHU7L2iDk6MefUKqW30pFEuKkfox2zI
	IwSvCy/ZAnMdSgSTEoq2I4nTdN4vAQmqeBYez3ajVkiOYVJ9eFlHaT
X-Received: by 2002:a05:622a:148:b0:51c:1f35:4638 with SMTP id d75a77b69052e-52b2adefbe4mr16081611cf.21.1785327964296;
        Wed, 29 Jul 2026 05:26:04 -0700 (PDT)
X-Received: by 2002:a05:622a:148:b0:51c:1f35:4638 with SMTP id d75a77b69052e-52b2adefbe4mr16081341cf.21.1785327963855;
        Wed, 29 Jul 2026 05:26:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm756343a12.23.2026.07.29.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:26:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v3 0/5] i2c: qcom-cci: Enforce the required CCI clock rate
Date: Wed, 29 Jul 2026 14:25:54 +0200
Message-Id: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLxaWoC/23MQQ7CIBCF4as0rKUBWgRdeQ/jgk4HS2yLghJN0
 7tLu9Kkm0n+l8w3kYjBYSTHYiIBk4vOjzmqXUGgM+MVqWtzE8HEninBKYCj0N+odW9qkdeyEQa
 sUSR/3APmedXOl9ydi08fPiue+LJuO4lTRiUaVFox1hp98jGWj5fpwQ9DmQ9ZuCR+CfVPiExAd
 ZDaCt2wWm4Q8zx/AXYqL4/wAAAA
X-Change-ID: 20260721-cci-clk-fix-fe145b2acfa7
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX0tCKfDJ4h55v
 58nGPuvthI4oYMyEqWY0K62zT3jDs2jof6XQYYeeZQWbNOJRvP8V1blw43rHkNCzQsMzxriLUdC
 sKJzk1+cEd5xyxQLOielcnPA5iyZN6M=
X-Proofpoint-GUID: d0WSneaZno0nvn-z96R6wJy_EkygYd3r
X-Authority-Analysis: v=2.4 cv=LOdWhpW9 c=1 sm=1 tr=0 ts=6a69f15d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=BDIs8drXFFqd0dwbxQcA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: d0WSneaZno0nvn-z96R6wJy_EkygYd3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX/AgZCmg40+zE
 R+teLuGwe4if4/7qJCPZ5nMiRwYFFG6r65/O7ebX9MEz4VrYAAKkKvMfs/MxWD4eMME3uE3R8mf
 VgsnFZ0WLYjjBhlO7aJiPOnikvVFHGt4ekpQCHzwRpMGwRyzOSG4ycm3lGWNSzjTxMDnLzrvAki
 Kf7ZeGzYdSuDQIYEbyaWZHe6JdlRWSv4BZWm4aT2lm8+Ee7zfuJmNgG5I9rIIbSxAoVMBYu6IT8
 BBdPIV2YKnIwgQg9evcvuK4A0Jm6sfED57aJGFuAqZ/q6J9+BHGb39RpC+yuTdpYorqNuN1gOdS
 75oVDxgBzXzzN5SPaLY1fjUv9sJHtN0nGeXIJKVO5ust+sYXscL4poxf/J6WB46QZuUcKFdueE1
 aa3TLbZ1CnCfL2UfoqKj93mNJiLZDsAIlmOwspjVJ3tLQRfq7YZzlhRESMxWaSJ0eI7ZJGI6JKg
 YbivNrcHtap3LLLPMiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

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

 drivers/i2c/busses/i2c-qcom-cci.c | 333 ++++++++++++++++++++++----------------
 1 file changed, 195 insertions(+), 138 deletions(-)
---
base-commit: fce2dfa773ced15f27dd27cd0b482a7473cdcf2a
change-id: 20260721-cci-clk-fix-fe145b2acfa7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

