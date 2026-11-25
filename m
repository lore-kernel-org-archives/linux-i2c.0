Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795575272;
	b=vzTYacVlRAbzjXAq5ObJsG1bfw/4+HdbP5VCBhSyvLr6GqalYH0ugModtNXbaO1idGaj
	 /SVg/cgqcEgIiePjgZLnS6WvTAAKsPGFchBp5sBmdEZP8Pl0/vD/f67zL9fPy52scF0Tu
	 iM6lzhYkTerOCAEBxnLBiKXCMYlNdDuRgfmtZALfSYTgqM0LIIHYFDyGIfnaZVXssPy3H
	 sbgjoTgTUjYBqLpvg/Sm0wWuXibfPqyeNM9kFvFU7KZgUJZRlhFXMbLGaUKRKAMCqHR8p
	 C2MVe1TDnos31cMNubXm3gC1SJT3eSsLfjnMjHBqJf4I4q/E5UJJd8WW7uUgEDcF3kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575272;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/khDiS/4shh7qKUcxmDnZE22uggyUrCuwzVWYRZ2m+M=;
	b=1dQHzhDzJpBjorTbfM3mRJ8iHUNQ/gFigfhFvPcGY+hIc2TxBcS0h1Rq1qFYXOUa+/Zk
	 OanOO4NZD4D18vFEv8dhJ61yXBcA6toX6P9ARZjni6cXPxrNHXCt6JdfH0wZNHtDR5Rgl
	 0/DEPMPyUz+NngrTiZZ1BKRMeDAH+pgdfLMQOj+NIWDsos9PzyX5er6r/I28EQ6OI8LLz
	 QdPVdrEOmrJIPWrlVoo7ZirvURHN91NfUAuOXmZBAI2Irx/OweBW7HjerROPmSNffEd9j
	 R+tWmQcEItXeONOK6YEuBIN/10TXquvZWXz7iRWuv/m/9j1JUaMbdVA3DR9+tXAGKPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b="BBcty40/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.59
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B255606A31E;
	Wed, 25 Nov 2026 02:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B255606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=BBcty40/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFU4Mmhkc0bakcwkO/9FrfU+QabcdspZQm7Ir9tUhXWpLF1oB/n6xNoz2cTiy3CGAqYk5m/3kwThz4Vr9EVv9zsilraH7AbF7QQRGpEyQYjx5oRs3vIWJKp76HYQFUWvfGVuIsMn1YDMD/tLE3/yPllos6hIUvDJTko9AMd+SoHKOv9FQrSwifqtOFeUsTSTVdghRXwbBHg5zDj6TR5C4uB11UHOfIGdVJfjgIMuNv3SvKttWgAj1yXY3x+12FSFqWpX/HA1wzAyAuZ0YApwe900WbtdTDzC2Mr7qW6TF2SRhtzubh/8BL5NjgpWx/Y+0zd8gxlY4v1eBM8WF6zgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/khDiS/4shh7qKUcxmDnZE22uggyUrCuwzVWYRZ2m+M=;
 b=hDNVuKl8A4Pjcw2HX+Ec1v+h6Ao5UQ7HcByoCkS8Jcwb7WUo2mdJExE6V9R54qaEZ3y7k4SfZY8COx39Y7WNrfduJ5O+59mHE1E/CiBCq7GHOMKaUg4QBuOTY/LQ9hgKT9qeKL8EupNi1WI4cMJc15zvDiOHG1ibVgKzPUQ4+3XBNxUFKB9sujZSKbL0/7X5OPeP5+dxBzxL0+UeKOq2JgpoF5POSToIoj7lqPPI+bOn+O5p3ZQImPh0cPuh5lhIoP01HfKMk2wIbC4hvStBto4sNZqTcAUzY11q8YAwyJGbm5ODCp2hxyLHndGUob2gDlVcynk4QMaEsVH6eBm9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 69.31.5.41) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/khDiS/4shh7qKUcxmDnZE22uggyUrCuwzVWYRZ2m+M=;
 b=BBcty40/SgTyzwCAWF3Dhxzg5FDUIGosy0+hc72ODGKuOmC3xZIOwNG/PQeoAdtIHOo6KrfkxfsAS8b4eGDzOpqikS/kWsVDhwDFlTqkykBnibca0dDcPbx5xjuvgcDyETUyjeeUuBkN76Le6nCIZqG+ORp8nxJifh0nv9EdKte1oOEzCDz8w2Es/vu7lzr4/8UrgKD36RF3VveIW2TGjU8JI1KBM6WagQxZ8awuNl5C6UipFnIN9B6p0ZG7y5pATKPHsyXjDNbp5gs23aHIZZwcwKIhPrB0MQE50RtdGksL1ozZ1hJPLPzswI7dvkF5+Z2QLmCC/Ddtvti5E8ubMQ==
Received: from MN0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:52c::31)
 by IA3PR02MB10721.namprd02.prod.outlook.com (2603:10b6:208:514::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 02:54:27 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::a) by MN0PR05CA0006.outlook.office365.com
 (2603:10b6:208:52c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Wed, 25
 Nov 2026 02:54:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 69.31.5.41) smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 69.31.5.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=69.31.5.41; helo=jabil.com; pr=C
Received: from jabil.com (69.31.5.41) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 02:54:25 +0000
Received: from USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) by
 USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 24 Nov 2026 21:54:20 -0500
Received: from 0BMCAMI.corp.JABIL.ORG (10.11.27.252) by
 USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Tue, 24 Nov 2026 21:54:17 -0500
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: <netdev@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
 Johnston <matt@codeconstruct.com.au>, Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4] mctp i2c: add sysfs control for mux child netdevs
Date: Wed, 25 Nov 2026 10:54:11 +0800
Message-ID: <20261125025411.986998-1-kenny_hsieh@jabil.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|IA3PR02MB10721:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c233c8-5ad6-4698-f1ff-08df4a9f6a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|30052699003|1800799024|82310400026|376014|7416014|10067099003|56012099006|5023799004|11063799006|261026121527099003|261026140227099003|261022115727099003|261028144727099003|261022105027099003|261022113327099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ytZ6KR3D03u5WPRIWDzrqPvICj9xDpojmSCN0zoS8CQtYc2k11loVqYUqc5aIEhts0eA1JdOIRpzX2DbQIuUC3NqeDrEnxjy1SPzk4WPxchCQdHn+nKGT2SMe7nMBe703rzBIxxjtqwb5sdaBrH7NtdKQfmAhE0Imbh6Z/LG2Ei85qeXwpqjoUDVFYslUdsbNdslmwZxzNF3HF/d+ZztnZZ2vv7oDek/ceDcviv77UpnV9lTLU59VC8I5BSfHog9qSC6moT9AQNLUqnAR7/Qkqgf0zsyaSYcMebkLKzA1YCelYumnZSyMl9PUrpQVrIG75d7cJEav3eQafbMCAwOu9OynsdLVnFsIjqdOmztuwsn+ovVdNAoRoqLU6pesV+2t2O22kfglyeIzv9eY3CXi4caEV/UQMBKzLJUUK5G/9xJeQtGLSgDOx7crCDh17hIO9NXrWtycdVT4vdMBPZFg8Y4vGqWY779gwPQeKQ19OkhxLK1pGR2DBR0jeerszYvOQDMPwJIR/PuGe+EIEaUSoa52BN4X6bl3IBrZiBcmJs9F9VsVzCFjsdletE8ulL33hF02R24nAdTpUTRznxL8qEpMBt3PakcKURhiJlvtx4v4uAUOSBgdhO4QzFPWRJsmBX3PA0EMDyb4jzimAnIeg==
X-Forefront-Antispam-Report:
	CIP:69.31.5.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(30052699003)(1800799024)(82310400026)(376014)(7416014)(10067099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261026140227099003)(261022115727099003)(261028144727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vE09/fEuHvbPSAL/U+IZbtavWBcFOOFZ2gzMPIDZi7LTn2ZuCGDqp+ck4FI3r3vOmT6kzkX2HmU5+8ohoFSqMrDJAgkKXvsSLskpNWTd+Ca5o+W22cutPiisVVYxnBEGD/zL9FsP+vZdk6duNJGTV2DezN+BE8TG+et+l5nMR9f6Co7f3/KJ2HfZoEJUgTj++uz429TxsXUeYHk69a5wPj+xaQHgnTLZtTqzLI4TK1l5+RJhNfT5jxW6vWm97MtWnt562iBhwRLOPwOk/y3umRcVYuqjp1Y042jxYw7RoVxlEgsn9tmvHMrLel29S0L/6mFguK9L7CiaACHAQKYio49h7C+yyZ2426wduse6lOAtDyi6GeWBZd+Da6OC3G+EPOkMDiPf5CN3cgNp06LgrfMq7LSxFWrLgTr7wqtsZtBfjJ24xQHHFQzx4q433H70
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 02:54:25.5112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c233c8-5ad6-4698-f1ff-08df4a9f6a67
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[69.31.5.41];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10721

An MCTP netdev is created for an I2C bus, root or mux channel, that
carries the "mctp-controller" devicetree property. A mux created at
runtime through the I2C sysfs interface has no devicetree node, and
neither do its channels, so they can never get a netdev.

This matters when the mux topology is only known at runtime. A BMC
that ships one firmware image across several chassis cannot describe
every chassis's mux tree in its devicetree, so userspace creates the
muxes it finds over I2C sysfs instead.

Add two write-only attributes to the mctp-i2c-controller device:

  echo i2c-30 > /sys/bus/i2c/devices/9-1010/add_mctp_controller
  echo i2c-30 > /sys/bus/i2c/devices/9-1010/remove_mctp_controller

Writing the name of a bus in the controller's mux tree creates or
removes the netdev for that bus.

The attributes belong to the driver, through dev_groups, so they exist
only while the controller is bound. Netdevs added through them are
removed on unbind and are not restored on rebind. The devicetree
property keeps working, and both can be used on the same mux tree.

mctp_i2c_add_netdev() now skips an adapter that already has a netdev.
An adapter can be reached twice: by the probe walk and then by its own
add notifier, or by a sysfs write that lands before that notifier.
The notifier also handles BUS_NOTIFY_REMOVED_DEVICE, since a sysfs
write can add a netdev after BUS_NOTIFY_DEL_DEVICE.

A write requires CAP_NET_ADMIN in the initial user namespace, as for
mctp-serial, since the netdev is for a physical bus.

Tested on an AST2700 BMC with a two-level mux tree: add and remove on
a channel without the devicetree property, unbind and bind of the
controller, and a loop of both while MCTP traffic runs on the channel.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
v4:
  - Check CAP_NET_ADMIN with capable() instead of in the writer's own
    netns, as Sashiko pointed out. Any task can get CAP_NET_ADMIN in a
    netns it creates, which made the old check no gate at all.
  - Fixed the commit message on where a duplicate add comes from, and
    explained BUS_NOTIFY_REMOVED_DEVICE in it.
  - Listed EPERM, EINVAL and the second ENODEV case in the ABI doc.
  - The double free on a failed register is fixed separately in net,
    now at v5, and the two patches apply in either order:
    https://lore.kernel.org/netdev/20261124101237.3884438-1-kenny_hsieh@jabil.com/

v3:
  - Moved the attributes to the mctp-i2c-controller device, as Matt
    suggested. The driver core handles their lifetime now, so the
    tracking list and the races Sashiko found with it are gone.
  - Repeated add returns -EEXIST, remove with no netdev returns -ENODEV,
    per Matt.
  - Also remove on BUS_NOTIFY_REMOVED_DEVICE, so a write racing an
    adapter delete can't leave a netdev behind.
  - Dropped the stored netns, since get_net() kept it alive while the
    controller was bound. The netdev goes in the writer's netns now.
  - Dropped the midev = NULL change, the double free is fixed separately:
    https://lore.kernel.org/netdev/20261118090515.3390034-1-kenny_hsieh@jabil.com/
  - Rewrote the ABI doc, rebased on current net-next.

v3: https://lore.kernel.org/netdev/20261118100231.3827609-1-kenny_hsieh@jabil.com/
v2: https://lore.kernel.org/netdev/20261015081341.1262695-1-kenny_hsieh@jabil.com/
v1: https://lore.kernel.org/netdev/20261002073156.759005-1-kenny_hsieh@jabil.com/

 .../ABI/testing/sysfs-bus-i2c-devices-mctp    |  27 +++++
 MAINTAINERS                                   |   1 +
 drivers/net/mctp/mctp-i2c.c                   | 110 ++++++++++++++++--
 3 files changed, 127 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
new file mode 100644
index 0000000000000..4efbc888c7bb8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
@@ -0,0 +1,27 @@
+What:		/sys/bus/i2c/devices/<bus>-<addr>/add_mctp_controller
+What:		/sys/bus/i2c/devices/<bus>-<addr>/remove_mctp_controller
+Date:		December 2026
+KernelVersion:	7.5
+Contact:	Kenny Hsieh <kenny_hsieh@jabil.com>
+Description:
+		Write-only, on each bound mctp-i2c-controller device.
+
+		Writing an I2C bus name such as "i2c-30" to add_mctp_controller
+		creates an MCTP network device for that bus, and writing it to
+		remove_mctp_controller removes it. The bus must be the
+		controller's root bus or a mux child below it. Adding a bus
+		that already has a network device fails with EEXIST, and
+		removing one that has none fails with ENODEV.
+		Writes need CAP_NET_ADMIN, else EPERM. A name that matches no
+		I2C device fails with ENODEV, and one that is not a bus in this
+		controller's mux tree with EINVAL.
+
+		This covers busses instantiated at runtime, which have no
+		devicetree node for the "mctp-controller" property. Network
+		devices added here are removed on unbind and not restored on
+		rebind.
+
+		Example::
+
+		  # echo i2c-30 > /sys/bus/i2c/devices/9-1010/add_mctp_controller
+		  # echo i2c-30 > /sys/bus/i2c/devices/9-1010/remove_mctp_controller
diff --git a/MAINTAINERS b/MAINTAINERS
index 7d8b59ae6ea6c..ca07689318285 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16093,6 +16093,7 @@ M:	Jeremy Kerr <jk@codeconstruct.com.au>
 M:	Matt Johnston <matt@codeconstruct.com.au>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
 F:	Documentation/networking/mctp.rst
 F:	drivers/net/mctp/
 F:	include/linux/usb/mctp-usb.h
diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d338bbf..ecc3036d54a35 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -857,6 +857,24 @@ static int mctp_i2c_ndo_open(struct net_device *dev)
 	return 0;
 }
 
+static struct mctp_i2c_dev *mctp_i2c_find_dev(struct mctp_i2c_client *mcli,
+					      struct i2c_adapter *adap)
+{
+	struct mctp_i2c_dev *midev = NULL, *m = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcli->sel_lock, flags);
+	/* List size is limited by number of MCTP netdevs on a single hardware bus */
+	list_for_each_entry(m, &mcli->devs, list)
+		if (m->adapter == adap) {
+			midev = m;
+			break;
+		}
+	spin_unlock_irqrestore(&mcli->sel_lock, flags);
+
+	return midev;
+}
+
 static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 			       struct i2c_adapter *adap)
 {
@@ -876,6 +894,9 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 	}
 
 	WARN_ON(!mutex_is_locked(&driver_clients_lock));
+	if (mctp_i2c_find_dev(mcli, adap))
+		return 0;
+
 	snprintf(namebuf, sizeof(namebuf), "mctpi2c%d", adap->nr);
 	ndev = alloc_netdev(sizeof(*midev), namebuf, NET_NAME_ENUM, mctp_i2c_net_setup);
 	if (!ndev) {
@@ -920,19 +941,10 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 static void mctp_i2c_remove_netdev(struct mctp_i2c_client *mcli,
 				   struct i2c_adapter *adap)
 {
-	struct mctp_i2c_dev *midev = NULL, *m = NULL;
-	unsigned long flags;
+	struct mctp_i2c_dev *midev;
 
 	WARN_ON(!mutex_is_locked(&driver_clients_lock));
-	spin_lock_irqsave(&mcli->sel_lock, flags);
-	/* List size is limited by number of MCTP netdevs on a single hardware bus */
-	list_for_each_entry(m, &mcli->devs, list)
-		if (m->adapter == adap) {
-			midev = m;
-			break;
-		}
-	spin_unlock_irqrestore(&mcli->sel_lock, flags);
-
+	midev = mctp_i2c_find_dev(mcli, adap);
 	if (midev)
 		mctp_i2c_unregister(midev);
 }
@@ -1077,6 +1089,79 @@ static void mctp_i2c_remove(struct i2c_client *client)
 	mutex_unlock(&driver_clients_lock);
 }
 
+/* Returns the named adapter in mcli's mux tree, with a reference held */
+static struct i2c_adapter *mctp_i2c_find_named(struct mctp_i2c_client *mcli,
+					       const char *name)
+{
+	struct i2c_adapter *adap = NULL, *root = NULL;
+	struct device *dev;
+
+	dev = bus_find_device_by_name(&i2c_bus_type, NULL, name);
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	adap = mctp_i2c_get_adapter(dev, &root);
+	if (!adap || root != mcli->client->adapter) {
+		put_device(dev);
+		return ERR_PTR(-EINVAL);
+	}
+	return adap;
+}
+
+static ssize_t mctp_i2c_controller_write(struct device *dev, const char *buf,
+					 size_t count, bool add)
+{
+	struct mctp_i2c_client *mcli = i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_adapter *adap;
+	int rc = 0;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	mutex_lock(&driver_clients_lock);
+	adap = mctp_i2c_find_named(mcli, buf);
+	if (IS_ERR(adap)) {
+		rc = PTR_ERR(adap);
+		goto out;
+	}
+
+	if (add && mctp_i2c_find_dev(mcli, adap))
+		rc = -EEXIST;
+	else if (add)
+		rc = mctp_i2c_add_netdev(mcli, adap);
+	else if (!mctp_i2c_find_dev(mcli, adap))
+		rc = -ENODEV;
+	else
+		mctp_i2c_remove_netdev(mcli, adap);
+	put_device(&adap->dev);
+out:
+	mutex_unlock(&driver_clients_lock);
+	return rc < 0 ? rc : count;
+}
+
+static ssize_t add_mctp_controller_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	return mctp_i2c_controller_write(dev, buf, count, true);
+}
+static DEVICE_ATTR_WO(add_mctp_controller);
+
+static ssize_t remove_mctp_controller_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	return mctp_i2c_controller_write(dev, buf, count, false);
+}
+static DEVICE_ATTR_WO(remove_mctp_controller);
+
+static struct attribute *mctp_i2c_attrs[] = {
+	&dev_attr_add_mctp_controller.attr,
+	&dev_attr_remove_mctp_controller.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mctp_i2c);
+
 /* We look for a 'mctp-controller' property on I2C busses as they are
  * added/deleted, creating/removing netdevs as required.
  */
@@ -1090,6 +1175,8 @@ static int mctp_i2c_notifier_call(struct notifier_block *nb,
 		mctp_i2c_notify_add(dev);
 		break;
 	case BUS_NOTIFY_DEL_DEVICE:
+	/* A sysfs write can add a netdev after DEL_DEVICE */
+	case BUS_NOTIFY_REMOVED_DEVICE:
 		mctp_i2c_notify_del(dev);
 		break;
 	}
@@ -1116,6 +1203,7 @@ static struct i2c_driver mctp_i2c_driver = {
 	.driver = {
 		.name = "mctp-i2c-interface",
 		.of_match_table = mctp_i2c_of_match,
+		.dev_groups = mctp_i2c_groups,
 	},
 	.probe = mctp_i2c_probe,
 	.remove = mctp_i2c_remove,
-- 
2.50.1

