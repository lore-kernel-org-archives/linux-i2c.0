Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022127.outbound.protection.outlook.com [52.101.66.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC52C2349;
	Mon, 16 Feb 2026 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260048; cv=fail; b=bibnvZrsXffGjVRd2CEGcZ9nWcAxPUyd28hwxAgchkwKyUuEHi4yiflDMjlP/OfoyfgQSxMY9pN3xXBp5zka6YfY7LAOv2XOKB5beri6hlJ9sIFOMq+6p2vZSRv4xZKQXYK9PxkJpZrbIyTaITeCFo2xuBOgIH7r0q2vkBmuIOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260048; c=relaxed/simple;
	bh=Yex5nLLD9CpE281bQHYJAYz8pBx31Zp4ubAmrMd5JQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n3hm/+OJ+jTMdyVREUjnOaATIEQYtxtRWxT8nRB7pquCb5tCsmEKLPjDKnAtywrJoB8/rHTPTEi94hUvL+xIfmIG8Vl4yxJtI8bmcCMzY/Czky9ucWQ3njH7a82tcnOP/iVR+s7q2SznyFpMrKSCj+lhy4a4k27TeqN3IvseWlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=XzzBkpCw; arc=fail smtp.client-ip=52.101.66.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="XzzBkpCw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvVS73mbRd+o750iNbCr9E6VO48nwj4XXI9SpWnyDsnsSHsAbO6G9b9CxCCnvuEJamZepyilprkMp68cGhZgq2JCmEMaLzVUQ0ZJs/rLYb6jcL0gfoXb05eS+TslPlOaFmBMPsp9P6yV3ZFZk5tpgXWkej8+lBjUlWgqY6fsylVS6ZsZqgHaZkxqajz516iuF5yVoI2q8qzk8NCIoNXHMwEW5CPnXqAC/eqISd96q0I6JTnEbiVGsAOFqBI2crcMSaz5mIM0piSq6p97XJNg6gNcQFoRxdbWUJU0+cxKIrqvWa9THDnpC/7AHuByf39PsGYyUo455Lp2nYvb4JQ34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSYF9q41avcxMMbxZfX3p6jv0wki4TSzChe+VDuBaNI=;
 b=QPCCjN+eTXQb7Rac4yk5qIzeDyZ7pYMT3jyDVjVdVhxHtm2krhCgJ6GJRAt+fiWTxvCg4hmWSSXBcLXvS86g+yqpH/GThk9AmhUZpmehxRC+KzJqn7DsM1Ixkr0Bnc95UFgyLJMUPDvLZmpmIFhLRkLlWSlb0K/HGGIfM1DrKsuUhTJGXJNje53uYZX8z391qQdmS66oTpBs666Cs2zxpbohE0X3YLcmjVH4vpxpW3CkBHO03mdY4oE2+2xzmrZZSUjtcTZbYFZAf9P2VUlwu/ZSdAHV++FYJoG7PZVBaazHwDQbAg/ZdVB9bci1Oa5NLhwSecMne1flE1plEXkptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSYF9q41avcxMMbxZfX3p6jv0wki4TSzChe+VDuBaNI=;
 b=XzzBkpCwAaoLgev/4rhyel2/FdEx8v2bEH3oJeIS0mbNTLlJUdZJSOle2R2dF5vcvC6gqF/Vj/x0h+zfVl8MQvRiL+1hGFynjErx4xyA0X37J9UV2Agmf6eT+EOiwc1UP8dAjYt+8mIDX/JAH4cPsHaynHRGQhf6gnTzTgyfrKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by GV2PR02MB9589.eurprd02.prod.outlook.com (2603:10a6:150:d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 16:40:39 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 16:40:39 +0000
Message-ID: <ab7090f3-4c03-098b-b118-4cd7a68af8f0@axentia.se>
Date: Mon, 16 Feb 2026 17:40:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 2/5] i2c: mux: add support for per channel bus
 frequency
Content-Language: sv-SE
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
 <20260216-i2c-mux-v6-2-9be28ecfd7e3@gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20260216-i2c-mux-v6-2-9be28ecfd7e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC1F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::118) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|GV2PR02MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dbc22b-ef7e-4199-3427-08de6d7a1e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEVvNUxTRFBmS3FUS2h6L0RMalBVN0ZKSEYwVnpXUFE3YWNSdVpPQWlDQ2Fk?=
 =?utf-8?B?ZjcvUW90a0o5M1phRUgweDhDN0dVbHVCT1o0L3liNjdpUS9TUmltcC96azZx?=
 =?utf-8?B?RWI3SWNuVlNmRFYvR01GY3RkbFJ4QktYWTl6ak1jY05JcG5UbExsV1dLdVBh?=
 =?utf-8?B?d3RHY1dQZnFHcE9OckFFZHhmSHRhQmI0Qy9FcjgvTXRUbzNTNDZmOFE5R2Np?=
 =?utf-8?B?MUN0QnNHVEU4TWRKR2E2WFREbmpvdGVjb2ZXWjV4VTZvSTllbHFDUHZrbmcv?=
 =?utf-8?B?YkhlWW0xbDVYWjFIYjdlWmhrcnRIeVVxQ0dDbUo4aVpabE52Qm9DYjBubTAx?=
 =?utf-8?B?TnRhR3B1Y21zcUNTdHA3RnN6RVNneHE3WUNURW85NnFRRWU5OHFDU0tid0Vy?=
 =?utf-8?B?VThLdGlFY29iZXR1T2lCUjVXdUFJWmkzaVZhZFpEK25yTjNaMXRWdHJ6UkVu?=
 =?utf-8?B?KzlRR3pJU1dSSG00K2Q5MU5YUmZHbElOOXNYSEFCUTI0U1RpWFkyNVowZ1N6?=
 =?utf-8?B?ZEcvZERXMnRLMEd6bmVGQ0Z5cHd0TE5nQzNrQmE4bU5MdDVFZ3RhQXFMRVAv?=
 =?utf-8?B?VFdvdHIra2NZWmdDMktqTGdYNFZHN0FuenI0TlZGb1haV3p4anhkdURFRngr?=
 =?utf-8?B?MzVYMU9URis4TENDNHNGSjFOS1IxWitpZExDWTdVTVNsbWJIM2tRU1lROHQ3?=
 =?utf-8?B?QnBtTTVmbTZLYWVIVURRVElVY0hCQmtpeVRHeTQrREU5dDIwSmRPSGR4aGFW?=
 =?utf-8?B?RmNOSUxHZTFRRWJUaU14WW5FSkZjckV3WFRUT1hCVG9Rc0RQN0ZIYjZLak1V?=
 =?utf-8?B?a28vVUJEWWRYcCt5UmY4L1NFdytrb09uNHVnOGViSU1kSmQzUjFOMUJOOGVN?=
 =?utf-8?B?K0k1WkJtZmtIaithbVo0M29FV0FQa3QyL3Uzd1htM3N0dFJQbDl4bDRXYlJo?=
 =?utf-8?B?MUNNQXFHSGUwV0dXWFVNSTNidnhZTkdXcXVYRDE1V3UzYzFBNHNudlUvazUx?=
 =?utf-8?B?RkRlSGoxaHNqYmFGaHltWDJ0d1lSRGd5NDJyTkk0elVtOXBFL1BWR2Q5V3ZF?=
 =?utf-8?B?bWVSYzdvcmFNaDJnWWMrNFhkR0FGTzdOR3pOT1FyVEgzTndyZThxSHFPbUp6?=
 =?utf-8?B?UXlnMHRuazNHT0VzeDN5dWVDZUp3Zi8zTzdvYzJsandtZTl1UCtNNXU4MERw?=
 =?utf-8?B?NmRLeEFQcFBkczl5M0VuRHZCNFVUMzQxT1E3SmtqRGQ3Zk0yVVFLWEwzSDU0?=
 =?utf-8?B?Q3NjMlFSRGFvQWtCTTBBMzQ4QkVoRTJNWkJQNENWaFlxNmU2WnloOWZJUHNE?=
 =?utf-8?B?SGI3clFqVEdxbG42ODJFODY3QUpiRHBIRVZHNmdZL2lkZjFnd0xkcFE3LzA1?=
 =?utf-8?B?Ynh1WG1GNTdLRm1Yc1F6dmYrSHdkYjZ6WTN6bjUvNHg4clI5NFlENU1UWXZ5?=
 =?utf-8?B?dU9PVlNDYkJrdC81NVJHRnJBSmp1Y0Z6NXBHUUQweDVhOERIMzV5Wk5jUlFt?=
 =?utf-8?B?cDduWGoyZ08vaGVVMDZLdDFDUS9SQmNmZUltVHZYdUpHekg3WUxzdll2VWdW?=
 =?utf-8?B?UE9sNjNiUzZlWmN5eFdGeDhGSVdObmhJQnl0OTNudTJKSHVwRDh6dkhBRmpq?=
 =?utf-8?B?Um9WSk12T280NzFaejZkT2pTTVRDRGluTkFIZzR5SHNLcmJ6VjlHMjhUNytT?=
 =?utf-8?B?Tmp4d0RBOXR5SGlyYnZoNVZJcW0zaFBhS2VsajBCdnlyNDJrWUk0ODY0SUdQ?=
 =?utf-8?B?bEpka3I4eExYd2R0Nm4zMU5NOVA1dGp6S3dMYlFqSmtaMHZKK0xmQlQ2a1FK?=
 =?utf-8?B?cjJTMUlJaHhKQmwvYXduZWtKcHJrZVpmM0RlRXMxc2pqM0V4SlAzcTF3TDhn?=
 =?utf-8?B?blF4TmVxdDZnc3JRUkt1MlZESllvL2kwUEtjTExvdlRaTk8vbHpmS1Fpa3hY?=
 =?utf-8?B?TW9OOXJQYytqSUFmaWZNWm8rMU1qcDRvRnpOS3FvUStzZENPNVBFOU8vcHQ0?=
 =?utf-8?B?YkhwMjRwQW56aFo5VEY5cHB2WWhTUDdHUU91Z0FCMjg4MzdmWnIzcDFuVUs4?=
 =?utf-8?B?MUdJeSs4TFA0OURlMjBMRmNaaHNYTU9GdjFubzlFOTVvcGg3RzVMOWVSL0Q0?=
 =?utf-8?Q?OQQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3pYSGxvclhjV1crY2RDQnA5MTR3bFRtTTdxYWw2YkdYRnZYOWU1c3FxVEor?=
 =?utf-8?B?aUJlYS9LczVabmJteG1HWU1JMUF2RUdkemp0U2ZUL3o4Zm9rdVQ1d2gvNGh1?=
 =?utf-8?B?ZkFwOWwraUFmMlpYREJJMlo4WjdKYTA4TjZXZ3o4K29UVSttaWllKzI5UDla?=
 =?utf-8?B?c28zMDFTK3NIYThzUE5kZEtsMlFVUHA5bWFOb0hvWHRIc1hsUGtHalp0bXNm?=
 =?utf-8?B?TGNsYmc4eUUvK09mV3VQeTBRcWFYT01lbHRWMGNQRzBJZVBuUTFxa09UWmpR?=
 =?utf-8?B?aWtHbDd6N3FkaEpTeU8rQUNiUDFZaG8zNW1pOWxtcU9vN29lUXlWNFNmNk1s?=
 =?utf-8?B?UjJRMlhRdGR2U2dJaStGRHhpelMrNEdQNnpnbmgzeDlISGtHY0V0LzA2dnRh?=
 =?utf-8?B?L2ptTXdTRmNWVEtaZ0Yrai9JZkFQbHJWdHJJdzJqMHRQZ0NWTk15Vzd4NWxo?=
 =?utf-8?B?T1M0VGxwcFIrUGdMVmE2dlo3RGtKK3lMWWNDTWJVaW9WRnJ3a0JvWStEQXhC?=
 =?utf-8?B?UGtpY3BHczRJK1hVUXFtaEpmelJ4UW10QWQ1OFB0NzJQUExVdGEydFlidnNF?=
 =?utf-8?B?bXE2TUk1b3l0NUhycXFIaHIzU2w3blhQWXFoa3EvSlI5L2lhOUNEYjAzUll2?=
 =?utf-8?B?cFVVcFEvMUxBMysyeWh5VUFyYWxMYkdCa05McE9Va2RGb21FYlo4QmhudzVS?=
 =?utf-8?B?M21aa2tNN0oyeFFEYW01NkhGRUlsM1MwZCt0OUpHZ2lnbU5GQWd3Z0FLWmJK?=
 =?utf-8?B?aGozOTBVY0JkVVlYNmh5TFAvNW9kdDEyT2dYWTJpVDYrdTJBMHBJdVI0RDYv?=
 =?utf-8?B?L1l3bUhFVG9OTENjOVp1blp4NHBlS2RMckV2TjJML2lKMkxEYWV3ZzlEWng1?=
 =?utf-8?B?VXlSSnJON0hienpwR1lUalFMd2xZWkFQSWFBU3VSc0JyNzdqYTBxa3AwWkZ4?=
 =?utf-8?B?ak9wNmk2OWJrdWhEb3hIaytWemNyZGNrU3lDOFlCWlF4NmI2bUxjaHNrTUtL?=
 =?utf-8?B?K1Z3cjFwT1pGM3dhRlBia3pGcklpR0JzL3grZHhQV2lHRU0zUmZlUksweGlj?=
 =?utf-8?B?QVZXRXFtNmt5YXhnczB0R2c4aGVDLy9HSmxWQ0R1QUFBVHpTakNacDlRWWo1?=
 =?utf-8?B?L2t2QXFJVWtKOGxhN0FCSEIrdEtJM0tzWDc2Nm1zZXc2N0NPWG1ud25EZTVJ?=
 =?utf-8?B?bkVOSm83bFIya2FPdWJNclRlVnZFMWV1c0tYQzdaMzZ5UHdGQW5Hb0tDOVlP?=
 =?utf-8?B?MkFFSktyWW1FZXpkUXpOU0tYQ0NzVmkzRCtOdGh4bjZidGgzbFFibW1qQVVl?=
 =?utf-8?B?QkUwRy9EOU0vSWdobm9iSC9wMFllaVZCbVJlK0RPNUhva2lhZk5oVTJESktR?=
 =?utf-8?B?d0RML0ZBWVpLSFNpeHpNMVJETGFYT3ZJQU9GOHRaakd0Nmw2YUdYVTJhdmlT?=
 =?utf-8?B?VllNVUxWbi93ekdqUUtTeUpZZElzcHVaa1ZPZnRDa1JmOXd2Q1JFdTJMb3Zx?=
 =?utf-8?B?VGFWUVhzdkxZV0U0ektXSHRKSzBrSGFtK1lyOFlZWFI4bFkwVUVLTHhwSTFO?=
 =?utf-8?B?SUw2Qi9qMXVHT3RxazZVZU12M2RkYkQ0a21xQXc0RUxSK0huTzBEVFFQTmJS?=
 =?utf-8?B?Ky9haGhNSHZKNDVhb2NQL0QyRk1Vc0lZR2lhWFFFUUVkWUd4SVV3VFZWZmMx?=
 =?utf-8?B?SXQxVHVvY1BTbnZJZEVMbmhhZzQvdWJEbysvdHFlaHVQcjJhZnNOVGFBWVdZ?=
 =?utf-8?B?U2hvdWQxZExHYUd1cFU2QWJOeFZZdVJaL1NwbjViUFVJbG9PYkVjM0tmT0ZG?=
 =?utf-8?B?ZzJ3bXVRSDc3UnZhUUNlNERvalJ1YXozNXBiUGNTT3ZJYUdpUGFDMVR3M2lF?=
 =?utf-8?B?MldKa3VmQ1NaMHpGdFV0VVhWbHQ2U0YzQ0VGMkgwMGt3cE9Kd0tOTmdVMnd3?=
 =?utf-8?B?YmpORStzU2czUmk4Z0JxT0tJQVBjYk5makcwVTlFOFNRZXVzT093THJhTy94?=
 =?utf-8?B?NVJIaGpYaXpVQkt0UDhSSWlDSVE4NndWWVR2d1ZKR1JrbnozQXdRelk5T3di?=
 =?utf-8?B?amlvTmV6UVUvam54cmxkc3J3SkJ2WnVKdlQ5b1RuSkZISFRiWlB4U1hiMnpU?=
 =?utf-8?B?K21QNzYyays2WURrbGRVdWQ0ZFBXdDM2ME44dkdpa2JPRGEvVzF3UzRwUTcw?=
 =?utf-8?B?RGlTMitCcU5yaHZOSEpldDNXamFlUGdSeTd3WXhmSElYcTlxc3pwTkkzU1pZ?=
 =?utf-8?B?YVFqV0dGcFNYK3A3OHFLbjFWekpXMXNqTFZQMnZ4d25sVXBXMmtySFdsUVJX?=
 =?utf-8?Q?BLBqW8bDng8dyJpk6p?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dbc22b-ef7e-4199-3427-08de6d7a1e12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 16:40:39.2832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKGoB7Vql3WryTnN+PPNovEX1kRpmfZPt5hvcvWQrfQJkIgBQF18lI6ExD8LbGdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9589

Hi!

> +static struct i2c_mux_core *i2c_mux_first_mux_locked(struct i2c_adapter *adap)
> +{
> +	struct i2c_adapter *parent;
> +
> +	while ((parent = i2c_parent_is_i2c_adapter(adap)) != NULL) {
> +		struct i2c_mux_priv *priv = adap->algo_data;

This assumption does not hold, making the cast pretty wild indeed. There
are other i2c_adapters with a parent besides muxes. See e.g. i2c_atr.c

Cheers,
Peter

> +
> +		if (priv && priv->muxc && priv->muxc->mux_locked)
> +			return priv->muxc;
> +
> +		adap = parent;
> +	}
> +
> +	return NULL;
> +}
