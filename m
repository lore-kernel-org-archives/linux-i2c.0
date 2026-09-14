Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021138.outbound.protection.outlook.com [40.107.51.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787903093CF;
	Mon, 14 Sep 2026 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392230; cv=fail; b=d0DlpC1GtoNszhMuAm2zhZsSxuzutt2K3YtEBlQxV+aJSgMGS6u32OQWRk+Ve05rHGv/DYzs29gx+91rUQw6SptmXxaPp4HdSVo2KoCXlK1ZEdSvjgOjfaU3VBNdbelQ3pMsF1FWN8UNLdtqCkAgSTfj58lQ45KhPVwFgr5JnVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392230; c=relaxed/simple;
	bh=O71Caw62uxAhIinuaHwKxfkNforb4Y11r30b3/GuF/4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=awKanWcdB6pkeQgxAkqXnUOy+uoojemVAAD+1f8oYlpiLjwfUWfuwUHP4gEK08oc0q6RvnkV4Pcz9Oh0FLcnnhE0G8/iuJQqzXd4jgnHwv2GFag7R1b0+sLOMhN8a7kNOHi+sjnzp5W2v9+5qIkr5SBJgI6vyBFX2uD+Xf6Eia4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com; spf=pass smtp.mailfrom=ebytelogic.com; arc=fail smtp.client-ip=40.107.51.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ebytelogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkgVYWU8cLaogRext/oA6UE4OHmZ20HxJdan8LXhk5r2/26mKBdxREVN9WqwuqbVh6L7EULMMR5B+iUF+CIU6o9+SRPx8bPhHOxkNdR1GDDB/A1x9lLArFUijhXF1V5z3GpIpo9qZ/tuFQB2qv0+rOIRYcV8FnqQIjco2diRPe8fRq2eOFmqHmo3YYNAzw4jaMSJrwv2r+nVKPiZOIrQHg82HPlVaqon+fatlYi2xO/AP+SQqCSkN/Q699i0QQJ7kjObP45QlZFtnCxq9YY8IzNPKFxonF1WPu8eUmoVaEpr/A8gJ5RIU2Yt9rkrGe2xGiy0LpMZ9LqZxgHIZlrC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCyrtoR1R3oH9LVyD34BoSf1gBW8c3ufYeDUnkAQKKg=;
 b=nv11uGx1s3DNC5qw3T/hxQoWEXByJC37JafMmcjm/xargM6ubRQINa+kR31ETBgPuUQsAc/KoqRxxgwHHej57ZXw70vsDjs63vv6U4S3bOzj5tCM5PPSZ5UxavyclT3MkFL8rAi8jGh1lfoNW1byPSlC5++/2i0qrepl1Kqc2sofjy1Q+WA+QcFOH2C83yIkaB7keSHADWfSBoOGnhc7fNs63OX0sFFHDcY/qEAZTVsR45owcWjqD884ovSCrwzUsjjW1gAnpsSo9h8SOgyTZ6mJuK6pgYpNmkUdHdkeL5PEocvWuAFNvP95+hzshZoLbvUkWqQs2z97urvQpo0c0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ebytelogic.com; dmarc=pass action=none
 header.from=ebytelogic.com; dkim=pass header.d=ebytelogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ebytelogic.com;
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::97)
 by PNWP287MB6066.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:345::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:23:44 +0000
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e]) by PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 13:23:44 +0000
From: Hitesh Patel <hitesh@ebytelogic.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ravi@ebytelogic.com,
	Hitesh Patel <hitesh@ebytelogic.com>
Subject: [PATCH] i2c: qcom-cci: enable SCL clock stretching in standard mode on CCI v2
Date: Mon, 14 Sep 2026 18:53:28 +0530
Message-ID: <20260914132328.976902-1-hitesh@ebytelogic.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b7::9) To PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::97)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PPF28092842E:EE_|PNWP287MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2cb598-8d26-425e-92bd-08df12636638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+psDkWBIpRvAWi4V8BG7rUgZHxquhDHJ+q5xx08mvrZhQeg0mdPDwSOF3no7CRtcyFm6Hsi5tK3E9x8FYOIsCmekzefJ6nNpcLBLb7QwE4ok56epi9CYM3Qh1q7Z8sXcIZGkbU9xIx7ocS21QX20viFgVrMDOWF3bSjpqrPJOjRu22VyC5AhLsrUTQiE2sttqHchhCv9X6LijOshxp8qdoYyYTP++snji+RsxFJQos72S9ayLtNAz3Lw4e/ypCqoU17jvGnlbCi9uhbnuEIbmnNBZfQJBz2VQsXjJEtNwxjylgtMWgdj7BQncQPqMn9x9dTvceMQ18hGRDcrTRBwSXUhWamWGiSMimI1ny5J70f0wMlIoaHFs4eR6v3gV8HwGi6K84Pf0CovgPwXiSnQFdYQ0SShARncl7Aie6ZQAT2Blr8WatfDt+fMXF/cvxFnsy+GVN/Owe2U9m/gcuMj4ZLmTVigme9seeUNqGw4MTA/4rTFt/070NKXfxevYl1uKAw7Ym1oUB2oDpZOFmWohygjyonnJFyEcsWbPuRnpzUty6OUK5L+5RnG8y957k85xdAuGX0wUE76jn30aoSUbX+wG4ccUgASDn8tli5FZgB5XBGrc084ifELImPYV/x4jrnUNXK46SDdK1Y/z3P/E9uqyhnrlMHZD4fOP7ZEfCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5VhJQkmSHB8xlFonklh4UpDGGbc0pkpBuCrMtdB+LZfF3RoTRfa1IlA6Jx7Q?=
 =?us-ascii?Q?jPDy/xrIepa5WmsQpL571TmttELevBrdoQAFBg2YA4kG+gvMFxXYaxj7RrMx?=
 =?us-ascii?Q?0SPldjQMI14tvbVjlQL8qlMtvklNNUU8AsEENdXQZ+utYq7UkouXCJrLnQnK?=
 =?us-ascii?Q?otkcD0wwrLkhOL995kQuvJ6lC7oWEBgrFOF3lgQDDvef5dc1JPc9Otace6jl?=
 =?us-ascii?Q?QobJnso2HPjr/uo7uofFJiwN5xAZb9I6bWR+LL23zsHfz5znQh2ZCOtyf4bw?=
 =?us-ascii?Q?o7GQJEf49KQAlWf3KcAftmUA6/pDqPkvk5SlYMWymIOTCIIaGWWDPHHEETZ/?=
 =?us-ascii?Q?ZZQ75AztzYCIeJtV5oKDfNZxyRTeoqLEGjP9R6E/VpVwR33lc9FiW9uG3eX4?=
 =?us-ascii?Q?AvvX79WpkGC02Vnt4waga+jfUHXDvR1611FzGJPnHYJdY0uuNLk2Lklt/pyY?=
 =?us-ascii?Q?qlKOV6T3VgDr0U2Plj5dXAh/QARR8e/IvD8/uj2NDmcQxONhJNh6RxtWHUCK?=
 =?us-ascii?Q?62wYoYcbcj07f0GwfPUsnJmNHRe2wzD05HKa7BU5WhHei8YkUa97H1Khv+aj?=
 =?us-ascii?Q?FvxzCeyPDbjEmA6f7njqvTgOBM549wasVlPBfZ4RdS3SWeYlZH12+VqHX2O6?=
 =?us-ascii?Q?ySfb8L8q5HeC8YsPK3lznqNBp1ULAtJ7ROfnp0n1tud9EFofoz7aGbBPW8C9?=
 =?us-ascii?Q?VWC72MDbhKKNWInORUhPTs++9t66+axnolkUP4Uq6Je7ht2NaAbOln977glI?=
 =?us-ascii?Q?ZoTlZ77RFxp9FsXI26Qh0M+xmgp1UlOfChE6IgEFm6zzz2cb9XSOGvV9oiFA?=
 =?us-ascii?Q?evcy8rXbOqBhntySqjizkzTIsbQ+1pNO92VbhzfNGhZ8Wok1hkKL3eIJ1vYx?=
 =?us-ascii?Q?vjDQcRfS3JPK4yTMj99ui7FK5qCsLKRYVQPbj5Wh14+cy2OcZJlJuwW8DoUh?=
 =?us-ascii?Q?4CtZkRyXwBLraOnUMaegBoLDWWhF1ijWzJjKzAzC53+Fh5/P9nbATz+Rdm1e?=
 =?us-ascii?Q?Jf4Qi2PeiGDeH7Tzdn05yc58fKNxCm3F7vncIYu3rLaSE9QdwVSForw2q9jf?=
 =?us-ascii?Q?8P470ZXXAT6Bg7cmSN/9c//5lIAOIA9pxrgr7N8W0um7hBq2bIGCM/3FiVEn?=
 =?us-ascii?Q?3F6haRZNRbLXzf/xMUuK5xZlBZ41h1wxvXVBd6VyiBpm82DmDr7Io3U5WhdH?=
 =?us-ascii?Q?2IsjTI5KflxDobgg5ztQjIhZ5Zmh3tjVIpKQM5FkJhEFk8czSiS2tzGg1D9p?=
 =?us-ascii?Q?Whtkc18NAmcmEj3tggchkuGrxZIwhPLEl6BrtWd1ltUhft9asnXjLpf0n4RN?=
 =?us-ascii?Q?eSvhumiAdONw5GTmnfeiLUYyfFs3SccKhs8T64SCk8Wpq5e/N1cEJ+uO5HJw?=
 =?us-ascii?Q?3vYBQ5QJ8cbPwt3hTkbaVCXmAuJn+qPOi1CijcAoq4tW+IE5s6upSYt48K4Y?=
 =?us-ascii?Q?sLRV0ra4NjS764amtYrMTh4EYgPjUMuS8V1vcYBrAg2q7xcq2uqfLkrkfZoa?=
 =?us-ascii?Q?KHPJGxJ8Ep5cRLY0XtTUMrGMCfkVmz35dDIKddrDa7KARIceteQ4tDfg8W1O?=
 =?us-ascii?Q?QTDA+lJQ1wzWB1QV1yG+MZcYf/QWWBTrMStrs2LYxilUOa05cXdpOLH+T+ho?=
 =?us-ascii?Q?03YBt2/tKweDIZCCXaPfVXA3BCI/DFQoOp6sdaQAoPZGhDLnNccZZuN314uf?=
 =?us-ascii?Q?a/gs1Bqt7VBRXRLNm38zQhlRm1cYz0ff9Sx5CTk24xEBK+Lch/GlvTTPfIbj?=
 =?us-ascii?Q?7tgB66OC1Sz5QijS+6kq+2c1asnXtpZ3KUVhfA6aFdhZUWHZXx2HSRXVZg1D?=
X-MS-Exchange-AntiSpam-MessageData-1: xr0XfZuzxhx7gw==
X-OriginatorOrg: ebytelogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2cb598-8d26-425e-92bd-08df12636638
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:23:44.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 13bdb17c-4ae8-490c-90c1-ec8121ef96ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tibLIf2fkS+GGfxIHWKpQyOTI+12ES5hCbBkRgFY3TMCQ/5CdqZabEb8dVE1cb+p4gF5p1vqPc9sWeNUI3gOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNWP287MB6066

The CCI v2 standard-mode (100 kHz) timing table leaves SCL clock
stretching disabled, unlike the fast-plus table for the same block.
A slave that holds SCL low is then not waited for: the master keeps
its own clock timing and the transfer fails with a NACK or returns
corrupt data.

This is hit with a camera reached through a GMSL serializer/
deserializer I2C tunnel (MAX9296A/MAX96717 on the RB3 Gen2 vision
mezzanine). The deserializer acknowledges the address locally, but
forwards the transaction over the coax link and stretches SCL until
the remote side has completed it, which takes well over one clock
period at 100 kHz. Without stretching the register reads of the
sensor behind the link intermittently return garbage and writes are
dropped, which shows up as random sensor init failures.

Clock stretching is part of the I2C specification for every speed
mode and a device that does not stretch is unaffected by enabling it,
so enable it for standard mode as it already is for fast-plus.

Signed-off-by: Hitesh Patel <hitesh@ebytelogic.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 25b6e4e9e..327efa86f 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -723,7 +723,7 @@ static const struct cci_data cci_v2_data = {
 		.thd_dat = 22,
 		.thd_sta = 162,
 		.tbuf = 227,
-		.scl_stretch_en = 0,
+		.scl_stretch_en = 1,
 		.trdhld = 6,
 		.tsp = 3
 	},

base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
-- 
2.43.0

