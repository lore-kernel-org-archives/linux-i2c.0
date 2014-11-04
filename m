From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create proper topology in sysfs
Date: Tue, 4 Nov 2014 01:07:08 -0800
Message-ID: <CAAVjN7dPet_nBHcQzPYknfiWnf1hD5d5NAJcrNEKKJHYHcBNkg@mail.gmail.com>
References: <1414960809-16860-1-git-send-email-wsa@the-dreams.de>
	<20141103205534.GA18937@roeck-us.net>
	<20141103210200.GA6242@katana>
	<20141103221850.GA16026@roeck-us.net>
	<20141104073306.GB1887@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141104073306.GB1887@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a tool I have been developing for complex I2C bus structures
(lsi2c) the output of this should help with this complex multiplexer
testing. I was able to overcome the problem by creating persistent
paths describing where the devices reside. I will be testing
compatibility with this setup. I will be reporting on my test results
within a few days.

[root@p2020 ~]# ./lsi2c -h
Usage: lsi2c [OPTION]...
  -c, --config-file     Specify a config file
  -C, --print-config    Display i2c devices in configuration file
  -a, --all             Print all i2c-devs in bus tree
  -d, --print-devices   Display sysfs i2c devices
  -t, --tree            Print i2c bus and children
  -p, --path            Parse an i2c-dev path
  -P, --probe           Probe an i2c-dev at addr on path
  -F, --func            Print I2C bus functionality
  -T, --timeout         Set adapter timeout in milliseconds
  -S, --retry-count     Set adapter max retry count
  -h, --help            Display this help text
  -V, --version         Display the program version
  -v, --verbose         Be verbose
  -i, --initialize      Initialize devices in configuration file
  -r, --remove          Remove devices in configuration file
  -k, --kmod            Try to initialize i2c_dev kernel module

Use `-' after `-c' to read the config file from stdin.

[root@p2020 ~]# ./lsi2c -v
Searching for i2c devices
I2C Adapters:
bus: i2c-0 path: 0               type: i2c name: MPC adapter at
0xffe03000 parent: ffe03000.i2c
bus: i2c-2 path: 0:0.0           type: mux name: i2c-0-mux (chan_id 0)
parent: i2c-0
bus: i2c-3 path: 0:0.1           type: mux name: i2c-0-mux (chan_id 1)
parent: i2c-0
bus: i2c-4 path: 0:0.2           type: mux name: i2c-0-mux (chan_id 2)
parent: i2c-0
bus: i2c-5 path: 0:0.3           type: mux name: i2c-0-mux (chan_id 3)
parent: i2c-0
bus: i2c-6 path: 0:0.4           type: mux name: i2c-0-mux (chan_id 4)
parent: i2c-0
bus: i2c-7 path: 0:0.5           type: mux name: i2c-0-mux (chan_id 5)
parent: i2c-0
bus: i2c-8 path: 0:0.6           type: mux name: i2c-0-mux (chan_id 6)
parent: i2c-0
bus: i2c-9 path: 0:0.7           type: mux name: i2c-0-mux (chan_id 7)
parent: i2c-0
bus: i2c-1 path: 1               type: i2c name: MPC adapter at
0xffe03100 parent: ffe03100.i2c
bus: i2c-10 path: 1:0.0           type: mux name: i2c-1-mux (chan_id
0) parent: i2c-1
bus: i2c-11 path: 1:0.1           type: mux name: i2c-1-mux (chan_id
1) parent: i2c-1
bus: i2c-18 path: 1:0.1:0.0       type: mux name: i2c-11-mux (chan_id
0) parent: i2c-11
bus: i2c-12 path: 1:0.2           type: mux name: i2c-1-mux (chan_id
2) parent: i2c-1
bus: i2c-40 path: 1:0.2:0.0       type: mux name: i2c-12-mux (chan_id
0) parent: i2c-12
bus: i2c-41 path: 1:0.2:0.0:0.0   type: mux name: i2c-40-mux (chan_id
0) parent: i2c-40
bus: i2c-42 path: 1:0.2:0.0:0.1   type: mux name: i2c-40-mux (chan_id
1) parent: i2c-40
bus: i2c-43 path: 1:0.2:0.0:0.2   type: mux name: i2c-40-mux (chan_id
2) parent: i2c-40
bus: i2c-44 path: 1:0.2:0.0:0.3   type: mux name: i2c-40-mux (chan_id
3) parent: i2c-40
bus: i2c-45 path: 1:0.2:0.0:0.4   type: mux name: i2c-40-mux (chan_id
4) parent: i2c-40
bus: i2c-46 path: 1:0.2:0.0:0.5   type: mux name: i2c-40-mux (chan_id
5) parent: i2c-40
bus: i2c-47 path: 1:0.2:0.0:0.6   type: mux name: i2c-40-mux (chan_id
6) parent: i2c-40
bus: i2c-48 path: 1:0.2:0.0:0.7   type: mux name: i2c-40-mux (chan_id
7) parent: i2c-40
bus: i2c-49 path: 1:0.2:0.0:1.0   type: mux name: i2c-40-mux (chan_id
0) parent: i2c-40
bus: i2c-50 path: 1:0.2:0.0:1.1   type: mux name: i2c-40-mux (chan_id
1) parent: i2c-40
bus: i2c-51 path: 1:0.2:0.0:1.2   type: mux name: i2c-40-mux (chan_id
2) parent: i2c-40
bus: i2c-52 path: 1:0.2:0.0:1.3   type: mux name: i2c-40-mux (chan_id
3) parent: i2c-40
bus: i2c-53 path: 1:0.2:0.0:1.4   type: mux name: i2c-40-mux (chan_id
4) parent: i2c-40
bus: i2c-54 path: 1:0.2:0.0:1.5   type: mux name: i2c-40-mux (chan_id
5) parent: i2c-40
bus: i2c-55 path: 1:0.2:0.0:1.6   type: mux name: i2c-40-mux (chan_id
6) parent: i2c-40
bus: i2c-56 path: 1:0.2:0.0:1.7   type: mux name: i2c-40-mux (chan_id
7) parent: i2c-40
bus: i2c-13 path: 1:0.3           type: mux name: i2c-1-mux (chan_id
3) parent: i2c-1
bus: i2c-23 path: 1:0.3:0.0       type: mux name: i2c-13-mux (chan_id
0) parent: i2c-13
bus: i2c-24 path: 1:0.3:0.0:0.0   type: mux name: i2c-23-mux (chan_id
0) parent: i2c-23
bus: i2c-25 path: 1:0.3:0.0:0.1   type: mux name: i2c-23-mux (chan_id
1) parent: i2c-23
bus: i2c-26 path: 1:0.3:0.0:0.2   type: mux name: i2c-23-mux (chan_id
2) parent: i2c-23
bus: i2c-27 path: 1:0.3:0.0:0.3   type: mux name: i2c-23-mux (chan_id
3) parent: i2c-23
bus: i2c-28 path: 1:0.3:0.0:0.4   type: mux name: i2c-23-mux (chan_id
4) parent: i2c-23
bus: i2c-29 path: 1:0.3:0.0:0.5   type: mux name: i2c-23-mux (chan_id
5) parent: i2c-23
bus: i2c-30 path: 1:0.3:0.0:0.6   type: mux name: i2c-23-mux (chan_id
6) parent: i2c-23
bus: i2c-31 path: 1:0.3:0.0:0.7   type: mux name: i2c-23-mux (chan_id
7) parent: i2c-23
bus: i2c-32 path: 1:0.3:0.0:1.0   type: mux name: i2c-23-mux (chan_id
0) parent: i2c-23
bus: i2c-33 path: 1:0.3:0.0:1.1   type: mux name: i2c-23-mux (chan_id
1) parent: i2c-23
bus: i2c-34 path: 1:0.3:0.0:1.2   type: mux name: i2c-23-mux (chan_id
2) parent: i2c-23
bus: i2c-35 path: 1:0.3:0.0:1.3   type: mux name: i2c-23-mux (chan_id
3) parent: i2c-23
bus: i2c-36 path: 1:0.3:0.0:1.4   type: mux name: i2c-23-mux (chan_id
4) parent: i2c-23
bus: i2c-37 path: 1:0.3:0.0:1.5   type: mux name: i2c-23-mux (chan_id
5) parent: i2c-23
bus: i2c-38 path: 1:0.3:0.0:1.6   type: mux name: i2c-23-mux (chan_id
6) parent: i2c-23
bus: i2c-39 path: 1:0.3:0.0:1.7   type: mux name: i2c-23-mux (chan_id
7) parent: i2c-23
bus: i2c-14 path: 1:0.4           type: mux name: i2c-1-mux (chan_id
4) parent: i2c-1
bus: i2c-19 path: 1:0.4:0.0       type: mux name: i2c-14-mux (chan_id
0) parent: i2c-14
bus: i2c-15 path: 1:0.5           type: mux name: i2c-1-mux (chan_id
5) parent: i2c-1
bus: i2c-20 path: 1:0.5:0.0       type: mux name: i2c-15-mux (chan_id
0) parent: i2c-15
bus: i2c-16 path: 1:0.6           type: mux name: i2c-1-mux (chan_id
6) parent: i2c-1
bus: i2c-21 path: 1:0.6:0.0       type: mux name: i2c-16-mux (chan_id
0) parent: i2c-16
bus: i2c-17 path: 1:0.7           type: mux name: i2c-1-mux (chan_id
7) parent: i2c-1
bus: i2c-22 path: 1:0.7:0.0       type: mux name: i2c-17-mux (chan_id
0) parent: i2c-17
Count: 57
[root@p2020 ~]# ./lsi2c -v -d
Searching for i2c devices
I2C Devices:
bus=0 type=i2c bus_path=0               address=0x70 name=pca9548
   driver=pca954x         module=(null)
bus=6 type=mux bus_path=0:0.4           address=0x68 name=ds1339
  driver=rtc-ds1307     module=(null)
bus=1 type=i2c bus_path=1               address=0x74 name=pca9548
   driver=pca954x         module=(null)
bus=11 type=mux bus_path=1:0.1           address=0x73 name=pca9541
    driver=pca9541         module=(null)
bus=12 type=mux bus_path=1:0.2           address=0x70 name=pca9541
    driver=pca9541         module=(null)
bus=40 type=mux bus_path=1:0.2:0.0       address=0x73 name=pca9547
    driver=pca954x         module=(null)
bus=40 type=mux bus_path=1:0.2:0.0       address=0x71 name=pca9547
    driver=pca954x         module=(null)
bus=13 type=mux bus_path=1:0.3           address=0x70 name=pca9541
    driver=pca9541         module=(null)
bus=23 type=mux bus_path=1:0.3:0.0       address=0x73 name=pca9547
    driver=pca954x         module=(null)
bus=23 type=mux bus_path=1:0.3:0.0       address=0x71 name=pca9547
    driver=pca954x         module=(null)
bus=14 type=mux bus_path=1:0.4           address=0x73 name=pca9541
    driver=pca9541         module=(null)
bus=15 type=mux bus_path=1:0.5           address=0x73 name=pca9541
    driver=pca9541         module=(null)
bus=16 type=mux bus_path=1:0.6           address=0x73 name=pca9541
    driver=pca9541         module=(null)
bus=17 type=mux bus_path=1:0.7           address=0x73 name=pca9541
    driver=pca9541         module=(null)
Count: 10


On Mon, Nov 3, 2014 at 11:33 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> > What is your muxing setup?
>> >
>> Complicated ;-).
>
> ...
>
> Ooooookay... well, for testing these patches, your setup is absolutely
> awesome, of course :D May I ask what you are doing with that amount of
> I2C?
>



-- 
- Danielle Costantino
