From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Wed, 4 Jan 2017 11:18:17 +0100
Message-ID: <20170104111817.663236ae@endymion>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
        <201612291517.37474@pali>
        <20161229210932.GA1254@kmp-mobile.hq.kempniu.pl>
        <201612292228.18706@pali>
        <20170103090641.GH5767@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170103090641.GH5767@mail.corp.redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?UTF-8?B?TWljaGE=?= =?UTF-8?B?xYIgS8SZcGllxYQ=?= <kernel@kempniu.pl>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 3 Jan 2017 10:06:41 +0100, Benjamin Tissoires wrote:
> On Dec 29 2016 or thereabouts, Pali Rohár wrote:
> > So 4d5538f5882a is breaking lis3lv02d driver...
> 
> Apologies for that.
> 
> I could easily fix this by adding a kernel API to know whether the
> provided irq is from Host Notify or if it was coming from an actual
> declaration. However, I have no idea how many other drivers would
> require this (hopefully only this one).
> 
> One other solution would be to reserve the Host Notify IRQ and let the
> actual drivers that need it to set it, but this was not the best
> solution according to Dmitri. On my side, I am not entirely against this
> given that it's a chip feature, so the driver should be able to know
> that it's available.
> 
> Dmitri, Wolfram, Jean, any preferences?

I did not look at your work so I do not feel qualified to give advice
on the proper way. I trust you to make the right decision :-)

-- 
Jean Delvare
SUSE L3 Support
