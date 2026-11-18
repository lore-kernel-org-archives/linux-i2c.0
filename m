Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794996170;
	b=aIDO94JWpPpGr3QAl/gwsPNsfTjzLIKdFkCXvdsPkCBCmNRF19fvwKTaxLyOhdYQm+Fq
	 iiHBDX/7f3W1jhxiD2FsbgAx+pTSr4Uz7rTmAuM+hItj7nEWBVHoWr75kY+IYEp0Oe14j
	 pWE8IoAQriRMd/FSlhoKE4ely+L6tGuEJEo+FBn6fBqbUCZhlY6hcojKL3MwuknmMdSUi
	 xTj9cy52X13bxqJBkdzMfT/1RmbDf0IFY1zLcNBOTFA37VgaInbDriJ45yCn4uoOnE+t7
	 WlKUOM0D07ndUgWG+Ht3VQE/p9ZmlTOv+wI7sFFSU9lCdFBjkfQIrY6SeO7FzMB3Y6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996170;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ENPt05YGqRAXsgKJh9rtY4AHJQW34kaLlJ2l5YpTub0=;
	b=Gjx1yUUpvRNTo7HPaNLa87SkGK1JY61fIpEB0eBbyfv9WDO36V9nb4GuXGgSxpAyDaDx
	 8H2FfhmpUCfMjh4veVRidrkeCQqx5/5HUbmB7AZm49wyzSi9jj7hWIwcqst5Bnyn+8V2W
	 QqPFGn/g8lVnAqu1vu1r4S+CwJbZHZgbSVxFY6AWLV7dRWfpqgJxYbb4s+OU22Sm1jiwl
	 IePm11kCeQK2sbq51keG8NJQT6Bhb+ErMsfltrbjnQU28C5U70LMIiD1tme8H0P1gg9R5
	 MTad6p//gOTCP9pOEatXFHN2HDqS+FiKWIW7v/6P+Hd43igDLSZXOh5a97xtmJJoWig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=nwGGoSAJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.3
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4E8606A325;
	Wed, 18 Nov 2026 10:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE4E8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=nwGGoSAJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoO2ujyQXbcvIxvYZCb8+riiDb+XT63Tkr1nUyoi+80+IicyVGAz7+Yv6FS/10Ol9rb7Xs/r0srn3BQ8lF2Hh9wZ7qQqbzXsyuWlquJLl+utPoxg3NyYxH4WDoJWiuUZxvxQz2EGhaKZ89UtXVTHdNz6XrHJj/AC5WEeFeqSuBxp+i4asJ7hqo2Z5Zk78hmaoHgVH723Nte1UwxPZ4/o4juDKkSfc9kh9U2ca1UVYdEDMYqsyGJki463c5U8xHIlFy+f9e9KkZeGwXbdTs9iqk3Q6JJGePtdRv7t0uafV+PydFJl/pe89pj16NwycVVEfwarUUyA6p92Suvi9ninhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENPt05YGqRAXsgKJh9rtY4AHJQW34kaLlJ2l5YpTub0=;
 b=XEfXQn3K5zKKjntTwS+qseLY9/oia7puCLhUJddUpNsWSv0wPA5om+QDgoGBkJboOU5zRwH9GoIZqS2a8d7RFQPAJQgtEeNNQE7wieEpMt8g5qqDBhM8y2OzB1GI1KLpO3rztuYlkneUDbwWE22F1rGt7vLPqmCzW82g84ODMwLdLeTqV73AaeEFEqbh68HyexhMpRADXAFIjlUY87Qds7ow0MuQhSqF/aqy3OQ9Ao6tFmE1FSl4je0bEOnnSxXLkimWMns7Rye94KU+bvseckylLFIzMEX5RhtqW8x/xH5DYWPsAzmm/zQfW5G/BYiVSeX6BjzmIUxAxSNRRFfRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 69.31.5.41) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENPt05YGqRAXsgKJh9rtY4AHJQW34kaLlJ2l5YpTub0=;
 b=nwGGoSAJOKcmeNxvmmMs3POpDLyhvRQcpqOuJ/DY5ipfINRskPGjQ38hitiXalZ8Vtl48MCiL6DRdeLAcjSznoeqxS3t+IAu2R/kghvFRBmUSGog3WcIkdHBqCqnIQJ2vRtxoHwemdhAHuz5fkGIXbT388OZPrLEMXfYG5pgZGfHiCE1UnqzzDNSU5L0f/hM9EzBcvSYYj5P+LesSx3OiE7df4rUmJ+N8HEshMkzFthKxu4O5ydEgHDCDvBT9z0i+q+dyOjSqdebpkC8Kk5Vtc2rUFpecQv70lJc6tTXclIar+/3O6EkORplO9oPyhE7fvtKHiAOTxERSg9kU2TkrA==
Received: from CH0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:610:cc::16)
 by EA8PPF12B131AFC.namprd02.prod.outlook.com (2603:10b6:30f:fff5::8c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 10:02:46 +0000
Received: from BL2PEPF000352D5.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::87) by CH0PR03CA0071.outlook.office365.com
 (2603:10b6:610:cc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 10:02:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 69.31.5.41) smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 69.31.5.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=69.31.5.41; helo=jabil.com; pr=C
Received: from jabil.com (69.31.5.41) by
 BL2PEPF000352D5.mail.protection.outlook.com (10.167.254.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 10:02:45 +0000
Received: from USPLND0HUB81.staging.JABIL.ORG (10.11.24.250) by
 USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 18 Nov 2026 05:02:41 -0500
Received: from USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) by
 USPLND0HUB81.staging.JABIL.ORG (10.11.24.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Nov 2026 04:02:40 -0600
Received: from 0BMCAMI.corp.JABIL.ORG (10.11.27.252) by
 USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Wed, 18 Nov 2026 05:02:37 -0500
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: <netdev@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, "Matt
 Johnston" <matt@codeconstruct.com.au>, Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3] mctp i2c: add sysfs control for mux child netdevs
Date: Wed, 18 Nov 2026 18:02:31 +0800
Message-ID: <20261118100231.3827609-1-kenny_hsieh@jabil.com>
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
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D5:EE_|EA8PPF12B131AFC:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa920d0-b7aa-4ce5-7c3c-08df455b1803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|30052699003|18002099003|13003099007|5023799004|11063799006|10067099003|261022105027099003|261022113327099003|261026140227099003|261028144727099003|261022075727099003|261022115727099003|261026121527099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	+XH5sVW5JB/7PUl/j7sw1brBnsoCdblQh04MFkTvLoBbPOGF9NukfWCL0lLhXns8g/rAAcF/n3wzZGRdxbKv1VJic7VeC/w2OkxPiR0e55yvhNbba8ZwAf8Gq1iCKBv7p1na2g4++JZ2fyreTiMKP6Z27cAZp0ON4mrV993BF8+nWUIhpP1/iWGiqHt2SP7sz8DjZdlIZLyxDmRUKUi6Qb/E1WVdG8MGBJHcVCQtZt8ZLXY9g93w3GPxrNZfA1sMu3mOb5hMYCiiZXd6H59ckx1Uw9bUf5s/gnNbB2KK5wmWKf2+e9cXIqAqD5tupcKsRypWSUf292HHyaLSN+k5nOv3ri55CzWMRT3bohEwE8Atg9KkgN6ckaFZ2N/CEwIQh3Pm7Vie6gTkmjuqwCQTwjKfoUtRJwUT3QrJ/IQp5veJL3v+qir3yHch+V2Sagoey9mm6iztJX5/d2VCjf1eZ0zh4Dj5QpA1DyktR82YDBCX8svoXiOuvWI337hFuR5TvF15p44EoUZcdytH/bXlJXi4GwXNRRPMNLq1c4bbvqU8mpl+deRxNialfCPDvyGXTHepu9K47ebYn4zn/86QxPKrApR4mRh9SXuPt65yJBhrbW5wa2r7cJp4zR/A1izJBu4Ma3oVb2w6Fe4Te9XJwdItiax1wLlAHUHZPEFYagU=
X-Forefront-Antispam-Report:
	CIP:69.31.5.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(30052699003)(18002099003)(13003099007)(5023799004)(11063799006)(10067099003)(261022105027099003)(261022113327099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022115727099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EtNVqwSFZ/vPiTuIEIA5i1Z0O8eMlXGH6HzFx7Kr91fNzqFBZ+W63f+HjgsRFPVcxKnP36uPm5Z7beDC3Ex2LbSl5U6MUYCSdDZwAk/bFdqvJNAArTdmMgcf5PCTOgnkdQ7TKobocIYI6Y/sgtpbEhvxBDQr0hKOQjPzjNUHELaC6QgCjGslPGEDLDDRWh1HGhNtJkGilRWUngM4OhqVCUnzcCwW2z08BupSrFklwDKQnPqjqxPjCdsSZkY4VUrJ148zrd2HeDb7c4FmgTsEuCjLqI/DQvzQpXJQwOuNahoGuOHMTJojCUgyyE6sc18LK/KD3u2w88gOeBxImOQzI1WWbVWu9AQUd9s7ElkznU83S6DGYwPY9k+ZnZqnGuUmBNx1864XvS5qKE+f+fY6OTKBzszyi4tSde9ltH0tf60GfB5Qj1xeIJdzxL7r/yDI
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:02:45.6757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa920d0-b7aa-4ce5-7c3c-08df455b1803
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[69.31.5.41];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352D5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF12B131AFC

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
mctp_i2c_add_netdev() now skips an adapter that already has a netdev,
so a probe walk or an add notifier that reaches an adapter a second
time no longer fails on the duplicate mctpi2c name.

The netdev is created in the writer's network namespace, and a write
requires CAP_NET_ADMIN there, as for a netdev created over rtnetlink.

Tested on an AST2700 BMC with a two-level mux tree: add and remove on
a channel without the devicetree property, unbind and bind of the
controller, and a loop of both while MCTP traffic runs on the channel.

Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
v3:
  - Moved the attributes to the mctp-i2c-controller device, as Matt
    suggested. The driver core handles their lifetime now, so the
    tracking list and the races Sashiko found with it are gone.
  - Repeated add returns -EEXIST, remove with no netdev returns -ENODEV,
    per Matt.
  - Also remove on BUS_NOTIFY_REMOVED_DEVICE, so a write racing an
    adapter delete can't leave a netdev behind.
  - Dropped the stored netns, since get_net() kept it alive while the
    controller was bound. The netdev goes in the writer's netns now, as
    with rtnetlink, so there's no same-netns check anymore.
  - Dropped the midev = NULL change, the double free is fixed separately:
    https://lore.kernel.org/netdev/20261118090515.3390034-1-kenny_hsieh@jabil.com/
  - Rewrote the ABI doc, rebased on current net-next.

v2: https://lore.kernel.org/netdev/20261015081341.1262695-1-kenny_hsieh@jabil.com/
v1: https://lore.kernel.org/netdev/20261002073156.759005-1-kenny_hsieh@jabil.com/

 .../ABI/testing/sysfs-bus-i2c-devices-mctp    |  24 ++++
 MAINTAINERS                                   |   1 +
 drivers/net/mctp/mctp-i2c.c                   | 110 ++++++++++++++++--
 3 files changed, 124 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
new file mode 100644
index 0000000000000..4ee96254f57a4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
@@ -0,0 +1,24 @@
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
index b02476d338bbf..61dd4a9e72545 100644
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
+	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_ADMIN))
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

