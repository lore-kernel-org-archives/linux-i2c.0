From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 19:50:29 +0100
Message-ID: <20170104195029.0b7c660d@endymion>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
        <201701032105.51144@pali>
        <20170103202418.GE16032@dtor-ws>
        <201701032139.13061@pali>
        <20170103205937.GA2289@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170103205937.GA2289@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 3 Jan 2017 12:59:37 -0800, Dmitry Torokhov wrote:
> On Tue, Jan 03, 2017 at 09:39:13PM +0100, Pali Rohár wrote:
> > Some distributions blacklist i2c-i801.ko module... And 
> 
> Any particular reason for that?

At some point in time, the i2c-i801 driver caused problems on a few
systems. They decided that blacklisting the driver for everybody was
the easiest way to fix the problem. Of course this doesn't make any
sense and should be reverted. The root cause of the problem should have
been investigated back then. Maybe it's fixed by now and they will
never now...

-- 
Jean Delvare
SUSE L3 Support
