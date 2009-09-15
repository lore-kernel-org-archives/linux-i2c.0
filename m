From: "Dan Mor" <dmor-ukWli4Tkv9rQT0dZR+AlfA@public.gmane.org>
Subject: ds1682
Date: Tue, 15 Sep 2009 21:05:01 +0300
Message-ID: <000001ca362f$0ef74790$2ce5d6b0$@com>
Reply-To: <dmor-ukWli4Tkv9rQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-us
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Guys,
 
I am trying to use ds1682 Linux driver under 2.6.27.30 Fedora Core 10
Kernel.
I am new to sysfs driver approach. I successfully compiled the module and
loaded it. 
 
The device doesn't recognized by default and no sub directories created.
I add insmode parameters to the driver and loading it with force=i2c_bus,
i2c_address  parameters. 
In this case, it works.
 
I can read/write from/to devices by: cat /sys/..../elapsed_time, etc.
 
My question is, how can I read/write from/to sysfs from the C test
application?
I am trying to: "open" "/sys/..../elapsed_time" and "read" from it but
apparently I am doing something wrong.
Do you have some C code examples of how to communicate with sysfs devices? 
 
Regards,
Dan
