From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v5 0/3] Enable ACPI-defined peripherals on i2c-piix4 SMBus
Date: Tue, 20 Aug 2019 12:42:27 +0200
Message-ID: <82cd0682-91db-6afd-855c-2c2f4b329eda@metux.net>
References: <20190802145109.38dd4045@endymion>
 <b013c33b-da11-ce5e-08d4-0b24a8575109@metux.net>
 <db725a3b-7b6e-ac79-ef1c-e601ff45c0f2@rationali.st>
 <9019cce9-837f-97fc-0f3b-7503b8fc3717@metux.net>
 <20190819185334.GA9762@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819185334.GA9762@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: acooks@rationali.st, Jean Delvare <jdelvare@suse.de>, Linux I2C <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>, Guenter Roeck <linux@roeck-us.net>, Will Wagner <willw@carallon.com>
List-Id: linux-i2c@vger.kernel.org

On 19.08.19 20:53, Wolfram Sang wrote:
> 
> Just so I get this correct: This is all about instantiating the devices
> sitting on the SMBus,

Yes, I'm struggling to find out which devices are connected to the
smbus, in case there're some already inside the SoC (instead of just
entirely board specific).

> but you are okay with Jean's patches? Or is this
> discussion affecting patch 3? (/me knows not much about ACPI'n'stuff)

I'm fine with them, just wondered whether BIOS needs to add some extra
support for the probing, that is not already somehow coming w/ aegesa.

Unfortunately, we cannot rely on board vendors to do that right and
cope w/ old and incomplete firmware. (that's also the reason why I'm
*not* using acpi gpio entries for the apu2+ board family).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
