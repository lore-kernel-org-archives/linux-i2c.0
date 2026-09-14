Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AEA1A6817;
	Mon, 14 Sep 2026 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789356513; cv=fail; b=RsU/iACd/V2A/XTibDjfFZsEOYWOSZR+2j6PK1WBUJ8rLqKYUfuq7C9nuwM6BK19WJkiHwY01sKNmN0+F3afGd2xxZ6VqAirdHO3T++WBpsC7ZxTWozitIkNTez7I2yLYoToXil5tTs6zK5VnjWu/8BEHKDWk+E+avPJJ7L2c8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789356513; c=relaxed/simple;
	bh=0gUfYj2x8pWebLV63JEt3OmyVE6daMNABSPYKvkOhwo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GQJ77MrH4SVzCCSllNwOItlxN/vg1h8PHPL6eeZDa57+UhWv2ILIWQb9YNfuaVs3hTiXx/8+bUPrLBXBmZXwlcL7FuIAC/nnJv2QtrTlpc1quDTem0/UGe8WxMxHC8UNYstap0Uxanjgl8KvvrlZmYEBSMlmcJFJtLzqP2Qyb3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KNcCHtIP; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KNcCHtIP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxlZGJAAyxr5LfA28CcdA6yac5B/3Q+6dvPjzPpbusvsdzGfH1fH3RKaQ7uMd5IqarDixeGrVKoBbG5hgN6oGucP8Weifq5zI3Pg5sz7WRYerz9zcj5MIDicOJkzQHBLft0KpLb4eDeGDrLhIZRSI4uLABp5vUB5jY7lOxef2qpIMAzi8P9uWXoiLXyFXKFyZrbF/L6xvFbkUsAqAplDdcDg6V4LKXy3+4GeM+EKd9V7MwyUN/CVVV7nz3JhIqG0AwFz3HzJVXP7itm+h7m8JfNs15Aow6YLnAVPkbgw/aNHRfVDX3yqzIbTuRkJWKWSQZZ9NHtMKoBE6rd9+1RtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii64DO2E5Q2A/0BLzv6pWvxdQKiOfdWrYailiniV8RE=;
 b=m4xjyiVSCc4XzNeV5PrUD95Nb8R+l4a9V7PTr2kJDJTVi5NlS3nm/n1UqpaQNe9PJYoGidpfYsazoq4sdv5D7WKjBwpGgQcUDnWKROepHFf3gBCD7N1ZhbmEeinPA0+inG9triWTINIU7OyuIyg6wXOrRkiAajPEWqssmbXH+ttHRnXkFEcqBVAHgoMeSDOHvn7NBiJVnajvf/bTE2WHrCQDYWNeSIZZwiQ4oEw5Pul33G7ioqpOy9d6sjRixh6htIEesFnqvoB6T4gbntNolLkNbV7xFgMEE739/sX0It0d8xD1/SfoJ1rJd4fFT4O+Bzk7BmnXp4Ad7GZA8Hb7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii64DO2E5Q2A/0BLzv6pWvxdQKiOfdWrYailiniV8RE=;
 b=KNcCHtIPQDUbMJ7A+nrWT1XdKgRPNWQHWpFdfch5WPj7fdjM21sE4ebaiqp4o8ste+HxvSbbymZKNnfhaSKbJ2cH7a2vDnpciMMIJP7W9UobSeY9WKt8zVlu0oTm87a/IHut1SZgqm4aXpKFFe/mZvrn/EOe2K4elYKW5tSarmanTM0XtaWrbM/cw9gMvBV6xH3kdjH94gMrHMpcWRROUJYdSYOIPF4toT72ztGZDa2w3eH+kROSDMQnKHaE0XcKvJpu82KIXOrXJo+BIgbjTeqK13JhCHvR4h9Gf6XMWbMfgMJaIYDKLOXay5V8zMrPCGA/ar+015w530tSj6tVdA==
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 03:28:29 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 03:28:29 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Aisheng Dong <aisheng.dong@nxp.com>, Frank Li <frank.li@nxp.com>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: linux-next: regression in i2c-imx-lpi2c.c after rust-i2c-next merge
 (next-20260910)
Thread-Topic: linux-next: regression in i2c-imx-lpi2c.c after rust-i2c-next
 merge (next-20260910)
Thread-Index: Ad1D9RMqoig6Pr8qTkWLbK63wLmfKg==
Date: Mon, 14 Sep 2026 03:28:29 +0000
Message-ID:
 <AM0PR04MB68023742F715A3BB3DEC1929E8BB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Enabled=True;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SetDate=2026-09-14T02:59:49.0000000Z;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Name=NXP
 Public;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_ContentBits=3;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6802:EE_|DU2PR04MB8549:EE_
x-ms-office365-filtering-correlation-id: e06e54e7-2bda-45df-ab08-08df12103eca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|11063799006|56012099006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 UR6J0ctaD2fFzFI+uUIhEZ21bRlTTqKT1rUqeAwLFXEhBqiPKr6p3z4/xkfOR4wPwboZX3AI4gEVKnjX5kHOeBOcbmBAuMZJJq4spoNMABT8KJGGp8uc7d8ZRWD31R/RDEk5OswAkzBuYrrhFlOmVbYcNSPWNeQYVu9qTZL7Vq9guLGYifJMEYjZJnYAuXX6PFW8e+/3L3rbzj5Ht2Wrv2yN7IUaIB6PPPQJwdGXS0g1qhsN29CyIyCUuNwP879CWHUs6yIXejHUJfJhbiMAkDjNLi61FaJSdfjEhMqL694WVKjxLRk2KURsAqWg+Z+XHn0BfHgpN6rK+e/DNyla/yFFVjhdypTrzSQf1sMCkVDBWOxxwypc1/w1pebnzu6G5m1V4UlNMfinnaHHYh3KEaqVmjTyMpdtPsn16+tIhrPkQBiz3q10sQo5/UtqgNZBSQAh1gtymrEY4CHx2sNutD6OrKuSswDFfyE09cjC8rwObddcIVyCewPWv0Fr0q1UqM+dYpYJxaIZdZTS9SDLuMQGQEB4qGJkro3vV74QzkIYqTptHNefKBT62zNMNT6KmA2GIfNxTrLORp2WU+lRefz5E6QKjBYbq6u9qsawb5d8i0CO21xod985vvCpd8yj8FOwOPHUoAm4WOPHqoJGds7ddF0OUKs+ub2AXeROr6tcuMADRGqs36n0SKcZTl9OfyDd63jBgrY7eQgdvAfqnqjsx4NesDx/0DcIEr5Vt1Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lvCxEQ8UcQ7bF2ixuMBaw3L0qBOxY6WXknIVQKCwdL2Pq3KnK0G7P+PmfPwm?=
 =?us-ascii?Q?YVejCH++LxfPApmEW7lCv/YF+4roH14PlbqkneNu4PHsbFSo0z1FtTqtSFN1?=
 =?us-ascii?Q?yen10r6QL2vsa0gUTCGGSizUaNIQsmTmGZWtT+EY0ma039nms+5xn7ZMaa0/?=
 =?us-ascii?Q?WFlmg1EaLh0QQ0T3fUlJ9z8+89A3/Bvgt47DSrV3A5sPeyNJpgoSaF7brt4w?=
 =?us-ascii?Q?AvBxOd1hAbx0PlWTBvuxKbYuZUjtlGGRG6s+//GI7TgW4HPywpPMt/VCwosh?=
 =?us-ascii?Q?1yCxIzHiDZuGxvTmRD9I99N9sHch4IOQJ1/Vm9/xNufOT460c1bmX6ywn3gt?=
 =?us-ascii?Q?ssYeKPOc0HA25uBLJylWo2ssa9iSEYn2ObsF5O6xr+35VY8Tj8c2XR/GWT+k?=
 =?us-ascii?Q?OBpk5Cx8tk0ey66V8sswAQNsjHp39eeFA243l8xIyGE1Wooxow9FEy8k5qhm?=
 =?us-ascii?Q?6G4CN80MY4pbRuip746y4xxJBBdHogMDNE/7WJzFkRVKYWsBVhY1tV8rPp8H?=
 =?us-ascii?Q?QoSWySMJTKYu4iXZK1idAtzkJEnA6hnhyOYlb4w80qXDbtglMhl29IMJB4Qd?=
 =?us-ascii?Q?xpOXUMCVd0vptWtKRTCIKDrO5h7cj8PLqhDRg+yz6a9UhUAHsnKXK0Z5tlmP?=
 =?us-ascii?Q?PtbrUTVeQ8g2lGAEgiZgGXZkRlogg8l2f1SOAv3pYM88SdZF7B737nP19IR/?=
 =?us-ascii?Q?ShnRqjHm8KzGCe9QijhN0Z4UH/nst7RpUIcYYM/9U7tlxO832FzoEHi8Q0BR?=
 =?us-ascii?Q?SoSJBU6GngSGn5fEJQ5NEepYB2XBEqiB16KuLotNgDi7ER8iiuYu4ws3liY4?=
 =?us-ascii?Q?ebFJKEU1lQMidJIonzDyxWxkCpuT/Ic+ok/H8izHnGSqvo2niqVpKe5fdpmu?=
 =?us-ascii?Q?C16nvRhlVuutknBgdcsGSSiVKbbpz1aIqSXwAVA5r8we+WkFltM/V6RSu3gO?=
 =?us-ascii?Q?tk/19d0NJ6sIMHZPuGEsBgZPmfHs5Kr1fvrY1JMRGnAaHmW4cvypUw1rC+LO?=
 =?us-ascii?Q?7xanA2dQaifkrALUeWjj+MEhbasvNihsTyhgpC+ErqHCJcoep6sZAv+LylIn?=
 =?us-ascii?Q?cgWx8rcLHZh3GUVo3xEuSNaNN1orNYYjEasDNZcprZ0+GxxUPO/hYpaOocM9?=
 =?us-ascii?Q?Hv/lzHA0jI+uILOqq6Aro/uOJNCUWEAVYeLl8VZq7adidhL8qrgEcIEQNYBT?=
 =?us-ascii?Q?RMb6jKotEVz3nSetgekF5lCl9rcgZDLAY3/jNC+OpyIBZSHK8xkcYcsQH6ow?=
 =?us-ascii?Q?2aMH5Nr/xg8vOPveEr5qk3sxu/9XtkChonuTyvXNtlMBsP4mKCUM+yC/wjtt?=
 =?us-ascii?Q?vlEGG6Z0ytCZv+/6EDOj6RygpotpT8H7W4yFqwjyJc6SyjMv7dHbRPAAoOoV?=
 =?us-ascii?Q?PBsrINDAQVmpd2madPVYkYmIHKVgUBCtFx3YwRCWVVgdwh9/NUpDD7OtCH13?=
 =?us-ascii?Q?KW1xDkaOjQ/AQAe5fElN+XJAGTT9ibD13HhzrqCEcPjo9Id2+iWGJ0S4exy8?=
 =?us-ascii?Q?peqZlesniRin/o5JbnkdBcdeE7LtnP+AvcY5Xh/lg0MskFZpFsSEejJirk8M?=
 =?us-ascii?Q?no/zlURgkXvIaY3O+zQ8HHRyMjVg1sgn6OW8zBbu6CAuhylXf0KoitplLlQS?=
 =?us-ascii?Q?pj9tRxeeCGjhgPIqFpcCVxBG2x8kJajnL2QLpYmWmiS4NcYO6mQVsxZDvyxX?=
 =?us-ascii?Q?9M3CQ0T4ei1SprYUsHKFcNyltPtpekuD5BXhJO63O3y+6NND?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06e54e7-2bda-45df-ab08-08df12103eca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 03:28:29.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqB7QpM2wzXud79b2/ivHjaQzlxQ1V25tSvloEkj2fF/17Yr/RC9rTtIELXI25TkBcQan4uqyDEXeiZHWrJw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549

Hi, Mark and Andi

While looking at next-20260910, I noticed that the merge commit:

commit 2edfbdfb8f9c5b2482232087a03fa1a6692b9e5b
Merge: 98d87b29bc8a7 61ddec70c9bcc
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Sep 10 14:19:17 2026 +0100

    Merge branch 'rust-i2c-next' of https://github.com/ikrtn/rust-for-linux

    # Conflicts:
    #       drivers/i2c/busses/i2c-imx-lpi2c.c

After this merge, I meet a regression on the i.MX8Q series starting from ne=
xt-20260910
(next-20260909 was still fine).

The root cause is:
Change to lpi2c_imx_probe() from this patch[1] was replaced back with the o=
ld logic during the merge conflict resolution(2edfbdfb8f9c).

Could you help pick these missing codes back?

[1] 27c9445be86b1 i2c: imx-lpi2c: avoid accessing target registers on maste=
r-only controllers

Best Regards,
Carlos


NXP Public
