Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D924ADD9B
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873513; cv=none; b=EXen2loCfrYy22O+Qm3m/ndq6f0clc6IqSeGcnP882GUanq/J5XLEwoJCG1G0CMfiFA8Es5nLwDL7e41nr6vz3GU4lWtfOGAmIpzEjuOd8nmb7StJWIbGFFn/tStk1L3+Va39FsDnA4zqMHDsdr/LXIuayymxfrmUlcK2eWpEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873513; c=relaxed/simple;
	bh=FEu5Wj/gdb1pkJZnW+0/Hj1a/viGsgLA7fb1NYBorE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h74HITxxRpki/7Bs8MAFCWT+5gU8QqtsoDJ1lzVd4trTuuEvfBWT0sDQ3uMq3gqCmU2t2BA6C0S7CkN321/rngcwIj+QmLw+SU7FjvARqNDNlAMuhGwrntrolJLvxPC3jQXjpJVbyqpTAuQxbV95gyapEL0JRji6gfiDSqSGX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSmgC9Au; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZqMs7k9o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSmgC9Au";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZqMs7k9o"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674JlLqG644695
	for <linux-i2c@vger.kernel.org>; Tue, 4 Aug 2026 19:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CHFVspy67XU4/PWnp/wa0Uq1rcAcE4MHBcwb/g66OxA=; b=aSmgC9Au1DKE1XOJ
	FexsggIJ+mMPiECRoYd1RBnaupA4mPpsyHwk8ZtGCppG6or3bvP1KtLQWwkjw3hn
	PDbdJJ5RtaePuj+nTzDQJlEJ8My5FMuYdHv8vzA6w8v6moFi1d1iSpxW2rRkz4ij
	ZP5c3czCDhLjx6lqqb77o4p//mMMbdfojQapBOjAZoAcb2jO9mnllB0iYb5D5qSo
	K/gCIit5puzJjFZYqSuzSmYh+F/3NbT3hc4BiQ3GRF9kbiEpqezlv4Nu/lrZTUXO
	1Hzjy5UFY+nZmO8ZQufxOjkGeKxuZ+9sZN6RDzGOBcV0XYjaavQlPUlxBHAo/Hkg
	ZVCx8w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fujwsh86y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 04 Aug 2026 19:58:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb5cc1e13f8so157372a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 04 Aug 2026 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785873510; x=1786478310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHFVspy67XU4/PWnp/wa0Uq1rcAcE4MHBcwb/g66OxA=;
        b=ZqMs7k9ol/FrgKbPcExJY/17Fd+/E5jzvNuINsTncShPpx+6HWVTNLwrT9k/tgHFMC
         vRnCSrSRAf0MavaQtY0Y4vkkpyBR3pzOPyYJLJ4Fnj/QmZPFHC/y/r6D+cIm4erKuBQR
         Y+cL6zUtPB6OFjEYsbjL7P34m8IZ0RN1x/poRzDrm+SBXr7zq83PYkSbzKicxsoimfu5
         y87vqHgSOnlWOXTaxucMyqGimtr74haDoxfC0qUUfApY12ce7kQ3UcTEpRBXPnBVvhNF
         dCLGEziP6lZbCVCP/sxxaWXg3btkvuTBwwRWcSO9y6fjMjS+XTj7obGISgU5bNyCiuu1
         B/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785873510; x=1786478310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHFVspy67XU4/PWnp/wa0Uq1rcAcE4MHBcwb/g66OxA=;
        b=XglOmQvLE11Ny0EgC4LFbDV3KquUJMB6cDa8QP7Xj8uaA3TiQR4D8I6SofGuJSX+XD
         wb/mhT6NbA6xz+4ORzj1IV7lFT8zzCWvR3G0RwA93FXHSXk6k4PPLusWiveHseNaHwRS
         BMVWc+cGWxGIE45bWDqPXeQFwXTmV7GuTfHXB/w3469xMlOrIjCSpYUPtUKV3xV/yGFv
         IPnDuLROMCugLtQdXxs+kuFQhAmtQInJSqInR3rG6X6HQ+G/pRGrEChbM5icChcmGlxE
         XU3/kleaq6yPdusoWn1Pw1BVKyV3Ua6Eu8FnUkqp0mFnGtuvQFrAlSidTRb4B56sGPtl
         Lg3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrFMk4VbubQvhRRMQtEmhBRwjkGB3wsn1b+i5Vcuu9VvMy39HilsaxaRXii0fGhYxCRw7/tVsF99Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgrV4weW4G3LnVx2X3wLw8Y/E4ff78uQm3fH918PB+ADKHlP2
	3l0pYn9WWqU4mzkI7QgIz309KgW9ilkHigCgSWOAq6vgRvdiIeom06vyDgs3KNCxenTBonaU/dK
	7GC3In/vaxZ9+JK/uOp047HBAx9tHQzHAR8tkyHIXUv2U9Lu0N+r8ywUaiYs1Vrs=
X-Gm-Gg: AR+sD12x1Ft/MvvRCzHC44N0j6iikTnsv5Mhs7k/nbfdvch4JrFK8zGBtXNkZlDec0A
	lcz2pRBEpTlxzTuam4COGswSE6+tfFItfch2mhA/NgEmEFB/Je6utOqmXlyvcb5e/a3amm2hv4W
	UE+NeLUmxxcSFdXR6CKaUfCYOlNTKUseH+fKD0ergWxkfjn8HhzLiAwZWym6+OLbQrv6XH30NJ8
	B+hsyw8ZyMiOHKYJDbn4mKz0vOb51vsj4y+8Gk2qsNT257MzQVkO3wi9LJSMziqmkK+le0ywFhO
	iVTilDSbgHbE25KNQZ73h2JJsc5OA4lPJY2S/ZVseo3b1jvJz2aVqAeZxpSOpa3QSPVFDCokiGI
	u6OcQBu/f8eqem73Ujlo9yHJmyuJj9bqgdQ==
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cb85df12fbmr1244068637.10.1785873509897;
        Tue, 04 Aug 2026 12:58:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cb85df12fbmr1244031637.10.1785873509401;
        Tue, 04 Aug 2026 12:58:29 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867a68fdsm12316636eec.25.2026.08.04.12.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:58:28 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 01:27:42 +0530
Subject: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
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
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785873474; l=4780;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=FEu5Wj/gdb1pkJZnW+0/Hj1a/viGsgLA7fb1NYBorE4=;
 b=1xxf2D4WP4Iyk432GQjmqyJtyjVtVZJ8WaRIgbdkv/2bnBKC2G3p4HN/Ai+M7RWQuCiMorxQs
 TkYdNIors2bAmHG8UlPjBB2/WQz9ddMwufxkzwnyeHuOY2ZHvbWS/9B
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: RZ0Uey3YzW_PfgSKvupsvt3dBtZIQgwu
X-Proofpoint-ORIG-GUID: RZ0Uey3YzW_PfgSKvupsvt3dBtZIQgwu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfXyG7mZ6LiquOW
 IHFAm0ZyrwStQqVn1fN+lkOqdOQVk5OOm2bXSW6QjRENEPH/U3g+osPwCClZ3J2OoDTL68L+L5g
 5mlcOVcDeGNstnnvH7J1ff5etKsd1/c=
X-Authority-Analysis: v=2.4 cv=Lu6iDHdc c=1 sm=1 tr=0 ts=6a724466 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KQElQ6Bo8OdNfGCL3dkA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2MSBTYWx0ZWRfX5uq4aJtCNhjx
 mBDzy+r6bq2iu2kz+0nrUC4qkcoPh4q2jSfJKrEDzL79zlvDzJ2ex3x+dZl+XHcRF1lHaoYEQbZ
 thY8kh7W2OuMTzr/ww5cdoFTWH0ByeZhh1vj699fs27LCFm5B0HAtYJHjpMkTxSjieXYFbkUFeq
 f3BEjdFE0nwO/IhQcqewUPI8DB+YlF+MlLi4z3vAzjD4MmgoXnTb3gKouqYa/rn0T4yhnOqjibL
 tmKjSV+F99H+uU8yKmojMYHF1UIaa8NNqo5D0R0Cj22NqT4WyB2TEe+uOFiLd7F3dnKmkZanLEH
 z1wOX602mFPXXUwQ2W4Y5eGpGHdWIYdTxPc8vKpMju3J15r2Gfp68jLFvuqIagMLHXu3dG6Vs01
 aRXW9ZdaPLfhm6dIqUcS7HNQmz3WzfpaFPVP/LJNeL5xFJFQJTg/xL1BmxJazihawr9/jwRPo0N
 c7ucLUKCclB/BqGlN7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040161

The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
the computed source clock frequency, and dispatches baud rate handling
through a per-variant dev_data->set_rate() callback that either
recalculates the clock divider (Linux clock managed path) or selects
a performance level via geni_se_set_perf_level() (SA8255P firmware
managed path).

Now that geni_se_domain_attach() populates se->clk_perf_tbl from the
perf domain's OPP table, geni_se_clk_freq_match() can resolve a source
clock frequency and divider on the SA8255P path the same way it
already does for the Linux clock managed path. This removes the need
for a separate perf-level based set_rate implementation, so
geni_serial_set_rate() can be called unconditionally and
dev_data->set_rate can be dropped.

Switch to calling geni_serial_set_rate() directly from
qcom_geni_serial_set_termios(), and use geni_se_set_rate() in place of
dev_pm_opp_set_rate() so the frequency is applied to the correct
device (the perf domain device on the firmware managed path, or
uport->dev otherwise) without the driver needing to know which
resources_init variant is in use. Remove the now-unused set_rate field
from struct qcom_geni_device_data and its per-variant initializers.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..cd1940eae084 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -114,7 +114,6 @@ struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long baud);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -1474,7 +1473,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
 
 	uport->uartclk = clk_rate;
 	port->clk_rate = clk_rate;
-	dev_pm_opp_set_rate(uport->dev, clk_rate);
+	ret = geni_se_set_rate(&port->se, clk_rate);
+	if (ret)
+		return ret;
+
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1513,7 +1515,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 8000000);
 
-	ret = port->dev_data->set_rate(&port->se, baud);
+	ret = geni_serial_set_rate(&port->se, baud);
 	if (ret)
 		return;
 
@@ -2040,6 +2042,8 @@ static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 
+	geni_se_set_rate(&port->se, 0);
+
 	return port->dev_data->power_off ?
 	       port->dev_data->power_off(&port->se) : 0;
 }
@@ -2047,7 +2051,6 @@ static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
 static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-	struct uart_port *uport = &port->uport;
 	int ret;
 
 	if (port->dev_data->power_on) {
@@ -2056,8 +2059,8 @@ static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (port->se.has_opp && port->clk_rate)
-		return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
+	if (port->clk_rate)
+		return geni_se_set_rate(&port->se, port->clk_rate);
 
 	return 0;
 }
@@ -2116,7 +2119,6 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2125,7 +2127,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 #endif
 
@@ -2133,7 +2134,6 @@ static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_serial_set_rate,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
@@ -2142,7 +2142,6 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_level,
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {

-- 
2.34.1

