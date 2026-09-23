Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9F489FD6
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161386; cv=none; b=rq1rM5syI8cgDUdIJ5IfigfzmsYIU2lNUsJFWilrqHTM6oA1uVV4ufz2W+Wb9kZOLnrUcBB2P0BL8DC8qtQ0XXIfER5LHcLUAaZpLJog4jiZtuSDNZVdX1toJgO+2pZqO36YQH4r6WjFBcvNOCHJSQIEyf/asHpwM/paceC+Rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161386; c=relaxed/simple;
	bh=dj2HV07iJbUKgotIBkxev1vjmCbbYX4o6QipMiXBuws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qfWr0W6+RJNxd3QLU9MaanyLksNYpZJTk5ktzf5J6ecAlxG9WVfUvxv42Q6NkqLdlFg8qmcoTWvqFcU++1Qr3ZUHRHjkSSBvMI92eObMH22KHftftjooliz6lKryLQdxyvTVu2LWLFyL9Fi+rU8LGLhe443MATq+0NrXvCijjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=no/e5dMp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cOOrEg0J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="no/e5dMp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cOOrEg0J"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2lfZ3087130
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LtSfTBfPvgBFmUK6LTNNqXLD4BtNlVBQw/rcqNOcjZc=; b=no/e5dMpJxN49WtF
	0k046cbxoKfTfxoJUL6U1HtZSsrtNVO5sPp9mazMRp/UUq/wUsdcgU3aTFFMYJD5
	2n4QbKUbXiQTLiNnebaJ/HpuOMtyREIMkOMgN7/mwD4CbAUkm3yYXDlW04/n9b7k
	OwH3toXo124U1lGay1WHD9HdPhaZGlkQt5wqjOzoxGnTQ6JhdwO8UYI6J9XuAQ5d
	JCFRNuzywOTBj3K5OOTSOwSXJF0JTD5UFclqDwYAUkAnYhYs0Nn9sx0I4P33JJPF
	8dQQe70gW8KndqLjx80T5m2IO+hYzVvo4EYXb2OJRVyAKmh8wkgr90eLNy04CASB
	z+CH7A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm8exa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:02:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso935947eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161376; x=1790766176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LtSfTBfPvgBFmUK6LTNNqXLD4BtNlVBQw/rcqNOcjZc=;
        b=cOOrEg0JlpV7HIDkWU9BdprPV0lzMRI5EKh2LUA4mKDTvHpJiGQZn3Q5mIkO0uzllU
         LGk7RO7oq67PB5pPv0JsP3sTUDQCUCiY299uyUE8HGOzPTQ5eea6pu+oC8eXXjmmJgxM
         kbQdQiborvLFlaprrWctbeVCp6RQVg7+U7jxz7OfIQQJW32FYkza1u3LUtWl1R/9KMiW
         qQsIDvHAPOp0lbFuynOB+8TLQvDqb3HpdwMVbgujD/mxK9xAbPbJoOyDfKj++FVYEmBn
         1wI9DmT3DwjXCST4OC5icOGEOkCw452Ax1ZahyAoUw7q7O7s4dv3RuyqDdV1R+GX0d31
         ASOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161376; x=1790766176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LtSfTBfPvgBFmUK6LTNNqXLD4BtNlVBQw/rcqNOcjZc=;
        b=LfA8delKVkq+YlbNynI0GT1g+mjvc11p0ENL+rUE/zmqB5yMGSbhRg26oN8TMnYGYy
         d9z3SIuybgkAF4QHvP1Gu+hwF84HzIANnDAkPvvj016NWqLypqBJhLiWpzV62golWo5N
         HP22DVkexDWjJxFrlf1Vh1OWUYynZvwaLg1n12OtizgsBzb2roK2cWJjxehQrZHfmfWD
         wKi4xwip5CViDlL+do+P5ifqE34wuKFsVPhiqDD60SCg9nxwUe3hFoW2wPZUbN9+bPiI
         ULhAolxFWgFerjInNr8cWj0JvHJ6SFrPrpA/hqJrVomU/IYj/hrggbehep6U9oW6WZZq
         eTjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNs9PNNbfUl2pJ9WmOTBz9EgNEeWUtWNYNnoyhNlle5MfGaQbzaaSu95w/Lw1r2Fr/RMCvyUN9548=@vger.kernel.org
X-Gm-Message-State: AFuF++k7yybEug03e8RqBEK1TTDe0UGqgq3GbGc8WYUHqicLZ32V9fTV
	5aW8Nl8YjCXrsrlzzSgxDhAe1zhzTdEB32rUM4q1FKT6czzgdOF731HNJ6s9h2FVB9d8UWFMEDN
	UZ5/IHsHDwOtboHVyTM6OOlZKp3P5enxVmM9OBh737zej0KCwcrVIGzpOVTRdPt4=
X-Gm-Gg: AYBFou30zuluIiCKi+Lj8YLAuAyiVeR22LxAij+RSNPgO3xfdJGKux7DfVpznOOHeL9
	9KwzTSf2xwNYJZbttUWKrSJTEEX/hhaxhz6JjrGzQvIrbaJL8xwBLdxJOlcDdd08XHrcVqSUm1N
	JPXjYJpZMWIoarMbxtsgH/bGjS6zGGncecqpqLlqf6PWdDie7XNKpVQfl70luzcEtwcMZ4QIp8r
	X1gabQOWLpAJMMxfArDhLalwEltAu3gqVLW2XKhSsdIhT4x0oxi/NzQM0yZZsb0Mmpx7WzAVwkQ
	RPZ+2Jy0oVoiuCrkZg0pSm54QJHP/3FwsyEe8b4je1YRZ86eCFNq7hitsSqinDv7JNvgjqpAkqK
	ROpxzxTCIl7JDOCTez9G1Gc8EBktxpw==
X-Received: by 2002:a05:693c:8950:20b0:314:75d9:4751 with SMTP id 5a478bee46e88-33e8d9c90e0mr2161004eec.20.1790161375615;
        Wed, 23 Sep 2026 04:02:55 -0700 (PDT)
X-Received: by 2002:a05:693c:8950:20b0:314:75d9:4751 with SMTP id 5a478bee46e88-33e8d9c90e0mr2160949eec.20.1790161374603;
        Wed, 23 Sep 2026 04:02:54 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:02:53 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:32:32 +0530
Subject: [PATCH RFC 01/15] dt-bindings: i2c: qcom,i2c-cci: Add Hawi
 compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-maili-camss-v1-1-cbbb42e534ef@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=1282;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=I9K6dqyuKuWaYIMstHojoCWyhkP+UlD/jEvqS2r1WK4=;
 b=fMqMgUdgNqosHNWEGIHnXmLcwDITd899XEMhKFVmcURT/DeeJSNsCYQGmfY+mBFVl2QkScFJo
 RVc137fNrsFADdM7QQB1ic3h4k43RN362ju+kK00r03loSLaDdVp5jU
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MyBTYWx0ZWRfX8S5qrNhU5Z6c
 VcgZlVi54ocAHnEmXHO11/D7QWFb1dcpT2ESaHSrJyU14GG7YiR7611UZ+0B/yiCzTLsbecF9rp
 0W0uttxQROO68hhGX91PcbmVAXcgjd4=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3b1e0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=phzA4CzYhpZqrDFsW3YA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: eOyJ6rPpAw8C2xSdNrRqX89NBwHHV3Po
X-Proofpoint-ORIG-GUID: eOyJ6rPpAw8C2xSdNrRqX89NBwHHV3Po
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MyBTYWx0ZWRfX37kjg2w8h4O5
 33E7exwqeypY0t40XKivrDMM4kDSoZ67tieReqXo+ZTsJHBVWVPd9cdummTw9cR9n8q2trBAUG/
 4nVMzUkVBVb4uCtsDf0nYkrKWmK65od2DBWANdum6ka6WGD/6/9R5cWcWDONjTbDcv69Q73ROZ7
 MtO7ZkVDxOd1C2sNhXhsHZukmdCvuUgX5htVVvFfoz9gtfwP6z+1zHd0f1Kf+qVxYXhTSdvmyKo
 7lB9eaVuI/reWPu+pFluRZ/88+sUHXAjs5gNJ2+zTHTPY8Zt0Ju/37pv5QbxO4KpasXfUhNApnX
 4Vox/OCweBs3s6pVl0IMQUyu7wOBYDFgobf5PLWBQZbZTF8f9ZEEK4vbAk9+zIwlZdVI+BvgFUN
 VF8idMmowTjX4bxVqQFvkMgySbUgME3nFuHe0c8hIFsqWZoVgvw6bIkT/SmzzS9N0tVW90IQM8W
 7+jIBsaoNvXY+ayGSuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230043

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Document the Camera Control Interface (CCI) compatible for the Qualcomm
Hawi platform. Like other recent platforms it requires two clocks, so
add it to the corresponding clocks constraint as well.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 1e8def25ec0ec1ef6b34859709d10a2a36fe36f5..b2b4d4bcf780792515ec153c873bace1764fb3e3 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-cci
+              - qcom,hawi-cci
               - qcom,kaanapali-cci
               - qcom,milos-cci
               - qcom,qcm2290-cci
@@ -137,6 +138,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-cci
+              - qcom,hawi-cci
               - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,qcs8300-cci

-- 
2.34.1

