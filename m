Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4049B5AC
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161466; cv=none; b=u2VacKAmXUfF71ssQCsNlOXIaG4d7PfJefOijLFeXXVRKD9xC0whUcB0uVsJyWgWOpQOCummqvtIRle0vSS0ZF3zrUz3OVxSiXwMgPWPc6yYCGY5EuhIDQhWRx2iA5rU8y4vvF68tZdMHlMlHR57/WwYjVJGjf+hwmmAPMNovpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161466; c=relaxed/simple;
	bh=/Kz8rmJ3w4JWD/nnvCi5T5Y3mLydYHnT6e+WfEUqDDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RO0XljR/mF8hz3TW6MHYYEiVU+aIOceHPYuJjLFkjNVS9qq8tnkzL+pjs0m9KQaZLaig2/fVUBtgzFEmJfTLDyzeGdqLUy+EScIsCFRiLH0aqozFzQIYC9F2nagFs0JUrBmIgr7M48RpsOyMKupZAluHlzszhFVz2TAjOY/1dTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5KrpkRK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TwSPaoWR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5KrpkRK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwSPaoWR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2w6o3409878
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LoVLElwHITUNPzcQlYlqRAIUBeJ+LjBvdi36J5Mup3Q=; b=f5KrpkRK5RoMaWiq
	ufzsbNCodSf6fwfbp+28UKpozH8Irtws697lWi9YqsnBa+nR/6GR4Uo+wqGq8bIK
	O6zNsHjhKXmNBl1K6SKIgggga6r0KvQ7JAZhCH+JNgbfRn6EK1an1LemXkmmzwBq
	t0IUxpc42xgIZIaf1X6XKlSYOydXd+iXN6h894m/rpuYyWRlvU+Xxd6vq4sN9tZu
	h69eqwFbWdD7IEVc4gUNPXwqErPdmYNaCUZwcU/DMILKk7PWKzrU9Bc3Hu/Fr52e
	u3rJZ+K+feCgV2PEE3RQZVWRGhsNrwh1nFviFJYJb04izGls2GhqzbxiomDcutMS
	JG+obg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux86414f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:04:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33bb08e80a8so766289eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161458; x=1790766258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoVLElwHITUNPzcQlYlqRAIUBeJ+LjBvdi36J5Mup3Q=;
        b=TwSPaoWRnCv06gG+KYGwqQJy2wtYa33DKl+V8CY6v2YHqxWwpFQ3RiH0YrQcAsvm8w
         GppGiivbtBpMdC3z02gLj4mPutNTjSUqSDadrEwloi13aHyB0Tad28p/eYX6XrJCzqQY
         Ec+a46thIOdGTWOV0PZ/mrRoRRoFVGwcubW5MamPUisCi00wLEnVxks2CiUHJTMn7YKr
         hUv9GdMMReo7kA3FFhXV9ng+qeLWdxF6ZtTFwLZpne0CvvSGN/oeTaMZRuqFz9L5Qq2C
         h/+03PjJftAdlmDR5bXOo7hapQtSbfvjM6KDhS/5o+WNaGxJzX5CTzrM4KUfQIIRO0F8
         oKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161458; x=1790766258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoVLElwHITUNPzcQlYlqRAIUBeJ+LjBvdi36J5Mup3Q=;
        b=bg7pxPfE0TGiEg+GH9IeMkuA+66NjR2fsBM2WwoSBXBKi5ZfjXqkA6mMNZ3OW/fBK0
         k7YPyw1NZAmbytKoPiUDFVDZ2789DdfqdOZdP00kvDgVJDrgymVdtMazoaSVF3nsQAvC
         roL33WW0vT98RVKXG/6wv8cMUWHMakr+5TwbYGl7fZ4nkoUMUnFX5thyEFAC8WVEERqB
         Sab8iJ4NoBk/A54Sikgcnr7XiqKDRN8nh55Xy0ygVuYetx9NbXAjah59jUTmiIg2/4hL
         ujaGBGYSk6uuKzTnOKPVD5Sgz+ev/w2ElVNoy5/xulup92TMuKeW/BL/wgY95N/n/9jv
         A6vg==
X-Forwarded-Encrypted: i=1; AKwUvBxrtYOM0w97898BMbdOY2OtPvDvdinZ8nQGSJAlTGBuGW60tmRA6gQwR2YpnDnPk2yYq6K0DX1k2MQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nxwvw1FRCNNJwuylh9UW1RQN4St1Xn3YbHQJde6jr3p9d5O/Ss
	24e9LDzjSf7WVXaEGZ+0056shaAf4qmqTNQ7t9ohFsNi0wxK/RyP+fCsWgOqFHEudJ2n0jFkkpl
	xk2ebti9h34HH+7MyMkEbNM+byE+9y1dy9wQXNu9981fOR7zKOuSFbfWjRhz8Ul4=
X-Gm-Gg: AYBFou2fusC7z8Yxju1etcrpk6daEo2TSROmNQhexLaohcdnVqzBdha0Hmu2Xyr7zTb
	5QHBbY5dsMt7lSI2gmdWGNGZtFJNdl1Rjfh6Czu4J3aH8fAwki6v36bJgf1KEbV3xw3AwK61/6K
	enFPLNqFLDJ2il2fs6/+0wUiRdKucDy/Gj3wK46iEDiv2HtYopfgjuWsRQJRmT61d+TU/MNQxNk
	FJvDgCzKUr05PwZ9/5FCkX5uUAP4MwM+3n5zdZ1qblKYt8Kvwk8JS/6XjGANirIOqRdJ+ZbNO7U
	YVEJu2I4QTM8mREQTJfRWK2bjcs4OMeG6b/emhTDkg4ait2SzgJl6XaH1nH+VvwCaecqmiuKc2B
	JDQprUTDx69iPz0xj3qb59Phi/lvrnQ==
X-Received: by 2002:a05:693c:895a:10b0:33e:aa3d:ebe9 with SMTP id 5a478bee46e88-33eaa3dfa5cmr1956008eec.12.1790161458169;
        Wed, 23 Sep 2026 04:04:18 -0700 (PDT)
X-Received: by 2002:a05:693c:895a:10b0:33e:aa3d:ebe9 with SMTP id 5a478bee46e88-33eaa3dfa5cmr1955949eec.12.1790161456679;
        Wed, 23 Sep 2026 04:04:16 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:04:14 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:32:38 +0530
Subject: [PATCH RFC 07/15] arm64: dts: qcom: hawi: Add CAMSS and CSIPHY
 nodes for Hawi
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-maili-camss-v1-7-cbbb42e534ef@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=12343;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=Wbyvp1iAqQnUiFvhnb30D06C9GLaeouPpvkTRwgmjyY=;
 b=hwjHzLsT5q/lmvviVAocy5JJKBhK9GFbFHL2hyphkdSR2obhq1nAc2lE42eyzGTHbJX7cVsTB
 YAFoWu4ItD8AW2gV7/pcHd2LlWOZX10mPPTZNuhoFS8WiKgJUCYQMie
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-GUID: McuJf6vR2UQXird3JHgaIFtqjq8yKSEK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfXy3FARRhaiXLU
 tHuKH7l9Z1WEiba6AuIURWYK1+ZoGK/ZR9GgnOEo38rUyPaKKxjj014kCnDJl/8fIgEWDZbIHID
 aZMvkOzdTx2WgvISiDP5BUuB9x4xt6k=
X-Proofpoint-ORIG-GUID: McuJf6vR2UQXird3JHgaIFtqjq8yKSEK
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab3b233 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fGyK3mbf50CEbhCm-MYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX9VJu2l3nlIVb
 bYf3G4I8JWoT9WaVnGCumDee+UeS5xB5Z7oFxE1m81fF9fYirQwcRssoUO3fsseXLhLi8cE0nK/
 xwFMzk6Xuwl4gn0EyjKY+0/bF9jIjXaU/3ZJl2NvL+wT3k3AqQ0eTSbJuYQ/eujNmQ2w0fyuPkt
 XSndtdgkCdU/8p7cTaHPi4FTLnwjSSCYzcCspaW6TSqJFK3ndY5BUZuuvpdiEzX5xyDcaZ5eBnZ
 9fGqvE1YSX/MO3lwVFZJyBESq1UPdx211BgPOI8RsVNqWeLzwhL96wWQgFZVc3K1vYwhK0tPoG2
 71BvuE2lFM2VYaNCHUIBjs3Xj/uHFDQj9G/UV1jXav6U5ZzhZiYmf0rWF29i7iFx81z80uFfDVi
 SAn/9nx7qbvp+YTdTKQEWtx9LnxAL7RoZ6HDH+RI7k4BxHr/O+SzebxOWywHb+T3tyxlIOWkISp
 E9/d1Qk4tt5geV6Rpvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230044

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add dtsi to describe the Hawi CAMSS and CSIPHY block

3 x TPG
3 x CSID
2 x CSID Lite
3 x IFE
2 x IFE Lite
6 x CSIPHY

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Co-developed-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi.dtsi | 463 +++++++++++++++++++++++++++++++++++++
 1 file changed, 463 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
index c7ae8133b9cdc88133f6dccdf87bfa8bc88677e1..2e3286f29d7d6ed007289b5e04fcda34dec93039 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -548,6 +548,28 @@ soccp_smp2p_in: slave-kernel {
 		};
 	};
 
+	csiphy_mxc_opp_table: opp-table-mxc {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			required-opps = <&rpmhpd_opp_low_svs_d1_1>,
+					<&rpmhpd_opp_low_svs_d1_1>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			required-opps = <&rpmhpd_opp_low_svs_d1>,
+					<&rpmhpd_opp_low_svs_d0>;
+		};
+
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			required-opps = <&rpmhpd_opp_low_svs>,
+					<&rpmhpd_opp_nom>;
+		};
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 
@@ -3865,6 +3887,447 @@ lpass_ag_noc: interconnect@8f40000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		camss: isp@9253000 {
+			compatible = "qcom,hawi-camss";
+
+			reg = <0x0 0x09253000 0x0 0x5e80>,
+			      <0x0 0x09263000 0x0 0x5e80>,
+			      <0x0 0x09273000 0x0 0x5e80>,
+			      <0x0 0x092d3000 0x0 0x3880>,
+			      <0x0 0x092e7000 0x0 0x3880>,
+			      <0x0 0x093fd000 0x0 0x400>,
+			      <0x0 0x093fe000 0x0 0x400>,
+			      <0x0 0x093ff000 0x0 0x400>,
+			      <0x0 0x09151000 0x0 0x20000>,
+			      <0x0 0x09171000 0x0 0x20000>,
+			      <0x0 0x09191000 0x0 0x20000>,
+			      <0x0 0x092dc000 0x0 0x6800>,
+			      <0x0 0x092f0000 0x0 0x6800>;
+			reg-names = "csid0",
+				    "csid1",
+				    "csid2",
+				    "csid_lite0",
+				    "csid_lite1",
+				    "csitpg0",
+				    "csitpg1",
+				    "csitpg2",
+				    "vfe0",
+				    "vfe1",
+				    "vfe2",
+				    "vfe_lite0",
+				    "vfe_lite1";
+
+			clocks = <&camcc CAM_CC_CAMNOC_NRT_AXI_CLK>,
+				 <&camcc CAM_CC_CAMNOC_RT_AXI_CLK>,
+				 <&camcc CAM_CC_CAMNOC_DCD_XO_CLK>,
+				 <&camcc CAM_CC_CAM_TOP_AHB_CLK>,
+				 <&camcc CAM_CC_CAM_TOP_FAST_AHB_CLK>,
+				 <&camcc CAM_CC_TITAN_MNOC_HF_CLK>,
+				 <&camcc CAM_CC_TITAN_MNOC_SF_CLK>,
+				 <&camcc CAM_CC_CAMNOC_RT_TFE_0_MAIN_CLK>,
+				 <&camcc CAM_CC_CAMNOC_RT_TFE_1_MAIN_CLK>,
+				 <&camcc CAM_CC_CAMNOC_RT_TFE_2_MAIN_CLK>,
+				 <&camcc CAM_CC_CAMNOC_RT_IFE_LITE_CLK>,
+				 <&camcc CAM_CC_CSID_CLK>,
+				 <&camcc CAM_CC_CSID_CSIPHY_RX_CLK>,
+				 <&gcc GCC_CAMERA_HF_AXI_CLK>,
+				 <&gcc GCC_CAMERA_SF_AXI_CLK>,
+				 <&camcc CAM_CC_TFE_0_MAIN_CLK>,
+				 <&camcc CAM_CC_TFE_0_MAIN_FAST_AHB_CLK>,
+				 <&camcc CAM_CC_TFE_1_MAIN_CLK>,
+				 <&camcc CAM_CC_TFE_1_MAIN_FAST_AHB_CLK>,
+				 <&camcc CAM_CC_TFE_2_MAIN_CLK>,
+				 <&camcc CAM_CC_TFE_2_MAIN_FAST_AHB_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_AHB_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_CSID_CLK>,
+				 <&camcc CAM_CC_QDSS_DEBUG_XO_CLK>;
+			clock-names = "camnoc_nrt_axi",
+				      "camnoc_rt_axi",
+				      "camnoc_dcd_xo",
+				      "cpas_ahb",
+				      "cpas_fast_ahb",
+				      "cpas_mnoc_hf",
+				      "cpas_mnoc_sf",
+				      "cpas_vfe0",
+				      "cpas_vfe1",
+				      "cpas_vfe2",
+				      "cpas_vfe_lite",
+				      "csid",
+				      "csid_csiphy_rx",
+				      "gcc_axi_hf",
+				      "gcc_axi_sf",
+				      "vfe0",
+				      "vfe0_fast_ahb",
+				      "vfe1",
+				      "vfe1_fast_ahb",
+				      "vfe2",
+				      "vfe2_fast_ahb",
+				      "vfe_lite",
+				      "vfe_lite_ahb",
+				      "vfe_lite_cphy_rx",
+				      "vfe_lite_csid",
+				      "qdss_debug_xo";
+
+			interrupts = <GIC_ESPI 665 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 667 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 495 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 669 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 440 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 497 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 500 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 521 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 670 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_ESPI 441 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "csid0",
+					  "csid1",
+					  "csid2",
+					  "csid_lite0",
+					  "csid_lite1",
+					  "vfe0",
+					  "vfe1",
+					  "vfe2",
+					  "vfe_lite0",
+					  "vfe_lite1";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_CAMERA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "ahb",
+					     "hf_mnoc";
+
+			iommus = <&apps_smmu 0x1800 0x00>;
+
+			power-domains = <&camcc CAM_CC_TFE_0_GDSC>,
+					<&camcc CAM_CC_TFE_1_GDSC>,
+					<&camcc CAM_CC_TFE_2_GDSC>,
+					<&camcc CAM_CC_TITAN_TOP_GDSC>;
+			power-domain-names = "ife0",
+					     "ife1",
+					     "ife2",
+					     "top";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					camss_csiphy0_inep: endpoint {
+						remote-endpoint = <&csiphy0_out_ep>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					camss_csiphy1_inep: endpoint {
+						remote-endpoint = <&csiphy1_out_ep>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					camss_csiphy2_inep: endpoint {
+						remote-endpoint = <&csiphy2_out_ep>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+
+					camss_csiphy3_inep: endpoint {
+						remote-endpoint = <&csiphy3_out_ep>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+
+					camss_csiphy4_inep: endpoint {
+						remote-endpoint = <&csiphy4_out_ep>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+
+					camss_csiphy5_inep: endpoint {
+						remote-endpoint = <&csiphy5_out_ep>;
+					};
+				};
+			};
+		};
+
+		csiphy0: phy@9523000 {
+			compatible = "qcom,hawi-csi2-phy", "qcom,kaanapali-csi2-phy";
+			reg = <0x0 0x09523000 0x0 0x2000>;
+
+			clocks = <&camcc CAM_CC_CSIPHY0_CLK>,
+				 <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CORE_AHB_CLK>;
+			clock-names = "core",
+				      "timer",
+				      "ahb";
+
+			interrupts = <GIC_ESPI 541 IRQ_TYPE_EDGE_RISING>;
+
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>,
+					<&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "top",
+					     "mmcx",
+					     "mx";
+
+			operating-points-v2 = <&csiphy_mxc_opp_table>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy0_in_ep: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy0_out_ep: endpoint {
+						remote-endpoint = <&camss_csiphy0_inep>;
+					};
+				};
+			};
+		};
+
+		csiphy1: phy@9525000 {
+			compatible = "qcom,hawi-csi2-phy", "qcom,kaanapali-csi2-phy";
+			reg = <0x0 0x09525000 0x0 0x2000>;
+
+			clocks = <&camcc CAM_CC_CSIPHY1_CLK>,
+				 <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CORE_AHB_CLK>;
+			clock-names = "core",
+				      "timer",
+				      "ahb";
+
+			interrupts = <GIC_ESPI 542 IRQ_TYPE_EDGE_RISING>;
+
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>,
+					<&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "top",
+					     "mmcx",
+					     "mx";
+
+			operating-points-v2 = <&csiphy_mxc_opp_table>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy1_in_ep: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy1_out_ep: endpoint {
+						remote-endpoint = <&camss_csiphy1_inep>;
+					};
+				};
+			};
+		};
+
+		csiphy2: phy@9527000 {
+			compatible = "qcom,hawi-csi2-phy", "qcom,kaanapali-csi2-phy";
+			reg = <0x0 0x09527000 0x0 0x2000>;
+
+			clocks = <&camcc CAM_CC_CSIPHY2_CLK>,
+				 <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CORE_AHB_CLK>;
+			clock-names = "core",
+				      "timer",
+				      "ahb";
+
+			interrupts = <GIC_ESPI 543 IRQ_TYPE_EDGE_RISING>;
+
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>,
+					<&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "top",
+					     "mmcx",
+					     "mx";
+
+			operating-points-v2 = <&csiphy_mxc_opp_table>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy2_in_ep: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy2_out_ep: endpoint {
+						remote-endpoint = <&camss_csiphy2_inep>;
+					};
+				};
+			};
+		};
+
+		csiphy3: phy@9529000 {
+			compatible = "qcom,hawi-csi2-phy", "qcom,kaanapali-csi2-phy";
+			reg = <0x0 0x09529000 0x0 0x2000>;
+
+			clocks = <&camcc CAM_CC_CSIPHY3_CLK>,
+				 <&camcc CAM_CC_CSI3PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CORE_AHB_CLK>;
+			clock-names = "core",
+				      "timer",
+				      "ahb";
+
+			interrupts = <GIC_ESPI 512 IRQ_TYPE_EDGE_RISING>;
+
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>,
+					<&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "top",
+					     "mmcx",
+					     "mx";
+
+			operating-points-v2 = <&csiphy_mxc_opp_table>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy3_in_ep: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy3_out_ep: endpoint {
+						remote-endpoint = <&camss_csiphy3_inep>;
+					};
+				};
+			};
+		};
+
+		csiphy4: phy@952b000 {
+			compatible = "qcom,hawi-csi2-phy", "qcom,kaanapali-csi2-phy";
+			reg = <0x0 0x0952b000 0x0 0x2000>;
+
+			clocks = <&camcc CAM_CC_CSIPHY4_CLK>,
+				 <&camcc CAM_CC_CSI4PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CORE_AHB_CLK>;
+			clock-names = "core",
+				      "timer",
+				      "ahb";
+
+			interrupts = <GIC_ESPI 186 IRQ_TYPE_EDGE_RISING>;
+
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>,
+					<&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "top",
+					     "mmcx",
+					     "mx";
+
+			operating-points-v2 = <&csiphy_mxc_opp_table>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy4_in_ep: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy4_out_ep: endpoint {
+						remote-endpoint = <&camss_csiphy4_inep>;
+					};
+				};
+			};
+		};
+
+		csiphy5: phy@952d000 {
+			compatible = "qcom,hawi-csi2-phy", "qcom,kaanapali-csi2-phy";
+			reg = <0x0 0x0952d000 0x0 0x2000>;
+
+			clocks = <&camcc CAM_CC_CSIPHY5_CLK>,
+				 <&camcc CAM_CC_CSI5PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CORE_AHB_CLK>;
+			clock-names = "core",
+				      "timer",
+				      "ahb";
+
+			interrupts = <GIC_ESPI 153 IRQ_TYPE_EDGE_RISING>;
+
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>,
+					<&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "top",
+					     "mmcx",
+					     "mx";
+
+			operating-points-v2 = <&csiphy_mxc_opp_table>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy5_in_ep: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy5_out_ep: endpoint {
+						remote-endpoint = <&camss_csiphy5_inep>;
+					};
+				};
+			};
+		};
+
 		camcc: clock-controller@956d000 {
 			compatible = "qcom,hawi-camcc";
 			reg = <0x0 0x0956d000 0x0 0x80000>;

-- 
2.34.1

