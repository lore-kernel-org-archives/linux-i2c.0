Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011011.outbound.protection.outlook.com [40.107.74.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB33FFFB8;
	Thu,  6 Aug 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014658; cv=fail; b=EWNyiUYVKxTuoD4KPc8kTvTXoxEk02WFDF8YD//iJGdBtoEvTQLjOJ9aMuEXsHzzWnBvivI1f99TYAwcor5YW7PaYzq8PBdCTzaTFO4NodwyxXtK0NI5VPb28ET0FqgJmt603OcF4X2OGrqkwK4+GAjUfb/jR5MV1DIE+4NlyIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014658; c=relaxed/simple;
	bh=mYdHvD/kWH3+HSlRwFugp+eKHj1wFof5mZc6qsAm81o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F7LzIS0aQI8VCrSlqIQKbbATz/l19zepgyM3aiGbSNqAx+XPAjMmug628XO72yhtHp1TpqkliVRpw1w3k0G+Yobt8vC7OBH8V1bK63bZgTe7tMUtlgDmH8BU11pUqnQYwV/dsJ5JdWzA1TWmf3ryVmGBjT3Q7F1Mn6xeje/p9+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bJE+VHR7; arc=fail smtp.client-ip=40.107.74.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bJE+VHR7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BL20YAel6DrM8l4CUEEfrLNzPiQCjYglXci1JaTRBh0wgG3NpuUU3kJpxByOSrqzzVrGUeusgJ1ZYna6BLwmco6Xjxojp8NfWJHdolUnraIRRE2Q/kVN6ns9S786LZ6nOyttg93bjpq4c6gJ5JGkSkCqE4L/JMPrYM7TqWTIsz77pYdq8o5aYLPAYm5NwvhFhYmqSDnr+MLItZ9NrgF8Rh9B5ETXRD1VUnSE+bK8LP0r9ZnaJbJ56U7EQyNPAlVsSYeH33yVS8eLcgDUscSiP6DtaUuXfira6eaXhbovvyoEm97rdEAD2Pnhyeg1MMd8rlP9KpsYQzAda7xyJlma/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvX9bAwDkbLeA4bZMHNrZaVAgICEx4syfmHZE8pBrZw=;
 b=sO0iYYqABBwPBV+kmL3efNu7NlC2+p6dEF1mqoMFaV8G7jZV64ohKTDq+Y4drK7cQzAfLhJKb1MEDxueGnSax8VWAbi6d7o5Q1vXKK36i8tKIm9wF5Ddl+EPc3ssFnI7jsK3s4oHmm26pyuCEY66wM2HPCjVjgR5KEW5BgcO2Da+PDpd+VU0nmPZZnbFtDvWIgaJCOx9uDtvoST9RXbRq20aYgnyJL8KLF2viOTWF5pOIK0l0gfjQqPslAVihMMTpG04n3xPNm8ejPL/bjx6L0VtRDTu8lySyPTXCt84q8yEMoki8TfbB5gJ5py1bhVmdDSBh2JXVLNJB3Dt9JSR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvX9bAwDkbLeA4bZMHNrZaVAgICEx4syfmHZE8pBrZw=;
 b=bJE+VHR7L9ui+D1Wn3tZVRIDy3hzf+Mzp5e+WcnhD9i7NO67NfsuN8Zvz5rgXfHXNwRirbDnf7rTnar57Hm6g09e0Q0mbg8BIKLti6lrMwDbofnHut7SFjSy/IZpeuqnL3huXht3EC18GdE5LU8nZU5nEUAVLCNHzY9+YFsXrAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYRPR01MB13689.jpnprd01.prod.outlook.com (2603:1096:405:18f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 11:10:41 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 11:10:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Chris Brandt <chris.brandt@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: i2c: renesas,riic: Drop clock-frequency from required
Date: Thu,  6 Aug 2026 13:10:13 +0200
Message-ID: <20260806111018.782380-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYRPR01MB13689:EE_
X-MS-Office365-Filtering-Correlation-Id: dd203f1e-a540-4fea-acdf-08def3ab5a17
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|52116014|366016|38350700014|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	isC70DhZZD4Ra38IpuY+Ng8kHRqXh7Fe5PbnFDTdJpn/DccPNHnrtIjdaKDNt9i2aIJkziCkkj3sN3TVpumC/JN9RFO5qwcxXUiGrC+Anrx5hQ09QTX0tO5YUTWmcKOBEe+v7AbMmCKZ3A9jXGdzGQQsK2JqJCBjSeOC78KJQiB0MAmvn9VvGCDQveaur0JjMaWbmuJKxNuo1rjXEzAKu3Yo2cLhKzkFx++DA5erygkwLw3mRRxHGBPMb+VDfsfGmqdYEfXGk/FodpZfPd8+K9rQwiqVqvS2KSEprt4QUiM5DwJ6/SaGEHSQ0VGwu3vWUA5Ec2aobdT5oAouolyqdG5bPCu+yU7klWjw+PTAtpfNBy2wToZj9LwIcwUbQus9RIr15GRTvhUJw71ew7Q3SAfifWmRvb5zn9HErXM7oYalTpSX/3p5aS7sApnJFzw0dIAMD3HWeOgxIko+dMiwQICEu2O+qfZmua+C6XFOhQ0Gyzckm2a67D8VoLKSuEtCSJma038avCQBf6ozBWZ/uJGKZHNFyOFc/Tg1dkX63CN4bZW8XAwItwCfmitLzGIu83mcXcLfkbFs7eIA90nWg0cxa/Lq73NQck0Vu59x18mh6MyjU/Ws/Ceaoi7LI7qPmECvLo/JTJfUvT30y/HsDVb+4hQW70KQCfSXuI9q2DOrh2C2/VmuRocpW1iUmTbMb8SlV4id+e7VyrLVFVsq1v58znTOeLpB5CWe7J/lMdc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(52116014)(366016)(38350700014)(56012099006)(10067099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w4DHl05t3EeF5WpcmyjIpwSd6wIMAcjp5RaBYrwqQ9sgxcrpyaLba5dMZsag?=
 =?us-ascii?Q?xYqU+lP2UxkjaxXESaHmvsa2EAP1YdfTESJRsSkEuJg9dC76wh8uOc8jnAZF?=
 =?us-ascii?Q?COepFUXKFQ/VTUpw24Mw2NeymlJlUh8pUVd51/bZmU4VxQrxJDsrGXH8CaSo?=
 =?us-ascii?Q?b25jJA1jfb6LkkcUhGY84gILcNQRVu2R/Kzwf7wMZjy5Nc2Ef14bap2ixLRm?=
 =?us-ascii?Q?z4jNdnNjFtwZsyghle+8AFnbRmnIxye4fugGBWLD+BJh5U6hyl0Dtpc4IDvs?=
 =?us-ascii?Q?3pXFPnnRNzXkakFCB2nQSQL9NFehF/7qaKhzszj8isEDIGfBoClgkjAhGbB1?=
 =?us-ascii?Q?m1y71k8p9ycv+FVUolMFioyUxaqHD0HAu49tScSMnuiFzpVBalS+lIlRP8Yy?=
 =?us-ascii?Q?yxL5k06DLgUOJBRRY9OPQTgbYMckhfddlhpvC4yGmfTjckNsC1dhrFsU3bFp?=
 =?us-ascii?Q?nZpviCH66VCoWiUXIfJvSs2Hs6woQjkuU3JRIEupiopRdxToz6LJWQz4OzNc?=
 =?us-ascii?Q?JTc3ETqeKUynWxDXWbAJ+M43lw+7zHZxNKy6nkGriY9nWgDqXfAJl8Y3v30x?=
 =?us-ascii?Q?MRnMrmSpQErXGtSPhWcvinCBZdRwf+DpEhEjxKN6En4v20k0klEiMrMxH831?=
 =?us-ascii?Q?h2dsi6Oqo5lAyhfAFT71P6Z0XIECltfnuD/VvOsf17q8pyDXlOpojulw3XhD?=
 =?us-ascii?Q?3WwFP6HheMchFbBCq4/vTzmBWgzz4DUub64uY3wng9vW9u1KfReplwf3C8RQ?=
 =?us-ascii?Q?pCQGuqzvvoQ/Pat32V9hF7QWPBZ4gxh0dW4l800k76qiAqArLw8mRnEqxDe/?=
 =?us-ascii?Q?slxEsFW/EtzUl+fLpmwRTsA4cKIlMCbc301wAMsOd+vV/EC2NERp4Jx4cgS1?=
 =?us-ascii?Q?BKyDEUwA/EIDgCpyylsIrKX9GiJbz4r1Keo5j3wncHScRXYVYDXSDBp1J8K4?=
 =?us-ascii?Q?cXEuGd7CgODkXdFGINX2KjnDvYK314+jhpzPxA6+0CRwKW1IQMsQ9VAWw+Jr?=
 =?us-ascii?Q?o7EmCVSVBFtNLutgbYFfsfAzU3m4u83tXEcwdUnjnRj5tTI14cypvZ6Ua0uF?=
 =?us-ascii?Q?9qwSMar4kcP6axT5S8O5qFxy6pHLQ5pPNPRF81YuItfl9hkPlNVcfML/7RVC?=
 =?us-ascii?Q?+zRslThpI3a3EocTAJVk2Ql5oVGh8FtR8l05cW9F1L0nRUhBwttjemONf1OB?=
 =?us-ascii?Q?Q+C1gVYvqxyzMvfPbISe0dH14P+otFfVKQ7zKPDiFXc5iCbn09MrDvzywtb9?=
 =?us-ascii?Q?fanPb/ngJ2EQNyRFJF8mdaBg1uQKfqB3lFXsFkDLNG47h7TV1gauNXNeCsWM?=
 =?us-ascii?Q?R2X95LZxCG4gqHEEALn3hyjtPnu6nY5lxEFHTCg2fK+tyXj18VWwbHN3Q/6t?=
 =?us-ascii?Q?PzEbymmfW91r0SN+iaVOrDJw0mibkZwhayM2A1tfRnvB5V7gmuPoRqu/FpJd?=
 =?us-ascii?Q?ZRWREIitD3w70aRgxnoQkhn2pniE3ZVakZib0cPu+LOLBsdVCGywC6iFpZNK?=
 =?us-ascii?Q?HFIMlcxE3tuTZmYMFeKDgUDbAxms0PE3BD0yIXoe07m4wHgjo5vIC9deQcrX?=
 =?us-ascii?Q?Y2G6XpajpMsHIcXDkaX1NH4aCa1HGnVwUCq+CxQYSFVJGik+zHfFTm6Uz1SQ?=
 =?us-ascii?Q?UsOqMl78msYr1eaFRvDuUwp4vb6UmOxoXegzQMY06V53xEqjiFIdTuG1qwTN?=
 =?us-ascii?Q?ck+QQL6rp+rZRP/y4Jh9Do0C0VZJDdGCUZUPhVxZgRJfNlMNQ5mqkHM4yAn8?=
 =?us-ascii?Q?QgXVcRvNmrPxv4jhg2zdLdv9AfUcDAMVmOrUU/UzOPutxcfYPNxs?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd203f1e-a540-4fea-acdf-08def3ab5a17
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:10:41.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mck07ooz4CB6FFijgrYvqceF7PmRRLGxKcifClJ9KcXrS7bQNScVaHYf23MotCxRBqXmdzp1YfzRry4YzXu7JBoDiODGKhPeoKWg7mKw2aiwYdMfJurW6gjjKmgswV/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13689

clock-frequency is described as optional, with 100 kHz assumed when
absent, yet it is also listed as required.

The description is correct: i2c-riic calls i2c_parse_fw_timings() with
use_defaults set, so the core falls back to I2C_MAX_STANDARD_MODE_FREQ
when the property is absent.

The stale requirement only produces dtbs_check noise on boards relying
on the default:

  i2c@14400800 (renesas,riic-r9a09g047): 'clock-frequency' is a
  required property

Drop it.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v1->v2:
 - Dropped all v1 series, need a rework.
 - Fixed dtbs_check failure by dropping clock-frequency from the required list,
   instead of adding it to the dts, as the absence of this property
   indicates the default frequency 100 kHz.
   v1: https://lore.kernel.org/all/20260803132828.3249424-3-tommaso.merciai.xr@bp.renesas.com/

 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index ae1f71eadc66..c5d07b722c43 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -95,7 +95,6 @@ required:
   - interrupts
   - interrupt-names
   - clocks
-  - clock-frequency
   - power-domains
   - '#address-cells'
   - '#size-cells'
-- 
2.54.0

