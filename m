Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF124399FB;
	Fri,  2 Oct 2026 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926354; cv=fail; b=sTxAdsII+X2WINbzjYF9OU+5mBVnRNZ2oGBtXJ4VRte7osVlHvvfeyJVbkEL17bM8vMAA/tuY1hiDUTgmV3iKtPAT0mAz9eFSzFUtLe62Q2e6+7tAv19a+DQKi3XT0aZRdURUOhJrJo8XxkLmkMDYsFp06Zh4ml0Q6aWAB81A40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926354; c=relaxed/simple;
	bh=+oIc5isyElKYTcujJ0LE4NZALIdAV9AC6ZHJQB+y5qE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LmxNuiRGt7G2bcy8+0qKaRzNYvm8/v2JUPLjWotBrxBOKIULbhDgoIbpj12I8UEDz4QPGIfFArAHIjxyy64f0OMn+NeyB8uyjb1t0724pkUdVZoYblj+zAzBEjW6NkGrWnn2SXhdo9fFiZUfx/gLWP6VfCDnwTim99AsziIqMhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com; spf=pass smtp.mailfrom=jabil.com; dkim=pass (2048-bit key) header.d=jabil.com header.i=@jabil.com header.b=lGboLl5u; arc=fail smtp.client-ip=52.101.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jabil.com header.i=@jabil.com header.b="lGboLl5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxmX3LjM7gBRne+HoWV+FMtSaywomBzmDLkNuAdL3ovGumT/q652LoPzQTC/aqtg3S+VCdxmI6ejRXJCv+RKLjsA4uSUf16a8MiwS5WXzkU/5FroYlpK1Ft3u16BcUMLsTWvshWo1VZ9g8J8xzN/CsUaaJMska8bMyqpV9VuIp9ayrsHsjy3Qj8MZFq0F/DK6D2Wsp0kgPBJI+7KekUNPga8/S0WLGlXDe0jego754zPeIUFjM2VWHUlw6g4JmaTlR6AoU6JxDzXAjOmTKWYqOCje9XB0B26G2L4BjcGcyZeZ8l3mmu8gT2Gx1nfWlgbL9QSPJKXJQlAW1uQL8sDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It8nSiJiNG+lr9sj+3tG+R4gyEzoLdcA5bDdsjCLFoc=;
 b=N3C1YiZHlfSH8q8YvdHTN8ESfhEs8XAHWLNB/n3UAxH/8o4J5/sYz9Tyrq+cOiIpMK3AHc30Y87r6nGqIZUq1QsyCmSHXkQ510cVpfG58m5UTmXJ8SmhZsWy3BC4bZnL1fTqrxUdatWghnh3wj7sF6boA+h9P2TDmwI30qidIfbp1pzBJi8d6VojCyLPiAuT3PUNFvMwIEuQstYbV52MvmTCWhWzxcqnaPDydP2xx1ItxgiAAD9hhmmH/hmwXYZ+mXvpbUHJyzESG8QWsz29i8NVNpkuih+kgweY7oYJ8OAS3dF8a+L90cP+9xPiw4yDZULK25r5AMmUYLV0CO94aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It8nSiJiNG+lr9sj+3tG+R4gyEzoLdcA5bDdsjCLFoc=;
 b=lGboLl5uRrwMiDzfPsUP76D8nkqcu9XVO/RbIk73PdLNiguCxac5RSt/X/nIiBHFw/mK/wtDvySQOVcz0KmSCbfmRth5ki9no5miPSjcZmtDGxgU6Yr4kXoDL8wnF1HNaBD03OBeBbAxgHEYxeC4r8xPiylk4eRTTGlveso8vpjAU3wFlSvg+MQ16nI5m8wcHUR2O/+KAg6HrmRJEj7RZsB+rqXRHFaQ0dHnnXgC75Dva84m2jm1PMtTPGa6WlnQ4iPUYjw2sOOj+7uPV+J+eGPuB8o5+Kb9uywKGF+mQC3gBqwygJclF2g+KmGUtB5bzIRAAuiPjmuWSMyaMVcp0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 DSSPR02MB11346.namprd02.prod.outlook.com (2603:10b6:8:375::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Fri, 2 Oct 2026 07:32:14 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 07:32:14 +0000
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
Subject: [PATCH net-next] mctp i2c: add sysfs control for mux child netdevs
Date: Fri,  2 Oct 2026 15:31:56 +0800
Message-ID: <20261002073156.759005-1-kenny_hsieh@jabil.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To DM8PR02MB8087.namprd02.prod.outlook.com
 (2603:10b6:8:1b::11)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR02MB8087:EE_|DSSPR02MB11346:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac062b1-73af-411e-92fa-08df20574757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|23010399003|1800799024|11063799006|5023799004|6133799003|56012099006|10067099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	nz0H+xWl8s0PeOgc6jDDiD9gQOf6Ie5GgyDqrpvu451m1nhQDHp0UGeopg5eGLk2HpFEch52ZY0q2gOvnauFXjvVnW3cGYGUNwQFcwDtyt133QCmGBY3byj7eUJqhPs6OjnYGzioZeThuC3u5LfAgNLWhu8MBl43HZ2y4OeIv9T2MR2zBtx60veVDBpNa/MIh0jdtXR48cMTI/FjYUUIxprbwnbbLSYflKwJ1tvGyBfDIzQFNBT1LgGUK67hGD8g+P5GgOsy63H0wthrbyQ0XDPJjbeeT5J62hVUPvonyVUNUEzC8dBHUXEoFLcV6oGRyvGniqIoXcF7dW+c7v4DPl8MKBUGEs+hekDNoAmx5X/m6dWYjMC99A98f6odtgzf3orRgq1ogfW2ym7mf/xAxfGoH7Lvy0ig1kFiYX3oofaheHruorauRpMn/6FurIqy8U9oPokN5agS2RsnewDKrbt5z9UVl3+hLy8wnaafxMlKA5qaSpgCWII7B9HQmH/RxH2rDrfPmJazE1IPvoVb3OSsaef/nO25EMNnZNycRTS2SCjC+Rr8uSyy2Hd2zEpd9gR1lQ88UUG8aU7Lxbr45b/xXFPsrtIn7pwsbxHYMN3/ggm11RIN3LRxaLZGpeF7gs8pPQ16Eo/2c0u2SdySHOMIbBKYFMdreOTukYv8zRg4cwieo33uVGbtRttn9HhkORktfUUZEGtxGwLYHaWraOPOVooo/7YldnF84qTr/4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(23010399003)(1800799024)(11063799006)(5023799004)(6133799003)(56012099006)(10067099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOGJhJfjtmV9WYGJb7TkHhVfUKK0e74+0ZQqPJWStmIEauoI+RyW12wx41ZV?=
 =?us-ascii?Q?hLivJ1Y++FBkQm4sOxV9WO7hdtA/dquFltiswtTsbc4ATP+5T8DgErQeRrFD?=
 =?us-ascii?Q?1iTnw0ebqRotBKGI7108VNyIVK4I+kaHYytecWJYIvUqEUeclHw+9YZdx7Hv?=
 =?us-ascii?Q?lVWEbhuIYYIUE/dvNT8G4MD8OGIge9jQs3FVa37/qWvvoqp1uv7ZOZy24+hj?=
 =?us-ascii?Q?iEbQrPJIbGTpzfoSoa/wy/YkrvZ+OeIulx8Xt7aFEIabk6ZvC/2SS4RTtwwh?=
 =?us-ascii?Q?fMEG5FJMDBtJ64FDX+omXK/NK8+Abz4jpejAQ7AaofWZ0S1l5kzeN8AGzQmd?=
 =?us-ascii?Q?bz6yUCaIuz9/1EvuVJQnqqiq1jYW93lylxG1k9Xo9ZLr4Ow70GrPssj3jRoX?=
 =?us-ascii?Q?idU2UHhas0DkzlziY4XY7DxFeavZCXDHcqMAqNMatmmO8UpXA1GSCeluUepz?=
 =?us-ascii?Q?MnmSFgzTFs/35S4yPA1kL/WNSRSYzCHhqZ4M8sVKHl2V4JiJImqKJEP1/yhm?=
 =?us-ascii?Q?BKyoD+PEgaMmT/UsVMHtZ3KuzzFxpOefXadOKkfwsasOlRDZ9m3Xvd+/rL/1?=
 =?us-ascii?Q?rMKzldR24qCPGm0wvdGgM4KDLBE2xH+Xqy0duKit3E+ZYND6ApOFPwwDKVyl?=
 =?us-ascii?Q?RidN1pHcBAkMysDVsc1+spI2RkGhS1O3so6vg4tcKmgPHEcE1dY9+zbZbL6p?=
 =?us-ascii?Q?xh3ixJU0zbgMvcUbx2Z7ns/5JqdVK+8Ja1iz5w2c55hhVZ+bHdCUhES/TeJJ?=
 =?us-ascii?Q?eIuxgHVnxmILqAxOokMQLWpwMrj3QV/qwbOzJC81hwubpifOipR/JYTnQchC?=
 =?us-ascii?Q?+MDMisi+5w5J9x6EZdwb5mJ/irfplkeojyYvFZUhgH8gZOqhqG8OI5ogWDEu?=
 =?us-ascii?Q?FNOApIyyMabQUITspNbfzePh7cCKmMh2Wk2jCIuxRyVMo4jSeNe2qEOZaIA+?=
 =?us-ascii?Q?OCvu/DFJjZi9D5Myw/y/883ZMhmJwftfDQS37ErcXXJJobRTLfqDrgbxfnQ2?=
 =?us-ascii?Q?e+sg2DjByMYx0hDZdMXXGdxlucR62+JNI9VLdEP2xLyCiqWz1g4DIHdJMkIN?=
 =?us-ascii?Q?zXs39eyoMkcI7A4fuAnJvyRqYl34qaqb8/u4U9KCw1GpQW8ifAxxe4FKXENW?=
 =?us-ascii?Q?8GYkJrF7K4t6nCfBpWbVXV7lW4wFtyaNPyxxu0yEw50rEa/MqD0u6qS4cEpr?=
 =?us-ascii?Q?jDdbL853L462/ICDJxPtcy3HBb9lMvMwnCVg1lVWHQF0MEJy0hyd78m/spLq?=
 =?us-ascii?Q?mUa/AKSk8apcbkKXk9xwcfRuij8apbY0Qfm2N5G8m/sVaqJT3GsNjhdsk9On?=
 =?us-ascii?Q?/t0uibvviw1PCABBMJjoA+VEzflhsYNmM5nqdZqCoCq/BMS7AHPnNqlX8rrE?=
 =?us-ascii?Q?6iXWaz1qgSqjcobEJKxq81Ay11dTkHPSUrlPIeJernEp5Nic9iXpZTN5POi7?=
 =?us-ascii?Q?ASxdZJwJpB7L0JY15Sl+PcOPHt7D+YKKz6i2+z0oyZNiID7lDHDAYoa3bXlE?=
 =?us-ascii?Q?2hwsEpWbqdwSt9hv+qUWFKUvrUQZwDWVAkNs8VXhsMCvSM1u8J1ZKfa21VGM?=
 =?us-ascii?Q?TdPscreOThtYNQDYo+oygA5zh/82G4xQkwfoqtoj30sBoAS5a+zaCjApVt2w?=
 =?us-ascii?Q?dfE8cmDc4Zi9J0rd1uWJxleNzHsWYVxcGWeRJpN9gaAS4kIcSN04R+62mbUF?=
 =?us-ascii?Q?wzfB1UymYoSWGLZyJkQV1ThwI1BTSmpulORB08QnCLiQelWHbQOyJnXE7Dap?=
 =?us-ascii?Q?/I7Evoqv+w=3D=3D?=
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac062b1-73af-411e-92fa-08df20574757
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:32:14.4308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U28IFiGSml7d4++2JWWFlogLl+3yXS1g+M6alQ9VzIzgCw84jh2f7JTX1eirL4sM0efktLxQ4fJ+wNBKATRumA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR02MB11346

An MCTP netdev is created for an I2C bus that carries an
"mctp-controller" property in the devicetree. A bus instantiated at
runtime through the I2C sysfs interface has no devicetree node on which
to set that property, so it can never get a netdev.

This matters for a mux topology that is only known at runtime. A BMC
that ships one firmware image across several chassis cannot describe
every chassis's mux tree in its devicetree. Userspace creates the muxes
it finds over i2c sysfs instead, and the channels below them have no
node of their own.

Add a writable "mctp_controller" attribute on mux child adapters below
a bus that has an mctp-i2c-controller device bound to it. A mux tree
with no such device is untouched. Writing 1 creates the netdev for that
bus, writing 0 removes it, and reading reports whether one exists.
Userspace can then enable MCTP per channel once it has created the
muxes.

The root adapter is excluded: its netdev follows the bound
mctp-i2c-controller device rather than this attribute, so a write there
returns -EINVAL. The devicetree property keeps working, and both
mechanisms may be used on the same mux tree.

The netdev is placed in the network namespace the mctp-i2c-controller
device was probed in, not the one that writes the attribute, since the
attribute is visible in every namespace.

Only one mctp-i2c-controller client is allowed per mux tree. A second
one would add the same attribute to every child adapter again, and
either client's removal would delete the attribute the other still
needs.

Tested on an AST2700 BMC with a nested mux tree by writing 1 to
mctp_controller on a channel that has no "mctp-controller" property,
which brings up the interface, then writing 0, which removes it. The
attribute also survives an unbind and rebind of the
mctp-i2c-controller driver.

Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
 .../ABI/testing/sysfs-bus-i2c-devices-mctp    |  26 ++
 MAINTAINERS                                   |   1 +
 drivers/net/mctp/mctp-i2c.c                   | 256 +++++++++++++++---
 3 files changed, 242 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp

diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp b/Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
new file mode 100644
index 000000000000..a04bc30aa7b5
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
index 3011f995437f..1ba32f61a21a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15718,6 +15718,7 @@ M:	Jeremy Kerr <jk@codeconstruct.com.au>
 M:	Matt Johnston <matt@codeconstruct.com.au>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-i2c-devices-mctp
 F:	Documentation/networking/mctp.rst
 F:	drivers/net/mctp/
 F:	include/linux/usb/mctp-usb.h
diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d338bb..d4da32656744 100644
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
 
@@ -89,6 +91,10 @@ struct mctp_i2c_dev {
 struct mctp_i2c_client {
 	struct i2c_client *client;
 	u8 lladdr;
+	/* Namespace the controller was probed in. Netdevs are created here
+	 * regardless of which namespace writes the mctp_controller attribute.
+	 */
+	possible_net_t net;
 
 	struct mctp_i2c_dev *sel;
 	struct list_head devs;
@@ -128,7 +134,7 @@ static struct i2c_adapter *mux_root_adapter(struct i2c_adapter *adap)
  */
 static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *client)
 {
-	struct mctp_i2c_client *mcli = NULL;
+	struct mctp_i2c_client *mcli = NULL, *m = NULL;
 	struct i2c_adapter *root = NULL;
 	int rc;
 
@@ -154,6 +160,21 @@ static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *client)
 		goto err;
 	}
 
+	/* One client per mux tree. A second one would add the same
+	 * mctp_controller attribute to every child adapter again, and either
+	 * client's removal would delete the attribute the other still needs.
+	 */
+	WARN_ON(!mutex_is_locked(&driver_clients_lock));
+	list_for_each_entry(m, &driver_clients, list) {
+		if (m->client->adapter == root) {
+			dev_err(&client->dev,
+				"An mctp-i2c-controller client is already attached to adapter %s\n",
+				root->name);
+			rc = -EBUSY;
+			goto err;
+		}
+	}
+
 	mcli = kzalloc_obj(*mcli);
 	if (!mcli) {
 		rc = -ENOMEM;
@@ -163,6 +184,7 @@ static struct mctp_i2c_client *mctp_i2c_new_client(struct i2c_client *client)
 	INIT_LIST_HEAD(&mcli->devs);
 	INIT_LIST_HEAD(&mcli->list);
 	mcli->lladdr = client->addr & 0xff;
+	write_pnet(&mcli->net, current->nsproxy->net_ns);
 	mcli->client = client;
 	i2c_set_clientdata(client, mcli);
 
@@ -857,6 +879,25 @@ static int mctp_i2c_ndo_open(struct net_device *dev)
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
@@ -883,7 +924,12 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
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
 
@@ -920,18 +966,10 @@ static int mctp_i2c_add_netdev(struct mctp_i2c_client *mcli,
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
@@ -968,6 +1006,121 @@ static bool mctp_i2c_adapter_match(struct i2c_adapter *adap, bool match_no_of)
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
+	/* The root adapter's netdev follows the mctp-i2c-controller client
+	 * itself, so it is not ours to add or remove here.
+	 */
+	if (adap == root)
+		return -EINVAL;
+
+	mutex_lock(&driver_clients_lock);
+	mcli = mctp_i2c_find_client(root);
+	if (!mcli) {
+		/* No mctp-i2c-controller on this mux tree's root */
+		rc = -ENODEV;
+		goto out;
+	}
+
+	if (enable) {
+		if (mctp_i2c_find_dev(mcli, adap))
+			rc = 0;	/* Already present, nothing to do */
+		else
+			rc = mctp_i2c_add_netdev(mcli, adap);
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
+/* The root adapter is skipped: its netdev follows the bound client. The group
+ * is never removed, since kernfs drops it when the adapter is deleted, and
+ * updating rather than creating lets a rebind accept an existing group.
+ */
+static void mctp_i2c_add_sysfs(struct i2c_adapter *adap,
+			       struct i2c_adapter *root)
+{
+	int rc;
+
+	if (adap == root)
+		return;
+
+	rc = sysfs_update_group(&adap->dev.kobj, &mctp_i2c_adapter_group);
+	if (rc < 0)
+		dev_warn(&adap->dev,
+			 "Failed adding mctp_controller attribute, %d\n", rc);
+}
+
 /* Called for each existing i2c device (adapter or client) when a
  * new mctp-i2c client is probed.
  */
@@ -981,37 +1134,62 @@ static int mctp_i2c_client_try_attach(struct device *dev, void *data)
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
+
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
 
+	mutex_lock(&driver_clients_lock);
+	/* The pointer from the first lookup does not outlive the dropped
+	 * lock, so look the client up again.
+	 */
+	mcli = mctp_i2c_find_client(root);
 	if (mcli) {
 		rc = mctp_i2c_add_netdev(mcli, adap);
 		if (rc < 0)
@@ -1030,36 +1208,32 @@ static void mctp_i2c_notify_del(struct device *dev)
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
-- 
2.50.1

