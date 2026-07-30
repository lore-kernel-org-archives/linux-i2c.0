Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C316314B96;
	Thu, 30 Jul 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395969; cv=none; b=fhR8uQB2fIN3PXm6JM637tqCxmQjVKUk/AVKqqBUVSlHhAE71lsufxN52e5z4zf974slLh5TVhw5MvYJK624ky4ZCOPpGbNeOQHBKMKJrQ6zRyCeK6+D+ScgimpX7bI4tUSB926ioRqLGw0jgfgFXdupeh8nemDKWN3hc6C7LfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395969; c=relaxed/simple;
	bh=7/mEOwdm07xwUxnDVFZ0Lz5zv460CZQfjBTSdEc+Lvs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FEzUKPdalr7CthPxnDZjTDYqrrvX2oP3rjXUM3MGfK70MNRYoflIjHKQcaEuyTXVBfqktvmlLGp8/Og0BB06ry6dCutnE576r4Lm7sJ5AjAYnONz6h5oRimQv80Ca2F1pKxS8IawS/gE2mHByyPYvWgyJMrPpGD0VPkhL+ZeyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JaIFLRFz; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JaIFLRFz"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U7GfTI3452956;
	Thu, 30 Jul 2026 00:19:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=jONHOGGXl
	W2KOB60l4tNjLs8dvUHVfsSEhvSlfhk6Dw=; b=JaIFLRFz2Njc0t4eNn1RTjt+n
	x8V3+rszFRCIbWWM/yK8SzIJblF19uGgCw/U6tyw6fftr8SN371sqmssPt7j0t25
	KuKPLp4LVaD5T4DcwtaBp5gJzjvlavxy+4aoUmPFzxklBQL3UzX+Ob1ZFbTEqvG/
	s0gK6IL5+UKpuNCJALwuBvwiqvgrVFWpHi8aSe8DGPetkOKUiZXrmevxe4OGB533
	C1QmmBxj1Q/GI/eZ7TVHIhvi19nRdvQ6lPjo3P4NgFjE0WjuZtKSXBNOYA+/BVCx
	ypLPlIo0ee8TUsT8N4nEFnO119gs94IC4gb2za9OHz2UFo0D4RF6V6YiRcPYg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fr234803h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Jul 2026 00:19:06 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 30 Jul 2026 00:18:33 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 30 Jul 2026 00:18:32 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <andi.shyti@kernel.org>
CC: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] i2c: prevent new device registration during adapter removal
Date: Thu, 30 Jul 2026 15:18:31 +0800
Message-ID: <20260730071831.352749-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=P7oKQCAu c=1 sm=1 tr=0 ts=6a6afaea cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=kK67iIRHsozuyWsT6w0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: HiOMnF8PhbI6R3KojIiPdSYtQneY4YCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1MCBTYWx0ZWRfX+FsMrQLYC4rN
 qbqMgDmUXYYb5Ry/3l4SO617KHoSMdRb34bgaPISv78/hXdHClNqSncfHpeb2FNZSQ2Myf2/oKW
 IbRsPR9amVOfdEAUt/twDqGScROL7K9MJF0MWWTTpzINuyehTz4lnRJ6KONawWxJXRLmLkaMoLI
 Uprrr5onKOL/HMqHsFp4WjKHPDc8O6ot4ecEK8xULAikWaQXqvsqKiSGZnRGfjmhfnvZeOtSN3S
 4HCCqfn+6JMonBf6yOPsYI+MXvcqabILX/3dYfJibM1mRkDBhUF6MrXbt2JErk6nINQ/SWMv0k8
 wMyUkfVu3ZaYOodybrERocBdzJ8ybCrtNfi6EF3EIsqdtJecW4YBkVgSncV4GhTxNMea3irssGT
 5TdItGz0JxH3f/KZhTULJNADB3JTcuTg1gKr2ifpdZP2KAGO+x7I6SFTRQme/eR7F6FmPCUCI+y
 pvA4zl70kufS6KtpByA==
X-Proofpoint-ORIG-GUID: HiOMnF8PhbI6R3KojIiPdSYtQneY4YCl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1MCBTYWx0ZWRfX7kKi0iEDUtVA
 95nwzqUD12eJugQzKYgJcsDQukFXRHc/zd/BWxMKJF2J1rPQV59/Yn22fW+YWLrh2v/Auo7r9Lm
 /8iaUJaKhecSGepLEyI44cRwMqOJLHFqf1I0svK8Q0NFOj/m76Bk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300050

Remove new_device and delete_device sysfs attributes early in
i2c_del_adapter() to prevent concurrent client registrations during
adapter teardown. Without this, a racing new_device_store() can
register a client that will never be cleaned up, causing
wait_for_completion() to block indefinitely.

Fixes: 99cd8e25875a ("i2c: Add a sysfs interface to instantiate devices")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/i2c/i2c-core-base.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ec04787a737..0f207520d6f9 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1817,6 +1817,14 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	i2c_acpi_remove_space_handler(adap);
 
+	/*
+	 * Remove new_device/delete_device sysfs attrs early to prevent
+	 * new client registrations via userspace while we're tearing down.
+	 * kernfs will wait for any in-flight writes to complete.
+	 */
+	device_remove_file(&adap->dev, &dev_attr_new_device);
+	device_remove_file(&adap->dev, &dev_attr_delete_device);
+
 	i2c_deregister_clients(adap);
 
 	/* device name is gone after device_unregister */
-- 
2.43.0

