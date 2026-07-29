Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCEF43E486;
	Wed, 29 Jul 2026 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785315562; cv=none; b=n21z2Gy/gwU7tk5cXIFpgV/fdvkE+Ky2k1kINeezZn5L/QKi9a5lq9Ye6l8gND1wUdUG/Yj8g4wINCrVpEwmQiyP3Y9RtiRo6dpYdnTFbIJTv1wPIwbAXa5sHaX2fm0/BVGnrUFAH0O3fuLsXz2J76tQzIAK16IfaCG0ajh6zIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785315562; c=relaxed/simple;
	bh=sp4RA9l6HO0Xim5IXdsreevaypuuawSAi7o+z0rSPWs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ps5kGKmrOT0TyllCVQm4tFfeX4MqfMtQGFDMwULGyow2VLOhc/oZCfBk3mc5lNyEVWC2rLeRv477Ou7UaiQMZ+I2GamaXqRfYaK+ZEAlnk2RYA1ikEopya3YrliU4MlWiYx8nYUj0F+2H/+3EM4dQLbGVMqVK9bX0R4VZUQ6PhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=J05zIUnD; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="J05zIUnD"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7cjBr992887;
	Wed, 29 Jul 2026 01:58:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Nb34bl4Yr
	hWQ0hQYWKEHzNEDlDhPnSU7YlBY6LvzrW8=; b=J05zIUnDAVrIFWq4UAN/cKWHn
	UK+bWtU/ScLJhL4I5R6Z45gAW0qmFM941E3PKrXAOsAD5HoRZp0FWEKfiJiEYP32
	qTczJm8FWROpuMw8Ti56AhmDYRaTFhRRoAj2DbDYvJ6n04987uKgjMRZKB2u/EMy
	LmzKG+35DkVHB/AudB8n7kwuWzTD6QHFntKPRc4NjcurSrXJNFL11yvNWVfdX15T
	Qfda6LXCeCN6pb9HOPmp5gEZjOJUHQkTqNsRelVJpES2Ss2PShHIihBBPenZVwfF
	FmoZCNbPORc9VRTjuFtApHsj6/4CLsvEQ17tWOrBTnvqFc3G09EtW78eiiMsw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fq86nref7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 29 Jul 2026 01:58:56 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 29 Jul 2026 01:58:55 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 29 Jul 2026 01:58:54 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <andi.shyti@kernel.org>
CC: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] i2c: fix use-after-free in debugfs directory during adapter removal
Date: Wed, 29 Jul 2026 16:58:53 +0800
Message-ID: <20260729085853.1624451-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jHUjkf9fED3fhcZyEb7a1Su-p4ySo_5L
X-Authority-Analysis: v=2.4 cv=f594wuyM c=1 sm=1 tr=0 ts=6a69c0d0 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=yrT7EzWpNdnlfDkubj4A:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3MyBTYWx0ZWRfX+iEViaWJYBVU
 GVR2xmIKQHdMsWq7Inn1HBrRORQ/Vp+XMgPM3mssDQeslF2R+fbYA+xUu/ZMy2htmIqKKDw8Zu6
 Gnov0/np5K1I8Inhs52mgtrOVIYaRBryIa9xWM5kb3TFDteVhuIV
X-Proofpoint-GUID: jHUjkf9fED3fhcZyEb7a1Su-p4ySo_5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3MyBTYWx0ZWRfX2u+grRCuj3XZ
 23L8KnpQXV5rrQ8z+AIadOCaJ7CTv8nvS83qcHxnsgnw/AVqF29uypjJhJIDyP/i7AH6nfuQllQ
 ptsi+a3KdSriaH+plqaolHOxDm3lsMErlEL9fAKPfIe5F5Xw/IiGpjkCudIUFt+Z72xaUJ75/hO
 VZu9uXdbNuzvrWOwHFNSj3LTaqD2wHiNG7Jl+rhns48wM/BucdCNEIibF6qAp54SVv0NPwq4Kv3
 LC8ISlPOvI1a8ewyGiuZqtqRVIYnT/58VIILYNrI8PWwqxbsk3vJpqH9NSEl5WqWVKY9k1Hff7c
 DRZ6yD7YnWVNtnWG8lKi7SFJ9xqtyoATSk2wNj4ElLq3jrbbC6h5C5dDFhoHL5Ba2129BlTFV/i
 r6Zr1OjCmlPBMqEWg0J8wjD9IiZgRyOThSW75akuZmECT4o8QWvHTog2MfMxIDnUv0jzg/jwILB
 0ColI9TLgHmHzsi5M/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290073

Move debugfs_remove_recursive() after device_unregister() in
i2c_del_adapter() to fix a race condition where a new i2c device probe
can access the adapter's already-freed debugfs dentry.

The race occurs when:
1. i2c_del_adapter() calls debugfs_remove_recursive(adap->debugfs),
   freeing the debugfs dentry.
2. Before device_unregister() completes, another thread writes to the
   sysfs 'new_device' attribute, triggering i2c_device_probe().
3. i2c_device_probe() calls debugfs_create_dir() with the stale
   adapter->debugfs pointer, causing a GPF in start_dirop() when
   trying to lock the freed inode.

Reported-by: syzbot+1e3d934ee3cff1ac188b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e3d934ee3cff1ac188b
Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/i2c/i2c-core-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ec04787a737..9b0f3c783e9c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1826,8 +1826,6 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 
 	i2c_host_notify_irq_teardown(adap);
 
-	debugfs_remove_recursive(adap->debugfs);
-
 	/* wait until all references to the device are gone
 	 *
 	 * FIXME: This is old code and should ideally be replaced by an
@@ -1839,6 +1837,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
 
+	debugfs_remove_recursive(adap->debugfs);
+
 	/* free bus id */
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.43.0

