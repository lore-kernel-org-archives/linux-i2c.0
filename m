Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE033D4108
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091313; cv=none; b=fXj+Sc9IuCcWGhOUtZuJjhlkvRNUm0lgksb3+wd6uD+pEaDhwyAYkosd9grF/ZAiPIO7nNUhP5o2/MTNMnA7JMioyYVW8Q90If37RQbjPH5Jh0DMT24uvtqjdUFc0H6xY2/RGmI3QPcNBU4IkPYsK3nxMCU9ytttzEoBIayYsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091313; c=relaxed/simple;
	bh=5QeoQ8TXJ2eWRKCulVJNBYD2hW0MNG0GXK/uGsHOHF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYpOAxIYrba6JvKGIuTX0wKYpTVpkgqdTPtsC6EObch1tA0drA4bcV19sAf55IXK2Hz3QiiNY3gnSfoOo9wJjTphWMHHGEcY2OVjphmRAnJZrDTrCTC7pAnVRSg/7u+4S8Sk7EkI+8Qs0GSojWvNDsvAE2+spPD0X8+BvxWeqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgJ+5XTM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SVRa/f1q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgJ+5XTM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVRa/f1q"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BIlNa3136392
	for <linux-i2c@vger.kernel.org>; Fri, 3 Jul 2026 15:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68zuQffoeICSOePaMqdl4NB4vCyqD8mj3IAHDnfcNUk=; b=hgJ+5XTMVyqXw9Sy
	VnmE8sRX6T/JPLnWfQBb8Jd6cLisRnw6d31hwIvGrCGEVgAhFjpTJy1R0enEtK9N
	l52vx+MD+hkfnUm5zAsUdHiDxyF/SLP+ERrYXR0PT5FLQdH5H4T8LayXDPBGb2CX
	c7PLTSRO8jmOpnu4O1civmMrnS9sbdsbNOVJHy0+IGSGT4d0Y2x1F8Gx7MRsjozY
	UwyqmSTsfLre2/v8Xgh/Dji8OUXkzPzU77vGk2a50LF7MeKxiSRfNK8GD1JnV4AR
	wf5iutX0VWcpyKFyKmy/4QwyuYkqnWkBGJEoSAJtdPskgETMB2AvcuDjZOaNUeNl
	AfQQYg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5auwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 15:08:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c890bac374eso1156815a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091307; x=1783696107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68zuQffoeICSOePaMqdl4NB4vCyqD8mj3IAHDnfcNUk=;
        b=SVRa/f1qBdLSjJT2qi3n9znsFZhRE4Dx7Ordq2f6nACBVpEKEM3atosq4l4Hvb4+mX
         ERMBo1nfzk6I4gICNHCEH3L2chxFV8+0m4xyWcDBpUb7eHutWrq96IWEBpfiPDofbxbf
         JyeHBibnUyz0CHSLS2D98L/3RiKdZLfGBoCVKb6GvSFqjURR65wIrcMZU1STpvzNb1r+
         AjPtCMe8HQezta96GVD18ggDdO5WopTXzJeQqIeEpgqKwjQvhvUjPkKDF6tnbiC8xl49
         iP/bzFRok8qPhGqDGKWSJOzwG6ruUnpdgpmqGbugcRRbAefKRIGd0VU+/KM5wN/EJkGk
         mfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091307; x=1783696107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=68zuQffoeICSOePaMqdl4NB4vCyqD8mj3IAHDnfcNUk=;
        b=GKhHC8IYrQREMDgxVHNzvHCez+l6poz9XBnKggbrsHqCTiUApwm2EJRC+hCv0+qO/7
         ZpOsYycLuVcwkMyHdKocQSiN14pq90B0T/7AuPtHt2ahzp1536GEbxRY0HomPgkichGC
         91leSoV2tT4wDDaSXvqddh6C6Pt0yq67K3Qqj00ec0c45yHlSKjrzUloPmqFoJKzWsp0
         MNcUHyxzQ+uDebzFd8oaZvobX4rcoBoN94zXi+p/zOq1wCQfbuDmA9JWFQsBdjY/XsHJ
         Q2sUXllB0ln0aZcuIz+0PV6M8YH162anwKAYx1e7YurfB2l/SFuRQM99oryDYrICsqV7
         ZigA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q/fxVIPDukVbntcQhvVVwJNDvN7uGzxh2+Ve6YiMlWbFgpChjDd4tpDFZhr/nleCEzPn/g+dUKRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSgrFL9mT7MdEq5bB7Qg1SO45ggmQ5Tknl4Y0H4huOsZVNTNA
	QCBc2wVoIxfyHtmRSbQ8tQI7fTjyyqpyBx0IBGkBaqLoO/MUQQW1sG5/tXeVHDMEboyDBr/J6C8
	bgxhFwyJ9opr0zz/nnHJCedcdgjTDA8cNOheNdnuSzDgOZsUFusJyIQWGu8pfwUY=
X-Gm-Gg: AfdE7ckl/70VhlmQA0MDT3EViaBbqEcuECehHvuA72+bHEVAc4ApmdxrI5h3hEnlHng
	zfJm3p7jvoBTw0PNYQrJ6Mcz8XKgeYRsfiCT0m037UT2WAxvwd4bqUzKHLtA1D/3d9gz+XOqmT3
	N3cn8i/64ZzsVPp/yjHjNS5V6MTXzbL8q11s1fWu3L3DjBSwbtpxMG12DnaTXSOj1vwIYuh+ADv
	5BKCn1ar0iM5Ia5PxY+oHH594HxybJrmA7ECzWGZdn7DXr+iM7Mgly7GfLBQ3Rn/C1NdKoEK9yM
	sTzincghtqfg9AfYAsAtS7t4herSMMvQpb+EJxt+Zq3eSkfRYWBUqky8Va59PaIFx/xohucN7Go
	hc3hjMjAocXuhdffSX+GLuCv7ZmLSr19KH++T2/RjbBXn
X-Received: by 2002:a05:6a21:6191:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-3c03c457672mr276003637.2.1783091307536;
        Fri, 03 Jul 2026 08:08:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:6191:b0:398:7ed3:a001 with SMTP id adf61e73a8af0-3c03c457672mr275943637.2.1783091306833;
        Fri, 03 Jul 2026 08:08:26 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm37007808eec.9.2026.07.03.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:08:26 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 20:38:09 +0530
Subject: [PATCH v2 1/2] i2c: qcom-geni: trace: Add trace events for
 Qualcomm GENI I2C
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-1-e8bf8b178290@oss.qualcomm.com>
References: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
In-Reply-To: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091297; l=3246;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=5QeoQ8TXJ2eWRKCulVJNBYD2hW0MNG0GXK/uGsHOHF8=;
 b=TRAW3IelPIMSyF0NYXNPzhAQLEYVuT27+/yMOfHFHYswg5RHanAQrpiyP7cEqxbScnUhXmEmp
 lOtJuvK39/lCUrh8ySv7Q1k+WlFwibwotS/qC6ZCCHBbaj70J1678Ay
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX8f728fJrEUez
 MJW1gnDSTY9aAbkFHM3ryDrHLE0MTUlZFBrLUIlFpHCri9t3pbSQpRpKYNAnlr4YsOOPn3gAhif
 pOhWEbeQloFwInEwoKUOrzumk6q8u30=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47d06c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=meVymXHHAAAA:8 a=EUspDBNiAAAA:8 a=CL0R8eYuxTG9Dar42d0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: jEYSNj6sjVuqtTEtSlh4cqECEqEZs_1F
X-Proofpoint-GUID: jEYSNj6sjVuqtTEtSlh4cqECEqEZs_1F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfXwTwvgedr2Q0W
 Vrij8lVDTV+l/yeU373WP2bG+IkjKqFi+X39B/chRo3VdLVKpLX8uRb7mlIuludfMkxK61wwmUO
 lUZYp6ZAJ9D/juX3c2JVy+tVqIc8bZcmsVE9VuzmGYq4nx8uG/5th2oZPTq5qCBJ9RBBv6Xk4Gz
 wI0WqZuYPuGH4CFDo3GOehuFKk1OrqlCGecIq4L2BUoC5Pd24RIg25mNX+dpJq+ZcYrqvb16zMi
 kQ/yUzQmMijQvLd3hVAJCBKcRWRHKQI1w6YnsOscJYng7SjbB6+c/hiULSFwjvIQhPShA5IN6Gs
 8H4UsaQQv+PLqiNOtkyxYB6CPXp3f8DOv26ZXL3rsPceOOrE+/PINuz6L4no66bKa5qnyZgJ1q+
 wF/gsXaw/x6LkzdW8nBIFllNgKeWcCuDl0ZF2tskiXbNoR1gcN/s0si5+kvslz9HZjKqD19oQEd
 pJBeHmzmQwBwLXuheyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030150

Add trace event support to the Qualcomm GENI I2C driver to enable
detailed runtime debugging and analysis.

The trace events capture I2C clock configuration, interrupt status
and error code and message.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/trace/events/qcom_geni_i2c.h | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/include/trace/events/qcom_geni_i2c.h b/include/trace/events/qcom_geni_i2c.h
new file mode 100644
index 000000000000..c7e7984f3620
--- /dev/null
+++ b/include/trace/events/qcom_geni_i2c.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_geni_i2c
+
+#if !defined(_TRACE_QCOM_GENI_I2C_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GENI_I2C_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(geni_i2c_bus_setup,
+	    TP_PROTO(struct device *dev, u32 clk_freq, u8 clk_div,
+		     u8 t_high_cnt, u8 t_low_cnt, u8 t_cycle_cnt),
+	    TP_ARGS(dev, clk_freq, clk_div, t_high_cnt, t_low_cnt, t_cycle_cnt),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, clk_freq)
+			     __field(u8,  clk_div)
+			     __field(u8,  t_high_cnt)
+			     __field(u8,  t_low_cnt)
+			     __field(u8,  t_cycle_cnt)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->clk_freq   = clk_freq;
+			   __entry->clk_div    = clk_div;
+			   __entry->t_high_cnt = t_high_cnt;
+			   __entry->t_low_cnt  = t_low_cnt;
+			   __entry->t_cycle_cnt = t_cycle_cnt;
+	    ),
+
+	    TP_printk("%s: clk_freq=%u clk_div=%u t_high=%u t_low=%u t_cycle=%u",
+		      __get_str(name), __entry->clk_freq, __entry->clk_div,
+		      __entry->t_high_cnt, __entry->t_low_cnt,
+		      __entry->t_cycle_cnt)
+);
+
+TRACE_EVENT(geni_i2c_irq,
+	    TP_PROTO(struct device *dev, u32 m_stat, u32 rx_st,
+		     u32 dm_tx_st, u32 dm_rx_st),
+	    TP_ARGS(dev, m_stat, rx_st, dm_tx_st, dm_rx_st),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, m_stat)
+			     __field(u32, rx_st)
+			     __field(u32, dm_tx_st)
+			     __field(u32, dm_rx_st)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->m_stat = m_stat;
+			   __entry->rx_st = rx_st;
+			   __entry->dm_tx_st = dm_tx_st;
+			   __entry->dm_rx_st = dm_rx_st;
+	    ),
+
+	    TP_printk("%s: m_stat=0x%08x rx_st=0x%08x dm_tx=0x%08x dm_rx=0x%08x",
+		      __get_str(name), __entry->m_stat, __entry->rx_st,
+		      __entry->dm_tx_st, __entry->dm_rx_st)
+);
+
+TRACE_EVENT(geni_i2c_err,
+	    TP_PROTO(struct device *dev, int err, const char *msg),
+	    TP_ARGS(dev, err, msg),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(int, err)
+			     __string(msg, msg)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->err = err;
+			   __assign_str(msg);
+	    ),
+
+	    TP_printk("%s: err=%d msg=%s",
+		      __get_str(name), __entry->err, __get_str(msg))
+);
+
+#endif /* _TRACE_QCOM_GENI_I2C_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

