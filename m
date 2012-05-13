From: Andriy Gapon <avg-+43SdJ71VxTsG83rWm+8vg@public.gmane.org>
Subject: Re: decode-dimms: Module Configuration Type not reported for DDR2/3
Date: Sun, 13 May 2012 22:13:02 +0300
Message-ID: <4FB007BE.8070603@icyb.net.ua>
References: <4F8C8A74.90804@icyb.net.ua> <20120417131857.4e05c67b@endymion.delvare> <4F8DCC84.2040206@icyb.net.ua> <20120418103025.46ab7446@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418103025.46ab7446-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

on 18/04/2012 11:30 Jean Delvare said the following:
> Hi Andriy,
> 
> On Tue, 17 Apr 2012 23:03:16 +0300, Andriy Gapon wrote:
>> on 17/04/2012 14:18 Jean Delvare said the following:
>>> I am attaching two patches, one for DDR2, one for DDR3, please give
>>> them a try.
>>
>> Thanks a lot!
>> I am able to test only the DDR2 part at the moment.
>> With the patch I am getting the following
>> Module Configuration Type                       Data ECC
>> for these modules: http://www.valueram.com/datasheets/kvr800d2e5_2g.pdf
>>
>> For some definitely non-ECC modules I get the expected
>> Module Configuration Type                       No Parity
> 
> Thanks for the report, I've applied both patches.

Thank you!

>> P.S.
>> I've noticed that the "Decoding EEPROM" message is printed with
>> $dimm[$current]->{eeprom} when $opt_side_by_side is true but it is printed with
>> $dimm[$current]->{file} in the other case.  Not sure if this is on purpose.
> 
> I think it is on purpose. ->{file} contains the full path so it is
> rather long, ->{eeprom} only contains the file name so it is much
> shorter. The full path would make side-by-side output very wide, that
> wouldn't be convenient, that's why the short name is used in this
> output mode. In legacy output mode, the long name fits.
> 
> We _could_ use the short name in legacy output mode, as the long name
> doesn't necessarily add a lot of value. I think I tried to leave the
> legacy output unchanged when implementing the side-by-side output, to
> avoid any regression in case someone was parsing the output of
> decode-dimms. If you believe it would be better to always use the short
> name, we could do that, this may even allow for a small code clean-up.

I don't have any strong opinion about this.  I see pros and contras for both
choices and I can not make up my mind :)

-- 
Andriy Gapon
