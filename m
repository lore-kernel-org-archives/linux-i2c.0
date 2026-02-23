Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612A350A10
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837726; cv=none; b=nQvtPhJy2N1R/HjXnJceaZmW+5HM5bM95czdtNrdIuhanYsEzL/5LP8KMPOZEBQvHE6PwJvtzYzFMUlmt+spTA5bIO3e71AK8mrtnvGaazzE5JZCFDW1lMR0gBqG7cMbDrTYx+Ov7l3kxiU66DTt4X6UBgEQGXXHEPcg882rBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837726; c=relaxed/simple;
	bh=/GP/zYso5A0SHWvWSzvaIfVcse3lbidG+Y7zPANDhd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dU7yhUdC1fiCkc6TMOwCiKXLidhHH8FbK2y7IenPmGXTt1Sf3RAg9IoeI6/0m8u6gkjCGaNOWFKjQ4xgBuBmvP/FUQpK/zWSFbwRcaeoEomYmkcMB2iRL+p7KrxNhInvKT/JhvpryY0XgjFH4VayIBRaSEU/6GUjS/s+BIvyf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a6hZP7jY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GlkvYSWL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a6hZP7jY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GlkvYSWL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMUCXF1687472
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BDVvuF+FWHEJn6n7VtwYeyoAX6Ys4Day7oFD9Rg33Qc=; b=a6hZP7jYVlBJd6hk
	NL8ZAM0tp+pR4yWxowKTP7uyTIPYaJK6R+Gylr9QIMqx9VuFMr8O8+eYLX/8hbcL
	laJKLF7uOys83qAQOXjGxQtgPUv5NjQ4ngJ3D0i9ukzYmqab2/0lt8/uSeyfb2yj
	0dBufSVyqsdyxQ8Pr6Uzw92THmYNcqO7k6VLSkqWI5GqYfi420fcwuG3JKPWEucb
	2ZqNgqPJA7Y20H9QGXylkNF0J4Y5ptOeBc897W30atL7PHoUujknsATADTKv7fQd
	eIhpCDTkjRh0KICPNOANttwZQgMnCZj7nlbYq+p4dEisPC7QE22Rba01L80LvswH
	0LpJKw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u9v3re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:08:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70b6a5821so3436043085a.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837724; x=1772442524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDVvuF+FWHEJn6n7VtwYeyoAX6Ys4Day7oFD9Rg33Qc=;
        b=GlkvYSWLmrt+3AqEZHBj2Va9G6WLZzlVXPcw+m+iSnYqXgNl+L2mNWO62/MWiry9wr
         NTweM66y9o82ORI42r140vD1RokOn0lbwO3c1tN5uQ7APTAHLUBbiPWVoR4kpBJDahGy
         eEGqW7UQs6A8yQUIh7KO0L5xfoIXTKbMtvH7fEIWR0qjQ7R4sOGwBvU6IFP9Eb0xQJyl
         w/1u04r1OoJT9ZHkAnI6c0XYcm+T8hdbuXC5HJjccXxHDUJkt+x4nFdVzZR/fEFu8qor
         sJ0raDX2lh/qQanuhzOneEe06Ozm5qt8JBIafs3l5IJ6kqsw3aypJPIebHIGoyNPNWjU
         h64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837724; x=1772442524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BDVvuF+FWHEJn6n7VtwYeyoAX6Ys4Day7oFD9Rg33Qc=;
        b=hKPYFzyo3H8OZOYO9VncUQB3ti1ovtQsmrsojhmo+5bxslU6040eyme00lqmweJtVe
         yxPwUN+3GJ7drASPbx8slA//5Ga6ZJfw0TJ6m0cgFlh0ZPmt1kkrYRfR8yn1scRbERUo
         21NJF8VVvkIFavLfyglGyi3MF9btKI/cDrWw2QK2y7NPQtR7ieajWU75WdYDnLbTs/f3
         0D1elkBhKZAOjatcriP6uxqSOCY7S4a00emVakWRYnWaAY61hfaqQNlraDm2VVaMLRq9
         4NbRk2fMFEgLmsxdjZps9OhEhldeDVcMIeOB9Gh1VfHbmoR4CEucrE26WrUXOfGSSsFb
         /jVg==
X-Forwarded-Encrypted: i=1; AJvYcCWPxcUOO5hA0AnIrYcEqC8F6oqnTnnHDSuW+kn3GvfxTHgCEoQuXSSZRUp5TS9AXdFmz9+RFfgVELw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDv+IDciWGZrkBV3MUVjwpWb2W91P7xZhl0fJvYMOoa6HrhKSY
	thb4XQ3y4sV6SXXEGUaYvT07wJhash5lKuHa1xll+Ls9EymR8Wkj1O8TNRYQChDi6t1pjKcrIpm
	+au/8FS3erQWnIekPQyePWo3CzeiSwAar7MvrsV+G71Js+/7Vmc1X1TFex+0m3aM=
X-Gm-Gg: AZuq6aIBzmU1cnP7Ed7xQ1EAMLLa/LlgqP75Va+PQflrK+rzAZdMlJMKmUrQ0M1i2W1
	KhWhuQsDtRjKxJPsvP0nEOrY9H9frQI1Hg9RoLgJ+Vvfsh70KhCVAHczl9CGw3qfxbA5DMx2ZMp
	zkIt1xtaLnk4wzf29n8CR0VBqa0jwG+M/Ak8uzpPLon/9mna2Vb4uBWysBHnspPWaxV+QSJPbFc
	2zGQOZUfScOg4sF8prpyESghYKjvqfbumgPDsnFNk2amzdEQUzTCqpT2SASHDX3MX2MmyblYxAT
	+nPgsRrVfWydNI5c0bfX+U3SV4VD5HOg+IKrjuEI7dDDOKr0RHVMQgLg6a2+IPmGeZUW8zOOLWH
	NbrgtN/hPG0glccL/pNfbslhJa0LWy1dGyo38Jc5qhEtB0ioL0ypT
X-Received: by 2002:a05:620a:3197:b0:8cb:4013:2812 with SMTP id af79cd13be357-8cb8c9e68aemr943618785a.1.1771837723723;
        Mon, 23 Feb 2026 01:08:43 -0800 (PST)
X-Received: by 2002:a05:620a:3197:b0:8cb:4013:2812 with SMTP id af79cd13be357-8cb8c9e68aemr943616785a.1.1771837723220;
        Mon, 23 Feb 2026 01:08:43 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm264049295e9.7.2026.02.23.01.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:08:42 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:08:25 +0100
Subject: [PATCH v2 7/9] i2c: usbio: use i2c_adapter_set_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-ada-dev-set-node-v2-7-77018c536610@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/GP/zYso5A0SHWvWSzvaIfVcse3lbidG+Y7zPANDhd4=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGmcGQ3I7Tql+V7x2gfiyD39jbUZeefr8fEtfBNuvzVQ5ibQa
 okCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJpnBkNAAoJEAWdLsv/NoTDEmwQAKUH
 MGIlAAr3gIg4SW1aQlzeYmbNiYRNL/K7EngVxjcMqfDsr4cxRgUqg4BKqF7ZN1gQ0mJNdikqK1H
 hsSVGKFnTtD4ziJZRKpCR7nnBLx1lOpB6L75j77D0455TDxN0UrwApffMLFLk70S0bGoyGlGaeJ
 NjRgwJzpoqHD+Bx5LEMU7YRJRJSckSrNRl9vir7IPZ8aBniXeCBSGQtLmzLTx0rQCoysJI9KAae
 P79LwLt6KjeYjtLMqjqw9NA+PGPmrjtckWHDlylbHE14+87ytK2kDv6QlOTRSpDswzbPiFWOQXY
 K6BzzyVgKZhxqcF2X4VrQutst9qbytRS/fgt63HAOoyJ5Y50M597+3zOmsyuFXzwMi9nrhV/Y5H
 uQ5wmuq6OAfImY8craiRiJMeggG7KPErJRmETLw4CsRwx6Bg5ubGwJ4162jaBmfk/sea7w10nDp
 od42d/Wym/vtjnDH9dvaZ31mZQvp5S5TXHypI0Iyw88SM+7tU68TAxhO+6W7bR8Zn78/R6qyV2v
 RWbePeRxqY7TFmGATE/PZaa/TTN+iF1GZT8Mmx9rhx54C517yaogG1gvZpYUMi3djfxrHQalG98
 kzWUrCd6pZm+gmBhuc4CCbMhOc1Wl5aJCAXxRZrYyoVBzRXgr4VZTjMOqlMOMNn9/mGZatbopyt
 7v028
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX0Zh+3grBzb6W
 fPXQV7HwAveTyFUB3HaruJD1nOXviUNahR1bMnh5bPzpgB2A6By71syrCbP4ev1G7qzLwsPBpVQ
 yvfBBcWn8pyVnyPzv0zVsR0PbHYDeYzG+bH2HqV5S1GyAcP9JVs+PtllEYnCK/HirbVXxC5+R5C
 HL6Vak2AbsShA4/UEoVBBqEvYrZGU3mdWa6vLdDKVS/Jf30CKDs5ChBWMJ+A5gaEu2f7ej1LW39
 VdI2nN8+CvMA4gRWJGV696ON5NzzgCrAbTJI9wXxHsTl9yjygS1NrYTp4qKMCieAD3+7w1EYB2U
 DtlEwPsxEXAOoRq0edQL5j2a8XnIKUh4uDapGIZVNS8KLU4d3QNRUeb8OdiDac7zOd7aqKRgAt/
 HBZDtIn7Spdh8spvUQ7TZloUIXm7yulLrKimvp6sSDZYMBjbsIYX9z1QcYja1GwdASNggGnBYrb
 9mD8P68pRwFPB+sLsqw==
X-Proofpoint-GUID: MT2wr2V8BVlOz2A7rIBI79ghvUX98U1U
X-Proofpoint-ORIG-GUID: MT2wr2V8BVlOz2A7rIBI79ghvUX98U1U
X-Authority-Analysis: v=2.4 cv=RpDI7SmK c=1 sm=1 tr=0 ts=699c191c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QyXUC8HyAAAA:8
 a=EUspDBNiAAAA:8 a=M9yQa1kB9IGsLdw4TO0A:9 a=QEXdDO2ut3YA:10
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

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-usbio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-usbio.c b/drivers/i2c/busses/i2c-usbio.c
index e7799abf67877906c7787235bddb28ac23168077..4824d61fc85d7b23fd7f6a8c2be5809ad9fe2613 100644
--- a/drivers/i2c/busses/i2c-usbio.c
+++ b/drivers/i2c/busses/i2c-usbio.c
@@ -278,7 +278,7 @@ static int usbio_i2c_probe(struct auxiliary_device *adev,
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name), "%s.%d",
 		 USBIO_I2C_CLIENT, i2c->adev->id);
 
-	device_set_node(&i2c->adap.dev, dev_fwnode(&adev->dev));
+	i2c_adapter_set_node(&i2c->adap, dev_fwnode(&adev->dev));
 
 	auxiliary_set_drvdata(adev, i2c);
 	i2c_set_adapdata(&i2c->adap, i2c);

-- 
2.47.3

