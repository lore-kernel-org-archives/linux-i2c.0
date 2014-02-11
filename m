From: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Create eeprom_dev hardware class for EEPROM devices
Date: Tue, 11 Feb 2014 13:03:05 +0000
Message-ID: <CAOMwXhMu5gW5cjTSW9qe-DNUA1isNNoghn=E5CgWoM4AcOw2TQ@mail.gmail.com>
References: <1390504562-20333-1-git-send-email-curt@cumulusnetworks.com>
	<52E303FF.2010808@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52E303FF.2010808-3s7WtUTddSA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thomas De Schampheleire <patrickdepinguin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Shrijeet Mukherjee <shm-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Jan 25, 2014 at 12:23 AM, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org> wrote:
> On 01/23/2014 11:16 AM, Curt Brune wrote:
>> Create a new hardware class under /sys/class/eeprom_dev
>>
>> EEPROM drivers can register their devices with the eeprom_dev class
>> during instantiation.
>>
>> The registered devices show up as:
>>
>>   /sys/class/eeprom_dev/eeprom0
>>   /sys/class/eeprom_dev/eeprom1
>>   ...
>>   /sys/class/eeprom_dev/eeprom[N]
>>
>> Each member of the eeprom class exports a sysfs file called "label",
>> containing the label property from the corresponding device tree node.
>>
>> Example:
>>
>>   /sys/class/eeprom_dev/eeprom0/label
>>
>> If the device tree node property "label" does not exist the value
>> "unknown" is used.
>>
>> Note: The class cannot be called 'eeprom' as that is the name of the
>> I/O file created by the driver.  The class name appears as a
>> sub-directory within the main device directory.  Hence the class name
>> 'eeprom_dev'.
>>
>> Userspace can use the label to identify what the EEPROM is for.
>
> Since my previous email [1] seems to have vanished into the void, I'll
> try again more succinctly:
>
> How will this work on non device tree / openfirmware systems?
>
> Is there a better way to expose topology information (i.e. that the
> eeprom belongs to another device that might not live on the i2c bus at all)?
>
> Can we expose type information?  There's a big difference between SPD
> EEPROMs, EDID EEPROMs, and nic mac-address-containing EEPROMs, for example.

I personally do not see major issues for improving that, but it might
be just me.
