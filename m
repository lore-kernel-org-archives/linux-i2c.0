From: Thomas Zimmermann <tdz@users.sourceforge.net>
Subject: Re: [PATCH] i2c: Raise SDA for each received bit, if necessary
Date: Fri, 13 May 2016 18:06:53 +0200
Message-ID: <5735FB9D.2060300@users.sourceforge.net>
References: <1461780714-20378-1-git-send-email-tdz@users.sourceforge.net>
 <20160512090544.GB1638@katana> <5734AD00.3050904@users.sourceforge.net>
 <20160513103355.GE1778@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160513103355.GE1778@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

Am 13.05.2016 um 12:33 schrieb Wolfram Sang:
> 
>> I was playing with the DRM framework and an old SiS graphics card. I
>> discovered this issue while trying to read the EDID from the monitor.
> 
> So, there is no upstream user yet?

No.

>> I have a few other SiS cards/models here and they all expose this
>> behavior. So I guess it's intentional(==cheaper?), although the HW docs
>> don't seem mention it explicitly.
> 
> OK. Well. As this flag is potentially dangerous, I would prefer to not
> apply the patch unless there is an upstream user of this. If there is
> one, I'd be okay with applying it with the flag renamed to something
> like "dangerous_push_pull_bus" or similar with additional comments
> saying there is some (broken) HW which needs it but nobody should get
> the idea to design a bus like this.
> 
> Makes sense?

Sure, thanks!

Best regards
Thomas

> Regards,
> 
>    Wolfram
> 


-- 
GnuPG:          http://tdz.users.sourceforge.net/tdz.asc
Fingerprint:    16FF F599 82F8 E5AA 18C6 5220 D9DA D7D4 4EF1 DF08
