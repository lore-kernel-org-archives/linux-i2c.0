From: Alessio Sangalli <alesan-+h0hele9I7BBDgjK7y7TUQ@public.gmane.org>
Subject: Correct i2c access semantics
Date: Wed, 13 May 2015 16:01:51 -0700
Message-ID: <5553D7DF.4090504@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello. I am writing a small program to read "DDC" data from a monitor on
the i2c bus. My application is custom so I need to properly init and
program an FPGA before I can access the monitor.

What I am seeing is that if I open() the correct i2c bus, then I ioctl
with I2C_SLAVE to select the right slave, then read(fd, buffer, 0x100) I
can consistently access the correct data.

However, if I only read(fd, buffer, 0x80) (in fact I do not need the
DDC/EDID data above 0x80 for my application), next time I run the
program, it will start reading from offset 0x80 from that device. In
fact, it seems like there is a static index on the i2c reads, that is
not reset when I perform close(), open(), or the program exits.

However, if I do one i2c_smbus_read_byte_data() it will always reset the
offset read to the first byte.

i2c_smbus_read_byte_data(fd, 0);
i = read(fd, data + 1, 0xff);

The code above ALWAYS read the same bytes from the i2c device.

Is this the expected behaviour, or am I missing something? I am using an
older Linux 3.5 in this application.

Thank you
as
