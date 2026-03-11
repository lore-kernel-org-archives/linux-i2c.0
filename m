Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0C3DD505
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243801; cv=fail; b=QbeIRqeHca+LYa8fh6Ovksk9LLo5fitMSijSE2qxEuYDVH4SmOaSmyaZCjJYPBPhREAl09xLYDi0likwjrzwKDraKMDoF13rWPbAb5BANmQH8/bKLy0hvQ5LSKEpZrPb31IbmINXoU+6bj6JqUqnRvKCQeAbehwfXRkkUFcz1k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243801; c=relaxed/simple;
	bh=JmQJxvtW5J7O2+5WK2cOLGc+S8ZQ9ylYZQqLULSBHAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5OB6w7fjqJg5K82iL5JJEdO3iI1VbcMEjsTrvHxECz0CrY80MFwahr7pfycFR/caoDFnXc9VI+DMp5E7RelizqYq/RJ0diJhW46tdSZ6nQ1WqPtuvMx2XxlTymqnzkJDvG1Ny+ZJOQuwsDvcFFVwM/VYxM6Ha+v8SdpKnBuD5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0avACVI; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0avACVI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPNJ3d6wXFZpuM7t57W2Z+g5pTCe1p4MyfBu422c6QiIx4k0pTphPP/WETp7EZAv2n1Q2QtBeQjj6Tk0I+hIxhWxTCPCYhRerU/N3+YPJ5URB49DZ6WD0zPywmBp4LctigFivW/KFR/iPf/BegPU9SJ2WrY4xcZOpuhPOnLQIWgu81pq9gsxgGWnFwV3ruOVJxVAjphy1nJbMZ3cQl1znGQSXrDgTs6f6b9/MbvlyvQryyudi/0/8WjHstku4vbdxwbBBCctdMrtQmH9Y1aH2vN/Mkten4iQGE9dUh0oVKA8DzKvlEAWirxEaI5IaieoNhaCWswpcSAsdRsl42mZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onxXG+Zr9BA7yXYUonk6QHXkJ5B3p8LwOUI7KCjGbbA=;
 b=FW8n5NMVj4HzUGWl2cJg6gRwzmnHgva3sEDjdQCpWsG9e58gyvn3+Lg31QGl0jAFoG6bRdYTLr5kktLOQhag536mC1JHwBtWT9V2o3AZq3a7ao340XRSlAhOYkr2wF3pJnbw7qcqUI7zXVrqksGlQ8Q1Xd6SIqk7tbNzX/jYDpNPAmLK+pFTNe3AZHVKFoRgoNoVL2CqlktQIBIQQ8GZ9FcBETptvZJ7r6Sq7Qp6yTdP2ePsxIwTL2L6nGW32t3WaJ4CNz7FgLFfeP2VAicp7NMpsw1rzKKFA39Wxew46ctoo5uhtuErDN33/Sv9MIfh8AfCUeYDPYkOulmM/v/H6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onxXG+Zr9BA7yXYUonk6QHXkJ5B3p8LwOUI7KCjGbbA=;
 b=H0avACVI1gkxftaFYd9Ljqfdw1Cvo3o9Dn02OiARSEhWzABThQEJkSJGHBj7SM/ws/al9XopFzx+KUrxCCuzxSHvEqZRbmwqI8IQUD8MmA4v6WCH4KENPz06pB5Ia67tXgFFMn89qIkSr4krYDQDmX238jcuQmb96A50YpR6zKDfYorQ0G3wY1NWvps6wRLUuvjGdItWYkFOwolAck7c2hfNUcnmoj+VVzJmI6++KS9y9/awNXcwz3OuCLAgwVFl5vqQOduvr5g4lOMYssO7Vrg3Y1RJheY5PQJu/OGSTeHPvnh/cD5sCotiUF9WnZ1cfX0J8HmP/0TjkK4yEq2h1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB11664.eurprd04.prod.outlook.com (2603:10a6:10:60c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 15:43:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Wed, 11 Mar 2026
 15:43:15 +0000
Date: Wed, 11 Mar 2026 11:43:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Scally <dan.scally@ideasonboard.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] i2c: imx: Don't recover bus when arbitration lost
Message-ID: <abGNjJnf40fqPz4s@lizhi-Precision-Tower-5810>
References: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
 <20260311-i2c-imx-fixes-v1-1-e625034d8202@ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-i2c-imx-fixes-v1-1-e625034d8202@ideasonboard.com>
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB11664:EE_
X-MS-Office365-Filtering-Correlation-Id: 21da9445-7a7a-4611-ce2b-08de7f84e8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	UVoooBt1TDvhdrr01gM2qUsoJT9rBfJTwxnqDjC5gBiiqiUX20FgJ9AhdqY65BMkqvOlzpWnS2FPaYxrXvnawFIH752hRTC1KoJ07AzTVmmd4pXiIY1wJoZGnkMXo3cs9Gg9GghYKB62c9QGCh3OLk/FYL/1BETRT/2Wow0rFCM4BfsQIJicY/1Ism02B/4jTMG4Joy1r3uukozcdsK79fFwlJddZ6J3GaLYse4xh3bb9XiBZ4xJVvSvTiGJyFe0W044cyK1ez/WASo2PY4LXBCiiVFiFmhf1NJAtqW2nbVRqnhy9YKz4/vcHyduiJo/G1RxhAjMdmjoIQoo3ugxKn20Q0bDrXz3ECAb44k7HyNT+i2rNurEQjlWEJJVumpaet++KD6eEuMZoAyR7qT9Q6zRKPkipmXQnIqMe+KoHSdPikfkwBy6uysZtRfM+cJJL+TEg3fFTrv3NzNS6yhv5kE/R26ra6EWWluwKN8GEFqgYlluyH7xFmULaudkPdyniGEiY3r71mOhCG/EnOx+qyv9XpZJUwCDdeJ4ASok3D9vDLmJnHh7e4W6e/DRX5CC7vB2rEFSMznQGn/EEfH+COQW7rLX6iy6aO+yRWP7p0CM3j5n8qsezFjDtNF2WTOS4Nw1dPSC1x4NZkVAXFhZj2DX5QNXG0qY6NEspswFyNUMlFxquiHDxvtoeK9mqs3PLkjrdEANWaP6dldIRSf8IPMNtShIqFcHbxdutQfZ+nhzBPy+LiB4PUVnUoFsIT1hxIFFijbNEl5hJuuOhMT8ubNzafkzVN4Acztk9Cm446c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rw1y2Q5twiUq5bJRmM6eFQmoW+cQAwGrnK2ej1EWfH0WkqeoIgXQ1/zDO3AX?=
 =?us-ascii?Q?njq4ucnggEB+M809sVMOx5zDf+2iSdAOHHQH1aFviaECimcLHwVEoG1bgvQa?=
 =?us-ascii?Q?59Wt4YC1ykPEPYjWGuwJHSY5KeKWlR9ZOZiwB13Tsab4IcHxSKWBFlh3Y2JF?=
 =?us-ascii?Q?LJuHcxwmaBj+pV/7KpAwKgxHxzC6gMCNTaCJYGI2vqnk5S6zy+FdPxGHIMIZ?=
 =?us-ascii?Q?UymbgKwNA2ClDVOa9MnyN6BHFN7VOS2GC9Fod9K8L2PruFAQtsVKe4spw8w/?=
 =?us-ascii?Q?Fjao0j9R58fLFV8TBVcvk0UJsNmMKcvjgFMd23FeL5rjRmYsgaTkggdMKDap?=
 =?us-ascii?Q?BV/erfIig6yPOhyiPRnAT3t2gptlWWee7mCxQN3q3CPYYNISJrem/QFzGjxb?=
 =?us-ascii?Q?f0+rGHPZeJYVgIQoZEHwDKvXf+jJ+gStL+EIZfO5B2xziuqYKMPhtnZRVCB4?=
 =?us-ascii?Q?pVRT7/Gx49utuf6p6IY4GlxuiRQqjNl8+63WjfNxUGudZN6yxYCqpdK0BJvk?=
 =?us-ascii?Q?DY5Rz8X4MYuksgslqawHBVDgi4w7G8DeW5I+u082fRQKCYDmNgzeJ0Xqcjw2?=
 =?us-ascii?Q?tDsolRA3fZ3up8RnOi3s2kMBR0pgl5xeQKr8yc85sAWPd2VVW8dsNvgXyMtq?=
 =?us-ascii?Q?14WdMb72rYakycNlwdlLnHCVtCigwB0rxaVIq13IKSNQAG7ux6m421iyAxzw?=
 =?us-ascii?Q?+/r9PWMc/04jYTeNXIfrTUgryVzwad3igkAGnO1STGjbjJhYZAqhvX3fk1GL?=
 =?us-ascii?Q?obFEgezse1wM3HlqpU+cEzpheWXFD3EtOEx5o73OYJ2wieSEmRpdWGBkER6z?=
 =?us-ascii?Q?pVLFqMWsb3hClRKxKNmMNSsWVLB/CjQuGlR/juQfvjGZQjdwHYIGE10U5Bmw?=
 =?us-ascii?Q?HtaUUnUVBwirDunuuWISp083c4djN8r1twSO6pLUPtYFBH1TlDbwo7hq+9xo?=
 =?us-ascii?Q?7kqgvlEl4uFK1dRn9WNh8T/X58rY1oTx0OhuTW3FMhH8d2uQku6kFPyOF1zc?=
 =?us-ascii?Q?Uvxj0yGxywJlLqsFvy8Ov20mB83zgr4SDCuVyX4vaMLfqd5j6OqzUHT1Jjcy?=
 =?us-ascii?Q?IE+G0WhMuz22AS+wC5PEgw0TmLlk9SRui2kKCVsjB8csvLaOId7F9p486xJm?=
 =?us-ascii?Q?rUncZhFZkt4hflU2Tnb+UsWSZC2B9oZinb4kOErIqvZZnHWdBdanv84DEZ0o?=
 =?us-ascii?Q?JDKjK5O0d8ZLtVvEH5fz7rjJf1SOeebu9OI3dCOZBxHsYvOwlAW7PGFi9O1K?=
 =?us-ascii?Q?7qsQSE6dISQWvA34CZZwkdyFHo6BtbKK9j0dlR7el7oWcmk/bWLyWkYYvI7T?=
 =?us-ascii?Q?fT7DfiOqEjOr1X3jRvFqdGQmCasGgcZyrz8CsGhMhctbfYw+D9M6YjRjuD8/?=
 =?us-ascii?Q?eQnRC4VAObPS/iDE6D7Ac+LP9YUQoie8H4iAFZ6U9qL4adWvcL6yfxYR4f5i?=
 =?us-ascii?Q?FtPzgc8Xnl7/Ten3cJWS7HVR9OmCSLlSQmXzDWNHQWWbZS2EYCV5ARAOUCET?=
 =?us-ascii?Q?MV4gvuipSxbOryvdZr242t+Eex2OwKEMvgCwrqFDwIzpl/6rJb2pB5bGsEXV?=
 =?us-ascii?Q?q4JO201V/2/2WIxGF50PkxU7QoYicm/17J9VSr6Kb9Kls95tcLeG86IxkbiB?=
 =?us-ascii?Q?QKCge+NfTaXKM1aU9yEhJWZCn+4/Z2MdNZ+IMnsx0IvIBKqLChFkOi8zCyB8?=
 =?us-ascii?Q?ir0qHkHlqCpX3cLdbiMTt4CjJCXyAQO9Hq0dDv9J9B47N+N8OUN9kOnL+KqH?=
 =?us-ascii?Q?n7M+UvRyag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21da9445-7a7a-4611-ce2b-08de7f84e8d9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 15:43:15.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGAuzj8docVkZdYANBJImXEyKUX3UXJfDWsljvj8DxUu0xP1szpAQznq38DUXyY6u+WayJzaXbPrT7bMR1irgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11664

On Wed, Mar 11, 2026 at 11:47:43AM +0000, Daniel Scally wrote:
> The i2c-imx driver runs i2c_recover_bus() if i2c_imx_start() fails.

> One of the failure modes is an arbitration-lost signal from the
> hardware however, to which bus recovery is not the right response.
>

Supposed

One of the failure modes is an arbitration-lost signal from the second I2C
master or slave devices, which is expected behavor. Specially two masters
try to control the bus simultaneously.

So bus recovery is not the right response for this case. Add check -EAGAIN
of i2c_recover_bus() to avoid wrong action.

Fixed tags here!

Frank

> Do not try to recover the bus if it loses arbitration during start.
>
> Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 85f554044cf1eec7d28310c3d9e7a7346237afdb..ed2316ab1ba8b6261dabe8af4377136a002e2f0b 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1539,7 +1539,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>
>  	/* Start I2C transfer */
>  	result = i2c_imx_start(i2c_imx, atomic);
> -	if (result) {
> +	if (result && result != -EAGAIN) {
>  		/*
>  		 * Bus recovery uses gpiod_get_value_cansleep() which is not
>  		 * allowed within atomic context.
>
> --
> 2.43.0
>
