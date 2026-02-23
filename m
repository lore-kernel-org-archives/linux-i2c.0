Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510734E745
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837385; cv=none; b=JeKiKumEgbM7gryH8zUTL5DB2m4sNmIkC92h3Liku/mmIjJlT5uD4r3kD56fZ6MkblkaRzCP/BNpIdqZXQo+/PvZNPM2yyBYO7ijGIh7Yc2blQxMlpFZIm4w8rMnCsyGo/n5HvGQ+np3PjhN8z6YA7MBUHfGiPDqjZBUhhly9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837385; c=relaxed/simple;
	bh=3XayEv/3h6xRZEvzC06lt3tVT/1yZOtcTislXfBw/Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVIcGqTrJCdjI5BCR5VMq8OcnF496PQYrlggdNMTVmhFOtboLo+y5qajZ3QdwP9y2jCgBRH8tv9WAE0v6TSawAOlUvbwu4xiiFjsbRrE7FBLexwwme6lQQI2jZri6/egVtYNro37R6f4y/aKUrdagTpKEn5jq8ppuW+rgJS/m3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lTXlt9Sj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DMlfEcQB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lTXlt9Sj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DMlfEcQB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMlAG71184063
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TfdnOSgmzDxymhYd3KHgUyC2QFdfH5GwQRLtdn4kltE=; b=lTXlt9SjNWJjOTVm
	4XfDQtfH8g+MojYUVm7Fy45qjybAY0kz7LSyrXlzOIag5DjeF1PhZtn7SFohl+Ib
	abfKRnbMiK6dc9+xfjD7ycYDPePzc7wWEgQHecFvSQWRI8gX9HSQsR097iKcdPfd
	isiEBg5uNxXMcAnyc3NkeL6hehakm1ByQV366drGr8T8MNxdvpiK8/L4Zcm3wXz2
	phxwo4MV+2LvgtQM6H6IKSmjvHW5fkNRAJk6ZTcqIn4roDRtYwacMJe8r+i4JZLs
	1No18jZp2yrbrHeCj5B5FWL7tRsC8OeCh5YScLd9BmK3VuhgoVzJArHznzVXWnUG
	CKVyIw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf603m2q9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:03:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb4d191ef1so590913085a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837383; x=1772442183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfdnOSgmzDxymhYd3KHgUyC2QFdfH5GwQRLtdn4kltE=;
        b=DMlfEcQBVk7Et6u6vIlJlH3xeEvpmGzgBMXUivikPZgp1hU/SgaQJYSUNQLaYVEU9q
         lAjXCzIUklESHVZ9AUqDt6bX3aGm8IbM4jm7XZgM/UPzFy3+DqSqRt+4gegECPeUvj/R
         cQVJyDWjDg5/H/SXPQ9mm/BHoY4meWd4KxlOxNh1yUHeRW0HqRGIfCmSW3Ga9ZUxWDvn
         N7D4sMS2J93uTQPdHfUZ6Es6vrcNSmqeVr4U6nEv6nHSA3R2GezNeeVyJzZ/v5ZYut3f
         NiXbou7Vmfr6WhN/RDzamd/YjcKs587ONr5GBfAVrotkXtbNVQBXbETpU62naDM3cRLj
         cP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837383; x=1772442183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TfdnOSgmzDxymhYd3KHgUyC2QFdfH5GwQRLtdn4kltE=;
        b=rqM8ypaoFzs4rXw/z5fk6RgPbqlOvhR0bghJa4ddCN59oThB5Itdt5R639iQNmRct4
         trAljnUboE3uSk4V9P8Ie0hcEbjUiSgllviI4gfHyIODdl88q7n7JLmykD6SkPxFAlMW
         VbKU/Wv1zDhd+sARmdH0DUr5ZjfxPiG5tkbCEZMnJj/9sQWXOwK57MwsX5tfNASaI+6g
         QE284j+blJUc73Yk9K9eAs+yIr9zx15MLPavXU57b5Gmc/LL1aW4ptIgh2yVNX7QDS7A
         H9iR0td0dNklG4EEFkgDp+lWQnDdO5YsT5dskIsq6Tn5ew3IhpHe+CjV4kEK0KQ+Mcpk
         Tu0g==
X-Forwarded-Encrypted: i=1; AJvYcCW5yUbcvx2vrM7DbncUV47GFC0ownCPM9p3WlSwaC3cVO9JfeddNUPfIJBhegd21J8Ux0rJyPBkDcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoEyn6sdajwCGh2Mo1p+fvqknig57H7bOUZaKj8CYfJE2uUFL
	46GfIzTlXap36aDqykCrm/zA0/cEeUhkhVUW8iAD6TkzX4oQ3kSnyWkzXda8zyHV6HdsCCj9vzO
	Xr6MesYQneX6qTygdlu7a0Kw6J5NqvLHX/LlVWsUt2lfIpItggVwkSn99QZ930OY=
X-Gm-Gg: AZuq6aI/uhDJ3qLV3Xu1JJbucw46KFuoGPdw/Juwn5Q7OPRTetWUMlQIbUBgz97zu42
	/Z/Gs1G/H4tbOqURbl493n/T1zzi8Th/ZUPqxHXjSTDn9GAEQyXZ6Hisirvnkg64qABJiShsfps
	PnJxaD5rpb+VoAbrWU7omcQUxOy20EO0As/3S0mp/j2//isFJFsO4UZRu97NYeRJiYBXJxZpLsu
	t/ws06c5OfuqUE1WMGZPrb7c6+xYfmA00HS83n+doQs3+LQ+ZVG7zz2u+Z4OxQpndw/5p13Ewre
	FdJ3wkSV0QRuIGkLobd9tnDhP9pXpxPSeQ8VJ7+tEYuZhGDStZj3PoxnB8NfI15j0vvkbhAGUov
	UhEVcPWddwknd3ZXlUcF68mfQeKS4hWx2vz2m5S7pOdehfrEtdp8=
X-Received: by 2002:a05:620a:4492:b0:8cb:5c90:dd7c with SMTP id af79cd13be357-8cb8ca930cemr1016826085a.75.1771837382786;
        Mon, 23 Feb 2026 01:03:02 -0800 (PST)
X-Received: by 2002:a05:620a:4492:b0:8cb:5c90:dd7c with SMTP id af79cd13be357-8cb8ca930cemr1016822685a.75.1771837382293;
        Mon, 23 Feb 2026 01:03:02 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f6csm19657169f8f.7.2026.02.23.01.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:03:01 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:02:50 +0100
Subject: [PATCH v2 2/4] i2c: piix4: use i2c_adapter_dev()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adapter-dev-wrapper-v2-2-d02946569773@oss.qualcomm.com>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hans Hu <hanshu@zhaoxin.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Jean Delvare <jdelvare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1549;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=3XayEv/3h6xRZEvzC06lt3tVT/1yZOtcTislXfBw/Js=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBe+kzyr9tORsDLpyOiDDRPFNZk+gHLR5FbeU
 wyLsuwl5rGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwXvgAKCRAFnS7L/zaE
 wyvuEAC0UYnLvfLWguqA83ot9mSptZT+sTWQKRSTIKEcmenHCkhXELGkG9D8Xr806upJMEilT1x
 ekzItWqfzIJb7rZQJfFR5JAZz7Zv3nUfJ0S8s9WEPYkA9keoziJRjyhJRQyWmLJx4pW/zEZawV4
 DmBEkp9ykRNz00nU/gj9sg61Aspukhjk7X0mrRKJe/LSm4Wi/5qNhW4iGkAvy4dwRR0Z+Z8SiDc
 PapIBfVlzl85XdT1cGhAq3jIsAObbQAXPeh2LPISHvZZ56lQAxl1omBX5Y7Un9iyvLmc9t6dVh9
 DZdx4gsdoZmFgTR1woSdbtWuD2MnLLwUsB+77j5DIcKMelYFfcS+/i1N3iRnsveW5Vw3ICxUFio
 9tc/bVqx6QFDHswFoFShd372vjeSiWhIpRbtyFcQ2xmJZXj5nWWkEO4uhvzHGI6a8iMszlNEb5c
 JR9EJ5Tz/F1FtzYVlQZikt4RHNFX9TwQGnpktGDsc/pP+o3lmsAqU387cvpdM4golvVb2Jb2w10
 iEaZ2B9u1ow0gh9CMu0g3Qo5GrZeuRApqCaQuW0Aw5UkmR7ekZ5E190DHfTlrRoBarRir7K6BS3
 J3LUrqSqPWSBs5wNmXQI8Y6tlkECOnOV6/oIRwVsYuLBmNWZr1PjzCGwP1NC1hOCSWkd0EjZhgF
 D3haldnmASa7Evg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=XbWEDY55 c=1 sm=1 tr=0 ts=699c17c7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=J3KHmbl4vA6OdG7rTiEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MCBTYWx0ZWRfX8GIbBkTCYcRb
 65cElepfbc5zU8K23jRKj/oll6xd5KdfDK+YY5M99iAlxll/e7TSkAJSqIcl4Wmvl8/sCKEUM5k
 iOiBZAfo8yA4yVvPbg9gcLf/P8JIxj5OU6m1+knYtOs2rXT5TzUU3cVhdeowtiI1hQlTVqb4arQ
 88oEF1Mz297wUIW6gW0LMyl/uwaQ0ak/e4M4QUaa8KfMcOzfjJqKGGrCN27XehKldxtZUR/MKRx
 0btqhzFkXNJCrMbYRVBGS249udpWDgVAILycyC8ohJgLVpETmJCgWJex1QIQNDYOyOxXDbHzoKL
 jlEeYSVTQtMTs65rtqTWFjJL94UB+Wp5gb3nNNDkuOVzot+4hSrOKuHgN1L2DhkNh3gTNR7G4ik
 2FR/MHfdNCwxfQ64Bs9lAgR7y1TGCs8U+DtzkR2KihFG+9qwXL+gG2P5lob/PbkggOJaGQsaC3T
 IPa4HQglWy4QHbQ+DEg==
X-Proofpoint-ORIG-GUID: s38lxmk3nTtf_OJne9Hi63HFdCUikChQ
X-Proofpoint-GUID: s38lxmk3nTtf_OJne9Hi63HFdCUikChQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230080

Use i2c_adapter_dev() where applicable in order to avoid direct
dereferencing of struct device embedded within struct i2c_adapter.

Acked-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-piix4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 7b6a4e201be4a211c3b84e57fb7d8e0adc9895b7..2e36883f630ac50e4f4bb901bcca70b5230b984b 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -788,7 +788,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	u8 prev_port;
 	int retval;
 
-	retval = piix4_sb800_region_request(&adap->dev, &adapdata->mmio_cfg);
+	retval = piix4_sb800_region_request(i2c_adapter_dev(adap), &adapdata->mmio_cfg);
 	if (retval)
 		return retval;
 
@@ -859,7 +859,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 		piix4_imc_wakeup();
 
 release:
-	piix4_sb800_region_release(&adap->dev, &adapdata->mmio_cfg);
+	piix4_sb800_region_release(i2c_adapter_dev(adap), &adapdata->mmio_cfg);
 	return retval;
 }
 
@@ -947,7 +947,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	adap->dev.parent = &dev->dev;
 
 	if (has_acpi_companion(&dev->dev)) {
-		acpi_preset_companion(&adap->dev,
+		acpi_preset_companion(i2c_adapter_dev(adap),
 				      ACPI_COMPANION(&dev->dev),
 				      hw_port_nr);
 	}

-- 
2.47.3

