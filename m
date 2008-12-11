From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre-l0cyMroinI0@public.gmane.org>
Subject: Calling an I2C camera sensor with SMBUS API?
Date: Thu, 11 Dec 2008 17:55:26 -0600
Message-ID: <A24693684029E5489D1D202277BE894415E6E424@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Some days back, Vaibhav Hiremath submitted patches to linux-omap and video4linux trees for an I2C video codec chip, and he was suggested to use SMBUS API instead of manually constructing i2c messages and sending using i2c_transfer API.

So I attempted to do the same for a camera sensor I've been working on.

But one thing I noticed is that my sensor needs to access 16-bit register addresses in the device, and I saw in SMBUS spec 2.0 that the equivalent thing (SMBUS commands) are only 8-bit length.

So, should this automatically discard using SMBUS api for my case, or am I missing something else? (like a SMBUS 16-bit expansion or so)

Regards,
Sergio
