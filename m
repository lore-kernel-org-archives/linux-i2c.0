From: Przemyslaw Wegrzyn <pwegrzyn-qaBtZ/OuEkOiu113P13oHA@public.gmane.org>
Subject: Finding particular I2C adapter?
Date: Fri, 07 Oct 2011 14:43:08 +0200
Message-ID: <4E8EF3DC.7060704@codepainters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

First of all - I know what I'm asking for is somewhat "broken by
design", but anyway...

I'm about to develop a driver for a custom chip attached to SMBus in a
sort of industrial PC (choosing SMBus was a really bad idea, imho, but
unfortunately I can't change hardware team decisions).

While developing the I2C client driver seems pretty straight-forward,
I'm slightly confused about making it look for the device on a
particular I2C adapter instance. The project is limited to particular
board types, each using ICH chipset, so I need to use i2c_adapter
controlled by i2c-i801 module.

Here's my understanding so far:

- it is not an embedded system in a strict sense -> thus no
i2c_board_info -> no static I2C configuration

- AFAIR I can force the bus and address using 'force' parameter at
module loading time (e.g. via /etc/modules), but the I2C adapter number
is not static anyway on PC, and depend on e.g. adapter modules loading
order, so I'm a bit afraid of users breaking this configuration too easily.

- similar issue with echo'ing to /sys/bus/i2c/devices/i2c-<n>/new_device
- I need to know the bus ID in advance

Ideally, I'd like to have a sort of wrapper module that will find the
proper i2c_adapter and instantiate my i2c_client explicitly. Yet I know
that iterating i2c adapters is discouraged at least (actually, is there
any API now allowing for this? calling i2c_get_adapter with successive
numbers is clearly a hack).

Any ideas?

BR,
Przemek
