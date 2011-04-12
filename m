From: Michael Fuckner <michael-iWcS09LKDTLR7s880joybQ@public.gmane.org>
Subject: Re: Decode dimms on dual socket machines
Date: Tue, 12 Apr 2011 14:52:21 +0200
Message-ID: <4DA44B05.906@fuckner.net>
References: <4DA4250A.3060907@fuckner.net> <20110412132611.045ace21@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110412132611.045ace21-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/12/2011 01:26 PM, Jean Delvare wrote:
Hi all,

> Note that you will need a recent enough kernel (>= 2.6.36) to have
> support for SMBus multiplexing.
currently I use OpenSUSE11.4 with 2.6.37.1-1.2-default


> FWIW, address 0x70 is used by the PCA954x multiplexers, so maybe this
> is what you have (and a driver is available).
>
> At 0x2f is probably a W83793 or W83795 monitoring chip, supported by
> the w83793 and w83795 drivers, respectively. Only use these dedicated
> drivers if you do not intend to use the IPMI features of the board.
>
>> 18,1a,1c: jc42 temperature sensors
>> 50,52,54: eeproms
>


Now I loaded the module

test24:/media/i2c-tools/tools # lsmod |grep pca
pca954x                 3288  0
i2c_mux                 2672  1 pca954x
test24:/media/i2c-tools/tools # ll /sys/bus/i2c/devices/
total 0
lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0050 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0050
lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0052 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0052
lrwxrwxrwx 1 root root 0 Apr 12 14:26 0-0054 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0/0-0054
lrwxrwxrwx 1 root root 0 Apr 12 13:54 i2c-0 -> 
../../../devices/pci0000:00/0000:00:1f.3/i2c-0

Seems like this is what I need to know, but I don't know how to 
interpret it. Is it multiplexed on the GPIO Pin 52 and 53 at the W83795ADG?

ftp://ftp.supermicro.com/utility/SuperoDoctorINI/AllMEMDIMM.ini

Regards,
  Michael!
