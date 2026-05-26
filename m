Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023143.outbound.protection.outlook.com [40.93.196.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC273D88F1;
	Tue, 26 May 2026 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790470; cv=fail; b=Cm5UIIgaw90mEouHqiZDhHoHdqIyJwz9eI39sQ5Por3xR72jQmdUIP/C+DS+z4dZ8Bc3EchspISKu0DIE3Xpd2tNxauJtRhsGyz4nkTmxOmK5jODzhu6pPhqxjxiDxsLcwDPLgSRJiGZeTIKmNUqHol+MVsqiW73qvm4BetsPhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790470; c=relaxed/simple;
	bh=4Vb9GgtCT/yVris7z1duDQtdf0FRrBa3pmcsu5j/M8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYKuVWemn5PY6YFYnASth4QtlIjaAlB38urGXaXK2iO3ENgs6cb9TkN6EDT3NiLphm+GORnq6yJOnQmsZUPKm73ySXRFZWB5h0yRQk8X1kz+N789nk7LaT0j2Hpmp+4pIqpJjcycuL9Z7DhFcc9JT3mKpTXlapCxUyIKRaWn6kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=j6Qgvf3l; arc=fail smtp.client-ip=40.93.196.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="j6Qgvf3l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0sasW0I/lJmWWTkmifCcE3sQ7zmK2TUkoYIojRxj4TczYD4pj8GmmTWxaLSHauDiAE1yGlC7A/8PsvJcObODk52LBhxexQQR1ZOUKDNWA1i3Dw7/HtJp8PRbXDEOvzf04IVzNQbVOdWB97UsBzFSzJayUWEkz2IUISdL6NslliUk9dXuenoxKg+cCEqK2m7P1Ugrk8iR1Abqe8gg+plPRUguyWu+2ZDII6Dsye8ipmJ8wJPYUTNbdIJ+cR/z0e9TyYIOjDmyywynoAPNxjj5Y231nbJ91szE1nv98xCVsJcItphRjW7DAtUsPyncEfEGh82v8YdCQ+Lv8Ze+qJdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDvOFDpaksUUU/ZPLbdXHxvMT7keXlHRcQVjQ5Gw0jk=;
 b=h2Ftag3ie3Hrk3DOt8qcYV0rKL/Zr7FsbGBWg8iTGr+alK7WPKBfJW+1Kga9H3Zyd49pdZUUbCijbcb9sCD5paSa2tDGtaV4OWSsfMvgVDP4goLOH0L0iIonl8PHY1Rk2Bexm6lprT2FQ61ZS40Nav8GE9WliElISrr7yhdXxd+n5Q3DGwVO8xXTuquSLOCpf1K+p5z//Yr/SMv3xe8lm1c8qmLCh6a729kyh9TaLdmPVDAFmtHOVb42h4DHiZjVtDXGSVB5p+n5J+OYHBm0WdIBHdea24LucMb2wqnRtSHO8jm2jycjR2oMPAyndrK0hIs0nYPsZ1j7dFqq39CvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDvOFDpaksUUU/ZPLbdXHxvMT7keXlHRcQVjQ5Gw0jk=;
 b=j6Qgvf3lxV6HQ1ZI7WRHNkWJQ/Vu8SFmizalySItnrRIv9ZMAsdcVZpoWZxShT5LnGLzZirO+NxGLfdsdhnc87+rulrPjBWak2W51PSkxksqp86NV5traITMcgPJJUdt2kh7OGwr/4KOlHiiDBduFP031DobmlsdJeXu/HQnOzwU057P/luDmbocXoHtyEXHxUUyZI7OqUnjnK8e1DtGz19M3GTVnpLU6SpZL9MhVUa2hKCwJX8YWRJbwsdYyDABOfJZ1YuzMced3ombQTqqtDlsWaQ4Rj33/MlsUOJO3W63yy0bHnotv+KCCVNPnlwq9shAoe4YvaTfyQx1ylqdRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DS5PPFE7B3EE5B6.namprd18.prod.outlook.com
 (2603:10b6:f:fc02::1ca) by CH3PR18MB5746.namprd18.prod.outlook.com
 (2603:10b6:610:1b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 10:14:24 +0000
Received: from DS5PPFE7B3EE5B6.namprd18.prod.outlook.com
 ([fe80::fb4c:ebd2:78ca:fd5e]) by DS5PPFE7B3EE5B6.namprd18.prod.outlook.com
 ([fe80::fb4c:ebd2:78ca:fd5e%6]) with mapi id 15.20.9846.025; Tue, 26 May 2026
 10:14:24 +0000
Message-ID: <0c6e3442-1638-4c81-af9e-977ed913248b@axiado.com>
Date: Tue, 26 May 2026 18:14:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] i2c: cadence: Add support for Axiado AX3000
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org
References: <20260426-axiado-ax3000-cadence-i2c-support-v1-0-0cb9346a7fb5@axiado.com>
Content-Language: en-US
From: Swark Yang <syang@axiado.com>
In-Reply-To: <20260426-axiado-ax3000-cadence-i2c-support-v1-0-0cb9346a7fb5@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To DS5PPFE7B3EE5B6.namprd18.prod.outlook.com
 (2603:10b6:f:fc02::1ca)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFE7B3EE5B6:EE_|CH3PR18MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d50f80-b6b9-4665-b31b-08debb0f8f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|3023799007|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Or5PWQRCa2/nlA5dKzECeCnx9NHuvsSFcyHHJckSn4iEM0EAN4SR2uIgOcr+GXiK4FAWa6oYqozeT009knl3hVt04Z3ZAQYfA0kbU9YL0mF+OisLLr213h138A+lGsEQPkmxIBwRhtCsTZRj6Vnl/FEAJn55yxQWG2yPiUJF3yrti+afY7sC10yGTVkijw8Tnadj8Ysr5MPZzAQ5jBhKkmCCiAgZFo7Ws7lY/NDiv6SYv/Kp+d0Im07Trfr+er5oQ4V8c2lhhDVLNYsy7s8mi6PhsFRZcXIdnaZ/0wCJ2dUj14OaVmTx97hwOZE88ZDtgf15rtICJ5AjRNY7M1pAz2AklVmfIxW1qDncF4RGD+eQaDASw+s40uhHHoJdffK0krYklica454OCX0SKuJD8kHtA7/YmPugLolBue7OERgoaXLt8wWJHzTh1p+35sReyjiQTFxetGIxJmudIKPUqdet6VpT7OWxZBpnBvA1DI4kpY63U8orDJQQ/RzADbIvBP0F15qkJiUdyruvPfdjETRiQ2Nkb6TBu0+Asz2TLOWwINNOdCfrmpQVgiKVB+06NDCcK0sN+H2NgZJCYbuJ+fvNaWjnHWtrTtpMG84J97sZ3dKIDTUZik/JnDefoGZKFRdtiqOP6INMEhzHEqUXDNzhaGoeUZVXBGAsQGjcU4FegxW4gE/HE4CFTy2gGyDd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFE7B3EE5B6.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3023799007)(6133799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW9oRitkTTBFb0sxaHJWMG8vcFFGQTArSmJXd3JKQXdBREVvbEZMS2Q2TGdS?=
 =?utf-8?B?b3ZVdkxrS040dlgxRDU3eXBxaXdYa0FhbUtveU13TUI0ZkR6UEozYUV6OUdG?=
 =?utf-8?B?RVQvSS9tajllaHFiMmo2aC9lUGkvYUZ2TVc5dG03RmJUQ2Y4RlQveXErZENH?=
 =?utf-8?B?YUVETHNOdEhEL2hXRjRhNnhsYUdCQjMra2NKQzdQL28zOEtObTBFWU1wRUt2?=
 =?utf-8?B?bU1TOTZaRE5VT2xiRzBmdjBQRFNNdU50bEFOZHpSbnJPUklCYWc1ZmVrMnNS?=
 =?utf-8?B?OWJXaWRqbngxZ0JUQVJ6QnIzdDI5UTFHWm1JSzljRTlvTGNIeTE1QmJRMS92?=
 =?utf-8?B?OGhzejFtWGdhS2ZxYTNoTHpBUm15RGJiRXhWQTRMYVBHUDlOKzQreitDU2dq?=
 =?utf-8?B?RTIvQUFsRFU5OXFZZEJqSkFZOUdabmJ5Q2ppcVdEY0k0L2RwajJOMlFnc3g3?=
 =?utf-8?B?SFpRdWw4T2RhNHVqKzN3TldIbUMrWU0wN3RkZFVBSnNFWStQOGgzaTRIOWlZ?=
 =?utf-8?B?MFhjNWoxMU91aU5idzZGdjNNWTQvODl0M0gzVVplUEh5ZGhoRXV1T2t3SzBC?=
 =?utf-8?B?OGhHWGhkZnNiNUUzdEpwQmZWT2g3aVV0UVlJaVBZbmM2NEhNRWluTGlwZjhH?=
 =?utf-8?B?Z1JkMkh2a0NyR1ZlREJac21zdW4yMjROaUw0L1dkWDU0ODFPcDBwYlpVWk1G?=
 =?utf-8?B?c0VWZDVsUnBEbWUrcktTSGVyejQ4dWZLY21CVmFBdTZWQmd5aGlSbXdjZVpv?=
 =?utf-8?B?Ui9jWjZ5bkltWEZ4d3RZQ0pjZ3h5RGJKSzltT29NTVFHRWZUTkJzZG1ITjh3?=
 =?utf-8?B?b0JDVGxqNDlVYXBiQWdWeFNLYktGendOSFV3NElMU2xIMWlXcHpMY2JQSDFz?=
 =?utf-8?B?NDZOdVFOUSt3NXlQMmZKODd3Z3hPYnZYdVh2Y1FJZTBtWWVqSWYvRWt5TFYx?=
 =?utf-8?B?MTlJd0YrMFYrc0p1L3lSWUM0Sjg4SkVlNlRRTGdITVV5WldnOUt2WXpCUUxI?=
 =?utf-8?B?ZmF1eHJKN1ppNjJhZU9tbVIvYmFHNjVkcGhxcUE5NVJyYk5yUUJGUTh2REhF?=
 =?utf-8?B?L3k1LzBaK093dHdCZnhwQjRZUHg0SEQvYStyQTltT0hCL0xaSkNhT0R5SUl1?=
 =?utf-8?B?cjhpMk5ZUy9MYW90U2p1K3hMNms3ZEVEVDBYRDFhNXQyMWFXSEhuY3VwSUxE?=
 =?utf-8?B?N3RpeVMzRWV5bVhER3VzL1ZDRGF6b1dJNmkrejFWUGErdS95cHhiUUI5dTl6?=
 =?utf-8?B?Z1V6Tm9jOXp1a1hjUWY5WlA1WDRKL3RQd0s4RmJuYllxMVN6cnhOUkNETWtj?=
 =?utf-8?B?dTVJcjZTVTY2b1U0QXozQjdkWTVFd1FXQ0VZeStLVUs3NWx4YWlGOEEzRWFz?=
 =?utf-8?B?bVFDcmUrYzdpSUUyWmVjTGxjV2tGQkhCb08zNEhQdXlxVW1FS0d4cVJza2xl?=
 =?utf-8?B?RHNwMTdCdG5mNG5ld0VRUVdKNitkQlFNWjVTdjlXZFBzV0ZvUFFCY01YMUFO?=
 =?utf-8?B?em5hdFl4azJqT0lRa2hhS3NHWU5TTDVLNzBXcysyMWJxQlMxN01CWlNqL1dD?=
 =?utf-8?B?dGNZSFRrT3JqcjA4M29hdkFKWS9LNlorS2ozVmNISzJLWjhkci9sSURBcDNQ?=
 =?utf-8?B?cHg4QXRSS2hnZUNleUMyS2dnSnZpc1FuOFp5eHZLWVBuQkNiaVhNZDluaGtD?=
 =?utf-8?B?MW05dGJ2QlhLQ1RtZ0svdDBVdkxPT2d6OWwzZ2w3UEZkamRuWFdJVWdxN1Vk?=
 =?utf-8?B?Z21FOVg4MExwcVhqalovZFZGWFFySlluQjBpdXpLZGJDQ2MrMkNpbUhmanc1?=
 =?utf-8?B?YTZEaGQ4VmZvOHJRTVQ5N1hNOFlLYWRWaElsUURwb2NSby9GS0R6TXc2UmdC?=
 =?utf-8?B?dnFmckw5cEZPQVlBdTFkUExvZThHNFpveWc1K2dRZ1NINU9hN2tMQnNLUEJa?=
 =?utf-8?B?Qk5maG5xd2JKZWNmSWlhTUJLa0ZSME1nUmtPblhBRGNESTl6RnJDWHBSbUJT?=
 =?utf-8?B?Q040cnNMOXhuVjBjbVVyWjcyNGVvK0FRM20zREFwcG5YTlVRc0lYMnFNeGw5?=
 =?utf-8?B?TVlGRnlHMnE4RVBSb1UyRVdob1BPdyt0U252eStwU2JBR2FxMVlRbEZTbTFx?=
 =?utf-8?B?VG9wRGNwREEyVU5RSHRGekk1R0pkQlpoYjR0d3h0WHdsMnBwNjBkcnlETGhy?=
 =?utf-8?B?NWZlSmhBT2txclpmZ1VEYml4NFVhSlhFV1pmc1ErZm1kSkJZTnRtaWxXY0pp?=
 =?utf-8?B?SnQwVDdodSticE9FSUxiSUVnSWIxWXcvYmxPMERwYnR4WG9kd2ZuSC9vUEVX?=
 =?utf-8?B?OHliMk1KeFIzMXNtVVZMaSs0RlVsRjVLbCtPWXRBU05WUHhaVnBhdz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d50f80-b6b9-4665-b31b-08debb0f8f51
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFE7B3EE5B6.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 10:14:24.2953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVQiu/I+HE1OWiOQRtvJ0EAOvlIpiUE1yo4CF9s62k1Acom5k5qSk31CgJfPTwOJFfuidmBmoHIMHh+tm29YQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5746

Hi,

Gentle ping on this patch series.

Patch 1/2 (dt-bindings) has already received an Acked-by from Conor.
I wanted to kindly check if you have any comments or feedback regarding 
the driver changes in Patch 2/2.

Please let me know if any further adjustments are needed.

Best Regards,
Swark


Swark Yang 於 2026/4/27 上午 11:57 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> This patch series adds support for the Cadence I2C controller
> integrated into the Axiado AX3000 SoC and enables SMBus Quick
> command functionality.
>
> The Axiado AX3000 utilizes the Cadence I2C IP core (version r1p14).
> While it is largely compatible with the existing i2c-cadence
> driver logic, the AX3000 hardware specifically supports SMBus Quick
> commands. This feature is currently disabled by default in the
> i2c-cadence driver (masked out from I2C_FUNC_SMBUS_EMUL).
>
> To enable this functionality, this series introduces a new
> platform-specific quirk (CDNS_I2C_QUIRK_SMBUS_QUICK) and uses driver
> match data for the "axiado,ax3000-i2c" compatible string. This allows
> tools like 'i2cdetect' to properly scan the bus using quick write
> commands.
>
> The DT binding update follows the recommended fallback structure,
> referencing the 'cdns,i2c-r1p14' fallback to ensure compatibility with
> older kernels while allowing the new quirk to be enabled on AX3000.
>
> Patch breakdown:
>
> Patch 1: dt-bindings: i2c: cadence: Add Axiado AX3000
> Patch 2: i2c: cadence: Add support for Axiado AX3000
>
> These patches are expected to go via the I2C subsystem tree.
>
> Feedback is welcome.
>
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
> Swark Yang (2):
>        dt-bindings: i2c: cadence: Add Axiado AX3000
>        i2c: cadence: Add support for Axiado AX3000
>
>   Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml | 10 +++++++---
>   drivers/i2c/busses/i2c-cadence.c                          | 10 ++++++++++
>   2 files changed, 17 insertions(+), 3 deletions(-)
> ---
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> change-id: 20260111-axiado-ax3000-cadence-i2c-support-53ec117bb074
>
> Best regards,
> --
> Swark Yang <syang@axiado.com>
>
