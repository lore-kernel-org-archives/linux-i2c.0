Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DC43E9C4;
	Mon, 31 Aug 2026 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184741; cv=fail; b=AmPL9o3/DO1ADi2NZpr84B+rFhyKKXP9A0HUEKHkHIIcAwVqKjANIw+VYd9gt+j5xXOiUnGEh9ClqANQcuIxywKNpEM2Zjr8TjHCIzdXMpfOz4vCzlO69+0nWQSkZUxBjBQGmj2BOqK/SwB4EbH9QH7eNomKdZBntPx5/LbLySU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184741; c=relaxed/simple;
	bh=dTkLU+KdUa6SzTiuhZ+duUMtV+Qms55of7sADUaCCO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z1xhrFIL6zjbEvbbMj2Ju5+v4x0mFBE4kfJVLHL/rtoIucIKu07XwfPxpcYNYbxazX0P2cCdrGMI1Eov/dZe2xiGbPndJBYVkZgm2JAd8rtv1TqCW+N/8OTyueNNLuKURg+DfkExMbdvW3l7d5nyOEmeUy4lAevs4/vIDe+9pz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=rXKRCd8S; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="rXKRCd8S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvIUIoHTDo/ThUaOH98FnOQpxrznfIA75yn0XzDnLO31RgNUD9NYrmZdwE0qRT3px4sAT3+9+cWQ6W5+5j+ET8aUc10JjmynCIYLWhhaB0xiRoZoIdCjXetAxge38R5Pf6bJdm+p5fjxIQzeNIMjBjkeDDeG9BPudrgpl1v7MN7MFH3Nnz9V0KKMbwKjOR5tp+M9E53gn92GKDXW+qCifjq0Ek6JdmCAmQqSJS4GqCxa8ex/yOrtNuEe5oKk5GG90QAb8A8jp6rx4k99gBlJ2+KqytpFdjBFAhYTSqOUtUyMplvQXKdVEm573/pNqBu+IPqV8yQvVvQ7lQtfQFRgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDXqc+g0SCVwRZ2fdK6jyir2rceNi65sm2gHKiXLk9k=;
 b=FCwtETTpl6p7bRXnqHHAIUBECI9eG/5b/u8FAMDfKvph1Egh9vvC5nwpRqJJ6K5luSS3L7gH9maCkEmRVgtwWlNM/8fggd0b5chHfKFM23253UQG/jEnzQgMiJmm/HcJKc8/8FqcPBjJxMXuoxqLz3hviDJTyGMH5XLzDOWJSC6ogbxTYwDjMHIcD1khixzX+ND8RztNujPsGQXcXXEm6X36onU+5E7nMEL37lm1o7OtqEK063pMMRANF7cEuD6Oq8kWJ5S9tf2ux74GXkUiLivY4TL/2+1q3WOiOQvBCOPz9xCTokkVzHimhdQhDn02pB6QBap1Clxe6CePvb5Xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDXqc+g0SCVwRZ2fdK6jyir2rceNi65sm2gHKiXLk9k=;
 b=rXKRCd8Sea2SkuWBD+Fz2TN0H4yAljeDegE3jtqigxcRmLJaT+JU2o/QG7Pw5j03C/Fp0QavRMhPzZU63WucDYPdSFnVvuqDU23E4vgQ8N+0WIs+E5fVU2nvt8WHfqedwJUZfHIciGfrbdP5u6lD2Zh3Xr+3wtfnSuDYrrkd1oU=
Received: from SJ2PR04MB8896.namprd04.prod.outlook.com (2603:10b6:a03:53e::6)
 by LVTPR04MB10079.namprd04.prod.outlook.com (2603:10b6:408:3c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:58:57 +0000
Received: from SJ2PR04MB8896.namprd04.prod.outlook.com
 ([fe80::8292:662a:4214:95e0]) by SJ2PR04MB8896.namprd04.prod.outlook.com
 ([fe80::8292:662a:4214:95e0%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:58:57 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Andi Shyti <andi.shyti@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Min Lin <linmin@eswincomputing.com>
CC: Yulin Lu <luyulin@eswincomputing.com>, Samuel Holland
	<samuel.holland@sifive.com>, Darshan Prajapati
	<darshan.prajapati@einfochips.com>, Pritesh Patel
	<pritesh.patel@einfochips.com>
Subject: RE: [PATCH v4 0/7] riscv: eswin: eic7700: Add support for clocks,
 resets, pinctrl, HSP bus, I2C and watchdog
Thread-Topic: [PATCH v4 0/7] riscv: eswin: eic7700: Add support for clocks,
 resets, pinctrl, HSP bus, I2C and watchdog
Thread-Index: AQHdK7qNBoWtU4ByRk6d3IDensMwHLa4SfKQ
Date: Mon, 31 Aug 2026 13:58:56 +0000
Message-ID:
 <SJ2PR04MB8896B638DC786A44968C15EE83A92@SJ2PR04MB8896.namprd04.prod.outlook.com>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
In-Reply-To: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=ba980a84-2fa7-45f1-97c2-b7446c52f6e6;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2026-08-31T13:57:47Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8896:EE_|LVTPR04MB10079:EE_
x-ms-office365-filtering-correlation-id: 8acd9d95-bda5-49ef-3c02-08df07680021
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|4133799003|11063799006|56012099006|55112099003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 6ld8q6p1Ec0F/TqvJJgXqxcMWvpHdKDs+96i0BC6pHf9OCtmxssWedkzFOyGheTe9Vdf59dbK//gjopGx/2R2oDM2bNeW8EfQJVRYFWJEFq9aLwBbWKcZBOMQmZ8fELXHVAVL1un97PUQFm7Dt6uT3ltvQqzoA+0WP9+16MFu+j7vvX0S7CBlxFyioymh8/o1H5p78HrJEmGQEgmxzp0ccjb2jeQ1K5s+ir14Pp5dFuVmAmT3tnL8zLkeuV3d7Tyv4eRCvc60AAFEAOCjNEbP90NpQsS/BPz4sImfkS+fDMEWhcLYxOtBn7SacalwWW76nnu/Y0F1ZZIibG0TOCAbETlV9fChkBjhOGqjl9OnQPTvFlK8FR/hxro++rNVGh1IauB/bcEWd6n4yP5Ajxj3O1I9919zJnnF2CYFAbZmUq2+R6bekA3cG1dFAdK3pnR1KMi4AeTqC0MlnCwn/xQxwojXcShlM8P3JtzsDKkkC7vBfP2ysofrbWS31bLxWlHj4F3/jF5A2zLYw2VB4OmphvTqxf1b+zRqs3tM4N8kt987SCistKvY/UhvzB5Wz5jjyQfzl7HN0QKjnkgHQzzJCffIvI7CKK2P/QzxQk24eqG4mAhjqAHrqmh9ZXBmBpb1Dtqo6UBRg9pBsmMrdzTHXxqe4b+UZIWurF3s9Jm6Pdkvn8ZfgQHQO4iBbH9/PAb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8896.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(4133799003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8D0CMtHjoQSjV3tl1AV7ItWcMuKMXF9O6DuYBt5Lg1xvQFXckeOMYoxWeszV?=
 =?us-ascii?Q?X24ZcQiQ+4jU6x1PQ2GRmuu8MU1W8HjHOAlAklEaR9pN8HU2dU0DAgpSFQeZ?=
 =?us-ascii?Q?FximQD+6zqARpqtwmBBTaZIsUj26uEAVDMNOYaG5KeOmbUGXRt4y0Vanq6DD?=
 =?us-ascii?Q?JLaI6xxeuMV+6cj+IWlo0OrOdmWOukqPBEvYuNFFubELZ8CPW5SBH2Zj843Q?=
 =?us-ascii?Q?iWvPv9zv9ADnkLWl1Y9BUWetHmVr1z4Y0IeqeKBEvJE2cAl2jqDe7SASem3z?=
 =?us-ascii?Q?qdqVbBNUqkQN/vc6T4tlPyINk2wUv8aLVayUwd2CiQMWyr0/YmzUbTzV3uGW?=
 =?us-ascii?Q?BNvfn2BBWvpGZu2faJyIYnJ2yR0POvQq6WnQ+56ltkpDd4WjdOkFsllcVqH1?=
 =?us-ascii?Q?AhmDpP60EhVgz7qHJ3tAP0cEErF/YQn3Nv753eIa/W+sR5wfRBEUMrE6vurp?=
 =?us-ascii?Q?5+wtuXDVIzppF1SlCKy4H+3HzTAl/quUiFtUg0v3Ugm++Z5C6fDCDk07X2Ci?=
 =?us-ascii?Q?FJMbom0gKrDg3CbghXYzNmh0JqqtPG1yBcyILX+uoyJq17rE9vEM7GJl4kfj?=
 =?us-ascii?Q?s8K8l1aTIhr+NCHa8sV0VczwUShuq4VHJ2QEVVMY7pr5G/A2RMyKy1ay10n1?=
 =?us-ascii?Q?3v+1JFTD6tDAJeiLPhIa8a0pqLTK46d3zoKIkYJ7quXxTiGnB3r7hegklyn/?=
 =?us-ascii?Q?WUnzWpVweU0Xnyeib7V3z7HZCy5LwPfLdkIHmWPLkQGLjljp8DVdOBF6607h?=
 =?us-ascii?Q?mSAzcjM2jCa7F9voTT6MK4WEGdWD8DIBIv5gEAa5hKkcMtVhCzJ6C+5/2OG6?=
 =?us-ascii?Q?rG2dJe1BY2guE+y0Z7bObzTm1pw1+pu7AoS1oQ/hEhRwAVxogw4n72EHilUE?=
 =?us-ascii?Q?w9wEvwkuYzl7GIAft0aGQAIItcn4UpbiszgihUnOJzXLNXHlDxcqjmw4Twvw?=
 =?us-ascii?Q?j82/n/2NWoadw9q3Y84miV94tXD33rP/YGZgDB8cQIuYG22tlRrZbgAPGdbW?=
 =?us-ascii?Q?Q+HF+JAJz3L5eJaqhZX80f6iROn7BtsMB2xuCTYShTQbGx42/D76VEfeq6Ys?=
 =?us-ascii?Q?fvcCYYSMOM9YiFzLd3Q6KQRnzj3ngAVjDkasYeTpxNHD0wkzkagDJQcW1tje?=
 =?us-ascii?Q?HsNBPtJYWKt4YV/ND79Ja17myK1SOwBntRtJOfXJRMMvUt6Ycvpqg7vQu7Vm?=
 =?us-ascii?Q?Lp+b8/NDHAV8wfjT0TNQiEjHAa5E+8JOxt6n6ucEuGhecgDJANMSqulc14lK?=
 =?us-ascii?Q?PmgLSwvTThISq+ZgzoDQeelvU3QYYhHB+GsdEGJ0+K6pZH1Q7+c01rN2/H04?=
 =?us-ascii?Q?D2pb7rw1a5wZXdBOpeq7134a0sB/s2qoSfkU6Fx08qcDtDNk/IyX0JfRzGNt?=
 =?us-ascii?Q?p+RHjpIo5Z+gp1eq4Az/KtrZyIQgYeixIFPv1rAWl/ccvJTXcV7s3Em9f1UZ?=
 =?us-ascii?Q?C9+GrxWYQWTiiCZNH9BwqAlUYQggC72K/Spb+EB3AmlYgJHGCQzqoNuOGSIY?=
 =?us-ascii?Q?neyoSV8UPva3ranEmkiPXB2qA/eRbkgVx+CzMJr9xRjEUFJHFo+1Dbuf6hau?=
 =?us-ascii?Q?0pTbbemQ9qnReEBLjexFYNd8X6SNo+2+TXCv8c3rulpFSiweAhUE0tM+0ttc?=
 =?us-ascii?Q?DaTIfoAhZUInsIdS8F3H0+R+6tym6Xi3LaZ36XDQ8WqZTFs48pNq5vvTIw7z?=
 =?us-ascii?Q?JMIFKSXmluVGuwsraPUt0XPIdVt7hdU+AHYoBFKfmemCjs7si6adlmrtXxoe?=
 =?us-ascii?Q?N4IgJ2LCtQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8896.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acd9d95-bda5-49ef-3c02-08df07680021
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 13:58:56.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtZYbAxLb47pwAS+4HrY7WHmf6DDVcUtRPLZ/h1IqKguG3iyrUiSqlvPd2m9EiDt+/hZ8YzhldfmctQRsmSQqAkr3f8XJHDepRbG9JjjIT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVTPR04MB10079

Hi All,

Any feedback or comments on this series? We have not received any comments =
except sashiko-bot which were already answered in the previous versions.

Regards,
Pinkesh

> Changes in v4:
> - Rebased the patches to master branch of linux-next tree having
>   latest tag: next-20260813.
> - Updated dts file
>   - Corrected the pinctrl-0 property for i2c nodes.
> - Drop "dt-bindings: mfd: syscon" Patch as it is already applied [1].
>   This was Patch #4 in v3
> - Link to v3:
> https://lore.k/
> ernel.org%2Fall%2F20260804104431.1391839-1-
> pinkesh.vaghela%40einfochips.com%2F&data=3D05%7C02%7Cpinkesh.vaghela%
> 40einfochips.com%7Ca84b0d242f5f42c81bbf08def9d1ae51%7C0beb0c359cb
> b4feb99e5589e415c7944%7C1%7C0%7C639222876135501096%7CUnknown
> %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAi
> OiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D
> bhJRleScPAhVe6XgHZLLf00ilZRk%2FGPMeeiZz0y4vmY%3D&reserved=3D0
>
> [1]
> https://git.ker/
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-
> next.git%2Fcommit%2FDocumentation%2Fdevicetree%2Fbindings%2Fmfd%2F
> syscon.yaml%3Fh%3Dnext-
> 20260813%26id%3Dd86dadc6feeaa86b6a29db5509bfe8c65b66c7b2&data=3D05
> %7C02%7Cpinkesh.vaghela%40einfochips.com%7Ca84b0d242f5f42c81bbf08d
> ef9d1ae51%7C0beb0c359cbb4feb99e5589e415c7944%7C1%7C0%7C6392228
> 76135530303%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUs
> IlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D
> %7C0%7C%7C%7C&sdata=3DxBhh2yXJ8ubJuN5h3LrF%2FB5Mq94pFEtTAIgZ7kVG
> pfE%3D&reserved=3D0
>
> Pinkesh Vaghela (1):
>   riscv: dts: eswin: add hsp bus node
>
> Pritesh Patel (5):
>   riscv: dts: eswin: add reset generator for EIC7700 SoC
>   riscv: dts: eswin: add clock generator for EIC7700 SoC
>   dt-bindings: i2c: dw: add ESWIN EIC7700 SoC I2C controller
>   riscv: dts: eswin: add I2C controller support
>   riscv: dts: eswin: add watchdog support
>
> Yulin Lu (1):
>   riscv: dts: eswin: eic7700: add pinctrl support
>
>  .../bindings/i2c/snps,designware-i2c.yaml     |   1 +
>  .../dts/eswin/eic7700-hifive-premier-p550.dts | 196 ++++
> .../riscv/boot/dts/eswin/eic7700-pinctrl.dtsi | 888 ++++++++++++++++++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 234 +++++
>  4 files changed, 1319 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi
>
> --
> 2.34.1

