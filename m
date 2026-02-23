Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0153563C4
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837728; cv=none; b=QksMbRz+CfsREyjj/V8rYLQWawyKgBXCPf9U60JF4FigEphjXK3mkGJhd//7VMbiHuOfjkpacrdc4CUDC+9+kTNAlZH/pWXWHlp3JLqxqmpRLIeG7kU4XI9IEC5AbaV117AgRyCmtbphzob6MmE5QKqmDHd2kdhmhQmEnRCvewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837728; c=relaxed/simple;
	bh=KM5YYy3FaFtr4PtvxBn1M4hgfoboT1uya9FFwL5qV+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWVmY/Szip5Ho7u5i1Ddiy/gJ/I/auNaIHg3i6zxc+6PEVRWFLFrvZcx0vJTCKnrKj+qsGmdBY13OwHubvB3k09KkR5RUeh5tz5a/MDL5o8xAq6pHNtIFBO1yv/SwGYcxjUzftDoWrzLKtsf9fVWRESxt91ciHEKkVG+8UZAfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZW1CGSOm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gev+a9X6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZW1CGSOm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gev+a9X6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMsBbR2238684
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VebP/75lB4Lk2oODvXgJoE4yXtkdgYDwv+c9JHk6z4c=; b=ZW1CGSOmzgUquQx7
	iby+w/zNw8S4jPWTBPFZXN/nwDgn8XJdEzJPs/UPhZMJb+1pIqcTL3GhKjWcaJix
	pRwfzEfdp8sMOUWRT0lrRAT7BaI+AqYJyfekLbKwMInob6H+9oHUaeyhxq17Jiv2
	EbzRJsrvB917kqvjL0MYDNT5t7LnD32rm4fbduAq3tUDp/Ak5dj7lJq2eUHcfPuS
	VRjqPnzUePooeohuu/zcGZoPFKo4tu4fM7Ntn3Z5WU2/M4OyTUI+kDLq+i9Xes1X
	ftOimue3iXd1Y+BmmHeWJhp2fHUKvaugcsbJBQ9i8goxp2d3RaP0TI+YqCHDebqb
	bcjGlg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vum0x3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3b0d938dso4456819185a.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837725; x=1772442525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VebP/75lB4Lk2oODvXgJoE4yXtkdgYDwv+c9JHk6z4c=;
        b=Gev+a9X6seF+sPfzD+G88dzN9BilGoMVD2ehtGYrYODMZ7g3iPC8YSxDV035a0Mza5
         Uuzf6rOu+s03zxE2fQ1HDYMT+zk2UEcuc8Pnd2c6gGNG1DbIiMKKkYM7a+dTHgcui4bh
         qRczk4KIpG/5kCLxE45ugbHB71yQC4DsqssdzBE7hmwPnK1Qe0jzVrvIaxWoYscnBoEN
         5UhzG/fbBp+ocGHhflUTMmUzrK/63eg672hbXngB98l9wjef0qnLQecnVR9svnA3ZIKJ
         2YkO5Wqrjv+vyYDhtST/5sswHPS8e3GVSZbHZR9Xl67wpCgMsI9QmWTbeQjn/f1UFnf4
         KhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837725; x=1772442525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VebP/75lB4Lk2oODvXgJoE4yXtkdgYDwv+c9JHk6z4c=;
        b=wjfEgGrL8IQ9adZX9HvyLsk//KEutkoaZ+8UP4D25n7yiQJHjxOXKGCGeoQNLlFSD8
         qNvloBnQD3LoRXLBVjdQIMus9RhsuX4EvPR/DzKjp+iQzPisICh10N86kvGZs2k8mViy
         CPPlmw0lL1BzCUkn4gC6c9WxX2wIte1ioq8XyiKt6KU6o+ISKqFBykhykR5pY4oStbtu
         w3K8Wv8XeKw8r99dwRjDedAdR4f0/3+SOgJ+gE02DC6y/89LGF58IvoPgVfr8YaksCTo
         sD6FUToHgQCVuH+QzzIvay4rJXck+2a4NhbH277xJi3WrClbP9MnQ2xJ2lPlom5MgL3B
         ctpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLfXyt3mX/r+Tx3aqciNblk6jaf5QUqRVbjfFNzpVwwp2FJz2P1Gm/BzR1eXCkG7xhg/b+M8hcEm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvrRzThq+pM/M6ulhsi9+CHP8PYglzAgYFexb+ls0mrlxzERg
	HIzVjmBZCRNHl2Tngpbax4DUD6xCoTWRDFp2lNwPLhFLvpfI2PQ6MTZP6fyXe2gaDYsK6NWJ9C5
	3uU0iiv5KSuuGNJccNXLj5F7mMUePERxNH9FApqNaBCCtJ1SEbBglPWr4cR6udnQ=
X-Gm-Gg: AZuq6aIjfnjlLO7se8zD6H4G3U6H354ytuibg3Im9SkYKXqKxscgBWYpqnBvHZlAnH4
	CwI2kQfXEwZjPagbzSXdD3dLDVhzBz5E7ZT4zESj2ZdfnChsNSjWfUqOi0/2s+UoKld2Xo8JyH/
	NSvfQa/sLyARTv/pMHtzXmIcJnG4ioKTL8FbjmK4fAImbBgPlhtM5zeQ658DiJ+qItIQ381zCDD
	bNA5CGIpB4ACuZZLaec62ajRgIoImXeKMk2L+0OPCcc65WdM2mZLZYoE1AjYbc01icjX/0sFx3g
	ho37yE31jfDl1No6SveT+qB9JRCwtmrgm1GAPagOoJ4cTMrD+MpsvDnbuv9fJat6W0hsX+x7kWc
	LQGEhEjVpsa+2q4PM4YV5QAZ41LrWdLww4FyUP45yGJT/lxD/y94X
X-Received: by 2002:a05:620a:4486:b0:8cb:3b09:9cdb with SMTP id af79cd13be357-8cb8c9d2882mr960205585a.10.1771837725285;
        Mon, 23 Feb 2026 01:08:45 -0800 (PST)
X-Received: by 2002:a05:620a:4486:b0:8cb:3b09:9cdb with SMTP id af79cd13be357-8cb8c9d2882mr960203785a.10.1771837724833;
        Mon, 23 Feb 2026 01:08:44 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm264049295e9.7.2026.02.23.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:08:44 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:08:26 +0100
Subject: [PATCH v2 8/9] i2c: designware-amdisp: use i2c_adapter_set_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-ada-dev-set-node-v2-8-77018c536610@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=KM5YYy3FaFtr4PtvxBn1M4hgfoboT1uya9FFwL5qV+o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBkO8POlzYJp+NpeAM0jvZ4BRXDGL3QCvcpcc
 uZqjKtzOw6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwZDgAKCRAFnS7L/zaE
 w+9oD/48uurBu4tKMDXYwBKRuAdj/3Py06Hy6I1lKIqfT5T4qx4BrULp6WkjkLdGEewsmOLik8K
 JrdAIFpAD3hjaBIyIB2fIfRiGJL3dsndDld3rK7iNcZNKUnw0HSuJKSHNd1OaI3vFqFGoa9xkO2
 I84XnF5uzV9bW8mvoEU+ybE8SP+I3zIgD82YQgdRW0d5tUkv85CwfEXog7HTljf2SbOaSfoOxtT
 +TLLJPApnghisJ6Ch3SgXP/CeR8QONFygFhUiCFQdWnrPUqmuum315stVPX9P0fePSnjdxHUgeU
 U3VzSp55AaQSGtZv8L25gEakmMtvRl54veMfA79bqBksJprb//fOBuk7E0fiKocOtTzhomq2Lsy
 m8gXPwM4HU+4pP4UXSYWrSgYK+NQWH5HudFsqVLHGFwnIbhV2XRiRre1DdtSg+lXf7QAo89MZEW
 SWsDFg+TPhdZc20/k3VTkVgOtXa8n20EcmO0xWGIUycDdqXFsCccLK0hrfAWcGo2AtsT8Yw2veO
 gc3NCtJ2TX0xDbMJpTr72cLeoxQZh6Mu8NvACx/wCcnxL25HddR4VmFGSZ2qCVzkTJeBG9w4Bkc
 1XclTfom69XrKi8X81IZXgomksMyuY8eyVZVly5Wk0eHmp7uuBbwI6U715q1QvxN4H6KbhY5edV
 q9bYp7PRR9DQvDg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=AL4GpdX7 c=1 sm=1 tr=0 ts=699c191d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=Zm9YSbcrgGmIKEIR8VkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: o0K8B29EEry_21r1m0m0_V3igZgEXaoA
X-Proofpoint-ORIG-GUID: o0K8B29EEry_21r1m0m0_V3igZgEXaoA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX5oMFFFqJ0YLr
 YGpk53IfN0m+SIkKm/D9mbWmDI0LG7lWp0A7lz1mB6hRRDU4kt9bhiXFJb17W1AHCRSCPZSEVnB
 hA+UZ2D4FRX67mhvlfROQmjCBYG4bW7wPQhr3sk1rD6Hz45TtzVKHWBMnG/C1mjhFDI1OXIJAT9
 ilJ0NLy2YgKxHf86zrLqHFAa1XIIQ+Ks5+xYvmtw7OxVBFjXbwJKTJO7VtTFjuYNEu+JAYmW65z
 Lc++DWl9tjYf0w4pOwU8AFggIxvIWa2kiGd659BDhlojKKFckF8pOceNPW/FNuTmiteQpWfzBg8
 4GQlA6vgHJLOOMP8nIDCgD1holQzRAL5kdW5v3cp3bDtMtPJ2mAnTUqRtDVyfXkkwUiSrCaFxvP
 djA0+ZLd2I7OCKUxNztH0e2vpXQe19Zu68d2Ec9WxysOx+l7lR6b10o+0HPnS2TVcpT1hbUd5zI
 L01ioQBgoE8AGSJbI2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Use the dedicated wrapper for setting the fwnode of the i2c_adapter.
This allows us to hide the dereferencing of the embedded struct device.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-designware-amdisp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index c48728ad9f6f25174515defe55603d67b2491b72..7cbfd441bb16ec1045a2546d55af3cce774b462a 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -61,7 +61,7 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
 	adap = &isp_i2c_dev->adapter;
 	adap->owner = THIS_MODULE;
 	scnprintf(adap->name, sizeof(adap->name), AMDISP_I2C_ADAP_NAME);
-	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
+	i2c_adapter_set_node(adap, dev_fwnode(&pdev->dev));
 	adap->dev.of_node = pdev->dev.of_node;
 	/* use dynamically allocated adapter id */
 	adap->nr = -1;

-- 
2.47.3

