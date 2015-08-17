From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Mon, 17 Aug 2015 14:01:24 +0100
Message-ID: <55D1DB24.8090602@linaro.org>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch> <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de> <20150816131130.GC10094@lunn.ch> <1511754934.28154.1439739426390.JavaMail.open-xchange@oxbsltgw00.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1511754934.28154.1439739426390.JavaMail.open-xchange-0SF9iQWekqLZ78VGacPtK8gmgJlYmuWJ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


+Adding Maxime in the loop

On 16/08/15 16:37, Stefan Wahren wrote:
>> >Another question which spring to mind is, do we want the eeprom to be
>> >in /sys twice, the old and the new way? Backwards compatibility says
>> >the old must stay. Do we want a way to suppress the new? Or should we
>> >be going as far as refractoring the code into a core library, and two
>> >wrapper drivers, old and new?
> I think these are questions for the framework maintainers.
>
One of the reasons for the NVMEM framework is to remove that duplicate 
code in the every driver.  There was no framework/ABI which was guiding 
such old eeprom sysfs entry in first place, so I dont see an issue in 
removing it for good. Correct me if am wrong.

IMHO, its better to move on with nvmem for good reasons, rather than 
having two sysfs binary files.

--srini
