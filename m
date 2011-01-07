From: Joan Pau Beltran <joanpau.beltran-i5CWTa81U/w@public.gmane.org>
Subject: Re: pca953x GPIO
Date: Fri, 07 Jan 2011 18:34:03 +0100
Message-ID: <4D274E8B.8050600@uib.cat>
References: <4D0B9C35.5000802@uib.cat> <AANLkTi=LQ56S43=BL8tdo=MakP-PRzVK0ieJM07y_O_1@mail.gmail.com> <4D14C6D1.3030802@uib.cat> <AANLkTinSuVYAVQqPHRtrnTPrtEZA1aCHOb6X4H8u2OW1@mail.gmail.com> <4D1A0A95.7020408@uib.cat> <20110106162213.4e5ee5b4@endymion.del vare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110106162213.4e5ee5b4-R0o5gVi9kd4wFzbXFV0ICA@public.gmane.org vare>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Giampaolo Bellini <iw2lsi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello everyone!

Al 06/01/11 16:22, En/na Jean Delvare ha escrit:
> On Tue, 28 Dec 2010 17:04:37 +0100, Joan Pau Beltran wrote:
>> Now i2cdump give this output
>> (all lines except the first one stripped because they are empty):
>>
>> i2cdump -y 2 0x20
>> No size specified (using byte-data access)
>>        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
>> 00: ff ff ff ff 00 00 ff ff XX XX XX XX XX XX XX XX    ........XXXXXXXX
>>
>> I am surprised about these values. The port has 8 gpio pins available,
>> so it seems their addresses are the ones in 000-007
>> (or shoud I say they are represented in the chip's register 000-007?).
> No, it doesn't work like that. You'll have to download the datasheet
> for your GPIO chip from nxp.com, to find out the meaning of each
> register. The details are normally hidden from you if you use the
> pca953x driver, but as you decided to go the hard way...
You are right. I noticed that after playing around with the chip and the 
demo application from Advantech (for windows only). Then I went straight 
to the chip's data sheet and found each register's function.

The chip has 2 input/output ports (port0 and port1), each one with 8 
GPIO pins
(so it seems that only the first one is available for the user with 
these board).
The eight registers are for (respectively) Input0 (0), Input1(1), 
Output0 (2), Output1 (3), Polarity Inversion0 (4), Polarity Inversion1 
(5), Direction0 (6) and Direction1 (7).
The byte in each register represent the state of the eight pins as a 
bitmask.
To read the state of a pin (no matter if it is an input or output pin) 
you should read the register 0 (0xff mean all pins high, 0x00 means all 
pins low, 0xf0 means the first four pins low and the other four pins 
high, etc).
The direction of each pin may be set the same way with the register 6 (1 
means input and 0 means output, so setting the register to 0xf0 means 
the first four pins are for output and the other for for input, etc).
The polarity inversion for each pin may be set the same way but with 
register 4.
To set the state of the output pins you should write to the register 2 
the bitmask representing the pins you want to bring up (if you want to 
raise pins 0 and 1 you should write 0x03, etc).

I think we will do the things this way (with i2c-dev and reading the 
chip's registers) because the code to read the state of the pins is 
simple and we do not need to recompile the kernel. The cost is that root 
privileges will be needed to manage the GPIO. But I agree that a more 
elegant way could be adding platform code for the kernel and use the 
sysfs interface, allowing non-root access to the GPIO.

>> (...)
>> It seems that I should add i2c-dev and i2c-i801 to my /etc/modules.
>> Can someone confirm that? Would it be better to make udev load them
>> automatically?
>> How can this be done?
> i2c-i801 should get loaded automatically, as it is a PCI driver. If it
> isn't on your system, make sure you didn't blacklist it. The following
> command may help:
>
> $ /sbin/modprobe -c | grep i2c_i801
This is the above command's output:

modprobe -c | grep i2c_i801

blacklist i2c_i801
alias pci:v00008086d00001C22sv*sd*bc*sc*i* i2c_i801
...

And more alias. So the module is effectively blacklisted. In  
/etc/modprobe.d/blacklist.conf we found

# causes failure to suspend on HP compaq nc6000 (Ubuntu: #10306)
blacklist i2c_i801

Commenting the line should allow automatic loading of the module.

Thank you very much everyone for this discussion, specially Giampolo and 
Jean.
Your help has been invaluable.
