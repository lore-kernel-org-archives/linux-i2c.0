Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078F3D88E5
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539554; cv=none; b=VX+BEwzKAkWRTAzLsgCTAr13go/nEHOY9cjvD0naY4FWMLxU9M9MWpAZufRXMpzaXSzzL3u0pxQ6apeZTdJ7Q4997D5PC6JpLCtVfztOBY7tKs/hp6aCyr0Oa+o/Wczq4IrcghfAn03jd4HqXxSf/F+GkoDb0+lWd1MAyB0/QCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539554; c=relaxed/simple;
	bh=A6rTQywiVuri+akWPu8ZuzmrgFMwkmEBL5RABzyTsAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TObIXeYd9XC/wwuFDTVKm6D1wIEO8MlCka5vlvBpK2fzqgfocpqNjCsnEgfJo33Tewx1X8bqryNqVtRArZY+1PZzLC9i9P2JK3xF6OQJvLQlQA8zFQodB4Pw25vv4b5LzNSrQu6IryuHdMIrMh9cbxiqNoRMYjdPvObGJpc5wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTX3r2ny; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bof2vRMF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTX3r2ny";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bof2vRMF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RXJn1420259
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 09:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=; b=jTX3r2nyWsHMgzxn
	8FiVrwsN9vBocFeW49l7ldKA5XAZhAJvTnfLaGPyMqjBxsPnKZBOPmOYXmAuXLVY
	4sWAiXGaTX45boKk1A3m8XsO7Gmxi/ELddH67Z5gVDiX05ykqVAhWHKtR+3LGKie
	veQisNX1QTgE8ROX03T0wNSpfnKt6iykthul2wHTYqiKsUZQS+FSKYyXOCuBYwzx
	FP7tPplooLKcPdtEWKezKg9RXkJ/Rf/nlqNN+bdT6uAg8a8my1SerICuKrd5eD+U
	UQmT5/Vq/x0vfqtNbWmWRgO1GD1kO9nqhZUuC2tvSRXW5+IyGky9YO1InCixmuof
	tFEEDw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7wjs3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 09:25:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0ab07320so136279221cf.2
        for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 02:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784539547; x=1785144347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=;
        b=bof2vRMF1FcBIKSY4k90Qj6BOt5laGjy3hPHzYFIVsp2lVChc26CH7uBj9uJuKJNte
         JLFdoT8Xkf6941uH/C/YAJmcwbLqsPq6K/loowxxzIp1CaafPhpVQfJjEySdhV/sifim
         9mmrz1Xe0MUJTZorEXyEno877epONbAxN9OugH/j7HINeKpgPj3aVqhCK0os0E3MOcAf
         8Dl+wRMrCXUvxlALiXai8IxJ++IqdAaIRPcOcZMUMpdqaZMd25eP+FvizU2R8gtf3mV3
         L1RwI9UDdgFHCHaqrN1gjeQ+iAeTktky6WwvSxe5LrqNxc9JPpR7VeyeShkvWA97lgoz
         GCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784539547; x=1785144347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azoonAs2rZvyyYgYMRjUol9O+q8eXf7OwF52OR7cKds=;
        b=hAj2jPALf0gYArhcGcR3oFa4WNgXwK5QENZ07v6acHuhYDJ5AFoIZ4wCxAGDcMxFHy
         IWhDD+1w5QAweY6ykEmQ5cQkwECGW3Ajit0jOh7qbbHXMxKrNmC7OGmlGuYee4e3gxCs
         axVD9lBgL/5vb2zZM3TIJrj2lANVA33FgY3Yi+/8VIZrbdqEc5YRD3ReA7tN2p/qMJ5z
         vJ28pWv9m30gzHjNON7KxrdPNjAEC1dByQWMX34DgGvdYLodex9o6x98jhjsLNtGOFs4
         VnNjEiA02g4tH/zScwgpy4HL6vnx+vOiW6NVqatkw90nD9w5wlyFDSCPawxKYLsS9CK7
         1GPA==
X-Forwarded-Encrypted: i=1; AHgh+RrhI1nbNBrR6oid+7UjYqRZx2M/CF33AW4lo8lWbQQmP4K5uD8Ngtm2eC5UloNRdAnHhgeFHNk1SQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3ExnUjbJiugvjVINiasIEhxvVkkGEJ0eIDheALEgPof6DhSz
	26mEBkTKbLq23wNKlgEsNpatVwqfkVFrz/QrjD+2k/1Twy985jRNtXC5vlv81d9WGpcmyByaaMH
	FQieVHjjNbpxzB1h9ajQsdFyulzBo4wlLLIWNCOw2fkJOVfLeq9XBVSsJDhy1PCQ=
X-Gm-Gg: AfdE7clUwX9RnuT16hZ+dfS8VkhV8dbJl2OOiHLQ/o9jqcjyY7fPS1yOUqXqVzt21+o
	0pNDnxrxj971+TEW098/TIXq7yshYYiQy76hOGiBrlnhxzgVr+E6RNforXn3iP34I0fnlgKMeM1
	MJ78yhZaygauL//D5shU0xkkbk+t69tU3u7zWvW1fzdvLb+8TCyQy0rTMau0ZQz0p11lAbYo1Em
	F6tdAtDINsPzSepPKEtpq6/1PkMxi8UGwpLhhN4HT9R5/SAcJK1Zlkr635ojaWUg0oCIdLAogC5
	LM9XKGjTOPdLy18RWniyQNb8d/mWeIAicFbxmXc5VYx1+8YQoL5PPf5pw8Js8NsB1QZd3cogVuk
	Qmufe5ZKpELVEzdJPq9MkdRRocc4KOw==
X-Received: by 2002:ac8:59c5:0:b0:51a:8c9b:649f with SMTP id d75a77b69052e-5213d0c7347mr123946861cf.67.1784539546655;
        Mon, 20 Jul 2026 02:25:46 -0700 (PDT)
X-Received: by 2002:ac8:59c5:0:b0:51a:8c9b:649f with SMTP id d75a77b69052e-5213d0c7347mr123946431cf.67.1784539546190;
        Mon, 20 Jul 2026 02:25:46 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:65fa:60cb:c205:d511])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955de88951sm62228205e9.3.2026.07.20.02.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:25:45 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 11:24:53 +0200
Subject: [PATCH 6/8] mfd: tps6586: use platform_device_set_fwnode()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-pdev-set-fwnode-instead-of-of-node-v1-6-2dee93f42c54@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=A6rTQywiVuri+akWPu8ZuzmrgFMwkmEBL5RABzyTsAA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqXel+JVh2LLebfg0Z60TjK/ZqooFO/E063bUsn
 DcFFoaXAHyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCal3pfgAKCRAFnS7L/zaE
 w2/uD/0aPKY8tpTuQyVi4bVwQxAwSe5GwjC2DtgnMo6nh/diKnBHmP8CrS17h3oxzaLBbpoQsyv
 Sz7j//KhI2uvM/6lsN12ObBAmWBE1OIY2cI2EITf9uARRqijYfV+vh3K099Z2WSPyIztcA7JV1a
 LXzZb7ugoqz2dMzT1dYxuTYTKlupbAIUqn3iCnldu412Ogk7U1TlAiPXUx8NUiwcSTgNJH6JtjG
 ybhBOe1z5foPXCLYPHg/mB/yn58+1Cndf7uN6COgbJKsYybBcSfm7GwhrfIR3kOESCkTPUQ/wKa
 CtSLDtJYyB3h0iOJVjA1wxmvViV3DncYABZdM9JhjlGr5xekEnOEIkt5J6dyoA6W3qAdQfM+wDe
 WHnnp/KwxzQBF0DZMHAzzpoGyj4CiF+A0L9ufwf2uDn/Gr6QSF3i1uh7g3B9Au9fYk4fZJVPzjL
 EreBD5gpBiQV4/muSmW+73v2B/YzUR/9/++LXGtpFgoyz9CAYZz8Hc2q0lwgczqGG/yerhUZ7Iw
 2svI6neY8mLXD64gJd+3QIabFLBehBoppvlO1WSrRtFtjFWC6wlYnhuX3lwh2ugV3XC2oWE+fzO
 N24Bq1v0R7mTGsTx4YHFYiArfM737K0E9k47o1YA1cm04PfUgXMiuD7g5S8kXEV39VNN8Mvf0py
 8hgioC0XlGh1TYg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfXyLq7pUV/Ix93
 0jFGaIw6fWdw0TYcrR478/MlhpER0RXtLfOqCYVw8ZlAlkiXXtXPsB3K9UMC8BrAd+MqiVdQ0Cv
 LTABElipWUVvDdhI8oXNWUEGg857/jCJz/ZDL94eoZco9pod0TBHHOWuTCuqLgslJSV5LxgptgS
 pXZr1n7RPDNswkzmRjk6gxr48+EEUWT6zvESlK9oFcjpDDorVnltG4snbv9iROCCCRL0YNaGVmD
 zzFKVi7FZsqxe5lOuO0/AIaqzfMuksJMkmU3aumEdsGAT9QCiY1rZRIRPIdm+EUv0cv5NxFHg9x
 +ubT70qlv4CW5K2kN72GSM2gWQme2+OHaMKoVzjmjZ8QK117XrnvTOmF+efo2lJ5BS5J6leuLOf
 EcAE6usTSZrWhs0gL8Fennuvd3ZIGBMDXinT+V8lwyNokGabci7P4UtBY8uYqXQF9ciUiYahsyK
 /q4MY3f6WQT/rx/ED+A==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5de99b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=s4_jwgGKpBPlvUtSdncA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ccXnU_3eec9rNxAQUF-YZ7UYuhY7cymm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwNCBTYWx0ZWRfX9MIgNihy8QwI
 /aJ8zSG4V7BMBtfrsBqeXl860JptaxLX+es/G6ILR7sCF9998bsKrf39GXF8mdzwQ/GfBhDcsLf
 14JRrWFWz+9TwM/aCwpjbDaP1g5saoA=
X-Proofpoint-GUID: ccXnU_3eec9rNxAQUF-YZ7UYuhY7cymm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200104

Prefer the higher-level platform_device_set_fwnode() over the
OF-specific platform_device_set_of_node() for dynamically allocated
platform devices.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 3cfd2f02b62f3cc370e0d970ec2643b638fd0fec..fc7c4b55c385416741925904abae4fd240f55b13 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		platform_device_set_of_node(pdev, subdev->of_node);
+		platform_device_set_fwnode(pdev, of_fwnode_handle(subdev->of_node));
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3

