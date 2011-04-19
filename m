From: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c-gpio performance issue w/MPC8xx @ 50 MHz
Date: Tue, 19 Apr 2011 23:53:11 +0300
Message-ID: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hey list

I needed to bit bang I2C on an ancient MPC875 running at a blazing 50
MHz. I started by initializing the generic i2c-gpio bus but quickly
found it could not bit bang @ 100 kHz. The most I was able to get it
was ~50 kHz by setting udelay to 0 and patching around i2c-gpio.c to
make sure it doesn't modify this value.

I then implemented a bus driver of my own, based on i2c-gpio. The only
difference was that it simply implemented set/get sda/scl by directly
writing to hardware. Using this I was able to reach around 150 kHz.

1) Any comments on the above? Could I have done something differently?
2) I thought perhaps a thin adapter could be implemented that exported
a platform data structure holding callbacks: set sda/scl dir/val, get
sda/scl. By registering such a bus driver and supplying these
callbacks in the platform module, one could avoid having to
re-implement a bus driver like I did. Comments?

Thanks
Eran
