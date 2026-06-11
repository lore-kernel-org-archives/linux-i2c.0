Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023094.outbound.protection.outlook.com [40.107.162.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43823FBEBC;
	Thu, 11 Jun 2026 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182929; cv=fail; b=Ae6IqnHP6E0hVG4Odo6nk3PP8QDP8aC5N2DWCphHbp+fBCJbKY+1i8SP6JkVcJNwAUOZ0BX3a6sK6l5vtipnoq3i/uTqQZ5uLBIF4tv1jMjMcdPRfES66yhVGa1+Oe6oALOU5PSFWmXWqPQyAjgto+NuwqqTRJu+Y6D3sd5rVlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182929; c=relaxed/simple;
	bh=G0YA8skJwzau5y6NPvD24qgDJH4Ml9T2xypekUw08r0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=okwWL/Su/khTbUqqJK/H/CuvhPOyrq/caQ4iYXxNF50qQPVXN9BjNBQhNuUgdqMB17UKF2RkwGgwwxrtX6eeJA4GS5xq+/quj+EyJs3NxMjmdcImffDFMggtQjyTOX8h0t72JBL76UzElLTAxX27LyNH2tXs/Axbz2W5Iqmi9Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barco.com; spf=pass smtp.mailfrom=barco.com; dkim=pass (1024-bit key) header.d=barco.com header.i=@barco.com header.b=gCfhek2S; arc=fail smtp.client-ip=40.107.162.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=barco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=barco.com header.i=@barco.com header.b="gCfhek2S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHaVYKh2BzdiaT4isClgkAgU+EN5N5zg64I+Fne9khNyROPtfwKzm/McUdjFlqp9V/wnJTFd2oda2SQkvOs+xKBW1tViVaY04g9IJsSew5fBLppMrAV3CSza4jE4oFUmWdNTKEwJds+arEBGavr3ZsjjzE2WAH4qgi2t6sACo+lg5DQwTRXdtlUQe1f0VSDD5WSNLIX4slFsGDgOJ8wyLje+fvf39ejT/D1tqYI0kLwlKB7vueWJjkoDfzeCRsp+RCryEGYzWqlKZqS+lcR7BDuSIQ770uc9WJh/N6WGoACpOdEjUkHc8O6924yAIBCWLcR9SPk+Qc1/qfSbGvXJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0YA8skJwzau5y6NPvD24qgDJH4Ml9T2xypekUw08r0=;
 b=kBLozGHT4oorcKPOLNSCMxALDwV0czfGNJLcDYwHJBz6HcsTje+RMJCH9GzLVXapqTLrJHE4yjM35sRZh010/3aGkvRPxjYk05LAjGqFpgsznuVPZXRXf0dilUlK21f4cS+Z0MU8YvFQmJWPB+yfXCoQHCanQ7Ef7UPRuNtEbaFoENmJ5Hp50lNxHfz2abbxoGP2nXHVHa0E3dqSqtTSqxwmg+bYMnnjpCbe4Ug+n88wQZ8BEnzhRDTrHa6N6/Drh03ArJyrJy/o29/L9NTCbkcJt+L/mbiUcSwn7oNsLgf7yAFhINczV6L+8yB3LGpOLeYOMDZl6hDr0Qj0coayPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=barco.com; dmarc=pass action=none header.from=barco.com;
 dkim=pass header.d=barco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0YA8skJwzau5y6NPvD24qgDJH4Ml9T2xypekUw08r0=;
 b=gCfhek2SyeuOR9OTeWod0dpcPv9ZeWb6YkoMiLH+kEQZ1gOhBA/+8Ap7MM+nSPcodPhgaFeQ/JTqTnHXAdQvyxLkWMh9s+aOWhafD4MwSTXXOQwEosHXxvXVw8j17L46lq+ndZ9mONqdXcEbZfqMVXKLuSqEDjfEXfjEhtDlvMI=
Received: from DB9PR09MB6082.eurprd09.prod.outlook.com (2603:10a6:10:3d6::20)
 by GV2PR09MB8857.eurprd09.prod.outlook.com (2603:10a6:150:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 13:02:03 +0000
Received: from DB9PR09MB6082.eurprd09.prod.outlook.com
 ([fe80::2bdd:b680:ae9a:cd7d]) by DB9PR09MB6082.eurprd09.prod.outlook.com
 ([fe80::2bdd:b680:ae9a:cd7d%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 13:02:03 +0000
From: "Korsgaard, Peter" <peter.korsgaard@barco.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: mux-gpio: name correct maintainer
Thread-Topic: [PATCH] dt-bindings: i2c: mux-gpio: name correct maintainer
Thread-Index: AQHc+ZzKt0+yKnItXkmOqCiRwI71+LY5UXWL
Date: Thu, 11 Jun 2026 13:02:03 +0000
Message-ID:
 <DB9PR09MB608288AE367DF5F476EA3A4BE41B2@DB9PR09MB6082.eurprd09.prod.outlook.com>
References: <20260611122053.7306-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260611122053.7306-2-wsa+renesas@sang-engineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=barco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6082:EE_|GV2PR09MB8857:EE_
x-ms-office365-filtering-correlation-id: d851df37-23b3-4a11-1526-08dec7b9a1f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Oy6mjMMxHjodFJXohEDtXtTQsHUB3urxa6EY4ZYT6D7GiCXDDsOPHIBuQJGmGrk/ayNNd1gaXwMfoaqHnZlR7D0WvhYa3TWjRPRCuGdRqlAerl6y27T0QH2D2mNnhEM5mgfRt/wXB7mGruJdBW0+/gr3LQh1qQFfuXVQ7K2ni65LF7yBRAqOeq7qy7rkgNL+93crvdq9RPmY2f4bkNZOlXCHSM+AvaCyr0BJtk09ch0ewjm9H9s5yTVA4QIrR5It1QbEjwDxJnxQjLOnUhkcuCUXSXQV0BjEo4TXnqW4RbDKPdXq0f5daMaDuK34mlz4WzCuF102J5CbHiqR4xTnruhfa3oH8Y8qJsr+yEK/+7n1xtWDTO4EeV7F6Nyb+wLi+Ew7TkwOvqOAqzYnHbugRDXa4elMdlbcAXlqcIBxjIYEFtw32xSVOBCuE+4uUNsRAFsWSLUcQ4t41YFs3OCyEh7rE0FJmu4b+3PtMaY2UxrEMXGiPJH5ACp9LncN13tN6mc7CqPfs8NQCURQDpt/ozz5gN09dY8KRFTPGYp+ubNui0hmeSS0ZfCA9Qd98v3vo9GyIrVrxAoMEsat+nb79qFzpCXOks5FUIqiO4THlUmpnlRqOTjKck/buqblI5fmlAslPsFnC2o1HgMrOL14LgcRczvL6Rmjik8laiQgkNPieYqpDJ4OE15/M0BjvZXM1q4MctDQb3TdqqKef2ldQKXidg3/RfREFxIWmntDVCcoQ+fux3FCv7ZSxFVroTPl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR09MB6082.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2idx4r27cBg3AAhpBIY9hE77A4fjzW95yUyjb19x3AwlPRjeqRBFe1K7Bv?=
 =?iso-8859-1?Q?pMFfzW77ed03u7fDZUaMggaWBciEw61V16yIDkQnE7yP+MPXDK63vR0kXv?=
 =?iso-8859-1?Q?+bIHOvrWQ0YTK5yzzZLlkkelmM6UhNgyx0+jTiYRO2O3aP4NyTvvZB+RRT?=
 =?iso-8859-1?Q?PVVamoiCHshsM37lQgs4yocNNeSziJ/ngjNWS38x6kqLJx4a9dFWQIuWk/?=
 =?iso-8859-1?Q?FNgb/3DRti8KxVDrIneiv3wpQFEGL4dSS+Qo2TmTFSfyAAscdRwIZmwPQq?=
 =?iso-8859-1?Q?PZT3Spy0g+KQh5GHjzrukflqz2kJ3VF9mCadgjHVIqexqJiFOfG9fcHYGm?=
 =?iso-8859-1?Q?q7KqNdHrQHcaMOw8Wg3mkGiOe+x3k8EoPLHiK8+LHiKrjOXmhyualzd2Zy?=
 =?iso-8859-1?Q?P+B2J4PftSIVrklo+KDkWaEAq+/Xp1qKXWoOlnFrRs0cL6GjK535WBNtw6?=
 =?iso-8859-1?Q?VjRc0WJ9wBw9ow6nSEj5Q8qvPdq1vj7WVvOUitECEUx7/CKvtN4kQJtc/P?=
 =?iso-8859-1?Q?6R6Mn16kQQeuHOcm0VecV+lJ1kzkUIF5mF4XatXhygepkfqNiOLdBMANIk?=
 =?iso-8859-1?Q?dFxSquNSkATizvnZdwxxjrjihk7RsvamizPqKV6D4Uahsb+s7o86J0A+nA?=
 =?iso-8859-1?Q?1R+5j0Xi4E+xXtFCt1/nODEotJAB26vq+STOqgi9HHKtP6WWqehfN90uHf?=
 =?iso-8859-1?Q?hNmf/PA1rS3WV7RFgAms6l55h44LkPCTprY0+lQTzFfokzJrC7ohKv9VtL?=
 =?iso-8859-1?Q?dK10LYh5OtWy0bY9tYVBXqgHu9GM9jKKjK/mQNCwGUK2a8UX52gq3oxZCO?=
 =?iso-8859-1?Q?IwLv9zfKSwxzYfJsfnDfG8fShOR5uJ/IXMgTjrBII/+59hqb+0n2STkzT1?=
 =?iso-8859-1?Q?Cja7gQjHXsKt7dwgego5KUHESdW3Rq+NzUTqYyBumU4p/SmyeT3hN2Atzn?=
 =?iso-8859-1?Q?+wPlQ0B4rjTxt1++1+4hsTCJ/hKsWdWqjnuiL+xb65v+YloeegvDlg4PA6?=
 =?iso-8859-1?Q?nMZ/KCNRNp8Fu4T67Te7jTuZmEccSnz3NT/3B7XA48Ggn0ruydlq35GHjy?=
 =?iso-8859-1?Q?d4cRYyo7ZWINuGhG8f2z+sepaz1oQCRmfQyyb+0hqB2C7s9i1bVr9LHeyd?=
 =?iso-8859-1?Q?hgZcf/pYfqhRcjtI8aG3hynZagmdCfh30/WPs522Xv/nrl+UgAQ2yp9bsF?=
 =?iso-8859-1?Q?SzzJW2hshedkYycRk0xoPT5UWxDdvMDAgfocz9pECt/+K9D3ycVE8IFCoa?=
 =?iso-8859-1?Q?3FFp3m98sjA5PVYO7x2O/0ogJx+HJjPY+ijbgO+qY44hpRNz4jI0JFBxLZ?=
 =?iso-8859-1?Q?kMZp/AbyroiOI4k9oiruejsSMQhPKEQSSLnRzBOPIB32ya/lKcdl67tqN6?=
 =?iso-8859-1?Q?BfYbJ90lJgRjVKAObtONuo5eFUTrSB5AruU6+eXtLVcRJ1Y3CZlc/yLRGd?=
 =?iso-8859-1?Q?iS0HEkmBT8RJFEKzkz2x5WbiDdgGePhkLhNzK5yp9tVm8qChaiaqYRoj5m?=
 =?iso-8859-1?Q?s8K1l2Ao/5NEtPWmrwM+fhF1O/YtJc2/lQJoKTV1MEAU3RUKubN3xFlDPJ?=
 =?iso-8859-1?Q?FkqLQnueZriaQs8ODPRxs8kK+mlnOujM/Uxt+Q4t54LkV52JgheycNTf/b?=
 =?iso-8859-1?Q?C2J3+utb9ThRpSOCJ0kEf36gca1MOF+WJqwfhyfvU46jPju1p9iN6OKydY?=
 =?iso-8859-1?Q?ePk0WhEXI0PNZT9HHnwlhSnaxYSe7g2wQhzP0BGhmPgPaSe+99+p2Hw6YC?=
 =?iso-8859-1?Q?N6HBgRt9VwhNCzMnfBEwUkwpK0ehFS/k44+ISTh5Iuz4CI8r0btZldnRwN?=
 =?iso-8859-1?Q?x8eaZh8cXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: barco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6082.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d851df37-23b3-4a11-1526-08dec7b9a1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 13:02:03.3131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: aeb84c91-6270-4446-ada5-d71ceba1d535
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O9V8UmaWgL0j4q65CAsSIkcskCGXBbCRbxYyRxq4WavddgRZoX4iXoPnfPFGuxlF5UUOAW0ghJrPKgVrbjQMXCIV4tZ3k82Abp1GgHjziIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB8857

Hi,

> The YAML conversion added me as maintainer but I can't recall being
> asked nor do I want to maintain it. Add Peter as maintainer for the
> binding as he is maintainer of the driver.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

--
Bye, Peter Korsgaard

This message is subject to the following terms and conditions: MAIL DISCLAI=
MER<https://www.barco.com/en/maildisclaimer>
