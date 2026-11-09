Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232936;
	b=a7eLwLKJgHp5dCZdXaDFTZdOtcPDkeynbzweJ+ixVt7p55lK56kraL81x5UYgUkK+6j0
	 FZd/zIfHIO5ijlrW1djbzaDv+INk3A8TLC/im+czVhHD3BjOm36dLGFEyI6CyF1B42bmR
	 szYa0tlPRjS3tf8rboK+7a3K69WALgiaL9wASAwxggaxRpu9UlNJFjckjwSS8KoxOZWH9
	 VDCfj/ticm/mgp73+NHfyzSugBdkPesvpKRCPLreEjV7gdyF83O+26qd6HhlquFI8IozQ
	 7hUP0ggC+wtb+JkTntyDTQvGzGS6gJ1dL1UjE6kU8hDKxB/vg+nCJNL1tBIrE67BNQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232936;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ATC4ytGvpaxV+ditlkv+PcB9kNkdnATmugFJjVslMz0=;
	b=43muCh5Cy/LjKF5QAI80tU3JMr4/4j01Q4AVC2IC3Azyv971wcjpJVxIztXZuFLWn2qw
	 LJYCUQGw7AfoVWW5lvRKTarjnza2708JZvWQDLI3+i78nL1AogsC9VhOWQpUN4lBBZz2Z
	 Kf2Vl+LHZ1eIjC62g8bj1L+tB/h5ueSvJWjIukj86zfoDXxtiuwB56KHSue/don3+hyXS
	 6llHEDBzoqje3SAKjptDVbGmMbNeeG3JZiXlHqKiU4VTPQXFl9jxw/n3EaT2fb6i2UcdQ
	 jfZSVu0flZF0X6pQ1Ehis+AFv6Pzcz+mbChGoGD+mP2/dPGgGYEJi/4nVw5D0juXX2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OQdbatpJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRLBrpP4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B85D606A31C
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 14:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B85D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OQdbatpJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dRLBrpP4
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DEvOX309696
	for <linux-i2c@vger.kernel.org>; Mon, 9 Nov 2026 14:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ATC4ytGvpaxV+ditlkv+PcB9kNkdnATmugFJjVslMz0=; b=OQdbatpJpbE5HMsa
	QCHAlSoC60+fde8fjUdySO69fwNuPVxJX1rNQz0ALzozyhgFyDBxvjZWUMjY1FYc
	kgsD/onAQLlcpoS3aR56Vlb0CChOI20rTUuLP+k5gTTLKuI/FwQhDVnXspbKYX72
	hemikCg5U+E2bhq+pmuMm4XSYrzBFI2UOggzf8NdVN0T5GDRXgez+RfO8zWho/x8
	frKijeARUDUVbvpIqbhLq/rvnh3FJmFf+K4Bnj15rqyjyVKuO+kPSQVcmTe2IimH
	ZiDKUD3hjLanPJh0BgKTu/nP2JJb9DjhRBOE4md2h5TA7hvkM+Un82/S+ewGrrzo
	ODZHbA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucap8pu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 14:02:15 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99081ea787eso671563241.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 06:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794232934; x=1794837734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATC4ytGvpaxV+ditlkv+PcB9kNkdnATmugFJjVslMz0=;
        b=dRLBrpP4Hk4i5gcKlFjrgZq2w9zSDfMPDOV0ybohDKWbVAEn6kZJQT8kE92Me3d5Ce
         Fm4zxM69rrGlkjWQ0ricrxXD1QKMm8wi8VCeMtt+KVrtx2TBH0m88ZfNdBzDJNsjO5/p
         EhRxsZYNBtPSOsjbitpNQ2B0sEaUzwJRogO6YwSvMEIHRVxLSH46AGXKejry4hzo18JW
         j9CJ2oBAVf+a/vOsrAdJat41F6o/4ZD8Sx9cQvtDwMA9XL9VKz3/J2p4zlLIWCHUcy5u
         n2QUPwhkiKFa4lryGE4ovxi/c0CBUilusY1don8937mT8m4hrLI/q4aH1dbaMeS5uGrX
         rcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232934; x=1794837734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATC4ytGvpaxV+ditlkv+PcB9kNkdnATmugFJjVslMz0=;
        b=ucUnp0AWKDXWmK5QPlW9LSmqv0KwxrwbhbPOOTEUQLNglN2aWddIU1Kr/SlCyNXgr1
         a1Wow3F/BN8HpaDo9VSndkEOxiQ5CVI0CqkcuvsrTlDgoWop0LYIj1/vF42Gs3o2uIrD
         s5DDxusEjciVf/89rCgB97FnheU8ilekno1I/MR8nuUTHzTr8l15+fPM8lcanwgP3XqP
         k8gUCpcnLkxDFK2eJEhmHGx2o9dfMS54n0yJpO7XDs9cHVxeB9Qj93ifbBmSriyWywJH
         CS5WhctKBItsccTPNCx7qjj+2LlpN5Uwp2MsMUPbsgCTvdF4O2KLrFx78cAFsGotyIGs
         i5AQ==
X-Gm-Message-State: APuU4Z9JAODHl3AfdlfkDcZEgpvISE1lhbxYSNN0IoWsGciEo2s52y/F
	9U9zG1TzKEEL3y9sToWfFStvvi6zmHSCUHSuNCSfhDk/HcKvKSeCvMzTUhwckqqLW3RpiaeHW6f
	UQBDBDBylqY9mMS3yVXz/gt3hpuRDUd/jjH741s6xarXXcpLu9YGP6+8TbF5P7H4=
X-Gm-Gg: AYBFou3eD0yDmoExJR+CfJrzlkWOeOm+QcZha+aRL6FtN5qdhxYy6OVwc4pX8JWQJHs
	axRsYrKTRL4jMBspDYss2In/iZ5vV+mer0sBHC81sxc39H4T9WuyzJ+3jQCsIplc9MkmqJK2Gxr
	+pikLxR3yqLKo/2n2z6wFscDTVkk6lwvV+Lg0TmsJ0/FZORR4NsKFG4+Fc+M8QxVxmVE64OWmy3
	0pSNxLHeh0v2qmIvUTFFyfRiGCDdVVAawTsFpFi2f/D1YTHT0JfG36lCG1/6fyZqVuwuSHo+pO4
	ZAOjQvDHg50tFSp0AhJms7Uk3Ya9Vy7F4NN6S+cFUHy6UCWY2jrR1E2DRmsn5T21b1OHRyk517q
	MPq3vTlYLNZ9pdhgSX1sir3Xq0Md7+6r+xPmRmL8mp/XUKkZUXSU4w3p/3FkgQFOHN9nYwn0Vxh
	Idj/NFEfQ1K0IXpQ5eAwIN+0ya8LvnWsOo9k6cd/1KuRM5m13ognGkFJFWmTVR3ZX9izVO86zFh
	PZ7xE8xDDZySYJJILaXCo7skRsA
X-Received: by 2002:a05:6122:1313:b0:5eb:7686:48f5 with SMTP id 71dfb90a1353d-5ece7207579mr1148144e0c.8.1794232930166;
        Mon, 09 Nov 2026 06:02:10 -0800 (PST)
X-Received: by 2002:a05:6122:1313:b0:5eb:7686:48f5 with SMTP id 71dfb90a1353d-5ece7207579mr1147489e0c.8.1794232920527;
        Mon, 09 Nov 2026 06:02:00 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f9b5:154f:6aa3:35d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm161515845e9.4.2026.11.09.06.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:01:58 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 15:01:54 +0100
Subject: [PATCH v4 1/7] i2c: qcom-cci: Factor out write command queue
 programming
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
Message-Id: <20261109-cci-imp-v4-1-4dc4095dd052@oss.qualcomm.com>
References: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
In-Reply-To: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX63dj79YVOhSK
 IbHYig6MA9Vh94E9bHRX12Puswn7F192qvXjUQlah3na30Qr3mZ7oJ0KZYx6EzUo/7khTaxrbAZ
 rkXik7PrB0slXbGsESmLSjzXKfBznFpQj/L8t6kUgs4pw5hFcSxRLZm0BHe/WqgxrHxVhceahBq
 VtBisx2rsthU+gKDt3ro5NByOFBTYYbs0LbtEvadNQNJr+2tWAmQRrFOTJXzXIC08H8D3nCtphM
 DniMbBqdcZ61OyPp5wpMc4EYs5gM3J75+9v/6+rsL2guQhg3MhN9HA4/of7HsDd0ahpSImupBCN
 dqSnikxXtkEVM8fG15u7XgQy0BNDN1Q7keSKwLmrwuJcjmwFlXiPkhH8nmdTRJlKsuiaNN/2ver
 YtTJGkT3YA2wkr0ipQAKCcO7W5BkduTkAjB9zhZzhwgGy03haKgLGBRB0eIQ+GyWfR7WPNVEtJ6
 2mntsNQIEPjpiVMx+vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX9zHQkckQ9HwO
 ZEOC2KnwrgYb5koa3L1d+YsLTPmCPnQK2N+JJrV9jYhzWOg8pPfuV9BVHx6eEKNgPiQOXWOXfLO
 Fy+xvIwqZwf4h+L/EEGC+q8F/SLqW48=
X-Proofpoint-ORIG-GUID: -aHl3HI0o3N94FCsaYgzoMk5yRHgDzvy
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af1d267 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=EKMQ_w68-2WzcSmJptwA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: -aHl3HI0o3N94FCsaYgzoMk5yRHgDzvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090055

Factor out write-command queueing into a dedicated helper and replace
the manual byte-to-word packing code with iowrite32_rep().

The resulting code is easier to follow and will be reused by
upcoming burst-write support.

A command can only carry as many data bytes as fit in its words, so
validate the length before building one, and do so where an error can
still be returned. The I2C core already rejects a transfer longer than
the limit advertised through the adapter quirks, so this is only a
guard against building a command that would corrupt the queue.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 44 ++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 76a5dedf659fb8396ca5df188143469977526505..e7e2650a05ab125c2ac619c90cb61152cd787165 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -78,6 +78,9 @@
 #define CCI_I2C_WRITE		9
 #define CCI_I2C_READ		10
 
+#define CCI_I2C_WRITE_WC	3
+#define CCI_I2C_WRITE_NWORDS(len) DIV_ROUND_UP((len) + 1, sizeof(u32))
+
 #define CCI_I2C_REPORT_IRQ_EN	BIT(8)
 
 enum {
@@ -480,42 +483,45 @@ static int cci_i2c_read(struct cci *cci, u16 master,
 	return 0;
 }
 
+static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
+{
+	u32 cmd[CCI_I2C_WRITE_WC] = { };
+
+	cmd[0] = CCI_I2C_WRITE | len << 4;
+	memcpy((u8 *)cmd + 1, buf, len);
+	iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
+}
+
 static int cci_i2c_write(struct cci *cci, u16 master,
 			 u16 addr, u8 *buf, u16 len)
 {
-	u8 queue = QUEUE_0;
-	u8 load[12] = { 0 };
-	int i = 0, j, ret;
+	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);
+	int ret;
 	u32 val;
 
+	dev_dbg(cci->dev, "master %d write: len=%u\n", master, len);
+
+	/* This condition should be guaranteed by the caller (i2c core) */
+	if (WARN_ON(len > cci->data->quirks.max_write_len))
+		return -EINVAL;
+
 	/*
 	 * Call validate queue to make sure queue is empty before starting.
 	 * This is to avoid overflow / underflow of queue.
 	 */
-	ret = cci_validate_queue(cci, master, queue);
+	ret = cci_validate_queue(cci, master, QUEUE_0);
 	if (ret < 0)
 		return ret;
 
 	val = CCI_I2C_SET_PARAM | (addr & 0x7f) << 4;
-	writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
-
-	load[i++] = CCI_I2C_WRITE | len << 4;
+	writel(val, loadq);
 
-	for (j = 0; j < len; j++)
-		load[i++] = buf[j];
-
-	for (j = 0; j < i; j += 4) {
-		val = load[j];
-		val |= load[j + 1] << 8;
-		val |= load[j + 2] << 16;
-		val |= load[j + 3] << 24;
-		writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
-	}
+	cci_i2c_load_write(buf, len, loadq);
 
 	val = CCI_I2C_REPORT | CCI_I2C_REPORT_IRQ_EN;
-	writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
+	writel(val, loadq);
 
-	return cci_run_queue(cci, master, queue);
+	return cci_run_queue(cci, master, QUEUE_0);
 }
 
 static int cci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)

-- 
2.34.1

