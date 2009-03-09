From: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>
Subject: Need help on selecting one (and only one) i2c bus
Date: Mon, 9 Mar 2009 11:58:50 +0100
Message-ID: <000101c9a0a6$078064c0$b23e81a4@par.st.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello everybody,

I'm new on I2C device drivers programming and I'm facing a little problem, I can't find how to select my i2c-0 bus (I have 3 of them: i2c-0, i2c-1 and i2c-2)
I'd like my probe function to probe only this bus and ignore the others.
I guess I can find the solution with the i2c_address_data structure, but I don't really understand how to use it...


Thanks in advance,

Ayman KHAMOUMA
