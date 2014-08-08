From: Angelo Compagnucci <angelo.compagnucci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Advice on AT24MAC driver
Date: Fri, 8 Aug 2014 17:37:58 +0200
Message-ID: <CA+TH9VnUJM-7d6SmrF67DoFpv_y96d+byKhnnq8B2Jyr0ge4fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi List,

I'm interested in developing a driver for the AT24MAC EEPROM from
Atmel. This chip is a strange beast because it integrates two i2c
devices with two different addresses in the same package.

It has this structure:

* The first part of the chip is a classical AT24 eeprom (2K) with a
standard address, 0xA radix + 3bits for multiple addressing.
* The second part contains a 128 bits serial number + a 48/64 bits
(depending on the model) MAC address (usable for example as ethernet
mac). The address has 0xB radix + 3bits for multiple addressing.
While this second eeprom is readable with the standard AT24 i2c
protocol, the registers are a little bit crazy: the 128 bits serial
number is in range 80h-8Fh, the 48bits mac is in 9Ah-9Fh, the 64bits
mac (the other model) is in rage 98h-9Fh.

The problem here is that you have to know exactly the registers to
read and their boundaries to get both the numbers, this is driving me
writing a new kernel driver.
I think that adding so much complexity to the already complex AT24
driver is not advisable and writing a fairly basic new driver respect
better the KISS way.
Obviously, I will export both serials with a couple of sysfs attributes.

With the right mentoring, I can try to export this 48bits MAC to the
network layer to be usable by a network card.

Have you any advice on this?

-- 
Profile: http://it.linkedin.com/in/compagnucciangelo
