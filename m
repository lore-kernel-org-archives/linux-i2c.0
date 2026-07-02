Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5AE385503;
	Thu,  2 Jul 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782974131; cv=fail; b=gF7fI9z1fuAPlnfyLNOuckWA2ZXqNt2fc3eGn6aMTEtxqRizc4crWt5FaJHmCe+f5Lp6m7ZG3y/i+LLbb7Uc8Q6ZTktezS9bKa/yU90pgh3LS46w/CifIT/DGl87D2N5T3B2bI7wTmgO99QNTpQmHCXPqeSzc8oxFqbaJMJZ6ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782974131; c=relaxed/simple;
	bh=TuAPcBbC47EjWj/HXQ99akouYmYWohfg5WXIuyD4gaw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bEpY/TANn5WMf9U38XWmwTDuk7Cxw+JB2CE94dTPAC+HSNp0JlPbWar2gTzu1xjTrawN3Upb/Hq/s8aJ5mmXmmiU4/VeWiEGZdnq4JV8yrLcB3IL2dX4o9ddXHjVQRJiIRsg3VAg8tjfIOZzzgkGnvKY104LutYwQ1Knv3OuLyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xjOrwuzE; arc=fail smtp.client-ip=52.101.52.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xjOrwuzE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyVdLHCpg7A47l29MWDwFJt/aECGT91HIWOeaav+7nEH+lG8NRnVKUP+U9KYNEQ/rsXkYd4Kt6R536RpA/m26YCQ81bex2si2xQvKGAdXCyOCWHCZgFYX4RWgTLZQplnZUfLnsz6DoZDUsTTD6i/IZLfZlo5zgCUHclALWpPZ3YPxSa2mlUSo0uGmF8Gmpmi11H9dTzThZ1Ls1Y3srodvZPKZC5IAwYmy7IHWeBTzzpM9Zknav/Pyn1qTxri955vNkg0vjdfYPQ3eNaF8hlkQKrLwTK6Um+xXpreXSrjFn3aTi8ojzLAi+fku4Pd+wVfVxbNZktlMo1eBgIAZ6XhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw34LNor8ONZekt0ezRs6Us72J60Rz266P3ViTRsnWw=;
 b=oG12s91si7D/S4wmp2Y6F2pvlKZXCsHeSeSB620pPtg/LspPgjDOwrK3HBAeKrswn2Vl3cvuBZ9dG3TMw48v61uXuxFmgbjm7a0IrEnMLIPnwIFCWzIj1IXvIyg/LZL4m/CcHW2tX/rr8umKLxTIaIMGPNkhB3DMlAG1uS158lkQsUY/+KJTWljgQHWBNAPTeKKtM8SVgBHCdL8g7iGrpxStgg1QmbuelRNB15qs5RkaDlNG423gc2n0a9rlF2cYQ30aksoQ6lGBnE3IyVFK7rjrcbUN1KxLwSAs33naMIs/GE7wDfmzG2t0nw0iC0MVxkbUFnhPHMpTFMI5IRQUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw34LNor8ONZekt0ezRs6Us72J60Rz266P3ViTRsnWw=;
 b=xjOrwuzEpJIw9OV4ElOfBYWMuXA76REMA/FtMmSileIn8GGDIkRPADMOUES2INQJVS00aCIEhY7EW9LMplupqP8p74K75Y/MtW7IDvm9U1iHdcZjBXf4hMyRTydmbyp1GSQwqQfIkYYSd8U7RdSbU+v01PEuVzAWGbarFI6PUk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB9729.namprd12.prod.outlook.com (2603:10b6:610:253::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:35:22 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 06:35:22 +0000
Message-ID: <5a1ef110-dbf9-4537-a542-9739a6ab0733@amd.com>
Date: Thu, 2 Jul 2026 08:35:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] i2c: cadence: Add support for Axiado AX3000
To: Swark Yang <syang@axiado.com>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org
References: <20260630-axiado-ax3000-cadence-i2c-support-v3-0-4e217cfe5904@axiado.com>
 <20260630-axiado-ax3000-cadence-i2c-support-v3-2-4e217cfe5904@axiado.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260630-axiado-ax3000-cadence-i2c-support-v3-2-4e217cfe5904@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB9729:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ab2dca-eb17-4537-c8ef-08ded80417f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|11063799006|56012099006|4143699003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	wLiBHebjKHWZTeRZSmlKOPLJzB1SXFwWTp0LP155AM0WNl3UAeYt1bgZ+AlMwcDrs/l7gxjVOfU+5fPBFWrgYGXcB5HrQUTtxl2K8fz854AZMS/A4+1z3eij45gsUwF3C1dPCTMUzDp4mbH6i606GHCqY1RhwmphPhS3+Jf5f0noIquUtGnmA5yM+EKI5VyBMw5UNpUZBf/Ljo2YjRZuitsqn/wmY6AmedXofZsRMuy0o52ulK9duDapU3IF9Jio4WPNaE6X4qITRNIXKaoxFY5wlHX1o3Vcam26OQ41wraekD1j6XOfurQoBHSuhUHFUwWTTmC/eYBGKdd6IjBRaXT47ox3Q+a7oT22fWioCwYTzdvcByyiGm3YltlAtwlzyRVXBRNDG/71s0ejBA9bTLSSGg2k0nQIgpJzRiQ6M6UEOKBlQOiO0CfNmrwBsMKOZUmYKpwIzxunsFwW/LmYrJbqGVr4VFw1vW4IGE3APozxk0CHB1a5AwMU1JnU9J4DJKFowlv+cTDchC9yVIf06zJvi2eKMPr4IEwN141pPd9YiPa6sGrZMmF+27pwJ+eO41Xjo1vZPPlWqN3Mme29nYdsO7+t5BQv4TFuabwABMfzAHmu05TW5ASposDA3aALa1PeCB2n7LlukzbjkOFAPGqy7qfzk4Y1dMBgetAyhp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVdVaDNTZmtzbjFyY3VWWC9aZTNKeW80bWpYUytQWUxLVzBtU1paUXBGeWJ2?=
 =?utf-8?B?ZHNiNnN5TG5LelVCOHdIdEZGa1E3bFhWMXBFQW5YNm1VajRUNENkQVZMVHZr?=
 =?utf-8?B?YTBIcmhtNnFOdnZJaGtmR2RBZ0I2Z1Ziempqby9lSE4zSS9UU1pyZHpYeXVO?=
 =?utf-8?B?YkRHbWJ4VmxwUmJJYk5uL0xrdG1UZjk1Vm42djVvaUdvQzdWckRlRjc3U2RI?=
 =?utf-8?B?cmRVMGdNZTBOcis5TE5VQnJKcVBGclJrQndKazhOSWUwSmtXM01QSmplNndz?=
 =?utf-8?B?T1dmTkdkcVdtUzNGMW40T1JOWTREVnNkVjhqbXdMWU5GZHB2L3B3QzZTTFVQ?=
 =?utf-8?B?ZUNPY1ZqdTRQRnBLVTcxVVBiZXV1QXBhZSs1UWNmZHYvV3BRZGY0RlRIdEtl?=
 =?utf-8?B?YmUrUmhPbEJwOGxzOFNXdzhHWCtKR00wQmhWbVZnK2tGY0s0ai85ZElwVUh3?=
 =?utf-8?B?N3BHaWMrY2I1VlI0cFZrVTIrVVZTVFZQQVVTekJXQlVkZjQ3cUd0cnhqMHpV?=
 =?utf-8?B?NEdIWm1pd282ZVBFMHJOVXhXRUN2Y3N6cXVIMUhjSlhFeUg4Wko5d0FtQnR4?=
 =?utf-8?B?cmlZb2N3d1daN3ZZMUlaeW5pdDFTSnhsYnA1Q1hUMU93Z2x1YTRic1J0Y0pr?=
 =?utf-8?B?NWFuUE5qejQ4b3pGUG5Xc3JmL1h3ekI4ZUl4NTRPWFBTbEJTYXFpNFh3d3pN?=
 =?utf-8?B?Y3VQcHpmTmJQUU9vamdnSmhBbXNKaUpQNklvZHhWOXZvSGFJaFVlS01MVzhT?=
 =?utf-8?B?M1hqWldmQ3YwQlZaUzdPcHg0aEttWGxXRUdmVFRBNVYxQ0x5WmliVnBJOUth?=
 =?utf-8?B?RWxiNUZEZTJrNWlNa2d0ZnoyQ0FpUXRBeTlLYmY4a3EzYkpCZUtVK05TeTV2?=
 =?utf-8?B?WXd0OFdqWk95cEtWSiszM3hQK0NDN1YvYmdSSC9wUmNVMEJtSTd2dTZydjhm?=
 =?utf-8?B?MCs4ODhoS1dsVzErQkJ6azhFZXVNc1VkcEV5ekFvMEV5MEVOWDNCZ25oWEd3?=
 =?utf-8?B?WlcvbGl6dFJYaGkwcldEVEpHOUxZTXlCbkR1dVNzTXV3bHcxZFhteGVhYVBW?=
 =?utf-8?B?bUIrc0cwdWxENkVuZ3JEU2tQcWtGZk44alFINnFoYlV5RU9IRSt3Mm1MTjNi?=
 =?utf-8?B?YXFEL3o3dDRETUZhemQ5QTVUUThkZFowdWEwYTduTThCeUNVU3E2bWcvS1dn?=
 =?utf-8?B?cnZna296dVN4amdjOXJxdS9DTVFzUlNUd2pNdGFXZDlQbUxhM0VwOFpocU5k?=
 =?utf-8?B?QVg5dUpQMkozL0RzV2FhQXg5OVJadC92My9NVXVTblJVdjJQVHBlWU1YRXZE?=
 =?utf-8?B?aTlidUpMUG1KOHVEejY4ZkI3WHU3Y1E0cHl3Z21PMDZmeXVlOGhaOWZCUHg5?=
 =?utf-8?B?RkUvcDBtTDBqWFdkQTBsUktFRHZ2RHh2UU9ZVWtBY2hLeUhRdWczdzNkMjl2?=
 =?utf-8?B?TnFnK21rb0VpWSs0c1FrTC81VkFMVFRPYjJzVmttb0lkclFsOWZDUExvSEht?=
 =?utf-8?B?cHBMOHZRZ1RSMml5a0lKeWREY2k3SDJEcWtwOHJzUG5Qa3N0cmwvU2RQZmNt?=
 =?utf-8?B?Wmx4c3VhUUY3RUdnSEJMTEZXK1ZpOVptSmxIV2xvbHh0dzZxTytPWFQ3KzVv?=
 =?utf-8?B?WUMvbWtFbUtreksvVHJBd1pjdEJORU5YRE9GNFRvNFhxQ3cyZ3dwbUgrT0FN?=
 =?utf-8?B?dGRPc3JSSTFJZGl6U05uWnBmeE5PaHovNTJERnNLWHRtbDVFNG1GM1FwaTFB?=
 =?utf-8?B?R3RqWFQxS2NGOVA0aUgzZ0xBVGRQb3pWRVBXRTkvQUIyckFseFN5UXk2WWZt?=
 =?utf-8?B?cmlLQ3ZuZ1h2a2lFTXBDU2tpTU1XWEVxL2ZEc04xMnJKQ3czYzdWZytuY1h1?=
 =?utf-8?B?RXMvOFZtUk52OUNFR2hhV1dkMEc5UTVzOHkzTDNOc2JTQStLbWxvdFFZSVpS?=
 =?utf-8?B?WmZ3OVk5dktPTFp6T2FTVlZsMEh6aGdtNVlnSHM3SWt1NklkZmd4alNJTkx0?=
 =?utf-8?B?TVlxTUt2c0d2aTZ1Z3dlYmZ1K3kxWmVFd0FsSEFtNjdhaTErRUxkek4vUGVY?=
 =?utf-8?B?VHREVWpTempMUUpEU0liMDBzaHl6bmkrZi9BenprQk5Za0dod0RRd3hIT0hV?=
 =?utf-8?B?TmR5OGk5T1ZxN1BHS3hwRFl3ZTFqSWxUS0lWM253RCtsMnVkYjJYYlNGVGxh?=
 =?utf-8?B?dW5OVzJOSEgzQXJDQTNMUCs4LzJYSXZRZ29vdzlIN0NXb1Q3LzI0UEwxSDg1?=
 =?utf-8?B?ZldTaGVMOHd2cGdwdnhvSVFBUkYvYjNIRXZDK0w4T1JsQytGOVNQeXl1V25Q?=
 =?utf-8?B?WkYxcWZuSkYyZUJVc0lCVFJIZHhlRlMremxkNGRac3RZT0U3S2RtUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ab2dca-eb17-4537-c8ef-08ded80417f2
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 06:35:22.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZJ3et9Cfy0Da/v8tvzl6cC4CZwyufHtgrzdWy+OZ7NUPX5ooTHulvYGhgJwkiyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9729



On 7/1/26 06:48, Swark Yang wrote:
> The Axiado AX3000 SoC integrates a Cadence I2C controller
> that supports SMBus Quick commands.
> 
> Introduce the "axiado,ax3000-i2c" compatible string and
> add a new quirk CDNS_I2C_ENABLE_SMBUS_QUICK to enable
> this functionality. This allows the controller to support
> I2C_FUNC_SMBUS_QUICK, enabling features such as bus scanning
> via quick write commands.
> 
> Additionally, enabling SMBus Quick emulation in the I2C core exposes
> the controller to potential 0-length reads. Because the Cadence IP
> does not natively support 0-length reads (writing 0 to the transfer
> size register leaves the hardware in an unsupported state), this patch
> also populates the adapter quirks with I2C_AQ_NO_ZERO_LEN_READ.

nit: Avoid "this patch". Just use ", populate ..."


> This ensures 0-length reads are safely rejected by the core, preventing
> potential bus hangs.
> 
> Signed-off-by: Swark Yang <syang@axiado.com>
> ---
>   drivers/i2c/busses/i2c-cadence.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index 0fb728ade92e..1964ea1650c5 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -128,6 +128,7 @@
>   #define CDNS_I2C_TIMEOUT_MAX	0xFF
>   
>   #define CDNS_I2C_BROKEN_HOLD_BIT	BIT(0)
> +#define CDNS_I2C_ENABLE_SMBUS_QUICK	BIT(1)
>   #define CDNS_I2C_POLL_US	100000
>   #define CDNS_I2C_POLL_US_ATOMIC	10
>   #define CDNS_I2C_TIMEOUT_US	500000
> @@ -1175,10 +1176,14 @@ static int cdns_i2c_master_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg
>    */
>   static u32 cdns_i2c_func(struct i2c_adapter *adap)
>   {
> +	struct cdns_i2c *id = adap->algo_data;
>   	u32 func = I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR |
>   			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
>   			I2C_FUNC_SMBUS_BLOCK_DATA;
>   
> +	if (id->quirks & CDNS_I2C_ENABLE_SMBUS_QUICK)
> +		func |= I2C_FUNC_SMBUS_QUICK;
> +
>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
>   	func |= I2C_FUNC_SLAVE;
>   #endif
> @@ -1442,9 +1447,24 @@ static const struct cdns_platform_data r1p10_i2c_def = {
>   	.quirks = CDNS_I2C_BROKEN_HOLD_BIT,
>   };
>   
> +static const struct cdns_platform_data ax3000_i2c_def = {
> +	.quirks = CDNS_I2C_ENABLE_SMBUS_QUICK,
> +};
> +
> +/*
> + * The controller does not support zero-length reads. Enabling SMBus Quick
> + * commands would otherwise let the core emulate a Quick read as a zero-length
> + * read message, which writes 0 to the transfer size register and leaves the
> + * hardware in an unsupported state. Reject such transfers in the core.
> + */
> +static const struct i2c_adapter_quirks cdns_i2c_quirks = {
> +	.flags = I2C_AQ_NO_ZERO_LEN_READ,
> +};
> +
>   static const struct of_device_id cdns_i2c_of_match[] = {
>   	{ .compatible = "cdns,i2c-r1p10", .data = &r1p10_i2c_def },
>   	{ .compatible = "cdns,i2c-r1p14",},
> +	{ .compatible = "axiado,ax3000-i2c", .data = &ax3000_i2c_def },
>   	{ /* end of table */ }
>   };
>   MODULE_DEVICE_TABLE(of, cdns_i2c_of_match);
> @@ -1510,6 +1530,9 @@ static int cdns_i2c_probe(struct platform_device *pdev)
>   		id->quirks = data->quirks;
>   	}
>   
> +	if (id->quirks & CDNS_I2C_ENABLE_SMBUS_QUICK)
> +		id->adap.quirks = &cdns_i2c_quirks;
> +
>   	id->rinfo.pinctrl = devm_pinctrl_get(&pdev->dev);
>   	if (IS_ERR(id->rinfo.pinctrl)) {
>   		int err = PTR_ERR(id->rinfo.pinctrl);
> 

Wiring looks good to me.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
