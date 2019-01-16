From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] i2c: imx: defer probing on dma channel request
Date: Wed, 16 Jan 2019 08:48:28 +0000
Message-ID: <633db479-e1be-3b8b-45c4-06d1b651fe12@nxp.com>
References: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
 <20190115215549.sepj7rmpqmtlxwbw@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115215549.sepj7rmpqmtlxwbw@ninjato>
Content-Language: en-US
Content-ID: <1515DFC079315A43BEFC0B7DB76310FF@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Leo Li <leoyang.li@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

On 15.01.2019 23:55, Wolfram Sang wrote:
> Hi,
>=20
> On Tue, Jan 15, 2019 at 04:03:32PM +0200, Laurentiu Tudor wrote:
>> If the dma controller is not yet probed, defer i2c probe.
>> The error path in probe was slightly modified (no functional change)
>> to avoid triggering this WARN_ON():
>> "cg-pll0-div1 already disabled
>> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0x=
b0"
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> I just applied this series to i2c/for-next:
>=20
> http://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D85099&state=
=3D*
>=20
> I haven't checked carefully but maybe it fixes/changes your issue?=20

Not really as it doesn't seem to defer probing until the dma controller=20
gets probed.

> If not, your patch most likely will need a rebase on top of the above.

Will rebase on latest i2c tree and re-send.

---
Best Regards, Laurentiu=
