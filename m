Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010072.outbound.protection.outlook.com [52.103.72.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546D23ABA7
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717012; cv=fail; b=joMxnCBg1zmu9fhxsnpByrry9JuWZ1+8VRnl7XCIOdoDqwYbLBkPB0PFrtXc0+gzpoWYvPFVp8YayLHJ4zPmW0vZD3rzS2hSDi2daDAH/Ww7SmnWR5eliKBODvkG/IKr0DHBRM124ptBUKZm0o1KBfv8jgHf3IztqdVTF7U1TCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717012; c=relaxed/simple;
	bh=qSIk7R74EbNhCOzOXUF/HsVsbpwNnnRdRzC60p5s0+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNQ0+h25KhLtR9v2pygH2XMlOJqFy/H/iKkuimkFvhFfC0zeltRRGmZ+Q09+xzh2crEWPlDpoEQQMKOjxsz1zHnk4uChGlSX8+RSwNT5B58q914O3XMWgbURfcp1qj36Ww2vhSM9onOW26voy172GrsO3GhdCZ3uqCoVl2R4HP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=Kt5e7QQx; arc=fail smtp.client-ip=52.103.72.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="Kt5e7QQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUttDAQIWTCWeTP8GFDr+RbDGBO+LjrPeKz/I2felSQDTdmoB2dJX+f7ZBp7iIE4vBdcNW1MO1VGiCUDhKTAiUrG7tSNaVaapoF5V+twyiqz0XgL4MUkeziGmYO3JMuP50zFEPoEkJdTVARZdGN1Fuvvpv7XDyv0nLlIB7I3AuunWR8glNPsw/uXySUO2GzW5ZpWiFkF7z9LQQGS8ApOG6oMZZG44RDnRM1DFBFZ1VrqTD1rRs6fO1A4NUwg531yfOOwg4/xLsEL3g34EltLkYxdLqRmlpPq8iicPaRJjkaNiZR4EX5ir+ldzYUGvrfhqtILtokTbcvPnp8kn0DQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSIk7R74EbNhCOzOXUF/HsVsbpwNnnRdRzC60p5s0+s=;
 b=M3QBtTHAAuxNAgSA2VUbyXZkzDL7hrIk2yxGtvkwqusxZAH0SSdJGPlcZ1mK/k7ydsdctPHFT1hWgGDjjN1b0qpICDo8u4lXPV8dtzn6AKj8Jg8spCZhnKPMkuebbS+WH7Pjshwm5RYSBcLJzYqlHhCNY9yYneeAhZPwm9bz1H9XkvGgv8u3a5ByroUuHxjdL4tuQWgA0j+NA88DfXSIhi2bF4tVw8mOJpqormwW5ZZFhrP7jo4oeSxBblLXgG52YtAPF4P/RJ3yo/WMIWucKOqQdC9H08sUYvvAW2htfmUlXuBF9u/x7cjl1qNLaAGtT1Uo7UrutAF7Vrm+jBYggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSIk7R74EbNhCOzOXUF/HsVsbpwNnnRdRzC60p5s0+s=;
 b=Kt5e7QQxnrAH6FR0YHepDti/xqoI7hG+0wXpfzCRHmlsNj9OV+pcb8WXJtoeZ0z7N7/6/iMPylmA6Qh40l4D40yLSzpmetQklrE9k+Eybz6LHHnHEvaBN0x0Nd9qMffFvVfMvznaMd2IyfknYQMLqbCT5BcQwhO6QDOOYFX8jA3/7G/MUlq7+7EUirUc5y1fo15hWpkeo71XvudCHLr5TORdV0wcJMM7nxFGlf78+5Jug0no3yotMs4IzYTC+cwHRshgZFdFJ5aQgNy29+9U4lpatTP9R2y59xsn1wMA0PISIRXObY9vqQdAn0/3hlH1KPkfdTcaC7igHLMF3psG6g==
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com (2603:10c6:10:59::12)
 by SY4PR01MB7169.ausprd01.prod.outlook.com (2603:10c6:10:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:10:06 +0000
Received: from SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957]) by SYBPR01MB4586.ausprd01.prod.outlook.com
 ([fe80::57d:8fd6:3940:5957%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:10:06 +0000
From: Stephen Horvath <s.horvath@outlook.com.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare
	<jdelvare@suse.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC: Stephen Horvath <s.horvath@outlook.com.au>, Guenter Roeck
	<linux@roeck-us.net>, Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: [PATCH i2c-tools v3 1/8] decode-dimms: Implement DDR5 checksum
 parsing
Thread-Topic: [PATCH i2c-tools v3 1/8] decode-dimms: Implement DDR5 checksum
 parsing
Thread-Index: AQHdB5ZQy9pnJNDtgkO9HiRupf8vgA==
Date: Mon, 29 Jun 2026 07:10:06 +0000
Message-ID: <20260629-ddr5-v3-1-07f45075a51a@outlook.com.au>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
In-Reply-To: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB4586:EE_|SY4PR01MB7169:EE_
x-ms-office365-filtering-correlation-id: b1986761-8fe4-414a-868e-08ded5ad729a
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd/ur0QDa6YmBjuOVf78JKonm7yfLSHwSgIo91A4K2A+06mbDtYvImIxTB76sWtlpOhCZ0hkbv6LwyJ303J1CpXX2zqLrAIGyYbOioXVCvVzwA/6yUUKSSHd6p6kqDCGE0gYWFPG3HzrBEdrzorYqS6C6IJlsQjFZ4MqrTpQakJu7OHZgAnMHWPXTJDnYP9HOO9aLTUpL1UxqqiIoRJz41XGjHe7HppYnhD9+83/ZocOUp9QUL0VlVp+98rac/3A9uoAxUtWnfP+YhpK/ayg/r8syS0QF5+gbMEVIoHuqjFySxLB/TvgvA02vPqBrnz+oU5xo5uMHfa7JrGDusyF9Yfe1yGennCYx/ZNLR22/46qa1BPPmGg99r86odHV+8K6+IxRGnrM9+zhwRjIpDY5EKQXKhWBGSEDFucp45qlpyGuB+EdKuidvYYiTagn/2ChCENMQeSXPi6tNVkJJ8g8j2TUPCjLSIg2C82Gllnu5OZFapxQEqZdYNs1ZQqmV32+cCfjCiUAj115ZycAHj0N5E5uD7icQJnfnMrAx1DmQn7TQbNeWsrF75nC3z4Azge3HYXu6G6WX0NXwMrmB8T5NuhAUPDJZfK1SkV01u0f1j7iAwwmv5q6dq+3HvwlO03z4UXwnMo/8Xo64LO5YOLhR45WW5iiX+Vq7o4PIVN/FWQslGyaOCd5ve6TMhhHtEsK+ceRN2owwZWMMGLwlzPSoea8v3KI9wrwBhe4dhxT8PEkpcPU1O+t0KRsm/dAAO18a17mHH0oLDTz7Dxupi8lQHJGQJKBdr4YuvrRC6lZWKSXQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|24021099003|31061999003|8060799015|51005399006|41001999006|15080799012|19110799012|38102599003|12121999013|37011999003|25010399006|10035399007|40105399003|1602099012|4302099013|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHg4SHdBOElnYkFzVm5yajFJaXZTd1pkamlBcmpsZjFhTzVRWXlnZWRyQUtI?=
 =?utf-8?B?dGh2LzRSMnpPTEVROTRucDNJYjRXMUZUUTJIbDZBNHYybTVkekFQQzcxQmJi?=
 =?utf-8?B?Z05NZi81UDYzQzc0eUxnVEFIdFE3NzJySVJ5MTByS3g3VzM4OXFvNDBVUDNX?=
 =?utf-8?B?V0k0ak1Ld0V2WGptUXB4emEvU1RkOVZTSlNzZXZCbkdwekhQU3R5ZS9ibHM4?=
 =?utf-8?B?UytEamZzZFh1bERQdW14c3hDNEZXWFpzNHdHaVdXdUNKNVlSZ0gxb09tTHFE?=
 =?utf-8?B?VkZKdmExR1RqYzNyN0hwQ203WEF3d2I4aXRLUU9ucHMrRVpMUzFiUHEvY3pz?=
 =?utf-8?B?Zk93QVpiTVVFYmdrSFFndHBsUWwvTzlEamxQUjRuMjJlWWREMmVCMDZwWVp6?=
 =?utf-8?B?UnV1SzJBOTVCSTd4ckVqNDh6WGxjOHZxVTlheHc2RHQ5V1U2OFBOcUVuczFM?=
 =?utf-8?B?ZmdIU3dUNndia1VVbGlOc3d4MTVaY2p5VlQ1RHJxekNFRWE3M0EwV25lbnc4?=
 =?utf-8?B?NEJVY20wMFpUaWxXZFljU3lIT1B1bGRPc2lYZWs4WmVHS0ZrSGtvQ0QveVAr?=
 =?utf-8?B?V1VOUklzUGliM29MeHVrZlpYaGR2aUcxbXVmTXZrVUNkRlRFcEpYYWpQUTJN?=
 =?utf-8?B?U2NwenFTTjE5MG0rQWcvbjVCY3U3cHlTMnR3QlZ6RlNXRytRSVFWazMrZERm?=
 =?utf-8?B?alAzRFdCNnNtb1NUajFsTTJxVTU3Qk9JNTg4cXJhdVpKQ0pLTDhJWDZwOHh6?=
 =?utf-8?B?M3M4VnpsMVNoU3JJSmcyYlQ2WTRUMFlObnNSRG05VFo3UTJMVEFoK29iUjU5?=
 =?utf-8?B?cTZpQXg0czZtem5vZ2JjL09uMzVCR1dJSGh3YjVxTklrVGR5ZzZlK0xwak4v?=
 =?utf-8?B?V0lFdWNaZElydFJSTTNJUVBTRUc0LzBpZXllR0ZCOHFNSDA0cTdRdUY2eWho?=
 =?utf-8?B?aHQ0cGNWZUVCdEVZSStpU0JCdmdad004NGJRY1dOa2I2U3hpci9rQWVIbmV1?=
 =?utf-8?B?RklxbzhGSWY0T09MdjZ2Q1J4VkRHWW1QeXUzc0h1L3U2S21ja2F5bmk3aHBk?=
 =?utf-8?B?bFMzVW9pYklwWHJ5UFFNcG5MUjVIMC9lYmpGOEg2Nml6Z1k5U0tiQ3VSSUZN?=
 =?utf-8?B?c2Q3bVI0S1ovZ2VEK3dFNmdtYTRaNkxHWmVZNGVRUlYwMHdmdkVBTkhtRXg2?=
 =?utf-8?B?RlhlVWVBaU1KY0plT25SZVg3R2FDTHJDU0NjajdzWUlOR2FtWXFDUFJoeEZ5?=
 =?utf-8?B?aU5aRUVJWGFsMlYwdUsxTWlyRW9vaXlXaGZ5ME1nWlJ6L0U4OHFlcVl6MGNI?=
 =?utf-8?B?ZHBCWTUrTjZUZlN3MElITTRYZWhxMUxlSnRyZTFuSDVwb0VCaFY1YXU0UHAz?=
 =?utf-8?B?LzFFOXVISy9HKzVsMXhMM05pM0RHc1F4SitYTi9MRVhGa3VYZEJRYjBOK0xU?=
 =?utf-8?B?RjJGMHZiUFFhS2JXdlNVOUVnYXhpajRxN09ObkszYXl2S1krSUY5N1E1R2sz?=
 =?utf-8?B?eEQwaGM5M1BFaUlIR3V1MTFsdkxFSHVmQ0NMQWk1N0FkTkNoODVTZTM3YjBT?=
 =?utf-8?Q?caVOalOLsIWlS6GT1ASMdY+TUYAKii0NJsCPIVZiB2JNux?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REJka2ppZis1NW1KRkUvQ0tXNlJBY0lUL0tEdWZadHpIYTljODFmV2Vab0lX?=
 =?utf-8?B?TS8vWStYN005NTBKeTlIVzhIV0M4RkZCS0UwaEJsUkRKR1czcFBhMDBZbHFz?=
 =?utf-8?B?ajFlbURRMlRBUWdjMG9hNDg0RjhITkExbkFZMERxbG1GcnhjR0NBOStqSWUv?=
 =?utf-8?B?b3pkZzFLTjAwQzFrNXBIdkg2blVEVW44RmxMcmxUN3FhNTFDV3RjaWdMVTEw?=
 =?utf-8?B?ZEtyUkJzQnJnUUZRaE1vY1E5dkZjUTJBTWd6Wlp0WVh6emsxc0g0NHI0WE16?=
 =?utf-8?B?dnN0SGk4L2VWam1SbFNBZy9tZTllTzdtWHhxZXU5T3VTSnNCWGxMZUthWlE3?=
 =?utf-8?B?dTdRY0xjRkNXQTlQNmhSMHJPOThkV2FjMWcwclRMcWRqYmJwUzNYK0ZCbkxD?=
 =?utf-8?B?SWhOdlhyQlphZGtHRHEvV3p0SndONTdvV0RsbDdyYitqeDdVdi9RVEtsVHpR?=
 =?utf-8?B?eHVBSWV2S0RyK3FqWk9mQW1DbHFwZEIxdGVwRlo3VEJHb3Fwb0FGSnRTYTFB?=
 =?utf-8?B?VmQ1OGI5NEp3VkQwQVQ3aVQwUmFQblZkQW5VMVU0MUlSdjZLQXRxQWdUcVRI?=
 =?utf-8?B?YWxub3NOZ0p3NmV1TFQ4LzF0M2FtYjBuamEwbVQxcldOQ1V3M29NQ2JMUWdk?=
 =?utf-8?B?b3hjaWpGSHc0Y1BEb0dWZFdIalp1bWNQVWI0NFVvM2V4akEreXhuckNvTnA4?=
 =?utf-8?B?c2NPaWJaS080SG84OTJoZFRtRnBwOUtGKzdDNVhNWFQ4M3N0VG1lTnJxQWdT?=
 =?utf-8?B?bTBGdFpBaVJwNXJib0tNQnZoQkpnSUM1T2NlajV0blgrYmZOK3BoZ3BiTXZS?=
 =?utf-8?B?cHJQY0Z0dXlEenNZV2xuTE9xd2JLb1hEM2IzZmJ0MFlMYzdhcGttczJFZ1lv?=
 =?utf-8?B?QUVvMVhwSEwwMmhpWFM0NlIxL1YreGdaSDZ4QXd0aC9hNjBMN21Nem9HdXFQ?=
 =?utf-8?B?K3lGTDM3a2piUHhvYjNvTmFZa1NJTjhOZjZPbFRrRnpMMkpjclBaM1lFZ2tD?=
 =?utf-8?B?dC9uYzBKWTJHSGU4TVE2WGplVHc5SXJiVFV3VjVrTGpCVUtaQ2tMdkFhbmkw?=
 =?utf-8?B?SlFOblRTelE0VXl5ZmdjZStXWDM1NVh0cTVWVW96T2lVdU1pbEFuZkJtQXdE?=
 =?utf-8?B?aXFPeDViYUplZUpVUEF0cFZwMWJqWkRwc0hZb1IxNHdpZ1hvM3RPZEc0dzV3?=
 =?utf-8?B?OEVoMms1MUMzaFU3UmtoK0dKeDRCNTJoSmg2cFFRTHljeGhqWkd3WkhrWTBY?=
 =?utf-8?B?MCsxZzYxcXhZL2JtMGJGbTk0MmxOdllPSTBxendoNi9yTGlhdnRjQUVxNmtp?=
 =?utf-8?B?V0Z3V3MyYWkvTzd5dWxuaWswK3RZcXAxMHN6U0RiVlVHbUtSL25QeThnUDk3?=
 =?utf-8?B?MVAxbndpK3JGY2FuMytIaG1tU0ppTi9PVHA2Zy9xKzYybnFNYmQxUDZIMGFs?=
 =?utf-8?B?aVJneSttbGttOFYrTnJHZ0JkcU5vNGtkVExhbmJmcXRCS1RNVVlaaGhUZSs1?=
 =?utf-8?B?OFVDVG5iTUVzd0tEd2xZMUEva1UzZ0JlWEJaVExXakVoNUFtcWY0U2tZcXV5?=
 =?utf-8?B?eURlblgvQjN4Ris0RGhOOXVMRjBYRVZwaHBtcVovYklKZXVGdW1EeXBPL3Q4?=
 =?utf-8?B?UmQwUEg2bW9scGFEazhRYmF6cmpJV0cyUUJIZjRlMmo0dFRHTFR2dlJTQnNr?=
 =?utf-8?B?MU8rQ2wxeDNJUnpBRSswakZTQjhZNXFxWXYrblBZSUNMWXhhVG1QbEZ5T3Yx?=
 =?utf-8?B?elN0YlVZdm1jckE2SVBOVGFsK1R4TGllZ3dBSFJWbFZLREdCaEtNYzllRTRj?=
 =?utf-8?B?WUdmU0l3ek5YeE56QWI1bGVVQnNyQmJOYzhDd0QrSFB0RlFDYWJvb0Fta1V5?=
 =?utf-8?Q?2j/eOzgK6rGMF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AF98C2A09EC1940AC54699FC4911B13@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-feddd.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB4586.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b1986761-8fe4-414a-868e-08ded5ad729a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 07:10:06.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB7169

VGhlIENSQyBmb3IgdGhlIEREUjUgU1BEIGlzIGxvY2F0ZWQgYXQgYnl0ZXMgNTEwLTUxMSBvZiB0
aGUgU1BEIGRhdGEuClRoZXJlIGlzIG5vdyBmdW5jdGlvbmFsaXR5IHRvIHJlYWQgdXB0byBieXRl
IDUxMiBhbmQgY2FsY3VsYXRlIHRoZSBDUkMxNgppZiBieXRlIDIgaW5kaWNhdGVzIEREUjUgbWVt
b3J5IGFuZCBieXRlIDAgaW5kaWNhdGVzIGF0IGxlYXN0IDUxMiBieXRlcy4KClRoaXMgcGF0Y2gg
aXMgYmFzZWQgb2ZmIG9mIGEgcGF0Y2ggYnkgR3VlbnRlciBSb2VjaywgbGlua2VkIGJlbG93LgoK
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaHdtb24vZWZiNzdiMzctMzBlNS00
OGE4LWI0YWYtZWI5OTk1YTI4ODJiQHJvZWNrLXVzLm5ldC8KQ2M6IEd1ZW50ZXIgUm9lY2sgPGxp
bnV4QHJvZWNrLXVzLm5ldD4KU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIb3J2YXRoIDxzLmhvcnZh
dGhAb3V0bG9vay5jb20uYXU+Ci0tLQogZWVwcm9tL2RlY29kZS1kaW1tcyB8IDMyICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9lZXByb20vZGVjb2RlLWRpbW1zIGIvZWVw
cm9tL2RlY29kZS1kaW1tcwppbmRleCA3NjgyMzQ1Li5kNjk0ZjQxIDEwMDc1NQotLS0gYS9lZXBy
b20vZGVjb2RlLWRpbW1zCisrKyBiL2VlcHJvbS9kZWNvZGUtZGltbXMKQEAgLTIyLDcgKzIyLDgg
QEAKICMgdGhlIGxlZ2FjeSBlZXByb20gZHJpdmVyIChpbiB0aGUga2VybmVsIHRyZWUgc2luY2Ug
djIuNi4wKS4gRm9yIGtlcm5lbHMKICMgb2xkZXIgdGhhbiAyLjYuMCwgdGhlIGVlcHJvbSBkcml2
ZXIgY2FuIGJlIGZvdW5kIGluIHRoZSBsbS1zZW5zb3JzIDIKICMgcGFja2FnZS4gRm9yIEREUjQs
IHlvdSBuZWVkIHRoZSBlZTEwMDQgZHJpdmVyIChpbiB0aGUga2VybmVsIHRyZWUgc2luY2UKLSMg
a2VybmVsIHY0LjIwKS4KKyMga2VybmVsIHY0LjIwKS4gRm9yIEREUjUsIHlvdSBuZWVkIHRoZSBz
cGQ1MTE4IGRyaXZlciAoaW4gdGhlIGtlcm5lbCB0cmVlCisjIHNpbmNlIHY2LjExKS4KICMKICMg
UmVmZXJlbmNlczoKICMgUEMgU0RSQU0gU2VyaWFsIFByZXNlbmNlCkBAIC0yNDAyLDcgKzI0MDMs
MTIgQEAgc3ViIHNwZF9zaXplcygkKQogCW15ICRieXRlcyA9IHNoaWZ0OwogCW15ICR0eXBlID0g
JGJ5dGVzLT5bMl07CiAKLQlpZiAoJHR5cGUgPT0gMTIgfHwgJHR5cGUgPT0gMTQgfHwgJHR5cGUg
PT0gMTYgfHwgJHR5cGUgPT0gMTcpIHsKKwlpZiAoJHR5cGUgPT0gMTggfHwgJHR5cGUgPT0gMTkg
fHwgJHR5cGUgPT0gMjAgfHwgJHR5cGUgPT0gMjEpIHsKKwkJIyBERFI1CisJCW15ICRzcGRfbGVu
ID0gMjU2ICogKCgoJGJ5dGVzLT5bMF0gPj4gNCkgJiA3KSArIDEpOworCQlteSAkdXNlZCA9ICRz
cGRfbGVuOworCQlyZXR1cm4gKCRzcGRfbGVuLCAkdXNlZCk7CisJfSBlbHNpZiAoJHR5cGUgPT0g
MTIgfHwgJHR5cGUgPT0gMTQgfHwgJHR5cGUgPT0gMTYgfHwgJHR5cGUgPT0gMTcpIHsKIAkJIyBE
RFI0CiAJCW15ICRzcGRfbGVuID0gMjU2ICogKCgkYnl0ZXMtPlswXSA+PiA0KSAmIDcpOwogCQlt
eSAkdXNlZCA9IDEyOCAqICgkYnl0ZXMtPlswXSAmIDE1KTsKQEAgLTI1MTEsMTAgKzI1MTcsMTYg
QEAgc3ViIGNhbGN1bGF0ZV9jcmMoJCQkKQogc3ViIGNoZWNrX2NyYygkKQogewogCW15ICRieXRl
cyA9IHNoaWZ0OworCW15ICRpc19kZHI1ID0gKCRieXRlcy0+WzBdICYgMHg3MCkgPT0gMHgzMDsK
IAlteSAkY3JjX2NvdmVyID0gJGJ5dGVzLT5bMF0gJiAweDgwID8gMTE2IDogMTI1OworCW15ICRj
cmNfc3RhcnQgPSAxMjY7CisJaWYgKCRpc19kZHI1KSB7CisJICAgICRjcmNfY292ZXIgPSA1MDk7
CisJICAgICRjcmNfc3RhcnQgPSA1MTA7CisJfQogCW15ICRjcmMgPSBjYWxjdWxhdGVfY3JjKCRi
eXRlcywgMCwgJGNyY19jb3ZlciArIDEpOwogCi0JbXkgJGRpbW1fY3JjID0gKCRieXRlcy0+WzEy
N10gPDwgOCkgfCAkYnl0ZXMtPlsxMjZdOworCW15ICRkaW1tX2NyYyA9ICgkYnl0ZXMtPlskY3Jj
X3N0YXJ0ICsgMV0gPDwgOCkgfCAkYnl0ZXMtPlskY3JjX3N0YXJ0XTsKIAlyZXR1cm4gKCJFRVBS
T00gQ1JDIG9mIGJ5dGVzIDAtJGNyY19jb3ZlciIsCiAJCSgkZGltbV9jcmMgPT0gJGNyYykgPyAx
IDogMCwKIAkJc3ByaW50ZigiMHglMDRYIiwgJGRpbW1fY3JjKSwKQEAgLTI2MTcsNyArMjYyOSw4
IEBAIHN1YiBnZXRfZGltbV9saXN0CiAJaWYgKCR1c2Vfc3lzZnMpIHsKIAkJQGRyaXZlcnMgPSAo
J2VlcHJvbScsCiAJCQkgICAgJ2F0MjQnLAotCQkJICAgICdlZTEwMDQnKTsJIyBERFI0CisJCQkg
ICAgJ2VlMTAwNCcsCSMgRERSNAorCQkJICAgICdzcGQ1MTE4Jyk7CSMgRERSNQogCX0gZWxzZSB7
CiAJCUBkcml2ZXJzID0gKCdlZXByb20nKTsKIAkJJGRpciA9ICcvcHJvYy9zeXMvZGV2L3NlbnNv
cnMnOwpAQCAtMjY0Miw3ICsyNjU1LDggQEAgc3ViIGdldF9kaW1tX2xpc3QKIAkJCQluZXh0IHVu
bGVzcyBkZWZpbmVkICRhdHRyICYmCiAJCQkJCSAgICAoJGF0dHIgZXEgImVlcHJvbSIgfHwKIAkJ
CQkJICAgICAkYXR0ciBlcSAic3BkIiB8fAotCQkJCQkgICAgICRhdHRyIGVxICJlZTEwMDQiKTsJ
IyBERFI0CisJCQkJCSAgICAgJGF0dHIgZXEgImVlMTAwNCIgfHwJIyBERFI0CisJCQkJCSAgICAg
JGF0dHIgZXEgInNwZDUxMTgiKTsJIyBERFI1CiAJCQl9IGVsc2UgewogCQkJCW5leHQgdW5sZXNz
ICRmaWxlID1+IC9eZWVwcm9tLS87CiAJCQl9CkBAIC0yNjU0LDcgKzI2NjgsNyBAQCBzdWIgZ2V0
X2RpbW1fbGlzdAogCX0KIAogCWlmICghJG9wZW5lZCkgewotCQlwcmludCBTVERFUlIgIk5vIEVF
UFJPTSBmb3VuZCwgdHJ5IGxvYWRpbmcgdGhlIGVlcHJvbSwgYXQyNCBvciBlZTEwMDQgbW9kdWxl
XG4iOworCQlwcmludCBTVERFUlIgIk5vIEVFUFJPTSBmb3VuZCwgdHJ5IGxvYWRpbmcgdGhlIGVl
cHJvbSwgYXQyNCwgZWUxMDA0IG9yIHNwZDUxMTggbW9kdWxlXG4iOwogCQlleGl0OwogCX0KIApA
QCAtMjY4NCw2ICsyNjk4LDEyIEBAIGZvciBteSAkaSAoMCAuLiAkI2RpbW0pIHsKIAkJICRkaW1t
WyRpXS0+e2Noa19zcGR9LCAkZGltbVskaV0tPntjaGtfY2FsY30pID0KIAkJCWNoZWNrc3VtKFxA
Ynl0ZXMpOwogCX0gZWxzZSB7CisKKwkJIyBDaGVjayBmb3IgRERSNSBwcm90b2NvbCB0eXBlIDE4
LCAxOSwgMjAsIDIxIGFuZCBzaXplID49IDUxMgorCQlpZiAoJGJ5dGVzWzJdID49IDE4ICYmICRi
eXRlc1syXSA8PSAyMSAmJiAoJGJ5dGVzWzBdICYgMHg3MCkgPj0gMHgzMCkgeworCQkJIyBERFI1
J3MgY2hlY2tzdW0gaXMgYXQgNTEwLTUxMQorCQkJcHVzaChAYnl0ZXMsIHJlYWRzcGQoQGJ5dGVz
LCA1MTIsICRkaW1tWyRpXS0+e2ZpbGV9KSk7CisJCX0KIAkJKCRkaW1tWyRpXS0+e2Noa19sYWJl
bH0sICRkaW1tWyRpXS0+e2Noa192YWxpZH0sCiAJCSAkZGltbVskaV0tPntjaGtfc3BkfSwgJGRp
bW1bJGldLT57Y2hrX2NhbGN9KSA9CiAJCQljaGVja19jcmMoXEBieXRlcyk7CgotLSAKMi41My4w
Cgo=
