From: Christopher Friedt <chrisfriedt-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: new stmpe2401 driver
Date: Fri, 25 Sep 2009 15:13:53 +0200
Message-ID: <3ea34a000909250613v77804a63gc1b8d68b20801ce9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi folks,

Recently, I ported Linux to a previously unsupported device (it uses
pxa270 processer, so most of the work was already done), and I had a
couple of issues that I hoped you could help me with.

1) I wrote a new 'multi-function' driver for the STMPE2401 gpio
expander, which also has a keypad controller, 3 pwm channels, and a
rotator input, and I would appreciate it if a couple of people could
review it for me so that it could be submitted upstream. So far, only
the keypad function is implemented because my device doesn't use the
others. However, I've already coded in most of the structure for the
other device functions but they just return -ENOSYS on probe. I'm sure
that someone with sufficient experience could probably look at my
driver and give me a few tips on how to improve it before submission.
Which leads me to my next question...

2) The keypad is a bit tricky for my platform. There are a couple of
different modifier keys, and I'm not really sure where to start to
have userspace handle the scancode-keycode mapping. Right now it's
done in kernel mode in a small callback function. When the setkeycode
call is used, it just returns -EPERM because I haven't figured out how to
organize the keycode remapping from userspace. Can somebody with
some input-device experience point me in the right direction? I've already
emailed this to the linux-input list as well, but thought that I would ask here
too. It would be nice if the keypad worked at the console and also in X or
other graphical environments. Currently I'm trying to get it to work in
Android, which just uses the typical event interface for key-remapping.

I suppose one way to do it would be to have the kernel dynamically
switch based on if the event device is open (i.e. not open in the console
but open in X) ... still it's a bit confusing. Any tips?

Regards,

Chris
