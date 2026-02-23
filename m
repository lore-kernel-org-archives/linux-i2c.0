Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8C34DB71
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837718; cv=none; b=Frc6pgbTgKSRcx8p6c8Nd8WYbJAALZZe/ufVky6ap4WC1V1TbbYYzyjC/PfpDQ0k1pngxw/A+MOpjOw4Y/arM3kk65IlMjWhjMgHsMFGYxJJ4GGJtHXWoVasgfSmJSJokMd7O2tpT65elfPK3xUbgVVpA+2e1WWX7C0opa/Aii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837718; c=relaxed/simple;
	bh=yCqBZlvfTojyzqPKINIhZxu0iYl01Le6puO4cMwx6mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wmb/pUDCMkh6QgUxy9NQwFpVfRJY3c8yfoJEfTgjK2q2LWJY6sPY65gDyoZr0yK0OFLYkEW0JBmb0LpZk1ZLQLY1NoAYS+GYzHWcO5sZlVlEVK8Cn8tgLhl+f9W7GHz+uknR6HRPe3VZ+w7Ng6wmi6D1NdSPV/Q7p8FTHX8ykn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PsaBrho2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ExYXdqzr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PsaBrho2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ExYXdqzr"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMa6S91461907
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WSQc+voghXG+egrbqQFmH2pPQOgAnp6fN7Los9wvsV8=; b=PsaBrho2snziwUeM
	3Oo1EvCJkqQU48Y4pElZSkh6qlzoakVLVcGRTNOaz8PhfNfovQMwkiV3QuMCt56U
	lTtkUc9buGvDVQkR95KxSlO9g3Cxb4hKWqQQpZ58fDUVjDt6rrQ+Sl7AzuKaMB9Q
	wIRYlWzBOR4ksIDuwy4EbaelwXvyK34BLHNI89iVB+34mwx3CMY5fZnW2cHUCbrQ
	2yXwqdwHJ3gIcu+HuUAE4xWyMfqWKuEszyOKwJttO/dTQvXf35SSTVjBsUvRFICr
	3S3gc46lMseG2gLLxB+odZTop+4P1pdjGbEw2md8W+sykd5LvkERQoMOxRaOv4KP
	p+0++w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5x7v41r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4d191ef1so591274885a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837716; x=1772442516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSQc+voghXG+egrbqQFmH2pPQOgAnp6fN7Los9wvsV8=;
        b=ExYXdqzrVUuQRBKWEi+CREWQOOBtZ3B6OY6ljFekBFt8b8U/89920h7FdBwFKbFD3d
         GcHwvWsH/zTogcuHsngH2E9w/MJUh4leQDp57tgTe8njfaxtYxoxDcOjVUPN+MKnOQFb
         p5bH0jTfCxvUgl11gpWCF3bcy0KT2SOboJYkpse28ZjhqWYkmMKOd+kuFdVXwgjiS2t3
         xB+zWvPyYNLozv1NMom1J9Ca5RdE3gQbMFufZLqKHcxVGTzAMPeypli12ayDKjCq5AJD
         qPjNXgVKP7Ql+wjCxZCkzeqTXc7HGMVEfI5/6YZgj85Phx1a3dVImfppqZon/L5cDzyM
         lUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837716; x=1772442516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WSQc+voghXG+egrbqQFmH2pPQOgAnp6fN7Los9wvsV8=;
        b=va+hyWWg1kbQZn2ufc03IgNduU6CZsPB8KQRJdlkaQi4C59D1e646uKf8VDdNrGYRc
         0qpKX/73MyrZfkIral4iAjg6dx4uAYbFQVfV2jsbghcdpwd0luqmSstQEg1FT4twm9bA
         x8Ki6h3QSgOMQs4k3nfTPpiffgW2iMqntWSudK3uFI+JwJ9YbgAQZFzLOMTiubvuxwWG
         kAAzPouo52gIAPKWvcSuxCODgF1xyLYx4X5weN+nLAkBrt9Jp21RgawlBVktLSyqjCxE
         fwnPft/h+fqb6Az5LUm5dvgan35je/ucM/zHMoQkgKv4mtuGc7+TG8i52gtpA+9fPX8z
         dTlg==
X-Forwarded-Encrypted: i=1; AJvYcCX9UldSX/GIu5nUHJS4cNlwx6ATqV7yIlwYmZzU5S8CqgZ7sYru/C4h8its2q2a1Jd7dug4nPG7Wls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOqde6zfnjq0PY7X+2wtY522H/ndbLuSRXG8DoEZndK44/mdQ
	+WSDtPCtM2HXWZ1YGDs2HxZs9SdkXSHOr8JNBscDhoCiUHoR9PUnVLRicf2i9sZheDbwNmYL2JA
	PjgdDQid6o01shWoVFtqWRhDlaNXVexAXOmyP2DHboyNOSAzyW+ptU+cMhCwJh50=
X-Gm-Gg: AZuq6aKBj+58cy/GAHRnBnyWFh1nK9l9OeF+NWja7NqeaQmMnrvB1StsgODBTpflb1X
	NBqLPm3yvgGOLDeU366WHy4phf9OqN8POoCsmOde2B4H6bSlwwf/2aJgokiNdb2cEhCFcrNqeO6
	+Aae5HXF2idacNePxxbaZWoLoLIHlbs+Yo36r/g7C77F55CVKVoNLlY4BmMbUM74QY58edYIWI2
	JAU3XAyPadZjTHE95qfSnDRTUijAxg8IW56q0s4vkopnaMY02Ujul+TizTFBukVTzSjeA+U6veX
	OZOmxzs3tMn9kYBhZGZE3441C3b9jYuaNSWwHMAWxkynd2SgJy46jjA1vXVm2aqFwDwALacZSob
	L3y+DDrOJcr4aS2RdmJ0RTHT664DjV+ncoKUnrNrLHT7tpf1hGNGt
X-Received: by 2002:a05:620a:4416:b0:8c7:9e6:3a72 with SMTP id af79cd13be357-8cb8c9cfddcmr962674785a.6.1771837716169;
        Mon, 23 Feb 2026 01:08:36 -0800 (PST)
X-Received: by 2002:a05:620a:4416:b0:8c7:9e6:3a72 with SMTP id af79cd13be357-8cb8c9cfddcmr962672685a.6.1771837715665;
        Mon, 23 Feb 2026 01:08:35 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm264049295e9.7.2026.02.23.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:08:35 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:08:20 +0100
Subject: [PATCH v2 2/9] i2c: designware-common: use i2c_adapter_set_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-ada-dev-set-node-v2-2-77018c536610@oss.qualcomm.com>
References: <20260223-i2c-ada-dev-set-node-v2-0-77018c536610@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-ada-dev-set-node-v2-0-77018c536610@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
        Lixu Zhang <lixu.zhang@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
        Hans de Goede <hansg@kernel.org>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Hans Hu <hanshu@zhaoxin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yCqBZlvfTojyzqPKINIhZxu0iYl01Le6puO4cMwx6mY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBkH5ixszgMsJSWyggENfQ8Rb8hEEPtBX7zdK
 w8lvpjXJ4aJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwZBwAKCRAFnS7L/zaE
 w8hUD/0diWfXcFUQnGcdSVXAUpVTzKEt4L01fRw9Txrrm++fRYDM+89PIKFJ+fPigm1Yd5UTyxt
 jiBnpGjhxV6nxergOVM2w18ased5EKDFbgiEssbCLShrPq3PmazSWzSlnoj9Nl/bGt/1GiNLbrd
 KzyFv1SRMSq4Sk0BoFFI0TQ+nCXu8An85A5xCwFR1xi55xTYlQGkFzan9XdUGlIuM/2QwHmG1kP
 O3QmP9r+REL94Fznmwhpl2Tds3Mwiu6EwR6tW6xhR5oCNNL7lN/jVWbQUTP7SEGbJYkvntipjpO
 EkxdvN6WdbVUtK+mtoNFg+O2V/sgsIV6BW1M/Vc2NSSY6iceC4TYqp5knmVwF3awztFNUUMCRPb
 vfUvQzgx9gqhnvtBrgRUKK4o+DvBdLqOomxFtERluXRoT7Q2onw1/ZunKlPfWyNXfFc/r+DKmAO
 QfDpgvPlUs8NIXQm5adBLaeLJDv4hCxa70i0icVdYfOilEEfn52lhUOF0ER/difCA9n8bAqh7yp
 YwI94nLZ1sJ2k8Kq1uHbbyimS3l8OXiIv0HbXrdv5Ct22lfB7YVhL2iy6jWf2OoqZUDjkUlay1O
 l//j+dPSplPCfKtJwcMQijJFPshxB4mZvIH8MSznrIWYuIFg3mABXHmVhmjLjze62+CSVzyQxCh
 aj37VlJnpyhhspQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX4qUCcl3XSu71
 MnG/l/TW95vE+aFYh3zf9gN8NTKsEHpCeIK7oKXT/h7IycPvsQpwyrGc4LE54vg2sU7EOB1ug1c
 tWuBNHUO5FjRnXK/5PrLIt2REldtnROx/ltekdcKt2WTwGWldElgRudre3LcuPJ8AVwQaCCnP8f
 ITOXrcZkGJ1foQ8f7JPcBhCXH+/ggLVcGCNOXahmXZ9k8Rs5KiLNS3Ku7L65sTxpGkW22Hg24AE
 zjxLhuc8N2MdpugG6YBmHuUCz5b9E+Akg8BmGKFQ887A42cNrZlZ78AEIof/0xHA1jpPSaBkLbc
 DRQ4yjNibQ3yQMomcExSod3sZ8xZMb/aJ9JA9nkGdH0k3aP/BLM3vNhaH4fVEdKnJww7z/CYEHd
 ie+RR8HDu4XdzbydAwD6ew8VqOBpOi5KsGL8+lAwG5e2BsscsxnaKicXJPv96yhNCWqZqvdMlbw
 gOb9LGKLc/CBQr61kDA==
X-Proofpoint-GUID: ax-zS23zlTo9fHCB3ubem5IWiCyaBh0h
X-Authority-Analysis: v=2.4 cv=X71f6WTe c=1 sm=1 tr=0 ts=699c1914 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=-kqZBCbCPCnDthpcomoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ax-zS23zlTo9fHCB3ubem5IWiCyaBh0h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Use the dedicated wrapper for setting the fwnode of the i2c_adapter.
This allows us to hide the dereferencing of the embedded struct device.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4dc57fd561703bc12a0c40889841571fd2943e70..3c761c4d818c12eb9721893d43a443374b8766d9 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -882,7 +882,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	unsigned long irq_flags;
 	int ret;
 
-	device_set_node(&dev->adapter.dev, dev_fwnode(dev->dev));
+	i2c_adapter_set_node(adap, dev_fwnode(dev->dev));
 
 	ret = i2c_dw_init_regmap(dev);
 	if (ret)

-- 
2.47.3

