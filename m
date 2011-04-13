From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: Decode dimms on dual socket machines
Date: Wed, 13 Apr 2011 08:13:54 +0200
Message-ID: <4DA53F22.5020105@gmx.de>
References: <4DA4250A.3060907@fuckner.net>	<20110412132611.045ace21@endymion.delvare>	<4DA44B05.906@fuckner.net> <20110412155345.4644e51c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110412155345.4644e51c-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare said the following:
>> Now I loaded the module
>> 
>> test24:/media/i2c-tools/tools # lsmod |grep pca
>> pca954x                 3288  0
>> i2c_mux                 2672  1 pca954x
>> test24:/media/i2c-tools/tools # ll /sys/bus/i2c/devices/
>> total 0
>> lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0050 -> 
>> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0050
>> lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0052 -> 
>> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0052
>> lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0054 -> 
>> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0054
>> lrwxrwxrwx 1 root root 0 Apr 12 13:54 i2c-0 -> 
>> ../../../devices/pci0000:00/0000:00:1f.3/i2c-0
> 
> Loading the pca954x driver doesn't do anything. It needs an
> instantiated device with proper platform data before it will do
> anything. This can only be done from within the kernel, using some sort
> of platform initialization code.

I would expect a
#> echo "<deviceName> 0x70" > /sys/bus/i2c/devices/i2c-0/new_device
to span new buses, their numbers taken by random, even without platform
data (not tried by myself yet, but will have to do it soon).
The challenge will be to detect which of the 8 supported devices (
pca_9540, pca_9542, pca_9543, pca_9544, pca_9545, pca_9546, pca_9547,
pca_9548) is actually to be used.

JM2C
-- 
KR
Michael
