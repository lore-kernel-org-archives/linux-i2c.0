Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445703376A2;
	Fri, 23 Jan 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165664; cv=fail; b=BbGWRxbSS3Ob3NNtLAC8jv/pR72pl6wZLHDxOSRbmXtbWYt+PdlCFQCqDDE9Za5h06mppdL70NUzDWV4qpZU9uZUzrj2Bh7/j+ALtIAPlpkIHYraKWKBG2relDYinKFURPE+XOADjNuJqi1hOTc1pXsYD2ezLDe7IkShlv/2YZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165664; c=relaxed/simple;
	bh=JUiIttzIT648vGYo83K5t7NIPeJQKt9az2uRYa71FAc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j5KH5fDCJEuPM8+Z/zxSnlGHEug5JAwL6lmEf++sMQoUDmNqCqDoT4q8SiMAqG8vSriJ/WOGrUJkJq6wggMZRJHp8Un7GpIhx4VsD0h7BmR6QFGwXPeELydk6hspx44nCfojABMxz87g81zB2BePZ0TlJ02vavNK70khhPNkQPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IqIFZ+aR; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IqIFZ+aR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxF+Dy2A2aEcOpDvqr6lLcxt5hHN2cF+68DlNjny2bOX2/r+KRNPK4X7psBV6VsC7kZ04U7EYVf972FxAkMhZxkbjZfWi7j+8xeyLTb1wztq5rQXG3PlneHC+2sdSpqp++Jcy622iD8BWIiDPgqD5uLv912f4fy2D8uhzVPeY69TVqcWM7Sa7EKIGrCt6BkK4RhUfKRGyICKI+Msu9aIe1N+mXInPmle0bizVJGDL5yeZX1lYUPYOUcfISGgqqIXYbXXI7CoMxRGWks/bsAEW73koTowQcmucYLD1cWr0JxF6h1mYE/2cdNkalin5RCrMnfQ0znzHIjiqF4MHq5MAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l6XPKNw9Vb97lzXmD1/7dHkN2wQSqUpkCKT+Ajsemg=;
 b=sJKDRzkZl0xw4Mf8GSPTrBYQmr51ad35sqOH1JtF/xWqnQ+ZOuCcuC3NmLMc1V0W4egqTN5eQ8dOBfzHp73WXdENsA86ou86SeXeOq2E2n7lBOmZsAqi3OwtbSUDyP52I2saiEo3pMWyfHW3n3no10TrjtB/cqpywDd5WqqU+b/kDgrMFBOw3+QkM2MB8gGdBHj2ZHJX6W8qkIg6fez8pZtJcvY8S+ZPZEbQTYYZnHaWFKhsqgKZ1VynaAPH+uKKpgg0IqC2Ycju2SRmvcEYnb0yIahOLu/NQ/MO+zxuxlw2BThNyIJcMl19pRJwVt5D+4EttCIGBOb6uH2VQWFjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l6XPKNw9Vb97lzXmD1/7dHkN2wQSqUpkCKT+Ajsemg=;
 b=IqIFZ+aRXWy2DvtpjxmS72edPmHjdqq4XwXtx3SRGd/rXYNYOLb0S1eLm0yAep0xO/RDZECxNWsLi4ZHkFoullm36+3dsxCJEhMjCpJwT3TCLeA/nmXHpeev4P8oz+BmJv3MeU7HyimSa25rray8Yre0WfcBaf7d3fekXItS4y2L+hEGm+41G4GmNGFum6RKAPbgwjltYAeOMxi4xlKv3fLkf054Ga1oHkAV2mb//J6ZScnP1uZCl4yy10L1XbLkVyErx/CFpWU4PKILXQ6/d4YPfUlEtY+s0wgIXZbRlR+fAdEUJnTM9bN/1eq9Wv6amukrTBXy0gFw7RIFC4xywg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB11003.eurprd04.prod.outlook.com
 (2603:10a6:800:279::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:54:18 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 10:54:16 +0000
From: Carlos Song <carlos.song@nxp.com>
To: andi.shyti@kernel.org,
	aisheng.dong@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	pandy.gao@nxp.com,
	vz@mleia.com,
	wsa@kernel.org,
	B38611@freescale.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [Patch V4] i2c: imx-lpi2c: fix SMBus block read NACK after byte count
Date: Fri, 23 Jan 2026 18:54:58 +0800
Message-ID: <20260123105459.3448822-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To VI2PR04MB11147.eurprd04.prod.outlook.com (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|VI2PR04MB11003:EE_
X-MS-Office365-Filtering-Correlation-Id: 84738a35-4a1a-43b8-5383-08de5a6dc04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGg+rBKBzhKXQnFTMK3Xl53fGuBXGBz75ddySDXS6xpLhUPlqh+4vboVUOgT?=
 =?us-ascii?Q?bLlrJFS5mTuFgKaijczi+8X6b22Y0GdkH1ccz4T1DR7vsVttSt7mrSmGsnGj?=
 =?us-ascii?Q?mMdzJTigUBqFx/Sc/7mwfP8AlZl9IPHnxB64/dtFn1EDpCocxLavqr3AA+JQ?=
 =?us-ascii?Q?5cm4ToCrEa8HLjMyJZ3irw/Zf05mB5u6PFULpI0MD1EtIJd5maq7TAga5S9c?=
 =?us-ascii?Q?F4yd6CWs4PnbWmHujo9nmPc5I1kDVCnNFIZsCDc0J+Q36Yu7sJ7LvK8MnZey?=
 =?us-ascii?Q?u2dzCMUfPPammROzm3f3iZDsffBZwudxnz5P1wpz5E++s2GJRcX7+g+wJ/aT?=
 =?us-ascii?Q?EO4WabH2gEO08vUAw0oOMEjD3ctPzuMTJ6gIPvS5hJSIeEzbE67XHqpTlHRb?=
 =?us-ascii?Q?KR+i8cA++WeXs6o3tpckY5sS+33ybiKv5dCTCAjnUwkIhuDdiC6Hdid6xxC6?=
 =?us-ascii?Q?3jJiqMSg59r69ER3IizmQmLOTkP/lycNcdLfitfQPGMPKpgj8bqRYJo5Y7zy?=
 =?us-ascii?Q?QTU8xbpspAKM7CAwcZhqoZEq8c5BCD0mwYsCYpxhV9Q99ddjnX1LYnuLyBHI?=
 =?us-ascii?Q?pwD8nGLnZe0r8+3xDUxaciW5cVkwJUURDweg2B7hMQqOyih/qBkaMpWPFKjQ?=
 =?us-ascii?Q?lLjuUv/NLOBuLzx1aF601iu0PijApXpt92p5VEpd7RD4goh66c0Dbl6eywQj?=
 =?us-ascii?Q?2/AXhQPU671O8WIPro3Mv1itM8llDo8GYi3RPohedH0FJLuDvyXPUMIILhFh?=
 =?us-ascii?Q?yS/mt6eIv95LvFhXp9d9S5vz7Jezu91Xzn1hLYyi6TrsfYz6LcgbtRcp/cDO?=
 =?us-ascii?Q?+Oli4HPnmROcrV/CYErFHcyKKByU/1VIpni1poOeM/K8rKos2e2CMGav41LI?=
 =?us-ascii?Q?Aua1kCaS60zBzkFmxNQisZEFPmx1YgwT0D0dFwi5nAr3DwIvOz1br1WvFP1V?=
 =?us-ascii?Q?zTznAjkr4oVnGF6qPkiKQA3JE7kgTcbyAZncjkerMHhUJqKuFzmdvXKOnDE2?=
 =?us-ascii?Q?NBmf5qStMCEKESjvDO0dVJK9iL7FKuHVeBu2ke+8zHzi3ajCYXgJ0MkjhK2L?=
 =?us-ascii?Q?MUB3Poxk/XiyimhCAJ6AnO86Zq+TGG3PK2bk4zDwW7QN48wBOKcTdZGO19Vw?=
 =?us-ascii?Q?r2XJ/e2JkZ5n8rG+BCoh4JLbVAqay23LYrAJVPhBzIdE8euWT03U3G0/fKmP?=
 =?us-ascii?Q?QgXoU3vLSvOxBkn2sfzaFLSRFYLpXj1l71jWgWtFzoYUY3BRAO2qBP+W3eY5?=
 =?us-ascii?Q?usKUZQF5iuJDVuOREjVkbYS9GIF4EAcPPhAE6U/DNzAhOAHVuy7wFNpDXbW6?=
 =?us-ascii?Q?xEssq7d+W1cJ1Swmut6HR+vlmhqvzgcJ5dPSH9DgDep1byLELnL/pHYPyMNE?=
 =?us-ascii?Q?aBOkNt8WwjRWTaJT0wJAVtNw1YOKWZ+Pstlz7lBm/fkHvIAbwuBAYmy3VVET?=
 =?us-ascii?Q?jm/JlQDrsQ+SPhWWHAJJptXmbaeftK2AdFIgc1Rv8wmD5KU4gnkZciB0cbpN?=
 =?us-ascii?Q?0pOuKYm4XVfvtRUFPPeAwRl45hu+J4F/jWrmnfjidLEfDYrngMQ/v5+JUHOT?=
 =?us-ascii?Q?PbXW66D/HFeJAFAl6UyNHHTdGYNwDzkZkXOQmOlEARGZNxmceAOq2Ok5ErHk?=
 =?us-ascii?Q?h1prnX6olLbKfcycVrqHJL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eEtGTV12PHu1ciZc4KSKTbjikzY0f82bwMy1FsgFDxGGJIeD4mJ4Hr3Psyoj?=
 =?us-ascii?Q?djtcfvrmvVZpD3EUYSoAFp7M+szc2NfpSc1xNzS8z5O57NBvwheovwDfou8S?=
 =?us-ascii?Q?3OpMHXpo5O0a1Y7c+A6xTs2pyp+uoDG6rzFy+6AZx0pr79jPyXF5PTpgr8Bd?=
 =?us-ascii?Q?43qETUs17EYHx9jjKeEbHoTE3DzW6NF6UwMOKOMj9WSwp6FqhBxcruqGu30K?=
 =?us-ascii?Q?mLsYU/losTYMs9kB+maSaVnxM3t4e+GpMbmTsRnBQEI+CdanopM8En++1iZK?=
 =?us-ascii?Q?F632QsT14TqnuOu8Fewdx/+cZXqTIVCAwo8lQSvpU/78cwowOpkrZ7lFzwWC?=
 =?us-ascii?Q?XVA/8h49fRdoYcz3mqA9me8trYIaBVcgl+mxrqJEnbgJTsZwods3I0ZUZCf3?=
 =?us-ascii?Q?ogC9eCKjSJQ3kd6DqcdkmvZ0pszaBPXO+YGPCwjgBcB6STKcvzp8NUx3iCA8?=
 =?us-ascii?Q?fsKfuJPvqoYTNr1Gv+wlP6sxn9g6GMwLe4AXm4Xk0crhkl8KF2akmapHuumj?=
 =?us-ascii?Q?t6tEiXAVfSNxVZA3MFuZ5aZyAwZbH3v0oSXwEatixmyKz+7EF8gU0ZUTSNZd?=
 =?us-ascii?Q?s7V3FY3w+WVgosHCtZn9jWiMYLG4KgrU88VU3BC3+YnKCugWJ6cezj5Qx7HG?=
 =?us-ascii?Q?8zWNwxy2BZoCABWi9bFcdgDaGXckfQOXl5rChLuOyRCYW4wVUgvQv6ze2UoX?=
 =?us-ascii?Q?dlNhXuMiF6oYb7/20Y6vPH+kbiOWaRwZCvkv2rzg1wAgxTDoLN4Wxeb5q/dO?=
 =?us-ascii?Q?NbcoK6ikuF5FcVSd823ffXUomFq+wuqUl/N+58ADy+as7OSrUrnChk9x7WEi?=
 =?us-ascii?Q?7yH8YIo5a8PZJPz+5An2gkgMjwMNpHV3/7+fGCftv7oZ4G2STMbq4YGUB5hy?=
 =?us-ascii?Q?5ABDAuKZx8pSqJiB7TRI1MtBHAhWiUpBzu1m5+LxEcukEf8A2DBb5JERI2ri?=
 =?us-ascii?Q?Z+ghGjCOLv2soq9nwGzSVq+1vIzGY/tj2gr4EasOmPVQu9S68PO3UpmQtX0P?=
 =?us-ascii?Q?YylphU8ullpez1oTZ4vW+zVNd6EXcuxkRJO71fEjf6fv7b1CDbl+BM+faYO0?=
 =?us-ascii?Q?y83PzlbVElUEL4+J3Q2BY5U3N7LGj8nA60/9JxNQt2KabxggLBpuYr4Ovml0?=
 =?us-ascii?Q?57ySavRF7C2+gbY7K7mJq+NGJa/LQnsdNeN6fuO+fhK4l34+4zTnDWohOatG?=
 =?us-ascii?Q?Y4SVufA/16WUtstCL/je578U+8iqyqQjdKhvztdhV/sK1P9CcV1k2U06t+dM?=
 =?us-ascii?Q?XdBgfmCjE7tb6Ep2QF4PBqVdi76fS8pDsIe9xIoQLYwStcvlIzVADh/I/Hj/?=
 =?us-ascii?Q?hDCR+tVrwfLDwbrKrd1B3jsM58+E+Ut6h4deRy1GKSu0aBQ9u4tRnu1I5uOE?=
 =?us-ascii?Q?zuZYKoxnMsrsrZhxhlpyCT9bpEnrLAnnniOBWR1/X93oNMPuPpbLyP+A0otw?=
 =?us-ascii?Q?ZlqsHlqISiupgdO/ybRBwZ+eX14rDP3WZEjaIiw4SC38kYiT8T5SATBY9h4h?=
 =?us-ascii?Q?SRc98U5hKrGGturXsSCtgJij+BVyLDwRwnsWDsZ76LfDkrevzbWXv962Ectb?=
 =?us-ascii?Q?9ROhskUXUKtvI0flCSyaEdmcxETN6yPeqL5CTKgy4RHevricU5tKpavrR1mA?=
 =?us-ascii?Q?PpGeixAmFayIacBWr6EFySEUbz5/U6187WyrKUV/QKQVD5OiJIpTs16cL+1u?=
 =?us-ascii?Q?WmhFXq9SytT7Lvw3/hr8NwDqIeBjbOzEbk+KLWkxtLNnIYs4EZzaR/FtXiLC?=
 =?us-ascii?Q?qUo59zJFxQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84738a35-4a1a-43b8-5383-08de5a6dc04c
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:54:16.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws/Z07cugLVWagTA1HuzgdeThK9xGTvLqhVKrUXipYBNNPm8rJkcejd9VE5r5fOHOEVwNVz46FvLAxpnbbciYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11003

The LPI2C controller sends a NACK at the end of a receive command
unless another receive command is already queued in MTDR. During
SMBus block reads, this causes the controller to NACK immediately
after receiving the block length byte, aborting the transfer before
the data bytes are read.

Fix this by queueing a second receive command as soon as the block
length byte is received, keeping MTDR non-empty and ensuring
continuous ACKs. The initial receive command reads the block length,
and the subsequent command reads the remaining data bytes according
to the reported length.

Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes since v3:
* Rebase this patch on top of i2c/i2c-host-fixes.
* Add <linux/bitfield.h> header file to fix test robot report issue
Changes since v2:
* Change patch name to clear "this is a fix patch".
* Change patch commit log and clear "what is fixing".
* Place MSR_RDF_ASSERT(x) by MSR_RDF_ASSERTED(x).
* Split this lpi2c_SMBus_block_read_single_byte() function to ensure
  return value is type aligned.
* Add return value for lpi2c_imx_read_init() to ensure transfer function
  return directly when meet error in smbus block read length byte stage.
* Don't read 1 bytes when block_len = 1 individually, insteadly all
  data bytes are read in IRQ handler or atomic_read function.
* Improve code comment to clear up every step logic.
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 107 ++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 2a0962a0b441..be2db861ddfd 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -5,6 +5,7 @@
  * Copyright 2016 Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -90,6 +91,7 @@
 #define MRDR_RXEMPTY	BIT(14)
 #define MDER_TDDE	BIT(0)
 #define MDER_RDDE	BIT(1)
+#define MSR_RDF_ASSERTED(x) FIELD_GET(MSR_RDF, (x))
 
 #define SCR_SEN		BIT(0)
 #define SCR_RST		BIT(1)
@@ -461,7 +463,7 @@ static bool lpi2c_imx_write_txfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atom
 
 static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomic)
 {
-	unsigned int blocklen, remaining;
+	unsigned int remaining;
 	unsigned int temp, data;
 
 	do {
@@ -472,15 +474,6 @@ static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomi
 		lpi2c_imx->rx_buf[lpi2c_imx->delivered++] = data & 0xff;
 	} while (1);
 
-	/*
-	 * First byte is the length of remaining packet in the SMBus block
-	 * data read. Add it to msgs->len.
-	 */
-	if (lpi2c_imx->block_data) {
-		blocklen = lpi2c_imx->rx_buf[0];
-		lpi2c_imx->msglen += blocklen;
-	}
-
 	remaining = lpi2c_imx->msglen - lpi2c_imx->delivered;
 
 	if (!remaining) {
@@ -493,12 +486,7 @@ static bool lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx, bool atomi
 	lpi2c_imx_set_rx_watermark(lpi2c_imx);
 
 	/* multiple receive commands */
-	if (lpi2c_imx->block_data) {
-		lpi2c_imx->block_data = 0;
-		temp = remaining;
-		temp |= (RECV_DATA << 8);
-		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
-	} else if (!(lpi2c_imx->delivered & 0xff)) {
+	if (!(lpi2c_imx->delivered & 0xff)) {
 		temp = (remaining > CHUNK_DATA ? CHUNK_DATA : remaining) - 1;
 		temp |= (RECV_DATA << 8);
 		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
@@ -536,18 +524,77 @@ static int lpi2c_imx_write_atomic(struct lpi2c_imx_struct *lpi2c_imx,
 	return err;
 }
 
-static void lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
-				struct i2c_msg *msgs)
+static unsigned int lpi2c_SMBus_block_read_length_byte(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	unsigned int temp;
+	unsigned int data;
+
+	data = readl(lpi2c_imx->base + LPI2C_MRDR);
+	lpi2c_imx->rx_buf[lpi2c_imx->delivered++] = data & 0xff;
+
+	return data;
+}
+
+static int lpi2c_imx_read_init(struct lpi2c_imx_struct *lpi2c_imx,
+			       struct i2c_msg *msgs)
+{
+	unsigned int temp, val, block_len;
+	int ret;
 
 	lpi2c_imx->rx_buf = msgs->buf;
 	lpi2c_imx->block_data = msgs->flags & I2C_M_RECV_LEN;
 
 	lpi2c_imx_set_rx_watermark(lpi2c_imx);
-	temp = msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
-	temp |= (RECV_DATA << 8);
-	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
+
+	if (!lpi2c_imx->block_data) {
+		temp = msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
+		temp |= (RECV_DATA << 8);
+		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
+	} else {
+		/*
+		 * The LPI2C controller automatically sends a NACK after the last byte of a
+		 * receive command, unless the next command in MTDR is also a receive command.
+		 * If MTDR is empty when a receive completes, a NACK is sent by default.
+		 *
+		 * To comply with the SMBus block read spec, we start with a 2-byte read:
+		 * The first byte in RXFIFO is the block length. Once this byte arrives, the
+		 * controller immediately updates MTDR with the next read command, ensuring
+		 * continuous ACK instead of NACK.
+		 *
+		 * The second byte is the first block data byte. Therefore, the subsequent
+		 * read command should request (block_len - 1) bytes, since one data byte
+		 * has already been read.
+		 */
+
+		writel((RECV_DATA << 8) | 0x01, lpi2c_imx->base + LPI2C_MTDR);
+
+		ret = readl_poll_timeout(lpi2c_imx->base + LPI2C_MSR, val,
+					 MSR_RDF_ASSERTED(val), 1, 1000);
+		if (ret) {
+			dev_err(&lpi2c_imx->adapter.dev, "SMBus read count failed %d\n", ret);
+			return ret;
+		}
+
+		/* Read block length byte and confirm this SMBus transfer meets protocol */
+		block_len = lpi2c_SMBus_block_read_length_byte(lpi2c_imx);
+		if (block_len == 0 || block_len > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&lpi2c_imx->adapter.dev, "Invalid SMBus block read length\n");
+			return -EPROTO;
+		}
+
+		/*
+		 * When block_len shows more bytes need to be read, update second read command to
+		 * keep MTDR non-empty and ensuring continuous ACKs. Only update command register
+		 * here. All block bytes will be read out at IRQ handler or lpi2c_imx_read_atomic()
+		 * function.
+		 */
+		if (block_len > 1)
+			writel((RECV_DATA << 8) | (block_len - 2), lpi2c_imx->base + LPI2C_MTDR);
+
+		lpi2c_imx->msglen += block_len;
+		msgs->len += block_len;
+	}
+
+	return 0;
 }
 
 static bool lpi2c_imx_read_chunk_atomic(struct lpi2c_imx_struct *lpi2c_imx)
@@ -592,6 +639,10 @@ static bool is_use_dma(struct lpi2c_imx_struct *lpi2c_imx, struct i2c_msg *msg)
 	if (!lpi2c_imx->can_use_dma)
 		return false;
 
+	/* DMA is not suitable for SMBus block read */
+	if (msg->flags & I2C_M_RECV_LEN)
+		return false;
+
 	/*
 	 * When the length of data is less than I2C_DMA_THRESHOLD,
 	 * cpu mode is used directly to avoid low performance.
@@ -602,10 +653,14 @@ static bool is_use_dma(struct lpi2c_imx_struct *lpi2c_imx, struct i2c_msg *msg)
 static int lpi2c_imx_pio_xfer(struct lpi2c_imx_struct *lpi2c_imx,
 			      struct i2c_msg *msg)
 {
+	int ret;
+
 	reinit_completion(&lpi2c_imx->complete);
 
 	if (msg->flags & I2C_M_RD) {
-		lpi2c_imx_read_init(lpi2c_imx, msg);
+		ret = lpi2c_imx_read_init(lpi2c_imx, msg);
+		if (ret)
+			return ret;
 		lpi2c_imx_intctrl(lpi2c_imx, MIER_RDIE | MIER_NDIE);
 	} else {
 		lpi2c_imx_write(lpi2c_imx, msg);
@@ -617,8 +672,12 @@ static int lpi2c_imx_pio_xfer(struct lpi2c_imx_struct *lpi2c_imx,
 static int lpi2c_imx_pio_xfer_atomic(struct lpi2c_imx_struct *lpi2c_imx,
 				     struct i2c_msg *msg)
 {
+	int ret;
+
 	if (msg->flags & I2C_M_RD) {
-		lpi2c_imx_read_init(lpi2c_imx, msg);
+		ret = lpi2c_imx_read_init(lpi2c_imx, msg);
+		if (ret)
+			return ret;
 		return lpi2c_imx_read_atomic(lpi2c_imx, msg);
 	}
 
-- 
2.43.0

