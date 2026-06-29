Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010013.outbound.protection.outlook.com [52.103.73.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAD39B97E
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717016; cv=fail; b=ibNnWVw1aZP+i/2GFUXJjk9K234t6efJ+0tCprP1+726nn5EwCjZr7kAOTdxbWnHJLua9L91gEoCO9h9ACdJxcBo2PljH+Icdy4GrdHt+RYNZKqnKlG5J2od2iDe99oB+1tz2akdsxWvOfir1kroTKT1rLvtIiITQA6oKfVpqFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717016; c=relaxed/simple;
	bh=zLtKiy5hwinH98f1gjURp3zz249egBcw8hM+N1uLaPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4wzcYpwPh9Is+e8oWOl10Ri3b0tlbRPRLA4V28anzbdlZ1cgrJn2+BUMhxF4aAWGwRdlGooj7RnpgOCWmgg5m+LvP0W4pl/w9LmdX3rkRvvK8S89cE8Tb5MxqEIE0tvGXqlzzlB+Du6kj0YDaInpj3CiUc1i3RCsJydHV8eOGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=QSgNSGH/; arc=fail smtp.client-ip=52.103.73.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="QSgNSGH/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrtBbKe1H61cQTqwClqAcVAf7wGN0ddzFThKkimLXXJeKM8hbshClfHKnTa97an9TsSKhzC7vdAemJXpmhap0aTwJbynUhEySugwWrZ6/d1IcTSL7/WIJA/khpSXtj7CciaoS9VWMbMORW9/VRCCAL4VKbNk9TzmRkEcGCbw7NWLmxT2jArlJAAB2qZFe8mZ1JTyYfm1LuM9xXw0x7QYjfPH+owXlJiu4ptSohL6/Ln5kT9E3TcwE97TorSUyF68jJJCq/QlmwiQKNlku13+TjgSapzg1PEDtDbuBDijxYYaORH9XzcEAxoztyWf4EjwB9QdMnGvK4a2XBx6BCIlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLtKiy5hwinH98f1gjURp3zz249egBcw8hM+N1uLaPA=;
 b=RjbHng/Y+ssTnnY7F7Fxdf/q5gQ+/liLcDEJ6hQa80fHUYfNTMiFEl/je6OmeS8dieY7jeO0XbNMxw/IPKJe5H6FYip2anpmGeb439qLuQez7gubNs6XhMyfJAqh51KVGkYQHO8kH2LHdY7sfS0RgyvS+xO/Wfn7RgDpYXfrYiFUqvef5/MB5qX46pAPGoaVloh1ihNOlgcRji+Wk4W/BEF9Q0Msqa+W1dqAHwhx54Z3yFlBcxON+nZ1sPQAYZaJRzxj+kXSETeAN13HbqMRRCMvVXq16prthPXpKxmEuusa+gbWFNlzmSAANwDe68j9wCk0VciJNc4XGfw6JmuF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLtKiy5hwinH98f1gjURp3zz249egBcw8hM+N1uLaPA=;
 b=QSgNSGH/5G9ct1sKojSnEWfgxHDw4Qa7hnz2x56g523N983xZ9lnwR576VQ00gaxGAWB9ydzZM3A5I4UsynZAEAI5vXg/004Yx1oawVa9oKr9kPQcZIGd/3evmF5iU3IT1U5BhiNW0+Zyts2iDz+ODni/mipPrzfI97CUmO6jlYO2FilRMOaMb6RIa/P6DPGBrtYo23Xasl0edi3W4+DmW/SgDZvbotBH/wS6QdWoLOp5iDZt38lMfuNi6DUt9F8hg+/woRZtAkq0+5/IbMuO0GEye1rxkQMYh1ytP9AiL+vy2aLqIFqZghRKf3/0EtJRY+gquM+/GTCJJ6RpGW08g==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY6PR01MB7509.ausprd01.prod.outlook.com (2603:10c6:10:170::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:10:09 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:10:09 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: [PATCH i2c-tools v3 6/8] decode-dimms: Add second level separator
Thread-Topic: [PATCH i2c-tools v3 6/8] decode-dimms: Add second level
 separator
Thread-Index: AQHdB5ZSbWUkx4ZQI0CZa7vNnU/X8Q==
Date: Mon, 29 Jun 2026 07:10:09 +0000
Message-ID: <20260629-ddr5-v3-6-07f45075a51a@outlook.com.au>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|SY6PR01MB7509:EE_
x-ms-office365-filtering-correlation-id: 39384a81-eaab-442f-7f4a-08ded5ad748d
x-ms-exchange-slblob-mailprops:
 5fu/r660v9Mj6U6kz+12O9pZy2TuKGHDx2os6dOzZc46McN91VvzsVy3g+3IEB598eSlv25Ial1A3uMEBsC3n6vQn8e1Mhc0ejL96twNAffF5sE5oxOEVi3wshRmDoHmghbwNgbi1sfv8k0ZbvGViSyDquQlCgnZZOTTREz6IxPBFH8vAEupC4sj8edm2hN8b5JuAJHzh0rUcmndgHxp4PJ6DawQip3smFKuTT/vs96z82XZph/8NnYNNBNG6VGf3ZFyKRsA/k8Y3CoUTdGOsU60oN0qIcrcWE4Cs4OZVwnL5Pr1TccPNbzONERLNBvHATWxIgKXwWHHyR7JnGUUUrkYJxcGBG2RdDVReYra3gc7/ERGnDCbjueGX7VkkSbmQAxIZULYHHCbegJb5IkXNYCSv6WILlWe1EwVFoytFv9kV5vWFUWDW7Z1//oN0wiP9hmAiAYy2sfM0FbqaOzmEYQeCw6F7BJHK0IfzKWoLflZRFQPC5p1QnjBlEE5Qr45WkLKOJtxGWxwJi1fFC6SqUBt+Cuk46aUBP9EyR5GiwEjHmqZjD1jqYmaPvehgEIS0VjXmZEB5cQSM+fIJzC1iBoRo2khrKrvo65eE1a1wJRkR4loAwIU7FxBag/A64yJ7o0k6buaZ7hb0FW9kD24IM14akRthGL5fzkJjrWY4EaFtBFXZr/PtdrJun9kN9HpFFIvUOEhMFMn+Qi06NZmdN/9Lb9iqQhsAgyzwgl1sxU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|24021099003|31061999003|8060799015|51005399006|41001999006|15080799012|19110799012|38102599003|37011999003|25010399006|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1QyWnJhMnFrNm8zYzZmN2JQaTZsZlBlRGtDT1I1V1BDNUxleWF6SDNGczFX?=
 =?utf-8?B?ZUxMT0V5R2hManl4SENlUmVBUVBsUkRhOTFqait0VnJDY25qY0ZKVzhHQVRV?=
 =?utf-8?B?RnJYdlBnWW5GZE9DbGw1NGx6NEp4a2RPbEo1N3ZhMTBzeTNzUmI5Vm9ySERQ?=
 =?utf-8?B?NGVTUkF0N29xRGN4L1EzbnRmWFUwYkpES3VVNmhHOW42bTZpbnZzTlZ6Nit0?=
 =?utf-8?B?NlRiL0pES3dUOWRKdDJXTWZ1SmVweWR6eGhUVnN2RGZnZGxYWEdCNldobFFV?=
 =?utf-8?B?V3lJNEJCbHdzU2ttb0xjZEV0SXF5dFVyc0haanRobU1tSUk1UTlNUkxKUU9Q?=
 =?utf-8?B?YUJSbi9FYmQ5ZzVKV1dwZXVrZjM2UkJUcmxqVjlMUTREYkVzaXVSZkE1Rmwx?=
 =?utf-8?B?Q2Z2cG5vc1hTV1R0b0RtblhkaWM5dk13UHFzV2FuZm12anNVK0NSMnJ6R0xy?=
 =?utf-8?B?UFQ4OHNDZmtCbkZlWUl0L2RTcnNnR1BRMlgvZ1R3T2dlQlFaUVpxUVMzakha?=
 =?utf-8?B?Q3dkRGFHZVB2eXpKclY3Umw3anFpR1h1VVdicU42YjgrTVl3cWRrY0d1dVVZ?=
 =?utf-8?B?dDZqTWF0bUtpU3ZpeW5LbVI5bzczd1A1SHI0MldZWWlPeWNldlZPbjlPMlV5?=
 =?utf-8?B?MU4zdzJ3b1dUbjV1QnBmWFFkbnl3VjN0SHA4dHp2VEtRekxyN2RzR3lPc0xz?=
 =?utf-8?B?azIzL2JjQWlLSU9tUk9lMEVMM2cyMUttMXZhUHRSK3lRS0J6d3Z6Z293VXZv?=
 =?utf-8?B?UDcvR3MrWmJ4dmVzd01oT3pmSU1yYUt6S2JFY0dkcm9pNFdvOEw3QjRqMm1S?=
 =?utf-8?B?USswZnZuZHJmSXBoZGhGMjA4MXdaRXdVNzIrOTJEL0VnODRXdlNjQWRBbWM2?=
 =?utf-8?B?NncybUxPUmhhYVo2bTF3cSs4TEowWjhaY3JZbFBQWEFEdXVxWUkySFFHa3oy?=
 =?utf-8?B?QVd1cG5OYThiL3VDNkZSdEFZNm9CUHo1cGlLSHZteCtHMnFudnhzMDJlNDJo?=
 =?utf-8?B?OHJGUWkxeWVYa3AyQitjaE5hK2FvaXB6S1grejBoMzhYaDJPM3RER05jNXhN?=
 =?utf-8?B?akNxMzJvYjRHa25VN1JVdXJ2Z1VsQkFGWHNvQ24xL2R3Z3ZLZWRrSzJaYWlM?=
 =?utf-8?B?N1RIbVU4NG1HK20vZTIwbVhjeG1GUW9WK2tYcGdhSGtPQ2NOd2M3bWdWWUlH?=
 =?utf-8?B?OHNQTXR4RFYvc1NSTCtuMHFYNCsrV1VDUGJQS0Q4TmxqaEFIV1FoT3Z2bWxl?=
 =?utf-8?B?VFVUVnk4M21WRDI5QjlKdzdvWHg1MUxkQTBmdzkvZ2xObzNkVWp4ZVR1UXBn?=
 =?utf-8?B?SGNSbW50aGNXdzhXSm4wbDhlTkJSa1ZjMm5rYTNrd0M1V2poVHQ5c2dwdFdp?=
 =?utf-8?B?NWFSM3VOSWZ2MnVQY1RXNVpIbXduMnErOHJqNVB2bVBEcGNuSGRGditUVjV5?=
 =?utf-8?Q?VExbMbMG?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TG42VVR2amJBNXVyN2tNZ2g2dG1lTUZLTWxxSzJUREtNczBseEg5S0p4Tytp?=
 =?utf-8?B?THE0U1Q0cWtmaitwUWlXaXpTMXV1aENUSlZFM2NTTkdPNlRRV3V3MWIxbUJO?=
 =?utf-8?B?TWJmWmIwWjVQR1NuODZMTlRqV1l2R2FFUS9MUjhSTzJDUEF3SDZCVTNDSGVB?=
 =?utf-8?B?NGhCUVRxcWZlU01xRjZXK1lqRVU3a2pmc1hrcWtodFJHTWUvZS9nd0RUQnRr?=
 =?utf-8?B?bTg5dFd3dXNxalNRb2wydDJwQTV5bnZGS0RXQWpocUZUY0hPSFo4eGVZWTVR?=
 =?utf-8?B?T21jZk1HbXJmalUxZWVrWU9rRmRtZkJtRDI0RUxTWVZhakM3ZzJVQmxkaW56?=
 =?utf-8?B?U1J3UWRWc0dJYzBJRmpmLzk2bzgrVWduVGRyNm41VXVwemRXcE1UUEh3RkxG?=
 =?utf-8?B?eElUOG4yZk5sbTlIbVBwNmZJQTZBZWZGajlPbThzdHA2RUppNTA1T2ZNeGVM?=
 =?utf-8?B?K0VldGhCcG5PZVltcmFKQmFWN0ZrZzRKQmtLS0ZGMGRBQkZiNkVIVnF6ZTNm?=
 =?utf-8?B?LzFHVkFMNGY4QmZJQW9jREhIeDBGRHU5MEpnaE5HTU02alIwVXVUdUlrd25C?=
 =?utf-8?B?RGVvS3BtWWMybU1FbEFTbnE2TnQxWHJha2d6cWhwME5kQjhGZ1BIV1pPTDBC?=
 =?utf-8?B?RjFqWXZVdHZkRGpiUTBOK1ZUWnIyU3pqZTBpZUFzK1hsdjJ3QTBnQTlKNDc1?=
 =?utf-8?B?OElnZVVSSlRwZGc0ZDM4cThzbnh6bDdBek1sMkdsWEw1Y09BUlhLTVJ6K1hn?=
 =?utf-8?B?eWZ5ZlhIayt4Z2c4TlpvcGc2b0h4SXNGUUJVeW9uVjQwbXlLTTVTS3prdFN4?=
 =?utf-8?B?RHIzRGZSUUVKKzNnOW1ieXdzYkVwWWJITEpjMkVEdis0QmY5UUJyYm1XVThX?=
 =?utf-8?B?NU1qSTM3dGs0TUcvWkJzeGxLSzdTeXltbUt4bjhISkRNQnJnSk5RQk1zL3Fs?=
 =?utf-8?B?OGluOXV5VWEybTF5QjFwZndZUXZURnNOV3ZJaTJ0T2NBN0tvWjhSR0tmMFJP?=
 =?utf-8?B?eVRCYTRVMGpmYnUzZk55ekxDQzdmQktVRjd3WVMwdWF1cTMyRkpqeE5XZWVR?=
 =?utf-8?B?U0ZaVWtjOWJJYTZNaUs4Q1NmOGFFekVBMG11ajNtMWt1YnpmRDRRdWdUVGUr?=
 =?utf-8?B?NEFxeE1jMnRRMUN1WmNYL3YvMGJ0Yy94WGxLeGtTTGgzQ2tFekxVR3JtY28w?=
 =?utf-8?B?WkJtS293aXdCNlVtOVpjc3piZFFpZW5VaklHSmZGZDRwYWpDcjRMbXBYVjU4?=
 =?utf-8?B?blNCbjREbmpRNVBzclZOQXp0akd0YXFTcWJsSFlBakhTYml2ZVNiN2FhdjJQ?=
 =?utf-8?B?SHpmblNpd0JrZkxsenBNVlpoK2NOMmZ5em1kbGk4MlNaMmhCM3FPV293K2o4?=
 =?utf-8?B?UWU5cy9Vb0ZzekttZkI3R0QvMm9qYmE1UE03U29hN0ZONmpvSThKL3RicElU?=
 =?utf-8?B?WFF4TnBGS1lrUjB2YWVuQnZWam5UekpTUlJVV3A0a3AxVlJmSHJ4NCtLVDBP?=
 =?utf-8?B?ZTNCZXAvZGh1MkJuNVpoVVVIMkFtOFNIaEM5cW0vTmtZRXRjUllsOU1ZT09J?=
 =?utf-8?B?OXE1dTlNMGI0aTgxMElDQXArSzI5cnBZZUNSLzdtSlUyN0pkT1QzaTcvNEZ6?=
 =?utf-8?B?N0Yrdkt4YStQOE1oSnJCdWV4bW1XWEFTbDdWRXpmS0IzZG84dmpqR1lvM2NM?=
 =?utf-8?B?SDVKSEpySUVleEtySDJPazdTczBtTTJBNlQrWHBoTForT1hoWml2KzdxemNi?=
 =?utf-8?B?bExybzh0elFGTVlnQ05TWnBjbzBXMnFFaU9HNXRSUmpaMzdqZW0wVkdrYnR4?=
 =?utf-8?B?Tjh2V2hwUFZQNE5mWGxEQUNZZmV4WmdibWtwYWNZK2R3UXQwb093cnJUc3RS?=
 =?utf-8?Q?R8ItMsNNxIiae?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F94E9A29F975478EAB91B52A710489@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 39384a81-eaab-442f-7f4a-08ded5ad748d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:10:09.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6PR01MB7509

QWRkcyBgcHJpbnRzMmAgZm9yIGEgc2Vjb25kIGxldmVsIG9mIHNlcGFyYXRpb24gdXNlZnVsIGZv
ciBsaXN0aW5nCnN1YnNlY3Rpb25zIGZvciBYTVAgJiBFWFBPIHByb2ZpbGVzLCBvciBlcnJvciBs
b2cgZW50cmllcy4KClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gSG9ydmF0aCA8cy5ob3J2YXRoQG91
dGxvb2suY29tLmF1PgotLS0KIGVlcHJvbS9kZWNvZGUtZGltbXMgfCAxOCArKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZWVw
cm9tL2RlY29kZS1kaW1tcyBiL2VlcHJvbS9kZWNvZGUtZGltbXMKaW5kZXggZGJhZWM5Ny4uYzcy
Y2ViMSAxMDA3NTUKLS0tIGEvZWVwcm9tL2RlY29kZS1kaW1tcworKysgYi9lZXByb20vZGVjb2Rl
LWRpbW1zCkBAIC03MTIsNiArNzEyLDE4IEBAIHN1YiByZWFsX3ByaW50cygkKSAjIHByaW50IHNl
cGFyYXRvciB3LyBnaXZlbiB0ZXh0CiAJfQogfQogCitzdWIgcmVhbF9wcmludHMyKCQpICMgcHJp
bnQgc2Vjb25kIGxldmVsIHNlcGFyYXRvciB3LyBnaXZlbiB0ZXh0Cit7CisJbXkgKCRsYWJlbCwg
JG5jb2wpID0gQF87CisJJG5jb2wgPSAxIHVubGVzcyAkbmNvbDsKKwlpZiAoJG9wdF9odG1sKSB7
CisJCSRsYWJlbCA9IGh0bWxfZW5jb2RlKCRsYWJlbCk7CisJCXByaW50ICI8dHI+PHRkIHN0eWxl
PVwiZm9udC13ZWlnaHQ6IG5vcm1hbDsgdGV4dC1hbGlnbjogY2VudGVyO1wiIGNvbHNwYW49XCIi
LigxKyRuY29sKS4iXCI+JGxhYmVsPC90ZD48L3RyPlxuIjsKKwl9IGVsc2UgeworCQlwcmludCAi
XG4tLT09ICRsYWJlbCA9PS0tXG4iOworCX0KK30KKwogc3ViIHByaW50aCgkJCkgIyBwcmludCBo
ZWFkZXIgdy8gZ2l2ZW4gdGV4dAogewogCW15ICgkaGVhZGVyLCAkc3ViKSA9IEBfOwpAQCAtNzU5
LDYgKzc3MSwxMiBAQCBzdWIgcHJpbnRzKCQpICMgcHJpbnQgc2VwYXJhdG9yIHcvIGdpdmVuIHRl
eHQKIAlwdXNoIEB7JGRpbW1bJGN1cnJlbnRdLT57b3V0cHV0fX0sIFxAb3V0cHV0OwogfQogCitz
dWIgcHJpbnRzMigkKSAjIHByaW50IHNlY29uZCBsZXZlbCBzZXBhcmF0b3Igdy8gZ2l2ZW4gdGV4
dAoreworCW15IEBvdXRwdXQgPSAoXCZyZWFsX3ByaW50czIsIEBfKTsKKwlwdXNoIEB7JGRpbW1b
JGN1cnJlbnRdLT57b3V0cHV0fX0sIFxAb3V0cHV0OworfQorCiAjIEhlbHBlciBmdW5jdGlvbnMK
IAogc3ViIHRuczEoJCkgIyBwcmludCBhIHRpbWUgaW4gbnMsIHdpdGggMSBkZWNpbWFsIGRpZ2l0
CgotLSAKMi41My4wCgo=
