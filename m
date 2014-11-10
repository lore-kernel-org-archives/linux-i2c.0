From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Mon, 10 Nov 2014 21:57:04 +0100
Message-ID: <20141110215704.07d7ca1d@endymion.delvare>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de>
	<20141103205534.GA18937@roeck-us.net>
	<20141103210200.GA6242@katana>
	<20141103221850.GA16026@roeck-us.net>
	<20141104073306.GB1887@katana>
	<CAAVjN7dPet_nBHcQzPYknfiWnf1hD5d5NAJcrNEKKJHYHcBNkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAVjN7dPet_nBHcQzPYknfiWnf1hD5d5NAJcrNEKKJHYHcBNkg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Danielle,

On Tue, 4 Nov 2014 01:07:08 -0800, Danielle Costantino wrote:
> This is a tool I have been developing for complex I2C bus structures
> (lsi2c) the output of this should help with this complex multiplexer
> testing. I was able to overcome the problem by creating persistent
> paths describing where the devices reside. I will be testing
> compatibility with this setup. I will be reporting on my test results
> within a few days.
> 
> [root@p2020 ~]# ./lsi2c -h
> Usage: lsi2c [OPTION]...
>   -c, --config-file     Specify a config file
>   -C, --print-config    Display i2c devices in configuration file
>   -a, --all             Print all i2c-devs in bus tree
>   -d, --print-devices   Display sysfs i2c devices
>   -t, --tree            Print i2c bus and children
>   -p, --path            Parse an i2c-dev path
>   -P, --probe           Probe an i2c-dev at addr on path
>   -F, --func            Print I2C bus functionality
>   -T, --timeout         Set adapter timeout in milliseconds
>   -S, --retry-count     Set adapter max retry count
>   -h, --help            Display this help text
>   -V, --version         Display the program version
>   -v, --verbose         Be verbose
>   -i, --initialize      Initialize devices in configuration file
>   -r, --remove          Remove devices in configuration file
>   -k, --kmod            Try to initialize i2c_dev kernel module
> 
> Use `-' after `-c' to read the config file from stdin.

Is the source code of this tool available somewhere?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
