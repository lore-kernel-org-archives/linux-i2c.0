From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: howto to suppor new i2c algo
Date: Tue, 3 Mar 2009 14:50:51 +0100
Message-ID: <20090303145051.676ab361@hyperion.delvare>
References: <49A276BF.6030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49A276BF.6030102-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zaphod001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 23 Feb 2009 12:13:19 +0200, Zaphod wrote:
> Hi
> 
> 1st of all, i am using Linux and currently implementing interface to the DVB 
> demodulator using i2c.
> The read (from it's datasheet ecc3100 SkyPhy) demands the algo with repeat of 
> start option:
> 
> S Add+w A AddByte1 A AddByte2 A S Arr+r A ...
> 
> So, which option i have to use in order to force such behavior.
> I am using user space application with ioctl I2C_RDWR

Well, I2C_RDWR is exactly what you need. Given that you already found
it, I am not sure what you are asking exactly? You need to provide an
array of 2 struct i2c_msg, one with the 2 address bytes to write, and
one for the bytes to read from the target slave chip.

Note that the user-space part of the code is the user of the I2C
implementation. You also need to implement the hardware I2C support on
the kernel side. That is, you need to write a kernel I2C bus driver
that implements the low-level access to the I2C bus on your DVB adapter.

-- 
Jean Delvare
