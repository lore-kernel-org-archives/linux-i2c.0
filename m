Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021112.outbound.protection.outlook.com [52.101.62.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C838BF63;
	Fri, 12 Jun 2026 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228296; cv=fail; b=HMh2IH+VFIGEZkPE99zBrX6Uzwg6evjQJ10A37kw5Fzu+3q5/ow00/yL98lV+NSmU9kqHopyfBVCzqey/2WZQeXKsiYsMwsHDtz1P2/cSVznrukyWQE1XtIupsLj9onfhdCopilBLgImLj2UVss0HhzLQPYjwnHVaB7oaeG5j6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228296; c=relaxed/simple;
	bh=UyaRAQHRfmV9Z7uqh96J0m7ie9XoNQbFHtiQmWF92vI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FEtEIiu+Q3JTyQfo9FgyUCt3M82iO9TrSTb/tGJbFsvoq0b5tKQ2Y0JquNZfkrbVgpEHpxRtqlrG/FHv691TH0e8TsXYOc/CBnonLPMjvI+/PcTnKFdjiWjqjLNoX2Dmh1cfjz/5L+KOWurcEXstfSjc8eUHXz6gQBS+8xN79WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=PGRpYbNr; arc=fail smtp.client-ip=52.101.62.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="PGRpYbNr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sY1x5ZyEzKZ7ak8X5A8+fYlva8Mz+dBtMzpYaH46unVYJCrx8DL3dGzPe76RBOvT45gntXayvYBK63yBHwAPKf063BhhF/EKTVBw2pusWm4TvQA3uO8rrgYCiDTz9lflrndfa1HGwxIcYNy/Xt0KmauhMCEvljm/HgJyKZvOv1hvjZnCNbA2i9vAk7JVJ/WB27NbtepQ+fPokOxYUe7nNuJHpUj1Q1sR2qJHN6BkFpSLkhrHDiPlmRSU/zwdeKkGP9iD1vAE30JRi5eYF5Bjyc/tUR6iJkiF0KtPA4AGnufwDF5gSvIunvmsmJseeDzcQ1PrqSyDrzFY7cGNf9OHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVdKBnOcxJyOU9ghZ9neO31ST14zAyF4JJ3CLzvFiKM=;
 b=REBX3mDFI3CYWZs3ApjV+hy2r2bYcBmpfOZ3bdIjyAV1WQTuVaLp+ok0Ft1RTQ9zNHgSXFHdIcKIZ76BUq4wGKgvIU1C2UAq4fpdQXNadJKXJdCO1P/GKs5NlbPBLHBtVrEIzogz2sJDe5qUg2mDgc+W5k6CrjD9bMVxMSYREumbp/FyRGDlFWE1j18ZQtN5mP8a5PGSQtWmsPuB4dyNdmGYnWxGkFMOWOADztl/Y+ArxdrCHA3o8L4UkL5PkJ0zWBOp01dzih54/8uRnrM3CPKRyS+ZfT36cCpbpZ9yQxdg8l7WrEomQeiAze704f9QqPnAF8iaPzayDMBQM675TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=amd.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVdKBnOcxJyOU9ghZ9neO31ST14zAyF4JJ3CLzvFiKM=;
 b=PGRpYbNr28rxpSiXmwa+PryPi6wQzzC1lq88p5VHVy0UUvN/H/YNPIwkC2y38jkrfbV1QwjMRES1Jt2QRTZir3Dxl/MxjR8OX/BiNdm0f2x4ciBNXtIbmaawGs/jkclQcyTol9f7ihjHT67x6ibKZNAtmfq/4R3s1LjZYBQCQPDP3ytl0j5utDbHELonPqcj+6yHiCfVkCFRizyhuOZ7AAoO4yCuRakH66CxU/l867fSSvtYMEwimKJ2qaSVjklAsUghUfw1LEazt2WI8EETUbqnz2e0hnb5ZVfgFbEjcS0/lO1C8lgJkf4p/kub8F/u+AxvYN6EIluhxD0O2k8A5w==
Received: from DM6PR08CA0047.namprd08.prod.outlook.com (2603:10b6:5:1e0::21)
 by SN7PR18MB3967.namprd18.prod.outlook.com (2603:10b6:806:107::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 01:38:11 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::16) by DM6PR08CA0047.outlook.office365.com
 (2603:10b6:5:1e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 01:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Fri, 12 Jun 2026 01:38:10 +0000
Received: from [127.0.0.1] (unknown [10.4.1.181])
	by smtp.corp.axiado.com (Postfix) with ESMTPS id D24814186B51;
	Thu, 11 Jun 2026 18:35:35 -0700 (PDT)
From: Swark Yang <syang@axiado.com>
Subject: [PATCH RESEND v2 0/2] i2c: cadence: Add support for Axiado AX3000
Date: Thu, 11 Jun 2026 18:37:28 -0700
Message-Id: <20260611-axiado-ax3000-cadence-i2c-support-v2-0-cfdad0534afa@axiado.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANhiK2oC/42Nuw6CMBSGX4Wc2ZrTAjY6OcjqoKNh6OUgHaSkR
 YIhvLtNfQGnP99/Lt8KkYKjCKdihUCzi84PCcSuANOr4UnM2cQgUByQc87U4pT1KUpEZEZZGkx
 aEobF9zj6MLG6JMO51BplBenPGKhzS3Y84Nbcm+sF2tT3Lk4+fLJ65nmaLTVWf1hmzpAdJVnRW
 YNa6vPvZm/8C9pt275w6SEh2wAAAA==
X-Change-ID: 20260111-axiado-ax3000-cadence-i2c-support-53ec117bb074
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Swark Yang <syang@axiado.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=syang@axiado.com;
 h=from:subject:message-id; bh=UyaRAQHRfmV9Z7uqh96J0m7ie9XoNQbFHtiQmWF92vI=;
 b=owGbwMvMwCHWlWK8+EozbyzjabUkhiztpM9yUtOTnFKKGzcmX9BavLqt+2n4RrvagOq11/p3W
 E6PrizpKGVhEONgkBVTZPmq8y3/ZK72vc69K0th5rAygQxh4OIUgInsPsjIcFaxd+erDP8Hs3/y
 2IpM2WdgI/Dgbeh791+h7wxlW6UsVjMyTDKZZsO3+1sA84+wKR8EY/8xnEgIby1pUarkmx0bYLa
 OCwA=
X-Developer-Key: i=syang@axiado.com; a=openpgp;
 fpr=F52CF66FC96D2BDE89BDA9758A6433A3D4830D5D
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SN7PR18MB3967:EE_
X-MS-Office365-Filtering-Correlation-Id: 70029115-4439-4224-9c21-08dec82342b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|56012099006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	09IPJY+jLztvyTYE6THvGx/9TBOE7xD2IyyyrKyZSKz12Xl3vO3z9vIityQF0fL/7J6pQvdYVH773f5xeCJkwJXiE9gQZVV6DFziy4TPTYE+PEMcV9zAdyX+I2tt3Dgs9M0Fg4rgbl0pSnRgYJlYnc3XBcJhmt6gJ1/GmxXvmo2fkNF+1NYWdPgxVSx/t97dDTlfMz+yvwGGlKz6PLwnPtWi54JSUMmmlxhUvTuJ+Ic73xqkzjfrMiCKvczDkHmKjYQ16PMJrYDP5WYg7rgB1+2IqNqJ7LnKkecCZf9ifrE+ogCdkQ5JLWZdvbGpfVgYK/g0IcWbAU/v/A6y3NL3aqQM3jjvcZL5Ja+YHQpAdyiJ5zRnhHMuRXZK0aQiSItyem249J0jwl9DSTzzrkx9eVl1ftC/zGjczNJ7HE29xmpLjumdNGA4oVOU5YvIldKntncCkAQMwtUg9FysUuiD8Zp9DtpmGpgfaoUc7l+gVG29vPjnpgqOxOUzeT1VvXFh7MohMJ3A2GkKowZc9Alin/e+jXMDAD1hIrj3sh+lGPErgwptD1nH6sU41+yfQeYb02P3ePUwZjcfemoN6/eLnJf4tDaYRZNp4K98AeJIuV+qIXjNFyiYdcbbEfO8JF6Df6cJXVquUEeXCYVJj+4ddEhvMghDJqFUFRff2fOYyIhCeFFeu9ZvKYzul9fxCYRCY4S3JG7SOdvVFJLqdKlhYmNrdBJbS4+8uY1a9nJ6Vls=
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(56012099006)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/2UOhvoBNQMdupPnJIpN0mjp3QL3K6Hrsywoj2azA/0O+6q9oNfEHKAaDzGfw4jYh+XXQsQirPE8lubNQrMDx+ATj/KWF+OY4wjSRQ8KZTXc+7LoZVr7ggnFd0ThqW1NIE6OqzB8R65QoJET+Z2rKsI4smPXau5+Z4QMjbS3nzcXB++5aeLsHzxtYu7P8sGto7GPgo8+XG0srKZLKhEx6+ht8apHxOayHDE/peBImpQ0Ar5Vh95Np9PDEUA8lV98iICTeFNWzSqK6w1lzb0GX57qgFqZwlF7USywBgswKYlPh5P5lmkOUSqMI8FuWDJqWT0/A0CYynSSVaaoRZc5NY+jmGqdTsvP3ExzNoG5u+2AvTKG3ptZrUIDJSeJoK9BDFWs2Vswcxad+NbwHBSo+zJy1/jQblkJcxgQ9JSILtJBqB2Gh7M3o6zZ853C2X0M
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:38:10.1058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70029115-4439-4224-9c21-08dec82342b8
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3967

This patch series adds support for the Cadence I2C controller
integrated into the Axiado AX3000 SoC and enables SMBus Quick
command functionality.

The Axiado AX3000 utilizes the Cadence I2C IP core (version r1p14).
While it is largely compatible with the existing i2c-cadence
driver logic, the AX3000 hardware specifically supports SMBus Quick
commands. This feature is currently disabled by default in the
i2c-cadence driver (masked out from I2C_FUNC_SMBUS_EMUL).

To enable this functionality, this series introduces a new
platform-specific quirk (CDNS_I2C_QUIRK_SMBUS_QUICK) and uses driver
match data for the "axiado,ax3000-i2c" compatible string. This allows
tools like 'i2cdetect' to properly scan the bus using quick write
commands.

The DT binding update follows the recommended fallback structure,
referencing the 'cdns,i2c-r1p14' fallback to ensure compatibility with
older kernels while allowing the new quirk to be enabled on AX3000.

Changes in RESEND:
- Resending as the original submission seems to have slipped through the cracks.
- No code changes since the original submission.
- Collected Conor Dooley's Acked-by for Patch 1.

Patch breakdown:

Patch 1: dt-bindings: i2c: cadence: Add Axiado AX3000
Patch 2: i2c: cadence: Add support for Axiado AX3000

These patches are expected to go via the I2C subsystem tree.

Feedback is welcome.

Signed-off-by: Swark Yang <syang@axiado.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20260504-axiado-ax3000-cadence-i2c-support-v1-0-97ed2fdc0b7b@axiado.com

---
Swark Yang (2):
      dt-bindings: i2c: cadence: Add Axiado AX3000
      i2c: cadence: Add support for Axiado AX3000

 Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml | 10 +++++++---
 drivers/i2c/busses/i2c-cadence.c                          | 10 ++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260111-axiado-ax3000-cadence-i2c-support-53ec117bb074

Best regards,
-- 
Swark Yang <syang@axiado.com>

