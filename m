From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Calling an I2C camera sensor with SMBUS API?
Date: Fri, 12 Dec 2008 16:44:26 +0100
Message-ID: <20081212164426.27b4f5cd@hyperion.delvare>
References: <A24693684029E5489D1D202277BE894415E6E424@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A24693684029E5489D1D202277BE894415E6E424-EovWT4A8QTWIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre-l0cyMroinI0@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sergio,

On Thu, 11 Dec 2008 17:55:26 -0600, Aguirre Rodriguez, Sergio Alberto wrote:
> Some days back, Vaibhav Hiremath submitted patches to linux-omap and
> video4linux trees for an I2C video codec chip, and he was suggested to
> use SMBUS API instead of manually constructing i2c messages and sending
> using i2c_transfer API.
> 
> So I attempted to do the same for a camera sensor I've been working on.
> 
> But one thing I noticed is that my sensor needs to access 16-bit register
> addresses in the device, and I saw in SMBUS spec 2.0 that the equivalent
> thing (SMBUS commands) are only 8-bit length.
> 
> So, should this automatically discard using SMBUS api for my case, or am
> I missing something else? (like a SMBUS 16-bit expansion or so)

You are correct, SMBus messaging implies an 8-bit command field (which
is most frequently used for register addressing.) There are no 16-bit
command variants. For writes, we can cheat because there is no
direction change between the address and the data, but for reads
there's simply nothing we can do to work around this limitation. So,
unless your device is write-only, you indeed can't use the SMBus-level
API for 16-bit register addresses and you have to stick to the
I2C-level API.

-- 
Jean Delvare
