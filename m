Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486E3D45CF
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539540; cv=none; b=Br1UM6J2b1FP2mi/FI/afKKoqK1++um8+oNSSKinxumNOgnuRQI77iXv3J+Xj/3131cDzViq9tS0wpWbxdk74leR+7laHn4gLbi6FZjnx7k+tBridBw+q6UujNQiut+rSUrMjsROXgvq77Tsx5FWHRqLEQhseB6aplECdjHmOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539540; c=relaxed/simple;
	bh=ZrUS/NnenvYCjb5pfCsn//onD0rmCvG2RI/jvr1V/hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pORD4Qna+ZNSXbmfwx4mlJpPOo4Bpf8BSBc7zvqb2SpwGptns9WQzJ5U+GBoigqIushO9stWEjbsU82oeiR4ymcGRsSmZykZAklA2COJeD0iuhdL61ppsgCzsv7jL5r3NdrcwqFf8vsVokeICB6Qj5seT3Utw/yl9OW+Xyt2AiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XmLYFkPG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HvZOVx7p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XmLYFkPG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HvZOVx7p"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7YE1t2043814
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 09:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=; b=XmLYFkPGPsf1JkR3
	tHbXt/iv/+pOUgfX70ac9uIwEItjtd1LHmJy7mC1eSZFKYGF3Cq9fTHXUnzeGBmz
	/VpnGG8HVXTgFzokDnuIWnp/4QgY+Lym7qVOeGkqccLklVlAvdxRSc186WX967Os
	nQv3ErHC2dMMJv5Y18ebao6fJZe7c/O4EuVhqxjviEx1Y+Zv/YXuatd4CKMqt2MQ
	waHnfeTeuRLbF+uuzNmLuxLdE/BMUGw0uGWEbTBv/Tz1bdFMXvKyLy6gLTnuGrFx
	ua8/ok2FwFRPlkBqSWKOQDF82DjrDoF3J/6KMDzmBtC9ZBbMNao9J8UuO5FITvZw
	mJTiwg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcggs7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 09:25:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1c7f135bso136076321cf.0
        for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539531; x=1785144331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=;
        b=HvZOVx7pes9UMuDypSL94vKLOcifMT7PRRfgJzGml6/Gb42nLfkCXAhbBNeILRP8hB
         9GBVNjAh2YbnXtLSH0Sq5u2LZabDDbvtjwfeHc1mmKdkI/wmLi5sGHqEb0yzOcSyaJLp
         V+pQjPymdf4Qjj3cRKlt4gHya2bxIo9IHLJC6ouZ5LZpeKwPLCBANHAGDhVG6eHbPzvn
         8PxuaW+X1Mr4wrTE+vRwlvTymglpsF+vQHyKR2Bsr0YjDn8cUQ+K1QzwLLWLDy6us8Uk
         8p24HjAkjcdT+sXgfAP9nIiA1yCeT2xUNr/NvdpQPxiBLfmZJYTJUgq62hfiyZZvcirX
         gRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539531; x=1785144331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pU1BTx3V21E1/GJSe0V/1tEDgkohw+OvR+uGXxiLMGw=;
        b=TUy1lAa5piMukZCH9cC38lIS7z0MIKd7UU5G6/3nTaiU2VBJ8kkLUAV8uaNm3ytkxd
         KPoFTAhZwAGsPtW8gdbRMd/i0lwja2GLsCEj3OkS8DJnI82KtimO9DNKh61OkOfIY1ZW
         ePSJ+sJ0chNkSp052iRSFt2KeEU+sK48ezJXlyHKQOPw8TfjV+usdvHtC8IGxfXpgLTp
         TbjLjuHb0qnffb5aCutUHiFUeQTERo2d3prybk0D9hoZcv6EathEaz/I0td4vvc/b3T4
         Zd7LVjNMlPrNYER8PTUhZBj1eHqVyyotuv5dL3ljW7K26nlrJ/P0XguEK08qAstuxv1e
         78NA==
X-Forwarded-Encrypted: i=1; AHgh+RrumYSehKj2XtuXMG18v+NZvk0/S0YbFBdy6L+NxH3k69Z6X8Erx5KtHuXTgUyE3T1Yst2yS/PevEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8AKUs0rgDLGBtIJIWJRLHRKjKaJLcrY2NmEogSh3oSAaxR3/p
	aH8i24P3EYpwaNsiagUdo936AZhLrPPKrPkT2Y9vRV0o4Dgk9OHAFBMbO7fz9y8hsF64KH/tQm1
	z2/dq7aSY9AuXlGJxBa0YSbL4CjiBgO1r1pCmpAVjZzSVWITupK/4BQ/5iqOPLqg=
X-Gm-Gg: AfdE7clFlSa9NTCPNM3M+SXUiQe6s1jVzj/dsNnK8cRf/gb4ZfSlgClZRi/7Z7juXJT
	M2EInNPN8oL+JsuJOHctujAjGTfG5G/fSNyXbLFJ/mIfHks6oZ37/uekkp8/QcM4zJJx0IQZLjT
	siXuDNWk/nPhKKSml+gZIeXlY9c0ZkP+xQIGX59aYcfLMOycRqBYid6jVx7zNmlX/Ub1QFBMQz7
	iG5mqdtUojojs2kgtWSvgA0KVzh12PgFIwiWnRPqVgDVhZ/jI0ocqbPtq3936jNlZhH+oAfl0zi
	6p9+EzJBPNupah4C021nasYUSFljd6ZdLJC9Y3rLQAPIuhCJxMRB27Sm4+3jt8iS+aF9BIFwZ+v
	4jLEUAjtLNWO9KYKOMxnp9FXmM6WgrQ==
X-Received: by 2002:a05:622a:13:b0:51c:12c3:efe1 with SMTP id d75a77b69052e-5213f66b7bamr122491281cf.42.1784539531246;
        Mon, 20 Jul 2026 02:25:31 -0700 (PDT)
X-Received: by 2002:a05:622a:13:b0:51c:12c3:efe1 with SMTP id d75a77b69052e-5213f66b7bamr122491051cf.42.1784539530849;
        Mon, 20 Jul 2026 02:25:30 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:29 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:49 +0200
Subject: [PATCH 2/8] i2c: pxa-pci: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-2-2dee93f42c54@oss.qualcomm.com>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: brgl@kernel.org, driver-core@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZrUS/NnenvYCjb5pfCsn//onD0rmCvG2RI/jvr1V/hI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel5RRr6FDYHe7Jyyb5uYqdruVF1jkNXdGz9x
 /SmPjU62fiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3peQAKCRAFnS7L/zaE
 w4UfD/4hGqcnN4YJaIbxls3DUyM4NsWC4IFRTcQ2thdYEI/wUb4fhVe+TyZ7PrPWrKx17P3wNAc
 maYIRBGRspgJFSLrKzyw/l5OMrFyyVo5Z/pJ7Dk0uXIabGxiELqzVXgd1WoxDuuTW4tgZJQQsNz
 aya2utaREZyKIpaxj3Roa5oFmv65+HJQAYnFL4K5NgfQAiEczNPuLe2ohktx4SzYNC2lv9sJmm/
 DHA4nfXFpGMYRwQ535aVbihSHmr1VdH2kZH3C+G/WUXDG2zcXQbEDRHBEOhpmLhdbvqSBENsqcX
 fC6rJWBiX+4Se5NDr4QwWa19rVDA7zPjcdlpN9JcNkqhFi9xrmkRXzjDUdQKm8EIVdHu3coyLeE
 dfcxPzHCmIAHb1itlp1OLHnZ9DJj87OFgfHqY29oOKKtNW95J+QJtOCwUlVFNwHyuCYraWwRy+a
 812PKPLgPzRsVfXkL/L7lzI/tunY/GnBcfOwpqKIihhVnA7CJuOZOAOJf3NLzzZPf5XVTB5OJ1y
 Sm73dsM4snyIEvT5gwzRjiYfEdW9H3342ztO571XE3VibNZU1J0bAZ7SEJoJH5prDBaV/jdLz+3
 RWkWUsdJASZAhP7p9ua3RxQqAYNsUMW6PQtT0H5gB8zcpf6TwgWLDgOPI+3GVCrq/4qo8tigfGI
 atX2+rRaKYcbS+Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: pHAtdp6wOgRbKJ0zlfBDCTnH7ia4uxcT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX6N6Z50sWcI6U
 +18N3kAsdzb23HoDmU8+E5KehY6lV0c/7g8upa+L7nb2+nv09A60a1nVk1I+ULhLNQfbDpBT4Vs
 ZOHP1j6Lkll/g4pMAlBHhq+xaJ7D8Ln19EQ1tWJvb6pSUEaBxPR9XHXZpz9qhetvdQgexFPzJGu
 pfTaame5bswSJvSfW7cQChCUxpNSkSuyJDyfv4PfzlELsZyNaz126xD0XsfePiunQvQlKW2HrFT
 IRpvqHhXOfiMHy0BU36HYnQr7oa4lhzz9Y15IfslL7NVcOaXRb4f+QpJVGNvVoEsltUgYB3QaMb
 8eYjI9ndq43dZYRcVCzaegykbl7o5IM6wJZ2NJby3NDYw0Kgj7OrlPmPsJ3uVK3TlV1Kwv8xpOM
 AP+KsonCQ6QI9K2jcYj9vtEyUaasuHti0r8z+TeMjjwvY5+5OG9qm7Kn+3HAYfEkn/uQIb1PzPd
 ugLB8vaE6VMZN4jn32A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXxObT1KENhsJ9
 Xhso+wIu1uARecQyFVwHm8D12zpEJBF4q0eUL7wHL547jk46NoPn+z4ZyEPmBb+GOiDoVLc6oXK
 gGSc8ZrMpZajMYWGAPz/bM5L1/pQ0ys=
X-Proofpoint-GUID: pHAtdp6wOgRbKJ0zlfBDCTnH7ia4uxcT
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5de98c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Dy7njVIJoQnLZkscNskA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-pxa-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
index 92a0647f08c69f841ca99caca757c1728b3f6fce..58532cf9f06d43a0f2173b962eb498c9e4bb81d0 100644
--- a/drivers/i2c/busses/i2c-pxa-pci.c
+++ b/drivers/i2c/busses/i2c-pxa-pci.c
@@ -77,7 +77,7 @@ static struct platform_device *add_i2c_device(struct pci_dev *dev, int bar)
 	}
 	pdev->dev.parent = &dev->dev;
 
-	platform_device_set_of_node(pdev, child);
+	platform_device_set_fwnode(pdev, of_fwnode_handle(child));
 
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret)

-- 
2.47.3

