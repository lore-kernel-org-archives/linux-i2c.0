Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717252;
	b=v+gfXpEum+2VE3VLqXPNlK0173U5pvuNgfTN+fCuZ2qiPGkXbqp81nPrTzADOAZiouTh
	 R1npUHxvq25+IsN4lCKHr8aN6/ylK4fHHuk+VO1LYg8kt4a4qEYk6Iygw5PFzHSLiAWtc
	 eUwm3JfNEWqon+CENH6g9lgYeQPvjy5tihwknVJmm3Pkb/mdvp0RSA184eYIQEWiEJOWK
	 Yq3+nME1BudY/cWixK2HVzAzy5jeZvwIRW8ThnYXvFdHg4lS4G+ZruDiQ7+kEkQBgn8gr
	 CdyTZB+gYjMg6xVqEUdF7fSxh++SO2yo80WqvE1JZe7meNLra5tbwTQd0C5KPrRwlyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717252;
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
	bh=VBhJnOJdjKJJzSw4kiDE8aKSp2iNIZxkkNlWCNr5Z0A=;
	b=To//7iwCE9M0buZ5EZR2zBdy8Xt7phFOU6ZBwiLwbw7sav7cEO/i4cn9uDWfUYCJKwDd
	 jgOT7nc/d4af4Le8F6EH3g9+8Hsu96i9Jw1BN2fw7PPeJjT2Tw5L01sV4LYJx/8mdzXVU
	 R2iCeOS9LsoQr4m3czcRTpmgwg8cJuB77qBi8EZqCiODmfgF+uLbPbWJ9vWGKGSQlx2f2
	 tYUNoF5COT661kjZblxbQ2Irofuzw91KSqNG5UcrXRyXOIykCqmFKq+pPEI+pEWqBvIeu
	 uFkwoHXjHsb9GBdiT0Mo8glSntEv+G8j4tQqUICCh3aBLsHITE3O8EiXYZU0zwY0xDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=nycEMIRc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.7
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013007.outbound.protection.outlook.com [40.107.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8E606A33B;
	Tue,  3 Nov 2026 14:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7C8E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=nycEMIRc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR8h2s0LbbdO3OdLujI+E0I0LJKTxT5/yUv+n8Q/2Ngc2/PrswInwjtS2DWMbQEPP2m0bYDyYFcF3djV1bAZOfSfoYHBbern6SmnRxCX5VhhZ/iqa3AprWwlwXEoIj6uRIvhLluNdEHTHo9lIysjn9TQgejU7TmmbKW6areIavwGCLr0kWGj2XS09xg6IEKl4cMey/PDU6RquXvaOtLXSVAaAoNsd0F8IqYONkkW3nFbO6QEp8SvpfnRlZIX02BipAq4d1M5y0wx3XJN0Tb3JWUZG9hhqs9eL7mQIKlYvPjqqRs6l28bb2KWAvmuWT3L3KE7hwplTQR2UfO0zO3MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBhJnOJdjKJJzSw4kiDE8aKSp2iNIZxkkNlWCNr5Z0A=;
 b=aHBTSKeJtrY5V3EKnPUoeBw00vL7IjL5O4pR8C89ByjOzuf2K28N46YDOH4vnDXIhwwwNC+bgK1rVAliwSMJ+kIA4LrXbdQVtWx5iMH+plEHNyu2k1Qebnjaq/jHxoXT3dR0RmBqbUDp6N6TqZnmo4LTs5Jij0KAV76F3nWmAWCGCy7wxCAnpPluT3/P2ayFgILJX0trErdu+yaJUkqtyHYaF2vkVYl+W5ARwFATUF1tyA8IPiIEDzwfljJxMIhoM6RiSKU4cSVfmkZIVwuKAiLnijg14sAPEJLU//NL22eC1tTrY4HK/Jatnn7iLGpwmwLWAaQs3ZqLStt+VX7GQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBhJnOJdjKJJzSw4kiDE8aKSp2iNIZxkkNlWCNr5Z0A=;
 b=nycEMIRc3g/+QH77TmtzpLyj0SdJd8+qlDWxU9wlHDWgZkpI4ikM+Vzb9CUCcmlGv3Wqp6xZ4z4UD2YOfHxDm5vAannTJF9A4/9oPZtuuJoWSY0cexPD+ogU7MsR7OLyC/7aipv1iEAMLG8T5nmQ6ol4uLiSFRJ7BD8aANKzBtvM1rWijpZpMkFNxpuD0qIsNb8zMGMbPn2GxFjM3z0rWOwGoiWRLa+joszbErDx2ViHk+ZZKidTW/IsSMi8/FEo6a3J82v2YXWQaCft3ol9TRBkH1T3wIjttqF3GLqXwc9DZcAxSE/70cS4uSpIRF4xKsMToVCqT+b9muYSgpN/Yw==
Received: from DM8PR02MB8087.namprd02.prod.outlook.com (2603:10b6:8:1b::11) by
 CH3PR02MB10278.namprd02.prod.outlook.com (2603:10b6:610:1c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 14:47:29 +0000
Received: from DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497]) by DM8PR02MB8087.namprd02.prod.outlook.com
 ([fe80::6e40:b3cf:7280:6497%7]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 14:47:29 +0000
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: Matt Johnston <matt@codeconstruct.com.au>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, "andi.shyti@kernel.org"
	<andi.shyti@kernel.org>, "peda@lysator.liu.se" <peda@lysator.liu.se>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Topic: [PATCH net-next v2] mctp i2c: add sysfs control for mux child
 netdevs
Thread-Index: AQHdXH0gJEQaa7DeYESRNm+vhnedSrcEkYgAgAyNxfCACXoQgIABm7iQ
Date: Tue, 3 Nov 2026 14:47:29 +0000
Message-ID:
 <DM8PR02MB80878075D2520A9CAD7DF0928E692@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
	 <179239912623.3135.11352652156626817288@kernel.org>
	 <DM8PR02MB808768B7D02FF12777B7777E8E602@DM8PR02MB8087.namprd02.prod.outlook.com>
 <7486b1fc4dbcca755dd2f6b6de54d17919af873a.camel@codeconstruct.com.au>
In-Reply-To:
 <7486b1fc4dbcca755dd2f6b6de54d17919af873a.camel@codeconstruct.com.au>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR02MB8087:EE_|CH3PR02MB10278:EE_
x-ms-office365-filtering-correlation-id: d98411f8-fbf5-4873-bf0e-08df39b96272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|4143699003|11063799006|56012099006|261009223027099003|261026121527099003|10067099003|22082099003|18002099003|7136999003;
x-microsoft-antispam-message-info:
 L56Q3jUe4a44HOjpgtfsnevQUyNHv7pGltsvO0uYDpJ1RQRLMMeLWAjZfWi/HpBy48dumqWCGhe0vDW8O5WW3Bxs/WBFR0AbLIDMPxBZiaUGbm4n9/0jSRO2YvjnEPTq8aNIRaGzqq1R5xu4+vnvMZt0ouM1b2tkOvr+GYNqCoTUrcijcqEO0hw7eajQG8RJlIraVqtoH1BzfoEPp3125IrhuGaFl/ziq/XJMhEu3Tk+OpUP7LvINOULdQ2vuvmMQV6m8rhe6zEEtkmuAAPKG+8engPoLlBYZnk2yBS2mj05G+earjCJFgv49J8W2M8ryHf0bG6HR1rMStbhJ1Fwfi4IepPzYuj8ssFK37kTAqk6lfcE7jIfBDm809v9Uu+l/dDep6KhmI55PXe51nUK1iosMQ7RZoTjqGMvKltQLwEwzRdJXppzRL7ufGJFJbSo9EQ53T6bkNFX5asmHROsOXleF/2uMCYvxvoORP85jjh1yi76xM6qEyvmMjfsD+BAxYa0YiB1IXy7MA84GXWIglLohrLSwJ4xSS9WEbu3CyVlvVsuT2mLA+GgkE4+W6+sf4cT+xL3Y3kxEsin2HmzpUKiRTZiws+blZxptDla8TCTTQ5h1URr95axCDK8zjAErqUIiw6EznrdDEGGQIoGwXNsda6B7wwYiSf4xs33mDTzhb7uTYJjoFyxxvUScAXlTrrO1qx4ByxZ/O9jXeMI0M3Rjt131D06izUlVg9sR9U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR02MB8087.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(7136999003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2VBaW5SS01kblFQb0xyemhRdFk4b1BUUzdhbDRHY3V4VXBNQXJjbWJTVWpm?=
 =?utf-8?B?M0xPbDk4YWkwcmtPc3FZTDVMSFkzMU5ob2FyT1diOTk3c2RYN0x1NFg3cit1?=
 =?utf-8?B?UEc3R0VTOUNSTnc5cmJJVXgwRVN1UWYyUklvWU43MXBzcmVuYm5xTjFmOVZp?=
 =?utf-8?B?YzV0ZUtXQWZYMWFaVTdaZW1XMWRzODkxV2trcUIrNVpzZ2NlcUdxZkllbkdS?=
 =?utf-8?B?d0RXS2dzMjJrQ3cyK3VMT3l0cW85cUE1UGkyRTFmOXBpb2lEZjFlNGgyUGdw?=
 =?utf-8?B?aGZaYm9VdEhIUzRXT1JTRFNJbHJlb0drY2xHcStKa0V3bHg4MGV2d1BDblpn?=
 =?utf-8?B?MStud3lqNGk0WDVUNDlTWjlaVEMvaDdBcUh4VkU5ay9ETEc2SU43cHByb1dC?=
 =?utf-8?B?UlJqUjNxZ0xnQWYyaGx4ekhwNUV4UUdpOHRQenR2bk1vL1BGbDl6WHRjL0Na?=
 =?utf-8?B?OS9HQUthSlZwVnJTeklDNVZCdUFyV0JqZndhLzlmOVRJeTVPOGxLdXpKMWtz?=
 =?utf-8?B?NlhJRVhCRmJHTHp3S2h5bVZtYkQ2N3lPMTR6bUlSNUQ1WkFhaXVpM0VuMklY?=
 =?utf-8?B?Z3ZoaFN2STFqTHd5d0pvWUlMYXRveTFOTlRVT3VWejduWW81WTgvL1ovMUkv?=
 =?utf-8?B?UUhLR1FQZEEyT0xSNlE4eWFOaUF6blo3Tk4rcEExWFlPaTlDdVUrL3JacWpW?=
 =?utf-8?B?ZUN2b3BmalRkNE1zd1d3MjhlSTB2emtyNFRZa1FsY1ZtcXkxVVJZVklVUS8v?=
 =?utf-8?B?Q0EwdGpkSDlmNU51VGgwMUlaekFtZ1puZ0RvdWJwMy96RzJqcTNPTDdZSmlE?=
 =?utf-8?B?dS9OYU53bkNSVmc2R3p4Y2VrSTgyTUsxc1pFclJlRDYzc1J1ZXpKYWw0QWx1?=
 =?utf-8?B?dEFUMjFpdmdTZFpqK0ZLRm9vUVlVN09BODJkUHZINE5NNTJOZFJVMStRc3JM?=
 =?utf-8?B?Y0d1ZU50TTVlUzdrZ3BWK1lIRk1CcWFJc1ZUeGhsSFBaVlJBYXJud1FQZDM0?=
 =?utf-8?B?QlRJWUZVYUxmYnMreWxxSzBXTjN4REtqd2lwb1l5Q1hCRWhtNm4xclpjTktZ?=
 =?utf-8?B?cGM2TnBFME5SdlZ0bnNMKy82Y0l4VjREZ3h5ZmFWNXU5d0pWb3gvWVFBVWYw?=
 =?utf-8?B?SHdjUFVaUitoTzFhd0hsZ2hMRTh0YTgxRnJCTWpsSW1UQ1NudUkxVU5EZ3A5?=
 =?utf-8?B?ZWFOZUV6VGE2WnJJTzBQbWp6NE0yVTUzaGZtTXBwb2tKNERWY2RycnpsSHNt?=
 =?utf-8?B?djZpMVRYbUluSDZ0ODh0Ly8vUmRPV1EwVFdWVXhtc1Bodi9VaFZtdUNpQkJN?=
 =?utf-8?B?OXB6enRWdVFnMzJ4aWdaUmRvcGtTRjFKSEFvUkhlenk4VmQ5ZTVJa0dESjE5?=
 =?utf-8?B?RzlaRnc0WS9IbkNhNUNjOWNxM2JxOWVlV2J3RmZRNlBRcyt4RnRnVnZEZ3Zn?=
 =?utf-8?B?UjZ6a0ZkT2Foam80c1F0Q1dON0ZoYVIzSkJpS013S2ljOXdyQ2VDdFFuYXRy?=
 =?utf-8?B?NUZSVWlBSTQ1MTVlSVg5V09LcGpJT0cvSEdYYlhoUzBKREFZN2thWC8xdGdq?=
 =?utf-8?B?VytqMWJxQ3llUUl6WUVrTzhRMG90UGhtdEFBTnFRUXpEdjV4NnZLRXJONXJ4?=
 =?utf-8?B?T2Rlblh2SFVxQ29manpILzBxOE1IbEJ1NnpmV2NvMm5sY2ZNOTJ4Z0hnZjVL?=
 =?utf-8?B?Z2czcjQyRmVvSGVjQWVPSjVOa1dVQ0QwVFBUZ2pvRU1wWTRjOVlud05Vb2NK?=
 =?utf-8?B?OGRtbGpFUm50aXMxd2NXQ2NPMnlUVERKVWptMWxzSFFsUEk1YkVzTXVIdWFI?=
 =?utf-8?B?UENLcVUvem1vaVFoeS9XdlhzdVFTRGU4aE1XVWJ0QlVyR3YvN1lSRUNMN1Z1?=
 =?utf-8?B?QVZGMkV1eEF5V2liRVVCYUsxWWlRb0tZNWpXK3NiQUJhampkZHF3RGtqVnNt?=
 =?utf-8?B?dXJLcG5BbjVXcTVnQU1teHRvNkkxdEszYTNONE0rZSt6bXd6Q3BBU1g4NWFy?=
 =?utf-8?B?T1VrYTNiN0pHdG9SdHFwMDlDd3VGZitPK3lYSGlqU3BBVUozVkRXdy9HMkpm?=
 =?utf-8?B?U1VLcWdFVzMrNCtQTis4S3JSRUN1UVF3VzhPcWY5QWo5SnZCUGxwaFBrSE5l?=
 =?utf-8?B?cDhaeVdPdWtCZncvT2pVM1A4bkVHRFhYOVBNQ0lvNkZ6enZaNjY5aGVzYWRK?=
 =?utf-8?B?bDgyaFM4T21QQk4xYXZzR3p3Z0szTExDQzN0TXpQa2ZaeGtoelBXNjFsLzlE?=
 =?utf-8?B?NmZlNjRZazRRNFk5RWdxVXBVbjJIa0oyZDBSZ05lYStzYVBGcXBBQkVsL1ZW?=
 =?utf-8?B?QWJWUXRlbnA0N3pNdUlNNGtueDROSmVLdEUrYnNhWVc4YmUwUVpFdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d98411f8-fbf5-4873-bf0e-08df39b96272
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 14:47:29.2299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRSh90NBIGw0qFZ2GhV8WRbPT7zLw7V+6CjW+nuHVMjJN9eSY08xEvU6mIJsUpLnpiXcePufLzwGlyPUYhBbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10278

SGkgTWF0dCwNCg0KT24gTW9uLCAyMDI2LTExLTAyIGF0IDE3OjA0ICswODAwLCBNYXR0IEpvaG5z
dG9uIHdyb3RlOg0KPiBBbiBhbHRlcm5hdGl2ZSBjb3VsZCBiZSB0byBjcmVhdGUgc3lzZnMgYXR0
cmlidXRlcyB1bmRlciB0aGUgbWN0cC1pMmMgZGV2aWNlDQo+IGluc3RhbmNlIGl0c2VsZiAodGhl
IGkyYyBzbGF2ZSkuDQo+DQo+IE11eCBidXNlcyBjb3VsZCBoYXZlIG1jdHAtaTJjIG5ldGRldnMg
aW5zdGFudGlhdGVkIHdpdGgNCj4NCj4gZWNobyAiaTJjLTYiID4gL3N5cy9idXMvaTJjL2Rldmlj
ZXMvMi0xMDYwL2FkZF9tY3RwX2NvbnRyb2xsZXINCj4NCj4gKHdoZXJlIGkyYy02IGlzIGEgY2hp
bGQgbXV4IGJ1cyBvZiBpMmMtMiwgYW5kIGkyYy0yIDB4NjAgaXMgYSBtY3RwLWkyYyBpMmMNCj4g
ZGV2aWNlKS4NCj4NCj4gImVjaG8gaTJjLTYgPiAuLi4vMi0xMDYwL3JlbW92ZV9tY3RwX2NvbnRy
b2xsZXIiIHdvdWxkIHJlbW92ZSB0aGUgbWN0cC1pMmMNCj4gbmV0ZGV2Lg0KPiBTZXR0aW5nIGEg
cm9vdCBub2RlIGFzIGFuIG1jdHAgY29udHJvbGxlciB3b3VsZCBpbnZvbHZlIHdyaXRpbmcgaXRz
IG93biBuYW1lDQo+IHRvIHRoZSBhdHRyaWJ1dGUgZmlsZS4NCj4NCj4gSG93IGRvZXMgdGhhdCBs
b29rIHRvIHlvdT8NCg0KSSBsaWtlIHRoYXQgYSBsb3QgYmV0dGVyLiBTaW5jZSB0aGUgYXR0cmli
dXRlcyBsaXZlIG9uIHRoZSBtY3RwLWkyYw0KZGV2aWNlLCB0aGV5IGNhbiBqdXN0IGdvIGluIGRl
dl9ncm91cHMgYW5kIHRoZSBkcml2ZXIgY29yZSBjcmVhdGVzIGFuZA0KcmVtb3ZlcyB0aGVtIGZv
ciB1cy4gU28gSSBjYW4gZHJvcCB0aGUgcGVyLWFkYXB0ZXIgdHJhY2tpbmcgbGlzdCwgYW5kDQp0
aGUgcmVtb3ZlIG9yZGVyaW5nIGFuZCBwcm9iZSB3YWxrIHJhY2VzIFNhc2hpa28gZm91bmQgZ28g
YXdheSB3aXRoIGl0Lg0KDQpMZXQgbWUga25vdyBpZiB5b3UnZCByYXRoZXIgaGF2ZSBhbnkgb2Yg
dGhlc2UgZGlmZmVyZW50bHk6DQoNCiAgLSBhZGRpbmcgYSBidXMgdGhhdCBhbHJlYWR5IGhhcyBh
IG5ldGRldiwgb3IgcmVtb3Zpbmcgb25lIHRoYXQNCiAgICBkb2Vzbid0LCBqdXN0IHJldHVybnMg
c3VjY2Vzcw0KICAtIGEgYnVzIHRoYXQgaXNuJ3QgaW4gdGhpcyBjb250cm9sbGVyJ3MgbXV4IHRy
ZWUgZ2V0cyAtRUlOVkFMDQogIC0gYSBidXMgbmFtZSB0aGF0IGRvZXNuJ3QgZXhpc3QsIGUuZy4g
aTJjLTk5OTksIGdldHMgLUVOT0RFVg0KDQpCUiwNCktlbm55DQo=
