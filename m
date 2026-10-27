Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793069985;
	b=GMX3d1y1EU3nNbZe8u/dgehIo4TiG4sZwtpMwTWwxSH+3UXCDuxRoOg9gmjkiq3Awcwm
	 6pprpVGPu88DEhQENGEGy1M3Hx1xAv1b+CR/yolNzkRMWEqK9FxvyVF19pjzxUBiv7L+h
	 t3VwcrhBl5xo8s5llDPKm8FGo624tYfVsyedsrCsiTpNDNe3x73Ky4I3BIgzVjURCu9gv
	 0EOXQ1lTrtddO/bU8HWEleGAeVRVp5+Sr4iqtj3k6sxnWWbHXIZpB1l1ZzaQ2HooDIh3A
	 KZyZNLNbxES47PXRvf2j6NQvrKYRE4dIrxt5a44mHptr7VOofUZ6wgHW0lpaXjxCqTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069985;
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
	bh=TjaQx/sqUWF4PdOJry9IYo9MLddQ3oeHMbJXM1pGeig=;
	b=McinX00G6meqq4e2B5kS3WBdEBcSIXiPfPhnm5Re7lwev5xh4XnviAI/SY7wXCo4BQ2O
	 Q42YO5CUs8RITGU/lbXE/YSL/fXY3d+MgBSyCL2HxU8vv3kT2ynVb/HJmEdilvf4mpa2z
	 LgTMPpwe5Lez3PzWQk17ve1r73EGpQ/vLHHtorMTRDUJ4VenI9duB9pVGg1c7XWoFJe5j
	 ZW9kJPbrCZh+gvdF3BU99RkNe7bdWntHumNb48AvNhg7xmjvdg0socUopohcBCX0HC5EA
	 UPQVZJ2tw87OYj/3T5nYxG2WbYay0XEYBKfGPc7jTv0TuhSq3q59wWzs5y/WBzP2hSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=WOIWDnf1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.125
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023125.outbound.protection.outlook.com [52.101.127.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B2606A323;
	Tue, 27 Oct 2026 02:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 278B2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=WOIWDnf1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ME1JsLQYnNlsGY0Rbc2mZmqXOkk6jNWjZU94XVNnlhr3hjf8Is6z7I1v7SmP7WU9vSLF6r9wnEStcsp4926RVVvPVVNecNu7OBWKBLiKdpEZ300HydavvbYzSGtKmlhYs14FFNMLzFdL6GqpGb9vnfGE3OLeDvqGakkrt5WISHepN+GSBU/z7Myu2igZzF9Mi9UqJBE/VdzpEMx8DWmL3lH11JviBcGvD7To/gjsGy1/cilDC4lL9GFNPRyqxbtH3dEHM3C7fzLxVJU9oA6OPYbDdDCEuv7tl+AvOOJ9JEF0hKwxCPJeeuPHXP4iCFihR75sr4mN4wO8Tce/cwJOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjaQx/sqUWF4PdOJry9IYo9MLddQ3oeHMbJXM1pGeig=;
 b=uGLAQNGyprXE4rkiFLbkpRG11XAnSJl4s6D2E9g5g/csscmha8LNX711G4YLDNBJBzQQGeuUn33rm99TK5wenzNOSkV1msufne18bv/pK3HD0ZJLDEc7U5y0em8042x9+SGyvOOtwOSCkBcRp7k9O0QcskVdr4sHnL9QgUKznu5Besxqy8J6HM+AQmgLCAvsxjvuq8pU7og6J8cTYd6Qkc+O8UER142vMwth993swnwpcYjiQbTV5FsjkN4G9YFuTcOdSe5DL5CFf68NLTXEl+zgJVZGE4RHkfsB3GsP7HpbrAG8bNLOIsrEPdZWPU1EM52EL/z3cgI5MUUrugLxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjaQx/sqUWF4PdOJry9IYo9MLddQ3oeHMbJXM1pGeig=;
 b=WOIWDnf1KFMGSx8prf3jhUF7iQfxiorQ/IfPuyG3lwMaVl5XZX0fGMdStJ3xjl4JHfAQB8IeBZyynM/BRJqRkm9guIoWs0LEKAcjNPDlwMe3y3Jp32U1sc21kftHTRPeohrwS5JvWT3QwRMmZc41CYDwbMlEsYQKi0GzhOWQvKjN2DoYslHaQxMBjf07yZpOuf2E3QNePQLLBlOr8xccTglAZhaS7HUPSa/O6gFol68uusfW3zgOtS5El5zjVS5k/LMrnG9QZGm+UP1lv/onI7qcMqNiPr5Lvqx/jhbvtoM6tSFNaNdUwcjNH4b/KqkC7iZU4I01AneLVQcTlzxDXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYSPR03MB8627.apcprd03.prod.outlook.com (2603:1096:405:8a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 02:59:42 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 02:59:42 +0000
Message-ID: <e5319105-0a88-44f5-94fd-6c78a0ab2ac1@amlogic.com>
Date: Tue, 27 Oct 2026 10:59:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Content-Language: en-US
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Junyi Zhao <junyi.zhao@amlogic.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Xianwei Zhao <xianwei.zhaol@amlogic.com>,
 Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org,
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022-a9-i2c-v2-0-45e3cef175bf@amlogic.com>
 <20261022-a9-i2c-v2-2-45e3cef175bf@amlogic.com>
 <at8nuDtiHEDq4AZ2@zenone.zhora.eu>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <at8nuDtiHEDq4AZ2@zenone.zhora.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:990:4::9) To TYZPR03MB6896.apcprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYSPR03MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b76911e-0d8f-4ac7-3ce4-08df33d6590d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|261026121527099003|3023799007|56012099006|5023799004|11063799006|4143699003|261022105027099003|261021121427099003|10067099003|261009223027099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	lHFxtwvoonQ09TOSNjCq/tsWApnE5WkdQKHVtz4O3KUJlAZu8l3oI8nO0H9J08tOuT3GmTaRwnifBrGs+CQj0taJlZfl1PO85H/sBoOBKWKzFpVLG3kSuicdbPMNKIDaw52W/qMIOJgu0r37SQjEXuLczazCZg7lrwMr7JtB4CqgDOCQkL/kdCgUDfqlI+LC59hxCy7LcPFlp47/YRjo2D2DMaoKuArwdNfoGQgWg+lQ3Jr9Dzwdd/g1aBikxnMdaa404lDdD12rl1drYv1lcGTETAl3TlyxtU6WNIoM7DuNz0hZQ/gW+5PyDaBoeLoJmbiix8xXppGfLserNSIlCJ+d+m+wUiFtfJftQQ+Br50ZLm8mh0KNesG34Qx4cD3HBohsvszyjcFdyJIkoiY2kJZ9luy6sZejafcTyGA1xwUTWJUM8x6zGiB2XJNzlmjwqBledkG4pAkeWWkjBulmnuvU4PQOrAA6nZrYDQ1hG29MsiGaHMBQ8DQKiX7KpCTLjImQk6RXp/yJtZHJU6xuPfmVzLfTWJ6vTw4Bd13clCqCgydMTJi3asmBiGjKxVtqiTkQgrgqKPW4Q+VzIu81TKxU23D4G/Kf5Ii2pwzGR2GYUz/H7bOlF9q7whmR7aTJL+L+/0g5UW/7DieB1f/rRv9fTaGQUZ7ht+MqQtStHSI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(261026121527099003)(3023799007)(56012099006)(5023799004)(11063799006)(4143699003)(261022105027099003)(261021121427099003)(10067099003)(261009223027099003)(261022075727099003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czdvbkJDZDJSaHU5cHVEZ3kxVlJFZU90ZC8wQ01vNTZyck0zanNHSVIvL3Ev?=
 =?utf-8?B?L1VjRUtsaDBoSVBvSDlJcklKenhwZ0JkS3ZrRHJkcGtNczNHbDdCMUtoM2Qw?=
 =?utf-8?B?bXhBQko0ME84eUtOdHdoK2oyaDJreVVWYXkvMWhJdUZHVC9BUzdZdFJIYzNH?=
 =?utf-8?B?QTFicHZzUG9xSlBweEJSMEFMWGNBVGxYcHhDb0pRMzlNWmc3SDJJZXowd0tr?=
 =?utf-8?B?b0dMUUpJa1BkY1RlbGgySmNEVHVFWHV2WVFaWkE5K2NMSUdKRGZ1aWJ2ZHAx?=
 =?utf-8?B?TlJsNTlTaTUvRDUwSi9TUGgwbjVIVmtKRVNPZmhOSk1pWWt6ODNXV3RlZjUv?=
 =?utf-8?B?RFg0SDhuQUhLOGwySmk0WCtlSTdPR2RESmxHSm5vVHlmMTVTcDBRaU5DRTFS?=
 =?utf-8?B?anU0bUIvMkd5QTU4cjhYNEtpQ3YveFhndkdpbkdMZFBlNzBPa2NxK20zT2VU?=
 =?utf-8?B?eXFSVWxZWGlOenFZdHI4M0oxZlpFUWdPa2pkTHVnU2dTVWRoOWYzV251ejF5?=
 =?utf-8?B?RVM2RGpFZkszNzNNZHkxajZ0bGMrd2s1TEs3dVovQnZKYkh0ZktvV28yam03?=
 =?utf-8?B?UFl1MnVOL0Z6ZDQ5S3dnTGlPdlgrL3dPY28vSVhlQXBjaGpzc2NLZVpyaHFt?=
 =?utf-8?B?ckpma2JkblYyU1UvRDEzUGVnMnNzRng5Y1JneWNOSjRoWXRJNlpPb0I5a084?=
 =?utf-8?B?WXRsOXlWaXlKR1NOU3E4UVZBaHBoOWxZZUIzaU5tQTRUKzFmckZ2eDlQcWU5?=
 =?utf-8?B?SHI3Z294Mi84bGxEVTJMTHNXMWlqT1BMWGZvWXp6RUZnN2RQRnJsM29ldHUz?=
 =?utf-8?B?cUpLY0xXR2NndndKL09qbWh4dXlNTzNoZ2VIMDdNQVIwS1p6d1BhcVZSenRn?=
 =?utf-8?B?ZHBnbnpmY3VSRCtITkpSNjY3UnNGSmZ6WHlGYnYxSTVYTmRDbFN5Zk9ybGNE?=
 =?utf-8?B?RWVDZkJmUlRnSWdscnRxY2JFTVNNdHk5VFo4K0k4T3pkLzlsdTdGMzlVQ0wy?=
 =?utf-8?B?V2ZUdHhPM2pkNW1LcEVwUTdaanBBNVJpQkh4WXd5RENhSUhTS1h6QUlDMkV3?=
 =?utf-8?B?UEk2TU5EYzJ5TUxXdWU0T2N0WHI2WEV2dXppNCtrUWNtMWYxbmRMU0p5aDhu?=
 =?utf-8?B?VXRubWhmNU9xWWNKeEtyUm1jbU9qUzBVeUhqWitCU25QdFc5aHIzVzcrbUcz?=
 =?utf-8?B?cDhEQXFZNkI2aHRFSjcraXBUaE9XY3dhbm03R1JZWWlvdmVLWTArQkxvVkR4?=
 =?utf-8?B?U3hqdm9GWllNWGpzdTB6amdOQmFzb2dQbVRDM0k5bWJ1Uk9VSjNoMVRCV3RX?=
 =?utf-8?B?TG1DVFVyODZhb3V5SW1RNm5zbXg1TElJVi9iemEvOUZYYzRYM0JpRmk4dUNj?=
 =?utf-8?B?akZZUFJhRW5WYldLSUJBMGRYU3FZRGlxbFBmM0tZbC9NWHE0UDgrL3pPT21z?=
 =?utf-8?B?cVcrM21QRWRPTUVZQVoxOFVNUWd3amFDOU1HeVVsaWR6NWlhdUZodHdsclpO?=
 =?utf-8?B?cUYrZjQ0VitXN2pRTk1VSkVLWUlEQlZTQlhJamFZL1h6MFFKQnJpYUsxc0Vy?=
 =?utf-8?B?WVRyeGxRRUZDN3kyRlNrbFZkc2lzU1BKU1oxc1l3UWN0anNhZzNhS2RqMTFW?=
 =?utf-8?B?UmJOU2p4YjNyeDVWODRDbFFjb1FiaU90L2VOL3o1VTcwdTk0ejdpWEc3aG1T?=
 =?utf-8?B?clFoN1pxd2Q1L28wVWJ5L2hFOVZDTzZCNCtFS21NYnhaMHJlcFZid0JiRW5z?=
 =?utf-8?B?MC9UMVZod21hZFdYOTNsaHZOYXhCUDRBVDdiWFVtekpNcGpmcnIrc2RBZ0hR?=
 =?utf-8?B?Mnl2a013cTYvelFnZTBJUnlhNzVhQ01zWk1aMVVFUmtFUS9Wa05UOFBHRC9U?=
 =?utf-8?B?aVYxUDhFZWl4YmFaNjZZN1V1eWo5aGY1YVE0SW9EVVlpQkpaQlRQRnpmWGZz?=
 =?utf-8?B?QnRPWFJjR1NTM1QwRTdxVnBYTVZoZWlZWFdGL3ltT2xkaFRXeTY5cEZ0Y095?=
 =?utf-8?B?VkpKVHRCS2R5d0ZFaFZ5MWFua3d5Y09HY2p6YmRqVzNRTngzVjlMQXEvcWdT?=
 =?utf-8?B?OXJCTmdkRmorWnJhblNHOWpLa2loWjJFd1pIZGY2U2EzUlQ3NTdmT0tCQ1Zi?=
 =?utf-8?B?Q2JoTEFhc0h0ZDRRcU50YWgvS2hQQjVWOXJZaVhTYXREQlA3MTROMEFqMG16?=
 =?utf-8?B?aHdhSVRSY1B2WDZRQzNoUitSSlJPNlZ4eGhicWJuQlErUWZrbHZ1ZForTjZS?=
 =?utf-8?B?eUVqVHZLaFQ5MXlXN3lJNmVDTWFNQUxZTmhoaEpNcDRMSTloOS81cEhEOUs5?=
 =?utf-8?B?ZDVpS0FhQU1kYmJzR0tOQktyOS9XMmpoSFZEMFBNMTdWZWQrQlE1dz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b76911e-0d8f-4ac7-3ce4-08df33d6590d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 02:59:42.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR1uhqYH4vMsCzfpbNLS/+2kGBJig79kljUJR7m8OXFVixBUR1s7c+KwvgIw1QpsQTUON022J11Oxnq6F0hf6DWZkVEu2vU+xy5gAXPkilU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8627

Hi Andi,
    Thanks for your review.

On 2026/10/26 23:22, Andi Shyti wrote:
> Hi Junyi,
> 
> Sashiko's comments look legit to me, can you please take a look
> at those?
> 

I'm currently looking at this part. Some of them don't have relatively 
good solutions yet, so I haven't replied.

> Besides...
> 
>> +static irqreturn_t aml_i2c_irq(int irqno, void *dev_id)
>> +{
>> +     struct aml_i2c *i2c = dev_id;
>> +     u8 *buf = NULL;
>> +     int ret;
>> +     u32 rd_len, i;
>> +     u32 rd_val;
>> +
>> +     spin_lock(&i2c->lock);
>> +     ret = controller_is_error(i2c);
>> +     if (ret) {
>> +             i2c->error = ret;
>> +             goto complete_irq_out;
>> +     }
>> +
>> +     switch (i2c->state) {
>> +     case A9_STATE_READ:
>> +             buf = i2c->msg->buf;
>> +             rd_len = min(i2c->msg->len - i2c->pos, A9_I2C_FIFO_DEPTH);
>> +             for (i = 0; i < rd_len; i++) {
>> +                     rd_val = readl(i2c->regs + REG_CFG_RX);
>> +                     buf[i2c->pos++] = rd_val & TX_RX_DATA;
>> +             }
>> +             /* Rx must clear thresh after read fifo */
>> +             clear_irq_status(i2c, A9_RX_THRESH_READ);
>> +             break;
>> +     case A9_STATE_WRITE:
>> +             aml_i2c_prepare_xfer(i2c, A9_FIFO_FILL_HALF);
>> +             if ((i2c->pos + A9_I2C_HALF_FIFO) >= i2c->msg->len)
>> +                     aml_i2c_set_mask(i2c, REG_CFG_IRQ_ENABLE, A9_TX_THRESH_WRITE, 0);
>> +             i2c->pos += i2c->count;
>> +             /* Tx must clear thresh after write fifo */
>> +             clear_irq_status(i2c, A9_TX_THRESH_WRITE);
>> +             break;
>> +     case A9_STATE_IDLE:
>> +             dev_warn(i2c->dev, "i2c irq triggered abnormally, irq_state:0x%x,irq_en:0x%x\n",
>> +                      readl(i2c->regs + REG_CFG_IRQ_STATE),
>> +                      readl(i2c->regs + REG_CFG_IRQ_ENABLE));
>> +             break;
>> +     default:
>> +             break;
>> +     }
>> +
>> +     if (!controller_is_done(i2c)) {
>> +             goto irq_trans_out;
>> +     } else {
>> +             if (i2c->state == A9_STATE_READ && (i2c->msg->len - i2c->pos))
>> +                     goto irq_trans_out;
>> +     }
> No need for brackets here:
> 
> if (...)
>          goto ...;
> else if (...)
>          goto ...;
> 

Will do.

> But perhaps the two can be even merged.

I will try to merged them.

> (i2c->msg->len - i2c->pos) is equal to (i2c->pos < i2c->msg->len)
> 

Will do.

>> +
>> +complete_irq_out:
>> +     reset_fifo_pos(i2c);
>> +     complete(&i2c->done);
>> +     i2c->state = A9_STATE_IDLE;
>> +     aml_i2c_set_mask(i2c, REG_CFG_IRQ_ENABLE, A9_RX_THRESH_READ | A9_TX_THRESH_WRITE, 0);
>> +     clear_irq_status(i2c, IRQ_ALL_MASK);
>> +irq_trans_out:
>> +     spin_unlock(&i2c->lock);
> ...
> 
>> +     i2c->state = (msg->flags & I2C_M_RD) ? A9_STATE_READ : A9_STATE_WRITE;
>> +     spin_lock_irqsave(&i2c->lock, flags);
>> +     aml_i2c_prepare_xfer(i2c, A9_FIFO_FILL_FULL);
>> +     i2c->pos += i2c->count;
>> +     spin_unlock_irqrestore(&i2c->lock, flags);
>> +     reinit_completion(&i2c->done);
>> +
>> +     if (last)
>> +             aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, 0);
>> +     else
>> +             aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, BUS_NO_STOP);
>> +     /* Start the transfer */
>> +     aml_i2c_do_start(i2c, msg);
> I think this should also be under spinlock in order to avoid that
> the interrupt handler accesses a partially initialized state.
> 
I will lock it.
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
>> +     spin_lock_irqsave(&i2c->lock, flags);
>> +     if (!time_left) {
>> +             i2c->state = A9_STATE_IDLE;
>> +             clear_irq_status(i2c, IRQ_ALL_MASK);
>> +             reset_fifo_pos(i2c);
>> +             ret = -ETIMEDOUT;
> the next instruction overwrites this error. Perhaps you could
> use a goto to spin_unlock and return.
> 
> Andi
>

Will do.

>> +     }
>> +
>> +     if (i2c->error)
>> +             ret = i2c->error;
>> +     spin_unlock_irqrestore(&i2c->lock, flags);
>> +
>> +     return ret;
>> +}
