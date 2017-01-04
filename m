From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Tue, 3 Jan 2017 22:36:42 -0800
Message-ID: <20170104063642.GA20545@dtor-ws>
References: <1482843136-12838-1-git-send-email-pali.rohar@gmail.com>
 <20170103090641.GH5767@mail.corp.redhat.com>
 <20170103183843.GA16032@dtor-ws>
 <201701031950.17389@pali>
 <20170103194812.GD16032@dtor-ws>
 <20170103212934.GK5767@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103212934.GK5767@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario_Limonciello@dell.com, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 03, 2017 at 10:29:34PM +0100, Benjamin Tissoires wrote:
> On Jan 03 2017 or thereabouts, Dmitry Torokhov wrote:
>
> > Yet another option: can we add a new flag to i2c_board_info controlling
> > whether we want to enable/disable wiring up host notify interrupt?
> 
> That should be fairly easy to implement. For now, given that only Elan
> and Synaptics are the one in need for Host Notify, it could be better to
> request the Host Notify IRQ instead of disabling it unconditionally
> (which would make the current yet 8 years old lis3lv02d driver happy
> again).

I like that we have it done in i2c core instead of having drivers
implementing it individually. Since you are saying that handling host
notify is property of the slave/driver maybe we should be adding a flag
to the *i2c_driver* structure to let i2c core that we want to have host
notify mapped as interrupt if "native" interrupt is not supplied by the
platform code?

Thanks.

-- 
Dmitry
