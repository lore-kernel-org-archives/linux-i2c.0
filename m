Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6738399F;
	Thu, 21 May 2026 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335983; cv=fail; b=fTptpOKgS+ebUY2DbQQGuNXuZs56i2tp9gtZT23XhkF0XdyZBavtAByZ6qPZbWJWKqzkKT9CZ78IJ/a0FQ6VOccxYQSgcQ1/pQdgde4fV/NKe0jZBGwLW93WxVwyRvd6DSdMvRJ3UNSEIZ0Nnj3pIPZfXLzXqBVbkVk4YxMOc+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335983; c=relaxed/simple;
	bh=Ime/iVxyreNrmmq8L5FkjOGC/kE/1ST++c603yGJGJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fz7kVTJ9vwf1F+0d+qp4NqezUVUMh/EZV597vOs3uHZeIoha+RxSntp3RL1nhrH0cvyNDM8zBnfq6aBB7NkX1O6eyE8XcxUBOuFQBgB0Rw4jIDIVUtNQVBc9qLgyLGEnvLNf/Is5cLfJlQtYTVU3ZrnpQCvBrw8uy3Rb4en7GJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdhYLjqnajJnBWB6pgsd0JHRsaoTkhtuE3PfOWwwnEkZQIrPdvXRXUFfI3BVJCf8NttvqdkatgpbfKj1MkQHPRqPxubqQ6BPrejhE2MIHCf6ZCoOTwIastcrKQaZ75T2mcYskldZNdn0tYeynzMV5smugZTd4AbUfUL8SjhQBuUI+PUZaGYORQD7HhOnpaahxEqEIE+MbCTZlVO6RYSpmR604Wvy4QcL7GHCWXFqBKLw9PjALfUbbJWZAFmX9Dfk9EPD9RBDKlZ1nMYQ/NnWU5r98fwreAiTJBwI2lV4t6uwcc/CKcNWdgLjsOzXwqU3v16IJlcBj2Jklh5Y3X43iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H68npBjcO7KUiLt4Wkw43hLgiDAUomsW/plEjCwAlPo=;
 b=IcR6Vy5bLglVTNyvy1l4Ha5/SRHqF4P6F5jqRrJuiFt6GYUw8zzoFce/Yh543v5guFAA/qK89rF8qAelK8shSUp2AYA5q3/gWv97xP/CPABqThiw/m3nfhwW5IRuQ0ocnrfg/eoa8o+H591zePfOkK/21zZX9c1UcebEK7505dApoJPIykYXd6Ii2V0Fxi7Y9DWVgNgihxhXdYBVoImDEkif6+Ju+/Kp7d3gtdF6Zl/+rkrqvMI+OJaszSGbFMEUj2NxKSLLn4sktiEpNLbnZKxIlXCYT+MCEBbohNG66xGzQs0VnaIilfca2SPWCKqen9DrSreucVfV9e3LDBDAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 03:43:47 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 03:43:47 +0000
From: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Subject: [PATCH v1 0/3] i2c: dwc: Add I2C DWC master/slave support for StarFive JHB100
Date: Thu, 21 May 2026 11:43:37 +0800
Message-Id: <20260521034340.27837-1-lianfeng.ouyang@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1302:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e976437-5f35-424c-a422-08deb6eb2a1b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|18002099003|56012099003|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	NLBuiDqtBJeuGwkwaq0OivqJ6zqd+p8h8Z+YA4LOUWu7A+omyB0q3BTelx8arc92gG/REPFOhkthbAmoHH5JNN1icnS1WDsHBQa6SVXlPhb/yQdQDCpwOdp3nLpAURRf1yGg/C56WU6e6jdHmz9HtKYISXcj+eAbFbt5r2QnYdLtYtPemaVnstupshxA6C462VsIjKvxs+fNMdDN6MbJlU5gbEXVZniWSnFk5s5VUb7kvsMiqOx6BpoCtHRRMO6un6Lv/toVIDoSF230c7Vr7lZfsTtdILcbdi7x7GQi7AprkJMa5mX7HgqQuoZ+9XFL8MNHOdAlm7FkZmb849g0MARZ/G47khU7/vEEpOjctQsFsgox5yCMyW0ajFmnkDPOvGscjIBA7F0RiatwGLlIj49P6x5BOP3WPuc/eBn4kXt59zOy3icFEWtN+SMPQN4uHhSyvmwRxa6M/nADVIYGNh4erRMusCevxyAgYB06Xz71Ia05J/Jhm2RKSHL9pLv+updgEBeT3N1Kl88VhMOJbRLznhYDlwNl8jINjJ4nqk5a6X4Fquz7sQUTf3gKR+xU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(18002099003)(56012099003)(38350700014)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnhUa3RuY3NQQ1VHV1lNSjNJY3d6TFJvcWMxbjRQaWkySlRxaFY5c2FUamZK?=
 =?utf-8?B?TVNUVWgraS9IQ29HQkpSOEhQc2J6NU50MkY3V09waVAvcG9oT3hOb21pY1d1?=
 =?utf-8?B?clBzSUN2OXhYTUZYTFlTcXAwT3RjNndBbFAvM3hhOFE2WnFlVXJjK3JUblpn?=
 =?utf-8?B?aUk5UW4ydWhVb1FWcThKeHhZckVNT0dlcUJIZCswa1NEQ1hyOW1YSFVyV3Ra?=
 =?utf-8?B?WGhxZFZ4VnJJcHFpcEE2Q0VSYy9yZTVUM3FsTDRNajE2UGxkeEtJSzNlUUtk?=
 =?utf-8?B?Z0d6TUx2NUpCZTkvdXkyeEkxaHNuQU5BZGdGQXdreDFsTld2YVdrS05pekxP?=
 =?utf-8?B?Z05lcHFKb05PSzd3UXVCb2EvWWxBalF0cTVsNk5UcCs1K3NNZktNbG96U3pq?=
 =?utf-8?B?QnpUUjVwV29sQWkrc1AxQ1VWRHd1MkRreGJtYWRsM1B2RzMzUW1YNW9WYnR6?=
 =?utf-8?B?U0NzeEEvdTRiRjRDNzRnYWdrZmc5MGZZYkFmQzNybnJyZWNjalpuTEJNZ2NC?=
 =?utf-8?B?L2hxd1h4NEY4SjNtb2xtaTBmZldnbDh5SGhvQUkyTkZDSWRNb2tPczdFa01n?=
 =?utf-8?B?cnRNRWJxekNvdUVNM3dhTk1IUnBxNXdwMnk3cWVQcnpkOWpkVmxIZDZMNmMx?=
 =?utf-8?B?dHlTKy90Mlc2S0VpMGVtNXFQRG1jdGsxMDdkQkF1cTRncU1qWTdBMTA0NFV0?=
 =?utf-8?B?dmZYdXU2RnQ3TElBNnlvNDR1TVpqMmhTVlNVdllOZlkwNEc5MEJOb1JOMDVD?=
 =?utf-8?B?Sm5Wdkk0cGM5bXlYSDh5TU5XeExlbzBiK1pya0R1OVVsUms4a0dXL0FzeU1W?=
 =?utf-8?B?Sy9nZjUzQklaTDBIVGFOdWlDbHZwQnJncnNtUXk0N2YwaUJ3NVQ0U1F3RG00?=
 =?utf-8?B?czhRUWwyYTNFNEtQMDBlOVJZZWVBY1Uwek1iUjJEZyt3SzF3azFxQ3QxUVFS?=
 =?utf-8?B?MkFNTXg2LzMyZDltZ0tZK2dKN1pzcTh4K0V6MGxyeUsrUHJvbmUyQ05nR25S?=
 =?utf-8?B?YkVFTDhJa3ZUMmxWSFlnYzE5L081dUt4Q2llMXV2eEMwWDl4Z3E2NCtMbTFq?=
 =?utf-8?B?TWNtZFhGUDQ3N3Z3MTN6eDZUVUZEQzNTQ0R6cjd2SjNOWVVTL2VBb25oZENo?=
 =?utf-8?B?RExjOGZRaGI5YklRcmVWa0gvWTEzOHhvcVpWSlRBSGVFVXdDdHkwa2hSNDhl?=
 =?utf-8?B?WTJMYzlnR2w2c3NyUTJKL3VZS25SUTF4STVaV0dqWGl5eVpIa0U5OVpDK1NH?=
 =?utf-8?B?QVZSZm13c3dBbzk2Zzg1cUhka3ZpcjQzamwvUDM2akVLTUkzb0VQcDBPYnh2?=
 =?utf-8?B?ZVdYZkdIcEVQelJKeGt5VUx3RG0wMS9PaERDb2loV0xPM2JQUTVJMkcrS0dl?=
 =?utf-8?B?NWk2Zm9oaEtod1V0cEdGRTB6VGgzUVNHR2JsaFRCVDltRy9tZk1hVHh1MTV1?=
 =?utf-8?B?a1VnRDIrclBMdHRhZnBSUmVCaEhRZCtmeEwyNGJtbURKQ0pGcW1LV25Hb1ph?=
 =?utf-8?B?YXRSRnFTVGRCSTZyRXVVTFhNVG5nd0ZaT1FFK1lWK0ZocHp1ZVlWU1ZUckdG?=
 =?utf-8?B?Rk5zbm1oQVFBMnFTNzhFRFhUakJvOWU3bXloTFJoYlJOWWZwMXJmSklFQlVp?=
 =?utf-8?B?a2JYK3g2MW5xWWNGcHZYZWEyT1dVUDhVQkdybXc5Y0xRYXVvTytPdFBjR0tZ?=
 =?utf-8?B?Skh2QUYxYVg2bktBdllIOXZBTmo1TSsxc3JyQW53anI5Y29xYklvNVNaRStC?=
 =?utf-8?B?VHVCRjd2RDZONVV6N1lKVWs1Q05aUDZCWFUyTDlacU1ZQmUvODErSUxvZE9O?=
 =?utf-8?B?WG9IcG9NQlFTbVdqNVljU1graUtidUhWZExNbmo5b1lwTTFpcWNhaUhibVJs?=
 =?utf-8?B?elk1c1Jyd3VlZDZHeGtDMlIxR0hoQW1FT0d6OEtVUjlUc01Ra0xIRmJoeC8v?=
 =?utf-8?B?WVUvQ0dPMDVpK3NuQVJQR29rbnlyeFZLK3RZVVpCV0hnTWxURjFmRkhCcWdJ?=
 =?utf-8?B?L0tzSlhPd2ordmdvbkI3bmJWYm9Zb1hxVVY1MlFCeXBaWFNINUZaak1pTVhL?=
 =?utf-8?B?aTBWSzFSN1RKNGdvM3BiUmpEeExPZVhCVlRzeldjdEVWaFYxRDRBNGdJdExu?=
 =?utf-8?B?ajZFd01qZ0U1SHFic3ZlUFhzTEwwQ1FaN0tpREVEanlTMnNtZXFNQVlsMDhn?=
 =?utf-8?B?MVQ1Tnc0TEt2RzVaZEpvWUtOY1hEZUFGSFhQUE1yMVJxUHpVRDA1VUEwaitr?=
 =?utf-8?B?NUk5WFpFT3dtZW5aV21DT0tEaEs1NmhmNTlpV0JuTCt1RGZTck1ZbWJJMERk?=
 =?utf-8?B?S1VmNkgybkdGWXhyc0NPWi85aVhXbTBydzdNdVFFbzlIK1VCYVU0SWU5ZDl2?=
 =?utf-8?Q?vnT/afZOqIa71FYaV0QREjo7FRJdEElTH2wjt?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e976437-5f35-424c-a422-08deb6eb2a1b
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:43:47.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0qCIbETYXeTXpXUJGyRW7o7/ptyKzACXca5NJ3ID1l+DY/hbKnfqdR8rao8Pj4geI3Zm1IR+SLC6Gu/Z8Tq87veS1ISeoXGGT35Y9yxpvNQzaK0RHSkDz5n0BG60uGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1302

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

The Synopsys DesignWare Core (DWC) I2C controller is a variant of the
widely-used DesignWare I2C IP, with a distinct register layout and
enhanced features such as SMBus Alert and programmable FIFO depths.

This patch series introduces support for this controller as implemented
on the StarFive JHB100 platform, which utilizes it for both master and
slave operations (e.g., for MCTP over I2C).

The series is structured as follows:
1.  Adds the device tree binding document for the snps,dwc-i2c compatible.
2.  Prepares the existing i2c-designware-core by exporting and making
    certain key functions overridable, allowing code reuse.
3.  Introduces the new i2c-dwc-core driver, with separate modules for
    master and slave functionality, based on the 2023-07 revision of the
    Synopsys IP manual.

Key differences from the Existing i2c-designware Driver
1.  The DWC IP's offsets for all key registers are redefined. The driver
    maps to the correct addresses by overriding macros from the core
    header file in a new header (i2c-dwc-core.h).
2.  The host and slave of DWC IP need to perform probe callbacks
    separately, so they cannot be directly set through i2c_dew_set_mode
3.  Interrupts are cleared by writing​ to the corresponding bits in the
    INTR_CLRregister (write-1-to-clear).
4.  The DWC controller's IC_ENABLEregister contains an additional
    TX_CMD_BLOCKcontrol bit. When enabling the controller, the driver must
    ensure this bit is cleared. When disabling, only the ENABLEbit is
    cleared, preserving other configurations.

Lianfeng Ouyang (3):
  dt-bindings: i2c: snps,dwc-i2c: Add StarFive JHB100 bindings
  i2c: designware: Export symbols and add __weak for DWC I2C driver
  i2c: dwc: Add StarFive JHB100 I2C master/slave support

 .../devicetree/bindings/i2c/snps,dwc-i2c.yaml | 120 +++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/busses/Kconfig                    |  34 ++
 drivers/i2c/busses/Makefile                   |   3 +
 drivers/i2c/busses/i2c-designware-common.c    |  57 ++-
 drivers/i2c/busses/i2c-designware-core.h      |  25 +
 drivers/i2c/busses/i2c-designware-master.c    |  14 +-
 drivers/i2c/busses/i2c-designware-platdrv.c   |   6 +
 drivers/i2c/busses/i2c-designware-slave.c     |   4 +-
 drivers/i2c/busses/i2c-dwc-core.h             | 192 ++++++++
 drivers/i2c/busses/i2c-dwc-master.c           | 441 ++++++++++++++++++
 drivers/i2c/busses/i2c-dwc-slave.c            | 180 +++++++
 12 files changed, 1068 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/snps,dwc-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-dwc-core.h
 create mode 100644 drivers/i2c/busses/i2c-dwc-master.c
 create mode 100644 drivers/i2c/busses/i2c-dwc-slave.c

--
2.43.0

