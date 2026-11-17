Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.101
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794909692;
	b=2Yx4Fux65XoR6XobyO7zV7iYytk7rZHtxGQUsa6svpcBGo8x2ZQY7sddogOmsYIDq2bP
	 F05DB62yEj22hJSotCd12Q0yBc0Fq8jooEzUVEwgXzgj/CF3+IFlrlUMU5Kom8u9KwPay
	 dGItP+ulYAzr0dL3piKKeg0MPddVfBR2j4CyPYysv85wu9KKyxzXKE9+ZbSChAzblAmoE
	 lpeT13skazNW4bxJQ8jtm/lBUgyEHbReZenhse4UGFi5A62sIaZC/gP3ipjJNdJjCCSXw
	 aeNoRhhnfDg0HBIgWHRfLDnjenkdnGryDED9xQqQ00yMT7GbRhXU0ZL+7L3TAyUgAfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909692;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wd+q+q1B0EpOsj8l3RfyiGN4m0aqjMHCrU1KbhR9sZs=;
	b=hwuHGhhqNQ7432StY5mdIl66dEjO0OmD2heClPG3fjTVokbazaYkZY/slFB1D0PVEUmk
	 X5RnEXN65WlUZjQAcLvMhxCRqV+jBKrWbO52rBmgDXkE01qagsIti6GlBZAwBZT8DzgE+
	 Nd5aAZ1R6ql69ptRNrsWlivQUVrJoBtz54sbHU5arCqG7upLBA4QYNf+/YJJDZjeYkMgv
	 y3PxykPp/2bUXRkx1S3g5Y44D2L+7RJoEUr3QoqTYTNbwHd85HL7fDV7wpTBmOVvPveLR
	 NC3ugVetOL9rJ6iQGiPOkjsewxAgAHe7RzZ4V7g6kUwXzoCKoQKjkuKDgxrAVd2LsUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=BZs4uXTB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.101
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023101.outbound.protection.outlook.com [52.101.127.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11685606A323;
	Tue, 17 Nov 2026 10:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11685606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=BZs4uXTB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5UOQNoB/zXC2Zevlzz6xdyrxj/UiDflmUVNcH366bY5QRl9ar3mLy8UBWB979mO6OSGQGcfL5TJfS5fITHn6Siw+I18Qf/742bunBgzINy+kqrB6Je/A5WpknYJwXS51miCFwh0c3FcbAh5zISdvrTLFhCTDOi7IiOwdc4ApZWW30UDbpKRPw6bJr3aFaiIhsCk3J1fGNO1/jIfOSWxKQg1D3EAzSgpFWd+x6qjb0rKatUJ6Zd2YHdy173311xmog0R8Yn5aUjfIaSo9cnLLqKrmj6m6c+e/HYc/5x1kLoyieszRbF0CWGkyWEQj9SWNznSJAAS/GyqguBHv16tNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd+q+q1B0EpOsj8l3RfyiGN4m0aqjMHCrU1KbhR9sZs=;
 b=e2aSkCyExQuQzPVyVZiRBhs2KeO2g7f6YH2mDVusKoHdzl9b7bUW7Luf1BwNk/jp1fo26xKdbPuncT5lQrrx3mtHrSHjXfAFhaNtNtp3AvlVIj7n6uhDW8Xyka4KGmzhLt0/l2V6I9BjUUFgXo29jjrrepaxagvNUvpQh1igO7arYWpnIoXhcqiKiI2u5SqpzyoMWhIzNe4zyW6DD9An2w4EXG6MREBTb8yG3DB/H1X0bFO6320h6v+Slzu0S9YIvmrEmBQOje4BtMo7bnP/w7JbD0L75Kch5QW5gETnVGZUZ4w2BV4JuhnQYS5ddzLTifFOz6efmHe+gql1NbzARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd+q+q1B0EpOsj8l3RfyiGN4m0aqjMHCrU1KbhR9sZs=;
 b=BZs4uXTBn1eLFDDkhp4HTBkXyb6/UrRIsyF3UqywAsdLFOnwdviGudF2jBfFUYsZCqJSfIywEJSgRWyRsR30LN4J7BfbPsyHtDF8yVPqmpi3AUC3kUzLif22veR1cmLkVsZuYMXD5TSF3WPe7GUpWWw1zvazm9WEuOPjkkc0lT3atOBhF2p3BzFfQGa8Z2mi+Sz2ErtbvBeY2fKtM3riebzCQV4R8T1PTvGcKie4hsLp3nUEaxpA6H1f6n7oB+gxxBJE7sHUhasneSf/l9reFuzDtW0YSfnyIPHUgesGalLAld8JBhQ8zuQVwpll/MIh2lxzWO5zxa/S66rzenaPPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KUXPR03MB9438.apcprd03.prod.outlook.com (2603:1096:d10:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 10:01:29 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:01:29 +0000
Message-ID: <cd3d821b-1cc7-4134-b902-1f05ca2526dc@amlogic.com>
Date: Tue, 17 Nov 2026 18:01:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Junyi Zhao <junyi.zhao@amlogic.com>, linux-amlogic@lists.infradead.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
 <20261117-a9-i2c-v9-2-7b303c894fea@amlogic.com>
 <7026e0f7-5d7a-4756-8783-4d8558f420d1@web.de>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <7026e0f7-5d7a-4756-8783-4d8558f420d1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KUXPR03MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: d34ff406-4659-46f6-be8c-08df4491c010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261026121527099003|261026135527099003|261026140227099003|261028144727099003|10067099003|261022115727099003|261021130227099003|261021135927099003|261021133027099003|261022075727099003|261021123027099003|261022113327099003|261021121427099003|261022105027099003|261026130827099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	l3HnYdkiGf7E1+sKKUqjlkLC6MPjvufG1ZYA93ZUtSbhnQnh21HLwFelIGF0vL8I4VJzUkjcOzXMYxMqtwsS2U+twp09sMHAuC6JL9A0R8sTsd+Tl57apAI4m3O5EJqEfj/u5g+Pwa8lX0ULm2swSPQc88lNan17auZQNXNa/Sl49tklyZwMizjNY4+G1+dXWIxwpeKgu57PiCIsCyP6xGjkUuQj6Fp5n3DPW0RlAc9GkB1urhJM7R3RUe04NlUZmsprw0Uh7dbmgF1Zdij8P0ewWDHFIUZIq54tUkr4fjltnA0VkG9wwr2Gru/ad6MfFjy9QHNwKdZN9G5IFgXgm2Sd1HyNFoazToJssyIlCQhYfg84xjMzukKPf8dKhMVRc75Pt7eQCBvDN7qfW0Ti1GwdNcVr1zgk7dO7AxpWaLJ5q9RGWie+OzgyK2gf4RN/zUWzW8HnoC7uaDm7xWzxeACnHjNuUdfoxYpCYfRXJTR1yNy43pJXpbv1xS9o7YqjO5+9I9rlKiFcMbd2niiMk7CR+naZVlHs8M16gRMDHidwM5rackqe3yPrUZWaH0XFupTGOl0kHJ27jA+vTBJ8lAjJFWxRkmUk4jFBWB8CCjfVj7hS58d5UY6bG58kt0Jf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261026121527099003)(261026135527099003)(261026140227099003)(261028144727099003)(10067099003)(261022115727099003)(261021130227099003)(261021135927099003)(261021133027099003)(261022075727099003)(261021123027099003)(261022113327099003)(261021121427099003)(261022105027099003)(261026130827099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDBvUUtpam9hL25OQlRVNFJ5RmpDa0ExZW1KSjhnT2Y1M0hEcTNzcjV3eHNq?=
 =?utf-8?B?dE9QYjJGVGM4Wm43aDFTUXBpSEpsMG5MTldCNmd3ckFFbHBzQkp2Zzd3dk1N?=
 =?utf-8?B?NUl4dUhGWHJBZ1VRTWE2SmJ3bkFmV1l1OFNhOG1Nd0NvVmYvcE5aWXppY1J2?=
 =?utf-8?B?R2lLcm1QZU1QcXVta2p3WEE1cElTTWlpK0JyYkg2VVczN1V2NlpyQ2VFYjRH?=
 =?utf-8?B?cFNldTRLVUg4cDZxZEY0VktzeWFjdkF3K0N0MXNtOU9CMlZvaXAyRGxvWlM2?=
 =?utf-8?B?S2FOaVFpYkF4YTFKSWV5WWZOWXYxV3dNMURwOTNGUDJOMXVhd2l2bnBacW9z?=
 =?utf-8?B?NFJwVm9PbVVsaHlodFlWZDhDclE2OVZ1ZFVjbGJtZTczS2o2K2svYmhJWjdN?=
 =?utf-8?B?dkRBN2JkYlNENG5XZHE1RjBzdGluMjJBVjZGWnZVdEpZMkNDNHU1RjBlMGZR?=
 =?utf-8?B?K2RXcFU2bmVnc1d2bHphbzRPTlhPTFFDTnJxV0thMmFpb29hU0ZZVmZWdGN4?=
 =?utf-8?B?UFZlMTJSV2FIa3NrWlplWnJZNVRHZUcwUzhzRWU5YldVb0duNS9DbUNJeU1B?=
 =?utf-8?B?TFkyNDNkSnNLL2lOMEdhSk1CV01yV2JGbWU0Y0NieksweUhkbHJiUXdTM1RM?=
 =?utf-8?B?NDlXd0VNbU85aEx1dFFNdW9jRDRLYjhBdWpFYW9VbmpnRHNwTHA1UllmS1BB?=
 =?utf-8?B?aE9sUVl3ZWplY2lQS3BrdWRiZms2Z3Q3L3l3aktHa3hJN0p4WkNoVTNmeUhT?=
 =?utf-8?B?d1FxMGdNVVJhSndaMzVqaHFPWWw4aWpxWU9pR0tGdlI2eTE2YTBiczl0V0lm?=
 =?utf-8?B?SmFNVTRramFMKy9ET29Rbk9IdVEwM0FPMkh5V2hVWUVLK1pEODVJWC9qdWdV?=
 =?utf-8?B?YTZ6bFp6WSs4ejhTVVNUc0E0QWRYY3Rsc3RhcEJ5clltUWVvc05jQ3lleDJ5?=
 =?utf-8?B?QzFnTWhENUY3bURsWUZPb1h5YUEyRENMM3lmWmU2ejVFUzJoSVVLQm9JYnov?=
 =?utf-8?B?UEYrSk5Kb1MzZ2JOQ1YwRElOb1hLSDZ0aXgvOWduU2hXVHJuM1VNRG5HRkN6?=
 =?utf-8?B?NnQzZ0pFajN0M0JuZTdkcERqeWg1SDhVQkpzdjl3VytnOFhva09Rd3o2bUJG?=
 =?utf-8?B?T0FlV2FlOHJDRFRoQ0ZBcnYycnNjaGo4RUxkT2dWek5hU3Nsb3BUNFdSVWhS?=
 =?utf-8?B?Ym1UOUphSWdLVzdTckt3OVFOdVZ6Vk0yWjN6TnRMZU1MR2dMYmFocHN4RVFs?=
 =?utf-8?B?NHgwam5oamxrN3JkNFAxai8rOTh2alNSTWNlRVp1NlBJQTRSY3FTK3hySWo0?=
 =?utf-8?B?Y2hqeURYbElJSzNad2sxMXVPMkhYRlJwNjRuQ2xoUzg5aSs1M1RQdS8zZGMz?=
 =?utf-8?B?WjUyaUk5Y2JOaTBsT28vaHhFUkd2cmE1U2lKUkw3dFlPVEIyS1lPZ0RUUVB6?=
 =?utf-8?B?N2lENHZLNlBlTUlSOWlYRjU5azJTQWJ1R2twTTV0Y0dpckhSVi9zSXI4T2tB?=
 =?utf-8?B?MmNZbTFLa1AwOWRmaHA0QzU2ci84dEhWRW4rUGh3dFRrbW53VkNXTUpoS2RL?=
 =?utf-8?B?dUJNSENnNFZkS29KVEFidXUwNE0vQVA2aWxoTCtpWHREM0MxNnRwV2pIbisw?=
 =?utf-8?B?QU80MEp4V3JjQitzRmZKTU5QT3V2SFUvbVJ6MEdCeDRaQ0JHY3hjYjRHd0FY?=
 =?utf-8?B?cGMxZEpTTmwyQlFXT0l5enkyY1htalRnb3JBU2hYeFZFb096N2JuZzFhQ1Ew?=
 =?utf-8?B?YVZ4SGZCOGJ4amhFQy9rRWFZdy8vK0xTb25TWkg3a0paUEtrNWwrSUxpUXFL?=
 =?utf-8?B?cy80RlB2MVJqem1ldWROVmVSS282cTdyUk42VWFFVE1KK0FBT1VVQmtYcmVV?=
 =?utf-8?B?RjUxcFdJbGg1MEVJcTM2N2VBZWJja0FVNWl3VVk5MXRDU2xqLzMyRUNzN0NQ?=
 =?utf-8?B?T2FsYkpLdVhkSEVqMFB3bjVIQkZiaElRdFF2NndiaUJQOHRMWVR4b0dqYTB2?=
 =?utf-8?B?dGhkT2dzT25QbDZWUUNxL1cwVGsvZjVqc3I0THZlbVgraGRpV1pQTCtHWTBN?=
 =?utf-8?B?WENFb2EvUWdsQk5pSVNYaXBGZnZDdzA2eGswQTFzdlBybEpUYjFYQjhvSlNY?=
 =?utf-8?B?dkJnNnljajNvdklQVlMrZk1lcTJMN05EK2dwS1E3dWJ2WGVQTnJBQ0JBb3dX?=
 =?utf-8?B?OVJYYnoyMHo2amtkQ3djNGRQUExhczcvcW1JWFJyd3NlSjdDUEdYdlc5SmU4?=
 =?utf-8?B?WmlPWWpIZlorVkM3N2ZkTWNqNVpmL0dSRXpwTmRZdWoyL3Y3WXRkVzJwS2U1?=
 =?utf-8?B?bHE4WXFqSmt5S1hSaHdpNUhhelhGRDZVQkNaRVJ2Wkk0SFZiVW9MUT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34ff406-4659-46f6-be8c-08df4491c010
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 10:01:29.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnD1jhQIk0uA/ARh7EocX/DE6njS1xxg9bj6aMWGc0YJ/imzWhL0oa0bjMJbKxM8rQLDWKzHSuRWn8LUvIhBQFv9OjpF4InNPJjq+UGmNKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9438

Hi Markus,
    Thanks for your review.

On 2026/11/17 17:36, Markus Elfring wrote:
> …
>> +++ b/drivers/i2c/busses/i2c-amlogic-a9.c
>> @@ -0,0 +1,429 @@
> …
>> +static irqreturn_t aml_i2c_irq(int irqno, void *dev_id)
>> +{
> …
>> +     if (!(irq_state & A9_TRANS_DONE) ||
>> +         (i2c->state == A9_STATE_READ && i2c->pos < i2c->msg->len)) {
>> +             return IRQ_HANDLED;
>> +     }
> …
> 
> How do you think about to omit curly brackets here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.4-rc3#n197
> 
Will do.
> 
> …
>> +static int aml_i2c_xfer_msg(struct aml_i2c *i2c, struct i2c_msg *msg, bool last)
>> +{
> …
>> +     spin_lock_irqsave(&i2c->lock, flags);
>> +     i2c->state = (msg->flags & I2C_M_RD) ? A9_STATE_READ : A9_STATE_WRITE;
>> +     aml_i2c_prepare_xfer(i2c, A9_FIFO_FILL_FULL);
>> +     reinit_completion(&i2c->done);
>> +
>> +     aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, (last ? 0 : BUS_NO_STOP));
>> +
>> +     /* Start the transfer */
>> +     aml_i2c_do_start(i2c, msg);
>> +     spin_unlock_irqrestore(&i2c->lock, flags);
>> +
>> +     time_left = msecs_to_jiffies(I2C_TIMEOUT_MS);
>> +     time_left = wait_for_completion_timeout(&i2c->done, time_left);
>> +
>> +     /*
>> +      * Protect access to i2c struct and registers from interrupt
>> +      * handlers triggered by a transfer terminated after the
>> +      * timeout period
>> +      */
>> +
>> +     if (!time_left) {
>> +             spin_lock_irqsave(&i2c->lock, flags);
>> +             i2c->state = A9_STATE_IDLE;
>> +             aml_i2c_set_mask(i2c, REG_CFG_IRQ_ENABLE,
>> +                              A9_RX_THRESH_READ | A9_TX_THRESH_WRITE, 0);
>> +             clear_irq_status(i2c, IRQ_ALL_MASK);
>> +             reset_fifo_pos(i2c);
>> +             spin_unlock_irqrestore(&i2c->lock, flags);
>> +             return -ETIMEDOUT;
>> +     }
>> +
>> +     return i2c->error;
>> +}
> …
> 
> What did hinder you to apply further lock guards for such a function implementation?
> https://elixir.bootlin.com/linux/v7.4-rc1/source/include/linux/spinlock.h#L642-L645
> 
> 
Will do.
> …
>> +module_platform_driver(aml_i2c_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic I2C Bus driver");
>> +MODULE_AUTHOR("Junyi Zhao<junyi.zhao@amlogic.com>");…
> Would another macro call “MODULE_AUTHOR” become helpful here?
> https://elixir.bootlin.com/linux/v7.4-rc1/source/include/linux/module.h#L233-L236
> 

Do you mean put MODULE_AUTHOR in front of MODULE_DESCRIPTION?

> Regards,
> Markus
