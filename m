Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB103F23C9;
	Tue, 30 Jun 2026 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816627; cv=fail; b=gTfkS9AUTjTtAQM1I/CXa9nwIB6q8MjPkv4u67/WGLCdg0Ke0zUJ6KB9DYxNh+uSNiBV18it6YZI+DRl+etwtgKYFYiFd6edsIIKJbWuGrAXRKssAwLDdktkQFmDyLB8EcsxCMMrEKkn20PAJVKLSKgHT7dbu1XlZ5xpi8UNGMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816627; c=relaxed/simple;
	bh=wlJwvEuuuc+6MvjthdfGfONf7AZtx3Nx3OsaCyUcRbg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DUYC1tVq/BZgcZzVQCF5Xj1127i+CrEeE/RYZc76FsCjzaL43XheqlyREL83rp5s2v+XscDqwa5qGbSWfGNPk0unXmsvkLcghXn1UVAmzo3UV4MD3Emck3WXSsXsphIGDSxlm3ZQWdm8y81eg+BjQhEfjov9J3dVEIj8/HenwQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ecQ4qj+T; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ecQ4qj+T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLFFmYGgRcDwr3uewDWa+5OHqi9bmO4/daPQDeN9+qdEiKP6Ub8eUvR1cvTaV6t48leLq/3OwLsiRx4Rxc1FnRXab8UbqCzGucsEdRW+IbegPR11WeF52ZRQS9QgS/zNM01fnBYkOBeji4GFJfPajMtAd3G8yQAiEgq5Wgv8Li8fdhO9fuZvDzcx6+EgVK0Pu46NU8eenRse04whzc14XV8870/RCuAlji0e5f+2GF2C4H5+h+7PYxUuniD9XW6KTNQ3zWK5Ss4q2IoWF790lHpUpEyleDzpe4JncoCfpjOj2MDQkToIYinYZRrAXq0sQ5mznXrxq7tvhnQYnyyyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgKkLpqKGg1ZMr7yIQ3JBewFd7cuyQzHz+qliH+JqIE=;
 b=nFchwfqTib7qCwlyMQOPnBeazsPais+kFQc1/rd1XEe+j3nbaQb6p+iYY6nMQgv3NoYTJHCJtuXjI6t/+WhmaPocKdjw4w+io87HD9uzps/dBo8Zz2OTv12MW9om6kpSejI5FgPnD2WonLnyfIz7L1LUorMQmKAS5/GAP9KohgbLk3FrTLIUuB3t2FCEhaaDmZLvw3i3/mydlHoA9sBLnnA8AFIlUqxRQs9eTxhyB/PViDggzWBSG5kpuW0lFstFB9JCHSZuhsnBXoLtREbVOfm/CrgvwG3CS/sLZWz8z7518cQ/BoAr/aNLKcLdsWpMQNFiN0FXOIf8pW7+Cao4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgKkLpqKGg1ZMr7yIQ3JBewFd7cuyQzHz+qliH+JqIE=;
 b=ecQ4qj+T8vDtutzQUkImzvOFxF5sgy1ezaeH3eYB81Co3eC9n3kEugDxUVYYsYs/kbFJrV3dniPT+OrNPRUFLxM2ccnQ/Y0YChR8Nr58eBBKqrGKdSzCJ4eOtx5kFNLFfqwOpHFKuWhF1ZYKTsp6JZ2Q8kjhJUd5ydhHE4NhBZQDm/AeaOLfPZ+bk+DaiX+9Yk3BzHyMlCeFvfhxJfatzhfQU90MTYmmkZy5pMsEzvsprzZuN1hO0ouDJnPMZM565/7Egz/KGf9RPvHeTyZdbRE5wXf1cca7OjCzALPjCHvkI2S98et/+Yy+MwN9T0zIoGXWSGduK6M+x2FQwRM+og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 10:50:17 +0000
Received: from DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c]) by DU0PR04MB9466.eurprd04.prod.outlook.com
 ([fe80::326b:ef06:42b5:c83c%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:50:17 +0000
From: carlos.song@oss.nxp.com
To: Frank.Li@nxp.com,
	aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v5 0/2] i2c: imx-lpi2c: fix probe error handling and reset controller
Date: Tue, 30 Jun 2026 18:52:21 +0800
Message-ID: <20260630105223.3687516-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0171.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::8) To DU0PR04MB9466.eurprd04.prod.outlook.com
 (2603:10a6:10:35a::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9466:EE_|PAXPR04MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: fc400257-6816-4a6c-9dd3-08ded6955f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	veyHk1kXv5sMVzLgPiEx6ixmIuA/MTsnBOCwZJ+gH3SLuCWnb2f1aLXrPYuVuizGcW7wSPNF1gDZw3mUJBNKjeLuUhsaS9JG2bshrkzye75Ua8Bd9od/JLgOu3e5yLfST/n3rTofseHDh0z7+cHhe6/fB+JPaPtb/5MoMQL1S9dMzamsnPnSoHWG+/PTdldlUwlem8uxNmaHAcidw2ieqvmtxoV89KoC2bpsCYCRro8GBEUhzpHDIaxhImoNdO3nTBfNV/IY/WUyzFLBpSY1QvFhcu4JeuiT20zd1uFIeQ6fn53UNZMMilGc0Km8CMxSM252BoMUOtTD4+py+2PCiSdsJzRWOm9uHQDfDMYkHXyI8qZ5jNNx1nP+0MjpwM+ybIzMIpZogaXZwuqlt/caz+h3OO3TOZbmGLH10fkUirYBKJRHDNhgnC406yjQr/pgREMeR4hyNYZ6i0stw0+OYDcVPnWWhpUK9dG7ry0aV9alYsy8ywwK/M1wGEKB50DXi/urz0CsYeLY1YQN7djHOVN+dJlL9kADb3aJt5ywjvPfBAZZ2pfR8sldWuBaTfoLWZlqtRo4HkotGhXH/nwSwXieH0hPC6EbPPi+uwYAv/fHHbm2KHaO2eYZkr0wgAPMbzaYyhBblv3OTS3ZvxnOx5zWZHBMrfB0gRv29/v6Z3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9466.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x8GRDAKWJDArdieXHwOeUGfKViutt5fSb35opJxVSByBurnITkxHEV6NdqcJ?=
 =?us-ascii?Q?juyDn1xjE/UteHoTNrZKIDCWwdwuZ4w+ekjwhN9VkFyRAEJcHLyG0AFQbZFL?=
 =?us-ascii?Q?5KVTmlv8YU0Jxy5RUPx9zYLj7umg+evzrCAd/WZOBTEpNECYfa9tVmMXrr7N?=
 =?us-ascii?Q?k4uoT8ke5zLrPLyRaI3YtDh3yiYKEa3msxUH2I0uG2cUmlNqJilf8B0C7p/5?=
 =?us-ascii?Q?exelV3lactTCWnDaKhSA+R3svW3CF9X5m2Ya15VkCYb21kbkoPPhz0LP0t3R?=
 =?us-ascii?Q?zJzf8iAiBLc16kfT/dCDrElxBIMKfqPh77bbW9cA1TbjkbtH2Ai9aZ5kp6x7?=
 =?us-ascii?Q?smxkXRDnl9Pz3SxI4uh8T34BwDBwcRvIrI4IlEXffw9Zs04uotw5gafMH9YJ?=
 =?us-ascii?Q?6+GC7trCBZIvp6/+eHLq0L/UvhBVoGUnxMG8Dvo+vCikTL4z2Ccw2HLnT3yx?=
 =?us-ascii?Q?l0agZkJ09fxsfLyUHyOyVpWsMmHCKquEVyyuBdQijl0wZZoenY+4GLcD2DQ8?=
 =?us-ascii?Q?1ONqxGX47H5t1OqIAEGTesFyv47lcldDM0GJnd4gQ+IyuA3EHfvWhVDLl7ig?=
 =?us-ascii?Q?FQNussDITbhD3yo4RLTQ3AZWmgLW0bb5rGvwmLJZH50pIh1mWeJ2i5dWYRFg?=
 =?us-ascii?Q?OrSFFhlJJrZhEHCJgUepah7h6BsHqmmfGR85i6llCxsuhWC8ge0Q6ZSUy0IM?=
 =?us-ascii?Q?7eRLxe6/ejC5/Q2Cba0Z+r/8/pmdMWI2V25w5hOWrQ4zNPtsB+7L9wDoPJUB?=
 =?us-ascii?Q?KmjMnmYrhuaXn3S1yQP4VwVdxvboBoxWYZ+82Z21FND9B7ehZYu4tz9x8mzW?=
 =?us-ascii?Q?IynxQxQ6m2nTTzmpfdYMmnQWM6J8IEdnlx34G5f1BM+POFIfK1dSQnfU4czq?=
 =?us-ascii?Q?dxJEvCO8SMYJMvwPEqfxtkil2oAAX3qClb3nOJtlC2vAQxJay+XLbw7MMBW7?=
 =?us-ascii?Q?aCBAeWYzUPDdFlhxnHWHxOLhkyzv8AckrUmkKDr4LHd0uHn0JNezD+HKq3XS?=
 =?us-ascii?Q?vtYPjJY4Y4U9DDh8fq/oqE/TWgZGcn6vcXF2EppPH0VUX6wgjonchWPW7HkH?=
 =?us-ascii?Q?bq2sKQEyfJ1Wzbq9DophT04nMymqp4vqPLWv2CGiaCDdRNXWJxj8HaTx1Czo?=
 =?us-ascii?Q?z/aVzKI44Tzije02juMmTOx3kLWthOcRgL/MW/gH9ibLj5mxCZLLLs6avjzx?=
 =?us-ascii?Q?PYGF6K2q5/st1ypM9lbQSWuks123zC05qBsOfGUtQQLQ8+KKtqocTx2Ih5Uk?=
 =?us-ascii?Q?8gExd6maEZoErqbBS65g6gB4+kCcQjD12ivcaWp3QXFG9sXF52e0KxQACPDD?=
 =?us-ascii?Q?gXU9PpZkV8s1vzMJ/vSwtdsqv9Fr4+hqkecLt7FQMwKb/O93TEcS+T0YiR3T?=
 =?us-ascii?Q?9PNNY2PD4n1R1A65gu612bJZz7Hr1MqErdSY9cw87iuN/lZ+bIjEBgArwK/g?=
 =?us-ascii?Q?e3IENEomyLX+Nk+TQJgRteZxrIl0MDPJ51yOkvjDNJx0bTZ3C7DUXjqXBg+6?=
 =?us-ascii?Q?ApsV75uaunt0LhK1y3xxkyNvB++2ue9I2XDE6Rs5ZEG2f7GZtNlCfFoB0fPk?=
 =?us-ascii?Q?mmySJMWHf4lisaXNEZ3Lt1N30myjW9i1CgwtVCkToPXpLy1muA1fvIhXOMJE?=
 =?us-ascii?Q?OsZuUWMbzvsnmAe+DztgZdnfpGMFNdzD0J8JtRIRDlEMG+i3MC38alqY/Qdi?=
 =?us-ascii?Q?jJY/Ql8qcbmr5DzArGG49WoB4QgeJC6vvTo6pA5smWzmgsGBq8kxAFIfjWBN?=
 =?us-ascii?Q?pWeHv/aLlltPJemDemTbljrb+0c820qRK67QCYoSvIB9+UH5OMwf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc400257-6816-4a6c-9dd3-08ded6955f69
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9466.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:50:17.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c8Z18sdAs7tY7Ui7frX96Yljh/GG+XKaytrUrXiGpSeKXPosrY4j+vae3+UnjGgBUWfT8SekapgVOmGZ5/DwldjbR57oe0fLPCBYD1IHyaHKA6DAymeAMdOo4S6oAe9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122

From: Carlos Song <carlos.song@nxp.com>

During probe, two issues exist in the LPI2C driver:

1. The error paths do not properly unwind all acquired resources on
   failure. Clocks enabled before runtime PM initialization are never
   disabled on certain error paths, when probe fails after runtime PM
   is initialized, the previous error path called pm_runtime_put_sync(),
   however, due to different clock management strategies on different
   SoCs[1] (to avoid deadlocks between the global prepare_lock and runtime
   PM), the callback may only disable clocks without unpreparing them,
   causing an incomplete unwind. 

2. The LPI2C controller may retain unexpected state from previous
   boot stages, causing the system to hang during probe.

This series addresses both issues. Patch 1 restructures the probe
error paths to ensure correct resource cleanup on failure. Patch 2
resets the Master and Target controller logic before IRQ registration
to clear any leftover state.

[1] https://lore.kernel.org/all/20251125084718.2156168-1-carlos.song@nxp.com/
 
Changes for v5:
  - Remove devm_free_irq() and free_irq err label.
  - Change commit log to explain why not using runtime PM to manage clocks
    during the probe phase.

Changes for v4:
  - Split v3 into two patches per reviewer feedback:
    * Patch 1 contains only the error path restructuring.
    * Patch 2 contains only the controller reset and the IRQ
      relocation that is required by the reset ordering.

Changes for v3:
  - Reset the Target logic via LPI2C_SCR in addition to MCR.
  - Replace pm_runtime_put_sync() with pm_runtime_disable() +
    pm_runtime_set_suspended() + pm_runtime_put_noidle() to avoid
    triggering the suspend callback during error recovery.
  - Add clk_disable and free_irq labels for complete error unwinding.
  - Update commit log to cover the SCR reset rationale.

Changes for v2:
  - Jump to rpm_disable instead of returning directly if the IRQ
request fails.

Carlos Song (2):
  i2c: imx-lpi2c: properly unwind resources on probe failure
  i2c: imx-lpi2c: reset controller in probe stage

 drivers/i2c/busses/i2c-imx-lpi2c.c | 43 +++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 12 deletions(-)

-- 
2.43.0

