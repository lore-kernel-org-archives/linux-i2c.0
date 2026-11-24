Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517705;
	b=YnCebMZJ6aGOfni54wYMkXgdIOqGJjQEtrwyB1sSgK3IEDOY3vfYn7tCgp12KU024JG/
	 O1zSf2uaB+XbpVlMtQNaop31I2lVlvFi1OHv40TObo7Mcg1exNa0w9kSQm1/UM1b+DQx/
	 6HCAx362Qz3kTbzRNfIhxQqvZPSDc4Zn7Tvf1gHDIE0GHxVe3Srj8syZoan5KwO5IK7xh
	 A52cPqDM6/5i/4CsATlaVh2vNNwBT+37QBXz+Xii0wSbNs017ZoOE+yhGW3BBe6ulqfm9
	 CECXetgIvYZe4UMauMJ6C/+58ymPOEgAWev4JzpZ4JjejKPJx9PXQdZJ7cYWfpVP3Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517705;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DOV+Vt2yE5UBGw/kGxkYrpMgWcGa2KzKC7I34GIYjK4=;
	b=rgxTvCu8yl3fZilPvYXhwtjEKIc3WCmPzNB60rh9Os2N5/WpgdIfkFWwnATYGAEHRDk5
	 2Dt2pslFQP6tKaiiyXjTlibcDuNmp+z+0Rj5aQenrOEKxgvcXCUmMW0dLCn8OSxVwMwXL
	 9KnSq2eY49/TF19zPNpYLtWdwk3o3QViStA9oLQbfuL8/B+vHpseEtVUhMEk+G6Yuk+4n
	 N3D9BK/wpYyP+Y9PR1R6HZki9RBd7/6c9ZadL3IfkoZL81JSGFIVCxZ4Vra15OSve1EpE
	 rrERcZaU051K3Gu9IgF+1GXXr5puiRpAEAL6FFnxjoP9tj6ZqEBqTfMnPgqDhdCtjVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H8vdGkJ7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PJk5xvgm;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E04606A321
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 10:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91E04606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H8vdGkJ7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PJk5xvgm
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8hOWq3850772
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 10:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DOV+Vt2yE5UBGw/kGxkYrpMgWcGa2KzKC7I
	34GIYjK4=; b=H8vdGkJ7/EnJqDyJmlgndRh8DOjvqf8vnYHL4F2yOij9h8gZy3I
	zK05lpvdUSW5FiAcrMUSfPLFr5WMx2nHd855+jD8EHvqqgMqJVR3AdFJYW3QKRVK
	9ryXzKivtnzfsdDEOUFCHwH7iwQjcD9GupcbD6lHeaKqrF9se/04f/z9JIShFOX4
	Qa4G1bNaYMxvG0KciAH6TX6tIHUGwgSA9sKM6iFSnVkIgfLOJYyK8ocQKY7OuqBR
	DndEzv1YksStRaesKNxSnMCmwAKcAaJAjTt/8Ttw42SkEXf1KRhxHJ5S34jhUXBs
	ivbwl3uPF8hXfcnYO3dwkBBT9xpOhSbiYjA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvb2b3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 10:55:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386ad819860so1903100eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795517703; x=1796122503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOV+Vt2yE5UBGw/kGxkYrpMgWcGa2KzKC7I34GIYjK4=;
        b=PJk5xvgmbPtIKieEDDdwgpqvw9UJgWfxqE/H8/T4c55TSCPXl6CxImQbfazRW5oTQh
         jMX9f0IwYITGJi5Hy/V4YUQPZmRLB7BjsWagL7FyyyS/q9jFScKvk1m8kavqKdEBK57J
         tXpYQk+8yJ9EmTRRsnO/AKBwPnowtt0b7QT5JB0BV/yBEXZCj5G3DZlYD3/zFUe+HwLy
         lkBgHaqdQ+Pg4r6iAeiefYafiipFLE6fvHZFIZVD9YNAwLQp5vNW5mKJmJi9yTDl1TU8
         S74cBZ9Pz/9gdWEKa6y7LtHj5F95bBabBNeI9AcxAfJG0DC11AQn3cWJ/lOCC/aehd8A
         0/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517703; x=1796122503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOV+Vt2yE5UBGw/kGxkYrpMgWcGa2KzKC7I34GIYjK4=;
        b=nI+3/xTihXBgJbXVd6ld28jAFDrw6mFFvo4ZVre8u/JqmbgOjQ7Jj0ELufKNkltDA2
         UEtw/O5O15bbcPzrPzTrDPvao8vBHXWlrVB98jPJ3QXfFoBpY393ekfPuxxoDGTJPLoL
         T5s8iaxNZ0LEyiIFgd4SHa/tu5jccFJgy/DgXJ/UBcvnDg0GQ1lHPVXf6CAP8EFcnKKr
         L/cLxMKOGvGxS2xgGD+HdThbM/aAYzICgqTS1OII5xNCRAqhY50uPPcSgBKK671qHDNh
         qXpmzaiaDatsV9y6WONRfVn3/y0dEH5ZM+d/ytQj5XFYS7vpHw7POTreKkkX5iJv9so+
         L8Zg==
X-Forwarded-Encrypted: i=1; AL+hErFGiwOSLfRjfNmaWchvEWSX2g1TvJLPfZ/4aDKGWO8jCxSgACaIda7QF4r1dISvXglE7+SyND2+6Ik=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NwTD3K45WcsUzv585+H45EV/QdvL2Zmsqg4NDO8DzxIxfOwzV
	5rSy6ofpOvWxgfZ8LNI/k4oZk8n6NoAtkYUDWBOsbl1gE4P4kNvklBjgTdHV9sKBZghuik+Fcnv
	DpVSBdDKsmIYZ4Uem08PARgkMn9RaSTV6R2QUSYENy9dOmktl0nDSnAJ6lVGjbqk=
X-Gm-Gg: AZFdTZdik9o39Uk8AliK+gloWLHznhVjwyHA2djV8/Sc5+r549iHLpWzdRECfV2VmUH
	n4vtdbjJjeK6EK8ym6RZGgljQu94goBRjmQAe4Z0OEHevmLRMq/Gb+ytFR5ZrfCVlsvRi7C9eJz
	HmM98M16Ni09y0ZD7bKTljTO/ca2O97kFVhLH+MkuUxJIMgM5HW9mcHj2qxt6EVRQ8DLtywWmyG
	8WEu42ZH+QZCs6xwEuue+mcBEz+V5nGeyppetQaZVFVxIU+0Dege3qfAZLVL8L7zYHlR/QXA5f/
	B0H7jvzlr7nYznq3Yixch6yviiMcnVg3/pIw5ZtWsbwELjDl4gPwHMr48/pveCfrsD4mOMox3wH
	VqqT9erJS6tcw3kC+7YiKh4X0tpLZFDKRRu8m54hUqsXK4xXR7DGYzh6b6UPwSay8QTQK6GULmQ
	Q3wbpx6SX91UmXX18/Oah+DHstRT6RIdUubyv/5QdQcQpDCzXlkjSlg6gY
X-Received: by 2002:a05:7300:1c1e:b0:386:b0db:944b with SMTP id 5a478bee46e88-386b0db98c0mr5942101eec.22.1795517702506;
        Tue, 24 Nov 2026 02:55:02 -0800 (PST)
X-Received: by 2002:a05:7300:1c1e:b0:386:b0db:944b with SMTP id 5a478bee46e88-386b0db98c0mr5942085eec.22.1795517702088;
        Tue, 24 Nov 2026 02:55:02 -0800 (PST)
Received: from hu-ymg-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm2282257eec.17.2026.11.24.02.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:55:01 -0800 (PST)
From: Yadu M G <yadu.mg@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: i2c: Add compatible for Seca SoC
Date: Tue, 24 Nov 2026 16:24:56 +0530
Message-ID: <0439e03884c02c9edbec89132b526aaf8f54ae23.1795517696.git.yadu.mg@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aJ1lOr9m c=1 sm=1 tr=0 ts=6b056d07 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lHObh2IfMKzVuqTG74EA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: zQugcI6V1fO_OL7A7W3LwmEY0nJnefFm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfXy3cmZC2CKjKt
 Ct6q3gFkL4njY2rWX88wH++Pwd9LW8zAFapkd1Rh2RV/CQZWtCJBdzg6W3yufNQUPN0sEHLoirY
 bI5BDhu153YK5CP7rvpnqAx96ktnKR4=
X-Proofpoint-GUID: zQugcI6V1fO_OL7A7W3LwmEY0nJnefFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MiBTYWx0ZWRfX3zn0ae6PHJOa
 /Sha3oAIcQXY7surRVBx0lsj0yPcnekoSJm2i39xeTwhcRg/yzJGuGG0lHZcgufSwVe+0ZiYFxy
 Mz8EQ70+ak6iUF3pIErGABWvRTIXKqngrAVPjUwP2AXslZB+Ev2js26mMf2CaIJ32wpp/sQnrVL
 edPlhcSDf22E3+cdW8WKvcHwHFZDuBRtShrC++rrKjPzL2gEtMPBCzm+t8IscsqdksnWPZxiUD1
 Xj76x1r/XJwvjw6qXl4I1VzZxtukjNP+bewgL6r1LtN85z/9sodm0+wL6vR4xN/8nYdGVmoarp2
 U6zLhaZyFwY2RtJNxY/CGosa1FbeJLa5oVxwW90Ox/EoAQwLG9XCORRSBf1OoA2TvWedO6BlXlf
 YvoLbvjYuO4p0RG13fPasCNzE4HiU/WYgRztVjV4qeKCAGG1tCxCQ5zgj76oAoI14+J1/vhTZy2
 Xiz6kwomdX+36LwMt5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240042

Document QUP GENI I2C controller on Qualcomm Seca SoC which is
compatible with the SA8255P controller.

Signed-off-by: Yadu M G <yadu.mg@oss.qualcomm.com>
---
The Seca SoC device tree using this compatible will be posted as a
separate series.

This series was prepared with help from an AI coding assistant
(Claude). It assisted with review on the device tree, bindings and
driver (formatting and alignment fixes), rewording commit messages,
and running the validation steps (checkpatch, dt_binding_check,
dtbs_check and W=1 builds). All changes were reviewed and tested on the
Seca Ride board.
---
 .../devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
index 04caf622b3ba..63895fdb51e2 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
@@ -16,6 +16,9 @@ properties:
       - items:
           - const: qcom,sa8797p-geni-i2c
           - const: qcom,sa8255p-geni-i2c
+      - items:
+          - const: qcom,secaau-geni-i2c
+          - const: qcom,sa8255p-geni-i2c
 
   reg:
     maxItems: 1

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.43.0

