Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C83B71A2;
	Thu, 30 Jul 2026 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395515; cv=fail; b=XGNDVFMb3nY6YrSNigUqkA/zu4IfIeuLthmVrMgT3hy/ltLe8T7//WsO1vEj3Kqf0VZgv7Pb14T8wQdExAdnYKMgrxXz0zXCD1gOEPZxyDOzljAZefRFKafc7KZEd1k+lF1/2YR5Z3EgCWTc3ZvirHwJ4Ts6J3qF+Vfd7QmBuUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395515; c=relaxed/simple;
	bh=q3Lhock5rwvAE6LPzvnLoSBpADqCgOsa5Gl+cxo4Moo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l2RyLMjbvJc0GCOmOB2FO5uvuH0Yc7dMKUY7M8bLo8w/PyTxcrT2v5aqPo9sCiw0iYt7c/nq6rQNrNxw6hXaipdBXmfqRjtXmPZwUlGS/vpNLUXoKr7BP8RiTHvo3VAripkdCb8NULUZ3jzpGMWNc60SdHUNo0kdKdpXSrh5XHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=cyEWbvCo; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="cyEWbvCo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J37iCgeVXTV+2qqTZXj66MIycMyhqnc0mi8SyY9c+Nbnmq96eMOzVULduARAcJsXW/4XxKuNbHVaGDaZxSx+ZGuY2h4NNLnHtN6To9TgPvipN9Easwqz0bVqremfoeuStowS5OvfcTqCLhy6k+to0H8iYo32VBa5j2T6wEFEEpMn0PzeVu5bbSGBh+VvVX2P7KRzlHnHCIcoe8I0MWL8VDTNAJY8o0rPNeiTCgSBf+tsFYZFr3qQQxjjNwq7+qFhJE129tS5cRpcmccq+nfZsqXTQGrZal4eZzhQ9Q/l1QBnOvnSmyu3PUBrwU577v8pVxlYFzWIv3Px4JM8lBTBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVIoEYVo5CC/8sHYwmGXd82mwdGZ+jrSkW/cRXiUjnI=;
 b=cQv6T4rOOGdy8hdfkTK/nIW8eFZl2T9vHOcQmZ22Jjd975ZESWrteq0jkAkA4VrW5SkJAClfCfAxnu1dI6UaZMC0Yl0fAlU+zvoL14Xvrb4Zs1kZhe4io6nedwszL7aOaRSH7VaOG8LAzA/yH0kM4jJ0+N8HQM3vfk+omiuJafpcDadm5awIxjZhEf4DH3g40F3xLoEViZq0myge2G2vQtcvCOwiRbNfm0prWCkhkLehqRaXCmbzxVd44Yuji1ugOERzADc1OVZ0N6LXCotil51v6em9BXauD8DKn++GNv+s2sP1/bnwwVKFlz0AFZXXjMALn8JiF8nMr1woPY8low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVIoEYVo5CC/8sHYwmGXd82mwdGZ+jrSkW/cRXiUjnI=;
 b=cyEWbvCocsz016BQ5OJlJ24Ecl/UMNJBD0pJnJBONZ6EvcEf7T7QeOkXYmT9vRyK01nxwlxe6L0MXEX8Quz0maAhJ5w1Ed+nw3lZIbCVbyBzdFmZY92oHTOV0jBMt5M0bdA8SnODIEuojoCB+jpVwYT8pA+89I+ypJ6MdAEruCoITCHlnrj9/m2eQSGijL9VCcPkcBATT51MxLIj8cAYgzeP09I0IJP07a0XEqVTls4pJSBBTKUqdjUAgIseKNVgj0DtbpbEf5KJtRAZZTJI4l8WMNWQHyF0JfcZmooLdF3che9rsaULPIj31GA6GridCNfIQsEWy2I76u86PQGmuw==
Received: from AMDPR07MB11191.eurprd07.prod.outlook.com
 (2603:10a6:20b:71d::16) by DB9PR07MB8586.eurprd07.prod.outlook.com
 (2603:10a6:10:305::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.8; Thu, 30 Jul
 2026 07:11:43 +0000
Received: from AMDPR07MB11191.eurprd07.prod.outlook.com
 ([fe80::88b7:eb6e:24e8:ff7c]) by AMDPR07MB11191.eurprd07.prod.outlook.com
 ([fe80::88b7:eb6e:24e8:ff7c%5]) with mapi id 15.21.0292.005; Thu, 30 Jul 2026
 07:11:43 +0000
From: "Jie I. Li (Nokia)" <jie.i.li@nokia.com>
To: Andi Shyti <andi.shyti@kernel.org>, Jie Li <lj29312931@gmail.com>
CC: Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Wolfram Sang <wsa@kernel.org>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] i2c: core: support recovery for single-ended GPIOs
Thread-Topic: [PATCH v5 2/2] i2c: core: support recovery for single-ended
 GPIOs
Thread-Index: AQHc4TqSqTIgkJQ+jU6ymPdtfAHuCLaFhRAAgACc6EA=
Date: Thu, 30 Jul 2026 07:11:43 +0000
Message-ID:
 <AMDPR07MB11191AB1C5459FFB55CA4B612DDC92@AMDPR07MB11191.eurprd07.prod.outlook.com>
References:
 <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
 <20260511113726.49041-1-jie.i.li@nokia.com>
 <20260511113726.49041-3-jie.i.li@nokia.com>
 <amp0b2jpiV9VO9Pe@zenone.zhora.eu>
In-Reply-To: <amp0b2jpiV9VO9Pe@zenone.zhora.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMDPR07MB11191:EE_|DB9PR07MB8586:EE_
x-ms-office365-filtering-correlation-id: 23f14d7d-2874-4829-31e3-08deee09cf5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|6133799003|5023799004|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ik1VXur+Na7OEqoX/iWKSPVkwx0m+engmnIEEq/GqkuST5tx9ucJ/z81LanmvS5EajU4uyr/KGOUHAhKUDQGf/im01aa8KAlyxaTRxXKyLv8FAU86TOIboSeCM1sevHPxNt/byLDmOyOY1toSexrCag1gWS69QXA1qTaT7weZuFNQ5VNPFmc86UhBwTYO96BLhPdBtmqI4KdFC9lC1niZTNWVCszCODUCGZE38HjvjMcZJL4iZgl5JfuxFdoYdLnGE1Ty9jO8Zsk1KyuRPhmryLFeUxI1bDmD03nn15tjkV6bJYOXJiPkGqCtveYddbXK/o/eVa4BGpLa/mfPBsALPlfK37wcf817zq/ZzkxNNzQKtW1BdIBFauSXcWsiMLTgsL5D2sWsX+pNaTNK6f8RoFEyplHxNt3l8r7YwJxxwSmJe8E2XQ6xOuDd5z2GvU5OKhcOSO9pMI9Mp6rVf7BkhA3DrGolJQIbBvL3+MxbNkEcH8Y4ZZmfqy0WnGRayfEtBkup15E8aLJuYst8r+7FdYrNDEoWK7zSk4OucsACy3UfmiEbBCQ7Q9aOnb9DscQfFR3tQJJL8Q+4k9E8e0CpW0YcP2DiqI2PMuCCqDOaip+amM/GLrg75svIry9ylYojowfyjTBYGEiNchuFc5nsQP68zKXunR9PLUsjsaER5o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMDPR07MB11191.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(6133799003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VYnq2HVkj6WkKoO7Emh0qqvaVO3zVO29C5cTQcUcZQ3eONQM/9kq4w4h8QLZ?=
 =?us-ascii?Q?JN3rX0dV2ue/CTXe82eWiNHVvWx8jDdMYFoSez9ZEQrFGpeR3K0Ql8EW2SMs?=
 =?us-ascii?Q?7eqLpefiiTPvh3N15VrQ7UeJCVH8fE5ouJz+s4PfbdlKRLA4AF+mkS+OXKwE?=
 =?us-ascii?Q?r3e2/s/QG+PtziSP8qowaHW3VsPlmaiembUU894YkD77Q9ql1maN4NUR0l3o?=
 =?us-ascii?Q?AhpxBf2xugQ+DNcObEN1krUMjOTu9x4s4Saz6hyTRx/zRgQ96RIhuxay65bE?=
 =?us-ascii?Q?niK7TJOy/79g3ZbFphlMGxRgQOkgwuGa5UhA4nG67L+nNmbp3axJV0NrFyO0?=
 =?us-ascii?Q?enxLq01agAsWYAsrM9XQkER9kb5MfxS321dc+fM1xHMxSWEriTjJc6Ypdzwm?=
 =?us-ascii?Q?RP1PZ11+lzrG36VA6nWf11JFo5pkDjT4AOCQU04RCCAyyqN0qyY071AT967E?=
 =?us-ascii?Q?ksEp+famuBcc77ooqdyWBRe/qUq0nfii/72QckJ9y3KAa+n1O9EQhuSvteT+?=
 =?us-ascii?Q?esxAv8tF0vFMdj47goqhxX2ES4xWY+5IJ/X9WEGaZ2BdsP4waZ3IWmT/XmMw?=
 =?us-ascii?Q?NXjFoIozXB6dcYgUwBo/PizTH2BhhCDE8SPS+TUEh3gle662EJKea6CGuwCa?=
 =?us-ascii?Q?CLncmX1xdNKbDypgGTsDfCjrGXu4YOgB5Yqj5YEYUFRw0RdiPF+XxXvtDPKH?=
 =?us-ascii?Q?5EiEJmtqEF5plzb38J1x7wL4yBQvnf44CAEtFwUnlgPKrY1G/w8+sLxbD/ea?=
 =?us-ascii?Q?AUMYqy3SZvh82Jm8tUbRHrRBvbvCqc9lVyo9e8PPVnUVVfim8+k4QS+q9x1q?=
 =?us-ascii?Q?WbmzRZUUSCeZiVlB/Y7yIVsx9Dig2hxvyF2CyOr+CGDEqQHUs7omODx7G+Yw?=
 =?us-ascii?Q?NXcqJz41n7rN57SW7p+Y3ubGU+gj6kmGIsG8Baqak2mwhv8arFCYxg44DkE+?=
 =?us-ascii?Q?eL1YNALq8zMFgPFQ/fg5FxUh2i2LR7nGcTMLmBECZBffznUvhI8YggmHSsem?=
 =?us-ascii?Q?JyPo5NlY/mnmDARJJySu+zfEJpQuehLdokEozWVyMoo97V3XkxcWeDVC9AJn?=
 =?us-ascii?Q?yRxtzQxPTC0wsEkrTRzisjVZyk42IV8xlQAGb++sk5w9G/guN1fOBVj/wEzj?=
 =?us-ascii?Q?/dCjfsyQbjn9xFDN9RZoFAzdHeWPXE+IT5F+dOyPGjvwgrttsVO5qgqoDXR2?=
 =?us-ascii?Q?I+zP9xfoo6VOP8W4NG0i2RREkas5v1ZKdSCFPI4euDzX1Sd5FPDyPeLK2ACy?=
 =?us-ascii?Q?ktxT/IMVq+9yATcpZlc3DFH4szY5rD3k9+NZoyI3cuG8yayEx3vKjIC+vu8Z?=
 =?us-ascii?Q?SJ227uH0bLHOuCRwqiPhcjg40PP+BXY73f9obe4CaIzqoMRBorGW/XkEsiOH?=
 =?us-ascii?Q?iseo9C5Xj2kQ42Y9ZGXo4W4ckThYOVyUTqZgKO/MObOCsZBzG/4JSTDj2LG0?=
 =?us-ascii?Q?vW+rt2UgtLiXXJoYUYssHSFgRWwShT586kbyr/+OAstfVluBLkXS7Zf5uaFM?=
 =?us-ascii?Q?/3gEZluDseybKR+UPG4moeaIzz2DCHJZo2EyFIjhgKkhkUs0vSIWceRhlvyx?=
 =?us-ascii?Q?1uqaK5yI9kdJKLW6GRn11Ja98jmotaDRQZg8RmC/yL1mb9fQW0JGpgiGopJK?=
 =?us-ascii?Q?yt/zQBVme/i7oqtv91jvD8HhowQprATjBuOQPkrnLFIXGFAgcrZROlZ8ZIBF?=
 =?us-ascii?Q?dVlIDpiHS6lotdgvmQKB0D7M0MB2waS2PPOEivzFv6H3ewCQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMDPR07MB11191.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f14d7d-2874-4829-31e3-08deee09cf5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 07:11:43.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihX5rdK2nxn0FFJknorQIyE+HA8exBadQR4Vyi/NzwQGv5HC00/zxTyKdXP7AwejOSRWJ1XTIMU9WSPbUMss9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8586

Hi Andi,

Thank you very much for resolving the conflict and merging the patch!=20

This is my first time contributing code to the Linux community, and seeing =
it finally merged means a lot to me. I truly appreciate your patience, help=
, and time in guiding me through this.

I will also keep the --in-reply-to note in mind for future submissions.

Best regards,
Jie Li


-----Original Message-----
From: Andi Shyti <andi.shyti@kernel.org>=20
Sent: Wednesday, July 29, 2026 11:47 PM
To: Jie Li <lj29312931@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>; Linus Walleij <linusw@kernel.org=
>; Wolfram Sang <wsa@kernel.org>; Wolfram Sang <wsa+renesas@sang-engineerin=
g.com>; linux-gpio@vger.kernel.org; linux-i2c@vger.kernel.org; linux-kernel=
@vger.kernel.org; Jie I. Li (Nokia) <jie.i.li@nokia.com>
Subject: Re: [PATCH v5 2/2] i2c: core: support recovery for single-ended GP=
IOs

[You don't often get email from andi.shyti@kernel.org. Learn why this is im=
portant at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



Hi Jie,

On Mon, May 11, 2026 at 01:37:26PM +0200, Jie Li wrote:
> Currently, i2c_init_recovery() only assigns the set_sda/set_scl hooks=20
> if gpiod_get_direction() returns GPIO_LINE_DIRECTION_OUT.
>
> This logic fails on certain SoC controllers where open-drain lines in=20
> a high-impedance state are physically reported as inputs. This leads=20
> to a "deadlock" where the I2C core refuses to assign the recovery=20
> hooks because it incorrectly assumes the pins are input-only, even=20
> though they are fully capable of driving the bus low for recovery.
>
> Update the recovery initialization to use the new
> gpiod_is_single_ended() helper. If a GPIO is configured as open-drain=20
> or open-source in the firmware, it is safe to assume it can be used=20
> for bus recovery, even if the current hardware direction is reported=20
> as input.
>
> Signed-off-by: Jie Li <jie.i.li@nokia.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Please do not send subsequent versions as --in-reply-to, it's difficult to =
track them.

> ---
>  drivers/i2c/i2c-core-base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c=20
> index 9c46147e3506..a3c33e804d47 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -445,8 +445,8 @@ static int i2c_init_recovery(struct i2c_adapter *adap=
)
>               bri->set_scl =3D set_scl_gpio_value;
>               if (bri->sda_gpiod) {
>                       bri->get_sda =3D get_sda_gpio_value;
> -                     /* FIXME: add proper flag instead of '0' once avail=
able */
> -                     if (gpiod_get_direction(bri->sda_gpiod) =3D=3D 0)
> +                     if (gpiod_get_direction(bri->sda_gpiod) =3D=3D GPIO=
_LINE_DIRECTION_OUT ||
> +                         gpiod_is_single_ended(bri->sda_gpiod))

there was a little conflict here which I fixes and merged to i2c/i2c.

Thanks,
Andi
