From: Martin Schroeder <mkschreder.uk@googlemail.com>
Subject: i2c driver for ch341 usb to i2c converter
Date: Tue, 1 Mar 2016 17:02:38 +0100
Message-ID: <CAGmj6quZaOXEj__Pj+s+NJhRQJRnzkMPGtEacpEpW++YaKsXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34916 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbcCAQCj (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 1 Mar 2016 11:02:39 -0500
Received: by mail-qg0-f53.google.com with SMTP id y89so145330947qge.2
        for <linux-i2c@vger.kernel.org>; Tue, 01 Mar 2016 08:02:38 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

I have gathered information and started working on a driver for for
this i2c converter chip from china (see link below for an image of
what it looks like). It is a chip that was surprisingly difficult to
find information on. I found some code online that was a good start
for working on this driver, however the original code was attempting
to read the chip after every write which was obviously always timing
out because there was no data to read. So I changed this and it now
works a lot faster.

I'm making this driver available as part of my kernel packages repo
for openwrt. The actual driver source code is here:
https://github.com/mkschreder/mks-openwrt-kernel-feed/tree/master/ch341-i2c/src

I'm looking for more people who are willing to test this driver.

My driver is tested for driving an oled display over this converter:
https://github.com/mkschreder/hack-ssd1306-openwrt/raw/master/screenshot.jpg

- Reading is not implemented yet, however there is example code in the
package directory.
- I2c messages have a 2ms gap between them (still though it works a
lot better than before). I'm not sure if there is a way to code this
driver to avoid gap completely (i'm thankful for any input on this).

Docs for this chip are also in the repo (one level up from where
driver code is).
