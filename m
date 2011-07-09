From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Winbond W83L604G
Date: Sat, 9 Jul 2011 09:23:34 +0200
Message-ID: <20110709092334.566e6dcd@endymion.delvare>
References: <20110707182315.6e28f62a@endymion.delvare>
	<21511805.221.1310161730242.JavaMail.root@zmail.rockbochs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21511805.221.1310161730242.JavaMail.root-N94c1vXlnCs/q/FG96+aB0EOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nelson <tnelson-f4DZ+GDyDBaakBO8gow8eQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tim,

On Fri, 8 Jul 2011 16:48:50 -0500 (CDT), Tim Nelson wrote:
> ----- Original Message -----
> > To test the reliability of the SMBus you could dump the whole register
> > map:
> > # i2cdump -y -r 0x00-0x22 0 0x19
> > and look for XX's.
> 
> I'm seeing a *lot* of 'XX's present. Here are ten samples:
> 
> root@aaa:~# i2cdump -y -r 0x00-0x22 0 0x19
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX 00 XX 55 XX XX XX XX ff XX XX    XXXXXX.XUXXXX.XX
> 10: 3f XX XX XX 00 XX XX XX XX XX ff XX XX XX XX XX    ?XXX.XXXXX.XXXXX
> 20: 95 92 XX                                           ??X
> (...)
> 
> What does this mean? Unstable SMBus?

Yes. For whatever reason your SMBus misbehaves severely. Maybe a
hardware problem. You should try a few dumps from your other device at
0x4c to confirm that this is a bus-wide issue and not only the W83L604G
device.

Note that there exists an alternative driver for the I2C bus on SCx200,
named scx200_i2c. I seem to remember that it is needed in some cases
where the scx200_acb driver doesn't work. Maybe this is your case.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
