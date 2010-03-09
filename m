From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: CONFIG_I2C_XILINX doesn't complie
Date: Tue, 9 Mar 2010 08:42:29 -0800
Message-ID: <20100309084229.6aa00ce8.randy.dunlap@oracle.com>
References: <alpine.LNX.2.00.1003091727461.17799@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1003091727461.17799-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Richard =?UTF-8?B?UsO2amZvcnM=?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 9 Mar 2010 17:31:04 +0100 (CET) Jiri Kosina wrote:

> Hi,
>=20
> current Linus' tree (57d54889cd00) doesn't compile when CONFIG_I2C_XI=
LINX=20
> is enabled:
>=20
> drivers/i2c/busses/i2c-xiic.c:39:28: error: linux/i2c-xiic.h: No such=
 file or directory
> drivers/i2c/busses/i2c-xiic.c: In function =E2=80=98xiic_i2c_probe=E2=
=80=99:
> drivers/i2c/busses/i2c-xiic.c:750: error: dereferencing pointer to in=
complete type
> drivers/i2c/busses/i2c-xiic.c:751: error: dereferencing pointer to in=
complete type
>=20
> Seems like the following commit
>=20
> 	commit e1d5b6598cdc33257fe68302ae9db81d2f7bb883
> 	Author: Richard R=C3=B6jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
> 	Date:   Thu Feb 11 10:42:00 2010 +0100
>=20
> 	    i2c: Add support for Xilinx XPS IIC Bus Interface
>=20
> forgot to add some header files.


http://lkml.org/lkml/2010/3/9/50http://lkml.org/lkml/2010/3/9/50

---
~Randy
