Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020139.outbound.protection.outlook.com [52.101.84.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F833065C;
	Fri, 13 Feb 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983300; cv=fail; b=c+kdbgVOk53pJKBZfqxCs1s1iYND1aJlO6M8FTiqQ8hmLlI01SBAy4AjK+5/Yya+cnnPyedxwC1Nh5o8MYZvYLWKvhlXvA/x8FSE73b4zgc74bmEO7AzotvDr8ZnoCVsa7obxG5pDArfM0ah/xfT+5g9DCNnfprPwUpCO7QJWmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983300; c=relaxed/simple;
	bh=OxeeMzCYbL3tL1/1vnHrUIG/CwubKEjWtjAHvVm5BDI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pp+UIDNvCWunJ3KNT17dv5Rq1fBpw515ayqhQSnbapqkkCCaXDNOLoxd0rP6+dm0Jv+HkqJLdgjrSPTSbOpC8xHPwgQiZdDYrRiKet0mjRRM34Pj8gtpSaTaSBYhR+bZaZh7zCmqc/a66kaW3LQktEgIy4UM/9jKxVupLnqBOuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=F5hY2hf4; arc=fail smtp.client-ip=52.101.84.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="F5hY2hf4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5H2LyhdckwM2RhNxNSx6Yjbw4NOTPilcfnTIHDyD1gD8p93Y8WdFZDLijr6XWGwX9p75LwHSsF31gSnrRmIwxYsbNYjduBOBeTRU8GcgPxIJQ67vSb5HmPkv/nWGu6r99rO9r/FCNuOzy3QLZTk25XI+zhLReRYwN7te/G24hj+ScELlMzZYFxIyUYOnOXkwjQB69K9yZAMgFHrDIPkdqTjy/+3tuEUCNV+xxH4La8b1MhTkwFZPB8n5o8Kk1OKgMs1npR8AgSh3qvpKmlsCh7y5iLh/rBwDK0PozEE1P8Z0Nofd+yeC+i4c697caJ/9C5uNbXxwN512UZizci+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7m/zbQiyspxMF1QxfwxOEZtOLrF4gYghksNjFiSE8w=;
 b=GAHN9DMyM4sLheZI47AfQuhqHqCUUjvb8YfIzWasbo/9p6QwAnqdh1SsBVG+Vl8JFFqCvJ40bNJtsEv9l+3XmgPLWHfVMVMh1RmBtP15EjIqBmOJK9/awL+WENZ7Rn73hOeKDM37N6NaghBLIDxcYNbi8rNchan5eFxmiJerXgKHaAAH8V+vqOco5/qbEM2s5/PTJQE5DxQ49dA/IweWLSQP5NWDskgSSWJtV5f8/WWA7/oq4u0cJ8qEFvFxzvpw7v2rO/d+5DC566ieesEv6aaCVOD982Sbvq0wUJalVPEvlucBqwaoY4Fd3IvCkwNC3DSCyPwNCKeM5p3KanvsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7m/zbQiyspxMF1QxfwxOEZtOLrF4gYghksNjFiSE8w=;
 b=F5hY2hf4ZTlSpk0MRke6+alyAFniBFXGL/2FIop+LodS/oUPMt0Wb/IlU74YEx3VQ05bJgQlKhqeuBdC9ukH9c+ggqquqJCcEtgKs4mtWlBLjRl5vYx9OneiOjI+j6u9w7VaamtSP9WBYiQSKXEl4l2yRi+JrqJlfWfNj34Tio4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by DB3PR02MB10401.eurprd02.prod.outlook.com (2603:10a6:10:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Fri, 13 Feb
 2026 11:48:15 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 11:48:15 +0000
Message-ID: <ccd960bb-9dec-3a1b-cf3a-d22b4ccf4df9@axentia.se>
Date: Fri, 13 Feb 2026 12:48:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 2/5] i2c: mux: add support for per channel bus
 frequency
Content-Language: sv-SE
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::27) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|DB3PR02MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: b2915fbe-9588-40a0-8728-08de6af5c588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGVTdlE3dDJ3YTBtZFNVSDZpT0RnQzU1VFYxZ1VGS3B5aTJFT1BHRTZKVW94?=
 =?utf-8?B?ZDYrVm4rdVZ6NXRpanFienpSYTJXWEVDMS9PT1VHcGZOeEdKTWpiYWQyVE5V?=
 =?utf-8?B?UEVvWHVDM29EcmJwNjE5QWZZczRzR215YmlwMUlnbTdIZXBWSEhpSGExVGQx?=
 =?utf-8?B?QXgva2h1c2RQMW40ZFFSUVk4QnFJcnRnSHpXNnY1SVIwNm5oUlBDZ1lhaUJC?=
 =?utf-8?B?L2M0VmRMMmt0Mlkra0VZNGw0TzFQTVFwVk5SV2ZWbVQ2ajFpL1VjTVZlRUgz?=
 =?utf-8?B?VmlGdVJVRTJXRTF6WW5QbjljRWR6enFXRW9vY0lScnhQbStUdlNpcnVaNVRr?=
 =?utf-8?B?d0g4dVNwWndzNlJrc0hLYWgrMTZXWkwxNFdmcHRkcTBoM29KamJsRzczajJw?=
 =?utf-8?B?RXk5MnRaVmp2RWhkbE9zNU83WG0vWjNGU0tNeVBLREFiVVFiVWtDYUxiaHdB?=
 =?utf-8?B?eTYyTy9wSTQ3NDB1ZUlqOXUvNklDK1FwTWduc1JzcU80WDRxdzQ4U1BRM0d6?=
 =?utf-8?B?WUZwbkJybVV5MXo5MGQwc3NwNkNMQlVwMlA1dGphYlZHL0lia2ZGUVhRWmlS?=
 =?utf-8?B?WFBWT0VjWGdWamw3Rm5LOExOZnVxbkRwUmhZOWRGL0taY1U3NXpEVDdjYm53?=
 =?utf-8?B?cWE0UlJoK3JaTUhjbkMwbmxkRUxCUEZZdnNhTndoWkhSVDBvOFZVUm5pTm5m?=
 =?utf-8?B?RDNiL2kwVzhoVGtTN1FKc05XVlZYdUFFb2xoWDFWa3lGTmc5L0JoT0tGaitC?=
 =?utf-8?B?QTR5aTNyL25aYjgrMTd0d0VNVG42dTJTeDVyT1hzckFWalhOOGZRNi9PVUow?=
 =?utf-8?B?aXN1a3lRa0MzVmV2cWFjbmkrYkxBajJHdVZIZEUwdHVyb3ptcFFWMm0rcnBt?=
 =?utf-8?B?R3BLemFNWW00Y3N5ZDhDcGFuQzRRcmlINlFnczNRazZjdWpRZWNUU2ZBbWZV?=
 =?utf-8?B?MFRpSG1jemx2SG8rWnNlQUxvZWlTa3p4K1d2TUM5QmZ1TEpqd2c2UFE1QnU0?=
 =?utf-8?B?aGpKY0ZOSDNoYlhaZ004QjZvS3Jub1BrNzVLMjJ2Z1Z6dEFTUTZyeVQyeTNm?=
 =?utf-8?B?bVJ3akVkRmNYMGVIcWNhY1Y5U3hkZUdsRGZnc3RIV1VsaW8zaUtoNEZZSzJV?=
 =?utf-8?B?WDJmQTBHYjBROGpiTWNBak56SDgxOXJnWVBUSE9OenA5VjdmNllsODRwZGpV?=
 =?utf-8?B?TDArSjNQV0tqVS9PK2VEd0ZwREZDUStuMTJvV0tDVTgzTDBENU9oME16aEIw?=
 =?utf-8?B?Mk5oVnUzMG5TOVhqZndlOS9XUGNmUERwbjFjQitQbDIxakNGTHNJT1FOZEI5?=
 =?utf-8?B?dU5zamtHcnFRVFh3WWhITG4venU5dWFKai92a204ekhFV2lGWFpielpnd1VH?=
 =?utf-8?B?WDJISzFyYXAzU2pTL1BkdUR2SFhJaHdLRzBGbkxrRmhnNjRHdU1OemNpRk8y?=
 =?utf-8?B?cTZ1bjY1MVdwaFhRWk1Dc0Y5aldId1p1U0NKeThMcW1UVHRud1BZY084Sk5C?=
 =?utf-8?B?RG1KYjcxdm9NWldLQ0liUGo2NEo4NDJCUytOaDdJQjV1b0lvRGJUTEtCcHhC?=
 =?utf-8?B?SjlNSnVENWxDOTIzeUxEZXJFQ1QyVzh0LzZTODhPVjVFb3dqZ2tubVNxSlB1?=
 =?utf-8?B?YUErN0FYcEkvMjNCa1Q5QWlzNUJTdFp6ZFFRcXZQOHlobHJSOFlrMGx1YWVN?=
 =?utf-8?B?NEJaeUM5aHJVRmRSM01xNktVaEJRM2JoTmptODkrUjd0WTVkS3RWZGk3OUFD?=
 =?utf-8?B?VzJnT25DNTVGMkZDOVVhNEhJTjRHdUF2dHZicmhqdE9rNW5hRjNpVytiMFVV?=
 =?utf-8?B?enZBSEpBNXFkQmp5cmd2Q2FUbXordXVpdDFwTW5CTXhRZG9HcVlnY1dpVjM5?=
 =?utf-8?B?L0pJdHFNSDdQa0Q3QjRwYXhRS3o5S21wR2F1cU00VXFVenBxbmt2RmRkejBp?=
 =?utf-8?B?YSt3Vm1QVnYxMCtpQlRWMzRVNjU0ajZkZEFsY0lBTGdxQ095T210c2p3L3JL?=
 =?utf-8?B?ZDhMdVZrZUsrOE02ektrNVl0dE9yRzRSVVJsSVhRYWkrR1ZLclFkYzIxZUxp?=
 =?utf-8?B?cC9TMTVhTDBzU3NNRkFjWHFmb0R1eDExQVJabEUyZHZMYWZSN01DS0hLWHhK?=
 =?utf-8?Q?WImU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjQ2RnVRUU0vQ00xam9NQWNaVklTZEw4SW1CMDZXamkrNlhXSlFxREhDYk95?=
 =?utf-8?B?KzNaZlU4WWZzaWcwS2ZVQ0NPVys2TnUzNXdzcVg3d2JWL0Rmc1lNcHpZZkpn?=
 =?utf-8?B?d00zQ0hTQlBWakhJWlZMV2NTeXAySTZjYkdMSVNFdUdWRzFCY0F3STlUQVNo?=
 =?utf-8?B?R3NnTGErdHgyZkU0N3BJZkFDQTFMdnFRTEhxQXpjSkp5RWdRWmg1cUdWOWh4?=
 =?utf-8?B?ZlRIQUkvcTZSTG9QRDhmVnF0V1RYUytVenpaTFhiKzBUSHlSaXphOURrTjNL?=
 =?utf-8?B?WjdadzJUdXk4U2IxTW1WdXNiM0JXTTFHSG5OUHp5STc3R09obzJxMmdSeExs?=
 =?utf-8?B?eXpRZStQS0R4c3VGTnhiY0VkNHp2MmVweWppSHJIRkkvL3pERVhaWDVNOHVq?=
 =?utf-8?B?YmhVem5PT3lDcTk1QTZUSVFIckoxM056MkF6eGh2WExSMXE2MFc1b0VLZmNO?=
 =?utf-8?B?TFdyeDhJVlVtNzZFTlBSRG5zZXQrTzBnNmpTZXlPZkRmZ3VoUVpRUm90cTNR?=
 =?utf-8?B?UlFWb2dhT0xVVmtzOUJMZ2t4Y1pidTRaOVBjbFFRRkJLakp0dUQwNVpxWnNV?=
 =?utf-8?B?YTZuSWR6VXhHYlhFQ3Z2Qkl2ODlmS1p1Y1o1WVhQcFc5NFJyNFZvWkd4eU8r?=
 =?utf-8?B?ZUVhR09QQUk0TFp1SjNLQU9XQXVWakQ4UlpjdHVoUHgwQm9MSUl1Mm9jb0NX?=
 =?utf-8?B?U2VlOXpnTW5ZQnJZSGNDRllvMFJUeXA0eFU4L1dNYWdQUDVvL01ZWXZTMXhw?=
 =?utf-8?B?SldsMXlMdHg0YnVHbkNCc3djTTFuOGRyWnBuZnZlc2NEMWJzak5oN1hPSFE1?=
 =?utf-8?B?dFhYWUUvN0ttRkFWU3lOVzVtWHU0ZlU2WlZ0QU1WY21IczhWc0VaM09LSkpK?=
 =?utf-8?B?a3g5ZlFoQkxaQUNtYk5LbzBhazFxbHROeUhtMC81ZVhVSndWblZyL0Jlci9M?=
 =?utf-8?B?ODB0elQ3SHVLNFBiTzUrQnRvNTJtaVc0QXNXd29McDBxUXpvZlZNUXM5Y0wx?=
 =?utf-8?B?a0huQTB6bDZYVzYvaW5waW5ERExEM2V3MStUZlh3cHVxTndXamdlUTEvdGZY?=
 =?utf-8?B?QzNVODVvSnNnaDlzTTZlc2NVWWkrSi9xcFp1TjN6Z3dlWVRtQlRnWEhxSmlQ?=
 =?utf-8?B?WXpramJOOS9QT09FYnVyWURqTzhXTUlXL096ZFA2djVPSktIUGNrL2M1c2hp?=
 =?utf-8?B?WTFSUEw5RDN6clp0WE04Wlh5cnVPTDlMKzJEckgzQVZPczZCbVR1d1UzbVNG?=
 =?utf-8?B?NUNyUHRrMHBxQ013WERKUlBTQ3ppb1FiSWVqN2t3cExNam9FN1F5ay9GQXBD?=
 =?utf-8?B?eWFRaHNRUmt0akRiNmZvUCsrTU9XY3NzQU94WXlkSGJSbFJqZGpjOGdBMXFH?=
 =?utf-8?B?RTVkK1ZKTDcydE1Yd0JVcC9yamhLeDZXdzg0SFo5NzkxYmxYSE84WUs3dDBh?=
 =?utf-8?B?VzdQVlpnZFk3eHlVTVArdklrYndQekhpY205UzhIaG03alVGazBWb1NhNmRU?=
 =?utf-8?B?eVNwa21lNWRJY0hsWGRpL3JXbkJqQTNDQXR0V1FIWHEvV0hIMThQeXFmRHlp?=
 =?utf-8?B?Z0FMQ0Y0SjZ5cmpneWdQVTQ0YVR2Z3lYQzZpYVFFT0ZHY0NIOFNWUER0SW43?=
 =?utf-8?B?ejY5UmlPdnNkaU5GbFJYZUxoaTJQYXN5OGk5SC95QlA4eWVSS25ocWt6SE5k?=
 =?utf-8?B?QURsQUt3T3k0cVd6VC9SclZ0cHJRS0NRVlNTWWlqcTh1anZnaTR0L1BDNGI2?=
 =?utf-8?B?WEdUaDRCeWRPaWZjSG5tLzB4UkYwZ1NhYUVQSStqME8rZXFrMlBIMWhSTE9M?=
 =?utf-8?B?RnU2d1FVVnNjU2Vka29BWUhTdmZuK1lGYzR4MDhack5lOW9JM1g2ZWFUUU1G?=
 =?utf-8?B?dlljZnFDOHFpaFRkSHhEUXJlWHRWVW1RQTRBMmdkTnhoMmxFZGI4VWVIQmc5?=
 =?utf-8?B?Q2hGaUVzZlp5U0g1MGwzeHY3cE1HSXJZbDgxOFNxRm9mRkMrTkV0SnJnVjVP?=
 =?utf-8?B?YisxNG5hZXRYSzltYnJmRXlCQzdlMTVnRWlsckE5K2hGaWZZbk5kcnJpZ1V0?=
 =?utf-8?B?TGVOSXhSVDN6cFJoc29sM0tmSWgzMkZycnZBN2swSCt2WHlaM0kxNXYrWmxR?=
 =?utf-8?B?MnJNbm5MbTRPZDVpME9rM01DY2JEck15NjZjTHpCaGhSY01JQ0JRM09GSjcr?=
 =?utf-8?B?WTNjSXlkRGM4TU01YnRpU3NyR20zY3VGK0o3ZG05UzhZTjduR3lVWjRNemp6?=
 =?utf-8?B?RkJqS0QzV3YwS0hidm5xNUdFQldZSENML0ZMMUlDUXFDQlZoWmMxM1VVQ2o2?=
 =?utf-8?Q?ftgmMuX58yAsCNHrh+?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b2915fbe-9588-40a0-8728-08de6af5c588
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 11:48:14.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIerN6qpbCcuO2xv306riKKbLfxo3lL80mZ+00Rhd/EpNSWqL6DfTABVAYTNBtjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR02MB10401

Hi!

2026-02-13 at 12:06, Marcus Folkesson wrote:
> There may be several reasons why you may need to use a certain speed
> on an I2C bus. E.g.
> 
> - When several devices are attached to the bus, the speed must be
>   selected according to the slowest device.
> 
> - Electrical conditions may limit the usuable speed on the bus for
>   different reasons.
> 
> With an I2C multiplexer, it is possible to group the attached devices
> after their preferred speed by e.g. put all "slow" devices on a separate
> channel on the multiplexer.
> 
> Consider the following topology:
> 
>                       .----------. 100kHz .--------.
>     .--------. 400kHz |          |--------| dev D1 |
>     |  root  |--+-----| I2C MUX  |        '--------'
>     '--------'  |     |          |--. 400kHz .--------.
>                 |     '----------'  '-------| dev D2 |
>                 |  .--------.               '--------'
>                 '--| dev D3 |
>                    '--------'
> 
> One requirement with this design is that a multiplexer may only use the
> same or lower bus speed as its parent.
> Otherwise, if the multiplexer would have to increase the bus frequency,
> then all siblings (D3 in this case) would run into a clock speed it may
> not support.
> 
> The bus frequency for each channel is set in the devicetree. As the
> i2c-mux bindings import the i2c-controller schema, the clock-frequency
> property is already allowed.
> If no clock-frequency property is set, the channel inherit their parent
> bus speed.
> 
> The following example uses dt bindings to illustrate the topology above:
> 
>     i2c {
> 	clock-frequency = <400000>;
> 
>         i2c-mux {
>             i2c@0 {
>                 clock-frequency = <100000>;
> 
>                 D1 {
>                     ...
>                 };
>             };
> 
>             i2c@1 {
>                 D2 {
>                   ...
>                 };
>             };
>         };
> 
>         D3 {
>             ...
>         }
>     };
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/i2c/i2c-mux.c | 145 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 133 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index d59644e50f14..9116ee3fd979 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -36,6 +36,100 @@ struct i2c_mux_priv {
>  	u32 chan_id;
>  };
>  
> +static struct i2c_mux_core *i2c_mux_topmost_mux_locked(struct i2c_adapter *adap)
> +{
> +	struct i2c_adapter *curr = adap;
> +	struct i2c_adapter *parent;
> +	struct i2c_mux_core *result = NULL;
> +
> +	do {
> +		parent = i2c_parent_is_i2c_adapter(curr);
> +		if (parent) {
> +			struct i2c_mux_priv *priv = curr->algo_data;
> +
> +			if (priv && priv->muxc && priv->muxc->mux_locked)
> +				result = priv->muxc;
> +		}
> +		curr = parent;
> +	} while (parent);
> +
> +	return result;
> +}
> +
> +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
> +{
> +	struct i2c_mux_priv *priv = adap->algo_data;
> +	struct i2c_mux_core *muxc = priv->muxc;
> +	struct i2c_adapter *parent = muxc->parent;
> +	struct i2c_mux_core *mux_locked_ancestor = NULL;
> +	struct i2c_adapter *root;
> +	int ret;
> +
> +	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
> +		mux_locked_ancestor = i2c_mux_topmost_mux_locked(adap);
> +		root = i2c_root_adapter(&adap->dev);
> +
> +		/*
> +		 * If there's a mux-locked mux in our ancestry, lock the parent
> +		 * of the topmost one. Mux-locked muxes don't propagate locking
> +		 * to their parents, so we must explicitly acquire the lock above
> +		 * the highest mux-locked ancestor to reach the root adapter.
> +		 */

As may be more apparent from my recent v4 response(?), this is not
what you want. You want mux_locked_ancestor to be the nearest
mux-locked ancestor.


> +		if (mux_locked_ancestor)
> +			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> +
> +		ret = i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
> +
> +		if (mux_locked_ancestor)
> +			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> +
> +		if (ret < 0) {
> +			dev_err(&adap->dev,
> +				"Failed to set clock frequency %dHz on root adapter %s: %d\n",
> +				priv->adap.clock_hz, root->name, ret);
> +
> +			return ret;
> +		}
> +	}
> +

Here, you set the frequency /before/ ->select.

> +	return muxc->select(muxc, priv->chan_id);
> +}
> +
> +static void i2c_mux_deselect_chan(struct i2c_adapter *adap, u32 chan_id)
> +{
> +	struct i2c_mux_priv *priv = adap->algo_data;
> +	struct i2c_mux_core *muxc = priv->muxc;
> +	struct i2c_adapter *parent = muxc->parent;
> +	struct i2c_mux_core *mux_locked_ancestor = NULL;
> +	struct i2c_adapter *root;
> +	int ret;

And here, you restore the frequency, but /before/ ->deselect.

Thers's no symmetry in that...

Cheers,
Peter

> +	if (parent->clock_hz && parent->clock_hz != priv->adap.clock_hz) {
> +		mux_locked_ancestor = i2c_mux_topmost_mux_locked(adap);
> +		root = i2c_root_adapter(&parent->dev);
> +
> +		/*
> +		 * If there's a mux-locked mux in our ancestry, lock the parent
> +		 * of the topmost one. Mux-locked muxes don't propagate locking
> +		 * to their parents, so we must explicitly acquire the lock above
> +		 * the highest mux-locked ancestor to reach the root adapte> +		 */
> +		if (mux_locked_ancestor)
> +			i2c_lock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> +
> +		ret = i2c_adapter_set_clk_freq(root, parent->clock_hz);
> +
> +		if (mux_locked_ancestor)
> +			i2c_unlock_bus(mux_locked_ancestor->parent, I2C_LOCK_ROOT_ADAPTER);
> +
> +		if (ret < 0)
> +			return;
> +	}
> +
> +	if (muxc->deselect)
> +		muxc->deselect(muxc, priv->chan_id);
> +}
