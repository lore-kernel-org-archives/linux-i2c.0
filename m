From: Xianghua Xiao <xiaoxianghua-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: multiple byte read/write to I2C device
Date: Fri, 24 Jun 2011 16:34:15 -0500
Message-ID: <BANLkTi=VObOHgC3HsXuOF2rRVzNwbvGHsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

It appears i2cget/i2cset can only handle up to 2 bytes at once, I have
an I2C device that needs to send 4 bytes R/W, can i2cget/i2cset do
that?

Thanks,
Xianghua
