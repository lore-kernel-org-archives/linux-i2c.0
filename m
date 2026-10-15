Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A893530E0A
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069155; cv=none; b=CT/l35qNUe/hTbry9Arenuz7XxJgLBeLCYffUdcdKoSB8HdbP3n0Ri3zy6RzWuJ9P1jkDyH0W/aF3YcRhEcPabo8+7VYgfCFqePxXzTItTaxVwQb3W+SQ6tlMwPQLW+Onry5CgJyIwTqil4JPHoa4nYI9YPcZk3+XPLAA8ndbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069155; c=relaxed/simple;
	bh=DFbeif1siwvLY3MMd4TdLfB4FjRIpjFhIHxBdIWFXfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mecviObbaOIy+n52RT61OPZLCxl2VBsROEHAmzVcfBZd0y2H8NTO8pVgEB5T6lp6ZyvUzFe4JvKyb966qg5t9Ij2cGfsD2eN3zfG98uPHdtB10FErgom5x14fGT3ZwZgwE1Iyswf2frpGthJ/tVMZgGWE+5Pj3CUvUtrJXNfLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LBQGD8pO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mi5COXL0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LBQGD8pO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mi5COXL0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jVB12416814
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tzm6AB9lq0hXcWvlWTSDwsYy5uYcMWQNCxs2piz67CQ=; b=LBQGD8pOGQ7+Bk+X
	vxrJS9EIOW/N2OsOJTtX82fZjOIo8io4JKaSTQ3OOnZc7cpIKT+7SYttqpZDYAfm
	3gvp++nUAWigsDNAsBmVkGn3kOntEi2ssyFFXiJa5jbjI4/HnryfDzkwEK2WtDHB
	olZ3T5edsY6cAYp6q+ykVvAdEYvZldA6G3ARD5oHkcqAONrR31/i4x5xj8SXnf+S
	3a4ysdXs0nHShUHx+go/QnEXdm9TuAXP/lm2aYz39IL4Dm7jHla2TpUqaN1s/IQY
	GCRJbx68LPxJWvoCHvhsPiXqoXVW6T/wOZvB2nG9w5xpA6ckVF6Xp/6Zhu8i1TlZ
	vLZB2w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhj5q0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 12:59:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab9850456aso2220875a91.0
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792069153; x=1792673953; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tzm6AB9lq0hXcWvlWTSDwsYy5uYcMWQNCxs2piz67CQ=;
        b=Mi5COXL0pAFT03Ro8p3yKuKqOpIcGFu3eI313wXIgtaawy5kBD15CGi5exfD7PZOj6
         PxerOcakVF1rMg6Q6nAM38bew2rnRrc0zeStmmR+fQpRVobdzWA1Rdw1axO3/fR0E6u8
         mgHF3PdV20iDuBnq4H/bL7ssomVNzSx8Qe36Qp2l/5tqflXnMWRbMyC539nD9Z/WsIlu
         ZNeOQWlEmgNxiffyOn+RyUBtfdtBObIvB0setGPbBkBBQAfgFXM0BRey4iLb9bbRBySB
         BxXgDit/+mSe+CRSYznKBVfNkVItuVKADIAd/NwCkm8/aTOlCviFqOgoEnBxXR3oFmUY
         NjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792069153; x=1792673953;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzm6AB9lq0hXcWvlWTSDwsYy5uYcMWQNCxs2piz67CQ=;
        b=eO+1klRgbVEi+Nh/NdJXmUNA0kyogAvqZH1UUqyteLBr7e9c9WxQV/W6BOnzSSrKMO
         D+PZAvOalyW7kQ/u1idFCCwMkPaGsUt8CwNWDOBkzLy3rqmiU8cMCNHMlHTEIJ/OJHCd
         x8z/yDYlR/9z19vA5d129JXPhIfU/324OB+SaH63N9P9kdJkYJhEnCqIRfVpL/HHegQW
         8e/q0e8bMoX/ZQT4yvIZUGSDcMw2S3JVjLXvbRWpE0baiVZUPKz7smLLCg68dVnsFWle
         i8XSbp7JQPg2Jm1wzLmZ+rIp4wqfQ6yyrLs4694jdlGm8m9GlZ8MKRy2j2IqE2Z6BZpM
         essQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEOEmzkgtUnXmJxpOi/YNpiMStx0PzEil836uTbT1SNtdoDhizGZl9NHFuhlV81xMZ2/Ci3WiKtPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvX5o2YVQa44LrW08mKkmIzChiAbkJ6xaa0VN9ub9DTnR9XMfm
	JCrXqsOvmqLnIf8PICv1RMb04KXAjBfUWRWvqV1mH3k3b0IYoAFStd9UekY0gMEqUZogu90sizO
	NCzhRXhP/iezDnV0FpdFBrvMYSPkV7F5/kEZD+Fv2QsWcBM5eL97wge/aNn8kWgs=
X-Gm-Gg: AYBFou1BlAocTpei9LdW04NRZXlA/kZac4uTMruvHR0igQEJfrvi7hr2218dShVTqFq
	+7zvCayq2Q9tgTgMpthT45ysyuPa7GXNNoPuGMKEa/CVkt1gckehBV+JY41ZrxSkDOddR5yb1GC
	a3V6s9toAdl617y4Qx8qdJSy3T03lfSHt9QELEvKhOcmw6M+8c9f2itPSs0ku2zZmlk5QWfOM7w
	Q/aYeZBAaYi+irzKbYKHaUGHzPhrJwc0lBSQzmTatIJbkmyWV6ooR1X93GrU4n1vhrMNznv3VFt
	Bs4mDMDfHom1a/JifMva0BG0H0VgW6onQl0iO+ENBQBOZiEUB72elkkKYB5deA+6BaVvpKvQWQS
	qkUNwra0bJ07lxWxg11EVbbFG6vNaELehow==
X-Received: by 2002:a17:90b:384d:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ac97bc59f6mr2382223a91.14.1792069152874;
        Thu, 15 Oct 2026 05:59:12 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ac97bc59f6mr2382180a91.14.1792069152211;
        Thu, 15 Oct 2026 05:59:12 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8d8dsm79691705ad.52.2026.10.15.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:59:11 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 18:28:25 +0530
Subject: [PATCH v3 5/8] spi: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-5-5da1096243c9@oss.qualcomm.com>
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792069108; l=3817;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=DFbeif1siwvLY3MMd4TdLfB4FjRIpjFhIHxBdIWFXfQ=;
 b=MAjUv8u6xRV0Xk8anMuKNPBJADNkMGHOAE/nSNJ7PYGexYasIwbbodDRwGZE82ThwEC0Ld4ae
 9ifbQpoguX3AWaObYGccS1F8ifkd8N9gMboimFft/lk2OsDFGizoY80
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX7LjARAForaZ7
 gHU8qxo9LAOeGoHBxXkacyD7ocv73Zv9kOhuuZQ4nZhNs9/LNpTp2sp0ntavpZuaDr47GpXtmhP
 2EGMpQ2BWb42d+18tx4wFoyxVzilhN8xVbiJEj1P/ZJJkPG7XP0VZmHNoBC5L3e0965VZy1jgTW
 HITILcaU6TSNRS3niU1rN2YbwpYfJNVacUMR9k4NqPC1O5M5wU2CobOQGJPpeD2HrjSM9zvhzKH
 bVWLDpjwAsvtBhmJlVYmklnD50fj5g7F+BtayCeJg5a5/h5i5ycqL0Osi1kNlzyUK9FoI9BBg+a
 1ZgM0baIbe6dpB2xhXUGPgjSCnNZNDJEzjYCXkI0IOx7EzbRXQocz57F3zdCafT4W6zUknzl4Ut
 kvORYoW8RuiKFu6tejHJJ/N/nq+nOyfmyiOkZ1iDlGQ3vOmbj/AT6zhvMr/EXK0jcp3x8QPxI9n
 ejWMatsT5TGsvo3hzWw==
X-Proofpoint-GUID: kgsdDkXBnZ60D1b3J_3EXfcWyyaVKerw
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0ce21 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V8jFpX-JU2fdHFI84kkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MSBTYWx0ZWRfX7vOXiDND8UR+
 eufOmdeitzPj0/h9F+x5PcDBl3HZo+q/Pv1CjCVok1bPUxe7mJdtpsEScqJz0WG00ULfNEm0teM
 SixvkqR8EN3zjVWoB4azkXGYTwYTwxk=
X-Proofpoint-ORIG-GUID: kgsdDkXBnZ60D1b3J_3EXfcWyyaVKerw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150051

On the SA8255P platform there is no Linux clock handler for the SE
source clock, so the driver has no way to look up the source clock
index and divider needed to fill the GSI CONFIG0 TRE for a requested
transfer frequency. To work around this, firmware instead exposes the
SE HW supported source clock frequencies as OPPs on the perf domain
device.

geni_se_domain_attach() now populates clk_perf_tbl from
the performance-domain OPP table, allowing firmware-managed
platforms to use geni_se_clk_freq_match().

Use geni_se_set_rate() instead of dev_pm_opp_set_rate()
so clock programming is handled centrally by the GENI core,
independent of the underlying clock-control mechanism.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 91e75e213f92..cbccd6d8689a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
-#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/geni-se.h>
@@ -85,7 +84,6 @@
 
 struct geni_spi_desc {
 	int (*resources_init)(struct geni_se *se);
-	int (*set_rate)(struct geni_se *se, unsigned long clk_freq);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
 };
@@ -155,9 +153,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
+	ret = geni_se_set_rate(&mas->se, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "geni_se_set_rate failed %d\n", ret);
 	else
 		mas->cur_sclk_hz = sclk_freq;
 
@@ -850,7 +848,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 	}
 
 	/* Speed and bits per word can be overridden per transfer */
-	ret = mas->dev_data->set_rate(&mas->se, xfer->speed_hz);
+	ret = geni_spi_set_clock_and_bw(&mas->se, xfer->speed_hz);
 	if (ret)
 		return ret;
 
@@ -1248,9 +1246,14 @@ static int spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
+	int ret;
+
+	ret = mas->dev_data->power_off ?
+	      mas->dev_data->power_off(&mas->se) : 0;
+	if (ret)
+		return ret;
 
-	return mas->dev_data->power_off ?
-	       mas->dev_data->power_off(&mas->se) : 0;
+	return geni_se_set_rate(&mas->se, 0);
 }
 
 static int spi_geni_runtime_resume(struct device *dev)
@@ -1265,10 +1268,7 @@ static int spi_geni_runtime_resume(struct device *dev)
 			return ret;
 	}
 
-	if (mas->se.has_opp)
-		return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
-
-	return 0;
+	return geni_se_set_rate(&mas->se, mas->cur_sclk_hz);
 }
 
 static int spi_geni_suspend(struct device *dev)
@@ -1310,14 +1310,12 @@ static const struct dev_pm_ops spi_geni_pm_ops = {
 
 static const struct geni_spi_desc geni_spi = {
 	.resources_init = geni_se_resources_init,
-	.set_rate = geni_spi_set_clock_and_bw,
 	.power_on = geni_se_resources_activate,
 	.power_off = geni_se_resources_deactivate,
 };
 
 static const struct geni_spi_desc sa8255p_geni_spi = {
 	.resources_init = geni_se_domain_attach,
-	.set_rate = geni_se_set_perf_opp,
 };
 
 static const struct of_device_id spi_geni_dt_match[] = {

-- 
2.34.1

