Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946940DB42
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833682; cv=none; b=LEodz1MnQ7qWzm9oJTmZbvTN52YMGVgteXuNIoYg0NozxLYx94KDibqIvC88vpJ1RTLNhUnXG8TbZ4R6EJkzmKz93xXzy/VzETsJXQhtJADTUTfs0N4URVorHbPX2VAkWecEfLz8fIzVwfe6gKfzqMu6GCv5LrNnCXxQFsxZDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833682; c=relaxed/simple;
	bh=9svXqtqyffmCnBi3bJtEcbSBLp3Ou2cJhPq5IW5GGrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I1QX4HEZyykUDRSrN4aPeMg/zGvjYcj/vmmGsBRZf+WnaMcI0UujsWhxDmH5XY9/l9w21gdKFe/gf289DUtIPOZCHVCZfauqvHsy6+Zs51SmFBYnenmR9wCkTGyz7G069q6y+OcNUT/V6U8sZmYFZ5Z1yfRQPvApXO4aLoV8wuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z1BJ8fDk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hg9zT0pd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1BJ8fDk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hg9zT0pd"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCC5Hb3803113
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 12:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w5+eiCY9p8RiiqYomgs4p2
	jL0uYjh7QF17bPtKi+vQI=; b=Z1BJ8fDklddY7/ZpD9p4X7Iw9GDDZHBqhdrIic
	AI4rLgiZ65suNYd+HLrtG7jqeAgVL7qRuiP33+KWc+LYyORunCcMe7Kxq8WTCvBZ
	LPTM0IVZvZdZ1PS0akw0otjNouEYc6hXyZRVP35Bk2DcQFFekf9mZATNyRafhos/
	3wvNPXwOv7HRV5+kfrPPJPgmusQkpwPbD6TUIW8j4PBWmU8SN4XN1diDi3ZnwaO6
	5+vWi8jzFJECsYFJmYPa9U8m21H+7LSjHmoZlw72baHG5w8yOwuDNNaQknPfiz5F
	2I+RI5qrw35CwI+rbL2G/m8sTNKYwane0ZuIXZPuO/p7c2GA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak560fbb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 12:27:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so2918336a91.1
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787833678; x=1788438478; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w5+eiCY9p8RiiqYomgs4p2jL0uYjh7QF17bPtKi+vQI=;
        b=Hg9zT0pd0gf/o6MqqtubxqQkxI1uyvwzMikm2Y31BsjJyCuIkwlDek0upIdeq1X0T7
         tljQtL8xgZUqO4lnWgCvRYpBFXFP1ooaxj096SgHyG2IPNIaPCryOmxAhTpUnv/2B/wF
         lj92WFXChwTae0vN0Dn6pV0M54Ty9EyuATPC8eZSvhLQ3cH4R0+XmNZ2udSg/ACrUWIH
         qy6CzP6ZuCrp1b8Co5Eghpqjm/0Yv5338eouZP0TZcMgatRQmgcprIwKc1PVJspBQrlJ
         hUyZxVekjBw+VW+10fetvqUeR5dia0579UgO+awdYRXanbr3wF/1PvdsOlR976rgigoH
         R9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787833678; x=1788438478;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w5+eiCY9p8RiiqYomgs4p2jL0uYjh7QF17bPtKi+vQI=;
        b=NxxxVfD6r9RT6VePlL4tvniOlX6rMFFNfqkDnYjQt7BG05M4zQKH/9L3HXvZYtg6nJ
         RD6WTZJ3OQX2HLGX0QMc7TS7TN/hwFWt3/idgRcHLWpbRHe/Q1v1EQVrGZtFEKFi9PRg
         QVQmDw0ZyOja/KQIj6bLcg/Pet6yb5WwK9ND6Rqu0PJVE1ReuXPJ3juYerA/v1VkwMsh
         Pz2wFl+Cbcp+1eBrpc34wg+Mlb6A4/C7yB8PFDwHn5tgKCxm2MQ1fkF67aFgAZGIuYk5
         +e44+0RwOEdSQ7QrhJskey+dfqSiDBymEowJ7XOqHszwOVTkWhKT8Rh2/uqsDy20Mp28
         ZcTg==
X-Forwarded-Encrypted: i=1; AHgh+RrpsHuqP3VKbREcdpXLMj0gfsweYiDv92T/fK08je24syxCBZXH6FqKyvQCPRp1M0lYsMW+njkQqDI=@vger.kernel.org
X-Gm-Message-State: AFuF++nYLg/D4BvqjxkPzVjVVlZ5xdVc0dCfDuN8TMTr3c2W9DH5d5F8
	n5+rsqpGASocqWyYG4FzHmyodcr23SOB8YnG4HCdORSCUEkJm4OPotRz0UAst3TChypusJ9JIjC
	3MpQAvF5NEb4IcE6z3prUzMTUYcAvRu4Ofmm/ytNQ6ow7w2Cy9XxOlOADNp/9Hxg=
X-Gm-Gg: AR+sD11AhxxgrSC+4h0kGg4H/vA7twLjqjYyYxaRsRUMboYZiQBIECs3UZVgqVo8/v5
	XEy7Pwt0DWF2NqQQhIqZOM13z/ymywRIZSzBEMtQU/q2lYaUo0yXppBjGAjTmuAGRRRdERs7HQP
	QyaJym1x6xEsBVqU4DJRw4oqbNeMbpQmbJSS8UJGFRRaCk+wexe+26nIt9DQ225CIEYT08iiV/S
	KbXvFLdM/iI8hZbNtZVvbgY6C/l+uzWzPA/QTYRpdU/OFuK0xDnoHkl+1aIp5DnLN99XET71LJo
	MfE9JlIZ8SZ2TX7RPNEMhTK0+DqZO0mvJqC2NXZ41XQABaW5EgIdV14qD9EJWZVtW8JJR55OUc6
	pK6aRCFr4g1cF+PX4k0SGODMCckxqn8eEd9w=
X-Received: by 2002:a17:90b:3f88:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-3966d207838mr33034151a91.7.1787833678188;
        Thu, 27 Aug 2026 05:27:58 -0700 (PDT)
X-Received: by 2002:a17:90b:3f88:b0:395:f0e8:9e13 with SMTP id 98e67ed59e1d1-3966d207838mr33034001a91.7.1787833677640;
        Thu, 27 Aug 2026 05:27:57 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm2707690a91.6.2026.08.27.05.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 05:27:57 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH v8 0/2] i2c: Add dynamic transfer timeout based on message
 length and frequency
Date: Thu, 27 Aug 2026 17:57:49 +0530
Message-Id: <20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUtkGoC/zWNQQ6CMBBFr0JmbUkpgVJX3sOwqGUqNUK1U4iGc
 HcLxM0kL3n/zQKEwSHBOVsg4OzI+TFBc8rA9Hq8I3NdYhBc1FwWNRs0RQzMyk5X0shKKA1JfgW
 07rOHru3BNN0eaOK23ozeUfThu3+a5eYd0aYo/9FZMs5Kq3jBjVVCqIsnyt+Tfho/DHk60K7r+
 gPo8oxItQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787833673; l=3599;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=9svXqtqyffmCnBi3bJtEcbSBLp3Ou2cJhPq5IW5GGrg=;
 b=UTFNAvIngmoVFqsPoH38r3m7/4l3HvX5CDmjMLjJyARyQ4/Ilz8ydpwNvfnrmZ+RngxUwqERK
 4TPr+JtnTDzC2aVR/GCnE06vknfzqRLVs37NzVyLuftDn2DBHZqmLCJ
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwNCBTYWx0ZWRfXzRiJZCqsRt+8
 tiybwgWNZLTYX49n3HAFO7SPaSPkACHhFpXdwqWhK8e28T5vLwN2dIkIvmwYZmE6neeEonraQVp
 O/o5hVLCMCyniy38ZBrFwn3N/usv+Ak=
X-Proofpoint-ORIG-GUID: n6_1iMYwIVMwFbgKoaDIDJBKWpMpMOE_
X-Proofpoint-GUID: n6_1iMYwIVMwFbgKoaDIDJBKWpMpMOE_
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a902d4f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JvO64EORAAAA:8
 a=m8JL0bDcoiRC_ExNt2kA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=Qz6KxWHdQ2_aS5WpiCfK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwNCBTYWx0ZWRfXwr3XUJeELYMD
 jLcPsWa5P/MjpPpl2up19rskcOQWBZ7O0NcGBklKsuoUMR3djmxt1gEzymd218f/qbr4gEiYWY2
 LKwOmwUsWw3robqRGKaSlzL/P5YYSRrz6CMDvaNA+bQ6lK+ct02lBaeg1zJIA9kPc5q2H9IfW2F
 5I/lmny5GUQ3+0FIL8k4UFDGmfIj0W2kh40VjiCG+JESifA93777/Nvm6SAafQxddBNxu0NXdho
 T1YTvyJ2vcG9uRvsA6kgiKCZAvIOTm7lr4riXSRQuqYc0vVop37Ai1pZezQob5BkYFq4zrtJZ3z
 3k4U2+2HU5y8KoWKxAzm+KRDlDYmwJ26nOBh0b5Pg010pDwpXUzfySZEQwCTKARrBY1QRNIMHkq
 kO+9QbnkT6k5PfZKMpX35oBTu4Z7h72XJIDzkYMtGftQ8QnRpo7sDUzZ4IH7SNK2ozs7gLikZu7
 lqci4vSJVHvT94tz0Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270104

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

Changes in v8:
- Compute GPI multi-descriptor timeout using the total length of all
  messages in the batch, since completion is reported only after the
  entire batch finishes.
- Guard against zero bus frequency in i2c_update_timeout() with
  WARN_ON_ONCE() and retain the existing timeout as a safe fallback.
- Link to v7: https://patch.msgid.link/20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com

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
 drivers/i2c/busses/i2c-qcom-geni.c | 48 +++++++++++++++++++++++++++++++-------
 drivers/i2c/i2c-core-base.c        | 43 ++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-dev.c              |  3 +++
 include/linux/i2c.h                | 13 +++++++++++
 5 files changed, 111 insertions(+), 9 deletions(-)
---
base-commit: f82a5da2f04960df9fb57489992d03dd5e64ec6f
change-id: 20260716-master-f7da57c7529a

Best regards,
--  
Aniket Randive <aniket.randive@oss.qualcomm.com>

