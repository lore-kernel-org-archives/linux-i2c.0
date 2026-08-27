Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8857499F01
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853577; cv=none; b=IZLIZtm+g5ur4PC4LSkmczeXiPaVJIpt8dArfa/5JetAoVxdQ2zkyu/5Cn7F1ZHCp883qsj5O/BiWs8M7LJMiGbQ2YsL06JPqYzVzdgroUcMEhSiiOpATIz4akaXcptb1vLMLpfiGoeE6DNguPY41MXG3Wwo2n/C78N/SQ5OlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853577; c=relaxed/simple;
	bh=/+YatdltfR0iMDpKsEcQ1d3BbMXEeeGwVP7+dDq4nRI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KnRwWRktpDe1wkHWouV908DEKoHQgeupJvj5ZrzKDDxcAt8pDGabYYkvHqURIMfwkLuju668tlq76+LWEs2Mpuys9Ezcnynv4cPR549SDqncC9PuvKJAGJp23FM6yUCxI+9BlZecEH/scbyW5sFoZ+0+NKZUFNUC1/GAv4Pr8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R4PeHk11; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBjUSyyc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4PeHk11";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBjUSyyc"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXqFs4178538
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 17:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f99q1/EfVd9fZessbQ28VP
	g/h51qq2Bt/mxBgayLr8A=; b=R4PeHk11fPI39iwjJqNkBiksbYGUUehDNgjv8o
	BDBOo1rltBHOrw3zgejyv92Qde9iRd3jNV3NPm4av3042gme10EU0qv9dOOUd06y
	G3cLTPl0AU3LPkx3xAr8XTnsqlKXJQ59nsMLwCSYgkcXJT0YuzdWeb8SHN6Wr8Nq
	4Xc7ys9A3/HKolSS5AsgLTP2Uo2ra6xUarQIRUGVDuImGksR9LLedvAa2psO4E6n
	ScV0Z8hDqc5lJSvSIwqm7XlGrYZiQrIm159SjCUzNzCK8rXK/i9B7dbyK3+K3DQL
	HeKtqaYX+mqqOS8SGOXl+ITJYSU750U5ukWsLmEiNTh8jDNQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaphw14s0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 17:59:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39640eebc57so384561a91.0
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853574; x=1788458374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f99q1/EfVd9fZessbQ28VPg/h51qq2Bt/mxBgayLr8A=;
        b=LBjUSyyc93clE3PEoxnjTomljPrBgf4kf+GAc/JU/IXVQEvQP+K1AOzR82yjPJnKcb
         VOpUUBRtzenc96iKcmEgpV7a3RKDczJ9Rg48ehUaYB8/KfE5MULHVEdx0AOdC4wqPGzy
         Vk1bTEy9N2t7Ajg85MWP97AigH8KqVTsRKEbuBC2zNRUVZ+Jest9PQIwxVS2Q7g3MRSQ
         NwZ/wI3fVg4Z5WGhNF636M1lKo6Y99JGqYrNQkZuVsLMwQnJ0TgEw9spu+TfxiHAnv+S
         coMPtTOO/CZSVi1A0SqhqeRP+yAmmP9xUmqozi5+4Q1LHJzc7hmQryVQwDnihxhGZCDe
         syvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853574; x=1788458374;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f99q1/EfVd9fZessbQ28VPg/h51qq2Bt/mxBgayLr8A=;
        b=K5m0pT773x89gCtJRSUytWMzzXm767m6xq4wZlaF0WqvpI3TRg8/FHeDZhZdm1EmI/
         rgt3gjZBI4JZcvOnh2jle8lOaennB7vysUwg5HxTFGkKyrQrdlD0pauqnoIGjk9SFq/J
         PKtHMFBpdRqNh8GZwVkfMYl0YRbUG2CKvxp6293ZxTbPs/Zu7P2Ketg1F/4dYlRuTXzF
         N4G0QyadztKpOLeSXbDG7vIa+brUpZK9bAonH8rTDKXtGXi1uBCOmbc512EvU9sjYemw
         JW9zuykbSxdBZEC2LWS9yNfYGXlNltGHdLPuzx9Ofo04jsHluG7nvj4Gez7vBYKCovBa
         4iug==
X-Forwarded-Encrypted: i=1; AHgh+RrI08uVGK6Tr3JpEHflLyMDiyTPITj4bL2x1oi9AtFcSQE7mhwibcMbIwN2tlOUwmY4HRiMV09Zo74=@vger.kernel.org
X-Gm-Message-State: AFuF++kMndC14lUJNrN0oxw5lvcLFJTawHk7MjTovzWTT91yLmRPx8JE
	opm0cf4GNMkwHKEV1MQL0nBIHFKlSpgoswC2uRgaIZY86Dal6U2ZGnK5WoHlwCcsEOC4y6V7Txt
	jBNPADsZetoI6Za8pX3tEvRkVaFlhg3c3aSS+cxahtDO8my7YSXVFS1T+URXhKFY=
X-Gm-Gg: AR+sD11lMLXDvWfPgGVawnMn0sC0WADEvRtJqW6XktmfzQAX/gs4etbjM4ktLzxk/wq
	x6eghMy17XwwCiKdUH6e2pSg/It8uXuEkmVVnIBsDIG0NS5B5iBg7mXgS6jyp/RgnNWo4PIBum2
	vHF78Rby5yuC3pYY0mQlb5GEE6yts0+sq+xHlSPPLyM1Dj3m/cYlWajvTP1i6CJZMOdCLvgKTDb
	djeHwSjgxW95RDrpvbXbnXZXTx3+AFM5t+ijzuj5aoxUSEnNGvHIVSuGkGumdcuLF2jQeFz1Y9Z
	P/xOiXAvBd3lYlexKr4GL9H08SOMR7WQIEXO8Q7LC0zSv3vtxtB4j60fef79sYP4iinfHla6Fh6
	yQMGSGBK6Dl6pwPAVrQRcWUXM+hdFyXPx0A==
X-Received: by 2002:a17:90b:264c:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-396d0e86577mr1841392a91.4.1787853573596;
        Thu, 27 Aug 2026 10:59:33 -0700 (PDT)
X-Received: by 2002:a17:90b:264c:b0:396:61f1:da5c with SMTP id 98e67ed59e1d1-396d0e86577mr1841280a91.4.1787853572974;
        Thu, 27 Aug 2026 10:59:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:59:32 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration from
 OPP table on SA8255P
Date: Thu, 27 Aug 2026 23:29:17 +0530
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPV6kGoC/52OWw6CMBBFt0L6bUk7Rnx8uQ9Dmj4GqVJaWyAaw
 t4tuAN/JjnJyT0zk4TRYiKXYiYRJ5us7zPAriC6lf0dqTWZCTCo2IkdqMn+hEJ3TxEwNmJQnWi
 idz8y3knbCx+CGKTqkEIDZ2n2AFBJkkdDxMa+t+Ct/nEa1QP1sFZWo7Vp8PGzfTTx1fs7PnHKa
 MX5kUvFtdF49SmVr1F22jtX5kPqZVm+v1veqwUBAAA=
X-Change-ID: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3793;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=/+YatdltfR0iMDpKsEcQ1d3BbMXEeeGwVP7+dDq4nRI=;
 b=st+LTRVfFk5svHyCZv6i7Uv6xa7ZAuHILjEGhNjK1QxXVrVdp25J74WVf8PSJSsZRimRFzrY6
 nIgViibqvaICdTBhGTLqq/Ijl8YGjlpKT/GsFZGxpHwZNTekgC/Wcdd
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: B-Sac-dpqHEYoFMz3yC3tWNmLj15PY50
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX2iA08Lh9yh6d
 Euda5dXY3lR583V6zK9jB51Cyf8eskJsIupNO0Xk2lun5N9HWqEKbWdnnCccoUbp4joGo5Kszun
 SYLfeJnt7DFvKdeLlU7jmL6rVv5bSXs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXzW0bF+XifgGS
 Q0980/6nC4BLREZzJMzqi3tbNzKqQnJxC3YrU6JgJEsD84zXzez6831hTwNrPkDSmf7RyShQqq7
 Qz1pMo4JdRKIXvaDPRWWUMfcpAMkA0/OK+K1ufnSpHYwlos7dD7mI/vzTYpT4j2ALDwjY4Qv27g
 DqmbqViVuwY4PPTktA43k1ONm/Qw39GJRN1tm3VX2pJaVaLTvMowvDlK98wxiDr+ZnwigSI9dIj
 WFP/DpQt4KO9X7ttInmd/zWxgteRTsK/4ohzxi1BE+zwQEFoWmd/w5dgemnAeUs92AeClOlbxMO
 uDcdTbluj/Uv0kBezd4bnKRoLKuD5+txYB2lrl6YHFfcVm7dYUVc7OJgkbd9IO5ZzREBK4KrQ/o
 yRD+14GzBs9tr9MTGIej8/MkIvObzcra/cv+1lX6gdfqr45HZb0S15VGhl+np09QBdUb1hktlpQ
 0Y4Ip594DE6sZjM7FvQ==
X-Proofpoint-ORIG-GUID: B-Sac-dpqHEYoFMz3yC3tWNmLj15PY50
X-Authority-Analysis: v=2.4 cv=E8b9Y6dl c=1 sm=1 tr=0 ts=6a907b06 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pe4rHqQ3xWNOjACthRQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

On firmware-managed platforms such as SA8255P, there is no Linux clock
handler available to determine the appropriate SE source clock, source
clock index, and divider values for a requested protocol frequency.
However, these parameters are required when programming GSI TREs, where
the hardware expects an explicit clock source selection and divider
configuration for the serial engine.

In contrast, platforms using Linux-managed clocks derive these
parameters through geni_se_clk_freq_match() using the source clock
information stored in clk_perf_tbl. Since the firmware-managed path
lacks equivalent clock information, protocol drivers cannot reuse the
existing frequency matching logic and instead rely on a direct mapping
between protocol-requested frequencies and performance levels. This
creates a separate clock configuration flow and prevents
firmware-managed platforms from deriving the actual SE clock parameters
required for GSI TRE programming.

To address this limitation, the performance-domain OPP table is treated
as the representation of SE-supported source clock frequencies. During
geni_se_domain_attach(), the OPP entries are used to populate
clk_perf_tbl and related clock performance data, allowing
firmware-managed platforms to leverage the same clock frequency matching
infrastructure used by Linux-managed platforms.

With this change, protocol drivers can use geni_se_clk_freq_match() to
select the closest supported source clock frequency for a requested
protocol rate, derive the corresponding source clock index and divider
values required for GSI TRE programming, and apply the matched clock
through the OPP framework. This removes the dependency on direct
protocol-frequency-to-performance-level mappings and provides a common
clock selection and configuration mechanism across both firmware-managed
and Linux-managed GENI deployments.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Add new patch to remove OPP rate reset from resource deactivation
- Add new patch to vote source frequency via OPP for I2C
- Compress the SPI, I2C and serial commit messages per review feedback
- Drop a stray blank line before trace_geni_i2c_bus_setup() in the
  I2C resource-initialization helper commit.
- Link to v1: https://patch.msgid.link/20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com

---
Praveen Talari (9):
      pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0
      soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
      soc: qcom: geni-se: Add helper to set SE clock rate via OPP
      soc: qcom: geni-se: Remove OPP rate reset from resource deactivation
      serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
      spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
      i2c: qcom-geni: Vote for SE clock rate using OPP
      i2c: qcom-geni: Use common GENI resource initialization helper
      i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

 drivers/i2c/busses/i2c-qcom-geni.c      | 72 +++++++++++++++++----------------
 drivers/pmdomain/arm/scmi_perf_domain.c |  2 +-
 drivers/soc/qcom/qcom-geni-se.c         | 62 +++++++++++++++++++++++++---
 drivers/spi/spi-geni-qcom.c             | 24 +++++------
 drivers/tty/serial/qcom_geni_serial.c   | 26 ++++++------
 include/linux/soc/qcom/geni-se.h        |  2 +
 6 files changed, 122 insertions(+), 66 deletions(-)
---
base-commit: 0f6da28aab51b16762ed82e8fdeaa5042da45b08
change-id: 20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-2f29ad32226a

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

