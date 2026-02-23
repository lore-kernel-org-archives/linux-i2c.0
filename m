Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E534F24D
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837721; cv=none; b=lK+rrBhtZwf0MjUyL5zrqJ5oei/eTRq+B4p5gllEagQXRsGQkU3Zihs3RfbZ4OBnDSAyFJjslwjc5SRwi/JCLmRZCRMPgZPCdQ2ZznKhJrrsLBqW0d/KoqjAoMpJpDX6ahKJY++P1eDBceLggmkTnMn0+SS611yfiC4tD4LeboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837721; c=relaxed/simple;
	bh=l1b9VnhjLxExoERgVTRD6HsqRNSjoAW17j+UY5k5yGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F6oqCYm2JCdnukpjOCjMG5bO5LzG4oMNZZ9CEvE7Y/yEPBWcziwRKQHeLf7bVm6a09/wtvShidh8PQQIEhU3xf3YZy9ZBV9RcvmmvMZltUAiA1OgTosbr+/EkOVcUGpnGDpQvdDoba/OibzXMIXHXGUe42KvOK9CHvnvgx6rXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mw8QNWv1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ArL1rcbL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mw8QNWv1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArL1rcbL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNGjMl1776702
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WOz/vj4E7EAr5A9KF64UM36whlEv+sowffhauzM8bYA=; b=mw8QNWv1oqp4SAs0
	WP9bsnY9d5W7ZsV9wYxBGedWsRU/3bcRq5KadwlRYWkPmRtfWy/H7x4oGsqUq2VD
	In2AN2TBRF7V4BkLzXqFpwRMzN2eOvmr1j+xUW6UD/dZ0KddsQnrJLr2HKtNcDnK
	NbmuTAsat+xxhpKRijLRQQL9lC0uSKwxhh6+4tvtjv5T3oedpf9TKHf+PqsY9U6P
	HXO/UZOua4HrqF/+soYLI1QCtQHGfD56Pe+/+PcyVaDi+a41uP4bDbQTnX8fdrsr
	/FLl+cLmi323y9G+j84NgQUU5gcESdSWnDkRAADC86E9BSCet6yCn0g3RFp05M7i
	RyPtCw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u9v3qv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71655aa11so6385752285a.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837719; x=1772442519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOz/vj4E7EAr5A9KF64UM36whlEv+sowffhauzM8bYA=;
        b=ArL1rcbLhfg7Gi1IJfMCf3ciEXD1vY1ePe9HWyqr2LKfcIl1ibp/yclX4g2TVRIexY
         wP9Tol9JW3SZTRitiA8PUkbt1UZ2tm8fUicgZZA9blb/8weL9C3FqpCybwufGkWZk24I
         uGjwLZ7aYKvXOJ/f82b0cf0RGTz1eThwPyO78asuEa+EgJLfp9uuO2r0kAvR4XZFGZ02
         p6JbrOOWZzvHf4p/SI0K2JID8rHzqb41KQgHlfwsIhUl1gCGR7cbX/r1stmN/YkpQJnr
         p+VNd7/b4g7n2RV3s6TI8kvPY2zQowGY0GGQirQ9nuJzysqicI5T32ykCT4sS8o0/aKB
         SAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837719; x=1772442519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WOz/vj4E7EAr5A9KF64UM36whlEv+sowffhauzM8bYA=;
        b=cVxa1/j9tfxcqRBkTRAUQTa/Xi2LIRinnm9yKIzT635gRO4emBqmLAYk930fu1gYP5
         aYeT/BPHFpEXF3igOWLsKAGuM+zEVX+ez+ANivPO5MZqR9mVF13Z9As2P6VxOtkEE/hl
         qhBiIXImkkA+1x73zkZHrkDiI/ENS5azrOAGr3BvgSce2W/sxRAwFKm843D83jdr8+VZ
         TpdAlHbQLxw9FIhKVaQFh4E1F3QGYn5AOBdmth9DK4YeGOBot6aERut6n71U+tOpDsgg
         isaYHgtv24rcNoJ+jLsLjpIgCMhRotP7Jq+vOCHyCg+G5iZENx3XMEqAPVCZ3Ymj/Iys
         7r/A==
X-Forwarded-Encrypted: i=1; AJvYcCX5ZEg9Uge0K3H50+ipb2asp7Pq1ASBNYeqr/WnR1CQKLUdF+vOz/+vo4R7tzgFOFlR7EOCWIP290g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kA5gUxfb8nZ7VWN/wZ95aqOdYLCwRi5xfr83T03OVVjrKoin
	1VAEr8acv4RhJKJ544nwzCm199qgwWvH9Fujp6pVuRhfwrGVn8kkpRxvqPcvbfjXOXUGsGFLgNP
	ERHL6CPGjXl0GP/So2hU7K7ArNtyYabYiPwaMnE+L60UwWVW1e6yapjMIhOhNr/t9ZrOs+Us=
X-Gm-Gg: AZuq6aJ3eCNZhJw9S3M2roJ/VypkW0DNuEUs1k4ePZVPx1/3NgbWIeglX0WuR2guaU5
	6AJ5Ng1KAmRHLquEH23x8um0ncG88+yh1Xvi6cK3BMzB34QR9mB+St5+8KsuShvETakFkcbjGvz
	XcUWFnjXdNrEBAkW50aBrr+casHXBL/v7/szHBhF+T90xDuazwOri46A0OpT4Hw5qSRueRPfyeh
	dRgAnrAmwGhwAxG2FIA36fWXDoN6uyuv14XuMm4AriboRLbCiqqZYdu0/eBC+UUYyGWqs6Y0EPV
	wCk3ZUCFIGS2nJoASjj7gVhwfquwHPqm1Gqilbp7IfKTscJ/1/CMP0gSrRmrPM3Smo2jaXIHjVO
	xNVzynLm0D65sGOarTbpC0LQXmpPH9/K6A7mbuV7j3coWXhAvJdPd
X-Received: by 2002:a05:620a:29d1:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cb8ca6e5f5mr949118985a.38.1771837718996;
        Mon, 23 Feb 2026 01:08:38 -0800 (PST)
X-Received: by 2002:a05:620a:29d1:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cb8ca6e5f5mr949116885a.38.1771837718513;
        Mon, 23 Feb 2026 01:08:38 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm264049295e9.7.2026.02.23.01.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:08:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:08:22 +0100
Subject: [PATCH v2 4/9] i2c: ljca: use i2c_adapter_set_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-ada-dev-set-node-v2-4-77018c536610@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=l1b9VnhjLxExoERgVTRD6HsqRNSjoAW17j+UY5k5yGM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBkKnpZKBA71TcPK28qqvWtEwInm14uMmpc1T
 jgbj9McdGSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwZCgAKCRAFnS7L/zaE
 w84VD/0QSUNOcTSOUYuT8uZb0GQ56hLcF0r9pjAmNXFkzLbKYMfmCwjsNUZ0ZdVPO2zzsrNkBxD
 UfRXQQ9oddBGQJZd2nsJP9/H4H3stZ92FHMYlM+5Oucaz9unnek9ZC1MoZ0u4+tZfw2RSh6CUT9
 oWHiHdAkpEDkKQgR4gkvYm+O/f+nVRcAXGlnpye/FIymo/v53VTwyNTSCAlNPCE7g5k5rOIBS2P
 PzbrhMs3LXlf+zASckmE44dsSMhPY5oqNC81PtZVBBENKHAiKo4Iwd1RXTXMW7mLxWMYuP7b9n1
 g/tXOnTOJW01cJnLlExPHyDrfronv8qgxH8XpvGLJxrJkyCj2dXPp/MEEGUfYjIhtxic8fH7jsg
 cHcJ+ztHIz8rHSQYXrWMg+5WyDHirU3wtZ3nLI70QGG5ySGlGpg1p9z4TOFRv+ZlqpWbcU1Sgn6
 /Ya3yFiwyD/lCxW5eGXnbs9s+c7HCZ/2EbKvPt10Gg8SjdDT0GncICcKdQc9UlSLNXDQvIcC4m/
 Ci/kb3WmhxQwlMY+JnkxBpCTn94VyJLchpZq/IHuukIoANMVlwvDGUjGkUmKqDuXGvOQsWQ3bb2
 V3gxwaCa1O+6yUyMlAID/8j2IS3TKZcCuslng2E1SLtk9tuKHA2+daqY6TZk6IeNxwBRVX4O50F
 zD+eKIdy5kyPa2A==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX871+ReKBA/ob
 wSFTjAG+0XuUUvGfYM3NcWAHlcTQtDbAaJzPyEuq4+oeSE+l7EVmpxkqBIm4cy7TQm+ccGQzn3S
 kJTfi4sLKWArLQew4UhDVcFASLCyzXc3OojzgfZP8HlV60MRP9locgDa/XJC4LcqKLiZ1ILXtik
 7dJcRB4d4PNTpoKKbCNL7wVafp5ysjBF0qxEiIe7SdhIBvPIA76Ac6bdx5LUyHSELUgqsznzwxg
 azYiqQ4/AsW7Yjkf81dDdO9v8aOlX5cXdPvuwJipVIncJh9bh3tQtcuQw98ReSCb07feONgZrUs
 urUNCLqcE/14OI9lnj1Kdrkf77Iy18YJqlapfZZhppNhvrBCI4Yr7SJ69sgxR+Rb72kmp4MmmbA
 Lx8w6Nxszr01i26m4nWOg7fwHv3Xfo04h35AEHbgm8ZbIUjISovrxPONQ9EW2fA6Oy2VToeoLqx
 wVSIiB7bLwCGXHJRpPg==
X-Proofpoint-GUID: IuFOEMlf0uis5vF6iantDr-LdMAhOGeI
X-Proofpoint-ORIG-GUID: IuFOEMlf0uis5vF6iantDr-LdMAhOGeI
X-Authority-Analysis: v=2.4 cv=RpDI7SmK c=1 sm=1 tr=0 ts=699c1917 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=gbzR1XxPnI4f3MEL7tkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Use the dedicated wrapper for setting the fwnode of the i2c_adapter.
This allows us to hide the dereferencing of the embedded struct device.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Zhang Lixu <lixu.zhang@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-ljca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ljca.c b/drivers/i2c/busses/i2c-ljca.c
index 93274f0c2d72166bf017f65af797f418743b6a57..fb45019b1a0c583f19bce3523983a79d632da3da 100644
--- a/drivers/i2c/busses/i2c-ljca.c
+++ b/drivers/i2c/busses/i2c-ljca.c
@@ -294,7 +294,7 @@ static int ljca_i2c_probe(struct auxiliary_device *auxdev,
 		 dev_name(&auxdev->dev), dev_name(auxdev->dev.parent),
 		 ljca_i2c->i2c_info->id);
 
-	device_set_node(&ljca_i2c->adap.dev, dev_fwnode(&auxdev->dev));
+	i2c_adapter_set_node(&ljca_i2c->adap, dev_fwnode(&auxdev->dev));
 
 	i2c_set_adapdata(&ljca_i2c->adap, ljca_i2c);
 	auxiliary_set_drvdata(auxdev, ljca_i2c);

-- 
2.47.3

