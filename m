Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021111.outbound.protection.outlook.com [40.107.130.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D9189BB6;
	Fri, 13 Feb 2026 11:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770982657; cv=fail; b=OGMoG6I5THqEOe+mEn1yzTIz3O8yfzDZ+gmvcRwhaV6v+doYNk+kVSORyMJl3kAF0Zsfsdz0G9/lhAkA5JiV0rPWBq97pYMvL9tI0LWlBkhoXFatPi+oPDhLL19t+E0T0uQgZpSUyNTASUzcEclqEmzCLYQ5OrOMCkCBsBrUtMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770982657; c=relaxed/simple;
	bh=IHDIlvQuHMPIdM2Ap9NO93uO+DybcM6STQ8a+3Cbvug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KXRndfXjonCUW6T07fWfmkueHVHcHwTGjtXCpTdXVQfs9HTuM5/JbE3nMb3ngucovO/m/ps+55uu7MtGTk37Ykfij3aQ+h4S0wNal0GA+wzWtwjkRzBnfdOE7dNJkOO7B16gMKacGzcVBbVrHikDbU4aV4tnHLcj5yKzUI2A7LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=Zs/RQU29; arc=fail smtp.client-ip=40.107.130.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Zs/RQU29"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBEHUkYRLwepg4aOxHoMsL9SVVj51rfNDyEecAOcpV7Bzwqh7UQFTiP/0e0ca6+W9ME0md4S/X04nSJFtiT83JaARot5nRNGqVLU/bUNFp+mHn0ihxyAlbmM4ZInAIouOPvSK9dFyt0t2etW+VibsuKf/NHuCS4zVG/m9m6dE1VhaKopqRrDPwyBXvuImfCOAN3inS8B00iZS7VBZsrykks8dKa/63vWxmcbJ//LCXRv9If9PFkqPEpM2H6imdvdEI1U8UwQHQXQXa4QVQB+bC6UbGqVLDTESCiZtctr2q4UO8uSh2Lmfv3sGp9oqHdb60SklnPt31GH+7ihbjDkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fOZBwXC4w57k2Cwg/bwbZ6SwA1coLkgaqCs9O2ONMs=;
 b=Tnfys3Y7v24rLJuTaUtX09fXmp2BxCtIcEYm4BoYlI8ZV/o3A9Dk6VXSexP0TrHrsXVQ6lbBvkG6AE00i45pMolvvlwv9Wa9UzlHpKrPe1gNabQRfm1Sru5atUASJ9MV+80hoEdDwaP0udV000t+EGr6E1gaX4MMdA2Zq96K9pGfAXan8f82kC2VGaFIf+CdA6oBX3nX1EOyYJF2KCYtlU39jsMD9oc+FawcOIU7WmREVgzwTwkpnrRe6BIeHngnSwfQW2ad+IzZ4Gj8RL/zQJMPT9AzJv9Er303pw3wa9HUMdFfQQ5n+Hok4qXEdNOgX4FoCJ95XsHhetlyLU6l4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fOZBwXC4w57k2Cwg/bwbZ6SwA1coLkgaqCs9O2ONMs=;
 b=Zs/RQU29EkVO08+naf6q0MUhBG61WGlePVJvKK9Aul5ALifJsHK6hvEfRXI+ufhUux9cdesysRr6kgI8CJyZBu/JUFC3TvX9Gqrd2IXwiJXl+xOZsrTCEjxOLF+DghEZJNNtLhw5H2/ij9CsrMUb+Be4J1rLkxCVDCZz0LdayBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com (2603:10a6:20b:5c1::5)
 by PA4PR02MB7150.eurprd02.prod.outlook.com (2603:10a6:102:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 11:37:30 +0000
Received: from AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714]) by AS8PR02MB9235.eurprd02.prod.outlook.com
 ([fe80::32a9:a9e6:ded:5714%6]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 11:37:30 +0000
Message-ID: <f38230f2-f74b-cf89-8d15-194d85f341df@axentia.se>
Date: Fri, 13 Feb 2026 12:37:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/5] i2c: mux: add support for per channel bus
 frequency
Content-Language: en-US
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
 <20260128-i2c-mux-v4-2-dee49ce276c0@gmail.com>
 <2ecbebd8-0842-34fa-a593-25168c91aa6b@axentia.se>
 <aY5KeH3Z1S3MswHI@gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <aY5KeH3Z1S3MswHI@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::7) To AS8PR02MB9235.eurprd02.prod.outlook.com
 (2603:10a6:20b:5c1::5)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9235:EE_|PA4PR02MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e2a003-12b7-4f26-c40b-08de6af4453d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WllSZ0xkZ1hJWkVWaFVvZktsZ3U3TGxhZjJ1aXYyQytYOEVFVnh0L3F6VHMr?=
 =?utf-8?B?UU9FWnZKNUVEWnpoRzBlVHdDeGk1SDNqOTA4NWF2TFJhTWRSWmpWU0RwSGpw?=
 =?utf-8?B?V0kyYW4yOWtzNzNYRGFISXFaREZoTDJFU3JZMkd3b29rclp5QXlvenEvRmRr?=
 =?utf-8?B?SWFmK3IzVTNWSjVyR2NtYjZNcW9pRmtsSzBNVk1BZjZTNi80alg1WWFEdnpT?=
 =?utf-8?B?blY4TWxjUmZCeHZRQWVSZHlUdjV4QVJCRDBDTzlDQjdiT2dNT1FMeWVYOHFM?=
 =?utf-8?B?dUppcm5VRHp0M3VjZk5XTlRNeFZBVnFMd0NON2NhNS93b0pVd3VEVUdBZmRR?=
 =?utf-8?B?RnQrUVBYbUlNb1h4aGRvWGRRQ0VidjhWamJISDR4L0EyVjhjTDhxYzhJUm5C?=
 =?utf-8?B?aEJ3VGVBUFg1bW1kWXBNSmppU3lGK3VlLy80Zm1LT2x6Tzg2UHJYVHNTc2tZ?=
 =?utf-8?B?bm54M1paMHBwdUxkVlNHTXhGQS93Z2tsak8vNy9iU1dmd3V3SkduWXc5TUpu?=
 =?utf-8?B?Mi95Vjd2b1llcC9XRHVsMGZIemdiVFJ1cjk1UjlJL0NPQTlQZmMzcGE3WDht?=
 =?utf-8?B?YloyTGxhOFFSV3ZSaGFFaE9ZWjV2WmN3TWtRV0VhczhKUzRiU3lqTXZoSVh3?=
 =?utf-8?B?OUkwcWQ0R0YwdlNIY1NnLzVIYmYxOVFMTUhRTkpTWXZWL1NidHQ4TjlwNFdE?=
 =?utf-8?B?OUhNYUZFcVhVNDVpWVcyZzB3QTBGbGdUeC9FVW9JM1QyK2FvLzhqblFDeUdy?=
 =?utf-8?B?enhMZlRvdi90OHNsVlVvOFo0TVpWdFNkbEJqaFVvQkVKcE9iWVhDRC81WHNy?=
 =?utf-8?B?MFZnMW8ya29XVmdIRW0yVnlBY2hoNWg4YVV1UFZXeHBoampkQ1J0dnRnVGhz?=
 =?utf-8?B?c0xvTkMzRlp5OVFGTmZLNEorMUZLbk1MdktTNk1uUDFybXJ5YUU5bURZcDFU?=
 =?utf-8?B?UkJZS3hCS3V6ZjdKTDlqSGVOVzMrQkZIK01MZVMyQWRKbWFNa1ZjWjR2Uko1?=
 =?utf-8?B?ZUUvaHdES1pjWEVmVmhhRXF2ZHRBTnBSQnRQdUFkOXkxcGFZSXVIUVhJeFNh?=
 =?utf-8?B?MkhCNkdFN0dhbE02dzNlaWhZZE1SbWtWRVdDaCtRdzAxUXpoK2VJSFRjdzRR?=
 =?utf-8?B?TnJ4UkV5VjR4UTJWc2FnTll6NG5xYTZEeUd4R1JHZ0duUFN0OVc4Rlk3Ny84?=
 =?utf-8?B?WGd2cDdEN1hFYUZYY3Q1WWRHWmRZTU9KWXhrSDN0dERQSTY2dWdES2FzWFFC?=
 =?utf-8?B?enJ4anZrbFJSRjdlNmx0UjZabVpkRHJYYldScGlFblRaWGpiOGdGZWR1bHNW?=
 =?utf-8?B?a2lEakhzNFA0NUwrUkdHRWo1aHNwYlVjY1k3UW5pQzBUSk5sTjhyWTJqbmw5?=
 =?utf-8?B?eUlYSUVSYkFOUWpWeXlNZm1XUnRJSDlVY1h4TWJ6bTZhN3ZDdWV3RWNlS1Zz?=
 =?utf-8?B?WEFXd2xZODBrbTZIYVZ4ZGMvcnlnN2dLc1N4VVVTWFFINWlRVStrbkNXbXhQ?=
 =?utf-8?B?SG1vV1pvdXlSdjlyazRQL2lVQ0RMM1NYS1k1cFF3Q2lNdEFmNE12endramFH?=
 =?utf-8?B?RmVGaWJRdDZwUkVPK3E0TnJhMmFVbHR4dm0vTUlFb2xLeG5wVW5VRmIxYkZ5?=
 =?utf-8?B?Z1ZsYS9GNjZUQnVpRHY5Sm15cndnRGdHbHhIR3FrTUQ0S2N2Y3BFU2t0anZ1?=
 =?utf-8?B?dmEzUWNqSnNqY3hrSjRyWjJMNkoxS0Q2YkUycHpXa0F2S0lHUjh4V1RnMmg5?=
 =?utf-8?B?QUxnSE9QZFNHSFpoMWR3WC9sRlVuRVAreFplM0NYMXpsZnBDaFMva2ZMRUlz?=
 =?utf-8?B?ZlRtajN6dlFvU1RUaUhyemVpUUZLaGNJY0JaMm1LZDRRN1A2enJsWitxelFV?=
 =?utf-8?B?U2lvOVhpS0NYc1N4aURzREt6Zjd0clR0L09SNE53a3dFbk1xTXF0NlQ3UmRJ?=
 =?utf-8?B?M2lodnF0cTVmU0ZhWlBJNUMvUjVmQXRick1IV2YyWVRmMERCNkxjNW1qUUxx?=
 =?utf-8?B?bjExc2ZXL1hGV3JyWGhSVVVtQVI4N1RodUFVOGZESWVtQVF6NDhvR1ZuOHor?=
 =?utf-8?B?bWlJQVEycFNtZ2hVWmdWNEZ2Ky95TUZaTVB4cVE5MWtrSndYS0N6ME1lMzVF?=
 =?utf-8?Q?VRuM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9235.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGtjL1MwZ2tHUnl1a2djY3lPaG5QdEVyOXE5LzQ5RGg2ZCtTVHQxdnhyTWVO?=
 =?utf-8?B?d0cxVkRJR3RLbWlrNmg0NHdXbXdET2tIeXJIQ0RKTVZEdVlUUEJ1Z3huY1Nr?=
 =?utf-8?B?aTFaWFZYYis4UmJyaXNDUHlqdVZEazZyT0VEeU1KUVJ4VUlFdmdmeVUrZ083?=
 =?utf-8?B?OGdpSGh4b3RQVG5uZGhxSFJHclJhVzBlZUY0UU9nelBuY1p6VG15VUNtV0lU?=
 =?utf-8?B?dTI0ZS8yeVVpdm1ham5selFoWWJqZFAvMFk4UWNYUVhkRHBzOHU2ckRRcWpo?=
 =?utf-8?B?WlVrN2hGZG5jc3kxaDliNDY4R0JxQzMyZ1hNTGN4am1GQUFFZW9oU1ArRkV3?=
 =?utf-8?B?cXZvMlA5UWhRZUVUZmk0VHBNbkNmcTM5L3ZVMGVNY1RqNDROMHo0Q1VoSU5l?=
 =?utf-8?B?N3ZMYnYwNTlqOUJPVW1McnJvSGM2KzF6aTF6TTZiK2IyS2V5dGYvMmRFWFFP?=
 =?utf-8?B?cWhMS1p6U0hqcGI4OWRZdTRqTjJCQTNTdEQ5T0FTTFJHZk1hK2JMSnJpQ0dB?=
 =?utf-8?B?d3VNU2xWZlBlb3VIWW4wM0ZBTVI0SVNLNWdGWms2TXlmMWwwY3FBbUxydVVu?=
 =?utf-8?B?RjJGZGVLOWRFeHFtNHJ2UmRneVlONGZLbXFyVlpwZTVkZ3dzRlA3TDN5aStK?=
 =?utf-8?B?b1dOT2tqa2RjVHQxZ0M5R0NNNHVCKzhSYkJibjgvNlNPR3FRM1VMQTBjQmtY?=
 =?utf-8?B?QmVaNEw4aHVHRi9IOXkrbGxESStkMGxEUTZJTy95U2JEMTJWN2E4VVNmbVp5?=
 =?utf-8?B?aW1UR0xyL1pDS1k3ckdmUmo2ZTl2TnRCWXZjOHN0eUk3b0JSdGtNakhhSnI4?=
 =?utf-8?B?NG1FNldaY05XWFRsWXEyVzRQbEFvVUp2b2NhVngwTGE5SGZWTE9iN2ZJTFRj?=
 =?utf-8?B?TmcyNG9FaDJaVGN6RGNmSExWQWIwcGhQLzlkQkM3T2VCbFpxSTF4cWhNWmh4?=
 =?utf-8?B?aGZwVldVV3E3Vi9YMkkvSkFrWWl0bkovc1RwYTQxMW53TEU3cFh0czlLRlFy?=
 =?utf-8?B?K0ZOeE1ybDE1ZWU1V3dnenZhcHQ3MDhkdjFJLzFSMHZwQkQ2STZCWVVtN2Zs?=
 =?utf-8?B?VVExMEdxZ3BXcnFWMTdxeGxqS1NpUXpYVGd1YUEyTW83cjBsZER5MzhEWjNB?=
 =?utf-8?B?SjZIaGhLd09XMXRKTjMzZzlXQ0J1WE9qeFYyQ3hua0tKL0ZjZ0UzSmdBMjk2?=
 =?utf-8?B?UXJhUm9qbXNEdExPbzZGbnd6TlNkNERUejd2S2lhZ2lHRU9CWlNIUm1FOG96?=
 =?utf-8?B?ZVNCbkpXOTA1TlpEUmVlbUk4bVFzSHBZR3ZzOEJoVnpIdk81NkdteTV3RWU1?=
 =?utf-8?B?b3FtWGoxYVA5bWlDbUhFWGk2cmR3UyttcXNacXJyd3ZQd0ZtcDljUUZ0cmtH?=
 =?utf-8?B?ZDJNR3VPdHllTWJ1cklhOGpPWXAwdVZVZVkrZGF4YW1scHZTS1ZSd1pXQWhk?=
 =?utf-8?B?cDBna29sWFlBbXh5czN5anY4ZmNPTnFGK21RNFdJUHJhZXdPWGhEMThSQVNt?=
 =?utf-8?B?Z3A3dXN1NmZtM2VvZW1URDBMMWVOenhtSUMxWTZQQjhuKzZGMVZvQzRqZ0hw?=
 =?utf-8?B?dm9oOXNueG9QM0pVZGEwclZSZzIvRFlrdXdEemFSOHlxWXN2VjRCcVlVdnZ1?=
 =?utf-8?B?M2FVU0EzakZreUtUZ25rNEVxOENhNzlLYlNab2xZY1ovL1EwcVJsVXM4c1B3?=
 =?utf-8?B?K3czbGNxY3NxYUxoN3JQZGR0cGREbFdOQXpHUWxCcm1lSU8yUkdxWDB5TFgr?=
 =?utf-8?B?RHhFY21ZSnhPQkw0ZmdYR3NKODJYVkZIWE5rb05VR0tvdUlMVzRDNG9GcGdX?=
 =?utf-8?B?UFY0SzY4WExlbGI5SEdMQU5NREx4bEEwZWJTdXQ5bUZxcDkxUmdOcE5QcWN3?=
 =?utf-8?B?Qi9MN05FUWpRVkpTSnVVdVR0RVpMQ2R2TmI0MjVPOElLT1YrT1dyZXoxLzNL?=
 =?utf-8?B?SmJxR0d3K013eWxjb0E4akJGRVNzTW52NXFzY0pDNEhBWERldjRuMzZJb3Y5?=
 =?utf-8?B?bitBc1lCTjgweHRuaTZabFNNay9mQS84NTF3blRVU3F0MmVPNklpSWdkYzVk?=
 =?utf-8?B?ekxsYUp6RWFxQlk1UzN4aENsSXYvUjFtVUNaTFdKenNlcjd5L2IxbkQzeVVV?=
 =?utf-8?B?QVVlSCtlVDcyWE9WdGFlM0orT3hwZDZlWWlRa0xveFlnWDYzNXFwOFEyRTQv?=
 =?utf-8?B?alZHQjgybXBOVFZ5NTFLKzBWQ1krdVkzSVg4elo5Ylp2NGcwYlhtQml0Qkdp?=
 =?utf-8?B?dHZhMmpMaTR3UmVWbUNYNXJuaTdyNllWSVJJeWFJUk0xVm85M0g4SWIweGYy?=
 =?utf-8?Q?sYbY/JaDk3eHuQedQE?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e2a003-12b7-4f26-c40b-08de6af4453d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9235.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 11:37:30.0891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uZQiSJ0uFIpJC9RpZwduN8UTEIfKh/2kdbFtdaU+vxxVDTF7lyW9+L6+RxEzs7i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7150

Hi!

2026-02-12 at 22:47, Marcus Folkesson wrote:
>>> +static int i2c_mux_select_chan(struct i2c_adapter *adap, u32 chan_id)
>>> +{
>>> +	struct i2c_mux_priv *priv = adap->algo_data;
>>> +	struct i2c_mux_core *muxc = priv->muxc;
>>> +	struct i2c_adapter *parent = muxc->parent;
>>> +	struct i2c_adapter *root;
>>> +	int ret;
>>> +
>>> +	if (priv->adap.clock_hz && priv->adap.clock_hz != parent->clock_hz) {
>>> +		root = i2c_root_adapter(&adap->dev);
>>> +
>>> +		/* if we are parent-locked and the root adapter is our parent,
>>> +		 * we already have the lock we need. Otherwise take the bus lock for the root
>>> +		 * adapter before changing bus clock.
>>> +		 */
>>
>> The assumptions made for the "otherwise" case is wrong, I think.
> 
> I think you are right.
> 
>> Consider e.g. the case where we are parent-locket, our parent is
>> another parent-locked mux and our grand-parent is the root adapter.
>> In that case we also have all the locks we need. Trying to grab
>> them again will be a deadlock.
>>
>> The more correct approach is to do the parent walk in search of
>> the first ancestor mux that is not parent-locked and then call
> 
> Hrm, does it not apply for all mutex-locked ancestors?
> 
> Consider the following chain:
> Root - P1 - M1 - M2 - P2 - D1
> 
> P - Parent locked
> M - Mux locked
> D - Device
> 
> In this case we need to lock both M1 and M2, not just M2 ?
> I'm not completely sure though, I need to refresh myself on the code
> base.

No, that should not be needed. The reason is that when you initiate a
xfer for D1 the following happens (xfer is a locked transfer, __xfer
is unlocked):

- xfer using P2
 - lock(P2, I2C_LOCK_SEGMENT)
  + take mux_lock for P2->parent == M2
  + P2 is parent-locked -> recurse to P2->parent == M2
   + lock(M2, I2C_LOCK_SEGMENT)
    + take mux_lock for M2->parent == M1
    + M2 is mux-locked -> no recursion
 - ***** (see below)
 - P2->select (commonly __xfer using M2, elided here)
 - __xfer using M2 (unlocked since P2 is parent-locked)
  - §§§§§ (see below)
  - M2->select (commonly xfer using M1, elided here)
  - locked xfer using M1 (locked since M2 is mux-locked)
   - lock(M1, I2C_LOCK_SEGMENT)
    + take mux_lock for M1->parent == P1
    + M1 is mux-locked -> no recursion
   - M1->select (commonly xfer using P1, elided here)
   - xfer using P1 (locked since M1 is mux-locked)
    - lock(P1, I2C_LOCK_SEGMENT)
     + take mux_lock for P1->parent == Root
     + P1 is parent-locked -> recurse to P1->parent == Root
      + lock(Root, I2C_LOCK_SEGMENT)
       + take bus_lock for Root
       + Root is Root -> no recursion
    - P1->select (commonly __xfer using Root, elided here)

    - __xfer using Root (unlocked since P1 is parent-locked)

    - P1->deselect (commonly __xfer using Root, elided here)
    - unlock(P1, I2C_LOCK_SEGMENT)
     + P1 is parent-locked -> recurse to P1->parent == Root
      + unlock(Root, I2C_LOCK_SEGMENT)
       + Root is Root -> no recursion
       + release bus_lock for Root
     + release mux_lock for P1->parent == Root
   - M1->deselect (commonly xfer using P1, elided here)
   - unlock(M1, I2C_LOCK_SEGMENT)
    + M1 is mux-locked -> no recursion
    + release mux_unlock for M1->parent == P1
  - M2->deselect (commonly xfer using M1, elided here)
 - P2->deselect (commonly __xfer using M2, elided here)
 - unlock(P2, I2C_LOCK_SEGMENT)
  + P2 is parent-locked -> recurse to P2->parent == M2
   + unlock(M2, I2C_LOCK_SEGMENT)
    + M2 is mux-locked -> no recursion
    + release mux_lock for M2->parent == P2
  + release mux_lock for P2->parent == M2

(Phhew, I wonder how many typos are in there...)

So, between the steps lock(P2,...) and P2->select (at the ***** mark,
which is where you add set_clk_freq), what you need to lock is M1,
i.e. the parent of the first ancestor that is not mux-locked. When
you lock with I2C_LOCK_ROOT_ADAPTER, this happens:

 - lock(M1, I2C_LOCK_ROOT_ADAPTER)
  + take mux_lock for M1->parent == P1
  + recures to M1->parent == P1
   + lock(P1, I2C_LOCK_ROOT_ADAPTER)
    + take mux_lock for P1->parent == Root
    + recurse to P1->parent == Root
     + lock(Root, I2C_LOCK_ROOT_ADAPTER)
      + take bus_lock for Root
      + Root is Root -> no recursion
 - Root->set_clk_freq                  <<<< the new thing
 - unlock(M1, I2C_LOCK_ROOT_ADAPTER)
  + recurse to M1->parent == P1
   + unlock(P1, I2C_LOCK_ROOT_ADAPTER)
    + recurse to P1->parent == Root
     + unlock(Root, I2C_LOCK_ROOT_ADAPTER)
      + Root is Root, no recursion
      + release bus_lock for Root
    + release mux_lock for P1->parent == Root
  + release mux_lock for M1->parent == P1

However, spelling that out makes it clearer that Root->set_clk_freq
will be inserted in more places in the "call tree". It will be added
before every ->select call, e.g. at §§§§§. Since any of these
additional set_clk_freq calls happen after the one at *****, they will
take precedence and ruin the whole thing if any of them should request
an intermediate frequency (1MHz at Root, 400kHz for any intermediate
mux and 100kHz for D1, for example).

I don't immediately see how to reverse that such that the set_clk_freq
for the top-most level happens closest to the xfer on the root
adapter.

Cheers,
Peter
