From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: use struct_size() in
 devm_kzalloc()
Date: Sun, 21 Apr 2019 18:15:21 +0000
Message-ID: <d7950904-23ee-98e2-9a55-77e7cb802e0d@axentia.se>
References: <20190104174327.GA30932@embeddedor> <20190104180612.GE3009@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104180612.GE3009@kunai>
Content-Language: en-US
Content-ID: <A3712A6FD9B7FC49A185DF7E87C89FEF@eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2019-01-04 19:06, Wolfram Sang wrote:
>=20
>> Instead of leaving these open-coded and prone to type mistakes, we can
>> now use the new struct_size() helper:
>=20
> I am okay with this patch in general. However, I think the name of the
> helper 'struct_size' is a bit unfortunate. I really wondered on the
> first read why it needs 3 arguments to find out a struct size. I only
> understood on the second read. I think 'trailing_array_struct_size'
> would be way more clearer what it does.

I read that as an Acked-by... :-)

Cheers,
Peter
