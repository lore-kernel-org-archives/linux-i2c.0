Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793802234;
	b=h/SJsQ+3dTdhoGAy1z8bJIMIza66qawh7DosmgpTJ/RGDfwBbZzKrIx6g2kdGQAJ3I3N
	 KbvF37Xp508Y3M9Y3Uz6du6z1dz3fzMSndbJo6/s0AIHHuEAzqS1CsqoZtspzzOF8DA9j
	 AhTYwdud55wmk/rRCFq/HfJ1idBSwq8psmKVR+nq7vbXJIns9lPEeEzPBG/lwkOxdBwTv
	 gplQVk3HLIeqsLH9Yvj0oflhOjwhBhb0PRuGIGYYgRsF6R3qkcIG6cm5kE8DFgNk14s/X
	 qHPOCrtry0R9/DQxOny9ZJJGAsdNhq+uRG0SH22jck0nwtlM5dJ6Rxo+zLC9npqXsqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802234;
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
	bh=UJiZ/edD9rygHoGw3pnHaWeZWZCqBpp8FVAmHlhAbUo=;
	b=ngfHNNPul719tK7glKNEFstTbSXo3dLXfYJCObrEXDECWPX8OiBr7pguydqMJOaOoLiO
	 MUZP38QjI391q+IJ3JucU6QChYI2/pJ9A0QM0VTkpy216QDqSaFawjgUDtW90GpcaPvop
	 qHPF27SfSUiDfaM6r//PwfZ24e7cVvUjmyDaIBid4CbYq6upwkarGVYufyM3lCTxgGvlX
	 ETd1ZESji0iiTxO4aktc/8U2Q7bJ7bhZPCC1nUNbHtbzFmKvoO72hqL3pb35o8htszrOZ
	 Z7MMktIoTFCj+Pnpwto6ulOhXYy+clne2/fY/9lVFWbdTUvcG9g1yKFCe7vl1j8x3oA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b="d3tBZ/os";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AD606A31B;
	Wed,  4 Nov 2026 14:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=d3tBZ/os
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAL8icthwion25kyEU2ZD6For80Ezm0MVPRdQNHOTPU+D/dAzKWzwJWLGjwP2e8eTCm7LisNnS4bx4lgZTzryf+AxNAtwMF5o3mA8FX1BYUHdEslUqP233gHs4AOeqOXimaVaSQ9X+jxtrH8JwDbNRqOhR07uIzTjYpdQGq0BmHZXqgFUh+y7DLnOYwTr2BP5QC6/PCj4A4RSSnlJP1LmqTZvsQ8rHdHsQuHfTVGjDcuvEnOst/PAGs0DjY+e3ETnVatJ3A3iXPZhNI2liiWW2a9PJVoHXdLMns6AD26LVgITO7NqEpMIDVZZrkHzADkNVmCQsy6sqcQyuICrEeGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJiZ/edD9rygHoGw3pnHaWeZWZCqBpp8FVAmHlhAbUo=;
 b=JmZ5IRuTXNsXLIfcGdh/SXK8FpmiKBBKMw+AP6gHIf4OqUoyD36XTLyuK7500y4R69A5tPGLJP5m0IOHEIPv1aBpQIKR9wWR3WRLMEoKD46J9r43ZeyjkKDL02N75bIvaWagzCi7VEG/UZvlE9UkE2SBMMhACctVP8P9TDl51niz7uKP4YN+VXzRkn3DYbI/lOSvb56jg0Dvu3RmI1FY1hYTGEDEjSlGz5UiAXTjPdCWuahRzIpzIOA2K/TpYJqZ8irWj3DeSIw3vz1j6DK9wQaZaGKV3gccTtOrM0IqZJnlj0EUy6XsfbftvSX1+IJNN51Uv43KzPXsCvY5Nfw8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jabil.com; dmarc=pass action=none header.from=jabil.com;
 dkim=pass header.d=jabil.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJiZ/edD9rygHoGw3pnHaWeZWZCqBpp8FVAmHlhAbUo=;
 b=d3tBZ/osC5RF2GCDAulgnOc4/+t796e10AihWu797EdpE0/Kl/NmzAhn98kg+3gRNx7m3brynVrA6cv1ShGAwdZf81nro463AAZ4Z7KFiKmE3ICUQjiBkLuFGwP3f/x43bBAcaTgk2bVt9Nwb59OG51FneBAHN4KIYx/ysHDRv4UpsSICpG+riVgZJaAoi0Q1/6+J4Gxj7oxUhbKxqGDqgdFPMTkLIDAA6wuxoXVmvzuY/JbLmaObn8kSuU6SOs6Vcl5jM9JGXNP3FbFwlTFtmeFoR3pM3RrnPWISU/0TuT4T7+he6aP4rDsvfaQ778l3zhXAkjEiRGjpumQUE5E+A==
Received: from BL3PR02MB8084.namprd02.prod.outlook.com (2603:10b6:208:35d::13)
 by DS7PR02MB11034.namprd02.prod.outlook.com (2603:10b6:8:261::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:23:51 +0000
Received: from BL3PR02MB8084.namprd02.prod.outlook.com
 ([fe80::f221:ed9f:c0a4:fa9e]) by BL3PR02MB8084.namprd02.prod.outlook.com
 ([fe80::f221:ed9f:c0a4:fa9e%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 14:23:51 +0000
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
Thread-Index:
 AQHdXH0gJEQaa7DeYESRNm+vhnedSrcEkYgAgAyNxfCACXoQgIABm7iQgAFhsICAAH++AA==
Date: Wed, 4 Nov 2026 14:23:51 +0000
Message-ID:
 <BL3PR02MB808435160B5537BE70F5E0928E682@BL3PR02MB8084.namprd02.prod.outlook.com>
References: <20261015081341.1262695-1-kenny_hsieh@jabil.com>
		 <179239912623.3135.11352652156626817288@kernel.org>
		 <DM8PR02MB808768B7D02FF12777B7777E8E602@DM8PR02MB8087.namprd02.prod.outlook.com>
	 <7486b1fc4dbcca755dd2f6b6de54d17919af873a.camel@codeconstruct.com.au>
	 <DM8PR02MB80878075D2520A9CAD7DF0928E692@DM8PR02MB8087.namprd02.prod.outlook.com>
 <e89969f13177f2e7b3105851d0cf42eaf11bd98e.camel@codeconstruct.com.au>
In-Reply-To:
 <e89969f13177f2e7b3105851d0cf42eaf11bd98e.camel@codeconstruct.com.au>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jabil.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB8084:EE_|DS7PR02MB11034:EE_
x-ms-office365-filtering-correlation-id: 6be563f3-dd72-44bd-d3ef-08df3a7f3fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|4143699003|11063799006|56012099006|261026121527099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 UChvTc5D7sdZASW9jhaB5eZPKDcG6Ws0BQrZDQZLFCB0y43y6w9IjMFZXuQuHuuH6NEVkEFZJxbXkfiMAofRBtXd8zm2q3jUS0DWt5eZ2AUGCrUpIAYEoa97Prgbsoph5JeT0OHoKO880eCKopGO9r+F/VJGGKu+s9efrt5pWjnR/zNwfLn8z/QuKUdFFtJ6YjdqlHIwDMQJnRqHKkMWKcuaO4zPipJAv2L0iQqV/BOImnHuBisa5Pg5jG3a+Ae0nC4MLU3yJuK2kiXfRKxVqzc7D9NpIMYjl+LQO2cwpyAeAqMbTEuSAq8vNrKIP2XBwAgooMeIQuI1O3E/YbMgBEuGmrKpQEd3jwf1MNZiQSFMLM02noIbPXBVXk1KGqHyLozxmnP8/9tx1mS0R+0G506J6I6s6KI4jcFL7XYEN8ANXePUo25fpZW+0D0157erbJWVuPLqKEUnREe2gG+U9QZdHkFF+ed7ziyC0CJxu0JH1s7nwquA23szT1YFC3jz7sNsDNHHTF0OZk+s21zwShqeS0o6Zu/ozamJ71XJAv6OvDPuyaIJEyKrwhDCXFQRgtd4Zsa+sHaABGlSiSrBnV64zFXnuxmqJoEpr8/7DZds2uJdFEftpVmDMCdHmY2OvRpzWFpnCyf0am/2Q1/FokdzSS+9JDT1S+PS+Vidr938wwBn5hCl+Hol1jbGCsvKOJZiN4waEUYLma0bgdgEZd+e3M4Ay7nVBVQVLY2F7NU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8084.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(4143699003)(11063799006)(56012099006)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVdRaExUbldicVlaR05XYzZxYVg3M2hWb2w3QVB6TlFCZ0RVUUlhblRXclU5?=
 =?utf-8?B?NUFQbjNuVUZzMVpRb00yMDJFNEZzOGluVXV3b00zYU9ybTg1RklYbk9HdHBO?=
 =?utf-8?B?Y25BWWp5TzZqNmNpMEhLUmdSRjVLUU8yaUsrTXVHL29laWRaODk2MUx3SVpu?=
 =?utf-8?B?Um9uNm9hR0QydEFTamJ0aTkzeldoOXZiT3I0VEpaczJjWE02cklkU3VEZFBt?=
 =?utf-8?B?ZXhrZWRML2hsMXBiVFFEaENzVUc5WEVQK2tuVjB1UGt4djFlSS9kS3VMMUtj?=
 =?utf-8?B?UDI1VHYyczVIWVVxQVVLM29VV1dWR3J0SWQ3Nlk1WHI0UnhJN21LNndqV1V6?=
 =?utf-8?B?VzlZM2VSenlnK3BqZU1RaUdyMUY2ZlFEY3oycUVxTjFXNW8rc0VUTU55UmN6?=
 =?utf-8?B?Y2VseFVOVngvaFZzS2ZOdXNWdHY2V2xTZ1VhZHdGbVZrekhPS2Z0cDJ6TmhG?=
 =?utf-8?B?MGk4eHAvYm1ESVJOZ1ZMM3dNSlA3VnEzSFViM2RaRjVKT1BjRG1HRFJrVm1m?=
 =?utf-8?B?dVo2Ym1xU3dXQzlGR1ZWSHltMlhJUzBWRWRhb1Y2dW1iMWFPdXp5YW9taHFj?=
 =?utf-8?B?Q1l3bEJpQm5xTktPcUE5SVgvbU9FU1EyMUdaR0o1cmpJY3NWbHMyWWEybWRy?=
 =?utf-8?B?cWZyVS81akIwa0VLa2tYeWpXNHBEZ3VHRWx5ejFkamdvdWY4eVJnamxmRitH?=
 =?utf-8?B?RFE5ODU2ajVFcEpxcFZRWlJaeWp4akdHSVlUNUF0TjEvVyt1ckRtMTJ3cXFo?=
 =?utf-8?B?MXhOSFY4WHhhNUtvQXMvTmgvcWszUFFkV0ltcmxzNDgrYUk4S21aQ0VOSnFG?=
 =?utf-8?B?L3RpYzhIZWl2aGV1cU9lbFpUU2Y0SVZwWHdyaGJZc2hTSWI4dkRlazdUclM2?=
 =?utf-8?B?MU5GSFpKSHVsdkxpQ3VmZHVyZEh3ajZiSk5WS3VxeUZCanIrbGZRRStHcGNL?=
 =?utf-8?B?Wnh5L1ZqOTZFdCtORWw0NndKVUp5Q1pVQzFPcFRXMzZEMWp6Um8zQS84bEtz?=
 =?utf-8?B?Yjg0TWtWeXc3UG1OdmM4TW42b1pGZ3pHdjY5aDFoL3RuQm9wZmdpeTY5dDNp?=
 =?utf-8?B?NlYxQmdIekdRWVVKeFhFbFJHYThJYnVGR0VuVlI0OTZPNnZic0tZU0VpTG9N?=
 =?utf-8?B?RjMyd2NsR29palh2YUNOOVBwS3YzTlZEaEFyb1VpZEJtVHdMbU1Rb1R6eXd2?=
 =?utf-8?B?cmhUS2pzbWEzQUtzRzJ4aUtCUHY0TmhNK0dxUE53RGozMGRjRDU0ZkVjUjZ0?=
 =?utf-8?B?bGRoMFkrQk5tZUZKdTZGNU4rMEx0TTQzWUhqU0ZyR3dDODNwNjYwb3N6RGxq?=
 =?utf-8?B?RFBYQ0JnYkNFaHoxOE1HZGYwbDRLZU1HcFd2Q0FkbTlaWTFTbXR0U1UxZHg1?=
 =?utf-8?B?cFUvREFUWmxBVnQ4aVh6dmV0cHhwUnIzY3RRZ1Zqa1UxQzJ6LzBzZDA4NTVi?=
 =?utf-8?B?RWJPUEZSeXNUN3MrQ1ZQMjVwTDk0ZVo0aGpiWjlKMGloT3VPUlNCUndFa0RV?=
 =?utf-8?B?aVh2aWRKeHU5bnZLY1Z2VHNwaThrZXFhRXN2a0RrNkErZG9xbEJoSGxCWmha?=
 =?utf-8?B?UFQwdWJJeGd1ZWp5Q2U3bVM3QmRySDJPK040SVh4MFI2MkdFdThUNGpxY0xM?=
 =?utf-8?B?REw4Nmtvd080bnhTUDBYV1NDZTJWWkJLU2tEcTg4MnhBQ0RKLzh4RjZtdkpB?=
 =?utf-8?B?WUo4QU04TDAyQTZid3FjT2hneXlMWjNSOGQ0Q2hBYkRjamRrMWNub0VYNFhC?=
 =?utf-8?B?YWk4YjJKVGx2WnhvZ2g3SUR5RUY5MzU1WjRuWUZuRGxTYk5TVmxUSjcyK3RR?=
 =?utf-8?B?UlB1N05XcU56WUNzbWdLS2IxTktxQlFPYUF4SlM1Z3pBTkx2V3prRW9vdWpZ?=
 =?utf-8?B?T3F6bkVndUFQT0QwUE5GWUpOdzcwVUtnbERTc2lrZGVGeDhHa0NzRDNmSmpD?=
 =?utf-8?B?cnRDcEhoSm5hd3paaUxLZllIdlRoOWdrRTZxdXhaNjQ2RGI0UlgxNldNYkVv?=
 =?utf-8?B?SklOUmR3TGFyMjd5OWM0SERVay9CWWNzeXA0Ykk5RndrR2NHcGY4WVpydkRR?=
 =?utf-8?B?TWpZQnF2OTBzb245V2ljMGRLTmQwaHNsSi9XY0xkMnFqTjBja1llQW9OVW4r?=
 =?utf-8?B?NHdkZUhwaWZ1bzMxdW1tTVpXOXYzZ2M0RXdDTGpnQXNnRmU4SUR4SThoQjFB?=
 =?utf-8?B?WnRRd1BVTU5pb3dOaEhvd29DSXFCOVpyejBwU2w3azdDTHJjZmpFM3JHTG5X?=
 =?utf-8?B?UWJsWE4vSEVsT01EWnZqV1FIT3NadmlGbThJd1RuQmUycS9JUWV0ODJxWTVu?=
 =?utf-8?B?cGpDSG5TSVc2WU9scWVEaFRBdm12Y0hVek1QbzB1VXRBeEpzTjBkUT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8084.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be563f3-dd72-44bd-d3ef-08df3a7f3fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 14:23:51.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsaJiYv5jddVnKg4NAK/g7izMRaNSlM3s/xjBNue7j/Lj7diHpJ5vB7KYAI/YUixzUbwRYozIFoH+ybm+tBMJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB11034

SGkgTWF0dCwNCg0KT24gV2VkLCAyMDI2LTExLTA0IGF0IDE0OjQ0ICswODAwLCBNYXR0IEpvaG5z
dG9uIHdyb3RlOg0KPiA+ICAgLSBhZGRpbmcgYSBidXMgdGhhdCBhbHJlYWR5IGhhcyBhIG5ldGRl
diwgb3IgcmVtb3Zpbmcgb25lIHRoYXQNCj4gPiAgICAgZG9lc24ndCwganVzdCByZXR1cm5zIHN1
Y2Nlc3MNCj4NCj4gV291bGQgaXQgYmUgYmV0dGVyIHRvIHJldHVybiBFRVhJU1QgKGFkZCkgb3Ig
RU5PREVWIChyZW1vdmUpIGZvciB0aG9zZSBjYXNlcz8NCj4gVGhhdCBjb3VsZCBjYXRjaCBtaXN0
YWtlcy4gVXN1YWxseSB0aGVyZSdkIGJlIGEgc2luZ2xlIHVzZXJzcGFjZSBwcm9ncmFtDQo+IG1h
bmFnaW5nIGl0LCBzbyBpdCBkb2Vzbid0IG5lZWQgdG8gYmUgaWRlbXBvdGVudD8NCg0KQWdyZWVk
LCBpbiB2MyB0aG9zZSB3aWxsIGdldCBFRVhJU1QgYW5kIEVOT0RFVi4NCg0KQlIsDQpLZW5ueQ0K
