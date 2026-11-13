Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794580839;
	b=N5GXQAuSvRXesOCZ37DD62JFkx8dqhMbQi+K5esMvPTbGxnlY7QG0QS76fPAh7GDXg2Z
	 j+MmSIbWFQdhP4sDuBOFN4X2oHVHHpG+vZ/WiVdzapPc2IEeZw8c42Sv4V1GPZOBxD5SK
	 VOJi6U3Ett5erwD1Npvo8GDVw2NUn67wpFmakV28T3M7a9oN0lp5UN9GJoibPn83FmT+R
	 2Pg1S2DwJh7YAGU5zPNDSDm7dDfS+yVcO6ePJVbVJxU53TRZ0S4NNstsDt8aqqtFMw9fy
	 bGN4BTkZ8narDftL9cuH1P8Cg3eQrAngBeba94+h7rLO4tmBpUd/QNIGK61M3K7BiTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580839;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eq5OwmqhkuLkhvdkwHCjLcijcGt7RCkLHTCYmaQVsr0=;
	b=h3w3KP3yxz25nyia5s7l4x6x0wA05mdwnTn19HFsW2qQ1J89yIuFoQ35YZ6KirjrXk/m
	 AY6rQvhiJS2CM+YtMUKsl6r9waA/yx+yguHmSlfE/j/9wK0aNA/tcJEfAHE6lJeYGRgWS
	 VwIU2CWi7MKvpjLJzEIYDQM86rWbaFnuaQocf725tU+8FJ0DwrRDGZ0BYFJxB20Jw1W7k
	 grNxiDyxSXG8+qr01SQyJoidzT3pKr+1A2wmTEuGvNDNxcN0kiLSCDTsYoC30H4ThjWZV
	 DlxLlhK5fpOmwvjar1qxEjigyPOhl6gbgSc4F5bfB4tS276K4UKXaaHljf2pEzhtZUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Sx3Dxjn7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.43.33
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011033.outbound.protection.outlook.com [52.103.43.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D9606A331;
	Fri, 13 Nov 2026 14:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C84D9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Sx3Dxjn7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+S9bBdRervQJvQHRdLPyZezmiQdeX1Jf0BnlnqUicFkk8d6IsagElR1C/MVm6z05ZLCa/fxWBRD35mXlfUuTVVtJp1v1tKrSSyHTMKtubIfw2QOL10RbyeFQwcX5y6aOE4LGM7Ir0n7D5e3ThmoLQ7SulO7gxeYIN/tljGsEkMHO83reQD6r9OQM1SmrfhQTLiZ4TR9D5d+4bRKTHRkumtGfbnQXP/VLLzQ25m22Tk2zo7hR/PfsWgOB3Hd9HWvIl7ePz562Ka9LsL3b3BIgy9Vjl41m3mzV/D3fB2OFdUQzSIltYn5cuQ7rGTY3BWstBpzyMcuK0Y5GJFntpFXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq5OwmqhkuLkhvdkwHCjLcijcGt7RCkLHTCYmaQVsr0=;
 b=XzaYy957qlLaK2KBZ7ynSZPQC5Ukt8z49s2rEReLf03G8pq0ApFFfiOja+SS3gDlrpvH8dhLZZ3QF9EUNb7Xn27pv8AnpSfeIH/3wOYo9IowyjA5jDNHHsCkyoUE/QpGAaOUG5xxgE2Ae14HiDobGejhjpCGmZPx46wpfE4BXGjPOZ/IVTx9d0aOjDX0LyVbqjKqMRFKywiTpnLfA3pJOYaXL2CJjDZkr9gk6PhTRS1nrWXj9yloj49kCkLonb3pDFpir3WVe4AtD7Jo0paU0yf7IK2OBOWR2LIwgs9lURWakZcNrkVQK3KjdaeXZJgBa1M7f5Eh/NM9eQGMI8o/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq5OwmqhkuLkhvdkwHCjLcijcGt7RCkLHTCYmaQVsr0=;
 b=Sx3Dxjn7fk4Mr94uNELbGc7Jr9JWjywkSpOETL+5leUyaopyTab4uLLfAcDEaXhJ3S0uMqvLTxlyylyD8+lw7DgM1Kg+JL/UEplrIUEaxQA3RXQA+LnPZ/EtAfkgojIkcBUE51WJySc++t87bkKoGqO6+Ch6C/Q0sn331JNM4J5DW9QbGtRaWH872FbL4Qjk2vdQDrhWNZ+S4p4G2ZgnXzwk3SJlZyPy7Yztl8jyNK/w28NwNdf9fIOtVB1cPY+tT6hdGQXHpfEi2SJSaw+aijGAhMvDRnyBma1Thr/mo/0BXSRbPVRybXI1x4OHWzYBzFZvpRCWMA883uBTThxSLw==
Received: from TY7PR01MB804852.jpnprd01.prod.outlook.com
 (2603:1096:403:403::19) by OSZPR01MB8169.jpnprd01.prod.outlook.com
 (2603:1096:604:164::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:40:34 +0000
Received: from TY7PR01MB804852.jpnprd01.prod.outlook.com
 ([fe80::4c0d:ea93:5322:ee61]) by TY7PR01MB804852.jpnprd01.prod.outlook.com
 ([fe80::4c0d:ea93:5322:ee61%3]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 14:40:34 +0000
From: Zou Jianqiang <jq.zou@outlook.com>
To: Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>
CC: "byu@xidian.edu.cn" <byu@xidian.edu.cn>, "25181214217@stu.xidian.edu.cn"
	<25181214217@stu.xidian.edu.cn>, "linux-i2c@vger.kernel.org"
	<linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c: i801: clear the byte-by-byte buffer pointer before IRQ
 sync
Thread-Topic: [PATCH] i2c: i801: clear the byte-by-byte buffer pointer before
 IRQ sync
Thread-Index: AQHdc3zwC0OsoW6G9UivINYd0mra4g==
Date: Fri, 13 Nov 2026 14:40:33 +0000
Message-ID: <20261113144030.32129-1-jq.zou@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB804852:EE_|OSZPR01MB8169:EE_
x-ms-office365-filtering-correlation-id: 5879b070-52f6-4776-bc36-08df41941305
x-ms-exchange-slblob-mailprops:
 9IecXKUgicApcBHgIkF1u3SRiU/lhwt0bi6ciF2VavjazKcnMOlwqyrH+UZaZaOJ5kdS1WvGmWq0sC7A7oH1L8IMbe+Gt4400NczI7i/a3JAZdv19yd56F/pUcZJUlk+l9tRHYkw8l+UdG3uetCaTLv0SZ73gRZq/hsz1lN03e0LX1+XvujJKB6YuKyjLPOFtNn1XicrlojOj9yBGZ/ip4DmWjKP+VOebfJ8u4/nSevSfh3cJysOBu0gk3K7hz1xs3tpAPBrYp9g1UdblbhESBYVMyDmuk66xLwkAat5SffM7G/XVyjqMs2ZHNrlr4qwgwL0sCAbvfgkceiS8dih9eM8gpDpjUkwvsA7c3q76xkt8xvEsEyxa6NlRAmoS0HR/M/BQhcSx0k7tYX79WDY639vhQU0Iqug/nqqNbzaLDXlov4DMuQh+4mXChLzc9h7aVf+yv0juwGfyH65sGdxabOeRwQ9HKPopyIsMyDIoXtbe3okpuY7tgDNZ7qbIw25RzvNSfwmMdCS1uUSdupEIJGfseL0S1tibndJgYymRD3D/YwkFikJu1HRFAgnLsg3H162xd1BHlC93dLW4cIHsEu4EYwWb3EYltkbtvA+BKed9Fw5j1pOdUK3GIsb1SpEN6x393f28G3mDP0mESbn7M15H+CGlf/DHo75jjoXOe9kznmrMBhzAXzaUMBYu1dnv+aXQtCF/osaowTkbWQCTxULLrz2iHDeedAGa7CWQVGOB+8uDQ6HJg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|31061999003|15080799012|8062599012|12121999013|19110799012|8060799015|41001999006|24021099003|4140399003|25010399006|102099032|26104999009|440099028|3412199025|40105399003|52005399003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/90r05iu5FtjQXVn5v71bhrzTsYT2YGqG9zLM2ZqNN15jw97MC0Y4MT31X?=
 =?iso-8859-1?Q?PBoeQbKqYXcza/qOEpKm6YTqz5y54Le6cvd471mGpA/7bOiTOrjifQ8FyZ?=
 =?iso-8859-1?Q?wHDzH0B/7VjL7KU3AiGZW+TW4HIK786AF8n9f2QyNmJ94dKIgp7n5r2Kdh?=
 =?iso-8859-1?Q?IwToGEd0TWfEHhYVek8VL/kzjKyXB5fzfurnzgJrcqIUD5U616JbL652aU?=
 =?iso-8859-1?Q?zVucAjjlxCAUG7b/Lwozx6xBIG8Afl0z50UhXYu2T6vVUEyt66P9KR9a13?=
 =?iso-8859-1?Q?L/8Up8llsiDYXNoVEaSS4BYnd7IQwBc6NI8/L+WRs/39Ul3O05ExOwKRr0?=
 =?iso-8859-1?Q?QnzSYQ39WfowC8bspNMFfYPMSUbu3EhA77EfmOgY/mdOMDKEok+wuzf57I?=
 =?iso-8859-1?Q?ski1sR5ORWEGxL4D5MNXhgVnD+r82REeDXcgx4UXQ//SnyjmY51xRKKwaJ?=
 =?iso-8859-1?Q?xwpMEVnnfNaEEb3exNurARgpNc5AuByjagGnDO1sjyJ2fw2gBv/bvkGbau?=
 =?iso-8859-1?Q?ho0hcAT1uAxtv10E0+yL8302OkF27+0hqpBkUHRhoUDKwp4zwIVDQ0TV9h?=
 =?iso-8859-1?Q?OYfIe8uYo6vQD+of/wGeydq+z0y2HXvhtft105pHIQOpXF/GabpQWe25XF?=
 =?iso-8859-1?Q?UGefLXdm7M0sonq3hjs4y2YwZP4qHB/KsfaepbNam55hRweLSL+VFf7bcx?=
 =?iso-8859-1?Q?MGZlRaXhAvxORa3jpbqYQ6H94ecoB37MgLKc8pKp5jaZD1G2jlsIWUiSno?=
 =?iso-8859-1?Q?w20k6PJmxR/xXIpvI97WVM4LLL0kgIzgXk2ckB4UgxqDHdDYsLBLaFHK1r?=
 =?iso-8859-1?Q?cjpeXhsMnqOjpRz+GoJ0mhvlBeh9lyNXXQ65VgrePTrSuprpTpjZZAg/SF?=
 =?iso-8859-1?Q?iE6kv7rYdD97Nh/V278wGeOF/Zl6syb5lcaoujBKUHHMI3lL9JwP4P8Fjv?=
 =?iso-8859-1?Q?aYBWGYFEvFwhfpwB9RDjQxaihxrhVwJf51AyPijrlEMloUn+biHvQU0yvg?=
 =?iso-8859-1?Q?NPlfpXyaUwL/DKp2MUEg/2G9d16gxuXrfpF6KmHUSIsYLM2rqPC5/nrJDP?=
 =?iso-8859-1?Q?reGf2YNruMdT5hfA+fAP2iM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CxNejdqrGUaxQIUTeQK/Skzs5Zfk+CPI2QaWQzmLecMudtQBW0tQXZBLwK?=
 =?iso-8859-1?Q?l9/9t52wugmo5whJIvspJufUXtY1lIqgadOpIFXrWmdl0bUasASIDCqHrx?=
 =?iso-8859-1?Q?/sbhB7gqIdzIWlbi7wlmtDcxiM7YkLA3P7Wr2JkPjZtaer2X0JQX4ONSP+?=
 =?iso-8859-1?Q?HmHweJNJlfPG71E/s5/0FEcOKarVUAJTZO4jI/BR+MlfoDbUDyCe/xpHEK?=
 =?iso-8859-1?Q?FVTuv5Q5+4DKUOz1g6u5lyaP7TN1hUsRvLu2CM24RtxT07RMNC38Eub9Wo?=
 =?iso-8859-1?Q?Z4mMIb4+UtHUQso9lKTQirpOCVIQo3XHJAiNzr+Ze/AevwnLRjZwD1pnFj?=
 =?iso-8859-1?Q?1WT0qAfqYltt4wWQz3wZ8sbvPL9hL9sEsYePy4c6+I5h/RDPjY9RHV/5lk?=
 =?iso-8859-1?Q?CAgRFfeQuzxxjSNIh2HTV5ev46KHCs9bHfLWLDMnXe2WblK5KmVmuUiDcM?=
 =?iso-8859-1?Q?lxLi2XX/uzZrNe9atlOybVFBa3XsBL+1c6IXlrOBeB60yAtXe0ec9+W+iy?=
 =?iso-8859-1?Q?FO8XYFDyiUNWtcAwyYUusxufiUEpNhnq9VQM4JEWEu3P+nJo93tnutrjsE?=
 =?iso-8859-1?Q?+PeaCJWIWRFuMOB2EXzRdvWYVWJCvb7KNlKfwRxWxJunau4deJkPTK7//D?=
 =?iso-8859-1?Q?VN5yQZY5VsUeyYc0W+/JFpEJPaPnpZKXHbUkFwVPzD6Na2/Dqquxjbv5zv?=
 =?iso-8859-1?Q?TaXcSwxKUaBVEevksMHmHPYyOMnCS73poyOOLRuc2S5EceY8HW6cB2CTFb?=
 =?iso-8859-1?Q?ZI9eY3wTMVWFSpRy++Cdk8Nfuf3APVLArA56WMsubj+h6LgAur+yszflUu?=
 =?iso-8859-1?Q?wKPMDw9cf779s9DMI6oGZYV8ru7LLd6vCCxwX/j7Utl9ZKaMASgeZVkgjA?=
 =?iso-8859-1?Q?kDTi9UMOjQb43nW61BEIbrkBV0ISEmNUcW6E5UMaxQRfHGeo6TTv37byNh?=
 =?iso-8859-1?Q?6JC2DaGBtEvR6Ghdc9R3y6QBO6xTILCAt0+uqOk72bM6VF7U5t+eQZGDyn?=
 =?iso-8859-1?Q?cSysnrLKhXZsAYLscOrlenJTsm8Vif4nyVIq3fuurdGBFWSQ07IH8/fD22?=
 =?iso-8859-1?Q?x1RKMelWedo9CQoAZX9XebldSZ8XUD2eZTleYv43+0h+nx9AWPm0jvOZMf?=
 =?iso-8859-1?Q?CJBsv8nn4jUPCGYuj9TgWvikiIY+CgL9Cjlm7MUSWxAxh0H8cXDHMggwfy?=
 =?iso-8859-1?Q?ADBs3R+oyP0t3eNYoOo/Q8DyH/gWBJp7WU6xGjNAb+j71k8U6PN+ikG1fG?=
 =?iso-8859-1?Q?bwl5rZ1AeIxpXKEhq0UcYHeehOd15+tXHwEL1KdGqKMh6DdcWqAYdzZWC7?=
 =?iso-8859-1?Q?x5kuOQfD6KDWyy6Kl4kHWkEOmX2kL5irEpQ1SC/CRB+DMkQT7RJS2yqo+3?=
 =?iso-8859-1?Q?rD9gSGXfqIyyT47vZQlpYYoMCcpANnX07yhouySs/OaCIbZe98P+g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB804852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5879b070-52f6-4776-bc36-08df41941305
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 14:40:33.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8169

From: Jianqiang Zou <jq.zou@outlook.com>=0A=
=0A=
The interrupt-driven byte-by-byte transfer stores a pointer to the=0A=
caller's buffer in priv->data. After a transfer times out, a late=0A=
BYTE_DONE interrupt can still access the buffer after the caller=0A=
returns. This can cause a KASAN stack-out-of-bounds report in=0A=
i801_isr_byte_done().=0A=
=0A=
Clear priv->data before synchronizing the shared IRQ. Have the=0A=
handler snapshot the pointer once and skip byte handling if it is=0A=
NULL. This lets any handler that already acquired the pointer=0A=
finish before the caller can release the buffer.=0A=
=0A=
Fixes: d3ff6ce40031 ("i2c-i801: Enable IRQ for byte_by_byte transactions")=
=0A=
=0A=
Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>=0A=
---=0A=
 drivers/i2c/busses/i2c-i801.c | 41 +++++++++++++++++++++++++++++++----=0A=
 1 file changed, 37 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c=
=0A=
index b29c99ed3..9d1a95a18 100644=0A=
--- a/drivers/i2c/busses/i2c-i801.c=0A=
+++ b/drivers/i2c/busses/i2c-i801.c=0A=
@@ -562,6 +562,17 @@ static int i801_block_transaction_by_block(struct i801=
_priv *priv,=0A=
 =0A=
 static void i801_isr_byte_done(struct i801_priv *priv)=0A=
 {=0A=
+	u8 *data =3D READ_ONCE(priv->data);=0A=
+=0A=
+	/*=0A=
+	 * The transaction may have finished and cleared priv->data=0A=
+	 * while a BYTE_DONE interrupt was still pending.  Bail out=0A=
+	 * instead of writing through a pointer into the caller's=0A=
+	 * stack buffer, which is gone by then.=0A=
+	 */=0A=
+	if (unlikely(!data))=0A=
+		return;=0A=
+=0A=
 	if (priv->is_read) {=0A=
 		/*=0A=
 		 * At transfer start i801_smbus_block_transaction() marks=0A=
@@ -574,12 +585,12 @@ static void i801_isr_byte_done(struct i801_priv *priv=
)=0A=
 				/* FIXME: Recover */=0A=
 				priv->len =3D I2C_SMBUS_BLOCK_MAX;=0A=
 =0A=
-			priv->data[-1] =3D priv->len;=0A=
+			data[-1] =3D priv->len;=0A=
 		}=0A=
 =0A=
 		/* Read next byte */=0A=
 		if (priv->count < priv->len)=0A=
-			priv->data[priv->count++] =3D ioread8(SMBBLKDAT(priv));=0A=
+			data[priv->count++] =3D ioread8(SMBBLKDAT(priv));=0A=
 		else=0A=
 			pci_dbg(priv->pci_dev, "Discarding extra byte on block read\n");=0A=
 =0A=
@@ -589,7 +600,7 @@ static void i801_isr_byte_done(struct i801_priv *priv)=
=0A=
 			       SMBHSTCNT(priv));=0A=
 	} else if (priv->count < priv->len - 1) {=0A=
 		/* Write next byte, except for IRQ after last byte */=0A=
-		iowrite8(priv->data[++priv->count], SMBBLKDAT(priv));=0A=
+		iowrite8(data[++priv->count], SMBBLKDAT(priv));=0A=
 	}=0A=
 }=0A=
 =0A=
@@ -702,7 +713,7 @@ static int i801_block_transaction_byte_by_byte(struct i=
801_priv *priv,=0A=
 		priv->cmd =3D smbcmd | SMBHSTCNT_INTREN;=0A=
 		priv->len =3D len;=0A=
 		priv->count =3D 0;=0A=
-		priv->data =3D &data->block[1];=0A=
+		WRITE_ONCE(priv->data, &data->block[1]);=0A=
 =0A=
 		reinit_completion(&priv->done);=0A=
 		iowrite8(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));=0A=
@@ -938,6 +949,28 @@ static s32 i801_access(struct i2c_adapter *adap, u16 a=
ddr,=0A=
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));=0A=
 =0A=
 out:=0A=
+	/*=0A=
+	 * A byte-by-byte transaction points priv->data into the=0A=
+	 * caller's union i2c_smbus_data, which lives on the stack of=0A=
+	 * i801_access()'s caller.  On a timeout i801_check_post()=0A=
+	 * writes SMBHSTCNT_KILL and then writes 0 to SMBHSTCNT,=0A=
+	 * which drops SMBHSTCNT_INTREN and stops the controller from=0A=
+	 * raising further BYTE_DONE interrupts.  That does not wait=0A=
+	 * for a handler already in flight, and it does not=0A=
+	 * invalidate priv->data for a spurious interrupt arriving=0A=
+	 * after this function returns.=0A=
+	 *=0A=
+	 * Clear the pointer before waiting for in-flight handlers.=0A=
+	 * A new handler on the shared IRQ can run after the wait,=0A=
+	 * so it must already see NULL. A handler that took a=0A=
+	 * snapshot before the clear must finish before the caller=0A=
+	 * can release the buffer. This also covers successful=0A=
+	 * transfers.=0A=
+	 */=0A=
+	if ((priv->features & FEATURE_IRQ) && READ_ONCE(priv->data)) {=0A=
+		WRITE_ONCE(priv->data, NULL);=0A=
+		synchronize_irq(priv->pci_dev->irq);=0A=
+	}=0A=
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);=0A=
 	mutex_unlock(&priv->acpi_lock);=0A=
 	return ret;=0A=
-- =0A=
2.43.0=0A=
=0A=
