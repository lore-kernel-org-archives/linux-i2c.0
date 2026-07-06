Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998CE430CF2
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341920; cv=none; b=pumNLRHYFGnE+F5ZLE+Xwa4S2GqKhOHzkFadtx4h4vP15hFQRcDXogmvkw6W2IuPTyo5dGs6pK5cCP3XQVYhJNMVamnE177VioLgD958yWNsAauCHvAL91oZITDALIH0vOhoECdS0wZkMxDZZ8AAUqgxj2oyINbhlxGK2yccA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341920; c=relaxed/simple;
	bh=+1w/ZPBEKC35lIaC+2VlK0kcwhdpXj4b1de+Kko1D9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=STu41tzRmlNiErE3EsG8EhR6W8nDCy/7BeB0bFmjCdeKvfayQ10ycFdUBg4WnjlQsI/x0BOoo//JDI3Ql4aiCF5R5pSp11yabOM9s1/p4EB6pK327j/ZfHOkBYvIl7l0AN+yJU8+RZo8ek8KienIbDOOQyNUHmvPY8s6AFxhtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=egnQ2Z5J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BKXUHuil; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="egnQ2Z5J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BKXUHuil"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Ax7nC245538
	for <linux-i2c@vger.kernel.org>; Mon, 6 Jul 2026 12:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yWy7bcZQwuuzEGhH6M9TUt1rOdo2WvLdyjbDuBMlhdA=; b=egnQ2Z5JIsW8dx+C
	u8ZNxCzHX4SWRQVEeSTnCHtfHzI5Za8qAqUcnBs0+107yrfXKqqJaDIB2u0a4qdw
	3zvy6xZX56ger6pSWmDNx0if3RgxUWVCuPQOG2+g/F9nEtFuGRsOmnRbKVr88MkS
	QSvdU3dPEIYIlYTXhyVQuNRHqB5ujD6vqW+QbMsBpzX3WcLcnYIbSjQvoktVZbD8
	Pi0uIkls8WltwBDbJpRvrcC4O8WtLNRfHnt9R+cYIaXaiaMzJ607KZFb7di2KNpu
	tNlEGchhAMcCdeMNTtF9JIqQJtABet4hsX+i4NX9vmypJl2Tmh87vfFUDwvwWGum
	tjodUg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98gjmj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 12:45:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e9a2b95b5so463738885a.2
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341912; x=1783946712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWy7bcZQwuuzEGhH6M9TUt1rOdo2WvLdyjbDuBMlhdA=;
        b=BKXUHuily2PvwlbN+teHcWzDzbmitsx+nhb9AN/ywiY7r/opHJaxqOziE95YGYZYDX
         ubPejah0SH7dfLszth7T0CybNemiMdz95NYMPy9OCFT9XOE/DP8tYk7Hsd46Zm5KKLxh
         qhbo7PReOqqPXi7c8rf7HIhz2r+6ajSwOakU441/m+LVCjCvHvITvxlJIyKS0CPeT/yQ
         QFZ5NqE41aeRLAkPTD9IGNMIz7CvpgXZJNdWNT2JSa8xbAHtz1Qmt4HZNcDnYGpEWujm
         Chn4YHavgddXqb2NAKplbNZ3y0Gxi8J9CHJ7FkexRa/n3/E3MWSNypOv2Tdt6npLL/Ct
         ZiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341912; x=1783946712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWy7bcZQwuuzEGhH6M9TUt1rOdo2WvLdyjbDuBMlhdA=;
        b=n1QcKCCcpb1fdATNflg/k/cCUS8ZSmAG/hnLy8QlAY1Yh/hejOSfAkM9g41Ujd+uIB
         VjVNvaTpV0Da1wiYEVM6+Zk+thERAcfEO/LrdY3Uop5BcFusS28bldMRjEcrOj2s6IkV
         I6/iuWUf3+8SPVGYAm8vrrLCfiTYQIGxsp42twCKn3ohsxaAMLRpjd/BU/Cy7IFtJg67
         +M4FXx3L9yG2hcj439Z6MfNhE5uBzdqy2vhcVCeLYogsvQvf/DR9VrO9eioBMpAKHcR4
         +eRkMwmvPaX0+dglkhbtq4t2kVSbZwEl9glOqF3xaD5GWs1PuHHwIKCgyohYcUU9pMma
         qKZw==
X-Forwarded-Encrypted: i=1; AHgh+RpMu4dG6EFXMl7Y6oOQiLxy0hd8ozsIPZN79WXR/PxT9vS100uGY4eyPKnIDC3EFHD7voadoZkkMJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgP7Wt1EsbF4xZVs4nDCVkbSvb/7qR47GJATVmCMmM969Nked
	mbDNWeKxVz/idEEYZnhhbCB59CRE0S3i5JI1Bq6CHpf63V4e5LNaF6tiqGkKQ2V0ICbL9xrQ5EJ
	Fll5uk/i8MyHABQeqog+MqZ967/5XYcfJQ4hepvs+r3TkKZkDELMtJY7dqAfFnc4=
X-Gm-Gg: AfdE7cnNGRQ+bcNoyyjDKYpc6bHFoT+QDtuCwYZNvWkazc37zU1Vekojr60rRlyiE0N
	4MAZZu1v1ECLjct78lajkDRu5hTb7botOGeLidRTI971HutbQgisHGFP9GyuORHU7pMKPwzr2G8
	T9sWudb4NtG6ZvzS/JTKrYeMqa4baJaaLwV8WvgEb3zLnownfPoksqIi4oI5Js2/ORrcCb/hyP1
	IF0Ucp3qxPGp055z+ijARgSmTTJ3L3JBn33OaJdr7QHa6E+MPrpmvYDawjrKsnPE9TJIjp9doGR
	gjAKq6ZZQHinP01jNxYz6xR3h7oNkONQ+gfLS2VF70Y6mlRzssKfROS8vHZJYpjX+qXWlN/eilc
	Ma4vQNch1raFgefqJCy2x8uq1cfcsFGi1qqNSToij
X-Received: by 2002:a05:620a:43a8:b0:92b:6805:917e with SMTP id af79cd13be357-92ebb72bf7emr41506285a.70.1783341911499;
        Mon, 06 Jul 2026 05:45:11 -0700 (PDT)
X-Received: by 2002:a05:620a:43a8:b0:92b:6805:917e with SMTP id af79cd13be357-92ebb72bf7emr41498585a.70.1783341911066;
        Mon, 06 Jul 2026 05:45:11 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:19 +0200
Subject: [PATCH v3 07/20] powerpc/powermac: use
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-7-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+1w/ZPBEKC35lIaC+2VlK0kcwhdpXj4b1de+Kko1D9g=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M0U6BWsLnbNRlpQxwDdS83jcJMNhZ/7eCG3
 cBpgbJrCuOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujNAAKCRAFnS7L/zaE
 w0wcD/9CEDRN/JtI/f1e/XC0nTt6drS5plkhZNCFHV5EZKxpgDTo06KnuPFGExy9v7E5rUTrZSd
 K/RONRwRA8d86X+ZL6U04BJU8VydBvO31cpLKQ7gRAfVYJD8MI8qYoyhV8tSTFdr3MFnuiVWS16
 pxw9ameDANBtKmCmhztyXe47aHDEdi2zHnyugwrFNK4tnqbvzbpFWtZ6YMbolsTe0FhEMZkl/5J
 SlB4vdmD9tlCmDWLoojLW8uyavDrafJdotxvQPFEB1CAWVRUhHIbiWa87lvPrbmr3N4HnPiuEWS
 0jo88f1RRjKnf/ACMLY0bQDKyXMMI50bdSuf6AghGyhRbrgRByN1waRkNW8IxiXsx48wXV8nXRk
 OlvTfMrQR0rKTTc5stHBEJWjR/fVz2s6r6FxRQ6HJ8zbXbHJAPN1DnPLRNF7AmNGG4tzQXHazSc
 yrKtXi8cE8BipFRwuXuZEeUxLEixu7ewIGIJos93NzNRnwxizNpfEReVReEUaaZnubo2cBtEglw
 FF7f3QsGJyjtfTTtc1oqYEi0sK+dx4JQdqknNzcF2DVrQ28taO90Ta2l4zSabwMV+1CiOm8wwpE
 EXhc0GB7kYUkAT2sJt5KM2eqKKsmBm4FeIgeO26w+V/+g0Sp7NVuoHW1Za7xkWCgbeqCH7VoWSu
 bX6IXrHrjAbXvrA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4ba358 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX2EhoRFZscHOR
 dOZN9JdPTtqXUeW8e8VRU72PzhWz4ysfU6tPjCLZttlM9mkOJb9ThgZP9q8wQd0Eo4mSbcQ2udw
 ny8VNgpjVLahAJG6054lgDfStUiD2uMeIFQsikdR46AQRFzBq26HlkDAPykNjQCZJZFxYVS4F9v
 pLm5kfx3RdyTx4n3Q2psFd4zz0mXmVuU3Gta8UTJdZyOncBLazIhPju95QoZwOi06p7/3nlZ0tR
 DNthp+p7oPyTq/GhayLkLoQC/qgv8RL4XodowekZ8pZU+SsgUxVF7GkNJc1mnN41GOasOH852iA
 DMyYj3UiJ6wuW1N1eESZxvG3ll0vL9j12Zu2unZETnHURS7lMa8Qp9N46EIKlo1ZoYeTPsrtGVW
 jm+Blrh5JUMAJcP1zJ6seLQlrX8f6paaulLgEN2RM2bzcl/R4X9zq+fQzp5YYr49oY25w6S0IBU
 KxKtC7y6AmC4Ho6kAXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX/j7YwzuiZpth
 kMOjvYw3Yedi2sutSBjJKXc/W2HUAnMumlHXSqtv4tNXHGAV5vbPVa4Lzk3QW7+83SUhKYazu2d
 8Yw0XaLS8AjfP46dKmpwXX6u8vfAYRM=
X-Proofpoint-GUID: ckmydnZ2Uq7r_Bqw5zN77kCWdQpkF18j
X-Proofpoint-ORIG-GUID: ckmydnZ2Uq7r_Bqw5zN77kCWdQpkF18j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 973f58771d9636605ed5d3e91b45008543b584d3..a175a32a222bab4cc7400f6ab6071f5630db2cb8 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
+		platform_device_set_of_node(bus->platform_dev, bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3

