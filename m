From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Wed, 22 Oct 2008 22:19:03 -0700
Message-ID: <200810222219.04768.david-b@pacbell.net>
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru> <200810221452.46786.david-b@pacbell.net> <20081022222940.GA14636@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754576AbYJWFTU@vger.kernel.org>
In-Reply-To: <20081022222940.GA14636@oksana.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, David Miller <davem@davemloft.net>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 22 October 2008, Anton Vorontsov wrote:
> >=20
> > So have it live in the __init text section...
>=20
> Won't work, unfortunately. I2C devices are created by the
> i2c controllers, via drivers/of_i2c.c =A0of_register_i2c_devices().

And I'm pointing out a way to have the normal I2C core code
flow do that creation.  OF shouldn't need to be so much of a
special case.


> There is a good reason to do so, the code needs to know
> controller's OF node to walk down and register the child nodes
> (devices). See drivers/i2c/busses/i2c-mpc.c -- it calls
> of_register_i2c_devices() at the end of the probe().

I don't get it.  (But then, so much of the OF support seems
needlessly convoluted to me ... on top of seeming to be
insufficient for configuring board-specific details.)

There's an OF device tree, distinct from the Linux driver
model tree.  Why should there be any obstacle to accessing
records from that tree before the relevant driver model nodes
have been created?  Remember that the various board_info
structs get registered before the driver model nodes for
which they are templates.  Just translate the OF tree data
to those templates(*), then register them.

I understand that it's currently structured differetnly
than that ... consulting the OF tree "late" not early.
But that's still newish, and from what I've heard so far
it doesn't seem like the best structure either... nothing
seems to plug in smoothly.

- Dave

(*) The role of the board_info structs is very similar
    to the role of OF device attributes.  As is the role
    of the platform_data ... except that's more specific
    to the chip involved (and its driver), and expects
    any callbacks to be in C code not FORTH.
