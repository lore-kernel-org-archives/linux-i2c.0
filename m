Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010005.outbound.protection.outlook.com [52.101.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A347AF63;
	Tue,  1 Sep 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259218; cv=fail; b=Nspu0zAtXBeY9O7VvSYmys1+/TvmeL5yaPky2tNgcdh9vKjF55GaI6sN33onOrjWmNeb1Isr1FPCSJpM5mDNj00wThBBEsXDgPfkF/Jo2Opjwf0FGrPm6DGiRbS6KjT88aLixNiLwtCcDO2C0LB3N5UKtKq9zTa+srrCXgGFyoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259218; c=relaxed/simple;
	bh=PYrgB27nHG47qDCrt407EGfzcdCYOMdeJN8Y6KjwzNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5O4TgIJeh3wd9/iC/7tI7YdvqxH704S4sWaNpY7d2Pjp/oH0JT4Lk8m5r77kq0/pjjVNIAfRHEtGKFDvp5DofClmluHreq0eYmnFKeSergHNGEcXBCGG+/fzcXOWvrye1suszZf4yZWYRoCUOvLXNNMoPIYLBNGgWyvBWh+2tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=IiqY+5nH; arc=fail smtp.client-ip=52.101.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="IiqY+5nH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS+8L5+Cf6AxfIyWIN/nLon5tgg9Q4mb3Ky74uM2LKTYIKhfXIdeBmXYKMIJc5vpwpFekfJWIgjrDMIzP/wYzJGjECdKHURpWMuVR81Y/lRKSXq0/fUMQ8cA9hm8ibv4DBT0J8xoKPxUko3uoZUPqC4CYLeY6lYH6Z2fvbQNIGST9Bke7RRYIdvzRtVcrmv/kq87lL+dssKo2LYXMVS2Jiz3rbP5WsHWlWTzx5hJ7163o4anf7RiQ3qIFRA+ntnun7yDmOsMOl2dG5952Yh/fnOwWZ1SJttDgWL1/m9GJ593W6mYaIVNQaC/eulpJKx7QDwVmix84GYtlrVRv11eDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVIaqheCLRNxrl2Vpb623NK2uyYfjazLDOATHqq5+/M=;
 b=c0nms/uo8CinS8BrcJNZKN5BL18FTTfjBu/4PlJ1RKCpBmYo3ODAnCGD8WhFHLo+JF1IgvpgVjVNaOk7PyV7p6qPaddBC4P7P9rJRPvbtMDbIPReVIkTT9Tom8c22dz//QO1vWugJ5tldAPTtWXcsW54uBCh7PscbCT2CnKnhYmvpZ5+ciM/8km+enSr9iMLuhWpWrjzB7suEJhv+/Vwo340WZoHdPCO5tSu0KyNPEY9SD5A/SMCPCsoO5E88pQ8wUc1RUz+O8Jp9l7fB3R0nMmhPmEx1XiEbRpftiCCwrgujMHVsbldQt77Ph+S4eKNdpX+TFce0VUlRskQEIukbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVIaqheCLRNxrl2Vpb623NK2uyYfjazLDOATHqq5+/M=;
 b=IiqY+5nHR6FVDzD6rSd8Bp10ClLhbUn9ajABcqhe5h3bOjNz8l45zlkPY4zUIKGXSs6E9C7qgHUbF2wfc3FQyvXLl1AhxqiVSGWiQA7Psj6F1CeaXo1Xpy0z4TLk1LVAQj6esKA8J9SraEpMGFOIg1uaqcQ4wzTkfukPr27pSRM=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OS7PR01MB11582.jpnprd01.prod.outlook.com (2603:1096:604:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 10:40:11 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::3468:d7ea:e817:1e6c]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::3468:d7ea:e817:1e6c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 10:40:11 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: Andi Shyti <andi.shyti@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] i2c: rzv2m: fail probe on reset and runtime-PM errors
Thread-Topic: [PATCH] i2c: rzv2m: fail probe on reset and runtime-PM errors
Thread-Index: AQHdOIjcsCvbNqEeD0a/MEJ4Apv73ba5g7uA
Date: Tue, 1 Sep 2026 10:40:11 +0000
Message-ID:
 <TYCPR01MB12093CE7BCF79C0226A971ECAC2A82@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20260830140709.28745-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260830140709.28745-1-pengpeng@iscas.ac.cn>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OS7PR01MB11582:EE_
x-ms-office365-filtering-correlation-id: d7b62aab-daab-442d-27cb-08df0815665f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|22082099003|18002099003|56012099006|11063799006|5023799004|38070700021;
x-microsoft-antispam-message-info:
 7Gaj96yJslstWLptNDFb9MLL4Mwoco1MerL7yW7Bpx00T3VqAeqDEGc0rgItQOuKjE45GS5QOlwRS/UeFrCGnxFukk4bJMkafkmipOTXkJmlPr1spWVY6BhZBrFOsX+NtxTszztsnZFor+q4iaRaqBl+Hs8AgNeaS4ZVLStFrgpST8JN1Mj2NCcYoDuOCPOnvuYOBtFbJAl1R2jHAfqhXKMQffX5jp8lraMf0CTerQi2+5xyjtAgtRlMLIDDB0A+ivTJD5fLTlLXDoSdwuNnDtUBPun8cObuD0eAq/bjdZ4k8473g16fkbLjSh/CUkG4Ta4e2zfTXJ2Ji+Pawql4sTd8F+ahfJyuwbZXuDXXllCzKGcl66TBJA37UBTQ7C/jA/sc3hN005J64JAdoj3qwaBrzvU8txqgJFYbwb67KYXaXLi8zkeFho61xug0ohie6P6Yp4aN7JmT0LHQWetRCMB9zFkxjtcidl2jmhUrja6xa4wSlh/voWvog7+MXjWhtnlASsFACxW7vgNMc5CVZ0v5c/6gRiI3AAeGtvLzr+xDZ3P59U9fOrf9hOTGgbf5c/ZLeeJz0CIrsNI6tU2ztLxKUxwAimNJyRYpXvKykOHTagbRfd/4HIg91hWAjLNZVXWuwsSCXk+1QJaQRAW2UjolaMQNPxT/BNx6LMurpDtUBiEdIzrxfgYSe3Qb/6qT2fFYYaYMxKoeGqMwgE92Q8xMPrwkVTHx2xsstUN6OnI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qZw1lYOeoTdN2StQrtWBlHKEZQQMkMOA13HUGIjcj1og4lQIFdk7EOcnhSeJ?=
 =?us-ascii?Q?ZdqZXZepStrUr6OMp44capaj8IjYsPkP/E7Sz7bZacBbz6jdS8plTkA2X18+?=
 =?us-ascii?Q?fbhYXG4gbUJNzK6MVGXJ0hCpHp0fouPNyQ9OGBal3ji6Kzk7limuBnb5zPch?=
 =?us-ascii?Q?tX5lpGQF8l5mToKvRgiUAzioRUjEprCBTEzRUaqUcSCCNkR+iyFOj4XXqilI?=
 =?us-ascii?Q?8QRURylzAKeAT0ZLzF2DtPmNp6PQ7WXvyem8WmXgpq2ggoxshEkYYA4EjmMb?=
 =?us-ascii?Q?29xYCkybB9zv3Cuhs3Pz7yxeXBWi5SNQTlPlgMOt6RxzxMM/rcI1zFzcRHu4?=
 =?us-ascii?Q?6+Gjj+qRpCuK3n1dqi38AesdxAz2mKBVOXYH/o/K3i0Y4tJhur2DFFXpXVnL?=
 =?us-ascii?Q?wwCVZkrQYuV4S1GsFINmcRUeYnedCbkpwrIZ7x1wcPQYWWhxP4sLQl2yJVrF?=
 =?us-ascii?Q?kkA1IirrHgj6C1VlY+VoD2eA1w0wQ+eM5MVNL2lwJQy9rHSittfIRk2ZOqxM?=
 =?us-ascii?Q?/KvOXgh8YG5ijj31Uy/hrC6yIqyxzzrHTzHW02Z6LFvP1lyV7NxggVXvj+88?=
 =?us-ascii?Q?69pQCLeZSMpbU35+x+/y7l6Q+NqA7SppC8rqbigppba+3jMnPQOyx11H+C5Q?=
 =?us-ascii?Q?l27/6hiMil+FzST8sCO5XgwkFzaexAcq/yRJWTU1KwoMoz8vxDVZVUdyatIL?=
 =?us-ascii?Q?gSILEOGs4o0liukrH/XpUCphb3Qa0Zkb5jIj/1QPWiHczkHrJNOjVT+GiiAK?=
 =?us-ascii?Q?Y1lA8oAxivkN0Mg0+3fy/ecwRklwUPbF5b78KEe1Se936HtgtW/RRIW6LII2?=
 =?us-ascii?Q?Cd2jRix4OBP/Y9wV1ysR61DU5OwCQV9cq8io/4suWXGujILiTZK7jLi5Wq9r?=
 =?us-ascii?Q?nxZz8eLWPXnRd45r+jlv6cYAG6onVb+eoJuGynIwCmdd47nT7cSqjyGxGab1?=
 =?us-ascii?Q?dHC4AP9CniIZPQ8pZG4VPNQ541ptcF304TzwrMr9dhZ4mk2muPgMc4R6VVPX?=
 =?us-ascii?Q?CnNE62ADhk7OZLJoGv0MFgCYteC70wRnHAK/Vq5eYHJ3w2yn+opnKXvxyhFy?=
 =?us-ascii?Q?8OdTiyBNKNAgimZDl2ylzg0dBJtifF3KGtqVNGoZHX/UKse70cgiif1sdQaE?=
 =?us-ascii?Q?QYWWLz9QD2SxXfzuHw4gnN2Hli4SFo5mFtJ03nLkopxfdf4ywGgQZGhCGXJg?=
 =?us-ascii?Q?/fqnQeDXGmoIdNL1Ig1MfCYsc3pDbwR0kODnEQ3ZNJlpoyxfjo8clzhSjVki?=
 =?us-ascii?Q?o4L+ftTPXjd7/Uy61lo4hk7Q4MNadwVVamXAJzozDvIdOqoQnO0Q9nC/MkXf?=
 =?us-ascii?Q?kzVFdKBxM8pX3YtbLCVeoea6EOdkrhlhwyEQmMfo13NmSuB6Cer8Ur3UXIHz?=
 =?us-ascii?Q?917d8D3/fYoj/sBkxZhjjgu21Cm/a+dp8j+nL2bPXVPEgTdn/uE0gAOYgVly?=
 =?us-ascii?Q?gFFAVsgv06R2ON1wmB5XRCFFwpiirrPt8/awbFbLZbbDaZN7i4GQ+0RI+/S8?=
 =?us-ascii?Q?e569Sa8uCsBl/z1CqpMtaX6Laa0QjgE6vdY4tRJ8zw5XwekvGO0wSIRocSk9?=
 =?us-ascii?Q?sRUnNvpw1blzUGYPjvGdaKhydVkQ+wRYqbs9nL/q90/YgNJPbkCbktkHyxZf?=
 =?us-ascii?Q?BP2USBYWxCcOUena52Q3WodCaQQ8iGVvKfppQX5mRsa40ozmYLvlTCrk4HRX?=
 =?us-ascii?Q?heePm1cbNwQDNuYzuOSDmZz1UWygfi2sQupwL55HFAO1o+6KsrVWS6Pzd6zE?=
 =?us-ascii?Q?mFZoipxeKtWJArNvVI0+BHHJB3OkJwQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b62aab-daab-442d-27cb-08df0815665f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 10:40:11.4500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYeU/joNY0C2qWbopduVxqLlvirdA/2y458VD+6hf9X8Z4o3kF5/drODb/wnILUFa6RlPvEnLoy/V1bQGlr5iq4cZ/hm1R7XM7PpApXFLD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11582

Hi Pengpeng,

Thanks for your patch.

> From: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Sent: 30 August 2026 15:07
> To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>; Andi Shyti <andi.shyti@kernel.or=
g>; Philipp Zabel
> <p.zabel@pengutronix.de>; linux-i2c@vger.kernel.org; linux-renesas-soc@vg=
er.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] i2c: rzv2m: fail probe on reset and runtime-PM errors
>=20
> Probe ignores reset deassertion and runtime-PM activation failures before
> initializing the controller and registering an I2C adapter.
>=20
> Propagate both required activation errors and disable runtime PM if its
> initial resume fails.
>=20
> Fixes: e0ca796a151b ("i2c: Add Renesas RZ/V2M controller")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Did you use an AI tool to generate this patch?

Do you need the `Assisted-by` tag here?

> ---
>  drivers/i2c/busses/i2c-rzv2m.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-rzv2m.c b/drivers/i2c/busses/i2c-rzv2=
m.c
> index 206a99e722a37..81e0101b61946 100644
> --- a/drivers/i2c/busses/i2c-rzv2m.c
> +++ b/drivers/i2c/busses/i2c-rzv2m.c
> @@ -433,7 +433,9 @@ static int rzv2m_i2c_probe(struct platform_device *pd=
ev)
>  	 * The reset also affects other HW that is not under the control
>  	 * of Linux. Therefore, all we can do is deassert the reset.
>  	 */
> -	reset_control_deassert(rstc);
> +	ret =3D reset_control_deassert(rstc);
> +	if (ret)
> +		return ret;

While the change is sound, the RZ/V2M has a strange SW arrangement.
Half the system is managed by firmware code running on a dedicated core,
the other half of the system is managed by Linux running on its own core.

Some resources are shared between the 2 halves, and the line that separates
the two is sometimes blurry. This patch should be tested against the firmwa=
re
code to make sure it's not preventing the I2C controller driver from starti=
ng
probing.

I don't have access to the firmware code at the moment, therefore I am incl=
ined
to say that perhaps we shouldn't consider it until somebody is able to prop=
erly
test it, as I suspect that the return value of reset_control_deassert() was=
 not
tested for a reason.

Cheers,
Fab

>=20
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
> @@ -461,7 +463,11 @@ static int rzv2m_i2c_probe(struct platform_device *p=
dev)
>=20
>  	pm_runtime_enable(dev);
>=20
> -	pm_runtime_get_sync(dev);
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret < 0) {
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
>  	rzv2m_i2c_init(priv);
>  	pm_runtime_put(dev);
>=20
> base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
> --
> 2.50.1

