Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F18330D2A;
	Mon, 20 Jul 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554096; cv=fail; b=qIOHuWm39UeuYoB4b505gJHNZKxNuI/BSrNnj5xqSgdEN86A9ePecRvbHITPl+K6fOhYLJJLmHWDqLg9yaaQZWBrtAFa2njf/Du2Lv2m0ZE0C9kp5NFZfZtxP4eHtWN9j+XBIGKqCYs7q5H8PWak1QUmEsqnrA9dSnzoeMdSdeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554096; c=relaxed/simple;
	bh=lWofoHRfWRVrEk5Qhiex4gnlGSGxiMkqqVWPjb2bmcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4cFiPeilOERRFefZB8OBx0jTj09Az1WeGbZycNLuIOQsN9w1bPZxm2PhXfT38SlLO9x/eD7aaGrSmGQQK30jzQOCyburOgOcm/yd6tJLPnx4imwO9/RM63t6lVZORzwEBzM0crZGCqd7v/6ZRg0Pn8T8liLzNtVuw7zvpBUk94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=Il3UBd63; arc=fail smtp.client-ip=40.93.196.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="Il3UBd63"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZuEKBxYRsDDSYBwBqL70YRq8YU47mQodGDYUubOmGxvt7qiPkdlBY0p+l6Vsgg2wUJd9L7ZpwxQq5bhOQGGftYwNQNul5Rw8eRHscR0afvOAIwdIU7K1Jj0+/Sjr5fh6b8Q7kGpGfW3p1D/HENvfHNsaX3l529mVqNeToMd/BjC9uVwRzPryE31kzHh92WOSD8upSyiE0a1rM4MR2vN7eo5tXp1xLJuwl/rfDZ6ErsgNlrbnj7hmxufwPJF/oV2SNvXpOnOxCLi9ANfoqFgvoXxSHjjUAdps+XTJ5fQEg3UfbLBFHKg7kw6rVAuLVm6ek028LIyEplmaFWH3j1WVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYElRPlwNmvVuX+ejLivtj532TKVmSuviZP6x3j0kSI=;
 b=s2gLvJPS+ak72xDuS+a8lOeVos+lJ+QTpPRKeZhxEUilsXiMRkhDgpYRjADwmUjfku/z7Wfph8Cr+iPEXEJLXFjRnDUQwXYLcLwb6k0duKTShM/dSvsxHJDpRf+Xk09Bj8ymTc+VW2DW0scc1M/7k5tt2Vj0GxNqzdRvh0sp9jCMjdh4zbOr9qhIdc/rJO6oFG9bMghkjom6hBvvZCpbqyv9qpe7VIX8lLYdSIb7KV3+LvoX3rItn91ndSDVf2eq6HVExQS3esY+9y9DQbgfKxP2qPBySGwA515vDTqMI7G0ptRvWKnSrGZX8VVkdUYWh56oe8EEpwRXA6NprPAy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=einfochips.com; dmarc=pass action=none
 header.from=einfochips.com; dkim=pass header.d=einfochips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=einfochips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYElRPlwNmvVuX+ejLivtj532TKVmSuviZP6x3j0kSI=;
 b=Il3UBd63cbPyxAR4Y7gHEN/HOAGvFyDcLeT2y7IWlZWPEdC96wL3F2ynH0itDPv//LXPHBYh/QVn8dIqtwjt8Qab0NQQKATddIIkHroLmmgj88QQ6n9lULVTGxAv+nNkmbVujKTfMgSU1pWhmqGJL1rkzfb8DcffzF5x+yiWkw0=
Received: from SJ2PR04MB8896.namprd04.prod.outlook.com (2603:10b6:a03:53e::6)
 by CH2PR04MB6506.namprd04.prod.outlook.com (2603:10b6:610:61::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:28:11 +0000
Received: from SJ2PR04MB8896.namprd04.prod.outlook.com
 ([fe80::8292:662a:4214:95e0]) by SJ2PR04MB8896.namprd04.prod.outlook.com
 ([fe80::8292:662a:4214:95e0%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 13:28:11 +0000
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Lee Jones <lee@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Andi Shyti <andi.shyti@kernel.org>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Min Lin <linmin@eswincomputing.com>, Yulin
 Lu <luyulin@eswincomputing.com>, Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>, Pritesh Patel
	<pritesh.patel@einfochips.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: mfd: syscon: add ESWIN EIC7700
 compatible
Thread-Topic: [PATCH v2 4/8] dt-bindings: mfd: syscon: add ESWIN EIC7700
 compatible
Thread-Index: AQHdGEucUM6ccmpEpE+P/hMuVAhZgA==
Date: Mon, 20 Jul 2026 13:28:11 +0000
Message-ID:
 <SJ2PR04MB88965A802336D3FB947B736083C32@SJ2PR04MB8896.namprd04.prod.outlook.com>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
 <20260706081055.1126275-5-pinkesh.vaghela@einfochips.com>
 <20260716122833.GE1260374@google.com>
In-Reply-To: <20260716122833.GE1260374@google.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ActionId=74f847c5-3f1f-4fec-9757-4300a57ab007;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=0;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=true;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=879e395e-e3b5-421f-8616-70a10f9451af;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2026-07-20T13:13:41Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=einfochips.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8896:EE_|CH2PR04MB6506:EE_
x-ms-office365-filtering-correlation-id: 04e2e99e-6401-4261-e7ed-08dee662bee6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|3023799007|10067099003|4143699003|11063799006|56012099006|55112099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 xB17eYTF1N8PMi/8anLbd+EXEkbAXTeBzAjr0Gr6qGsxDwAhOJ6hibBbWNtXLupKJZVVncROSFh8F1lrvGHgyHZ/137/h09XvHPXvmfTxkYLEdDmvqKBG8rIAesdBWz77C+/8cJwE0O4M25hninMl5P0gL+d0MkIk6/Guat0Tuwi5IUIcq5CQ1rwCaN8lOgvpEnQSZ3hTp18MqftfbiW2BHgM/ZNfu/kpOGbBOkbSzsZhuP+aPaJZbLMO59/1eskoHgvVJdQtraZjlkCX/vKm64yce+vla/kWhH+igUCDz5w3EMxGa8xZx8I/ugX8qxcL5bu5sKd3KKtLAfpXCSn0JZjgJua25NyUYVayNS2FwLWJlKJS+ihK0ciM8pEaos/U/HkFZMlVPrYhG1yJZr2rUaCSU4ReSAl4nSfBBHWBgli9S76RkK3B11SMcoB9MTzkCK1NJiKj0B75QBFcOaJjD24GQf9bkqX6+vn5E5kDLUxkMLeZcMq4gmnOc+0SsAY6jcS7o5T+5stCEMeVyhhHMOB4UhvC10h2RYwa9VpNDAUaFw86rCVJShfofJoyJrBYgDGhVtOWVbi4xZzI2nK7burNsaTq4aIDZCMmZVznl2pbfQVUXRZzu9c/HhbJ1q0ElcojK6RgofDq0hFl3JqleIu8kC6hSvYqz/tCojjxCC7nHR9BD7nsHNqhKtcIOjbUwaPu6ohe1ovZS+uJ2HiTw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8896.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1E4ZY1QI1wt9AzuQqKIINTX/i3qexkoMn9uBQptD8rQqAL7AevQYEZFX1hrZ?=
 =?us-ascii?Q?kK8BzFZ+5w1neLRX0vwQsPPtZ/q2WAwFuvP0zFYuc1gqLeuz0I+wyrEtDjgh?=
 =?us-ascii?Q?nxKfX0JDGesqBtNY9ynDNstBMkiGOZJyTidZrmP9OiWoJX28o1W2uUKhKcvI?=
 =?us-ascii?Q?yf9cLQKXv7oVnI2xlVT0m7/6NRreuoLBis6j6odZf8bPALCGZ1aH1dEUAsmq?=
 =?us-ascii?Q?pe1RiZrVfu8H7zKVTwTsn5w2zkHdcNlL5EM7ORQs4ObKsOwcAcfTE75HixFc?=
 =?us-ascii?Q?JAPrR/5X2fByBh2rG1uUCATea1cjxjTY2vNmlXWBHxUeYIzPpo/sawk+jY2c?=
 =?us-ascii?Q?vrWf+GeNQ8+DPfTIEMbAuIZCLL2YlMDiLZKUdhqgcu37/KcGakrNBtVgT8rP?=
 =?us-ascii?Q?BA+OOzq0px+Q/StZwLiZMuMEeeg5hcrONaXOCnwwNl5bllGMIYkDDSYbshrb?=
 =?us-ascii?Q?SCwqZyspiizPfnvS73pmtqDKIxwqJbrs4bMCbTZvGPQBiHFNwn9TKuH0QOrD?=
 =?us-ascii?Q?h3QMgdhmhIR/1ovbOJ4s3k03pDjGKufBdXZJ5+1SUin35rejoT7RxUxTtgec?=
 =?us-ascii?Q?qRNJm0vGfyPOKP886o4JXjHuynG34fsb2ly3fw/kwAS9f2IbDARUMwSDPjz6?=
 =?us-ascii?Q?IaovBvGEK7Jaddio2gO/+c0lj9z49tIbshot5UNjr0DGFDjx95OwBTweeEmo?=
 =?us-ascii?Q?+tdBUnr4H74ehAa1kDgjPfvEDMo+8+tqXhJd4H3c9WSjCMpPDVjBZ1/DlNm8?=
 =?us-ascii?Q?Rw52XqHWooyPkbyPHxveY/xaxEhkXlrjs2/8yQ1MPYBQglHnmxj/byikNAD0?=
 =?us-ascii?Q?NYp3BInDERFgU7J03ae48Ma2Odubsg+lnLDj1i7fYcnRKhwyBy+lkFXMVORU?=
 =?us-ascii?Q?MZT6zdEZrTnEu3QC1gR8g4yNZqBx8DmtBO9yKQn7aDgw353+q/0QjdbbenBH?=
 =?us-ascii?Q?nc6Kn0njIYKHkPNVUDhioR1hsAP2LCZBrNi6mKo4mElV6CqE7gN/0rj8cDHY?=
 =?us-ascii?Q?wzGVPptIUdg06dDzEueyxunuvngreWy4QDF32uib0HcypPSTq+6cw8sASN8R?=
 =?us-ascii?Q?RHlt8B8vS+uzQzmtCujfAAuhmzoqbJMDeM5jV+7ku90IisyghMce4zMsM0ZY?=
 =?us-ascii?Q?VBJozacpf11AAWejoDznlUmdId90GNnmU3AiSAjY3oEyHhJWfy6Rwy7445dw?=
 =?us-ascii?Q?uBBAI7cfrH46UHYxq2TEUSkea5kMTncFQgV74TdPPPrkNsDme1sqrYL4LMHY?=
 =?us-ascii?Q?//tZNBL2ekQ6YQH5qadDraQkf0GOXS7XfxjThZ3OOtb6VFbt1nP6VGNnW8Fz?=
 =?us-ascii?Q?0qj/qt7NgLzRJHmtdJXa9aiMrV8XlAssqp0vGyfVcHeHWomhn0YwQ6+zLs9G?=
 =?us-ascii?Q?RCD+WUnmRXu8n+7emGR1dwGbFW87/WBhZVJIQ6QQDjpKEmJoa3kyr9IGw1nC?=
 =?us-ascii?Q?JoXpKWkovxYDsgTgoEpGOXctXDbJHBo5kE4Y8Fbh0Paqtj2GAqvgFsqlxlZM?=
 =?us-ascii?Q?cAiYIK5OlpprLs559OXmcOFHelO/W/Jv/rGPzDpr4aHEB8UEvV8iDPpMq2mx?=
 =?us-ascii?Q?gNsXPXTyxZdmgWqCzoz1cUNaFCxKLcLGTcH6OYT3d4ZOssUlzUitamR35Zwd?=
 =?us-ascii?Q?E5YcxHd7GnA5U/Zt8pKQSjP2vgkzRmsuKoEI6tEj+cBgJ2ryab9CtI1UCtrr?=
 =?us-ascii?Q?f18ptfnqBfTYjWMHWtnpvmn+pfgDyJFrcPyzSLV30g2n6SBUhWoJUJM8CcYs?=
 =?us-ascii?Q?anw0W9Eopw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e2e99e-6401-4261-e7ed-08dee662bee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:28:11.6778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iircrOBG3alUMx6LJ4BG79D07oy2037YesB3UomNJllJG2qIL0QKR94dRQgI8k4t40YbCiUUQHgy6Ol8EdJyi1Nyl72R3r3doUpXmcdnvYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6506

Hi Lee,

On Thursday, July 16, 2026 5:59 PM, Lee Jones wrote:
> On Mon, 06 Jul 2026, Pinkesh Vaghela wrote:
>=20
> > Document ESWIN EIC7700 SoC compatible for syscon registers.
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Still doesn't apply.  What tree did you rebase on?
>=20
> Whatever you rebase on needs to have the following commit:
>=20
>    1d02f2a79ebe ("dt-bindings: mfd: syscon: Drop custom select for older
> dtschema")

We rebased the patches to v7.2-rc2 on master branch of mainline tree
before sending v2.
We see that the patch series you are referring to is not present in
v7.2-rc4 as well. However, they are present in linux-next.

Could you please suggest on which tree should I rebase and send this patch?

Regards,
Pinkesh

>=20
> --
> Lee Jones
