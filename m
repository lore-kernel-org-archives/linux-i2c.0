From: Zaphod <zaphod001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: howto to suppor new i2c algo
Date: Mon, 23 Feb 2009 12:13:19 +0200
Message-ID: <49A276BF.6030102@gmail.com>
Reply-To: zaphod001-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

1st of all, i am using Linux and currently implementing interface to the DVB 
demodulator using i2c.
The read (from it's datasheet ecc3100 SkyPhy) demands the algo with repeat of 
start option:

S Add+w A AddByte1 A AddByte2 A S Arr+r A ...

So, which option i have to use in order to force such behavior.
I am using user space application with ioctl I2C_RDWR

thanks
