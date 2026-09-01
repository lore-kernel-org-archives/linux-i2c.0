Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9140EBA6;
	Tue,  1 Sep 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788287159; cv=fail; b=Apl7t9jQzqmuvj2NLf8VdWSkRgP2ayYQjBl75ivBjDj8GcCStNmsvaIcDtTj83zZEcVDRBbwb0CJqHpz/1yCc77uKf5s1FhzapiJvPdhOJgcVKucw3LLSk3Ls/dFy3VaW8NujWa44XChWYOd8XwAtqlZEtYB0KGCFd8nySipegU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788287159; c=relaxed/simple;
	bh=PZl3UegIjcYJTDmHS//NdlmPNeV1mDB0zCBrPBuCrYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LqvhXY+wXrIdcsXw3ZCKa8ODQN8uo+XCDaK8YJnLp/hIbtYZ8kPSYSKo5z6v/F1DwPAmTjCZz0yN5koAaPg7CbG6+xWb+UD/ievNWV0jEtHr5vAC3b2M43xMZQGEi2rcgY5GWZE/ocnQCAz1fIL/oXLNsBmUf/mbq7ThysqBRBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pN9gCg9u; arc=fail smtp.client-ip=52.101.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pN9gCg9u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGUsVPWlHRM8ghIA82NdNTSuDu9txgqkZauGCifdMnDIFuUCFnuI6uPee8KnCgw6LDRgD+R3+6O+9mb/cr2yGUjEAszNVXgIN6jG6rSs5fcF4Ludu2YWei08MKa0e7RrNZt13qHZXsvH1QFgzEl7dXwcvneQz2kJs4MoMHMJ+Y/oKqr70j2qIBEMSz3ilPu9d8PRc6Dq81BXbhNSlxUOkR+6w+ta7HuKBGvqImg6l+IcPKaxGjDLJ6OmLPGbwRz9u/N10Sm97a68iyrJTXrV0YwWQZ7sS3W67ksbbfkKuic7dILnQR+LU13M1KR5VWWnMZQ4zvMuA3fSh4BU93RgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+1HQI3c5Aied2bzdpiTNL83LBh05Krk+Vi2Jcl8mzw=;
 b=D4fGJXvKF00OuMde9WTzT4pMaGHQuTaI80Sh2YSuFyA7Z9114JA9Og2gk37KgR800LPWIcn+BQANDYP6kmBh9AUcxnKsRB7AVTk2TJCSjdbmdjJ7YLs6LFFbl51Rd6eAf/hA76SvqpgwLNZpSkQxyIg3ClsgHdZpnYZjBoDEkT9VpUeJ75hWG4MLst0y5jJGRTILLVrnYmIooyHP91ReaGoVcgDUCNON97Ax1ck0A5B06psgMikHdURN8dDEWkmpSDdqKBwGbjeCxQ/eW+kMLhptuV0Kl1zQs8nS4b4OMF45MdhZijD+8+O06x40phc6E01EhoPyV5THqlYfrXbu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+1HQI3c5Aied2bzdpiTNL83LBh05Krk+Vi2Jcl8mzw=;
 b=pN9gCg9u1a3hs+eUMYjrH2MiLoq2IoT49bLGKAUsAqzoxCkFQWIKdQLr0UHvS5WTx/sBIkqmgQwXdIjXRph8EeMFXPMjLg1GWiUqmIdc7O1+FUJq3NB8AOP049WebTVWmgMbbYSFlxH5ETGh3TlFcaMIs0cMErDY5j5FVrSuKJBD1+xoSMIPJbkn1Xl3Gn3dra7plPYg+mUiRiPTzCoPWoql0GFTywYqxc0VOpjLl9hqPlPcDxhxpQLY1E57vkgvTCfqYV9IBYKFivIv0e9GT4e+DBUnUgLJyZH48+SDhDexkOWIIkZ3OJ2bL/RdDebN1RnWjV9Qfj62rdt5q1YXbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8616.eurprd04.prod.outlook.com (2603:10a6:10:2db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:25:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:25:51 +0000
Date: Tue, 1 Sep 2026 14:25:43 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: imx: add I2C_M_REV_DIR_ADDR and I2C_M_NOSTART
Message-ID: <apcYp0Zc7CrJMiOh@lizhi-Precision-Tower-5810>
References: <20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-for-upstream-i2c-imx-lx2160-reverse-v2-1-f1343714c5a9@free.fr>
X-ClientProxiedBy: CY8PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:930:48::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: e932939a-3ec2-4f3b-fb70-08df085673d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|23010399003|1800799024|366016|3023799007|5023799004|10067099003|11063799006|18002099003|22082099003|56012099006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	r8bx5fV3ghtFsUs+NzHAKG5B4I+YCF3w0LNIsxUnPs10LapaWI1jZLX6J/Eb1Lyn7g+1gKS6/A5O8q9Sn0vXiCA4t+F69IyVsh37G/cOgIWwFhbDIDZhIKWQ/YzXhmRQvEQpBr1VKlFrlHzjFqc5Tn6XQRv7B1uFlem9mDr5AZ32GL2z7UeSDtahHr8A0Hy7fiZhCUOs3irV7qVdQqWsZwk3E5B3xoOhDuJ8OvvRs2pD6Prm43Z5l4lRdv90EUQYOBSjP3VEDKkkdgxNj0vo3gZQvHtv8euJwNl9u06IGfW4IGj0SPUv/x3xrB1O2VJT/JArmB6KZs49aHguwR8R5AduEkYRImMwQkydNojKHuhKzbIsc2D680Q/oGjJr6o4sr5WmvLF8YktSzwK0lVWZ6CV3Cvc6UH4CvXYQWyzYCM/XswG1/21naa8SYFNYA0zNlyCZscsxyU1Uo19NSp/qTB4PmCZXzA0jbVautkmy2mOuAH4WGqjRiY0pD9bstm3QZ1/FlIYnjTyGa5W8TSDMoe+pxm3UzLbJbQL1BGpdo+br7ze3ZJ6vM4NMq4EFnW3F22ZAsPJF3YD7Tc3P8diqFNyMndYe1MS5YGmvzJV5Knr5jgmqWj5zAbMB3wPHbnL8JIZK3GuaIKtFt+hVhpmu3eWbMgHrfIrN+hJh+2n+jsQpvRUefvZKTu2KS3TuD6ZsKYDyIRF9l5u+5ZlXKPTZAyKJZYwAjj+5pLURoE3YKlT6J25puqjccz1qCxvy8Tz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(23010399003)(1800799024)(366016)(3023799007)(5023799004)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lB6PLQChKvQ2v6lErDDNV7t0BfMiQwDsobsNGYn4ciqH2g95H0lYniEbUdA7?=
 =?us-ascii?Q?UzlDz91SyHwLFBc8AOuF3sxTogihzVhDpwV4qnSHIktsO+gyhzRzu6FK6JTn?=
 =?us-ascii?Q?+hlueu6DDjJQlYBDDPUvBGIcVIzrBpNJyqmzZwlGdOlNimZb2UBHKbnHaZ7R?=
 =?us-ascii?Q?O61ht0MA5oEjlzYw3s7uxwLDQ2NgU9qCDd4LbljESYewsYlplGqvZKSvcGAt?=
 =?us-ascii?Q?wAGIVJKkHqyWrdJK5F13j8A9mVB8MNqwEq0BdpsC+HADnIVz46kbKmZ70SJQ?=
 =?us-ascii?Q?57ovqL2u4BVaDZuzDQGU8Pdu6gE7B9SINh2urFHhcgXga+bqZL52a3KD+3ab?=
 =?us-ascii?Q?Fw+54b18X2JI6oTVb+/ycVIav1vIj7ZtiWE6MtXklOyjk64gqux7O6gvgd1g?=
 =?us-ascii?Q?Z39S6LdBijCALEzRvPlcxXxBpZoNzuC37NdjK5+7pFpBbddyH6nXjvSBE2vb?=
 =?us-ascii?Q?LGjG2pdsNF4Y3Npqzh0FUBeDKVy2+Tzus5AJ/EsWLyc8fvwnqkmNA9fi6sTM?=
 =?us-ascii?Q?aWN92AdHyG3F7VnuuZilmv2cXLx+xFmZBVTZX3239qeCHm/l4M88VtVbMldG?=
 =?us-ascii?Q?uQhHGcnDu6+McDd6SFwY5CW978biq+pkAbvkpo7Z/zyr3CohSLxfZ6v+/CL/?=
 =?us-ascii?Q?O0t3rG1HgVcglehdvmqH6rhoGk3ZVVxVAyy0XPVtdtMlLnXPONLcqkwiQPBq?=
 =?us-ascii?Q?V24YH1hOYbqhYFMq15fVbUNCrMmec5rl7R6s/Qa+o+w+/VeMTelcJ3KMN+hj?=
 =?us-ascii?Q?Ly3ayB68Hlp0ZBA/fId4KtOkSmWQK0yUKryulW6aTe1CqDjOwM9z7PIMRvg6?=
 =?us-ascii?Q?OR2cgCf7oOYKWm+RUD5XIA0URRrMVQE3SZt7QcrYZWV93BePH/i63Ie60Kgf?=
 =?us-ascii?Q?BXXGRQQI4FmryaKiR4kE6wkipWYBg458JlfExD1hnkPSIcd6Ut+OhZykMY9o?=
 =?us-ascii?Q?IlGYYhM0f0XfZ4VWBkIxDICTg5keiFg/wKPj2O2Xi04TAXS6q1EtqgH9iDug?=
 =?us-ascii?Q?gwVALIzzGeON0S5jCT5sqMiTH25OV39GkwZgJ9EGbm9hx8nySYspMlmf3O88?=
 =?us-ascii?Q?zyRYbxzl8Oiu1V+rWDE/ZGYkCJD9cBTwsNeYdFOk4V77JHzuJsukS3ShuTru?=
 =?us-ascii?Q?eVIUsjAKEk1pyeiP8WwkqUR2F52npLxLLklnjDHVkkxGL5kwmUI5LGDccjbD?=
 =?us-ascii?Q?2peXovhmRzloHEoTfmagW33wgz0KQyAhi7IoSMvyUsasazF+YDoso8DtRcTs?=
 =?us-ascii?Q?Nw6FeG7eiSyIr6sE5rdBT9skYIXQ/dshmyJky7zoh8bga8aae/+oSS75p+bU?=
 =?us-ascii?Q?yqduQ6SjgtIe6fLLCOW24SJ/+JttNnA/ZnAOmlDLYIIAH4QSYU2q/TcRQRqa?=
 =?us-ascii?Q?lo4lXeVypO9VH4M7OxPvgA6AP9+uGVxK7k6U4P2jhaXrMOc2vNIuJMOJJ3Pz?=
 =?us-ascii?Q?IFVVI79bhsE5eKTxUUm7x9wV3W5kVey7DgSKdBJS8YXLMlM7WflIuqQFOxtq?=
 =?us-ascii?Q?P8LFisPJqQ6L4mcJkixhqnyut0HNR0/VDs66oJFtJB8DqlPGvuoaKkuC9u2Q?=
 =?us-ascii?Q?Bj3WfqTfIAkdC95mIzzuNyIWEpuTu+YSo8+NNsrg4A0C5UihF/V92Y4FY+9/?=
 =?us-ascii?Q?HHTKvGzMYXHmysutjgS6qmMezzuaTpy/tZjfwX1k1vdEjgEll7HeBTmO3nKG?=
 =?us-ascii?Q?eqUWLMDJ38BUdYK/8xL92zzH7nfWSDFxjlmGjMpd3xPHRJIjpVte0/XsV31o?=
 =?us-ascii?Q?xDgK7dKck2GvogMeFcnm1y1vQSr3Mk3Saft4ZB3yhfl/dTy6XeM/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e932939a-3ec2-4f3b-fb70-08df085673d2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:25:51.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y57/Q5vyUw3BjH7xmVgovIiK4ewose7n6gj/X8I5r0s5oviTfGiHFFJYQ3QNpUuRgJER3BSmX6BpvgSEc6hz2gwvQH1xV3ibIhiva59GlYWUVxVwyj4Yy0VKM5WoSAWQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8616

On Wed, Aug 12, 2026 at 09:16:05PM +0200, Vincent Jardin wrote:
> The Realtek RTL8366SE SMI read frame per:
>
>   S Addr Rd [A] reg[7:0] [A] reg[15:8] [A] [data[7:0]] A [data[15:8]] NA P
>
> Linux support it using I2C_M_REV_DIR_ADDR on a write message
> that inverts the transmitted R/W bit, and I2C_M_NOSTART on the following
> read message that continues the frame without re-addressing.
>
> This NXP i2c-imx is missing such support, so on an LX2160A the Realtek switch
> could not be used.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Follow the logics from i2c-algo-bit and i2c-s3c2410 (addr ^= 1).
>
> Documentation/i2c/i2c-protocol.rst says I2C_M_NOSTART "may also be used
> between direction changes by some rare devices"; the RTL8366SE is one of
> such device !
>
> - The NOSTART read turns the bus around without waiting for a completion,
>   because the controller stretches SCL after the previous byte and the
>   frame is therefore still open. That is what lets i2c_imx_read() enter
>   the state the ISR would otherwise have moved to.
>
> - I2C_FUNC_PROTOCOL_MANGLING also covers I2C_M_IGNORE_NAK,
>   I2C_M_NO_RD_ACK and I2C_M_STOP, which this driver does not implement.
>   They are rejected with -EOPNOTSUPP rather than advertised and silently
>   ignored. I2C_M_NOSTART on the first message is rejected as well.
> ---
> Changes in v2:
> - message validation with i2c_imx_check_msgs() (Carlos Song)
>   No functional change
> - Link to v1: https://lore.kernel.org/r/20260807-for-upstream-i2c-imx-lx2160-reverse-v1-1-f276ce8cb660@free.fr
> ---
>  drivers/i2c/busses/i2c-imx.c | 153 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 113 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 9477d814fde9..7dc9c43673ee 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1000,16 +1000,10 @@ static inline int i2c_imx_isr_write(struct imx_i2c_struct *i2c_imx)
>  	return 1;
>  }
>
> -static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
> +static inline void i2c_imx_setup_read(struct imx_i2c_struct *i2c_imx)
>  {
> -	int result;
>  	unsigned int temp;
>
> -	result = i2c_imx_isr_acked(i2c_imx);
> -	if (result)
> -		return result;
> -
> -	/* setup bus to read data */
>  	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>  	temp &= ~I2CR_MTX;
>  	if ((i2c_imx->msg->len - 1) || (i2c_imx->msg->flags & I2C_M_RECV_LEN))
> @@ -1017,6 +1011,18 @@ static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
>
>  	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>  	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
> +}
> +
> +static inline int i2c_imx_isr_read(struct imx_i2c_struct *i2c_imx)
> +{
> +	int result;
> +
> +	result = i2c_imx_isr_acked(i2c_imx);
> +	if (result)
> +		return result;
> +
> +	/* setup bus to read data */
> +	i2c_imx_setup_read(i2c_imx);
>
>  	return 0;
>  }
> @@ -1172,6 +1178,16 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
>  	return i2c_imx_master_isr(i2c_imx, status);
>  }
>
> +static u8 i2c_imx_addr_byte(struct i2c_msg *msg)
> +{
> +	u8 addr = i2c_8bit_addr_from_msg(msg);
> +
> +	if (msg->flags & I2C_M_REV_DIR_ADDR)
> +		addr ^= 1;
> +
> +	return addr;
> +}
> +
>  static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>  					struct i2c_msg *msgs)
>  {
> @@ -1200,7 +1216,7 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
>  	 * Write slave address.
>  	 * The first byte must be transmitted by the CPU.
>  	 */
> -	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
> +	imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
>  	time_left = wait_for_completion_timeout(
>  				&i2c_imx->dma->cmd_complete,
>  				msecs_to_jiffies(DMA_TIMEOUT));
> @@ -1242,14 +1258,20 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
>  	int result;
>  	unsigned int temp = 0;
>
> -	/* write slave address */
> -	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
> -	result = i2c_imx_trx_complete(i2c_imx, !use_dma);
> -	if (result)
> -		return result;
> -	result = i2c_imx_acked(i2c_imx);
> -	if (result)
> -		return result;
> +	/*
> +	 * I2C_M_NOSTART continues a frame that is already open, so there is
> +	 * no address phase: go straight to turning the bus around.
> +	 */
> +	if (!(msgs->flags & I2C_M_NOSTART)) {
> +		/* write slave address */
> +		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
> +		result = i2c_imx_trx_complete(i2c_imx, !use_dma);
> +		if (result)
> +			return result;
> +		result = i2c_imx_acked(i2c_imx);
> +		if (result)
> +			return result;
> +	}
>
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
>
> @@ -1371,16 +1393,18 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>  	int i, result;
>
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
> -		__func__, i2c_8bit_addr_from_msg(msgs));
> +		__func__, i2c_imx_addr_byte(msgs));
>
> -	/* write slave address */
> -	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
> -	result = i2c_imx_trx_complete(i2c_imx, true);
> -	if (result)
> -		return result;
> -	result = i2c_imx_acked(i2c_imx);
> -	if (result)
> -		return result;
> +	if (!(msgs->flags & I2C_M_NOSTART)) {
> +		/* write slave address */
> +		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
> +		result = i2c_imx_trx_complete(i2c_imx, true);
> +		if (result)
> +			return result;
> +		result = i2c_imx_acked(i2c_imx);
> +		if (result)
> +			return result;
> +	}
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> write data\n", __func__);
>
>  	/* write data */
> @@ -1402,7 +1426,7 @@ static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx,
>  static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  {
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> write slave address: addr=0x%x\n",
> -		__func__, i2c_8bit_addr_from_msg(msgs));
> +		__func__, i2c_imx_addr_byte(msgs));
>
>  	i2c_imx->state = IMX_I2C_STATE_WRITE;
>  	i2c_imx->msg = msgs;
> @@ -1411,8 +1435,16 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
>  	/*
>  	 * By writing the device address we start the state machine in the ISR.
>  	 * The ISR will report when it is done or when it fails.
> +	 *
> +	 * I2C_M_NOSTART continues a frame that is already open and so has no
> +	 * address byte: push the first data byte instead. That raises the same
> +	 * interrupt and the ISR carries on from the second byte.
>  	 */
> -	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
> +	if (msgs->flags & I2C_M_NOSTART)
> +		imx_i2c_write_reg(msgs->buf[i2c_imx->msg_buf_idx++], i2c_imx,
> +				  IMX_I2C_I2DR);
> +	else
> +		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
>  	wait_event_timeout(i2c_imx->queue,
>  			   i2c_imx->state == IMX_I2C_STATE_DONE ||
>  			   i2c_imx->state == IMX_I2C_STATE_FAILED,
> @@ -1529,22 +1561,29 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
>
>  	dev_dbg(&i2c_imx->adapter.dev,
>  		"<%s> write slave address: addr=0x%x\n",
> -		__func__, i2c_8bit_addr_from_msg(msgs));
> +		__func__, i2c_imx_addr_byte(msgs));
>
>  	i2c_imx->is_lastmsg = is_lastmsg;
>
> -	if (block_data)
> -		i2c_imx->state = IMX_I2C_STATE_READ_BLOCK_DATA;
> -	else
> -		i2c_imx->state = IMX_I2C_STATE_READ;
>  	i2c_imx->msg = msgs;
>  	i2c_imx->msg_buf_idx = 0;
>
> -	/*
> -	 * By writing the device address we start the state machine in the ISR.
> -	 * The ISR will report when it is done or when it fails.
> -	 */
> -	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
> +	if (msgs->flags & I2C_M_NOSTART) {
> +		i2c_imx->state = block_data ? IMX_I2C_STATE_READ_BLOCK_DATA_LEN
> +					    : IMX_I2C_STATE_READ_CONTINUE;
> +		i2c_imx_setup_read(i2c_imx);
> +	} else {
> +		if (block_data)
> +			i2c_imx->state = IMX_I2C_STATE_READ_BLOCK_DATA;
> +		else
> +			i2c_imx->state = IMX_I2C_STATE_READ;
> +
> +		/*
> +		 * By writing the device address we start the state machine in the ISR.
> +		 * The ISR will report when it is done or when it fails.
> +		 */
> +		imx_i2c_write_reg(i2c_imx_addr_byte(msgs), i2c_imx, IMX_I2C_I2DR);
> +	}
>  	wait_event_timeout(i2c_imx->queue,
>  			   i2c_imx->state == IMX_I2C_STATE_DONE ||
>  			   i2c_imx->state == IMX_I2C_STATE_FAILED,
> @@ -1574,6 +1613,33 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
>  	return ret;
>  }
>
> +#define I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS \
> +	(I2C_M_IGNORE_NAK | I2C_M_NO_RD_ACK | I2C_M_STOP)
> +
> +static int i2c_imx_check_msgs(struct i2c_msg *msgs, int num)
> +{
> +	int i;
> +
> +	for (i = 0; i < num; i++) {
> +		/* Reject rather than silently transfer */
> +		if (msgs[i].flags & I2C_IMX_UNSUPPORTED_PROTOCOL_MANGLING_FLAGS)
> +			return -EOPNOTSUPP;
> +
> +		if (msgs[i].flags & I2C_M_NOSTART) {
> +			/*
> +			 * NOSTART continues an already open frame. The first
> +			 * message has nothing to continue from,
> +			 * a 0 length continuation leaves the controller with
> +			 * no byte to clock.
> +			 */
> +			if (i == 0 || msgs[i].len == 0)
> +				return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>  			       struct i2c_msg *msgs, int num, bool atomic)
>  {
> @@ -1583,6 +1649,10 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>  	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
>  	int use_dma = 0;
>
> +	result = i2c_imx_check_msgs(msgs, num);
> +	if (result)
> +		return result;
> +
>  	/* Start I2C transfer */
>  	result = i2c_imx_start(i2c_imx, atomic);
>  	if (result) {
> @@ -1604,7 +1674,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>  		if (i == num - 1)
>  			is_lastmsg = true;
>
> -		if (i) {
> +		if (i && !(msgs[i].flags & I2C_M_NOSTART)) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> repeated start\n", __func__);
>  			temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> @@ -1636,7 +1706,8 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>  #endif
>
>  		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
> -			msgs[i].flags & I2C_M_DMA_SAFE;
> +			msgs[i].flags & I2C_M_DMA_SAFE &&
> +			!(msgs[i].flags & I2C_M_NOSTART);
>  		if (msgs[i].flags & I2C_M_RD) {
>  			int block_data = msgs->flags & I2C_M_RECV_LEN;
>
> @@ -1730,7 +1801,9 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
>  static u32 i2c_imx_func(struct i2c_adapter *adapter)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> -		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
> +		| I2C_FUNC_SMBUS_READ_BLOCK_DATA
> +		| I2C_FUNC_NOSTART
> +		| I2C_FUNC_PROTOCOL_MANGLING;
>  }
>
>  static const struct i2c_algorithm i2c_imx_algo = {
>
> ---
> base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
> change-id: 20260807-for-upstream-i2c-imx-lx2160-reverse-7a94b9561188
>
> Best regards,
> --
> Vincent Jardin <vjardin@free.fr>
>
