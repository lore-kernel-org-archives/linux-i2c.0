From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: CONFIG_I2C_XILINX doesn't complie
Date: Tue, 9 Mar 2010 17:31:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003091727461.17799@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Richard_R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

current Linus' tree (57d54889cd00) doesn't compile when CONFIG_I2C_XILI=
NX=20
is enabled:

drivers/i2c/busses/i2c-xiic.c:39:28: error: linux/i2c-xiic.h: No such f=
ile or directory
drivers/i2c/busses/i2c-xiic.c: In function =E2=80=98xiic_i2c_probe=E2=80=
=99:
drivers/i2c/busses/i2c-xiic.c:750: error: dereferencing pointer to inco=
mplete type
drivers/i2c/busses/i2c-xiic.c:751: error: dereferencing pointer to inco=
mplete type

Seems like the following commit

	commit e1d5b6598cdc33257fe68302ae9db81d2f7bb883
	Author: Richard R=C3=B6jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
	Date:   Thu Feb 11 10:42:00 2010 +0100

	    i2c: Add support for Xilinx XPS IIC Bus Interface

forgot to add some header files.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
