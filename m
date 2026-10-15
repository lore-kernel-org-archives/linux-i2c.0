Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E34734FD;
	Thu, 15 Oct 2026 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052043; cv=fail; b=ToCIA7agOMegKkpmfK1jzko9Am8D6lu75xTfsZFLceCDWYYloByfKmgYw7TRZMAIHku/3DkWWN55vD0yOCpQA+628k1ph85J5vc9qhhwySI3BHTog+GEK8Qusr/in3+sutLEjUlT82NAvwZAQhvwLMYNAK0UDNauugGBN4A1NFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052043; c=relaxed/simple;
	bh=MGN1mbq+PDoLVEx7wprc631xkzrwokvP3qSfCnZQpWY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d5nzYEgO1nIXBKPQ8qSc/MpPYkjf6P+gVmLs5AxSVjUIClDacwSRJV0QmolXFSy2xkJAJlEbgZa9nNX9zidpqMEgcPsX8FUsebduJ/Q96bp7EkwC/7xmO7wu+JXlqf1tpYbqSwumpUli4tSkKJz4PZw3BqF4p4HdS2ky3eRfisU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com; spf=pass smtp.mailfrom=jabil.com; dkim=pass (2048-bit key) header.d=jabil.com header.i=@jabil.com header.b=fvwhJD3I; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jabil.com header.i=@jabil.com header.b="fvwhJD3I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYmVzi9w1K1eCy5vQaxoA4OFOgTVNkMIrC3AFfWWa9TemAAGAt8WMfThDWQFydgwKd9krhYbdqhEMKfHzzkb3TZi+iI82rccJoEsZwd4FSsTg4UcmXVZxjD9ghWrXwpvnMk7zkP6oBoC4Fe62oAnrIhzH1V/YS2Ky1umY3KrrAfD4FoE8NYRet7RwqTsti53K7XrSyjIMcBp+LbDGAJH0Y5DNdK8IEQ94mcLg4cMkUzgQ267wxOpprA9T1FILzZjGVZnK5TOMTmteUh4ZAzKDoUDROTiw/lDExKHGYxbQ8nLo9Fb027fCKg4iQcuPyFRHwa5wBTfKkT6KmCKgxsyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwN+HrHUqrfU8w8i6EmI23g53bKWWWL5Crl4CRN1cQY=;
 b=jMoFKo3vHsg/yjrXbGoY+f/hZl2rQ8PPNNPtX7OXT4D87iUNxp3jvYlb/rIcZw3jC7A8anYE4UJMToicYl6AWgv57dt4SDAOoiIUblDOdn6Xj2lAuQYiRM8j+AAR5UoZPRacv+vKGaAuF/Hp18KW4mv5boUuGmXvRphjLVL9e/lcUVUiqZoZqQdExAPIaRkrS2fnLrBI7gWBTHbD6e+NDs3sjpLNv5GkWB7qo621FiifZfOoacD0xkAH+viTex70i7HA0Lv0J7Z5cpRElKv9R6lENTCKlCG/rU7QM+8lBodrs5Xq587YjnhycEHXkP6oNe7BkswTEEM4PLN12Rspxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwN+HrHUqrfU8w8i6EmI23g53bKWWWL5Crl4CRN1cQY=;
 b=fvwhJD3I3ya5tijQPvcn3UCqxeWXLZqq24Iv5vZdpQ9kw5fjlU2N/vdlZVU4EPtp1uvtANtGOWrBzE8bofAeLeKeqIylqjkv3XEyAp/GeW2FZTIlwGik409mKrw4UDjpdwNQvfbhOgXeNHq5eb/QewOg+DJFEIU3EFOQpDi1294xTYEaF6eJnKEcd6cL9J3ENiw9lfb5hCXV2LoVIsnx897co0IKF9RiK01dPyMTGtv0wiF9XuDOScOMu4vx4dtyULqA7RNXUwQiLk976sjtYR4ZjlOMEhxSFNKe/iDqWJ7oxMHM8TfWpLeKhEXmbJ0jOD12NkpVcdNzdoumjuYxzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 SA1PR02MB11619.namprd02.prod.outlook.com (2603:10b6:806:4f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 08:13:57 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 08:13:57 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: netdev@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] mctp i2c: add sysfs control for mux child netdevs
Date: Thu, 15 Oct 2026 16:13:41 +0800
Message-ID: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:990:54::6) To DM8PR02MB8087.namprd02.prod.outlook.com
 (2603:10b6:8:1b::11)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR02MB8087:EE_|SA1PR02MB11619:EE_
X-MS-Office365-Filtering-Correlation-Id: edaad850-8e65-4813-8959-08df2a9442bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|52116014|366016|261009223027099003|6133799003|10067099003|18002099003|11063799006|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	ysu9PDlkla9m/Q/T+y+fSUzLZTi8xPo8d7wlLj7vcTLCi/7+cJmBNy6zahMyfazo0SdR+ZXTl+fONILmN5QXHpfzMK5PZ5Hjj5tWdvmXv1QCvKme8ZLFMhcs3aIpYUyoxiON5QUeLminemkhmWyP1raTmOvJRnn67ObV86L8EcNwxH6ZrUwMCX3OjoEc4kZ/te+qEGPrQ6kUZTmxZpuRJC+iOUkBt05Tfe1KHcIhPmsEQGj8Gd9E1BVc8PpUroJZAdRKBZWPqlNDYEuyuoqwuuKNKVG+NYFDz0sA5sU0zBihOh0o3MCC4vKh/GnOdF3qcfeJgKHCmpQkT+Lv5eERQwxmvv+51szClwWzYNi/dajVOof1642BnU9cPOt8tVzo7VeyCyKggGqVHbW4Nr1XW9jYc8+lXXePwCzkd6c22U6tEvSVxm0Z2JWjWF6wD78+mqu6N6sR8J3KLp3Fh+LO/t95fsqtKxk3bD2mhFIG1M5YzHj9ERldRmGwwpbOFZSG3vxCrYxP3VDUSq+M0IGNRmB7+22gNWtR59gdEh3wcoHUXXP5RJkISNOnQKhqmM6a72irkb/0DbN80AZSSFNSmbTNuyiOq9qXibiXCyILIJBagQiMD0ehPIOiuzSndAnHFtN+qtCaPbs62fTcflB4foKAlvRCjZAyaH4sGg4jNgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(52116014)(366016)(261009223027099003)(6133799003)(10067099003)(18002099003)(11063799006)(5023799004)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VqKQXiqWZg0xiyMLB86AU5aeh6YfTRSZm794jsJGqjlLQAXCIsGmOcpOTLWj?=
 =?us-ascii?Q?P5ZgjNvuO+JmatVJ4aaVfWQbmaWaiDiSze0EiPOUg5tpX0mMcY/qt06QNk0P?=
 =?us-ascii?Q?ynjCgSk//nHuKsSpw84NNKCBNZ6zh3EYU4qSNT/wPNglbdDFRD3aHK6+DCnA?=
 =?us-ascii?Q?MrjWedhg6S8xxr5qgib5GeoTte2bFwWWlXNkPY5W9XhFQQIUaN+0TP+V4dbT?=
 =?us-ascii?Q?ScwCB2K9Skf7irs/Duq5VC+HK7TNpOhTMk55od3JwEPPOasdYezefTuGfNtp?=
 =?us-ascii?Q?eisFC3IHaXODyugKfOFrEiwXJPpVQcsfwDsRa8JpPryiroeYviVbIMPe77s0?=
 =?us-ascii?Q?VI1mpLd4dzUDZDD807Vnu1xbbrB5NIvEAjyaGtG6/aPjO1afJhPG2/fpVyZP?=
 =?us-ascii?Q?WaIhr9lr5EUXKQ8jfvW2zj1ZQxN6vikoDpYC4YlaC0NIDoxvTNLpNm7fUXxP?=
 =?us-ascii?Q?7DSLaoZX1fmR94NDiAK2wlyO71zOPuHtFs/YRRZeyxR99Ht1K17hSnNcwzsv?=
 =?us-ascii?Q?nwzesSE/pD5s7tTnR9obwqGCxuyfsLdWdpEihPhOdiEkeA4ymk2+x3QKhu0S?=
 =?us-ascii?Q?C9SZQujzOQkWjZdWyyK39GvjN/b+U6DiVrLT9u1y7zPnmPvRZhulvSVvWSXd?=
 =?us-ascii?Q?ogysEjveesvNd5drAr0zGfmWuE8ls1Fv0mvpQapp3YbwnR9tEjVPxvyawAi+?=
 =?us-ascii?Q?QqjV73iA7GAZeXQSKlmJ1Q6cTUtTsplKwrgorctr3/l9SAy42PnfTQxwl9XD?=
 =?us-ascii?Q?rkMXXTr1UdT/GLVlmfXwfPo6hGLdtGJMqQy5Zh0RU82qdlIL4Zm+oK4beOJs?=
 =?us-ascii?Q?u2yA4JbJmJPKq/buSMx9ejBRrdHY6I1dhdPemTPmh4VJPZ5ty7appdOP2W7Z?=
 =?us-ascii?Q?xgbzhZPNGJ2VtRK4qEhvNySsvIbiT/J8Rq2Rh+vqt62xbYEO7Z+bM8yVhHdm?=
 =?us-ascii?Q?g4Gaj6jqCXyx+/6TxRGUDC6mAYzy1gqIArCajQGW+gszzO3vdPbwfVGQ5lpg?=
 =?us-ascii?Q?pP5lGrGDG4ZYWBcopWvuNyLQMpB7iMnxMBlf18NpNR81RaJzJJ9xquSDrxZq?=
 =?us-ascii?Q?UrrbvvBUE/W8Phea1g2HMOZDUzpFro4W36CpTTEuYPWSqf/z9VrJhkRHdM1L?=
 =?us-ascii?Q?YlVDLEur/MjMQ/gJ7BNChfH9T84518z9a8nYEgdhLyPeX9v3Prt1lcJVuVUK?=
 =?us-ascii?Q?tj1wFI08OAkFq1yLsQFpvKJZqowFCrV1OgxV8xuJnGSgcfgRnNBQlNZA+5Y6?=
 =?us-ascii?Q?aSL3l51HiJLC3RCXwB8Bd2Pc74ToapLW1MsYLx2xuw+Jpzh4nHC3KvuSZWLL?=
 =?us-ascii?Q?yyryO8A/+dfpGlQd+Dc2nw2zHQPu/8XfYyzrhdcZ6Hh6PfcZsN4lju7zZbia?=
 =?us-ascii?Q?0+LSX+RhWgQyAMYCj+VYG3c8cH5ue9LXTXZ1nkFxXaTQ6nq3l7mIb4J+HSYU?=
 =?us-ascii?Q?VqoUgj6rhmhelkqF961KEY1K2jNBmPe7JpRjfDTN2AhZd281CaifcBpcyJWz?=
 =?us-ascii?Q?zXcEOcyBkcgp2kSD1qpUtTIvwcdfpvxcG3vBrQ8uGe5zJMHmysQUHI9mLWVW?=
 =?us-ascii?Q?3b1VjbQ+tFKHwqY8xQE7krYE4j8l9fITWrEak6tjkp0+VW+spv8l8WEDDg6O?=
 =?us-ascii?Q?3DFRBCbQFBTSx1Xr7P/sqEzZ+2BYOdPPUznIRB/u4vhfmVRdtnyY34Pkttwg?=
 =?us-ascii?Q?avJWlwHtducfEWX8pfYORMVaLya66Ku/lJgW6A3EwV9qNqPt66V99I3Ob4FV?=
 =?us-ascii?Q?ss9pVew8Ng=3D=3D?=
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edaad850-8e65-4813-8959-08df2a9442bb
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:13:57.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsvQ5RgjDDV8SmQ9e9lx7/DBk2n0V/iRjbtukbV8qGy+rTlzalo79HDh7tATGb502FBm5tGv1KTvAAGuHYSMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11619

An MCTP netdev is created for an I2C bus that carries an
"mctp-controller" property in the devicetree. A bus instantiated at
runtime through the I2C sysfs interface has no devicetree node on which
to set that property, so it can never get a netdev.

This matters for a mux topology that is only known at runtime. A BMC
that ships one firmware image across several chassis cannot describe
every chassis's mux tree in its devicetree. Userspace creates the muxes
it finds over i2c sysfs instead, and the channels below them have no
node of their own. It also matters for an adapter that the devicetree
cannot describe at all, such as a USB-attached one.

Add a writable "mctp_controller" attribute on every adapter of a mux
tree whose root has an mctp-i2c-controller device bound to it, the root
adapter included. A mux tree with no such device is untouched. Writing 1
creates the netdev for that bus, writing 0 removes it, and reading
reports whether one exists. Userspace can then enable MCTP per channel
once it has created the muxes, and can control a controller that arrived
through new_device rather than through the devicetree.

The devicetree property keeps working, and both mechanisms may be used
on the same mux tree. The attribute is removed when the client is
unbound, so it does not outlive the module, and a rebind reattaches it
reading 0.

The netdev is placed in the network namespace the mctp-i2c-controller
device was probed in, not the one that writes the attribute, since the
attribute is visible in every namespace. The client holds a reference on
that namespace, and a write requires CAP_NET_ADMIN in it.

Tested on an AST2700 BMC with a nested mux tree: writing 1 to
mctp_controller on a channel that has no "mctp-controller" property
brings up the interface and writing 0 removes it, a write of 0 on the
root bus removes its netdev, and the attribute disappears on an unbind
of the mctp-i2c-controller driver and returns reading 0 on a rebind.

Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
v2:
 - attach the attribute on root adapters too, so a controller that has no
   devicetree node can be controlled at runtime (Matt, Jeremy). This also
   drops the root special-casing and the -EINVAL a write there returned.
 - remove the attribute when the client is unbound, so it does not
   outlive the module (Matt). Removal walks a list of the adapters an
   attribute was added to, rather than the i2c bus, which keeps
   sysfs_remove_group() off i2c_for_each_dev().
 - take a reference on the stored network namespace, with a matching put,
   and require CAP_NET_ADMIN in it for a write. A stored-versus-current
   comparison is not available here, as discussed on v1.
 - move the duplicate-netdev check into mctp_i2c_add_netdev(), so all
   three callers get it and a concurrent store no longer produces an
   -EEXIST from mctp_register_netdev().
 - serialize attribute attachment through that same list, so
   sysfs_update_group() does not run twice at once on one adapter.
 - refuse a write for an adapter that is already being deleted, which
   the list membership answers.
 - do not free midev twice when mctp_register_netdev() fails, since
   register_netdevice() has already run ndo_uninit on every error path it
   takes.
 - drop the one-client-per-mux-tree check, which the existing non-root
   adapter check already covers (Matt).

v1: https://lore.kernel.org/netdev/20261002073156.759005-1-kenny_hsieh@jabil.com/

 .../ABI/testing/sysfs-bus-i2c-devices-mctp    |  26 +
 MAINTAINERS                                   |   1 +
 drivers/net/mctp/mctp-i2c.c                   | 464 ++++++++++++++++--
 3 files changed, 449 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
new file mode 100644
index 0000000000000..a04bc30aa7b51
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
@@ -0,0 +1,26 @@
+What:		/sys/bus/i2c/devices/i2c-<n>/mctp_controller
+Date:		October 2026
+KernelVersion:	7.4
+Contact:	Kenny Hsieh <kenny_hsieh@jabil.com>
+Description:
+		Controls whether an MCTP network device exists for this I2C
+		bus. Writing 1 creates it, writing 0 removes it, and reading
+		returns 1 while it exists. Writing a value that matches the
+		current state is a no-op.
+
+		The attribute appears only on mux child busses whose mux tree
+		root has an mctp-i2c-controller device bound to it. The root
+		bus itself is excluded, because its network device follows
+		that mctp-i2c-controller device rather than this attribute.
+
+		A bus described in the devicetree can carry an
+		"mctp-controller" property instead, which creates the network
+		device when the mctp-i2c-controller device probes. This
+		attribute covers busses instantiated at runtime through the
+		I2C sysfs interface, which have no devicetree node on which to
+		set that property. Both mechanisms may be used on the same mux
+		tree.
+
+		Removal is synchronous and does not drain traffic: queued
+		packets are discarded and in-flight requests fail, so a
+		requester sees a timeout rather than an error.
diff --git a/MAINTAINERS b/MAINTAINERS
index 509b35b5a0e7a..2bfa5d68c6b66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15719,6 +15719,7 @@ M:	Jeremy Kerr <jk@codeconstruct.com.au>
 M:	Matt Johnston <matt@codeconstruct.com.au>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
 F:	Documentation/networking/mctp.rst
 F:	drivers/net/mctp/
 F:	include/linux/usb/mctp-usb.h
diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d338bbf..6c53bfcc50a3b 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -22,6 +22,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
 #include <linux/if_arp.h>
+#include <linux/sysfs.h>
+#include <linux/nsproxy.h>
 #include <net/mctp.h>
 #include <net/mctpdevice.h>
 
@@ -83,17 +85,39 @@ struct mctp_i2c_dev {
 
 };
 
+/* One adapter that carries this client's mctp_controller attribute. The
+ * entry holds a reference on the adapter device, so it never points at a
+ * freed adapter.
+ */
+struct mctp_i2c_attr {
+	struct i2c_adapter *adap;
+	struct list_head list; /* For mctp_i2c_client.attrs */
+};
+
 /* The i2c client structure. One per hardware i2c bus at the top of the
  * mux tree, shared by multiple netdevs
  */
 struct mctp_i2c_client {
 	struct i2c_client *client;
 	u8 lladdr;
+	/* Namespace the controller was probed in. Netdevs are created here
+	 * regardless of which namespace writes the mctp_controller attribute.
+	 */
+	possible_net_t net;
 
 	struct mctp_i2c_dev *sel;
 	struct list_head devs;
 	spinlock_t sel_lock; /* Protects sel and devs */
 
+	/* Adapters this client has added the mctp_controller attribute to,
+	 * so removal never walks the i2c bus. attrs_lock is never held over
+	 * a sysfs group call or i2c_for_each_dev(): a group removal waits on
+	 * a kernfs reference that mctp_controller_store() holds while it
+	 * waits for driver_clients_lock.
+	 */
+	struct list_head attrs;
+	struct mutex attrs_lock; /* Protects attrs */
+
 	struct list_head list; /* For driver_clients */
 };
 
@@ -111,6 +135,11 @@ static int mctp_i2c_slave_cb(struct i2c_client *client,
 			     enum i2c_slave_event event, u8 *val);
 static void mctp_i2c_ndo_uninit(struct net_device *dev);
 static int mctp_i2c_ndo_open(struct net_device *dev);
+/* Defined below the attribute group, which the store handler it serves has
+ * to precede.
+ */
+static bool mctp_i2c_attr_tracked(struct mctp_i2c_client *mcli,
+				  struct i2c_adapter *adap);
 
 static struct i2c_adapter *mux_root_adapter(struct i2c_adapter *adap)
 {
@@ -162,7 +191,13 @@ static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *client)
 	spin_lock_init(&mcli->sel_lock);
 	INIT_LIST_HEAD(&mcli->devs);
 	INIT_LIST_HEAD(&mcli->list);
+	INIT_LIST_HEAD(&mcli->attrs);
+	mutex_init(&mcli->attrs_lock);
 	mcli->lladdr = client->addr & 0xff;
+	/* The reference keeps the namespace alive for this client's lifetime,
+	 * and is dropped in mctp_i2c_free_client().
+	 */
+	write_pnet(&mcli->net, get_net(current->nsproxy->net_ns));
 	mcli->client = client;
 	i2c_set_clientdata(client, mcli);
 
@@ -189,14 +224,17 @@ static void mctp_i2c_free_client(struct mctp_i2c_client *mcli)
 
 	WARN_ON(!mutex_is_locked(&driver_clients_lock));
 	WARN_ON(!list_empty(&mcli->devs));
+	WARN_ON(!list_empty(&mcli->attrs));
 	WARN_ON(mcli->sel); /* sanity check, no locking */
 
 	rc = i2c_slave_unregister(mcli->client);
 	/* Leak if it fails, we can't propagate errors upwards */
-	if (rc < 0)
+	if (rc < 0) {
 		dev_err(&mcli->client->dev, "i2c unregister failed %d\n", rc);
-	else
+	} else {
+		put_net(read_pnet(&mcli->net));
 		kfree(mcli);
+	}
 }
 
 /* Switch the mctp i2c device to receive responses.
@@ -857,6 +895,25 @@ static int mctp_i2c_ndo_open(struct net_device *dev)
 	return 0;
 }
 
+/* Returns the netdev for adap, or NULL if there is none */
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
@@ -876,6 +933,15 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 	}
 
 	WARN_ON(!mutex_is_locked(&driver_clients_lock));
+
+	/* An existing netdev for @adap is success: all three callers can race
+	 * each other on one adapter, and only this check keeps the losers out
+	 * of mctp_register_netdev(), which would fail with -EEXIST and log an
+	 * error for a bus that already works.
+	 */
+	if (mctp_i2c_find_dev(mcli, adap))
+		return 0;
+
 	snprintf(namebuf, sizeof(namebuf), "mctpi2c%d", adap->nr);
 	ndev = alloc_netdev(sizeof(*midev), namebuf, NET_NAME_ENUM, mctp_i2c_net_setup);
 	if (!ndev) {
@@ -883,7 +949,12 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 		rc = -ENOMEM;
 		goto err;
 	}
-	dev_net_set(ndev, current->nsproxy->net_ns);
+	/* Tie the netdev to the namespace the mctp-i2c-controller device was
+	 * probed in, not to whoever happens to write mctp_controller. A write
+	 * from another namespace must not place the netdev there, since the
+	 * attribute is visible in all of them.
+	 */
+	dev_net_set(ndev, read_pnet(&mcli->net));
 	SET_NETDEV_DEV(ndev, &adap->dev);
 	dev_addr_set(ndev, &mcli->lladdr);
 
@@ -900,6 +971,12 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 		dev_err(&mcli->client->dev,
 			"register netdev \"%s\" failed %d\n",
 			ndev->name, rc);
+		/* register_netdevice() has already run ndo_uninit, which
+		 * frees midev. Every error path it takes reaches err_uninit
+		 * except err_free_name, and that one needs an ndo_init this
+		 * driver does not provide.
+		 */
+		midev = NULL;
 		goto err;
 	}
 
@@ -920,18 +997,10 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
 static void mctp_i2c_remove_netdev(struct mctp_i2c_client *mcli,
 				   struct i2c_adapter *adap)
 {
-	struct mctp_i2c_dev *midev = NULL, *m = NULL;
-	unsigned long flags;
+	struct mctp_i2c_dev *midev = NULL;
 
 	WARN_ON(!mutex_is_locked(&driver_clients_lock));
-	spin_lock_irqsave(&mcli->sel_lock, flags);
-	/* List size is limited by number of MCTP netdevs on a single hardware bus */
-	list_for_each_entry(m, &mcli->devs, list)
-		if (m->adapter == adap) {
-			midev = m;
-			break;
-		}
-	spin_unlock_irqrestore(&mcli->sel_lock, flags);
+	midev = mctp_i2c_find_dev(mcli, adap);
 
 	if (midev)
 		mctp_i2c_unregister(midev);
@@ -968,6 +1037,287 @@ static bool mctp_i2c_adapter_match(struct i2c_adapter *adap, bool match_no_of)
 	return of_property_read_bool(adap->dev.of_node, MCTP_I2C_OF_PROP);
 }
 
+/* Returns the client owning @root's mux tree, or NULL.
+ * Call with driver_clients_lock held. The returned pointer is only valid
+ * while that lock is held.
+ */
+static struct mctp_i2c_client *mctp_i2c_find_client(struct i2c_adapter *root)
+{
+	struct mctp_i2c_client *mcli = NULL;
+
+	WARN_ON(!mutex_is_locked(&driver_clients_lock));
+	list_for_each_entry(mcli, &driver_clients, list)
+		if (mcli->client->adapter == root)
+			return mcli;
+
+	return NULL;
+}
+
+/* A bus instantiated at runtime has no devicetree node on which to set the
+ * "mctp-controller" property, so this attribute is how userspace asks for its
+ * netdev once the adapter exists.
+ */
+static ssize_t mctp_controller_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct i2c_adapter *root = NULL, *adap = NULL;
+	struct mctp_i2c_client *mcli;
+	bool present = false;
+
+	adap = mctp_i2c_get_adapter(dev, &root);
+	if (!adap)
+		return -ENODEV;
+
+	mutex_lock(&driver_clients_lock);
+	mcli = mctp_i2c_find_client(root);
+	if (mcli)
+		present = mctp_i2c_find_dev(mcli, adap);
+	mutex_unlock(&driver_clients_lock);
+
+	return sysfs_emit(buf, "%d\n", present);
+}
+
+static ssize_t mctp_controller_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct i2c_adapter *root = NULL, *adap = NULL;
+	struct mctp_i2c_client *mcli;
+	bool enable;
+	int rc;
+
+	rc = kstrtobool(buf, &enable);
+	if (rc < 0)
+		return rc;
+
+	adap = mctp_i2c_get_adapter(dev, &root);
+	if (!adap)
+		return -ENODEV;
+
+	mutex_lock(&driver_clients_lock);
+	mcli = mctp_i2c_find_client(root);
+	if (!mcli) {
+		/* No mctp-i2c-controller on this mux tree's root */
+		rc = -ENODEV;
+		goto out;
+	}
+
+	/* A netdev store handler checks CAP_NET_ADMIN in the user namespace of
+	 * the netns owning the device, as netdev_store() does. The netns here
+	 * belongs to the client rather than to a netdev, so the check waits
+	 * until the lookup has found the client to read it from.
+	 */
+	if (!ns_capable(read_pnet(&mcli->net)->user_ns, CAP_NET_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (enable) {
+		/* device_del() sends BUS_NOTIFY_DEL_DEVICE well before
+		 * kobject_del() makes this attribute unreachable, so a write
+		 * can arrive after the adapter stopped being tracked. No
+		 * second notification would ever remove a netdev created here,
+		 * so refuse the write instead.
+		 */
+		if (!mctp_i2c_attr_tracked(mcli, adap)) {
+			rc = -ENODEV;
+			goto out;
+		}
+
+		rc = mctp_i2c_add_netdev(mcli, adap);
+	} else {
+		mctp_i2c_remove_netdev(mcli, adap);
+		rc = 0;
+	}
+out:
+	mutex_unlock(&driver_clients_lock);
+
+	return rc < 0 ? rc : count;
+}
+
+static DEVICE_ATTR_RW(mctp_controller);
+
+static struct attribute *mctp_i2c_adapter_attrs[] = {
+	&dev_attr_mctp_controller.attr,
+	NULL,
+};
+
+static const struct attribute_group mctp_i2c_adapter_group = {
+	.attrs = mctp_i2c_adapter_attrs,
+};
+
+/* Returns the tracking entry for @adap, or NULL.
+ * Call with mcli->attrs_lock held.
+ */
+static struct mctp_i2c_attr *__mctp_i2c_find_attr(struct mctp_i2c_client *mcli,
+						  struct i2c_adapter *adap)
+{
+	struct mctp_i2c_attr *attr = NULL;
+
+	lockdep_assert_held(&mcli->attrs_lock);
+	/* List size is limited by the number of adapters on one mux tree */
+	list_for_each_entry(attr, &mcli->attrs, list)
+		if (attr->adap == adap)
+			return attr;
+
+	return NULL;
+}
+
+/* Stops tracking @adap and frees its entry, without touching sysfs.
+ * Returns whether an entry was found, so the caller knows whether the
+ * attribute is still on the adapter.
+ */
+static bool mctp_i2c_drop_attr(struct mctp_i2c_client *mcli,
+			       struct i2c_adapter *adap)
+{
+	struct mctp_i2c_attr *attr;
+
+	mutex_lock(&mcli->attrs_lock);
+	attr = __mctp_i2c_find_attr(mcli, adap);
+	if (attr)
+		list_del(&attr->list);
+	mutex_unlock(&mcli->attrs_lock);
+
+	if (!attr)
+		return false;
+
+	put_device(&attr->adap->dev);
+	kfree(attr);
+	return true;
+}
+
+/* Reports whether the client owning @adap's mux tree still tracks the
+ * mctp_controller attribute for @adap. An adapter is untracked before its
+ * attribute goes away, so a write that finds no entry is a write to an
+ * adapter that is already being deleted, which mctp_controller_store() has
+ * to refuse rather than act on.
+ */
+static bool mctp_i2c_attr_tracked(struct mctp_i2c_client *mcli,
+				  struct i2c_adapter *adap)
+{
+	bool tracked;
+
+	mutex_lock(&mcli->attrs_lock);
+	tracked = __mctp_i2c_find_attr(mcli, adap);
+	mutex_unlock(&mcli->attrs_lock);
+
+	return tracked;
+}
+
+/* Adds the attribute to one adapter of @root's mux tree, the root included,
+ * and records it on the owning client. The entry goes in first, and only the
+ * caller that inserted it goes on to sysfs, so sysfs_update_group() never
+ * runs twice at once on one adapter. The group is never removed on its own.
+ */
+static void mctp_i2c_add_sysfs(struct i2c_adapter *adap,
+			       struct i2c_adapter *root)
+{
+	struct mctp_i2c_client *mcli;
+	struct mctp_i2c_attr *attr;
+	bool attach = false;
+	int rc;
+
+	attr = kzalloc_obj(*attr);
+	if (!attr) {
+		/* The attribute is an optional control rather than a
+		 * requirement, so skip the attach instead of failing.
+		 */
+		dev_warn(&adap->dev,
+			 "Failed tracking mctp_controller attribute\n");
+		return;
+	}
+	/* The entry must never point at a freed adapter */
+	get_device(&adap->dev);
+	attr->adap = adap;
+	INIT_LIST_HEAD(&attr->list);
+
+	mutex_lock(&driver_clients_lock);
+	mcli = mctp_i2c_find_client(root);
+	if (mcli) {
+		mutex_lock(&mcli->attrs_lock);
+		if (!__mctp_i2c_find_attr(mcli, adap)) {
+			list_add(&attr->list, &mcli->attrs);
+			attach = true;
+		}
+		mutex_unlock(&mcli->attrs_lock);
+	}
+	mutex_unlock(&driver_clients_lock);
+
+	if (!attach) {
+		/* Another attach path won, or there is no client to track it */
+		put_device(&adap->dev);
+		kfree(attr);
+		return;
+	}
+
+	/* Outside both locks: updating the group waits for a kernfs drain, and
+	 * a concurrent mctp_controller_store() holds that reference while it
+	 * waits for driver_clients_lock.
+	 */
+	rc = sysfs_update_group(&adap->dev.kobj, &mctp_i2c_adapter_group);
+	if (rc < 0) {
+		dev_warn(&adap->dev,
+			 "Failed adding mctp_controller attribute, %d\n", rc);
+		/* The list must not claim an attribute that is not there. The
+		 * entry is looked up again rather than reused, because the
+		 * client can go away while the group updates.
+		 */
+		mutex_lock(&driver_clients_lock);
+		mcli = mctp_i2c_find_client(root);
+		if (mcli)
+			mctp_i2c_drop_attr(mcli, adap);
+		mutex_unlock(&driver_clients_lock);
+	}
+}
+
+/* Removes the attribute from one adapter of @root's mux tree.
+ * Call with driver_clients_lock not held, for the reason struct
+ * mctp_i2c_client gives.
+ */
+static void mctp_i2c_remove_sysfs(struct i2c_adapter *adap,
+				  struct i2c_adapter *root)
+{
+	struct mctp_i2c_client *mcli;
+	bool tracked = false;
+
+	/* Hold @adap over the sysfs call, after the entry's reference goes */
+	get_device(&adap->dev);
+
+	mutex_lock(&driver_clients_lock);
+	mcli = mctp_i2c_find_client(root);
+	if (mcli)
+		tracked = mctp_i2c_drop_attr(mcli, adap);
+	mutex_unlock(&driver_clients_lock);
+
+	if (tracked)
+		sysfs_remove_group(&adap->dev.kobj, &mctp_i2c_adapter_group);
+
+	put_device(&adap->dev);
+}
+
+/* Removes every attribute @mcli added, as the client goes away. The list is
+ * detached first so sysfs_remove_group() runs with no lock held.
+ */
+static void mctp_i2c_remove_sysfs_all(struct mctp_i2c_client *mcli)
+{
+	struct mctp_i2c_attr *attr = NULL, *tmp = NULL;
+	LIST_HEAD(attrs);
+
+	lockdep_assert_not_held(&driver_clients_lock);
+
+	mutex_lock(&mcli->attrs_lock);
+	list_splice_init(&mcli->attrs, &attrs);
+	mutex_unlock(&mcli->attrs_lock);
+
+	list_for_each_entry_safe(attr, tmp, &attrs, list) {
+		sysfs_remove_group(&attr->adap->dev.kobj,
+				   &mctp_i2c_adapter_group);
+		list_del(&attr->list);
+		put_device(&attr->adap->dev);
+		kfree(attr);
+	}
+}
+
 /* Called for each existing i2c device (adapter or client) when a
  * new mctp-i2c client is probed.
  */
@@ -981,37 +1331,62 @@ static int mctp_i2c_client_try_attach(struct device *dev, void *data)
 		return 0;
 	if (mcli->client->adapter != root)
 		return 0;
+
+	/* Unmarked busses get the attribute too, so userspace can enable them */
+	mctp_i2c_add_sysfs(adap, root);
+
 	/* Must either have mctp-controller property on the adapter, or
 	 * be a root adapter if it's non-devicetree
 	 */
 	if (!mctp_i2c_adapter_match(adap, adap == root))
 		return 0;
 
-	return mctp_i2c_add_netdev(mcli, adap);
+	/* @mcli cannot be unbound here: the driver core holds the device lock
+	 * across probe, and an unbind needs that same lock.
+	 */
+	mutex_lock(&driver_clients_lock);
+	mctp_i2c_add_netdev(mcli, adap);
+	mutex_unlock(&driver_clients_lock);
+
+	return 0;
 }
 
 static void mctp_i2c_notify_add(struct device *dev)
 {
-	struct mctp_i2c_client *mcli = NULL, *m = NULL;
+	struct mctp_i2c_client *mcli = NULL;
 	struct i2c_adapter *root = NULL, *adap = NULL;
+	bool have_client;
+	bool match;
 	int rc;
 
 	adap = mctp_i2c_get_adapter(dev, &root);
 	if (!adap)
 		return;
+
 	/* Check for mctp-controller property on the adapter */
-	if (!mctp_i2c_adapter_match(adap, false))
-		return;
+	match = mctp_i2c_adapter_match(adap, false);
 
-	/* Find an existing mcli for adap's root */
 	mutex_lock(&driver_clients_lock);
-	list_for_each_entry(m, &driver_clients, list) {
-		if (m->client->adapter == root) {
-			mcli = m;
-			break;
-		}
-	}
+	have_client = mctp_i2c_find_client(root);
+	mutex_unlock(&driver_clients_lock);
 
+	if (!have_client)
+		return;
+
+	/* Outside the lock: updating the group waits for a kernfs drain, and a
+	 * concurrent mctp_controller_store() holds that reference while it
+	 * waits for driver_clients_lock.
+	 */
+	mctp_i2c_add_sysfs(adap, root);
+
+	if (!match)
+		return;
+
+	mutex_lock(&driver_clients_lock);
+	/* The pointer from the first lookup does not outlive the dropped
+	 * lock, so look the client up again.
+	 */
+	mcli = mctp_i2c_find_client(root);
 	if (mcli) {
 		rc = mctp_i2c_add_netdev(mcli, adap);
 		if (rc < 0)
@@ -1030,36 +1405,35 @@ static void mctp_i2c_notify_del(struct device *dev)
 		return;
 
 	mutex_lock(&driver_clients_lock);
-	list_for_each_entry(mcli, &driver_clients, list) {
-		if (mcli->client->adapter == root) {
-			mctp_i2c_remove_netdev(mcli, adap);
-			break;
-		}
-	}
+	mcli = mctp_i2c_find_client(root);
+	if (mcli)
+		mctp_i2c_remove_netdev(mcli, adap);
 	mutex_unlock(&driver_clients_lock);
+
+	/* Outside the lock, for the reason mctp_i2c_remove_sysfs() gives */
+	mctp_i2c_remove_sysfs(adap, root);
 }
 
 static int mctp_i2c_probe(struct i2c_client *client)
 {
-	struct mctp_i2c_client *mcli = NULL;
-	int rc;
+	struct mctp_i2c_client *mcli;
 
 	mutex_lock(&driver_clients_lock);
 	mcli = mctp_i2c_new_client(client);
 	if (IS_ERR(mcli)) {
-		rc = PTR_ERR(mcli);
-		mcli = NULL;
-		goto out;
-	} else {
-		list_add(&mcli->list, &driver_clients);
+		mutex_unlock(&driver_clients_lock);
+		return PTR_ERR(mcli);
 	}
+	list_add(&mcli->list, &driver_clients);
+	mutex_unlock(&driver_clients_lock);
 
-	/* Add a netdev for adapters that have a 'mctp-controller' property */
+	/* Add a netdev for adapters that have a 'mctp-controller' property.
+	 * Runs with the lock dropped, for the reason mctp_i2c_notify_add()
+	 * gives.
+	 */
 	i2c_for_each_dev(mcli, mctp_i2c_client_try_attach);
-	rc = 0;
-out:
-	mutex_unlock(&driver_clients_lock);
-	return rc;
+
+	return 0;
 }
 
 static void mctp_i2c_remove(struct i2c_client *client)
@@ -1067,6 +1441,12 @@ static void mctp_i2c_remove(struct i2c_client *client)
 	struct mctp_i2c_client *mcli = i2c_get_clientdata(client);
 	struct mctp_i2c_dev *midev = NULL, *tmp = NULL;
 
+	/* Before the lock: sysfs_remove_group() waits for a kernfs active
+	 * reference that mctp_controller_store() holds while it waits for
+	 * driver_clients_lock.
+	 */
+	mctp_i2c_remove_sysfs_all(mcli);
+
 	mutex_lock(&driver_clients_lock);
 	list_del(&mcli->list);
 	/* Remove all child adapter netdevs */
-- 
2.50.1

