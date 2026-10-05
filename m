Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020079.outbound.protection.outlook.com [52.101.225.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07382F8EA3;
	Mon,  5 Oct 2026 04:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791174456; cv=fail; b=lL/nNnfkMysGIOMmiRFl5oxeat08wI3qHHbecyvmz6juo8oUVPCfXVHkRr3Wby6JU2/w/vrDRY96ivUwIGuBn+I+eYG0YHEmXnqcVzaaC5QlyxuwMgGgpDnCD1O6yQaamCzqjdghCuE5fVYIGS0ziXGM8b0krk+6EzUMp+X1XqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791174456; c=relaxed/simple;
	bh=4byU3bVZZcPGpfvlhtmgxxJsP0tvIcx48SPzHy8nqAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJeaEsnMeUUxxTjHKG9699VrPY7Fc+9JRibxEKWKtCB4VChxw6/SlViPjwgxU4GGplxBkksEGJxnCw6x+PBytPMStp3a/Z8wjd7DioN429nU3RJEmLHkhY8ITr9pI9gJtO/pyvv7Nztk4YVIFPVJQ4kWAZMJrN6P+XMw/jYx7oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com; spf=pass smtp.mailfrom=ebytelogic.com; arc=fail smtp.client-ip=52.101.225.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ebytelogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P91IOzT4i5oF+44FFsD88mBSvTF9p4Hc+9u83456SntZOJueHS++nGimVMFPLhfL8FaxtStmZxtFmJibNAEOQfrc7fl+GgRtgPHGvgfOZ0XYhN5j7cqBcmOkbwiTPaxapVMAlhr9oxBd+7kgmyIRhMlemziIQAC/uFT4e+arjh7LyJTUFStFem3A+iUHs8qhQORV6jwZ4f3iAl2pKBhS21N/zJMEnj5brcXj6AyHs6RTWvlKu2433222ms1T5qs5//vnuOnzBk2B0MS8GPavqLP0IhPf7pLVo2eHI2KsMTYl95S/l7vMefVJZ1Uf9A13FTLuBKu39Huv5hvLbN2+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jktB4HdeCh7V6tCxsuMKL5Evo5Fd4zXMyp59O1tnkvQ=;
 b=eHv5BriGGGjQ55IGDE0sYt71kLdOv8e6VJFl7PqT+HcNxQ2kxCMMjAGAp84USr+xTwqFvnA59wz/z09vONee31+nz5oIiWudykf2UVHJ0uDI+uedXNrUTuBPsjesW7g/s/rBsqDHJlxdmdsqcrErppFHouKiW4T9jzZE6/2FBn6lq04L0k9Hh2ebilyURf7NS5pPngNSVJZr03JHx9KH9xYBxHiVlXM/sZFwZ3y0WMIZdMV07g4Q8aIhVHiyLloNcFvHsR02yYUmnrOcip6hKfINt3E3ugGhf91SoDaOj/lg2Lx7Xru46ZhE6MajrqBJap0DMsIObbz+F37GfU+SeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ebytelogic.com; dmarc=pass action=none
 header.from=ebytelogic.com; dkim=pass header.d=ebytelogic.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ebytelogic.com;
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::97)
 by PN1P287MB3789.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:256::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 04:27:30 +0000
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e]) by PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 04:27:29 +0000
From: Hitesh Patel <hitesh@ebytelogic.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Hitesh Patel <hitesh@ebytelogic.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ravi@ebytelogic.com
Subject: Re: [PATCH v2] i2c: qcom-cci: always enable SCL clock stretching
Date: Mon,  5 Oct 2026 09:57:20 +0530
Message-ID: <20261005042721.162972-1-hitesh@ebytelogic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arr57tHBYx1MowW7@zenone.zhora.eu>
References: <20260921131954.1690578-1-hitesh@ebytelogic.com> <arr57tHBYx1MowW7@zenone.zhora.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0083.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::11) To PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::97)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PPF28092842E:EE_|PN1P287MB3789:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7d2b15-499d-424c-9d37-08df2298f770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|52116014|376014|23010399003|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dFGD6qrtoAS6cJpNdGomD3/Vr2uAFCHvLNguOb6E5UMNCZ5inwQvGpQTRInTDPcjpB+bvcwl7D4JCYLaZLmO2Q3cGF0Jn8Z3szlnoFcSPfaEvd1cYy5djOZdMdURLaIyBXFcwUvioNUyM1+5HlfUtcu1Ii0fkiGxcq6p2iv4wkHIvQkAqkyMhEmUgFHSnPHeb8a3nPa+l8OtQiyvanG5reBqIR8Ix/pSPmwkXea1SH31Uu1uiEjw9+bMUU/Il7sScZUE7DFspppoimOd+Y8f+jMkA5XVUMHYqgLAuv0pMhbsxD12gFafZU8OAhXC2LWmlhV1sR4fE/ftn4EN/k7iDiNkThfTV3KnbMy0PTSQO24pR4CThcw3+Qd/cYktc+UuIrz49Kyt6+R3raM9AP9IDjk1T2t8QN1Ot5DUjwr8f/G+AeGApApJnfrr4VZDIQQM4ng+0kFhUe5Xemi8q3yNn16ZNp8CKkRaXE9MXEKnw8BwHImvngQ/mUHKqxLRsR6QsSzb4kEqQ+Gh3itqaTcBqeQwkvzTi3YyYoL0b+8lpSM0iUHF9gfsjNEa4BkMNsUlF4U/OUpoHfZ1hxDXgRtoEsfQlnwFNxqZ9402umBEp8DbRd41SmRIGU+t5nhIz7Hs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(52116014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qTE+3Nvn1OBGWNNrlikPN2lV41Y/8/QVzhAGPb1Ppb4Go90u74Au/eHJhgt/?=
 =?us-ascii?Q?w+NC/Mt8Q/Klr5NMkcXwivNpQ8lUxrdM3+iny9feYvULjfaVC9a6ZA6MwC1t?=
 =?us-ascii?Q?nq0GRV8I1a2CCcRFnJT4FHNHfiCx0ssosQ7dWdc4SUA3xAZQpS7Nmv14TDVK?=
 =?us-ascii?Q?d7xzpwe1KO2CEfcXEHb+eprV/LmfOa9Bo0EOP2HPnDNdSA6aDdsoBboFAw8i?=
 =?us-ascii?Q?qYKvPbxWa5v0RAXTQYsS/uGi6ktCvzPjo2sb/gh4mMplcHbH2FQVK0h8UByv?=
 =?us-ascii?Q?qw3Hb5hXuUrSrJDaFWDceAGfNrs60TfVD3bEd6U6rcI1rUs8xXh++AS5JJWp?=
 =?us-ascii?Q?zZ/jSeBnF5Kzpztny0b8Zg+kC5P45YPS8O2SZWJwaGFdxI9pneI46jvCT3ns?=
 =?us-ascii?Q?CRu2pNSqtl8p5IvAmMdYdUR9ic1XFJuAwhRCcp2HdAaDOMItQY0293VTrSBl?=
 =?us-ascii?Q?y/Hk+9py4fsveGiliYTUyUN0a4eA4m2S6IURMdccO3Zzw2ORyLh1RoSYAjbl?=
 =?us-ascii?Q?APusrB6hlwsjry7LNUrSCAv4QoBXdtFczAcPwKoRKiJODVYifea6rtPDtQcq?=
 =?us-ascii?Q?RVllb+esHGqjVKG4oqzksTsYSmi//y4WxSOuCgKeJfWd90mG/0US+gAt8CRH?=
 =?us-ascii?Q?rmpCcjIDwImw0mFt8+JJl1tl7T4LFUtXvZjxb3/YPeFMmbFC3ru2MkozCCxd?=
 =?us-ascii?Q?WEzf7BmyetFplqGQLm3iOoPs8kK4nBcRmrGA5thfJ/5aBHYJJ6PGQxprbHza?=
 =?us-ascii?Q?evrBnMJUV5tDz8Lkl8cYUa3LutSlOz83Ij/C2UKengM8GIYuyeDFaD9i/Jwm?=
 =?us-ascii?Q?u5U6h3uvD8FIhA3whNz2/NlwZabS0liY4fAjf0WwWcxr5Esn9vZVioGUcCm1?=
 =?us-ascii?Q?so0rv6v5Y1Myjkb2fiHp7SvMrSEE3oCKXD0CrsOxmc2C9UIjoqpaK/8Kk7CG?=
 =?us-ascii?Q?8ja9F50M41VLgnzUBzD6OWdC80R+d0cvTVu/7rz4RcTJxqsWBL7h+Lztt/Ht?=
 =?us-ascii?Q?USf2SWCHTS0oP6GQfUnBvWorM5t8q10W1R+62LTy38wkzF/U21Ki6qjZ+dsC?=
 =?us-ascii?Q?UzAFiddfYbA+5J/Af7Sw2eznbWc2W1+/+5Wxpv6IZwktDDSh2St6yvTOjtHl?=
 =?us-ascii?Q?qidQiIRKrVpKBjBOvjOoXHXQCfQXqFC5bUWZJGGFU8sjufZ2TfC7zP1J889E?=
 =?us-ascii?Q?1ZJCsszsUCcNn/mlDfGAk1NlYzovl6NNwTGqY6mDSukaiYPSy0w+GBo6SgTp?=
 =?us-ascii?Q?7nUSqlDOHi2Cok/U/WUpVuM49puqcRegsQsFWCYklvfZcUQPHcTNPcwBtnER?=
 =?us-ascii?Q?jeHVPG1vsgOC9L3IgNMUkRwV93CvyMbSlOYYskXNRkkaXs0JziGOAAj7J3rV?=
 =?us-ascii?Q?O7/pKKceWKQ98V6iQviigDhmg0ZFugScUhOUAIX2bZwMWz2dCM7DgOyLWxL9?=
 =?us-ascii?Q?l1ZpsbFFY3GbPZbVcB6JPteQ4oTNxnd4f7ppZg9ZHqbDPlexSiDTfyhV/fWR?=
 =?us-ascii?Q?vOf5DtNoptv5c5/L270O2VrLNZl3nrbU0Iokd2LB+lWpFGDZArViFmgNDHSt?=
 =?us-ascii?Q?KHwoSK3j0UCUhVXmza0Sp3uXcMSIc/1+gOJt878FMOLgL52H0H2PZoNCiQvR?=
 =?us-ascii?Q?yYyeJoj1IRhJAsxHi/5qr9zKclkGkagzaLvaiD8pybBC4Wnv97rsUPdjD6GJ?=
 =?us-ascii?Q?6bE4vYJFikUUmotmfkAnz1u3ilPXZ4tOoffIJLhB+VLGKd29Sa94gNl+naod?=
 =?us-ascii?Q?QhrQ8EmvZKXN0UultPsO6WQ+DsKqhkqI9fMzO0m+KHU9CosQiW6xSZPoGxYl?=
X-MS-Exchange-AntiSpam-MessageData-1: x426S5KQFqY7bg==
X-OriginatorOrg: ebytelogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7d2b15-499d-424c-9d37-08df2298f770
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 04:27:29.4741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 13bdb17c-4ae8-490c-90c1-ec8121ef96ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htZKgkQ4k5LYegHIGXieEQmm2q1Gk8z8BOYJYcgxmEXavqfXYr/tDwYxUf3ycWrqfKDCWfxY238XS40Y7p6guA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3789

Hi Konrad,

A gentle ping on this one - Andi is holding it for your ack.

The v2 is what you suggested: it drops the per-table scl_stretch_en
field and sets CCI_I2C_MISC_CTL_SCL_STRETCH_EN unconditionally in
cci_init(), so every speed mode on every CCI version gets it.

Tested on SC7280 (CCI v2) at 100 kHz through a GMSL I2C tunnel and at
1 MHz for the on-board devices. The other tables are untested, but the
change is identical for all of them.

  https://lore.kernel.org/linux-i2c/20260921131954.1690578-1-hitesh@ebytelogic.com/

Thanks,
Hitesh
