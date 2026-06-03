Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FD47AF42;
	Wed,  3 Jun 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512718; cv=fail; b=nfE1ldL9ti/M6dbdIkqqgMpM+4c2OQy0LlJnxlzTH7o9hK+D+SzZUC4raDZO+fhkIifJZsYB3xQlB/FOV8xTQj0gca7BEDZvlp3EO9M3pRRQi8y4ylUZeE4GnJg0Lws5oHr1AkqdM+CguFHuZYo/WIaRZE1pyOdEyHesXNlzOUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512718; c=relaxed/simple;
	bh=aFvtAF8VDaFAT7BBj/riUO4juI7h1mNl6zUDesPW7Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bKS03vE/tWlPcpGbo2JoMYvc/01SiKqf0xU4GhF7DYeN2ukS/r0fcHOqd6o+1XG//IQoa4/9eDIc+CZAPNkYhre0jFGQyWF1M26an7Rn4G9zBveJPJQ38TyBx0KaXCj3JceL7fGgmlrVTqGt2L0e1+gX7VoZ+1hzNiPP7X/bu6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yuf/Jv7i; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yuf/Jv7i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dU8bSHzyBRNpzcMwQ7YlmbXQjfuO1XeuOfnKU9Hw8Iy6g7dlOlZmvFMhsjFhqgFUWwcHwq/Bj0k3Srtdm11x2PbsZy1WCw22cp8WtbPIMKy3HPZe6wx4EbrXRpjW9I8UhFPutrZsrxZAmZfu3ZRpirVNzSgaYZ5qAsXRvDIUQvZfwBrhQdfWmNqVunELcgs9QaWA6p4VdxP6s9uk/TFPKCG5op2xD1ODg7fY7SvTzfucM0KecCCmpLfu4+7NJo1Kd0diHfpRepHwf6gYq6kHUNWrJQd/JN5xnod8uddVuAkF0AwKndF42jX+TbQs669AiuNI+7SbEPxC9YrEbNQ2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8vTiRz6UjGmljawUk+WG9dNQoYYQmkztMEykW+20pY=;
 b=qSG5CHNyZWB13Ca6In/Ypy+Fp5GAoc6aBTFCoWBSM5CGshlqehjIrz66iPgY9yPIWQ4xOXOf7GiVJ8EJjbsyJ6j8sn0mw+002d9XYutZl6WPz7VSdSwoM5lLPlWWfo2oNXq0gC5yuzqULUmrlm8c6JX/kdySouu+pr/7BgGaiikbcVGVyCblWwTPAbgtHB7TUK3FNZxRjLS5hDqXvMOTRQ/9nC76mQSMYK2lRvCyI592HGwXtcIAGe8nZ5wAze5IVQBXXSAOGXAuEWPxJ3hkqYzuMn+l24Y+WMnbyNosF2J/Qox/eSTBZnQoVUFXXkPngzeun5MKJXJFpMn6L2E8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8vTiRz6UjGmljawUk+WG9dNQoYYQmkztMEykW+20pY=;
 b=Yuf/Jv7i3ooYBtbdoQYWZgHGVZCpG+amB78GPQ6qHikGI8U5MG5Z9xxzOJxOHEjHMgPkWax+l9/oaIajuxW1+qeiDWtGrbVOFBDL7zEYrxEZ8WXQR9ba7czV12MK8OKku6RjdWZnZVBZ8a/VC9XE/A5vmLmOSFdII6pPMuq4fuKKLYj+s9j9mnZV065EOR/TJhZjVlFM4WvEYjYbNDxjeStrm6FIXeQY5d3JkkBVmoomq5Sq/EIGA40F30c1nv7SoFEdy8vPV7FXeOwVotHYf94p8CKsZfE5zjGdyG62XfbKiah7Zyy3BcYAJnZurm3MwQZ+A/thGUqhNQ6WAHbdUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8683.eurprd04.prod.outlook.com (2603:10a6:20b:43e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:51:51 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:51:51 +0000
Date: Wed, 3 Jun 2026 14:51:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] i2c: mxs: add missing kernel-doc for struct
 mxs_i2c_dev members
Message-ID: <aiB3wY_uG0lnCL5J@lizhi-Precision-Tower-5810>
References: <20260603031135.289302-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603031135.289302-1-rosenp@gmail.com>
X-ClientProxiedBy: SA0PR11CA0195.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::20) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: 0572b698-2f5b-4ede-c41b-08dec1a12c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SmJFjVbzlNiXPUhmJgg2GUZSMR08ocDrC1f0kX8ZmKvjjW64ni1goxgjJXAUpvIcjxhHEGKmGL/zTzHFovZq3pUhQnDx+0p4TeC7QYvs6mgLV0OCwKScIQr7yT2sd1Kr2pRV7DbaMNua99oIIGtBBDKarScT/6d62uGKbXZhYUvPGzA9GOcPv18b9WwBQ4RzvJPviKHNXU2xU3hBmfZNdU9mVZPEL0u5YHZ00YNXxl7cApd6P7XPBJWSaD+ypu61MpqlAnEVCJ7HNxNavjfWhunqfjUSiYkdt5pUD+SAG4RANLA0M1lnsLr2w5/V3NDncIRGpQlmnHr67InhaD8eEfqHKC5znOZWZUD8QR7MUwV1QwJwuVb2lyf30wJzOUV6zUWPwCpUDl6e2fAUHjnICVFGLuHdMEYPdL63X1U1MqsbzLInMToKRB/zX8Qzo3pRUHNL+bqpyNOzUK/SuBIZZusPZObG1i482Antnku50+XrfZJFbOCvLFn93MiQESo2/5FpB+RhOFsgX7CN6RMdkPdEFBSaHNE5tHVL9ilTh0TtaB2q3rqxwf/PfsgfjGK0gpDsrrouYhEJH310ueshjosifj+qKPE6YfN2Bi303YofMdyAGlmjdwNOfeZ1+TfjgpGdO3/PJrPx1a9+QgFs1ogy6kLR69IE1BDfAuaTxK9MwFfaB+1r7aiOh67aBLagG2KeMwS7s7tEq3aa/VlYE/gHQ1yv+vpNa7QtY4uFSTEqTn43H1cZ/TqLnsrqqG6k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w454pAKu5dDQcHKOV94n8RnUiXEwhJqLI1a+sqMg+DR9JiL2q/+zyZl0qcUG?=
 =?us-ascii?Q?a+ywxp10bSc0s/hQ1BeRrx3MPxex50IpsVk8OGXdvHWiw+I0dz5fSmZ0VQdm?=
 =?us-ascii?Q?jH4zybPZNAlbZm2pLLUhnj63BDrzX6lS+gw/TyG5oVcjSRBTxuJK8nf7b0cE?=
 =?us-ascii?Q?pA1LOAM+/qjstIkeWPObNSPiDpl4ketyUECqOzyh4NoUQH9l2GAIXG2BYg5d?=
 =?us-ascii?Q?pWqeHi849B3MNc8ivERD8RVTWjZQVUUWrTfbpH721lxqLG6dDmj96PzdYr7f?=
 =?us-ascii?Q?pLJt7hmpXebOf5oDEnrbtLmPfoTQ+MQidZBiBcb8TIPu7L39jUVRMH95XwUB?=
 =?us-ascii?Q?xcZFgSnpBv5B6wajyNXpWuew+W5or5/8Xn2+Ph6FLxdzIyuGOZAP5FWdHsQp?=
 =?us-ascii?Q?DdW8tnMulRUWSKJWfSS1/a4pobmH6PxewEYvkQE04tuPTPv8oi1J8spuduXU?=
 =?us-ascii?Q?aTjCzvRrdYrahskGgBR//GVuSLowe8uF7C8lQDJNtBijwgQU2wHxUo1CUL0i?=
 =?us-ascii?Q?P5AtnPpaqjg6pGRd8tifTgcsOybAmjUh+clXxMRKpSPBDiO4H+SVwb75Eqen?=
 =?us-ascii?Q?KZfBBjzS4sXJeiMzXT3DEu1HnEk4o5VFmAq9QE7VcyXTC/7Dplljb+3drH/W?=
 =?us-ascii?Q?M7Z+vznBF74Adkls4bs+REV+VtnTwnMI3OAHqustdakL7zL74vBNxA6mt+Kp?=
 =?us-ascii?Q?3xSvPD2yk6Q2Crab8Hywf8FBmO2CSPCK9isG8TaKPppNh8OBHy9Tu5Nmaczy?=
 =?us-ascii?Q?WhRSgEHicwxThPpy3TPyiwC/3+LgOgm6Hs1uMQoaD4ZWuRYUYtvEIth/0r0A?=
 =?us-ascii?Q?PoIxfSSRStpvyuQpdmVC4G+bN5v9ooE8NEb7XM2K8vCXJf+3MeRmUtZs7Ifx?=
 =?us-ascii?Q?dTBzrR/6cdT/r2d/VNJ6Q85SIPNi740eoVwvzAWl7yArR79vN8yE6LLuyjJY?=
 =?us-ascii?Q?IkEqU8I5oUkExFQIbVjRedUk1EEFn444EOch6GzETtc3t95MWT5i5cgHQTUU?=
 =?us-ascii?Q?fYf9j1DVQLB/fmLaYDcephGWhbY8dXU2Q2Nny4qj/lJqMnQWd+0tMdwpxH/P?=
 =?us-ascii?Q?NYbvzEDjm00mYsxSMN5WT43NLUlQqc653/VhsL2MGIYpgFJJ9t1xDZSdCBu/?=
 =?us-ascii?Q?vc4xO8O+zu5Egjt8q0/hdjLgJDiJyPU3FbmBbelWoEEgwJj1Z/p+HN1lyFz3?=
 =?us-ascii?Q?RGdXYEGLDUgoI/Ly723KXU6I9YbQPCFwsch9xoOTgdnnjcQr+qdALXlr3s0q?=
 =?us-ascii?Q?sByB2dlFTgMXyoCsAYddcSlRkYclq/dTL7w+hSf/+cmhi0rNOUQt8O36PgL/?=
 =?us-ascii?Q?9QM8L3MMTfnyru6MpGn5hCTSkNCPkXKeW2NYlxp5s7/CnKmXWLrIUemOoEF8?=
 =?us-ascii?Q?YM/AxD0SadFwMxqu3ljkcI4zooQK3J5b1+mH7K3fu0m16t5AM+RxRz0t80EC?=
 =?us-ascii?Q?Rhtq16riWMwoz8XLT7Hkp3KrsgdN+XOCT7ycbjpZyDDqJudHlsEdWNA/3VDW?=
 =?us-ascii?Q?P3ftrC1GbhHR8jNgdKG9yzsIJ//mu0wQ3ch2TWxqfMnXsL1aMO/4JWZkcBLo?=
 =?us-ascii?Q?cO71Sn+jRYq+2ob5M0QmKv9L8KWHyNal2nskzmO/X8mLwuToiJQqpXOd0mcb?=
 =?us-ascii?Q?kzD8hBQ5d6FR/3LwtUkwYKMWZYGV6F/VIBW/EU6SjAVgX8TXEHuVqhTdDbDR?=
 =?us-ascii?Q?3HnJEndrKEp72O/T0+GR7bJiRjZmGMy4nir0us3oPwAfFL82kGIK1f1xjWOc?=
 =?us-ascii?Q?6z5aaECGiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0572b698-2f5b-4ede-c41b-08dec1a12c5b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:51:51.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yc5Zy3ejT0MI3P/fwPUBcstEBRrrRsJqeCDhbZU9XxXaDVeAmS5rLtvXM0AWr3+sVT3bBIGx8psVopcxKkeYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8683

On Tue, Jun 02, 2026 at 08:11:35PM -0700, Rosen Penev wrote:
> Add kernel-doc documentation for the struct members that were previously
> undocumented. This fixes warnings when building with W=1 and ensures
> the struct is fully documented per kernel-doc conventions.
>
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  v2: fixed Signed-off-by.
>  drivers/i2c/busses/i2c-mxs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 08c9091a1e35..4e07babea9c3 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -108,6 +108,14 @@ enum mxs_i2c_devtype {
>   * @cmd_complete: completion object for transaction wait
>   * @cmd_err: error code for last transaction
>   * @adapter: i2c subsystem adapter node
> + * @timing0: I2C TIMING0 register value
> + * @timing1: I2C TIMING1 register value
> + * @timing2: I2C TIMING2 register value
> + * @dmach: DMA channel
> + * @pio_data: PIO data for DMA
> + * @addr_data: address data for DMA
> + * @sg_io: scatterlist for I/O
> + * @dma_read: flag indicating DMA read
>   */
>  struct mxs_i2c_dev {
>  	struct device *dev;
> --
> 2.54.0
>
