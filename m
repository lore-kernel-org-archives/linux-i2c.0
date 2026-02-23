Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C4205E25
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837717; cv=none; b=KQFMel9NUvUpcbKHSk1tcZM9U5yklthzSOdORqA4KlfUnatVeV5xm/5smI13OwT7dGGv0hYM63M2ne2n/WzJa+FhqtuK+zYZioSMNkuiXPVZzthLk7r0tHHSAQhRDdQSyePR+0T7ukw61y3EWrcQfsLnfsz8VAYR0Gbk8F27vas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837717; c=relaxed/simple;
	bh=kO3CZRW/M5+uqt+4EF42zBuOHZXpdkukqDjmw3J6cH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D29D0noQ7J2r7Ai7+Jut7NSnHP2PSD8gdCv71aaDaBnq0uHLxDlPHWry0hePxZAco78X5INkzzx37pZFKgYLYhLJcfUIK2esPuwh6DszizdWX4b/DXguWldm5luONvoQXQLEsH2+K+pXXLeYH6qDF8V7pYDi4cJMDKwkz5+TTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dL/Za5BR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C7QnnneI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dL/Za5BR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7QnnneI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8o3oq2460514
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QkNQCV15k1n4PNG/fKmbVth/Edgoros15TZDXRrsNtE=; b=dL/Za5BROt1ZQBR3
	szqvTsLeZdH4utEMEfAoBwMEgTbXgiVAxEulQ0ktfNP/F3js6nUn7wfh0selgrv3
	WUKE5DagFSRoDo5vaPyRou9ZSPNQCiOoBpAUqa7zRhgmQv5CItuoYeF/MUO0r8E0
	PxcDuBKApN6FhDf5j5U7Zvjq2AZSpp1IJRxZ9RIk0hoS3h+EdKUjP84JCX5vk+Zf
	JghyBTCVWhy0hX39fXilG6oezl3HjgGKNaDXIz5Xeqdp+/Sjo6UEMuMx9jVHsX2/
	WrgHXaFccgdnWAlShxkjUMX363IMy+EQDORx2cqeRkXYNSkqB7ezzNHSO+w2nuVa
	pY/BxA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wk41em-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5033c483b76so553948581cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837714; x=1772442514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkNQCV15k1n4PNG/fKmbVth/Edgoros15TZDXRrsNtE=;
        b=C7QnnneI5CN29/vryQcx2IrHO4UahgOH+4QYvfs4T8acT3eNotiK7ZkyQbOHwJRYWf
         4OerRWgTbffVdnIt/lnLdAC+7U6gJSPmhSGmhj8WBsubPgvrhgrbSv3fHfd5ZsM5wLpm
         72vHELRx7vzfhDtQ4MNtbtdc2AgySzIiZLVFuhgA3WAJBX4yimQ/pcogdji0rkaPK40l
         jB+PbEhXk9xBDfenJko/QBr0Du4uAXBQ4j3dJkh3c+RKZThqv2kxzNR072mRYtoutgVf
         x/ENRuNn4E+bOmLRmM/NtUCpZACYRG0Uo3KdGO7PTsBzDh9ap1YDOfP4y2yuRectkbG0
         5xYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837714; x=1772442514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QkNQCV15k1n4PNG/fKmbVth/Edgoros15TZDXRrsNtE=;
        b=Yg935Dd05s1ZVaX/pNQnh7s2Ju8QlAHQxxK01EQRNic02ESvDCfLgAe6ZZi0CLDS69
         yBUbu5yUJV0+uRhbqPYCqep3r5HMjM9JljTgPUC+UNdB3X996ynBPCqqc3I0YDGFTAMD
         tJtEbA1PM/pHkQc21QbiCU35ZGuf6enn26TRg2OUQ4Aa8D0BWjMBHgSDRboTOCfT9Sji
         G0KGq4sJYX697wwpUX60HocVV3pW2ca8XkObdXECLMrTquUzxt6roBhW7AOP3pxF3nxQ
         K0YIWzXcXQ66jqvHwArOOyjjCzCJUYjC627JlLhbrT1vb3ruO3TKPhVBxkrkSm9Swln9
         1SFg==
X-Forwarded-Encrypted: i=1; AJvYcCXDWGLMXoHgzrN2j+lpwMoPYJAJINij0tbMbWJnlKK1HTLJp1SSwB7Xic9IrUPGGeYCKVVsgnrmTQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz++m7JDuscm+VRqvciIcjVTr/4m9Oc5W6fnwAcE6zXpE04p0o+
	qH/e8CzgxqCBZs3urTkTiZTK0cCqmVY+0vAX7iUzd6X2/i2fYGEJFp78TQmi+x9wb1m0wct/DQt
	HCewg0i8di1kBHWUwao/AsP2ttAjlnoTDkpoP8lfUs0EzbEarhyAWCWkC11ZxoC4=
X-Gm-Gg: AZuq6aJgkX55OCUW7GA/dgVRb9QRG0ydQj41mZJBIxNx7uX2OCadgijLvL+bPSIvntm
	K/L+TrT6NHX+kU9w60mpZWPC8hKVkTQzCVB6B96JceV31JObNQmlGwJ+io5lQ2B32MU2oX9xVdB
	qPP+N7mXUvvqS5YCssPUwq4T/T9pX35FGl7IuEYIq704X98IMsD9THxxJWP3pQeJqAyaU3yEnTD
	DC5VR8b+H1Zx8zU7Qeiv1ON5vljM80b0QLv8YVmNLEfSs11ki8Dy/uGi5MhQdwZIiCBCQSGojPQ
	i+j9FPAEnvYkMczBGnxkL5OievumEC/GLIw1iKikvHPyHjQEdPAWAEq06YOTa3YCyHxenX0kHP2
	WE7NWEB2mZDQ4b7LM6UY7nOnvWI/7hdkw7v7acU/rI9KRDfaTL+gl
X-Received: by 2002:a05:620a:1a85:b0:8c6:a5bb:f464 with SMTP id af79cd13be357-8cb8ca80011mr932891385a.66.1771837714559;
        Mon, 23 Feb 2026 01:08:34 -0800 (PST)
X-Received: by 2002:a05:620a:1a85:b0:8c6:a5bb:f464 with SMTP id af79cd13be357-8cb8ca80011mr932889485a.66.1771837714053;
        Mon, 23 Feb 2026 01:08:34 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm264049295e9.7.2026.02.23.01.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:08:33 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:08:19 +0100
Subject: [PATCH v2 1/9] i2c: provide i2c_adapter_set_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-ada-dev-set-node-v2-1-77018c536610@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=kO3CZRW/M5+uqt+4EF42zBuOHZXpdkukqDjmw3J6cH4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBkG2zPpG8Di466UOvtYxyfv63pDibnP3vKb/
 0tuNQANP9WJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwZBgAKCRAFnS7L/zaE
 w0asD/0e3puICkKbF4SdUNpc/i1iaNevfAiKRUqumJQoNae+cW21yghL88N1k+aNV+XBPVh9zEy
 nyd/K6n+e8XBPdGmAoNsmgafUNq+yJgztZzvp9LdTiX1QA0O4aRuC3YcQq6keODHFUjUYDoRjuj
 2+FP+LyBZ0Aay2AQMJ4YJPewItq1fR9HN4q9vvRdrwquw5qaz+avyFUXzt4SN6VzrttCRKPMfGb
 1R0EigxJU3JBAMUArdeNL9ij5RewDfWD7uyG91Q2lvrSWMeJ4kkKMSNaf183KRWDpS7nhXHPWZi
 NTsSLt2hVGMXEHYUTw+mfkYzcLmYylP/nFcDKysfM1uKi2kk3j54Ohy7CfFnep0+PVSyN6AJNmL
 cPSgg2dJh5iBLd8L4JkTgwU/7vPtP7FONXQH/qrNhqxECvtSE61RigSNgM4z7/PalSJ5AQWWXVI
 6F7lNKR83iK+cjmzafpPOqef7HuclurQA/djNLx2C+ZZNq/KN531tAcqVBTCHbd2vhhmSO6xCkf
 zrAYm6QGGcoS2MZqFKHBKcB9A26glg18qjc6YKBISwDilxZpqYhJHyX/M4uz0hdYTZA+Iao+xvA
 b94pcHKwTUL302EbVjQ9JFVlrOUZlKcQ43q84ZuScPhsKYRyjH2OGeRQIhwzbAsJ+WvEmF/PipJ
 My5i9NyJMh0PWSQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=699c1913 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=IgsMUyhKevcMw2BC1NwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfXyJK8wMXxDrNj
 nRT1EnUplqiozwDoHN/0PHgtaa3TWI8Qrt7JCpB9GrvkuHzrInJoiz5zAesaFlHQCcWb8hCJxtK
 6pL6O0ffKTu1NzC1PT65PJK0ae02qClzjPXANd5hieQaNXq8p0nDI/d4vUYRstJbyzQoGBECOto
 gTwjmYaYggEDphL8gOFKcTE2e7apTihWHAsZK+U1ej+taWXOIOYgINGmJJPiH5dO+nsl9ZUHlOP
 JZFrxcEreaggkg+3x8vlqRGKp7lOOad4XW1VIEQOmJIJQUhvsHysptqM1kbZNlppTfO0mLoQ3T6
 8nBLqsGvjop82S0PGjm0pZFC/Djgy4/YY0ztyTVULwu/BTn3DCZYQfl3LR2q26Gt+PwOXl3bLJw
 Pp7nQO/OLLWFTktgAfKnu6sI63S/Qh1zpIbbUs+Hmkwr6MHUys2N9IVy/74k7NJ4D+xafPkLy9v
 KkcTB8konQlMwVZKAug==
X-Proofpoint-ORIG-GUID: 2sP25xZXqMBMUD0WQjzN0Tt6WZ5IdCS2
X-Proofpoint-GUID: 2sP25xZXqMBMUD0WQjzN0Tt6WZ5IdCS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

Provide a wrapper around device_set_node() that takes the i2c_adapter as
argument. This allows us to hide more dereferencing of the embedded
struct device as part of working towards fixing the object lifetime
issues in i2c.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 include/linux/i2c.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c85ee1665395c07345faafd8e2fca..38448bdfac671adcdf341adbe2f52341e5aec41a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -29,6 +29,7 @@ extern const struct device_type i2c_client_type;
 
 /* --- General options ------------------------------------------------	*/
 
+struct fwnode_handle;
 struct i2c_msg;
 struct i2c_adapter;
 struct i2c_client;
@@ -778,6 +779,12 @@ static inline void i2c_set_adapdata(struct i2c_adapter *adap, void *data)
 	dev_set_drvdata(&adap->dev, data);
 }
 
+static inline void i2c_adapter_set_node(struct i2c_adapter *adap,
+					struct fwnode_handle *fwnode)
+{
+	device_set_node(&adap->dev, fwnode);
+}
+
 static inline struct i2c_adapter *
 i2c_parent_is_i2c_adapter(const struct i2c_adapter *adapter)
 {

-- 
2.47.3

