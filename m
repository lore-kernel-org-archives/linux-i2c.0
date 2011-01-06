From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Thu, 6 Jan 2011 16:22:13 +0100
Message-ID: <20110106162213.4e5ee5b4@endymion.delvare>
References: <4D0B9C35.5000802@uib.cat>
	<AANLkTi=LQ56S43=BL8tdo=MakP-PRzVK0ieJM07y_O_1@mail.gmail.com>
	<4D14C6D1.3030802@uib.cat>
	<AANLkTinSuVYAVQqPHRtrnTPrtEZA1aCHOb6X4H8u2OW1@mail.gmail.com>
	<4D1A0A95.7020408@uib.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D1A0A95.7020408-i5CWTa81U/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Cc: Giampaolo Bellini <iw2lsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 28 Dec 2010 17:04:37 +0100, Joan Pau Beltran wrote:
> Now i2cdump give this output
> (all lines except the first one stripped because they are empty):
> 
> i2cdump -y 2 0x20
> No size specified (using byte-data access)
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff ff ff ff 00 00 ff ff XX XX XX XX XX XX XX XX    ........XXXXXXXX
> 
> I am surprised about these values. The port has 8 gpio pins available,
> so it seems their addresses are the ones in 000-007
> (or shoud I say they are represented in the chip's register 000-007?).

No, it doesn't work like that. You'll have to download the datasheet
for your GPIO chip from nxp.com, to find out the meaning of each
register. The details are normally hidden from you if you use the
pca953x driver, but as you decided to go the hard way...

> However, since there is nothing connected to the gpio pins,
> I expected all their values to be equal 00. Is this normal?
>  From where can these values can come from?

You really want to read the datasheet. With i2cdump, i2cget and i2cset,
you get raw access to the device registers, so don't expect anything to
be easy and straightforward.

> (...)
> It seems that I should add i2c-dev and i2c-i801 to my /etc/modules.
> Can someone confirm that? Would it be better to make udev load them 
> automatically?
> How can this be done?

i2c-i801 should get loaded automatically, as it is a PCI driver. If it
isn't on your system, make sure you didn't blacklist it. The following
command may help:

$ /sbin/modprobe -c | grep i2c_i801

i2c-dev is never loaded automatically, so you indeed have to add it
to /etc/modules (or whatever your distribution-specific mechanism is)
if you need it. OTOH you have to be root to run i2cdump or i2cget, so
you might as well load i2c-dev manually as root too.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
