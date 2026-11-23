Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795408683;
	b=3SJ0ecWV1tcrkK9+0RYnGze7sljCU2S0zutDEcekMvwypPwlqMQ+tyMLUjl94dA6Xrmi
	 NwIss50zlS8/s0+bVQTucXMz8mECuBDiT5pBFyt2/83QlZZ3+iP2aGkbFhE/NvlVkAh5+
	 avZMElf3yGw8PPq6AMbmPIj+zc0W4BctWuaUc9BwuMmE3P/3Os7JHBjnXfUoL7S+rdrPM
	 ooFJFKtguxqJivV7wClgUuh/NgM7spKiYDr2oTMYPcqNYevXNYOCVGX4Tn2Bpi8DiTeLG
	 dL9eiH7Z6fHzWscIxPs+s/A4DwpVd3IRLJfUjz8WPI1ikhVziapfOAKosmQK4h/xNqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795408683;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CcSLh5CUENOETOT7XYYCE5cFgpJh5ZGm1UmnE7xxWkE=;
	b=qvCVtPU+2b3vQmzJwoPPWJ/zkVmFHBivTn9gtj9NQ6CNfG4OfJB717V1bpxcqcVrT3xZ
	 bnUyMp36BstuCbGqIk3OzIiu5v6sMYfDF6cent/ZxcmeU2Zzgd27uQw7vAI4aVdnGbHE7
	 HK0W6ZvF5Zbf4WfWdwG3YI0ruDOyyEDgMXPIqzOQwUvX9kS9f6DiMCY1QDfxFXcgLPnK7
	 m9UTh6kllA7Ih0kcoxJH/GpocVoCFkpE+F8GzdT+MNWfwhCxTrc/6LNcaIN4Tl5uiNre9
	 CZB+jIXzyvtgE82tGVZVTkjAZHVHnUNi6RrT0pnF4xi8llV7GbwyVlXEsr2fhmXEDcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b="a/wusqQi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.13
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88A606A31A;
	Mon, 23 Nov 2026 04:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E88A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=a/wusqQi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+sf+Y782nyw8ejE5ikqGHUZGikASvyq85FR9ZO0BRxGrbe9+B4BOOh0LaNu0epVyxcXepw4xWJ9lfeLc+3Mxsr7jSMPIYDjU1OOgJEmy1I/wv9Ddd9k83as6qFg2b0r4OALR5LRwQkc0sa0i8LsWdQz5ruYdLP+76mXObBHkGoEDBCKzgZNhSqBdkVz4Ae49jTpvg1oK9YUswvAC0mEaJWzXDqxHEDGYha7FKNfGTPPv5UWW6J6RqdAtXgU9PqaeC94Acl35qzeWbNFdlIzfP+unvx+hiuexB6tox+TG4wPVGsChPka3pQsonRBMFYG4P9yk0/c+iesDcGmv7KFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcSLh5CUENOETOT7XYYCE5cFgpJh5ZGm1UmnE7xxWkE=;
 b=XNuoQq8StLdxu6pEXB5dgGr6AxG7/HUbSvDmMUoMWGwvIRa3YfF0nqb7ZCyc3QCUJKvk+zMk+t3TON9FG0Nq5Gqyv+lZBgtfSifB3U90hsrlQkAAi51YT5QfWk3bwT6mvRLp9IxDnKI08FInswSneklHv/w1y3hEUn4Z6dhTLLUbT44+gyC63+lc/a0xac0qZWC++IRlyx/7yHNWMUYi60ZtzGfoySWmoPTJUbC29G9QcRhVnzBvmt35uH50IRwbihmo13ES2vq7ouH/0Cq5QejR39QUGaNJxDdPGC+khpM1ZCvhwdjY+PkH/JgeSHoj2Qkl4sqnHfui4I1YD6stvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcSLh5CUENOETOT7XYYCE5cFgpJh5ZGm1UmnE7xxWkE=;
 b=a/wusqQirijTTqMflMCh4Nxt3z1DaAaMb9/8vJxCNcidKvJsFTDErpgLazaDcWiJH0p3qjxObYNwFRXMiLDybAN6jZrH+oia5DG4lE8oooVEwXTPqx42foCSLS/6DtnLPKIuVUOWaov1WNTaphN+zcc+RH+ynXCk/KpZGhHkcw5FQsJbdScFiaFxGlhIQl4QNr+zKAoGjGUpJhq+PoG1JUXUGfNiwJ8sFF8tsIcZNaiRGkNHUpudjNLfxPETw1eB3zE8sybSYpm2W6n3I/xz3logfx3we3vCymjeY6SZgO6vEb5Vb26vjXf2e9uc++o5Fw2/XjROfa6p2uwpU6CkAQ==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 SA0PR02MB705379.namprd02.prod.outlook.com (2603:10b6:806:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 04:38:00 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 04:37:59 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	"matt@codeconstruct.com.au" <matt@codeconstruct.com.au>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>, "peda@lysator.liu.se"
	<peda@lysator.liu.se>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Topic: [PATCH net-next v3] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Index: AQHdegx2DnsWakRucUKRIuqcH0yhQLc7FDMw
Date: Mon, 23 Nov 2026 04:37:59 +0000
Message-ID:
 <DM8PR02MB8087942AD8FB03135001A0A48E452@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261118100231.3827609-1-kenny_hsieh@jabil.com>
 <179530217699.3135.2359467047069026979@kernel.org>
In-Reply-To: <179530217699.3135.2359467047069026979@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|SA0PR02MB705379:EE_
x-ms-office365-filtering-correlation-id: a0f58c9a-2932-4079-50d8-08df491b8d7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|261026121527099003|261102123227099003|261022075727099003|56012099006|10067099003|38070700021|4143699003|11063799006|5023799004;
x-microsoft-antispam-message-info:
 1DCEnzvhXcVS9XPFKpkRfbhHhVzP6EMOhsTaeEltnD/qblF9sGI5S8gibODCcnIGx6XsZM6kx8ABwvs7vPd20j9kQ7HoguHHuQLgb+tc7kl15PPNj4UkaYjTXj+kc4m3d+wvvfOosuPwE7FdooWznY0ZYX+yB3O+MPZDuCFOZReOMxapZUdXtJbd3cq/sSvo3FAUjFXvtFx/WkQL8xy2M1RLzdd8FUeXNpVT+MkfcP+04/VoUELtIgMq5o6hRZBjBjithn3uIY5Yj9JbkTWYtZVy2OK9tvlQNk2lzKOAwjafc1SD1VUxNZopDAX6kOe0FGija8KVbRzt0nRjSYcwJXcU+1jokPqRO/H2Q+NfvZ8ez2JdcXxTAOnPryMTwXz0NBJxVbQpU7dNGoP8yQN2CbpIWEiiGX0YnHbJU3PefTiYMo/LXEtNKThbHKbiM/ol5tTlNWJZzqTWw1DegTaeYLsocfaxxvOpSb20wxnOpmvMcanQ+IWlW4XN2iZVpsD+BN7TaXwPRI7mXqU/YXF5CR2t1aaLkr1IzdbDriK7vAQXmF9vmrkmBwl/yo3x1IXZ/PbMpTs50sJxdvPSCb+/UVAgzLfj1PPQr3MNcFLGOVvqWPXrN9ReNiYPTf4k847V9+0N7xLpW5j8rlYxT4lISMBnXNRifGSSXURmUxAuOLc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261026121527099003)(261102123227099003)(261022075727099003)(56012099006)(10067099003)(38070700021)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alJTSXM1T1R6ZTRBMnpPbU9sSklDK2tYUEhWNUJZbURuVlZNSjJYRUh0Nlgr?=
 =?utf-8?B?czRINmY1aDhCeFo5Q0VYTVRaOElZZXVzbUdmWi9IWkhLSTJOOG9vdEk4MTl3?=
 =?utf-8?B?UlZjaWZ5M3V1VGc1RTRpb1loRi9OVzBUdEZWTk4zTUh6SGZNTDlwZDQ4czRT?=
 =?utf-8?B?M1FpQnBXRHl3cnBSK0dMcGVRaDVyYldzeTJjNDlodm8vZUlVcE1CRTB5N3Vi?=
 =?utf-8?B?eERIZ0Q2MkF0eXpUUjRZVm50TzhsTGpYdWxNUGQ2Skh0YUFWSHFDdWlQcCtH?=
 =?utf-8?B?MG4xei83QVA5SUhXRjJJUDJtWkpGMThCNTA4aVY5akY1MmtlcmpJNEpld0pv?=
 =?utf-8?B?YTBQWXBnQ0ZTOGZWVzRWVlM0L3B3N1g1MWVXZERnelNDTkdVQUhFVWpuVngz?=
 =?utf-8?B?RXd5TFYwaTVFVStKZElhVEI0QzloV0lqL0dWY1hRU0dwZUY0bWM0eVJ2UUNi?=
 =?utf-8?B?YUhGVVJYSnhmZ0I2U0h4azNKenVWRFMrcmdLbnNpdjZoYjlZTHNXMlZ0eSsr?=
 =?utf-8?B?ZVlMUHl2ZEJnRHdhWCtUQzdJeFY2bzE5Q0RNVVNidG5sTkNLeGUxQWlrRmZp?=
 =?utf-8?B?bkNjYW1RYUlrYzl4VEpvNHk2VFNsQTZnOGtId3crMUJUWmhjZ1UxR0Z4UE8w?=
 =?utf-8?B?bUJGbFZpVFIvVU9uaHlXTEtPYlg1SUk3SjJFVS95UzMwcTluTmJqR3FLcFdE?=
 =?utf-8?B?emR4Y2htUUI2MjhjMFBBVDhGVTJ5T1FCSlJJM1RuSHh1NGQzWGJNYzYzREx3?=
 =?utf-8?B?bEZDRVFyT2xDTW9idTUwUytOUGZOd2F3S3IwU3F5cjlTdkEzSUk1WXhRdEhW?=
 =?utf-8?B?bWlrUlFIYjJMZW9KYk92dGZBQ3o0OUJrajloUkMzTjNTRDZqd3ZJcEZDZ0pR?=
 =?utf-8?B?b0FXaVhJamhmci85R0VVN1Nid0tYd1lYbkRHMXh2bjZQdHJWaWs1eStoU1FD?=
 =?utf-8?B?bWZ0TUNWSkZhbG9NUVBudk5ObHNLU0d0WkNuTkYvRU9yT2RUdGVSZ1RXTUtW?=
 =?utf-8?B?U3MrTXE0eXZEVUk2U083d3E3L1pFSEVJcW9tdjUzTzhaNCs3MWVORVpSVDVy?=
 =?utf-8?B?YkZPN0RUV0NtTW5kQlY0WEloUTJQOXplNWppQ3M2RXI3cFdaUHZrSm11Uzho?=
 =?utf-8?B?SmxiTXB1TTJ3TGc5cktqUGVHdG1qRUp3YThJYlBlcUJ3Qml5cFllVzAxd0RI?=
 =?utf-8?B?SEpjQUZNY0RVaGR1VWdNRWdBTDgyeVRCc09zZmdTcHdCT1gvSzIrbTJLQjh2?=
 =?utf-8?B?TUZIYk00M2taU3ZLT2xlWFZyUTJIaS9iRU1xd0Rpd29Kbi9DZE4xNzkzdlBy?=
 =?utf-8?B?UVEzNnJ2elltWjJPUXdORG1sVHhOSEYvNnl4RnFYQjNYNzlGd3I4cTBqVW4r?=
 =?utf-8?B?d1UvWXVXcERKWTAzUkRXSVFRVWJ1amZPQVZCbDQ2KzJldUpjU1hEVUtxbkQr?=
 =?utf-8?B?Qkl6aitSWmRubEk1VCt3VWJBV0psU29XNXFFdFN1Q1lJTitqc00rM21wWjRC?=
 =?utf-8?B?OWxXMU8rM3JlUnRGczYxQndpMUUzamhRY0lDcm14MWtGWVkvOEp5UHl1Qmpm?=
 =?utf-8?B?Z0Rnc1BlSTBnZWVzaU16TzBFc2c2eWc0cDZQcXd4Z1pKTFQ5dXN2LzUvdzdq?=
 =?utf-8?B?TlJQSUhTNEVUZGZXdUVBcTFUMERJU1I4THJnc0hYV1A4eVBCMStxQXdWYnFD?=
 =?utf-8?B?VzVUdDhIRHBQVnRKVUZZTnhhaEhTQWN6RVNpc2tTNVhXNmxTV0pObGRpc0J6?=
 =?utf-8?B?eldqdmU1VDhVVmtQb2xMZjc0SVhNMmRHQy9pTnpQY0pOK2pZZk8xY1BhR01I?=
 =?utf-8?B?NUF1ZUpFcVRZdERJMWY5NW1pWXRrN01sazJIUVAzUkhkOXBzK1hyWTlSUFkr?=
 =?utf-8?B?ZFFBeGhGZjRSNXN0NUppZXE1N211U3BJUlhnTnF4OGdsdWQ3elFRdTZqRjV5?=
 =?utf-8?B?M1VHVUROek1JeVR6bVlLWExjY2U1Si9pV24wUXArV1V4Y2RZZ0l4MWprcUNY?=
 =?utf-8?B?WjdzWEUwamZPY0ltMWVRU0N3enZTRVE2K25yZ0Fid0FDUExZWWsrS3ByQlRO?=
 =?utf-8?B?RUVqeDJmNHZtcEk3dFFBMDBWb0VJSUhsTjdkaHdsblI3V3pRRTZUS0ZhNFdE?=
 =?utf-8?B?Z3VSNGdISGx6aW52T2xobjNrNnpvbklBU3J1bmdmOHo5ZFRvSzYrWW8wZlNZ?=
 =?utf-8?B?anRYblRkNWhvRUhNb2NKSGhUU0RWWDNmSnZ5WEV3RDV0czBTUC94Z0NHWnl1?=
 =?utf-8?B?ME9XdXFUSWJsbmkydDgvQjJ1bXZCekVOWUZXeVEzWUcvYmlkS2M0U1NiTW5a?=
 =?utf-8?B?RU1ULzBZY25LTFVocmQwaHdWNTFjbXovV25nOVd1eHo4bTlSREpRdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR02MB8087.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f58c9a-2932-4079-50d8-08df491b8d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 04:37:59.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O25TqEKEDygfppCk5f6ywzYyXn8C/w7NsRIc5sPWTKmdWzKRz/10glwsBg/Z6DJKhZjkMxA/zTf+9QMVao4EvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB705379

QWxsIHRocmVlIGFyZSByaWdodC4gdjQgd2lsbDoNCg0KICAtIGNoZWNrIGNhcGFibGUoQ0FQX05F
VF9BRE1JTikgbGlrZSBtY3RwLXNlcmlhbCBkb2VzLCBzaW5jZSBhbnlvbmUNCiAgICBjYW4gZ2V0
IENBUF9ORVRfQURNSU4gaW4gYSBuZXRucyB0aGV5IGNyZWF0ZQ0KICAtIGZpeCB0aGUgY29tbWl0
IG1lc3NhZ2Ugb24gd2hlcmUgdGhlIGR1cGxpY2F0ZSBhZGQgY29tZXMgZnJvbSwgYW5kDQogICAg
bWVudGlvbiBCVVNfTk9USUZZX1JFTU9WRURfREVWSUNFIHRoZXJlDQogIC0gbGlzdCBFUEVSTSwg
RUlOVkFMIGFuZCB0aGUgb3RoZXIgRU5PREVWIGNhc2UgaW4gdGhlIEFCSSBkb2MNCg0KVGhlIGRv
dWJsZSBmcmVlIGlzIGZpeGVkIHNlcGFyYXRlbHkgaW4gbmV0LCBub3cgYXQgdjQsIGFuZCBpdCBh
cHBsaWVzDQp3aXRoIHRoaXMgb25lIGluIGVpdGhlciBvcmRlcjoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL25ldGRldi8yMDI2MTExOTA5NDMwNy4zODY0Njc5LTEta2VubnlfaHNpZWhAamFiaWwu
Y29tLw0KDQpwdy1ib3Q6IGNyDQoNCg==
