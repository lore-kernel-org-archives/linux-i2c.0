Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558472DC79B
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354449; cv=none; b=Syg0nmLZx/8zKifNw0DuK6zQMAS6BeAQMsAoR+TD+6Vm7Lf97w+qoulDtXP4yvIJ9pMqpksIlOWjtQGxppyuArF13D4b4Xa14diSYxmBfnDqUb58vWoOEMCllbNeimnsHDvNkVDo2wqm2aaBHggQgVMMUVhN8+XCk5aooUhd2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354449; c=relaxed/simple;
	bh=1m0AW2cExEyKezaoaqpg9M8Sd9W7xIah4eoQaNoNaio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEPLP5PViwgnyLoGDkKFoV+sb9OLXaKJmcmd6yhx2g7j7uMCdHxYxODWiJXZmBH1dU+8x6Ynb/Psgo5ZRRLemHVrTE6JouEkpkGoCi4dN3vUNBmGI5GnIVvBsbOnNF3OwnoZepNlTXAf7EeVkGNjM+o4zA9rfnQkF7RLumIT81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U38oypav; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WfnrBFU6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U38oypav";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WfnrBFU6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2T0jC3815926
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=; b=U38oypavBMQHX5RM
	5DGo6FDgcziIR+bFjcD66h11aj4Zak1nBWnsmmy4BL0uNyqk4OOoDi8VlViPoqNz
	gcwUjAXUut08G0bW+Jku6vIOsM7mx3MUO9LbNdjuEZdKCkz3D78xRbBA3XGVKW1N
	+EU8lo1LerY6ObmfBqMRLu64nJzLgMwhgfJh3ZiTCZU2WGPZ8qbTCCKXTru3SBCm
	tmaKbCMYgNpPkycbfHHImPSC1aF1Jexy47T8eyH109lN+2ndPMR1gjwtHffYbIcm
	bX7/IKe7UXVgnq7l0bzp1rMYGM4p3cB0TM4ANHgxZM2WX3OtuoEDEOEn+WBO0Lna
	hdw/gA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa19qp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516cdd89225so294061cf.0
        for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352670; x=1779957470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=WfnrBFU6dZFOlfQlgTNVhRdesLRgSheSOpve58fLelm8zlgXTVO6tpA9VCWTVpRg/k
         azxIC351RvbmX0nTLel3xhwMzGA2wFIbaJN1mwGuzNVCbUYy3eUXRJNBSAETrzMbJfTX
         I3ikefhSnepQ4trYJIpljEGy7by1aykf4f9paV6C1O7O7XnfuYL3QSAUzaRz1oGmNFbl
         5qac+qlPh7lG2zbErn3jYn+caTqV4e1OA9MGHSWxcktNGfTEyt8YUGRtPZjKHISqBeDj
         tiKQnI6OJpFPMfNJGN2I7kaSfwZGnTyAGDvN3xxuKP2P/OqMkkHS/zdoctHxagnx0vX1
         4l6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352670; x=1779957470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiqGJIubV46C/XuNtoDonnq8kzRgQ9Nd2r1gbru07SI=;
        b=q2OG8SXgsohT/6E9rr7aBkHaz7MCNzOri0ueyzLnaXtEXxiNMu3I574ZRCF+e/pq8i
         Q8s1CGB0TlVzLm5+igZ4ExwYc9ppo/E6CVHCMO4hHM8RCaQxNw4P8V0pPZyamxgASfP4
         JyUSH75mHOHolw9P14Qlkw4kusxXX6N1znlC4zNgetO3ummBRRYYjJe5tnBffwhbFTpD
         IAuQnaxMSWAaIJZyQ13N1k2w9GuhCuw++s9iLVK69J3ED4kSdRK5gE1UkqM5h9oCucd3
         7o/euRU0rFPf35qQnWbmM++oEwJuMc3QRlUrASGXlfnLu7b22P+bZddHeqKJPGwQZDVK
         Odug==
X-Forwarded-Encrypted: i=1; AFNElJ9dzh8fUyeu9PMoTkgfDsogD233C6RhKPhwydWH+GM45fQgTzlhZfga/d8tHR6ArnW4wXECCWvgiwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7Xcqm5j7lt3EkFD/ZAC7zCuOs7s9Grgr+H8b+M5tFZerGZCd
	CImLB8ZES/BUTKSsg722KQQctr/d2p3i4dF4Wb8CdmbRMgoX2UbvLxLShGauE0d34oYJYYEfrwH
	OKs6yF1VEeU/5l4V1DBNIbfY2pmNLWcQAxNmoL09bqTqX3HlgYfev/Kb1ANvs7jU=
X-Gm-Gg: Acq92OFXdR3xXuiFQpP/CuOv/8Mv4xW1OoPqfCi54t4VzvmyJcB3xArG1ciL1kmpJl5
	k4B0C9vvuh0daPbhFU5uNOnpepbEMV3E353MxtQIp0udMJLX/SMW9rafbz1cG8HaRjf/E89rFig
	v/ZLovG5siGn7tkDi6dj9syFiBpGcMUz451OwX3mt1UZKt4JkLZ7/garH4YOs8hiGGNjuMZYifi
	J490QZLmxyHeS8+BcZbjTNrPxH7AbF8k3efxVI8ssO5iUazqbsE3bVLVzctvaUKlFxYh4eA+uzn
	R/MLqC+6DpGOX3IohKd8NILMjy7LTQr5MVWdx7wXvzMIA1zyGIZYetlQLhsR60ZLFQ4dMbezGgv
	WvcKJe7sg/WvFHz62xr/K0+vg4V98/ODbl7ODSfW2P3ZYForbyW4=
X-Received: by 2002:a05:622a:4a8b:b0:50d:7f66:dca with SMTP id d75a77b69052e-516c559259cmr24616471cf.33.1779352669698;
        Thu, 21 May 2026 01:37:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8b:b0:50d:7f66:dca with SMTP id d75a77b69052e-516c559259cmr24615921cf.33.1779352669133;
        Thu, 21 May 2026 01:37:49 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:48 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:37 +0200
Subject: [PATCH 14/23] pmdomain: imx: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-14-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1m0AW2cExEyKezaoaqpg9M8Sd9W7xIah4eoQaNoNaio=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQpYiqSx3VXdqiHIpIBUXjGa5jIwrjLGwoyq
 Gc54yDrEJyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKQAKCRAFnS7L/zaE
 w87wD/4ovbkfGrByBExY1MPjO+ImreTVfGSAkWmqsKw88uLrhkyEKGHDAQSZTZE3i+FHGY/E2yW
 vuQTwIIwn0C7jebh/ZrW5OyqlKI4SfaTV8SUVza9v/w9itsoAjqdwFfTCAYtkNU0wl3z6zPIVZW
 eC5a4J3DiTbAuwujwfo0CkVMKKHGy6dNnhLhd3c5wk59h91vvRJDexswgzczEKYHYVvQ5PwEm4e
 1v1iYFCMc+jXWVLyMZMWL3qxn2LKbLI3uzw2KaE5pLc6qjG7WxuULz1fW5kc1tPHEt2UjXdtXoB
 Bu7Z+OiX94cgaD4jcN5Qf59TAYUWoTBWptl6Az7wCYIDSl4Zd4dfb/jPCgTBcEaoQMRxdT7wBp6
 04C+yAy6ZZFgQPV6NKQYtrhr10zYyMFhXjVosvUBV+a6Ji0EiFri1X1eKbRIDWPoxE/pW/NgzA2
 EIK/OJH+xDImj3AWv689ACL46miN6U4MXZhQgeeo20WrtwVz6rOsNHISp9VfDNfODARqNyRDH4y
 gYdC059xHRA7PTGRRZGWyRdRrxEDYxRds5O0j5sxjShEOV3/CBXZC7cr7dJk55o60cuiR1C1RSD
 DTE3n/guGYAoDroJBWU9vFEHo/tJTqZkDlWp9VK5ukHDUrBufG9yMNLg0PxfB2qf+8O/s29Yr1k
 PBNeRIDE8C5ssiQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX5nePuA5w6Ukj
 k7ZeC8si6uikbixi/+hO+Enyo2F03PtjH+9b2QeRpjNzmTGI8+sHtF2GoJHWYFxaj4M5ZYZRW8s
 k3Pc02T7gnhZECo4zuSHAKDjJDkvB7CCyIds0LZMvQ1fJKIxYeqQWU5jUtzl99qlNtmBPrQm/cY
 uBHlGDRJWAZBmr9CSDqUDdmOyCglugssujLCYEKEiipE6OdnddBReHt98weFGKBAcz5j2Jeq3jI
 ZkdXJz99W/YvvMng/MLP/POlkOyIIQfW04qe+iJ8pjc829zIwlY59C29IRvR0l3du39jhc2577e
 8ExLDVDHGRKke4R3pyXhH7NpnvLpWf4bl6Pn9gyp19IDWNo7MJJkLGkrJnlJc1pLQNZhwgNdY3X
 rsq//J2PjCzQpLXdZmRoL50fucjjjhmFIBtyjMezVd32ovTcBL0lEY2JM18ykTs4+87oXvalSks
 jrRMc+LLLtcVe8sfBNQ==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec45e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=J9-S39C9qTGxOfEZqScA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: xVSa7vkLcKnufjUhPwCLT7TB_cocGuqL
X-Proofpoint-GUID: xVSa7vkLcKnufjUhPwCLT7TB_cocGuqL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pmdomain/imx/gpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 42e50c9b4fb9ffb96a20a462d4eb5168942a893c..abca5f449a226fbae4213926e1395c413160c950 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -487,8 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 			domain->ipg_rate_mhz = ipg_rate_mhz;
 
 			pd_pdev->dev.parent = &pdev->dev;
-			pd_pdev->dev.of_node = of_node_get(np);
-			pd_pdev->dev.fwnode = of_fwnode_handle(np);
+			platform_device_set_of_node(pd_pdev, np);
 
 			ret = platform_device_add(pd_pdev);
 			if (ret) {

-- 
2.47.3

