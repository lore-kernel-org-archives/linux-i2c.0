Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7536F434
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342299; cv=none; b=QvEesjq2nO6OiPM0gTFQwdPGQmT3xzde1/nwGz3LTtRDRas4AoViV07Z1n7MiwCmtc1857f+kBi3uqfFkXpjgq2zdDu+erw1G992PaOEw+U/INlPopZSs5OZAurT5bROATeaJuF8KDTiVZ++H7RRL7X9dLWsX8oM6DxVLbTZ6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342299; c=relaxed/simple;
	bh=HEn5owEzeJIUYkdvn4DQSoUKQdn9M8eLHqPgfVbyGMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMvn6d/7KdrzlHFv43/SmrWIgp45SOf7BAFyKiPBgw2Q/JdS+M69/dXC89ywzxt28U5MfbJsFiH5Zz8HZ7Sbn+FJvWe6Ire+WCigF/UuC4cqDP03fh0VhoeTuu0XSF+AUWy2eTyoXm7NZBje4LoKbrs1HHZesUxrKkNfcZg6RSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JFClRWJO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fj4seuqC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JFClRWJO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fj4seuqC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxEPj401617
	for <linux-i2c@vger.kernel.org>; Mon, 6 Jul 2026 12:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=; b=JFClRWJO/YlvKXxt
	EPTan7Bb2wCcvP3ljtvtZjzTtxn9X/oJo2TEJ/HAmb+pQSKwSEV/Z0gNUsAg+HGp
	w6HgyrZUxnRD3q+7IWfDH5X62RGexHSNLTGzOUeq2dL2LoPSNk6QlXIjpQSF+Md5
	flrFBt6s2fKpQdszOkYGsCYuJQ5ovRF9aZdMY9Ly4KS9iJsfekBq0woUOh8k3cMV
	/RkmkqR4WcSAqZVtsYNjEqAk0a4iS4q0boV4t8SF1Q5kKlnTaNhLXh+6stEhQhqA
	eEHt6s2fdNhYEpAikHChcGddJF0Bgf8WoJVvm1/XIKUhDGVcw0Vt2kksgIYSgQFG
	fOJZIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3grm5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 12:45:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so311804385a.1
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 05:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341948; x=1783946748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
        b=fj4seuqC9Whszr1a1fXgwkaNf9JdZF2tvZeiOfWvS4JnE/t4kqtMo83ifD/kH01yqT
         x9QozejAvHigxSv0mqW/pChAg4m02encxUg68gci4k2yQ0SWkg8PS3a4dqXxRFurCqEK
         tXNgNjBKPIL+v0vjSB+LuCH+FW91USe43RpoeLahAOz9pHTb2s9zGMu6HjOHVKxhqlbd
         CPNN0vSO3y9qThtDDLAefAV7mUky0hVNQmmfSVR27eUVuyI0uPHCzNIkrQZxiDI0Htde
         +wPZrfH+r3e5mW+koN3F8NfYDB3rH9UZZgF7hHgr9PwzOVocIf9TCQikfc0nM/onCEeU
         G8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341948; x=1783946748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNrkEZw0kMBOjM8rF7wKaiZMIgE91+zaRIL+Y+aqlVA=;
        b=iS5Fq2oR3dwLSFEK4yDx+ZAjHsYYdAXS8FbJMCgp/HYRPgvoQfUY+H9n5zXWzfPwxx
         8gYkFhaDWCboI0qyHpNmUrzU9PGpHhORjJAZvPAobMxl1eqQGM+CWWMFOxmm2UuhHttN
         y7PqEaeN2Znueiy+6pYCRpSc7ciapyo0UTIi2+1zMXhoExbdASUEh+q+DTGSgXttK/NE
         70n3xRrlvuWxP8qmAZSW0pFCrAXecxlQhUJQvY9RpE3cX2zVJl85eS1RkzLNB2menq5w
         tk1ARiic6wGS09wlFkiD87A3dU14xHfW4HtX5v02z2XnUyjIj3v4tQzAyKK+nrQveE3/
         JB+A==
X-Forwarded-Encrypted: i=1; AHgh+RqmkKbM4CDFmoxo9e40g1TvCBrj92Da2eFtmnGM9vhvRgoVNCkiFSiivysSxW+oAGnmJHeR4JBrwjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZVgDqYQorMiaeNawQqa9CSoNcZRkT9uFiphCENR+YpR/NIuH
	rIUUMDeZMP92uGJGdiFPaYhS4T11QIrrm6drl7GcLw2JhVWtdFaPuWMDjNPXOJNKMj0g4QBefgk
	L42BBcAKFVQp/4P2LRS4lwAA0CUqNoVj3vnvJgfx5cTA92bQazk0t14QBnnGisr4=
X-Gm-Gg: AfdE7clJ8IX94EYslz+rnTdLV06Z36e6flAYEsKGa0QagbcSwiR3dtoewGGhJosc1sB
	+og7QzQbtKaxycNiXitE5zybf3SbXANVe6BPMsD6d03VDJ58GPqAz0fncgkeS72/zm+IvpdSza7
	AcoANgc8Eqrhq9NTWNFhgipJTaix9kqNW9j07rlkrSKmtfHdRKzYm/iraYESVkL/lRVcerBE5S6
	Xs7h/1PmTbsqCrba7uxJva1ImF/7UedIPt8F1FBN47It/3sD+3LvOJsJixClqRlx84gwKY3bDFI
	fwB5Oml/o/5CNnuWywLCo2EihShjWXyps5UFziq+svxrH5FLjirrtrpTLaOCvSSFZTRyaSnUmY7
	7/0eGEYuSlrXS6dbrfVycB9R02xHfyLjL8xzYSnl8
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id af79cd13be357-92e8b25f4aemr1773310885a.1.1783341948209;
        Mon, 06 Jul 2026 05:45:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4554:b0:92a:f74f:904 with SMTP id af79cd13be357-92e8b25f4aemr1773301685a.1.1783341947497;
        Mon, 06 Jul 2026 05:45:47 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:31 +0200
Subject: [PATCH v3 19/20] reset: rzg2l: use
 platform_device_set_of_node_from_dev()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-19-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HEn5owEzeJIUYkdvn4DQSoUKQdn9M8eLHqPgfVbyGMo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M9kHSk63/qP+xgNz2Y9PQyDSmFph3tQ8AC4
 5AtD4YK+kuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujPQAKCRAFnS7L/zaE
 w8S6D/wMyo30+5v8CLZilNJ79Z7wMDPBUG9sj14/UZP5eZoRp91qLsVzwolPCsq5U/qTKR3y/WF
 pZFakCrbpsJGqVqsKttIhxt2XpF4S1KfN1qC8pASBve+FNz8ZyKWhKOa9yoA01qpm32vrU5UPS/
 6u2lJxL4o4/rLQx8CT4xqgdtrSqHYMAonkNf5DACLGhTdz4ZNLZuCIo8GsF2zwWIH+cAxzjYd3E
 qqZHOI8wr8R2KnXC7H+MD0fJGcu5uQ+1j45nmYvg5cX3ElUN9riw6pLBLgO57aJVoCo/ucH6xOK
 GI4rJ/08Hr3PNBYdbcQEJMNE9yYMkjxiudHvOq8R4g0BwEVtdO1A8jbTcho0IUz53pA59iFnjyM
 ttMlMjXQhKSGu1dFNK6/elGJLMXC6E4nbUKvbby/LEHyHwLU0algPpHe9UPUYh3l/DrQAUt0udl
 +zNN2SMUOdAze/pIW2+l5sftft9+laItqGcD5M5bJTp7tPjVFcDskDf/PioUl0vtokzCPuP1F3s
 zP1G38H9ILdgjRhYpMdqqolRWhSDfehH//GwZSZfc6zSynuMNLzcAlJbgXUXpTthmlBlksAjYqr
 pTM9O9ZbxdBxzavLzPTTt8/695EpXxnwsMZ87oi6uApZGTqb0upieRcXVikiyju4bpSHudD6VYO
 /G0MaTqKJntCfNg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: spdnOVn4FKs8MQ80Pbg7j9uf9kMmtk-S
X-Proofpoint-ORIG-GUID: spdnOVn4FKs8MQ80Pbg7j9uf9kMmtk-S
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4ba37d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=kq0kPlqncbyAjjsh9XUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXxCkZVCgwGg8+
 OieSHDJBW62KdetLPZ1pzyy9yJrMvliLtQ6R99e365rsvqlYJsS36ozHKkZPVf/TGYBra7yiOKB
 J086DoK8DU/nnBJasPp/IdTd2JlK39ronDuZRMuqsq215m4bYyghhqoGi6nXvtUH1+gpS7JHkW4
 f58aqeGcVdzhkRbFEepXGYVoZ9s88XmOIlTrDw0ESSl+g3touHW26p78zR/9yJ9qLPrXAkcjoYO
 PL4kPW5m0QzMuA0bGwPnp9r8OvQ2uGlOgsnf48BnyC2uWuM6WLBRNAyjb5Dphb66YZ6Ozcrq11w
 1eb1/UDLezCyO1/aDVmHFWPKKHgYJ5CyfdkrG29k3Z1EcB5g07Nqzm+OTBy7LyQvJdk25yZ7NKV
 wjd1kho1/Tq1bhfEQ7MJ67ffOI8oHe5Fv2hp/3Q8IlOLk7ru4BRzFd3mhjRr5aC2ZTRsPMa3klH
 WqWaLKkdAuwZbez3Cdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXwWEzWLuY8Vce
 IGZsYvV4pFSr45QLn7fCQw0AEKbkgLB93n+HNLEqNuvFHiPq0Nftft6ns8rNhSLh6QdJ2Af8xJi
 eaQQfZJAavEkPizMItN59rDB8lQdTZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node from another device for
dynamically allocated platform devices with the provided helper.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index fd75d9601a3bfde7b7e3f6db287ec8c5c45a20ab..f003b360629c90bb37ed0ade7a675b5b0f28fa7e 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -249,7 +249,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	vdev->dev.parent = dev;
 	priv->vdev = vdev;
 
-	device_set_of_node_from_dev(&vdev->dev, dev);
+	platform_device_set_of_node_from_dev(vdev, dev);
 	error = platform_device_add(vdev);
 	if (error)
 		goto err_device_put;

-- 
2.47.3

