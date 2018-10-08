From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/3] i2c: mux: pca954x: simplify code to reach the
 adapter
Date: Mon, 8 Oct 2018 21:48:20 +0000
Message-ID: <c3fdd93a-b0db-771e-85e4-480c3b01ac29@axentia.se>
References: <20181003155024.16024-1-lucaceresoli77@gmail.com>
 <20181005114336.GB5433@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005114336.GB5433@kunai>
Content-Language: en-US
Content-ID: <666B2A29BFB0AF48AEB3A4940BD7BEC7@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Luca Ceresoli <lucaceresoli77@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luca Ceresoli <luca@lucaceresoli.net>, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-i2c@vger.kernel.org

On 2018-10-05 13:43, Wolfram Sang wrote:
> On Wed, Oct 03, 2018 at 05:50:22PM +0200, Luca Ceresoli wrote:
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> struct i2c_client has a direct pointer to the adapter, no need to dig
>> it out of the struct device tree.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> I like such cleanups!

Me too!

All three patches applied to for-next. Thanks!

Cheers,
Peter
