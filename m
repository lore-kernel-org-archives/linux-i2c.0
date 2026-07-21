Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2E7E792
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611076; cv=fail; b=kl5WuSY+6KfD9AZwphiHPC/uhDg3fvBOUO/zMS1EB8hEvWluo0RJLoFLesHF6qI05RNeP9BBBJ/4hnAICm666ea3nd51RhXb8A76zaYZ7YA9ZVCENpIA2uxOlA0+Kqu/EZp89wUXA3XIkHT6E0xBwM8Lu2RT6Z6NtYQiIVKqDKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611076; c=relaxed/simple;
	bh=PzhpAQCrKSipPGzQyWhIgAgFdw3O47QUeL3OYtSiPCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OFfc6QmLJZDePHnlbttdkQm0KtRSIl0jkxVChKDFORr0H4KUqccvsv6EG6jh2zMmPVBPB3yNAgCN/zo2U0JwEwWhJd1p+h6jlm0DKUiKSGnKKcnzbxVwf5CwZg8/xagYk4ZGyXsO0MH5rhwyDTIOyT9SsA8AcqxI6B9Sw46w0Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iTxGwBvD; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iTxGwBvD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPatXHjQq3ZsB5k5QS+QVmwJVhczgc75Qs9YjVgLZp3wFJPHZKvlpZAGI93xkbvXdpAf41Q/lMOOMbvJZGQRqIPfKIqSLDzS8gHwzdTyq744uB6TDnq2zoRfGZ/5elC4jscyreFdGgPfj7xH3we+Y6zYu2ut9TS7qWGuoLcy3fhUPXJSKZ+VERbJm2uWQJx/bd8P1uUkpZ6FQmBuYmmPFIQGJCcOHBxgYR+4FSHhobxbTe4dH9S//RLaLIDENOf233SzYQXe8g+JeM6IfrBaBaRmY2CKYrDFPOuDfTb+SymaIC2pTY814w++OD0JtHVQHUOud6I00u8RCVIS6ykJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+YdhGghZV5sVXSWDCHdmHi3Wm3OsvdT4QwAOuVZzJg=;
 b=hMqiNVfdC64zMqlBJ4GnRK+oiQI09XPP1pzIIDxRpbyXkAILlliAtOZe976leFqN6YqixVqX25sZmCQpSp2FsPaOBEdhlY7B9j1uvNjB1kk1QDVU4sTw/S0pjW2waJKMU25zqGN554pm5IjR4AdyvdoMMWUj+ECD+tXUCWgC7DtrO2U0vL2Kul1Fqzbun3RJb6Goq46tC1HwFewH/QzL4dmN7NBwk1D5EcuSBHh4u0vJ5/8jKXP65z4jSfhDHIe/nLv8UQVEK9uaTaNJRfsIQ4ZlDPV/1ad1fHh1Cp6i3yXt3UKZqbofjXAvr444NPvbrdrj7UBwbc8XFgPDF7qxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+YdhGghZV5sVXSWDCHdmHi3Wm3OsvdT4QwAOuVZzJg=;
 b=iTxGwBvDJv1QBQRNegf4yoKDn8r1VzsG5ojQc+5jsis77Au7d9nu6yKALFG2cvcVN4rdLD3Wv9+mNOTvBDXYubjjnY1Wm4DjSeLQxDaIbIDr35NAhZ6C6/VMS6cGLxuE9gHrLO9in3sO73x6HqjnEHVYnEhkEuuMzgvH6f2n7fE=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Tue, 21 Jul
 2026 05:17:48 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::9109:fa1f:23b:a10e]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::9109:fa1f:23b:a10e%4]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 05:17:47 +0000
From: "Tandra, Vasantha Likitha" <VasanthaLikitha.Tandra@amd.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "git
 (AMD-Xilinx)" <git@amd.com>, "jdelvare@suse.de" <jdelvare@suse.de>, "Datta,
 Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Subject: RE: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
Thread-Topic: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using
 I2C_TIMEOUT ioctl
Thread-Index: AQHdGGWzFoL8QftHNkqSgU9s8nk2GLZ2+F+AgAB2jmA=
Date: Tue, 21 Jul 2026 05:17:47 +0000
Message-ID:
 <DM4PR12MB77657106776BE150FDCCF7C093C22@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20260720163401.2001860-1-vasanthalikitha.tandra@amd.com>
 <al6c2VXwLFcNRLu7@shikoro>
In-Reply-To: <al6c2VXwLFcNRLu7@shikoro>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-21T05:14:52.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|LV3PR12MB9402:EE_
x-ms-office365-filtering-correlation-id: 4fd4123c-e6d8-4de1-409c-08dee6e7672e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|11063799006|4143699003|3023799007|6133799003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info:
 P3xA6Zhjfw1sC2bUkvvPT+cmceO1Mt0EXiJ1lv2CYqGWd8uyolo15wri1CJuPLv0cxQQgjQ5kmiF3haJZqnhNMNmx+oJ65q+M4mOejV4dXzaMKsO35cH7RkEUwHZDep203fzcBRplMR/hJzGkyiDw6iXc674ayxmJ86BqC+WqoEQbhBnKMenK4zU+FceHiL0+NzpFwIsz6AdnaabBrMJ7A+bl079Bw+6/AzaHOp4gmGCA1rBtVhpFYRh6IdLbbxjgHoo0ArhuP3fllv6x/CFgV3ProxFLa336VmwpXq+lf/POsAnGpaqPGM+rKx41BR95x2DkcH8VN+TyLmufLujyewjiFRHQxF779qED8HPUsy66ogZW9A5dA57IXZfRbdoOzX20M+j4FgCMqyiDLFV5WrYNwz8G9QAjpuia4YNmuSBGjlyRW0HETjT0BjfWXuj47ZN04tHPL/bnbHV5Qg6GHISxMWRqbWtb/Woncl18VPeU6x4De4gYJUR49h7vrPGfZKtJK8RHItviDwrPs8+GghrVouQs9iRU19rtXTF3vIgWASQ2d/Jbp+ul36MZG1R4giVeUa7r29NNBztvsrRv1II6S35EBOSQ8oxZFXW4Qz44T8P3R40CwPIChzSDYT0cPVrq7mthnfVE7bKOQAuKbEn6EPz9YQxnDhhLJd40ncSNh87DCZyh00EyPCmYD+j7dtxlrhO5+mkmDaM8XUvtv0RvIpiQq+MOjLAlxssYYw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(3023799007)(6133799003)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JEdm9PY4y29UvVTLuozn63Ik786idBREHEONbmUllsT4Wfk4rS4B8p9eYrHh?=
 =?us-ascii?Q?Gu21yy3NgP1AfLRWR6jUVauAXpNuxKcz7s8welMQ6wErOGAve7pNfbl5V20X?=
 =?us-ascii?Q?UvvvjqALPvsL6TvknaDB0Tjp+1RsbQ7QvvtDszKXw1tirry5ogGweUjNT+Tt?=
 =?us-ascii?Q?s1C+DstVrhaXzrxJYJ1qsfiHNSDmXI2WG5ZDj7L1bwP8BMRBmf6IyL3PjrGs?=
 =?us-ascii?Q?YzUzAHV/WEZx1HDT8fRu6WylwITABNEPrCeHKmuumF/76mmMOQ7Y22LhbXKL?=
 =?us-ascii?Q?kuLpxjzMWtVTvlxMxl19CCSgHg7Jb9yf537RPN5wd3sfpdZSRTROjMALVupq?=
 =?us-ascii?Q?szrH4HPXPh8hWJsRcBC8OIlH8KO8cXfnMxPrjMUQqoAC5zm2/myTxjqAlSG7?=
 =?us-ascii?Q?kdXvn/+pqrsBBHPfMQnlXlHU5HPay2Z8E1YJmuSUMtilagIl1NQiSefa+mK7?=
 =?us-ascii?Q?IePb3pIrJwdoRiKod6cZzW1VKRdzWkklRratKZ5e9aD9sv6wh0i0m77Crfly?=
 =?us-ascii?Q?YoupgaUObe1DPhFEtldP/d1E0rUe+XdYW178xNb8bxmQ22r95sF2xFfJEzB5?=
 =?us-ascii?Q?4HE48rD+KSnMR2QjKedfK3+50fqn9stU8mAr9/LwD7Q6ocQEKoe4fRQWoJjI?=
 =?us-ascii?Q?9FITdg1Hsnt9V1e0O0XtlRUdtFToT1U/WceixOmlnGe4Xu1QjiOHtmn7BJvq?=
 =?us-ascii?Q?pAsJrTSPmlUAKjHAEE+FdkYuow5amaar39Ig7YPlORGjOPP5NOXe720ElVi4?=
 =?us-ascii?Q?uq175bXnh+t6QBskijPzFCIzq6t452BKi56UkrZu2aXRJ4tHi8x5VdK2V/4t?=
 =?us-ascii?Q?Jw/0+2ZxFy39kEXyGuwb/ISz85HkWWP/1PZlXQE1X++HmPvgqjDSCfBmopZD?=
 =?us-ascii?Q?UW6AShf+SmLoMHlRTo0T1L6tfGG29qVUf0UJJ18wo/9ePq2dOClCu/glfCZ6?=
 =?us-ascii?Q?4SVm6p4lYnx6NOr0VfbefCfICpRiu+G3llMi4QKJDT1L8RAuBh6skzMEpZru?=
 =?us-ascii?Q?0pvTS9F4DUCXgvFc6hYseHKGknoEWRbzff1GR4T6ZzQZKcxJ8326IOou3FsZ?=
 =?us-ascii?Q?Wf+jDEbFeRecvJGdecf/75Ksjhag0ATysp/yGfKcFxFZP9/qXRDtsIzpmH3a?=
 =?us-ascii?Q?/ww0d3w6xROr2fQcoTleg5ysp3+ygkg9r+s0WSafHZbp/bPi8LWT3hES1k2i?=
 =?us-ascii?Q?LeiEEpNrNCek2Mk2pJ1MDSB0jD4KyU/PSeOoWxIYlCj2A9vK7J23J3Br7gKa?=
 =?us-ascii?Q?w2yAy2ETeKzRwzctbomH3wuqydN0BD+KgvVY2pXzt9BII+Mo1jAK+xjUd/57?=
 =?us-ascii?Q?5wBvMygr/Q1aEBKB7s2ay2jBccwezUAxnt7OS5vYa8Az3nx/ijn5ltzhyZrm?=
 =?us-ascii?Q?QeDQl8A/mKTk2GXyPSQe245wnNkakD4eO3cNivgqiXF68nRdMil2CvJEOVRU?=
 =?us-ascii?Q?Z8Xv9YzeFz4A9ifSKmV1UU6BzqO1X1DS+P0FdwBz3FDU5WNL29r8p8vBGezD?=
 =?us-ascii?Q?mTxQASkh24wR/WpprxhES0AiL93v7d3S1lJbOwc6zfBOkRCRad4eYgw7SY9i?=
 =?us-ascii?Q?oDdtFmbl5wpzn3vtjcq/Xw2QvUX3OKx9/wYGTAisTYYH41b10Wq/TV3+AkOA?=
 =?us-ascii?Q?Pra7emcdLxstizVofLsXpZcuXnn9k8sCHUR6eRhKPjRjTPMUgr1lJ0+CP5T8?=
 =?us-ascii?Q?RnPsDamff7DgC3J4Gl2OKBLECz7/1lbpkl2fLGsJUZ8OuxDE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd4123c-e6d8-4de1-409c-08dee6e7672e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 05:17:47.5604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IwyVsC9rATbCJhmvy24Du96S2WMPQyPAgGhlzvl22/ss68j6XPl7jRjO/Ys0vEA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402

AMD General

Hi Wolfram,

  Thanks for the review. Your suggestion makes sense to me - I'll move it o=
ut of i2ctransfer and add -T (timeout) and -R (retries) to i2cdetect instea=
d. I agree a separate i2cconfig tool is
  not needed.

  While checking the list of ioctls, I observed the I2C_TIMEOUT ioctl to se=
t the timeout, but I did not observe any "get" ioctl to read the timeout va=
lue back from user space (same for
  retries). So setting a value with -T/-R works, but reading the current va=
lue (when no value is given) does not seem possible right now.

  Could you let me know how you would like me to handle this - should I kee=
p -T/-R as set-only for now?

  Thanks,
  Vasantha Likitha

-----Original Message-----
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Sent: Tuesday, July 21, 2026 3:41 AM
To: Tandra, Vasantha Likitha <VasanthaLikitha.Tandra@amd.com>
Cc: linux-i2c@vger.kernel.org; jdelvare@suse.de; git (AMD-Xilinx) <git@amd.=
com>
Subject: Re: [PATCH] i2c-tools: i2ctransfer: Set I2C adapter timeout using =
I2C_TIMEOUT ioctl

Hi,

thank you for this patch!

On Mon, Jul 20, 2026 at 10:04:01PM +0530, Vasantha Likitha T wrote:
> Add a -t TIMEOUT option that calls ioctl(I2C_TIMEOUT) before the
> I2C_RDWR transfer. This allows the adapter timeout to be set from user
> space at runtime, controlling how long the I2C core waits for a
> transfer to complete before returning an error. Drivers that rely on
> the adapter timeout will use the value set by this ioctl.
>
> The timeout value is specified in units of 10 ms, as this is the unit
> the Linux kernel expects for the I2C_TIMEOUT ioctl: i2c-dev converts
> it with adapter->timeout =3D msecs_to_jiffies(arg * 10). Omitting -t
> leaves the driver default unchanged.

I agree that reading/setting TIMEOUT is missing in i2c-tools (same with
RETRIES) and it would be nice to have.

I don't think 'i2ctransfer' is the right place for it, though. One might al=
so want a different timeout with 'i2cget' or so.

My suggestion is to add it to 'i2cdetect'. It already has '-F' to list the =
features of an adapter. We could add '-T' to read the timeout value and '-R=
' to read the retries value. If '-T' or '-R' parameters also contain a valu=
e, then this value will be written to the adapter.

Was this undestandable? Do you agree?

Another option would be to write a dedicated tool ('i2cconfig'?) for handli=
ng extra parameters, but it feels a bit bloated IMHO.

Opinions?

All the best,

   Wolfram

