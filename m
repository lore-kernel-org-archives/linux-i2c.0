Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021076.outbound.protection.outlook.com [40.107.51.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA6255F2C;
	Mon, 21 Sep 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994204; cv=fail; b=ABOO080htj9vlLlaysL1EESJZMQhewEOGqKv8qRqkRDaSz/MlEEbfC2RssEAiX26qRdO/Kk/KwLcitTFucmTC/hRAQV4a3bG1ma84imWbqtew4M5xpM+GDmhQpLzLouT9f+/DPgHEbcr6yxLws81UcBVucji7UiFUvohiSFZbjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994204; c=relaxed/simple;
	bh=Bg0MGz9MBsr02kQkkIUjtyyIhX5YfAaeJtb2KaCPHAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kaVdxd9AWMDjLTft3Yfhph5Vi6Quye2XHsyv5kufKBzyCCVoqvOFygHFnpmGeCzOURErRxFSSP+Ns0cZ8TGhJfjoGzEXfCRDv2Lu4Bm6w9bNYFf+jwD99Y0CxgqOWIANTOqnYLiZUccM08Xf5XzVPg0EMv0fsjmdJYJ0+Fr4YhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com; spf=pass smtp.mailfrom=ebytelogic.com; arc=fail smtp.client-ip=40.107.51.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ebytelogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ebytelogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8D7TJPUhvF/0siFapBax9Ti2ITt2kZDdO3nYbTbG843Ql3fVdyGuu7izuIF+Gpe9+HdOt66VQY8bxvhAtpKLad0IoSSWu1UFB6b4wGjdh8+wXo8f23ELdYYEYy8zoJwDpZGgFrPnzfzv3aanGaqBOdxskPa6525xownFatEi+2p3meXGew8ixDEl6jA3SZJpxJFQc/Y3uhQStkk7blbreqjKKzZhXzWJKl8Z8cMTC4KUq8vEOYIybYsCAo1kNd94I+F0E63KHF3NOK/9UN80zDAP2FLaKvShHMIU5OryU5d9rVheh50qid35VuAVA82KvcNG0q4lBgbX94PoiX3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg0MGz9MBsr02kQkkIUjtyyIhX5YfAaeJtb2KaCPHAY=;
 b=xsAJN8esDaoXA2kG8RoiuKS18UGQRfasEKgnry3AyMpTFSFp8HnZ/z+70TYkNihTyqlQ4D98CG3mmqHaUC/xrM7BTu2YfJBn+xfDoPP7duAILR7zl87LpbAzYo8eRVfpGgiq+U9XYEGW+sBZL5KI4UyenLIyvLc0Dkhf8a+rfuBTaxfMXKObJofF/jv/PodG3kLVCKHpUKg3/fMgYR6g5cjQSXcI6WY2kt1pnT3nO7NDOSuIob2gKbT73OtPcsOa4usoy8v9iRAwkzBwBfcPUU8cTIwer6OSayABjKkRiU3dvY8umwGRKXj2Lhe3quC9efpfwrWvU59kc5t4XGbQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ebytelogic.com; dmarc=pass action=none
 header.from=ebytelogic.com; dkim=pass header.d=ebytelogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ebytelogic.com;
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::97)
 by PN0P287MB1080.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:139::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:36:31 +0000
Received: from PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e]) by PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 ([fe80::df75:6e8c:7def:a08e%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:36:31 +0000
From: Hitesh Patel <hitesh@ebytelogic.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ravi@ebytelogic.com
Subject: Re: [PATCH] i2c: qcom-cci: enable SCL clock stretching in standard mode on CCI v2
Date: Mon, 21 Sep 2026 18:06:22 +0530
Message-ID: <20260921123623.1312634-1-hitesh@ebytelogic.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c73b2ae0-e138-4472-8acd-b0ae3dcd742d@oss.qualcomm.com>
References: <c73b2ae0-e138-4472-8acd-b0ae3dcd742d@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::14) To PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::97)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PPF28092842E:EE_|PN0P287MB1080:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bb2a95-545b-4fc8-5d5b-08df17dcf6fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|10070799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KhItwpsHEhApmobh7BHk6f8/1+qVsWWE2O6feGspFXgDIIR+yoKNXRmhLtt/e6zvbxZpIysQ9HEbC48gMv6DP39JsmyU+8D2oCUamCccDuE2uZs9Gyei8tht2Rq+kVx8mgLLZOEDcKcHSHXwpjd/QhWNnRnCX6l02OZ4W4Q8m2zUPnXQbhoAY82wYn+DTn1OaWT9cM3a+nLZ7W5Y4dqbMtzTZHqRMtjiLwRLPUu9vo84aa43DYFfWCjd2pRzY6D3Om9xtmOlas2WsO2ClUV5tQgkTfCPUNw8vM5XMwaDDBpDGcrd1nM1N7twh0KJefQ9RA9wmNZ2Q6aY5QevidtzopVii8nzDN23T2279u3O42oe+Pjml/ixwmcPIHcFN3kQ98pfL6czE5eyut5KWi2DheaNUwirvILCF2UxXfwZ0sGpXd/t1FCQo0Kxm0mpjFxXLQwk9miEBCDdJXWlb5VWv7gvND8dE4GSk6qxy+1Q+Kubq1GXkQEmQHff1a2dWcxf+XFuxHOnZvt9MMInIl7lHkAcB8w39HDqf2FWwxnpuRqfve8ciCswcfBzD6ZjwvXqaYHmGoFTA3JjujTh3RhBvdjkPd/6kNgrpCaXd98PBI7bK3Bt/+xKe6JTF3AsdrXL+3Fn1ZlB0CpjOqd49sYP+h0akAiGaOOKCnB2almfq6Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(10070799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ArqJHs0VjfgB6MYN9fcXO72AWqDKuOUUJVRCK+vJboVeSSIe0emoQixn+Uc?=
 =?us-ascii?Q?7aES4rCecznJlO0VZ3hdNUHA67vUt1zJwmWANpi9w+q0mnDg9sUPpMPdb9XJ?=
 =?us-ascii?Q?kIiLLWJ3sD7ULioAlCoBJz1Mvomaqfr5am0NNW5VUh0AQnfUaEgCG5nUeCIt?=
 =?us-ascii?Q?92zeKoTc4z37eyc5ykm1PtBnJ3rKfHxDrrluTKG3BDknIEGQX9BIEW0g/skN?=
 =?us-ascii?Q?Jseb4cGb5kBp+GVCg2FFj6Ksg1y8b5l9QVFOn1kqFZQid3kWqC8fvLIaBAMt?=
 =?us-ascii?Q?fd6KABWtJtYmp5Y8wg3niKUrY0Faa1SAMKVkVwa29pwusLtid2vD9rF8wF8q?=
 =?us-ascii?Q?5CRBr2e08nFRH2PKZfllTn5y5eOYaO0gL1awXQzSA7lDXCnLkyBfVh0ygcRF?=
 =?us-ascii?Q?G7peA8J+z495y7Oww4IGmEixMUm1vpgaDOYjBbYTWsvmP+j3HuH33s/wMzC0?=
 =?us-ascii?Q?4M/31kCOt/IbC0hXsMzwSDt0VPSzFpk/MrdfYGiBRchpl6rI/K9YkMd5qv4x?=
 =?us-ascii?Q?Cf4VOqJbXM9Dpm9XVC7fGXhf5nwU1EDYJMClx+DZjK0l4Ms+gxln6JP/ehjp?=
 =?us-ascii?Q?MiY075+1TqnVGH4XWcnxD+EP/8Ua70vby+V8NQwUNES3bDbTjbG0ram5z1xb?=
 =?us-ascii?Q?dz2J5qoaPQe+RbXW2rmbhJE/+0N9DhX/iOcbWx32i6h/cAEUCLOvft/JoVRn?=
 =?us-ascii?Q?CVdPUWCqCPQk/dI+dSjU89FqXU8dHCG9efAyajEFcnvMDBMOS5nGvP1mVw+4?=
 =?us-ascii?Q?+X084gQQy5G5tlcojE/QWs5eK5tjz72jvBvYmdMQaKDuNZ/JWrv5hMvRln6W?=
 =?us-ascii?Q?CKTOtRHtCc9YTNCoO+IUlZIKBXwCgyx1bsEv9IM6tWpWj1IptYkszO7JXSpj?=
 =?us-ascii?Q?QtU8DN5T6YHiEZ57hNhrNh8Q1r8BOhlEE3uK5z35dEf7JPnOw3Skc0zsoK8x?=
 =?us-ascii?Q?zJor65udQceHx6VIWquwjvgn5jduUI7L54EBYjoYBqp6ysTBK216dpoetkra?=
 =?us-ascii?Q?+fU+ZvYytHl8hE4OWp1trwqm9orPPlRQC6s+2kE90/4T/dJXZcocR6o1PW6k?=
 =?us-ascii?Q?7lVr4cHVpb33rOjvvIJAAcex0Sb0RKerq8q1/Jw2LJ3YYaqk3+yKp1sxOfi7?=
 =?us-ascii?Q?Pzs6DoI9pYPGNt2q8q9y+xo0q0AZz5VnMBN0+7hXOuYceWuCg0IVqiM3XlKV?=
 =?us-ascii?Q?bfpKYzuXRuXMxdh68sGY0z2bRRzTqd9O1eVwTTIMLIRixCaJOa5KuFLHGc3C?=
 =?us-ascii?Q?k8r2GurHsyjZD5ZyMGwVWfF4pabGDiR/TlsAsde2qzLLcHiUWpINtWp5vzBg?=
 =?us-ascii?Q?3Whd9LTLMYIOd7AoEbdqclyOsZxm2UlZlf9GMt0fJ844J6APdNdFOZagi4Ep?=
 =?us-ascii?Q?psMbBknjFBLZJiG7PLZ4BhGJ1UI/BXcbFCu9Pb7K/j0jzhnIPbJMyxoWe3Sx?=
 =?us-ascii?Q?j+cOv6ib1JcesFwkZYbvUp9qAnGwYPbU5sI0upms5eYvzTAPqvz78D4vZbiA?=
 =?us-ascii?Q?AYEyvgWjWG+R4MrFgk2fAEEpBSlFRcjdaMg356lz1zZm8tMfpc2jv15KDni1?=
 =?us-ascii?Q?NmA51o5rhbM1MXAEz01xLC++XofQ/R0AHH3zJdxPXXt+dF5RUw3wzq4w7JJo?=
 =?us-ascii?Q?Y8AmPyPpJzj5LJ6egAH+qOT+dFDdbCwru4Zr5tQNkVIuGNK7DRW6ScptNmgK?=
 =?us-ascii?Q?glTmRtOc+vNOTF3yX7ydnQyJvDZDr3vnbfgBlKREXtyMTPslh8Ef1okSdrUB?=
 =?us-ascii?Q?Txlgqor/jzN3QmWRU1BO9qwGHXEJxnKP2D3xs+m7Q7axtDK2mHQ0zHaJFoMR?=
X-MS-Exchange-AntiSpam-MessageData-1: DO5lbZkvwPfHhQ==
X-OriginatorOrg: ebytelogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bb2a95-545b-4fc8-5d5b-08df17dcf6fa
X-MS-Exchange-CrossTenant-AuthSource: PN3PPF28092842E.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:36:31.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 13bdb17c-4ae8-490c-90c1-ec8121ef96ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s16JWCkyow4Kbrmqoko4Aa9hoGxeZXk4zj0zNEYH5lD6bJdshPTs4ktV/3gAjerPuiN8/nVtfVmlrrehN7KCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1080

On 21/09/26 17:04, Konrad Dybcio wrote:
> Would it make sense to keep it enabled unconditionally then?

Yes, I think so. Clock stretching is mandatory for every speed mode
in the I2C spec, and a slave that does not stretch never sees a
difference. The per-table scl_stretch_en field only exists because
the values were copied from the downstream tables, where all but the
msm8953 fast-plus one happen to be 0.

I'll send a v2 that sets the bit unconditionally in cci_init() and
drops the field. I can only test it on SC7280 (CCI v2, both 100 kHz
through the GMSL tunnel and 1 MHz for the on-board devices); the
other tables are untested but the change is the same for all of them.

Thanks,
Hitesh
