Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.99
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793901809;
	b=XycpVGBmLdqnIq6+3tiv7VcuWDuDruClp9wqEkUftyZ/TYkZC+1sUeAUybS55/dQFDp9
	 1Zx7JPFhE4QeBNDUbw6gUSZgFxV487cJglga6pmG2RjQiBpHtYK6oWrpifmMPEwwghboZ
	 Cu7gPG6Bx7il1Ogh1UVDWQuNJGgyzW+o/2hFwqm5pfdIlC0e3fzuawWpPYb3KH0oStukQ
	 5COCs3D7+5k3Ha4u4VNaG6XJv9ScopLVOuyhzApRnIpIBVpaJ8CNDSdpoDsn2qlnz686G
	 MIyED/QTDT9CQNa0rZ7Uw7jjIG+q3M2m2V/k75E7bY+ol9I2m6U+VcI/hA8zZ2AIiLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901809;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-traffictypediagnostic:x-ms-publictraffictype:
	 client-request-id:request-id:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=/K11Ef0jsmM9iXUxgYkm3gQx6HMMKXDwelx+0vqom2k=;
	b=s9WC54gdMOyStFPUBa/1iXV8VY0NiRzLZ12OIh3WRCVJmi4TF/dR/2tOxjr6ZBoFBXWf
	 zQbkmTcm+0knDlQBFVSqjQRnWgWr6do0d20uEOAgvZkVUCtfPT0WonWdDpy0ETvKf/rbS
	 aCQ1VFvTX0m1+jWh0WIwc5eZU5u29ba93f3Au7CSggW5Y641rB/bKqEkbTCG3VAtKn5M+
	 jGdi8n9cr7ICE4OoOW2VVo2DLxC4KmK8+FAiHgM7y22w13fnfPhK6zD0YLMJR4aBRvmlI
	 GPg5XqmDDMRtYZAu07giChhkSgJIZ8WFbHgdVmNzZmDHpKh5aEBO3YqxdNZQsAc8pwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microsoft.com;
	spf=pass smtp.mailfrom=microsoft.com;
	dkim=pass header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=LY9m1KKR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.99
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020099.outbound.protection.outlook.com [52.101.56.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9D606A329;
	Thu,  5 Nov 2026 18:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B9D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=LY9m1KKR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVh82mlExga1oGdiYA151ll/0xifUkPqyNTxD374M0idluWsK2nSBSGzeJBgDb16qyFg1SP8LtsAKKDuCO10RaO/In5HtYohhUn9RWk838b41ICqXf71LN2VD692xvRLx4zCOD2kdbuUcfifu4KZGlz8Dz3rYSVd/+zSZle9S5du9qGS20ukAKkl090UIbP6+JKGIN+OX+63n6IF63FzcQmnjODNTwDlSARgAfiv/hWx7KZFLSsXqr7MYW4HMY/aUHmT/XSlFRiU/hnd1C7dQ9qumFWFsR+ZK66YiU9AXGIIPWw/HqQiQ7I916oAVzUyU1bQvLUnBO7SIl0w2Fy5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K11Ef0jsmM9iXUxgYkm3gQx6HMMKXDwelx+0vqom2k=;
 b=EHAmVWRaGGaH6O89E2DvZg+jGh3JMVlK4CXWoj+QWpbzM8rh3AsSJfRhfKE3Pe4gerieXX52zLrAPhtdg8iq5cIUZbfa7TcVVbbJtr5J25QcFtc/cix+Vjiz+r/d4EGhqNPSMSBeAnMiCvL2vlrzxSOX/0ZucAUnH/LTb1aoMya/2zQaOBCmXHGqBjNZAfYpYGPfvVH2bMdaSU4khdsPgn5V0N3cf0kvcgt60M5stq/kWSRJsiLwhxiWMd5r95rglZY4mjRePOK1DpiFGB9kkhgI9GLqmDH7NSvmYklKYu+qPmLbcunkQdkz4qmQQHm62obpTejnNHP/eL+1EJ81FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K11Ef0jsmM9iXUxgYkm3gQx6HMMKXDwelx+0vqom2k=;
 b=LY9m1KKReqnl4JXyOIz4guSvQahaluJfDPzQzbOqr9OYTLs7++pO02uy11OMtS2qZ5su8wuhytYCzwB7JtuWBFo7mhk7w+vBgBe8stw1hXwK5dlryfTfDE+cA8HE7lSVPy3N66dA1EPKAdfTUZluH3V8gzyMMUhe8vq1+4Od0EA=
Received: from DS0PR21MB6216.namprd21.prod.outlook.com (2603:10b6:8:2f2::11)
 by DS7PR21MB3127.namprd21.prod.outlook.com with HTTP via P2P; Thu, 5 Nov 2026
 18:03:24 +0000
Received: from DS0PR21MB6216.namprd21.prod.outlook.com
 ([fe80::4a94:8c82:66f4:a1b3]) by DS0PR21MB6216.namprd21.prod.outlook.com
 ([fe80::4a94:8c82:66f4:a1b3%6]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 18:03:24 +0000
From: Jeff Kirsher <jeff.kirsher@microsoft.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Andi Shyti
	<andi.shyti@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown
	<lenb@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Allen Pais
	<apais@microsoft.com>, "rlmenge@gmail.com" <rlmenge@gmail.com>,
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>, Jarred White
	<jarred.white@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
Thread-Topic: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
Thread-Index: AQHdbLdi1FTD6HpwwkWzHJA6zFFI3rcfxc8Q
Date: Thu, 5 Nov 2026 18:03:24 +0000
Message-ID:
 <DS0PR21MB621669A91752DA6CCAB1EBD39C772@DS0PR21MB6216.namprd21.prod.outlook.com>
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
In-Reply-To: <20261104234928.86458-1-sidchintamaneni@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a3bb3a86-302d-4cb1-a4c1-226e66fcc1f1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-11-05T18:01:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: DS0PR21MB6216:EE_|DS7PR21MB3127:EE_
x-ms-publictraffictype: Email
client-request-id: 0e1cc6ec-ccc1-4e0b-99d7-b103cb5731fb
request-id: a6e2535a-c5e1-4ae0-cdd9-08df3b6715eb
x-ms-office365-filtering-correlation-id: a6e2535a-c5e1-4ae0-cdd9-08df3b6715eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|10067099003|7146999003|7053199004|18002099003|38070700021|56012099006|11063799006|261026121527099003|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003;
x-microsoft-antispam-message-info:
 amNYiu6D1Fc2aC2DnJnkqRRBi3mR+kgIq+3j2iYhvKuFy00EL+77sgz/eXTG8HKFpP1epjZTgIMjrK88qx+Pb/UEiSzS2zGafYRbcpbfwUdR9eijPRky5PXmyQBVIDyRT/tGAei2CzAi4bk5KYi0FIJnbPUqQ1NPGQU83WTa8LkGTpwMY1/VjJfNX6wu+/y7XFPJ0Q7qzz8sBV8j+aM93AwGuIhjPchN6vW28UbWZsLi7A3DUdqGwdTRm5GirANPIoHm1EP6+l6NxWdAazehfKxhFdud4lbx4gHp4aWkwaDK7cxf+ZtgOh7N3skmoWU2TkWijfztL+CsD5OsouWxKhqhSaQkwOGlE+VXjHzY559emEk5+IMKwIIi5wwCAuaHFiHkJ6VLviivJCRmnE2cpmEwFcH2ZDqLKku+M+c5hevekVC1e9dFNIvSK1Hdn12N17NEsk7DI+ha8uQqf36eQUF/HuPap3nC/J7AHVMpAS1SdMc5wuoZrsHhWZcnDqHDrWQbUaLy2mFOAvAk2KdO1w1XUdlT30dL97vRq0a6A/rRFYxfgOVMg1TDNqkjlb5m1h8CFbGhOO2yaIupJXjtWhF8RJMpxe6sPJPUtN08QOPQvjGnIVkVSdEoTZAFVjVNlGlWzr0qE2wo47YnknMtDBO76WEIVkm86yTG9SM2C2iTeXB9sqI3kHBjl6bMUW+o8Ndr5rjR43UUu8T20d7UVV7V2b9/VexNpsazX5Gj72U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(10067099003)(7146999003)(7053199004)(18002099003)(38070700021)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hjLvYNn/T1MOHpLYJ7H1zauS1DDtRpI1McXUB0gutNa87K8eY8y8rl976RAa?=
 =?us-ascii?Q?eNeOy8+kon1HxXGNfoMpT5nmTEqmtI18GKYcamoGAcQV9q5DDec/5kEffV1F?=
 =?us-ascii?Q?AkbwcsyThjH4XJK5NgG6dyNNeCN5KO2NIvVwh7oj0CavkjkY7HMCuyTpv/mM?=
 =?us-ascii?Q?yi9K9/A+Q/zdo34uMDnNgq4GLyw+JJgxzcp5G7tTlSLq/p6ouII0EhMkFYZY?=
 =?us-ascii?Q?aglJDiY52hh7XC5s2kYXB6M/al65nmVmfJIhZOt2pkjCt0BCgvqvFQNjmZnd?=
 =?us-ascii?Q?qowyXCv6l1dtIE8BsJGpVCAF/mZjwuCFAowghp0jkh0j3r9ltN8NbIFj9TfG?=
 =?us-ascii?Q?EsFIE92WJaF3bRNkRl8/CFazWnCwow1IIzBqFlGLTe1nqJfS7hAOrSPobi23?=
 =?us-ascii?Q?q3ef+T7Rk34PBbub7u5lGjpNGsMZ55qDYmPpF5s4f5/S+vQkIYPg1z+d94Yg?=
 =?us-ascii?Q?5bV17dKxIIX2UgfesWJPgkLO6OyzQRJABsf80/pF/SGSBBxF4I5z1iSLzvhS?=
 =?us-ascii?Q?pbU1yz6IYGu6U7jHyBfvO1zrNLNmkj15wVKTXVqdA7efhCmVSUuXuOkNrQhA?=
 =?us-ascii?Q?YBixNMQK/3GMpiVyzxFWNfsXubuaopsk+p12tK3wvEeVq2Yt7ixN8hWvDi5y?=
 =?us-ascii?Q?oWjeZvKzmcGcrEPNSRG4vYpK2w21RWf8hiMku6yE809tXEr7IfSEtsEwGjuE?=
 =?us-ascii?Q?4COac98IX5xzTnImzX6LHEDWAFH1eRObkhRFdorllYfq3hfVgCR0BLv+QxvU?=
 =?us-ascii?Q?MOU1efjkNmxZfTeHQLymYpT8VeYk7xPgcPqmVl/uS3+Z9BLGHeihG0LERESH?=
 =?us-ascii?Q?DdbF+Y4EQu2RRPqE7FsVXKIU1454lR3gWsNrkeO0vyQ0Q4zE6tmsT0LrY3/r?=
 =?us-ascii?Q?J7evw6sg3GFCOUHK3EKoQjfPddgzNHYCv6TaahoCrxuKd0ny10WFDp7W2x1Y?=
 =?us-ascii?Q?sIJju3JHgeS0+dE5Kg6Bw+fy66x0LGLUpIitSSXwcKkmvjAIryAYRuIQ+4le?=
 =?us-ascii?Q?s3Qd3YZr4nVSgmYn8rOfO4TwWy4sIllSR57HBalTHrUJ36PrSnHGbelff3MF?=
 =?us-ascii?Q?EhVTlVv2cOIz/Lb6Y7jm6buT2c3cKaW31Hr7gH69ydxJggztfEYzYvLBXvch?=
 =?us-ascii?Q?tdjNozuW7IkijzVGIK3UCXbWOl36p6Q9HNkG1VZ999xl3WJ/dOsseENu5JiP?=
 =?us-ascii?Q?5UiQoy3lqS4Jc1UnGIbFSPE0Q22s6riT6x122yWHIppX1E0xe2TkJJjR0CIO?=
 =?us-ascii?Q?yEepbSXfR6zKSwb3gxqrrHgBa30NyFwPd33l4sK6J32zuct2yJBa9WWp4zzD?=
 =?us-ascii?Q?AqbKXA5xDvwqjfM++I4gHZfl7FqHszW2prYFvnLzGp+mdhGAbkjQJjeNtB2n?=
 =?us-ascii?Q?qrS8/TKXp/rm7K1CI1744ceTHaJ/Ka/YRO1b/BDRCkk+NnKh7BGDuXywpgE1?=
 =?us-ascii?Q?jRx30ESuJzjLHl4kgqVRa7yI2oS6nQNNbiGGlIrnkDLkJq7Sq+N3wl6f5tIK?=
 =?us-ascii?Q?DiXndESz7doF77Rv17zuWKmu7OSM/o5BbqcHg4DVWpFI4EvQr6o3EESXTZVk?=
 =?us-ascii?Q?+ko24ymvmtlhVPbC4y5HGYsg6g4JEoO8mx4m31j0FGR4HJg6yBkm/w9O3U2u?=
 =?us-ascii?Q?KrG14Dh7mNnACNdq/bZntHFnQ7Gz7NT+hUgtOK1kdOBxVCHpJrNKMFovOeQn?=
 =?us-ascii?Q?W6bffg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR21MB6216.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e2535a-c5e1-4ae0-cdd9-08df3b6715eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 18:03:24.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bh5eVQGsInavHsWM6ExdpP1VIrKh7tzUsOGQd9hjgNYffXXW4/zt/0Ure3vAZHRCefsQkEFZks3W5ge37ij8xS6NE6qBvYw//A2p/iP1ZL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3127

> -----Original Message-----
> From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> Sent: Wednesday, November 4, 2026 3:49 PM
> To: Andi Shyti <andi.shyti@kernel.org>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Rafael J . Wysocki <rafael@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Len Brown
> <lenb@kernel.org>; linux-i2c@vger.kernel.org; linux-acpi@vger.kernel.org;
> linux-kernel@vger.kernel.org; Allen Pais <apais@microsoft.com>;
> rlmenge@gmail.com; hargar@linux.microsoft.com; Siddharth Chintamaneni
> <sidchintamaneni@gmail.com>; Jarred White <jarred.white@microsoft.com>;
> Jeff Kirsher <jeff.kirsher@microsoft.com>
> Subject: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
> for Microsoft Cobalt SoCs
>=20
> [You don't often get email from sidchintamaneni@gmail.com. Learn why this=
 is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated on
> Microsoft Cobalt SoCs, along with its 300 MHz input clock description in
> acpi_apd.c.
>=20
> Without an explicit MSFT0006 entry, ACPI device matching falls back to it=
s
> _CID (APMC0D0F), which configures a 100 MHz input clock instead of the
> controller's actual 300 MHz clock.
>=20
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Acked-by: Jeff Kirsher <jeff.kirsher@microsoft.com>

> ---
> Cc: Jarred White <jarredwhite@microsoft.com>
>
>  drivers/acpi/acpi_apd.c                     | 6 ++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c index
> 9fc667d6776c8..a1baa056931c4 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -198,6 +198,11 @@ static const struct apd_device_desc hjmc_i2c_desc =
=3D
> {
>         .fixed_clk_rate =3D 200 * HZ_PER_MHZ,  };
>=20
> +static const struct apd_device_desc msft_i2c_desc =3D {
> +       .setup =3D acpi_apd_setup,
> +       .fixed_clk_rate =3D 300 * HZ_PER_MHZ, };
> +
>  #endif /* CONFIG_ARM64 */
>=20
>  #endif
> @@ -272,6 +277,7 @@ static const struct acpi_device_id
> acpi_apd_device_ids[] =3D {
>         { "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
>         { "LECA0002", APD_ADDR(leca_spi_desc) },
>         { "LECA0003", APD_ADDR(leca_i2c_desc) },
> +       { "MSFT0006", APD_ADDR(msft_i2c_desc) },
>         { "NXP0001", APD_ADDR(nxp_i2c_desc) },  #endif
>         { }
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 1da6b0314b6a0..f359d38cc63c7 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -280,6 +280,7 @@ static const struct acpi_device_id
> dw_i2c_acpi_match[] =3D {
>         { .id =3D "INT3433" },
>         { .id =3D "INTC10EF" },
>         { .id =3D "LECA0003" },
> +       { .id =3D "MSFT0006" },
>         { }
>  };
>  MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
> --
> 2.45.4

