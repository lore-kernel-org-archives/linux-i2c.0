From: Laszlo Papp <lpapp-RoXCvvDuEio@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Create eeprom_dev hardware class for EEPROM devices
Date: Fri, 24 Jan 2014 20:19:19 +0000
Message-ID: <CAOMwXhP8-dUMNHU8E8Hb0wE1P25BEvcdBPEdLAzmhj+sYPR0xQ@mail.gmail.com>
References: <1390504562-20333-1-git-send-email-curt@cumulusnetworks.com>
	<CAOMwXhMfd8uw8n2Oa_BKW8UGzrUttD1L3=ATUGyDJMFy3kPUjQ@mail.gmail.com>
	<20140124192742.GU29955@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140124192742.GU29955-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Thomas De Schampheleire <patrickdepinguin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Shrijeet Mukherjee <shm-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 24, 2014 at 7:27 PM, Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org> wrote:
> On Fri Jan 24 18:42, Laszlo Papp wrote:
>> > Note: The class cannot be called 'eeprom' as that is the name of the
>> > I/O file created by the driver.  The class name appears as a
>> > sub-directory within the main device directory.  Hence the class name
>> > 'eeprom_dev'.
>>
>> I am not sure I follow the reasoning here, but it is possibly because
>> I lack some knowledge. Could you please describe bad thing would
>> happen if "/sys/class/eeprom/eeprom0/label" would be used as opposed
>> to "/sys/class/eeprom_dev/eeprom0/label"?
>
> By way of example -- let's say I have an at24 device on i2c bus 2,
> with address 0x54.  In sysfs the device can be found by its bus
> address as:
>
>   $ cd /sys/bus/i2c/devices/2-0054
>   $ ls -l
>
>   total 0
>   lrwxrwxrwx 1 root root    0 Jan 24 19:11 driver ->  ../../../../../../bus/i2c/drivers/at24
>   -rw------- 1 root root  256 Jan 23 23:33 eeprom
>   drwxr-xr-x 3 root root    0 Jan 23 23:33 eeprom_dev
>   -r--r--r-- 1 root root 4096 Jan 24 19:11 modalias
>   -r--r--r-- 1 root root 4096 Jan 24 19:11 name
>   lrwxrwxrwx 1 root root    0 Jan 24 19:11 subsystem ->  ../../../../../../bus/i2c
>   -rw-r--r-- 1 root root 4096 Jan 24 19:11 uevent
>
> The file "/sys/bus/i2c/devices/2-0054/eeprom" comes from the at24
> driver.  That is the file name the EEPROM driver exports for I/O to
> the device.  User space applications read/write this file to
> read/write the physical EEPROM via the at24 driver.
>
> The directory "/sys/bus/i2c/devices/2-0054/eeprom_dev" comes from the
> sysfs class name "eeprom_dev".  All sysfs class names appear as
> directories with the corresponding device directory.
>
> See the conflict?  If the class was also called "eeprom" it would
> clash with the existing "eeprom" file.  There cannot be two things
> named /sys/bus/i2c/devices/2-0054/eeprom.

Yes, this is more comprehensive for a newcomer, thanks.

> The files under /sys/class/eeprom_dev are symlinks to the "eeprom_dev"
> directories of the physical devices.  For this example:
>
>   $ cd /sys/class/eeprom_dev
>   $ ls -l eeprom0
>   lrwxrwxrwx 1 root root 0 Jan 23 23:33 eeprom0 -> ../../devices/soc.0/ffe03000.i2c/i2c-0/i2c-2/2-0054/eeprom_dev/eeprom0
>
> Believe me I wanted to use "eeprom" as the class name originally, as
> it makes a lot of sense.  But the sysfs file creation failed due to
> the duplicate name.
>
> I was not about to change the at24 driver as user space expects the
> "eeprom" name.
>
> Hence the class name is eeprom_dev.
>
> Hope that helps.

Yes, it does and I most certainly believe you.

I am not the maintainer of this code, nor do I have any knowledge
about the API promise in the kernel, but this case seems to be a major
upgrade to the Linux eeprom stack, and hence I would not personally
worry about compatibility.

If the API is kept, the Linux kernel will have an IMHO broken stack
for many upcoming years. IMO, the benefits of the different name does
not outweigh the disadvantages, but I will leave it with the
corresponding maintainer...
