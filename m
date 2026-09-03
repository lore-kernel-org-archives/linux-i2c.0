Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352714FDE78;
	Thu,  3 Sep 2026 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463262; cv=fail; b=HLr5bc/Q+LjrBSFavcgLgP8LuuzI/KI8Q+OgcDe8bjOTTvDACeZWvfQdtPvYxeu3TN4Z7A3u8+0e/jF3TzvkPwj0mHweNSa/wmwaUIESiBIeZEqs8/Dr2b3OpXwxJVFKsQS/T67gL5afkkCt7F4otddiZzeiLUTHQvr72y3mC4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463262; c=relaxed/simple;
	bh=N/W+cXX226yRQ6AAFy7qHlzmFmSSWLEGu9tatimo/mc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jnxLjYp46I1rTmnyFYQtTNzY6Dd59+WUcpwP9nf2KgELQv6Gwj+LQU89Po7tovrdgEmVRJ4Eo3KcWt0JWEXi+VtnJsQhdClvPOZ2R+CaBRrAczQ2WNPI3HSwjRuv6i2de//p8ZWO8yK9fjrir5uQGR86sR8SfMKxwjj3W8Icb/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImtyZwwJ; arc=fail smtp.client-ip=40.93.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImtyZwwJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy8oqLiP8znW7NVshee1SZc86hk1hJS7nuV88YNbiTOHv47W6twX8Hw/cznqR9eSyNeQgLtetkOhy4OP1bSUwy8/O9B/QoXOj+dJtCPtJpG3YJPTXY3aQ8TWx3U7SbotjqyrCtraP9+DeYBc4/x2jPhu2EmTcZtte9IF7jkWL0NOJtXbTIs8RpILZ1NXWjF4jurU0qGG2Nu5hycYv7dblnMxNAJKp8VOWFm8yRFr8ZED7y3awYb6VzWzbakwngo0ZhdONmtL+/xXNA7/YyV9utn+5AHb3yxXtBVKMMGW+Sbnbvi/S8wZbQjxn9EPPkx7qJuCqsjMgs6mVCH5A5usUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwHGk7TKfV8jRU3EpYGchM0ZfVD7zXzcI+VLdthb00M=;
 b=ox4sZJ6uKOdHcFudXA/MnLgP+tDwCITk7rP+aoGhRvLvGOeubq0n4PaskGXyYkTCiMfn2XkHakH2N8kNYCcT69LICbYIoPzKKqK+Yuux65Mzkm1gJvSaYKH5CX3DLeqgFw+5E3mS+TI6B0atQkm6OcXGelkYT17MELhUSZBgdYlA+P9JHA8ffaboHTHrPO3KPwTwI7H9jtyh3aJYrHG0wKwhhHja+v+ABICI8mu9Nm4OQHtIuaz/5+RKisOzTCOyxzkGBKahzQUnDq38Pr0OVy/kj2myU+f243WVYT+D9S8cWU4SdSYPtHbgxs1rfyHtjr4cVB8VBfh1IFG+UTvK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwHGk7TKfV8jRU3EpYGchM0ZfVD7zXzcI+VLdthb00M=;
 b=ImtyZwwJJnk6LFj2ijLvia1Kc15TcRPWwsjJhjMbo1TtIfFMfJOobx8pQmDsVgPz0PzY1kmpZFUO7NjZbMarMbwQN/Brxmufb7of1H24rdadW9H9doBYFYWUpFftOWdDCMbLKH9Tvg67EjkIEoIsBFk/Dy+6cO5TZMGl4QkaGVa9i//16NE17pSwA6yfw7v0aEYd3hwubuQNuYHaSrA2foLCcSRixe5fJWi4eg0Yxk4wV3/ilimdKBcD4+qGarwxXNxy0Azi8MAZOoBPnDqrVDeEPeriT9Hx4Z7B2Xx4vp525Q9EcVJ+2a7Vl1712d7L6zPnMBLOaGc18V9JEkMEtQ==
Received: from CH2PR10CA0007.namprd10.prod.outlook.com (2603:10b6:610:4c::17)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 19:20:47 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::6a) by CH2PR10CA0007.outlook.office365.com
 (2603:10b6:610:4c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu, 3
 Sep 2026 19:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 19:20:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:16 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:20:15 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <andi.shyti@kernel.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH v1 0/3] i2c: mlxbf: Fix master GW corruption
Date: Thu, 3 Sep 2026 15:19:58 -0400
Message-ID: <20260903192001.114263-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 75eafb68-6772-4303-231b-08df09f074ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cNF0/8eL4Ykbquy4bSnEAzAoQnB3ebwAX3EmOZkcAvtkqnxRH6E5nyj7r00/x1A+1KZEFf/T6rnIAC2BgIamdUwmilWvbCTlc7ZCYQFjnyqnn1CBBTzt3ba1CLTJgEeulkZ+mJxcW4/DvGnFVxyXeRg7V+auRQ8e5ye0+nWl8Z7wNZ84XOhFx7zqFgWbpmUjxz1JNf10siMfIzwUyYbJhhUSeprXB5HLLlSdh20feBpBGTPp+aab1cmWb1NrZj3RXcsUL0XXHbIcw2Kiw6Qvxn6HU0BF8pIkHOLWZsCT48yxzezq18vxECZkqrDQbTtkDUCilBSP9QbQIL2ViLDoHSalupKC5vZNP0iRxGykC+qs5egST4dhd0otpKuYCFr/7h1yxT7hcfJYrf1CefTWmeE2zNDF3C0WjB28LPoCDnRC7Ya8mYUsxvU4WSDpu4tEm1mlpECAIbl/EViK+6M3CB+VnI8ioDeWDBRJPyShkE/ORrlvNjR+aNT7wte330vn7RRlg72zkVOossiFlD3Sw+9BxWYyLBNLET2b6+NveGS2exzYBHukEQNcZoMWrV040akbWhV/snqwRnWOWE95zbPBm8h/Kum7C384crygXyC7ikfpLm8vdqteWI+f9dyapoLhXEgqRfxZlnRGXR3CZ5OopeTz820hw0ACRHiM5qXHzt4TZggygqfiYfJxaXvltkK9a+cSfMRpJYdM2pi81A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a3gryaYL0aGVOreR/fNVJ9YunZG9geiER4iVo+NyqlX72zs0kYZnsj5fXIY8I46zXMXzvVbtO8oKq7ZHeG4HBlevzzIeLr5YvF8dGYnGXrY58jcq8Smsq+hlqJ5e0yWbQUL5ZxAPaOiyF9b1XAT4tOvIwN3GXyRLFw/Lp3i+g0KTxdQoE4utCyq3SmQH0pdmRXeSJAmsIid03E9vpDeNOscBV4BSJOfDv9b3yNE5Mxt/+tWOf9wmu/bkGiTwQuEl9JtdFJQzzG6X15MNthfkXxo6ukZ+Gf4nCf4wUIS2zGMxUHuN41psxNVTOwF5yVvBcfigzXbAYJGxnub+dZCVFyY1rPYKcDdabXqDeNGkVu6V6DZDVp5uCAG8AptvC3IiDMgVIPbmHnji5r9g4dEuqkF6DiqEf2qFgz9FH7xVKiFImaV3yYnMon58Ayqd7WFD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 19:20:46.6784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75eafb68-6772-4303-231b-08df09f074ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

This patch series fixes a bug that corrupts the slave address used in read
phases and cleans up the code to prevent similar corruption scenarios from
occurring in the future.

When the MLXBF_I2C_F_SMBUS_BLOCK and/or MLXBF_I2C_F_SMBUS_PEC flags are set, the
flag bitmask values are shifted and written to the master gateway control
register instead of the single-bit flag values. This caused slave address
corruption in read phases (unlike write phases which use the data_desc[0] slave
address value).

Patch 1 fixes this corruption issue by converting the flags to booleans before
setting their values in the control register.

Patch 2 converts register field accesses from explicit shifts to
BIT()/GENMASK()/FIELD_PREP().

Patch 3 removes an unnecessary register write (dead code).

Chris Babroski (3):
  i2c: mlxbf: Fix master GW corruption from unmasked SMBus flags
  i2c: mlxbf: Use GENMASK()/FIELD_PREP() for GW fields
  i2c: mlxbf: Remove unused slave GW PEC handling

 drivers/i2c/busses/i2c-mlxbf.c | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

-- 
2.34.1

