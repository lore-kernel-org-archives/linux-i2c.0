From: "Wang, Alan 1. (NSB - CN/Hangzhou)" <alan.1.wang@nokia-sbell.com>
Subject: RE: [PATCH] i2c: core: decrease reference count of device node in
 i2c_unregister_device
Date: Wed, 29 Nov 2017 08:06:01 +0000
Message-ID: <VI1PR07MB3421903B9F5C37CB63637687A23B0@VI1PR07MB3421.eurprd07.prod.outlook.com>
References: <1511766415-3732-1-git-send-email-alan.1.wang@nokia-sbell.com>
 <20171127182145.q4tju5ikw56nygki@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171127182145.q4tju5ikw56nygki@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

In my understand, the of_node_put(bus) is to of_get_child_by_name((adap->de=
v.of_node, "i2c-bus") or of_node_get(adap->dev.of_node).

What I said is the children of "bus" increased by "info.of_node =3D of_node=
_get(node)" in function of_i2c_register_device.

My description in last mail maybe not properly, I think all the nodes acces=
sed by of_i2c_register_device shall not be decreased, not only the dynamica=
lly added ones.=20

In my case, the SFP devices as i2c clients on one board are connected to th=
e bus through i2c mux.
When plugin the board, all the related nodes are dynamically allocated and =
added into the device tree.
Then the probe function calls of_i2c_register_devices, in which the referen=
ce count increased by " info.of_node =3D of_node_get(node)".
When plug out the board, because the reference count of those nodes are not=
 decreased down to 0, the memory of the nodes and their properties are not =
released.
New memory will be allocated but not released in the next plugin and plug o=
ut looping test.=20

Best Regards,
Lixin Wang

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Tuesday, November 28, 2017 2:22 AM
> To: Wang, Alan 1. (NSB - CN/Hangzhou) <alan.1.wang@nokia-sbell.com>
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] i2c: core: decrease reference count of device node i=
n
> i2c_unregister_device
>=20
> On Mon, Nov 27, 2017 at 03:06:55PM +0800, Lixin Wang wrote:
> > Reference count of device node was increased in
> > of_i2c_register_device, but without decreasing it in i2c_unregister_dev=
ice.
>=20
> Huh, there is an of_node_put(bus) in of_i2c_register_device?
>=20
> > Then the dynamically
> > added device node will never be released.
>=20
> Strange. Can you provide your test case, please?
