From: Andriy Gapon <avg-+43SdJ71VxTsG83rWm+8vg@public.gmane.org>
Subject: Re: decode-dimms: Module Configuration Type not reported for DDR2/3
Date: Tue, 17 Apr 2012 23:03:16 +0300
Message-ID: <4F8DCC84.2040206@icyb.net.ua>
References: <4F8C8A74.90804@icyb.net.ua> <20120417131857.4e05c67b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120417131857.4e05c67b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

on 17/04/2012 14:18 Jean Delvare said the following:
> Hi Andriy,
> 
> On Tue, 17 Apr 2012 00:09:08 +0300, Andriy Gapon wrote:
>> It seems that Module Configuration Type ("ECC", "No Parity", etc) is not
>> reported for DDR2 and DDR3 module types.  Not sure if resolution could be as
>> easy as adding sdram_module_configuration_type() calls in the corresponding
>> decode procedures.
> 
> Won't be so easy. For DDR2 there is one new bit to decode
> (Address/Command Parity). For DDR3 byte 11 has a completely different
> meaning, and the information seem to be no longer available. As I read
> the specification, the only way to tell if a DDR3 module has any form
> of parity or ECC is to check the extra bus width in bits 4-3 of byte 8.
> But this is a boolean type of information then, telling "there is some
> form of data error detection/correction". No way to tell between parity
> and ECC AFAICS, and information about Address/Command Parity is gone
> too.
> 
> I am attaching two patches, one for DDR2, one for DDR3, please give
> them a try.
> 

Thanks a lot!
I am able to test only the DDR2 part at the moment.
With the patch I am getting the following
Module Configuration Type                       Data ECC
for these modules: http://www.valueram.com/datasheets/kvr800d2e5_2g.pdf

For some definitely non-ECC modules I get the expected
Module Configuration Type                       No Parity

P.S.
I've noticed that the "Decoding EEPROM" message is printed with
$dimm[$current]->{eeprom} when $opt_side_by_side is true but it is printed with
$dimm[$current]->{file} in the other case.  Not sure if this is on purpose.

-- 
Andriy Gapon
