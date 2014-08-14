From: Ran Shalit <ranshalit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c access from kernel
Date: Thu, 14 Aug 2014 07:11:43 +0300
Message-ID: <CAJ2oMhK_pz4uM5BipEmajtQT1Q-BvVX0+-98ceb5nbPBuqKq3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

In userspace we can access any bus very simple, but from kernel it
seems very complex doing simple access to a bus.
The first argument to i2c_transfer is pointer to struct i2c_adapter,
which is very complex struct to fill !!

Isn't there a simpler way to access a bus (for example i2c-2) from kernel?

If I know, for example, the exact bus number, is there some way I can
get the i2c_adapter pointer to that bus ?

Thanks, Ran
