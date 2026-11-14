Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655840;
	b=eh8/2skrUkdpaPqhY02Vdfuj3NvekZ1tnCru1eMesgVGhaFCfLhUJjKLRNVnr0dtS7dY
	 W1bHCy0BWnW6X2ULaGpIHA/1++TGS2NdTWu2z11LKSlaqQ27DcvzrSXm/LgI4V2aS16jE
	 Xp3B5CZAsLJXCsaUCJolV5mOnK5eGO5XWljt/bfhPXDFenjNYGKeJH88CwVGJglxwihKU
	 Hn/1f9+SDg42rl19JkrVrq97ZbPOKsjIFQR94pEyorVUZ76aBsO0JT/JguLlNLRkePdas
	 mB0TdbylueuTclSbL4LyFWOeXoO1DLr8D44Bo+bkXnYzrdZeRNrXF97bzjzMowy0V5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655840;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JtnzJyvk1KhH53ox2qEGTYmgQHbNRK/nZXY80+689io=;
	b=1Tp04qoGrbY2gQ8wX/RjuWAJ92BFj0U5VWVmmv8q85aiMbTE+2m54sU/C0/3z0+/mNiW
	 k7R/zdmbY03F/LVa+gaGYyHFlWu4aqNQZNyBcWItc5+kGM3yAWxpa5S1iUeBIImO2jmw0
	 pNa6oa/rTCbC9GAYYLBwrTvfrMf+feRm4kq7C8iM4lRXShq2rHrA8SJy5MfwXXmLOTKxo
	 0x+j1p655+BvZTNspTwa6efqYRWQc7H/3Rf9B4j7T6t+L16ktns99WvOjWjV1c2SefvzB
	 gdmSCyY/LZcpgit/XtkDbcrukMx29o4rvSnWJ9sv0l7TEEAr0z2j8rYk5f+YJiZa7kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pqurAJuF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bc7ziPU0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F0606A899
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83F0606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pqurAJuF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bc7ziPU0
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9x3rY3380261
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JtnzJyvk1KhH53ox2qEGTYmgQHbNRK/nZXY80+689io=; b=pqurAJuFTeiYXqDV
	PyIQkXvxpjpyOy9IqxV9p6GZJze3lWc3aHDuaHQxtr6RxRNlW8+MsC8+84GCVfkI
	5DaXgM+Cy0efyHNjf8yQdoFNskRnxVVOpvJCc1bvCCHlI/Rt+VsVPgeo7BKsjwb3
	XKEsbr/3xFQVB4ss74w2lVoxko9PIDGVoJ0wBJgHN5CsYSN09dXpIR5RI9Bq8bLt
	4omvte/5mvOkWdRsBKB6pETjJ98KpvnMLwqxG7JvNFJRPSpboiZTEasOfTuoSsq4
	YEmjCDkyHFLTPpEgvsL695fjCrtpuOVpyZdEXersqS6/EJ7MbdHvaK64FxMRYRRT
	lXZvcQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx0n29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:30:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91e9a0eae11so28261166d6.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655838; x=1795260638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtnzJyvk1KhH53ox2qEGTYmgQHbNRK/nZXY80+689io=;
        b=Bc7ziPU0uqwTepl5svhOvaFNo1R/P6fA7OYtr0UVoF1gR0b/UvIWOPnLrpTTnYH3p5
         1C0J3UUO0xd3Ply3G49xmiU3E7EseOCLOmdwHw2aU6aoSC+NRAovAlHdre3kEGzFffjS
         aImh3UCFKCbDX1K3H1CQsDPho/br5Qh26hqpQ948cuMMbiY1Wlg1qsZ4xOxpTJ2HG4C2
         gs0EQ7YfIRe/ujzGe7iyhd+LAwjuLqmsjTTKPPgN8sTl+uVJr9iplW4YwViUMT8LiFke
         nvjUR+y4bqTsJACfmpbsbj67WE6ilDjP3bNmVG52XHFyTNzM4gS5QQelaR41SNKOniUS
         NR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655838; x=1795260638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtnzJyvk1KhH53ox2qEGTYmgQHbNRK/nZXY80+689io=;
        b=qFEn8BlASNSDjqFGPSnNik0QrZtj9W8E+Vn5j2/1+9L7rchzcf63pCKsQIznpTOrtw
         Ns3rS4l0jkrrJeKqJJGi6wS/Ox9cu1+7s9uujCFR3IlscsOeiZ64FAhJbLCNoSIra1Kf
         p+opdehdS+hYmcYSggYDuyJ3YzNL9IGvgqrwbAxnOL68qmWNNfCkwSgnHHB7+v3sErt8
         gZmakY3C5BrM8L60V4p1el2KU5niBPoEeLfSdimrSFqA52u3DZuiwEu1zJaeikYqQ7L4
         CQ+LF3AE/O+ARhXn0nKgvZPmE3YzSnuIJfNod4zvuFL1oj+945CqKYU8o/HaZwLi8UPa
         REJg==
X-Forwarded-Encrypted: i=1; AL+hErEzOFJSkWfqOJ8Qlg2vl7a7hssir32KwINI0BETQe2XH5iEV/B0YifVs8BtEOfJs915Xsx7RO3hHH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SDJ+fHCfva0AQizuN5hVIbFX3eZ0WkGM2tMwVRJoW2MOOYZAX
	WnbymgJyrpmh7BPmqXETePJAomYM35tfJI/LSnyxAEPfDwG2HmNesEmhweJFi3HlYwDmp4NCI9F
	54GLy0zDnmHJmjEbFYP6u7P/eEGZ8KumV2h2Nf07s68Lo3QPeuBolfQUBB8oVE04=
X-Gm-Gg: AYBFou0W1e+eZXDijM3k0xzfahQMU/S26b7mSFCFDsMxaHZSLT1HzGy/OSM9IMmta3V
	9YrC05AtGD6kmfOS8VujXL/Yi4K4GJoot1worRaGBDe7nfrxsCOsnKWFUNrSVgl6gXPbMvDLs/H
	obzv8+mypH8hiAnbm3G3zepCpxNxIqcrDOhsWe0wp/FrQ3jua++f9J3tVSsMBW5JsjsJPapcK52
	1dJnrfgvktWQ1B6PN+2nOg20qrjwKpHj2Fx+j7rpwwDzN7sUOvoL2prq5TkVEnNufA+w6hIvCGZ
	B1TdofeHWxhbwGyseYJdqIgMMlg1xeSCHDa7Di0GpjK6edKWe2vJ/CtK73C9T9PI1QMTxjdqDrj
	kWEQT2IGFdlPL2+hiaP8A6FgyEcgT52FNdfr2kCKZTBYOGRJeGafMSgHflOqvlxA22HgjCET9f3
	9I9mhC+fB+C5dip5q4ICtjpve9BFcOecS5tUVL3nkJ
X-Received: by 2002:a0c:f00e:0:b0:91f:119c:49e7 with SMTP id 6a1803df08f44-91f242183a5mr64200986d6.33.1794655837807;
        Sat, 14 Nov 2026 03:30:37 -0800 (PST)
X-Received: by 2002:a0c:f00e:0:b0:91f:119c:49e7 with SMTP id 6a1803df08f44-91f242183a5mr64200736d6.33.1794655837376;
        Sat, 14 Nov 2026 03:30:37 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:30:36 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:23 +0800
Subject: [PATCH v7 06/23] phy: qcom-mipi-csi2: Add SM8750 support
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-6-8ff2a11835f6@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=1231;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=WftKjWMmd6ufkhmpBXP+kU2zClT4Pa5uPn8ECol2Zvc=;
 b=1hq3oXdyhFU9AflJEQbTquWWh8o+HWgH0+JcuLjn6dZoVnqZtl2X29Hz4G832z78mH6JrsmOn
 5bOzwxRADg0DavMNQ2fCQoeoL6og74SBbUdPXifKfoxZgdufnUPeutY
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfXw1+ekhHYwU4x
 SUp8iwfGrvEQd4MqbcyoiTl/DnojUJg9b2rvy1PcRUSTVZ3CBO1k57EWwOKZ/isuhqz7Ei5SUtI
 FbM/FuKWxqwYfKGA7z4Ej0fxqbnT9eFEU3cbFJAD/mI4YVNzFdFSzgkf/KaJ+6GcvzwooIOAvsV
 vVIAJQX42lcv1Uu6W8WvUk+Zlwrs3N+QzkgL4ou6MUjYZiJ2Z1PNAu9UpPuXaGNa+b+leFo5+zN
 QqpXP9bz6xb3hU624et14eBWUe8Y/Cwx+13w11JqHitJ0IbHIVxu4HM7b+Uft31ISc9K2h8VhAd
 WFs+ax6H6j6jRnPzxCMQIGq0VFpIH/tOt6o5Wy6c4H+1ThEWhckYI1svhxOp5rEiXl41R1CmzRY
 f8kSbxdwE5JO7g6KGFveYkFAVjZjMMH/R+qg5uY5e2o/3oZydNtSgsz3wtqMML8x7d1/yR2IKoj
 s+r0y9q1BOOMqC5RfUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX3s/M+jHsf+Bj
 r8WzL65wZFiJtFUF37qyM4S+W98MCWQG4jlLI4xbnlhkG2PaoaiRkGXFOrXV3bS6yMOisJ661ze
 1tv20U5BdGHG21DGW5tyM4AqZysWlaM=
X-Proofpoint-ORIG-GUID: a2lxfFzKXEpuTOmbeTLxhHMSZEAfFKnO
X-Proofpoint-GUID: a2lxfFzKXEpuTOmbeTLxhHMSZEAfFKnO
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af8465e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ccvM8GEhhlxfBWNg_LwA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add the SM8750 CSI2 DPHY compatible to the match table, using the 3nm
DPHY configuration.

The SM8750 CSIPHY nodes only carry "qcom,sm8750-csi2-phy" with no
fallback compatible, so without this entry no driver matches them and
the PHYs stay unbound.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c
index 165e3d026872db85e54a99c5dd25ca68a1a4e450..a672bf318487b16aacd1ecf165554cde3f38e292 100644
--- a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c
+++ b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c
@@ -444,6 +444,7 @@ static int phy_qcom_mipi_csi2_probe(struct platform_device *pdev)
 
 static const struct of_device_id phy_qcom_mipi_csi2_of_match_table[] = {
 	{ .compatible	= "qcom,kaanapali-csi2-phy", .data = &mipi_csi2_dphy_3nm_kaanapali },
+	{ .compatible	= "qcom,sm8750-csi2-phy", .data = &mipi_csi2_dphy_3nm_kaanapali },
 	{ .compatible	= "qcom,x1e80100-csi2-phy", .data = &mipi_csi2_dphy_4nm_x1e },
 	{ }
 };

-- 
2.34.1

