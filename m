From: =?ISO-8859-15?Q?Frank_Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Q: i2c block write emulation / handling of i2c message size constraints
 of a bus ?
Date: Sat, 27 Oct 2012 17:17:34 +0300
Message-ID: <508BECFE.2010302@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

the i2c interface of my device is capable of writing 2 bytes (reg +
data) and reading a single data byte only.
A block read/write emulation function would have to do an i2c write (to
increase the register) followed by either an i2c read or write for each
data byte.
The question is now: does it make sense to emulate block operations for
the i2c/smbus layer in this case ?
I'm not sure if an i2c read through the smbus/i2c subsystem should
really trigger multiple low level i2c reads/writes...
What's the right error code to return from the drivers master_xfer
function if the message length is not supported ? -EMSGSIZE ?

Regards,
Frank
