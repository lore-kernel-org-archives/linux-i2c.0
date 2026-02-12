Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023141.outbound.protection.outlook.com [40.107.162.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806629CE9;
	Thu, 12 Feb 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908546; cv=fail; b=NdAB5Nt3fAu7daBubs++c4boR2K/79DBXfeheQHdOcf5CCy3ONA48mktzmGLEtd9I1QsZtlfMz3OfSrDloptgEJSv8nTV+kJTThsxQ+8BINNu2rPKGVxx7UdmhLYBxae9PyfEA8eFzWDStjXhzYIBb8zL/CdTnetjoVunJjF7Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908546; c=relaxed/simple;
	bh=3muN4VeE4optdjDU1J3dTZiYjihxTABrZDJi5BraywM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/k1VZImge5HxpagjyPBfzPPXVLm3cV4aExrzxGIkC4DgsmwSzvFZNT6FOuo2USCYhS5rS1lNEXwgyN22IJ7uPGV3tFpA6RaC/C6o2ejHLj56AXfDMMEbuOpv5bz0p6DJnaB3XuvWAiihbC1sRLRpC1oIhD/1k54lJcH7MGiV/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=jyfl8Br6; arc=fail smtp.client-ip=40.107.162.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="jyfl8Br6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/zUKjlLkTsP7aMEEP4N1Z30pc8yUZCPEF8KBIMR9d2G0kSITH0dXNJo+kR8h9Z3FK9NxT9Bv+KkSY03SE/Og9Nne8UthKwQ3EvwMuBnS+YTZRoQEIvkVtH9UO89yJJV1tGqGjUvng+Ua+Jk/VOyawk/pdl/VVTvGZXXemk7eeCmmNluWQxAn28kMvD5fkat90dRRKW47P+glNAcLAV8ewEmRqhtmqMh+bclj1EIbKtEyNsg6nqTz/rAwbFVEzQxxKICcPN0dVBGSIWa8VOvd1KaNMJ25Lu3R9SCc15FpcxyGdc/Rno07yOSA4xBT+Hi3aF+NBJ82fIg6UMsMg3Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Iu0gxguZujHcorch4QtQWnVO48o2ixZk67iurpOLFw=;
 b=inK3tr+R9PGbjsBEfzFleXZUtJRpUAogIOvnWLl0rcN0iDWDn2K1pVjwQCK7I7RWCIiIYE9/XdGpBu3wITck5Ylr1HpzBYhq+SE0kBDkn39qibBHChF7Qwnjq0yYXf5hHcdeSDqkkHx6VQxBGyHl/1pcCmn4uLHb6tMd4UAulbzxy6fN7JiuCAY46mrkl2OARzPL06IFBjqOlujg7OrZkdifNCn4VIgByRJusy4v2/edI6nxGhC4feiqlNRLmRrIIRSpmVcPSzl/+7BeH388xa/i+QtGKqi5Qi/QoynxKNPI6csWNthmspcYan+qBiTe9oJ8bmrj7WFYkQsQabQwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Iu0gxguZujHcorch4QtQWnVO48o2ixZk67iurpOLFw=;
 b=jyfl8Br6ISgHH9cBihd/XUyd0KYGllq/GsSdUUptbR/y7rjjfm4rX0n+UG2Pc+IgrqiUIPumaNHmbhZNjHwsEVxHFWFaHdXJyDreKKJP3OKUNCg1eyc9iKNtqSdNPl7hK9rr0j7v5Gqh0n9ygq1tSeqadR70gfA0NtYZxgXVpZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by GV2PR02MB11777.eurprd02.prod.outlook.com (2603:10a6:150:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 15:02:19 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 15:02:18 +0000
Message-ID: <2ecbebd8-0842-34fa-a593-25168c91aa6b@axentia.se>
Date: Thu, 12 Feb 2026 16:02:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/5] i2c: mux: add support for per channel bus
 frequency
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
 <20260128-i2c-mux-v4-2-dee49ce276c0@gmail.com>
Content-Language: sv-SE
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20260128-i2c-mux-v4-2-dee49ce276c0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00004537.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::349) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|GV2PR02MB11777:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f84786-1b33-40ab-8a39-08de6a47b75d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW9hMmlWYXVjdTFESkVBQXBPaEp3TWdJVGhjT0FVOUhZaEZmODU1MTdqL0sr?=
 =?utf-8?B?U0I1SElVeGdaZ3J5VWVHTXlpeEdBcHh5MVVyZWtlZld1RmtybUx0c2Njc1FC?=
 =?utf-8?B?T3g2cUt1ajNvcW9MNlY1MHJlVGZRcEZQTXN0NlVaSXNkL3RxS0U0ckhVY0pN?=
 =?utf-8?B?TGpCK2pWamJ1bTFDSzV0L05JL3YydTdvcnJhS215UEh1aTVBU2w0ZDA3MUln?=
 =?utf-8?B?MFRxdG5nVzNQaTFJYk9EaUE4VWJiSHkzbDlUanowRXI4aTNkczdjclFIbEhy?=
 =?utf-8?B?emxXUitGNERrZ0E1K3h2Wkk4ZFQzZDMwajAvd0syTWRGUkJETnVKWEp4Q2tH?=
 =?utf-8?B?TW9RMVpnWkJxdlFnamI5eHI3cXpTZVNCUVB0VWZyRmY1VFZVR05rdUc2Umxp?=
 =?utf-8?B?Y3JVVkxXVlVqUmNXZ3BpSmQ3MnRkQTVHTVlJVDNLVllZaEFWR1VHR0U3Vjlk?=
 =?utf-8?B?OEErdWEzVTFhdU5SUnRLL0NWWThVZElIRlBvSWhzMTRPTDlxeWlMdU1lcUZN?=
 =?utf-8?B?M1I3YiswY3kvalhGc3V0R0VodlFJNUU5SEh1R21MMmw0T2NSLzhTN25MeEZu?=
 =?utf-8?B?T1hVeG9TTjFvTXF2dFEwYnRGKzB6K2hGQnBCekc1eVpaZk43dG1PdXUwNWtJ?=
 =?utf-8?B?bjJFb1ZQWmhzdDdmSUp6R3g5WjdyODlXTkVmWXUxblJXbzhzSDJaQ2czSGRN?=
 =?utf-8?B?bzBLQ2lDQlgxNUc2YnI0Y1dyUENSWndVdmhnbWUxd0dESlpjaWswcytpUUZs?=
 =?utf-8?B?WEk2SkNHTFo3bjB1eGh5eGtvaUlCdXZRa1VnQ2VQR3I2M2xyT1NYcDZNbVJ3?=
 =?utf-8?B?YUFFN3BBS1NEOXdPdStjUFhTM2pGRHZINzJqSmtIcjI1b21GdmFTbkN2Kzlw?=
 =?utf-8?B?S2FWRGhyTzRkOUVZV3hYWlFEMUZxdEVITTFKYnVMQVNUd2FqZlByMHJKQy9N?=
 =?utf-8?B?WVQrcVlMSWNyK2dzcnM2UkNWQ09UUEtPSjRnRUxSZXg4UEYyWlFwZVpIMWhJ?=
 =?utf-8?B?ZWk2Qk5jblU1MjNTQXVsdEMwclJZZHlIQU1NQjgrc0IwVE1wL2hkczgyQzNN?=
 =?utf-8?B?WDlLRlZBSFdGYjJNMjRyR2QwZXQ4Z0ZQb051anE3WmRkeXUvQTlqRkdNTFdO?=
 =?utf-8?B?NGFKcDBFQ3FTb3JaMXNjSklha2VuTWIvQ1dWVXVoamNMdDViMjl6NlZQQk5n?=
 =?utf-8?B?andLWDY0dHoxWDk0QjJxaVhpd054eS9hYzlLMTFDTUYvNFhGdjZTcUxrVnBS?=
 =?utf-8?B?L09rVkJxQ3IxQ2l3Z2lma2QwTGR6WVozZW9zSDVJVFd6RlZ4blQxcjMrQVJ2?=
 =?utf-8?B?VHJxK0x0UWVvT1Z1T2JYZWNZL3ZBNXpzK1F5S29kVFhyNnFYTmxBSjRYbXBS?=
 =?utf-8?B?cTR4OEVCMjR2bjBoWVFHajhSQTJ3Mitpa2QxZzR0clY0SmEwZDNHMVh5ZXZF?=
 =?utf-8?B?eEc2UU04WW9rUWxLbXFMbVphQmVNdHZodkp5cy9mUkVXeW5FdHhjV3RtNWZt?=
 =?utf-8?B?MUxscVRwaVFNbXpGWGpmMG1oREhQT3lvU0ljVE9sbHRuNHZGTVpyS0lHWTJk?=
 =?utf-8?B?eEttRDl6Qk1EYUZ0dVFyTFUydHEwelF5WDIzSDFSSEdheGlHTnA1SHlxdmxD?=
 =?utf-8?B?YlM1U0J1VjZYL01KRHRiMFlCZEhKSVd0cnQydk41NE1jV2NiNTRsU2tFcStr?=
 =?utf-8?B?bDlJZUY4SkN3eDhGR2JaczJSSlQxdGp3R2hCWG9yMVU1WTBZVUNJZUZzWUpn?=
 =?utf-8?B?eVY5MklxVnc2OUI1YktkN2VYU01ZY3g5NkE2akFKZ0xLejA2QUhLVjFlSmxG?=
 =?utf-8?B?M1ZzV0VGWVdHb2tKYlBsd0Z5S2JoZ0ZWNGdEMHhndi9aZnZLSGNDbllaakhN?=
 =?utf-8?B?NDRIYkttQWx6cm5tQjRKRzJCelVKT1BIMy9QS2xiL3FORDUyNk12MTBvT3Zp?=
 =?utf-8?B?ZTZhNm53ZkZZYXEwbzh6TU54Y2ZGeThXZ250ektucFMxeHdNRS9NR3Jwajhy?=
 =?utf-8?B?ZDFIYlRocHVFMzdPVGJsSVVTTHgxTzBFeE9JSDdwaXVuOUxuWHVYOWlhODRN?=
 =?utf-8?B?QkpoR2E2V1BjM0FlMk1UZndLaS9nQ0lSL3lwYjdYRGE5TnN2cUdlUnZLSnAr?=
 =?utf-8?Q?nFw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG84eSs1K1VJTUJsM0U5V1g0T2pKWVJhY0FzWEttWXpDMXhNTUpEK2JyS3BC?=
 =?utf-8?B?akxVanNERG9HKzdNdXZzalgxcjFnd09pQk82NEJCK2syR1UrMWFPdXpIS0l4?=
 =?utf-8?B?MGlsY1hhSUFLaEIyTHY2Wjg3MG1FSjloM2dteTQxa0R3OHhKQktzVGVTNmJi?=
 =?utf-8?B?TWxmbGFyU2xkRk5PelFuSDFhRGVKS21NRFRyTVIwVWV5OTBhUzBmTGxFUTdi?=
 =?utf-8?B?WGJVaEwrYlAwOGdmZ1VxOXZwK3gybExjODE1a3ByRmkwSFZKY0hFcTBFZnMz?=
 =?utf-8?B?REZoUzA4eXNmNUUvTXFTZVNGL3lIT1NrVzZ3SFZRcDFJOUZZQmgyZjFWeWg4?=
 =?utf-8?B?VjVGV1BxdDdvLzlDeCtZT2psMVF6SllWSlRqZEkrZFJINmVSOXJoV1RkbjFY?=
 =?utf-8?B?UVdXUjlQQjI4NVNlQmprSFhkYWpHVmM4VldWTG9NYnpsUTFXaGJ2dzFKamd3?=
 =?utf-8?B?b0VjRFY2cjEyb3FOK2JCQlFBN1hhMlN5Z01SRHZ3NFNHRmVJUmRUWHBZMHRW?=
 =?utf-8?B?Wlo2U25IUUhXRHpyYzZzTUdlU1F4VGt0b21VakgxcXJ1bEgxRHQrbzRZV3dI?=
 =?utf-8?B?MDBxTkV1SnBQWXJqS3pPQ2hjYy8yTkkxR2NxZWtuQmlib2trWFJDeEVSa2Js?=
 =?utf-8?B?eU00Y3liWUoxWGNOSnJiNG9rcTgvc042UmVzL1VnbmVsd2dvcVdITDdrMmox?=
 =?utf-8?B?UjV3b2xCKzRFdkJQVkcrSkJlUXozYXl0QUlpcjBucGxyZ1AzYTRCaU9oN0JS?=
 =?utf-8?B?c1IzelFkZjhwenU3Z3NWd3NkQ0lWa1NEWEE1a2tIL3kyRzUxUnBLMW5EZGpM?=
 =?utf-8?B?aVAyRmdnYi9WRWFZaTk3R2NkTlhobXMvaHR5K3VTZVdscTV6MVZNQ0I5UkQw?=
 =?utf-8?B?VmQxRTJzSEhIdW9oN3JlQzY4TXNYNloxNWJnZmdQSldxTWdDSVBFaWZnZXha?=
 =?utf-8?B?TW96czBMYTNyYTN3VnB0WTVlSUFRQkVRaG5TdERWb1QwZlNzYjVoUllFeitn?=
 =?utf-8?B?engxTGo0MCtpWG82cy9MYlBYaFRZWFZiczR0VUJsL0tDZlVnY3hoMDlHNno0?=
 =?utf-8?B?bFAxTmo0M1lCTVVobFBPbGhhMzYwSG1VRWpFK01sNFhxUEJ1M1RacVhkVzVa?=
 =?utf-8?B?dDl1eXNKWUYreXM1VGVkWUJpZDQrOURXamoyZ0ZGVXZqRkt3amV6QmpRRE4x?=
 =?utf-8?B?WENKZTR3Myt5RnNTeDhHdkNnVUFWM0E4RkVhU0tJZ2ZwcXJBQThqalRXcWVR?=
 =?utf-8?B?SEsveXgxWXJqYkpzS3VNeFZmZnVsRDZEY042WTFoRUFJajZPR2ZseEU3NTZ4?=
 =?utf-8?B?ckcxR2VlSlVmSU9weHNSbW5jUWFhdnVFMU90KzlmZkNiMmFGd3BxOXRWNmU4?=
 =?utf-8?B?ckNQMnJoT1dFVmF1T0hnWVJFY01XLzhVRERTNHUrYzljMVNFUDdHSVpTZis3?=
 =?utf-8?B?cG52MStnVU1zaDdNeitOT1ljRnlFblZhQ2wydnRuYlRPSlpkZVV1K1BBdFZr?=
 =?utf-8?B?NkY0b3BaNXhHOFd5ZEV5clF3em4yTU1PaURPSWFKTEtoS2VqOWVrZkdnb2dG?=
 =?utf-8?B?V0RXaEp5eG9GdU42MWtyR0o0aVNEUmlnYzBaQU5XVEs3V0N3RGdRU24yMExI?=
 =?utf-8?B?ZjluMEpoZmYveFRiM1BiQjVWL2x0SEtsa0pGbk01REdEVG0vN090cEp0TUJk?=
 =?utf-8?B?VHFDUXhQY0UycGRHRXNOejVxOEpxV2ZVTlk2YlNlRUVtaFZMbFpKdTVOUXdQ?=
 =?utf-8?B?YTJMcGEzQUVhbzBOOEJyUXVyb3p5QTVIYS9PM2NJL29wb1RpTVZLTHhwZW95?=
 =?utf-8?B?SVZPUkcvU0xmejNHVG11ZlhPaTVsanZ6U2JiRHJEakNzVE81RWVrTlRyNUVE?=
 =?utf-8?B?SzVOc21ZbUgvMEVoVmtSUTVpVloxVVRDR3N4cDhyKzBaaTRtN1k2aWdzcmQw?=
 =?utf-8?B?eFozeGVyWDFvb0x5QXVDV0NlbTRrT1RvbUw5UWVCMjB0bVE5Y1JleUh4SE4z?=
 =?utf-8?B?QU5Wd0F6dEIyZ0pUMWtVY291c0ZQOXVnaUpzT3ZOb25oa3l3UEtUcFRCNzlx?=
 =?utf-8?B?dzZQQ043VnFnYVpRRFl2NzZaMnNsRW5lR2lTTzdQeXNTa1FraStBTXc3ZWxZ?=
 =?utf-8?B?aFRsbGhNMGtNR3V2Z280T0lTbERreUxrYWtuUGM1a1FGL0VoMnpqR3B2Z1FB?=
 =?utf-8?B?a1RRaE9DNTFxVmc1LzQ4UkVRSmwwNk5ncjdFakdXVzlqVUxlaEdTYm5YQ01V?=
 =?utf-8?B?NzUwYlNLR0FBdHBta3ByZUFyTWVoTFhaM04ySlpSb3BCdngvOWFLQnREam0y?=
 =?utf-8?Q?U9zjTk2H2A9RbaHCvt?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f84786-1b33-40ab-8a39-08de6a47b75d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:02:18.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZOYYbkii1oCwz/vb9rzbbod100o6rrzJO/DU2bKKzrxzdGPHI1MKVWKL/RLZ9d6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11777

Hi!

2026-01-28 at 10:54, Marcus Folkesson wrote:
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
>  drivers/i2c/i2c-mux.c | 116 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 104 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index d59644e50f14..b7974161be4a 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -36,6 +36,72 @@ struct i2c_mux_priv {
>  	u32 chan_id;
>  };
>  
> +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
> +{
> +	struct i2c_mux_priv *priv = adap->algo_data;
> +	struct i2c_mux_core *muxc = priv->muxc;
> +	struct i2c_adapter *parent = muxc->parent;
> +	struct i2c_adapter *root;
> +	int ret;
> +
> +	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
> +		root = i2c_root_adapter(&adap->dev);
> +
> +		/* if we are parent-locked and the root adapter is our parent,
> +		 * we already have the lock we need. Otherwise take the bus lock for the root
> +		 * adapter before changing bus clock.
> +		 */

The assumptions made for the "otherwise" case is wrong, I think.
Consider e.g. the case where we are parent-locket, our parent is
another parent-locked mux and our grand-parent is the root adapter.
In that case we also have all the locks we need. Trying to grab
them again will be a deadlock.

The more correct approach is to do the parent walk in search of
the first ancestor mux that is not parent-locked and then call

	i2c_lock_bus(ancestor->parent, I2C_LOCK_ROOT_ADAPTER);

for it.

Again, I think. Famous last words. Handwaving...

Cheers,
Peter

> +		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
> +			i2c_lock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
> +
> +		ret = i2c_adapter_set_clk_freq(root, priv->adap.clock_hz);
> +
> +		if ((root != parent && !muxc->mux_locked) || muxc->mux_locked)
> +			i2c_unlock_bus(parent, I2C_LOCK_ROOT_ADAPTER);
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
> +	return muxc->select(muxc, priv->chan_id);
> +}
