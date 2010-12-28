From: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Tue, 28 Dec 2010 17:04:37 +0100
Message-ID: <4D1A0A95.7020408@uib.cat>
References: <4D0B9C35.5000802@uib.cat> <AANLkTi=LQ56S43=BL8tdo=MakP-PRzVK0ieJM07y_O_1@mail.gmail.com> <4D14C6D1.3030802@uib.cat> <AANLkTinSuVYAVQqPHRtrnTPrtEZA1aCHOb6X4H8u2OW1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinSuVYAVQqPHRtrnTPrtEZA1aCHOb6X4H8u2OW1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Giampaolo Bellini <iw2lsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi everyone

Giampolo, thank you so much for your time.
I hope you and everyone in the list enjoy a happy and not too white 
Christmas.

My tries following Giampolo's steps first failed,
but thanks to his first mail on this subject and his last suggestions,
I get what I think are lectures from the gpio pins.

Here it goes the whole story:

After successfully loading the i2c-dev module via modprobe,
two new devices are automatically created (i2c-0 and i2c-1)
with major number 89 and minor numbers 0 and 1 respectively. This seems ok.
However any of them appears to i2cdetect as a SMBus
(in contrast with Giampolo's console output):

i2cdetect -l
i2c-0    i2c        intel drm CRTDDC_A           I2C adapter
i2c-1    i2c        intel drm LVDSDDC_C          I2C adapter

i2cdetect 0 (or i2cdetect 1) does not find any device at any address.
I get the same results in Ubuntu Lucid and Maverick on the same machine
(with kernels 2.6.32-27 and 2.6.35-22 respectively).

Also in contrast with Giampolo's kernel messages in the first post
(i801_smbus 0000:00:1f.3: PCI INT C -> GSI 17 (level, low) -> IRQ 17),
there aren't any smbus mentions in my dmesg.

Looking for smbus modules, in Maverick I found the module i2c-smbus,
but after loading successfully it has no effect. i2cdetect does not show 
any extra bus.
In Lucid, I did not found the i2c-smbus module, but thanks to Giampolo's 
dmesg line
I eventually caught the i2c-i801 module in the output of modprobe -l.

After loading it, i2cdectect shows an extra bus:
i2c-0    i2c       intel drm CRTDDC_A             I2C adapter
i2c-1    i2c       intel drm LVDSDDC_C            I2C adapter
i2c-2    smbus     SMBus I801 adapter at 0400     SMBus adapter

Now i2cdump give this output
(all lines except the first one stripped because they are empty):

i2cdump -y 2 0x20
No size specified (using byte-data access)
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff 00 00 ff ff XX XX XX XX XX XX XX XX    ........XXXXXXXX

I am surprised about these values. The port has 8 gpio pins available,
so it seems their addresses are the ones in 000-007
(or shoud I say they are represented in the chip's register 000-007?).
However, since there is nothing connected to the gpio pins,
I expected all their values to be equal 00. Is this normal?
 From where can these values can come from?

Giampolo, do you remember which distribution did you use?
Did it load some smbus driver automatically (maybe through udev)?
Or do you remember adding any extra module to /etc/modules.

It seems that I should add i2c-dev and i2c-i801 to my /etc/modules.
Can someone confirm that? Would it be better to make udev load them 
automatically?
How can this be done?

Sorry for the long mail, I wrote it expecting that it could be useful
for other people dealing with similar issues.

Thanks again.

Al 25/12/10 12:24, En/na Giampaolo Bellini ha escrit:
> Hello Joan Pau.... an happy christmas !
>
> if I don't remember wrong, 0x20 is the address of the port/function...
> while the first number is the address of the bus.
> the value returned from the command should be the hexadecimal-encoded
> status of the port (viewed as an input)
>
> in order to control the port you should use i2cput with a third number
> that is the hex value of the desired outputs.
> I'm writing using a window machine now... so I cannot check it right now.
>
> from within a C program you can just open the /dev/i2c-0 device and do
> ioctl on it... maybe that's the simplest way.
>
> Buon Natale,
>
>         Giampaolo
>
>
> 2010/12/24 Joan Pau Beltran<joanpau.beltran-i5CWTa81U/w@public.gmane.org>:
>> Thank you very much Giampolo
>> (and funny to see that my name is the same than yours, but in Catalan)
>>
>>  From your notes:
>>> mknod /dev/i2c-0 c 89 0
>>> modprobe i2c-dev
>>> i2cdetect -l
>>>>>> i2c-0   smbus           SMBus I801 adapter at 0400              SMBus
>>>>>> adapter
>>> i2cget 0 0x20
>> I see that you can access the chip. I will test it on monday or tuesday.
>> Do you know if we can access the N'th pin on the chip with 'i2cget 0 0x20 N'
>> (N in 0..7)?
>> And do you know if we can access these pins directly from a C program (I
>> mean without using a system call) ?
>>
>> Thanks again for your responses!
>>
