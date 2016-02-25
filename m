From: Ido Reis <ido.reis@gmail.com>
Subject: i2c-gpio slave support
Date: Thu, 25 Feb 2016 19:53:44 +0200
Message-ID: <CAACqyoFWnacy9nPfDtqnJg=BjeujDv+ddZXDn8ZjD_aTduf-cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38525 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933285AbcBYRxp (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 25 Feb 2016 12:53:45 -0500
Received: by mail-wm0-f46.google.com with SMTP id a4so38610853wme.1
        for <linux-i2c@vger.kernel.org>; Thu, 25 Feb 2016 09:53:45 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi i2c Experts,

I want to implement a slave device using gpio on my DragonBoard
410c/RaspberryPi.
As a start, I intend to use the i2c-slave-eeprom as the slave device
itself, and wanted to use the i2c-gpio as the bus device.
It looks like that the i2c-gpio does not support slave functionalities
(actually I was wondering why as it should be pretty much straight
forward).
Is there such implementation (couldn't find any in the list history)?
Are there any restrictions to implement one?

Thanks,
Ido
