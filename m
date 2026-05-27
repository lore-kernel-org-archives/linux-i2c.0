Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2115.outbound.protection.partner.outlook.cn [139.219.17.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56092F6560;
	Wed, 27 May 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871861; cv=fail; b=T9eiYZjcAgWLERTmqxkj27Td7hNBZMeC87THERPXIGNfXAx1caTzTl1F84GQvbcpQqFh+D1kofept/QO74R/tAsuwmC0lNuHz4yjAUhNHzQ3eSzvmr3yxN6aop92eNNsnEsnWpbHYZGpf9pKNqesU3qtVsGbOGXkEM8iPmoq2CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871861; c=relaxed/simple;
	bh=oXv4jxfkVoTggzeqeDyhnYCxhrcPRbmdnCmBTxWUn68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KfXmOJnAWovZrwN+5Egqra2zxUNht1TsD36T0IIn1yG7htDd7EK60fBrlDmc3JT52k/DwS4yROWaIb4YVlRe02SGAQ1uWre9rNbG5rATI9JiC/i7MhwqBdUp/T+l9OdHfD9SE1lJO2Me0o1SvsSPYCGOji/sM56esoMbfj3XnPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR9CDQmTs2u+iJ1dU+Qvv2iHvyjEZmJkoZKh3Fd2PGPudx868V+Kr1EBsLGpZX1GxPqEa4bFRfJWcXRk9MTtkltAoQeCuDvhPG8wsulyckxGDmEVy0jYwuIvyIAH+iUmf3HFgeGTwoWUsOxvIcwbbeysIi2JTiVQcuSZGGdD+m4BEX4rlEa8HciPuIOxyI4bU2l3BaCiTht+z5y+5kaqjteRzumFCjjeW97R4rxQvJcA1fk+1C89oh/aYmuM5LHK7GWFbvoWamk7afnHQ4ZRXa5IDKeMVpo9Ei6Y41K8wsAxOcyzIx4tNjLmBv6SHCpr22v8xvz+P0sK4XSziRwT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4zH7gvgcVzUiEF6rMuXcCvUdgMyX5ebGAhvEoLTKSA=;
 b=N9o6OYAJImgV5zeffQJTqI1w3ozRhO/n2YWwEcy9ekAiKHsT65euRHU9jUHPC+rKlVjtRoxPsZCFg5acHlX6lLI2wQlqoXdwyQkwN/DEIIRasaQ0AyQb19dTQSk9z+XsudKUm5APbi572JQAKl1nVXYcwYGjgQUlYKaVgiQ2NVinjwFBNeeQqQrGsNERf+shFFBhUEUxOGpG3dYumd4OAgEM459AR+BdFgKV7S5NGH3DIZGibPsWld8TQ+vSWHMpdzaxhlBzDxvAF5D0MEStp2pY7osk5oXOnjX97wwM/xVwIwLJ9sMWzFKfaOL5uqMRp/ZrlkhtiIYaoKslKn/cIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6) by ZQ0PR01MB1285.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 08:50:46 +0000
Received: from ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570]) by ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 ([fe80::973:272c:ab11:7570%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:50:46 +0000
From: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>
Subject: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave support
Date: Wed, 27 May 2026 16:50:36 +0800
Message-Id: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::6)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1269:EE_|ZQ0PR01MB1285:EE_
X-MS-Office365-Filtering-Correlation-Id: b04053c3-20b4-4068-b238-08debbcd0b52
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|18002099003|38350700014|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WenFDlBDfiedwzL6/0ORb1/VBZbLk9xgG90E4qa924CHN3DMwrrFOIiXrUv0hxJW9XfOx7GUnaL4F7Reu921nb8WeWrS2NVxLQPSH6M8Edqeof6z2bRxkZf/owNoiMEmWy2QkwMP8UGJuW5jzTsaSX7pckJwED15PvlgAMvSXPJ8Wg9PeR/4+YxVqXAOa998NYld9zcB59PBnARmM3E7US4SwD55x1r3ao+oWyC70ARR4S//sNPxMcw2KiyD3zqmesgwUnTHx3IdokungOMaaQviqnYWAfg3EWZqkvR1z2exZxj8lrW40YOvcAAFJpsJaygJPPI3Z8Rl0PfUusw6SMQkRgnZjMT7UMBDuF1RhbsW8XjmSxZ/XlB4lyeZTYraYH6q23OKEOXDOwjx5vuuopoxnjSM9f/wLwcQ5YjbfXQRscyrQWmS0mgheMQJfQ25HPiU5RqwM7HYixbqrDDnc6neAHLvYR8zOa/MyEpyZsgD+akJMQ1e7KMfNCk1tR9qZLLw9W5rgHF9J7eZTJj1e92KiyaGkLsPB8ilUEqLuMtWZo3bvZxIiwc8Vyy2tmFY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(18002099003)(38350700014)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3v2tAbGfXy+dxtq//kyTJ81quegIo1qL68faz2QwBURWRjNSaZzDQPmV2+7j?=
 =?us-ascii?Q?MRIwJl9es1tBZ+VxsyjYKnwwESR3kBDLopSPljzr90reQXnJwAmQVbE83GIo?=
 =?us-ascii?Q?zJV2v9LFvGHRXvHQmNsvmbuLWL2Ne1wG2HXDR7GohVEfCbmiMrjx6eKcgtHa?=
 =?us-ascii?Q?9Knsha9gMomhjaTjFnAZ1TnQYdUCizyQWK+XgsdPNOgufmapCogoV/3S8Y5N?=
 =?us-ascii?Q?SQXdGCEqU6Vjj9sjMWHRbdC5OEU2vOubuSlRqViSivbmbBNC0OSR77Tpe7Pj?=
 =?us-ascii?Q?IefUzfMsvk1oRU+4wa7aLImjjUfvi4I1tcCBSHTxDW2PgB2qbTCPOr88p5y+?=
 =?us-ascii?Q?eRNvh3ODFOCIQgnyGX/MZ9wCZgR1XnNVlVabneXzyHuWS5cyYg7edK1dhP3e?=
 =?us-ascii?Q?wV9M+HhwF9ZsS1d1NyoGU2RHyV4mb7eNjlsI2mcKX4Kuh9BsAfWiF3lHJGEa?=
 =?us-ascii?Q?3/xw7j1MSiGGU5Q4kMt+kt5iTK5I/7Hjji4PLZUbVWwQ+iR1l+WtWadMYtAC?=
 =?us-ascii?Q?YaKMfpgVMCs30Sfl5hq7eAkabF4Ebu2xZM2h3wwXWZmxLn8Aard/8jRIuUPr?=
 =?us-ascii?Q?qK6Xkq/bohcHnEdXZn2eXc749lquObbGw97hAxs7mbkbzDE/EyUmupRcDg5F?=
 =?us-ascii?Q?Iymut16epiowhFNFXmEgM47gOoh2QQ2Q47CYyXskPWcDsawJhDutehM93iQK?=
 =?us-ascii?Q?ypsr81KYVYzBJ39Ssus8UCwZceyOccFC4X7YwMfIb4Klheh0CaNpn/wtD/ZJ?=
 =?us-ascii?Q?Ohkp6fRktdaF7loFvC7aA1746IeO5ja8Y5EIdwfJe2/+MX1kWFfJCTyD/Pb/?=
 =?us-ascii?Q?o2BWzinNs/92U2Rl2jE+I1HTc7PoVaJFUWgsvNJLizojh3q7vgWkjDLT5J+/?=
 =?us-ascii?Q?YhDHN68Ib/RjyMEnl84inY26Y1zZgeiDq44Sb2lKBrO0mXBQeVc8KPoY+h4X?=
 =?us-ascii?Q?ONHjQlgkLMqPez2BLzkVdcEGN08E93j5j4VMzVufDR97v94e8eV05NqzesLN?=
 =?us-ascii?Q?QYT+gn6EJxJAtAfjoiFLb0jYlAsaBPQIKxtvIVZAkrDynG8y643wWylKO1vo?=
 =?us-ascii?Q?x5qZRQbOKgmNDLDweQ0Tw8XWMRSmKWWrsccjX9DRqfWL6oABoNXLhDRaQnTc?=
 =?us-ascii?Q?K1g4tj0gin523p8xCHGHEa7UIYewxzceOi7tlVIFOXCbY2Qr5bndxqNDBEMQ?=
 =?us-ascii?Q?Kzfk7FF6SzNcwHMKel919reoSUpTfj6oqO8Dt63pbItLnf0ewgVPsW+zwrHK?=
 =?us-ascii?Q?MBHXscWJa5TG6dd+8Wnoq3T9CgC4tnhGYvKTfDLuCdZnBJDGaV3kLQg4JXbv?=
 =?us-ascii?Q?2ArCeWovmMhJldIOu2l4QUN6XxiiIK4Z8IppzLH+QgIEJX1GhILcWeCMTIZ/?=
 =?us-ascii?Q?URDjqsVCrniUrg4zK9aKhfm+LogjG5zxUnnrJtMHw0PZNMbMQElz58eDQc68?=
 =?us-ascii?Q?uQP+hiVz13ijltB3+ZvWexx0xmESv2Y+VlC61JmqS6JM2Qe+veHW5JSwU+Bf?=
 =?us-ascii?Q?RvpjGXxjQN/dyfAYzHu09cks0/TL5cxfWizbgPOmxug8hILV0oDWlHhQUtxJ?=
 =?us-ascii?Q?/1zGqpu/VJXqZ2tq7/slgcuNkuqwtPjFB6DAUsTGPnvUxmkJmpfdiOQRnMIP?=
 =?us-ascii?Q?IkioNZVjKVFBf4NM5ef0kHRkGzhvYD6+hyFICveRLCevw8JWsh85ARoY5dV0?=
 =?us-ascii?Q?pbWafBTP+wrPO0Yv9L325jFmTPtV6T7Oli7ZC9S+VoQ/Qxubg9Sku+mcvRve?=
 =?us-ascii?Q?YlYlg5W5tEBg//9xIO5i4/y89bzZd2adOjMC+72/D3Z5d5K4t7Z7?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04053c3-20b4-4068-b238-08debbcd0b52
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:50:46.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfPuwX1srCSR5BdCgRG5vXSPPs2b8kusBZYGw/HAjvDuQ9hyabxkXNvHG0XL1GB6ySfNXORd+FOy9+5DHcIFO2DtI8GlAGJV3cWQr957oP82imiPDOQtVCCtfLsegOOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1285

From: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>

The Starfive JHB100 I2C controller is a variant of the widely-used
DesignWare I2C IP, with a distinct register layout and enhanced features
such as SMBus Alert and programmable FIFO depths.

The series is structured as follows:
1.  Adds the device tree binding document for the starfive,jhb100-i2c
        compatible.
2.  Prepares the existing i2c-designware-core by exporting and making
        certain key functions overridable, allowing code reuse.
3.  Introduces the new i2c-starfive-* driver, with separate modules for
        master and slave functionality, based on the 2023-07 revision of
	the Synopsys IP manual.

Currently, due to the following differences, i2c designware cannot be
fully reused
1.  For high and low level counting settings at different rates, i2c
        starfive can use IC_SCL-H/LCNT to set SS, FM, FM+, UFM
2.  Interrupt clearing is achieved by writing 1 to the corresponding
        bit of INTR_CLR, while designware reads different clearing
	registers
3.  Master and slave require separate probe callbacks and cannot rely
        solely on the runtime mode switching provided by i2c_dw_set_mode()
4.  The value of FIFO depth is not obtained through registers, but
        written through DTS

I have written some poorly styled code to reduce changes to i2c designware
and reuse its functions by keeping aa always true, for example
1.  the implementation of i2c-d w_probe_master() differs only for the two
        IPs in i2c_dw_set_timits_master(). In order to reuse
	i2c_dw_probe_master(), i2c_dw_set_timits_master is declared as
	__weak. A better approach is to use a callback function, but using
	a callback function requires changing more i2c designware files.
	I don't know what the attitude of the community is
2.  For the operation of clearing interrupt flags, i2c designware reads
        and i2c starfive writes. Therefore, in order not to modify the
	relevant logic of i2c designware, I added a write operation to
	sf_reg_read()
So I think this version of the code is not allowed to merge, but I don't
know how to handle this situation because if i2c designware is not changed
 at all, we will have to write code that is similar to i2c designware.
 Will this type of IP not be allowed to merge?

Lianfeng Ouyang (3):
  dt-bindings: i2c: Add StarFive JHB100 I2C
  i2c: designware: Export symbols and add __weak for Starfive I2C driver
  i2c: starfive: Add StarFive JHB100 I2C master/slave support

 .../bindings/i2c/starfive,jhb100-i2c.yaml     | 128 +++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/busses/Kconfig                    |  24 +
 drivers/i2c/busses/Makefile                   |   3 +
 drivers/i2c/busses/i2c-designware-common.c    |  72 ++-
 drivers/i2c/busses/i2c-designware-core.h      |  20 +
 drivers/i2c/busses/i2c-designware-master.c    |   4 +-
 drivers/i2c/busses/i2c-designware-platdrv.c   |   6 +
 drivers/i2c/busses/i2c-designware-slave.c     |   2 +-
 drivers/i2c/busses/i2c-starfive-core.h        | 164 ++++++
 drivers/i2c/busses/i2c-starfive-master.c      | 470 ++++++++++++++++++
 drivers/i2c/busses/i2c-starfive-slave.c       | 180 +++++++
 12 files changed, 1060 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/starfive,jhb100-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-starfive-core.h
 create mode 100644 drivers/i2c/busses/i2c-starfive-master.c
 create mode 100644 drivers/i2c/busses/i2c-starfive-slave.c

--
2.43.0

